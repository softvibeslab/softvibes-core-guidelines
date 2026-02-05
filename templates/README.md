# Project Templates - SoftvibesLab

Templates de proyectos iniciales para arrancar rapidamente con directrices de core ya aplicadas.

## Templates Disponibles

### 1. React-Next.js-Template
Plantilla de frontend con Next.js 14, React 18, TypeScript, Tailwind CSS.

**Características:**
- App Router
- API Routes
- Server Components
- TypeScript strict mode
- ESLint + Prettier
- Jest + React Testing Library
- Tailwind CSS configurado
- Autenticación con JWT
- Protección de rutas

**Iniciar:**
```bash
npx create-next-app@latest --typescript --tailwind --eslint mi-app
cd mi-app
npm install
npm run dev
```

### 2. Node-API-Template
Plantilla de backend API con Node.js 20, TypeScript, Express, PostgreSQL.

**Características:**
- Express con TypeScript
- Prisma ORM
- PostgreSQL
- JWT Autenticación
- Role-based Access Control (RBAC)
- Winston Logging
- Jest + Supertest
- API RESTful
- Docker configurado
- CORS habilitado

**Iniciar:**
```bash
git clone https://github.com/softvibeslab/node-api-template
cd node-api-template
npm install
npm run dev
```

### 3. React-Native-Expo-Template
Plantilla de mobile app con Expo 50, React Native, TypeScript.

**Características:**
- Expo Router
- React Native Paper UI
- TypeScript strict mode
- Autenticación con Expo SecureStore
- API calls con fetch
- AsyncStorage local
- React Native Reanimated
- Expo Notifications
- EAS Build configurado

**Iniciar:**
```bash
npx create-expo-app@latest --template blank-typescript
cd mi-app
npx expo install @react-navigation/native @react-navigation/stack
npm run dev
```

### 4. n8n-Workflow-Template
Plantilla de workflows automatizados con n8n.

**Características:**
- Webhooks de entrada y salida
- Agentes de IA (OpenAI, Claude)
- Integración con Notion
- Integración con Supabase
- Transformación de datos
- Manejo de errores
- Retry configurable

**Iniciar:**
```bash
npm install -g n8n
n8n start
# Importar workflow JSON desde templates/
```

---

## Estructura de Templates

Todos los templates siguen esta estructura:

```
template/
├── src/                 # Código fuente
├── tests/               # Tests (Jest, Vitest)
├── docs/                # Documentación
├── scripts/             # Scripts de utilidad
├── .vscode/             # Configuración VS Code
├── .eslintrc.js        # Configuración ESLint
├── .prettierrc         # Configuración Prettier
├── tsconfig.json         # Configuración TypeScript
├── package.json          # Dependencias
├── Dockerfile            # Docker (si aplica)
└── README.md             # Documentación
```

---

## Scripts Disponibles

### Crear Nuevo Proyecto desde Template

```bash
# Usar template Next.js
npx create-next-app@latest --typescript --tailwind --eslint mi-app

# Usar template Node.js
npm init -y
npm install express typescript @types/express @types/node prisma @prisma/client

# Usar template React Native
npx create-expo-app@latest --template blank-typescript mi-app

# Usar n8n workflow
# Ir a n8n dashboard -> Import from File
```

---

## Configuración VS Code

### Extensions Recomendadas

```json
{
  "recommendations": [
    "esbenp.prettier-vscode",
    "dbaeumer.vscode-eslint",
    "editorconfig.editorconfig",
    "christian-kohler.path-intellisense",
    "streetsidesoftware.code-spell-checker",
    "eamodio.gitlens",
    "ms-vsliveshare.vsliveshare",
    "bradlc.vscode-tailwindcss",
    "formulahendry.auto-rename-tag",
    "christian-kohler.npm-intellisense",
    "christian-kohler.path-intellisense"
  ]
}
```

### Settings

```json
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": "explicit"
  },
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "typescript.tsdk": "node_modules/typescript/lib"
}
```

---

## Configuración Pre-commit

### Husky + Lint-staged

```bash
npm install --save-dev husky lint-staged
npx husky init
npx husky add .husky/pre-commit "npx lint-staged"
```

### package.json scripts

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "lint:fix": "next lint --fix",
    "format": "prettier --write .",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage"
  }
}
```

---

## Scripts de Utilidad

### create-project.sh

Script para crear nuevo proyecto con todas las configuraciones:

```bash
#!/bin/bash

PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: ./create-project.sh <project-name>"
  exit 1
fi

# Crear proyecto con Next.js
npx create-next-app@latest --typescript --tailwind --eslint $PROJECT_NAME

# Entrar al proyecto
cd $PROJECT_NAME

# Instalar dependencias adicionales
npm install axios @tanstack/react-query zustand date-fns

# Instalar dev dependencies
npm install --save-dev @types/node husky lint-staged prettier

# Configurar Husky
npx husky init
npx husky add .husky/pre-commit "npx lint-staged"

echo "Project $PROJECT_NAME created successfully!"
echo "cd $PROJECT_NAME && npm run dev"
```

---

## Recursos de Aprendizaje

### Next.js
- [Next.js Documentation](https://nextjs.org/docs)
- [Next.js Learn Course](https://nextjs.org/learn)

### React Native
- [React Native Documentation](https://reactnative.dev/docs/getting-started)
- [Expo Documentation](https://docs.expo.dev/)

### n8n
- [n8n Documentation](https://docs.n8n.io/)
- [n8n Integrations](https://docs.n8n.io/integrations/)

---

**¡Listo para crear proyectos rápidamente con todas las mejores prácticas!**
