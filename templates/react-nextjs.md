# React Next.js Template

Plantilla de frontend con Next.js 14, React 18, TypeScript, Tailwind CSS.

## Iniciar

\`\`\`bash
npx create-next-app@latest --typescript --tailwind --eslint mi-app
cd mi-app
npm install
\`\`\`

## Dependencias

\`\`\`json
{
  "dependencies": {
    "next": "^14.1.0",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "@tanstack/react-query": "^5.20.0",
    "axios": "^1.6.5",
    "zustand": "^4.4.0"
  }
}
\`\`\`

## Scripts

\`\`\`json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "format": "prettier --write .",
    "test": "jest"
  }
}
\`\`\`

## Estructura

\`\`\`
src/
├── app/              # App Router
├── components/      # React Components
├── lib/             # Utils
├── hooks/           # Custom Hooks
├── types/           # TypeScript Types
└── styles/          # Global Styles
\`\`\`

---

Generado con OpenClaw
