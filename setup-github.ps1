# ================================================================
#  setup-github.ps1 — Create GitHub repo & push portfolio code
#  Run: .\setup-github.ps1
# ================================================================

Write-Host "`n🧠 Abid Hussain Portfolio — GitHub Setup" -ForegroundColor Magenta
Write-Host "=========================================`n" -ForegroundColor Magenta

# ── 1. Get token securely ──────────────────────────────────────
$secureToken = Read-Host "Paste your GitHub Personal Access Token (repo scope)" -AsSecureString
$BSTR  = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureToken)
$TOKEN = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

if ([string]::IsNullOrWhiteSpace($TOKEN)) {
    Write-Host "❌ No token provided. Exiting." -ForegroundColor Red
    exit 1
}

# ── 2. Create repo on GitHub ───────────────────────────────────
Write-Host "`n📦 Creating GitHub repository 'portfolio'..." -ForegroundColor Cyan

$body = @{
    name        = "portfolio"
    description = "Abid Hussain — AI & ML Engineer Portfolio | Next.js + TypeScript + Tailwind"
    private     = $false
    auto_init   = $false
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod `
        -Uri    "https://api.github.com/user/repos" `
        -Method POST `
        -Headers @{
            Authorization = "token $TOKEN"
            "User-Agent"  = "portfolio-setup"
            Accept        = "application/vnd.github.v3+json"
        } `
        -Body        $body `
        -ContentType "application/json"

    Write-Host "✅ Repository created: $($response.html_url)" -ForegroundColor Green
    $cloneUrl = $response.clone_url
} catch {
    $msg = $_.ErrorDetails.Message | ConvertFrom-Json -ErrorAction SilentlyContinue
    if ($msg.errors -and $msg.errors[0].message -like "*already exists*") {
        Write-Host "ℹ️  Repository already exists — using existing repo." -ForegroundColor Yellow
        $cloneUrl = "https://github.com/abid785/portfolio.git"
    } else {
        Write-Host "❌ Failed to create repo: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host $_.ErrorDetails.Message -ForegroundColor Red
        exit 1
    }
}

# ── 3. Configure git remote ────────────────────────────────────
Write-Host "`n🔗 Setting git remote origin..." -ForegroundColor Cyan

# Embed token in URL for passwordless push
$authUrl = $cloneUrl -replace "https://", "https://abid785:${TOKEN}@"

$existing = git remote get-url origin 2>$null
if ($existing) {
    git remote set-url origin $authUrl
} else {
    git remote add origin $authUrl
}

# Rename branch to main
git branch -M main

# ── 4. Push code ───────────────────────────────────────────────
Write-Host "`n🚀 Pushing code to GitHub..." -ForegroundColor Cyan
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✅ Successfully pushed to GitHub!" -ForegroundColor Green
    Write-Host "   → https://github.com/abid785/portfolio`n" -ForegroundColor Cyan

    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Magenta
    Write-Host "  NEXT STEP: Deploy on Netlify" -ForegroundColor White
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "  1. Go to https://app.netlify.com/teams/abid7gh/projects" -ForegroundColor Yellow
    Write-Host "  2. Click 'Add new site' → 'Import an existing project'" -ForegroundColor Yellow
    Write-Host "  3. Click 'GitHub' → authorize Netlify" -ForegroundColor Yellow
    Write-Host "  4. Search & select: abid785/portfolio" -ForegroundColor Yellow
    Write-Host "  5. Netlify reads netlify.toml automatically:" -ForegroundColor Yellow
    Write-Host "       Base dir:  client" -ForegroundColor Cyan
    Write-Host "       Build cmd: npm install && npm run build" -ForegroundColor Cyan
    Write-Host "       Publish:   .next" -ForegroundColor Cyan
    Write-Host "  6. Click 'Deploy site' — Done! 🎉" -ForegroundColor Yellow
    Write-Host ""
} else {
    Write-Host "`n❌ Push failed. Check your token has 'repo' scope." -ForegroundColor Red
}

# Cleanup token from memory
$TOKEN = $null
$BSTR  = [System.IntPtr]::Zero
