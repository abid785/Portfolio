# Abid Hussain — AI & ML Engineer Portfolio

<div align="center">
  <h1>🧠 Abid Hussain</h1>
  <h3>AI & Machine Learning Engineer</h3>
  
  [![Live Demo](https://img.shields.io/badge/Live-Demo-8b5cf6?style=for-the-badge&logo=netlify)](https://abid-hussain-portfolio.netlify.app)
  [![GitHub](https://img.shields.io/badge/GitHub-abid785-00d4ff?style=for-the-badge&logo=github)](https://github.com/abid785)
  [![LinkedIn](https://img.shields.io/badge/LinkedIn-Abid_Hussain-4f46e5?style=for-the-badge&logo=linkedin)](https://www.linkedin.com/in/abid-hussain-2a01b0360/)
</div>

---

## ✨ Features

- **Neural Universe Theme** — dark UI with neon purples, cyans & indigos (color-psychology driven)
- **Animated Particle Background** — interactive neural network canvas
- **Framer Motion animations** — smooth entrance animations on every section
- **Type animation** — multi-role typewriter in the hero
- **Scroll progress bar** — gradient neon indicator
- **Contact form** — validates & sends via Next.js API routes (+ Express backend)
- **Fully responsive** — mobile-first design

## 🖥 Tech Stack

| Layer | Technologies |
|-------|-------------|
| Frontend | Next.js 14, TypeScript, Tailwind CSS, Framer Motion |
| Animation | react-type-animation, react-intersection-observer, react-countup |
| Icons | react-icons (Font Awesome + Simple Icons) |
| Forms | react-hook-form, react-hot-toast |
| Backend | Express.js, Nodemailer, Helmet, Rate Limiting |
| Deploy | Netlify (frontend), Docker (optional self-host) |

## 🚀 Quick Start

```bash
# Clone
git clone https://github.com/abid785/portfolio.git
cd portfolio

# Install dependencies
npm run install:all

# Start dev servers (both client + server)
npm run dev
```

- Frontend: http://localhost:3000  
- Backend API: http://localhost:5000

## 📦 Project Structure

```
portfolio/
├── client/                  # Next.js 14 frontend
│   ├── src/
│   │   ├── app/             # App Router (layout, page, API routes)
│   │   ├── components/      # Hero, About, Skills, Projects...
│   │   └── data/            # portfolio.ts  (all content here)
│   └── package.json
├── server/                  # Express.js backend
│   ├── src/index.js         # API server with contact endpoint
│   └── .env.example
├── netlify.toml             # Netlify deploy config
├── docker-compose.yml       # Full-stack Docker setup
└── package.json             # Root scripts
```

## 🌐 Deploy to Netlify

1. Push this repo to GitHub  
2. Go to [app.netlify.com](https://app.netlify.com) → **Add new site** → **Import from Git**  
3. Select this repo  
4. Netlify auto-detects settings from `netlify.toml`:
   - Base directory: `client`
   - Build command: `npm install && npm run build`
   - Publish directory: `.next`

## 📧 Contact

**Abid Hussain** — [abid7gh@gmail.com](mailto:abid7gh@gmail.com)  
GitHub: [@abid785](https://github.com/abid785) · LinkedIn: [abid-hussain](https://www.linkedin.com/in/abid-hussain-2a01b0360/)
