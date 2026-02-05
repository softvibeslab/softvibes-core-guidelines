# Node API Template

Plantilla de backend API con Node.js 20, TypeScript, Express, PostgreSQL.

## Iniciar

\`\`\`bash
npm init -y
npm install express typescript @types/express @types/node tsx prisma @prisma/client bcrypt jsonwebtoken express-rate-limit cors helmet morgan
\`\`\`

## Dependencias

\`\`\`json
{
  "dependencies": {
    "express": "^4.18.0",
    "typescript": "^5.3.0",
    "prisma": "^5.8.0",
    "@prisma/client": "^5.8.0",
    "bcrypt": "^5.1.0",
    "jsonwebtoken": "^9.0.0",
    "express-rate-limit": "^7.1.0",
    "cors": "^2.8.5",
    "helmet": "^7.1.0",
    "morgan": "^1.10.0"
  }
}
\`\`\`

## Scripts

\`\`\`json
{
  "scripts": {
    "dev": "tsx watch src/index.ts",
    "build": "tsc",
    "start": "node dist/index.js",
    "migrate": "prisma migrate dev",
    "migrate:deploy": "prisma migrate deploy",
    "prisma:studio": "prisma studio"
  }
}
\`\`\`

## Estructura

\`\`\`
src/
├── controllers/      # Request Handlers
├── services/         # Business Logic
├── repositories/     # Data Access
├── middleware/       # Express Middleware
├── types/           # TypeScript Types
├── utils/           # Utilities
└── index.ts         # App Entry
\`\`\`

---

Generado con OpenClaw
