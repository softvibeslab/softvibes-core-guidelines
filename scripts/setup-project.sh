#!/bin/bash

# Script de setup inicial para proyectos de SoftvibesLab
# Uso: ./setup-project.sh

echo "🚀 Setup Inicial de Proyecto"
echo ""

# Crear estructura de directorios
echo "📁 Creando estructura de directorios..."
mkdir -p src/{components,services,contexts,utils,hooks,types,constants} tests docs scripts config public assets

echo "✅ Estructura creada"
echo ""

# Crear archivos de configuración
echo "⚙️ Creando archivos de configuración..."

# .eslintrc.js
cat > .eslintrc.js << 'ESLINTRC'
module.exports = {
  extends: ["eslint:recommended", "plugin:@typescript-eslint/recommended", "plugin:prettier/recommended"],
  parser: "@typescript-eslint/parser",
  plugins: ["@typescript-eslint", "prettier"],
  rules: {
    "prettier/prettier": "error",
    "@typescript-eslint/no-unused-vars": "warn",
    "no-console": ["warn", { "allow": ["warn", "error"] }]
  }
};
ESLINTRC

# .prettierrc.js
cat > .prettierrc.js << 'PRETTIERRC'
module.exports = {
  semi: true,
  trailingComma: "es5",
  singleQuote: true,
  printWidth: 80,
  tabWidth: 2,
  useTabs: false
};
PRETTIERRC

# tsconfig.json
cat > tsconfig.json << 'TSCONFIG'
{
  "compilerOptions": {
    "target": "ES2020",
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "jsx": "react",
    "module": "commonjs",
    "skipLibCheck": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "outDir": "./dist",
    "rootDir": "./src",
    "baseUrl": "./"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "build"]
}
TSCONFIG

echo "✅ Configuraciones creadas"
echo ""

# Crear archivos .env de ejemplo
echo "🔐 Creando archivos de entorno..."

cat > .env.example << 'ENVEXAMPLE'
# Database
DATABASE_URL=postgresql://localhost:5432/myapp

# API
API_KEY=your_api_key_here
API_SECRET=your_api_secret_here

# JWT
JWT_SECRET=your_jwt_secret_here
JWT_EXPIRES_IN=7d

# App
NODE_ENV=development
PORT=3000

# Features
ENABLE_DEBUG=true
ENABLE_LOGGING=true

# External Services
REDIS_URL=redis://localhost:6379
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your_email@gmail.com
SMTP_PASS=your_password
ENVEXAMPLE

cat > .gitignore << 'GITIGNORE'
# Dependencies
node_modules/
package-lock.json
yarn.lock
pnpm-lock.yaml

# Environment
.env
.env.local
.env.*.local

# Build
dist/
build/
.next/
out/
.turbo/

# Testing
coverage/
.nyc_output/
*.test.js.snap

# IDE
.vscode/
.idea/
*.swp
*.swo
*~
.DS_Store
Thumbs.db

# Logs
logs/
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Misc
.cache/
.parcel-cache/
.vercel/
.netlify/

# OS
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# SoftvibesLab
.openclaw-temp/
.expo-shared/
GITIGNORE

# Scripts de utilidad
cat > scripts/pre-commit.sh << 'PRECOMMIT'
#!/bin/bash

# Pre-commit hook para SoftvibesLab projects

echo "🔍 Running pre-commit checks..."
echo ""

# 1. Lint
echo "📝 Running ESLint..."
npm run lint || {
  echo "❌ ESLint failed"
  exit 1
}

echo "✅ ESLint passed"
echo ""

# 2. Format check
echo "🎨 Checking Prettier formatting..."
npm run format:check || {
  echo "❌ Prettier format check failed"
  echo "💡 Run 'npm run format' to fix"
  exit 1
}

echo "✅ Prettier formatting passed"
echo ""

# 3. Tests
echo "🧪 Running tests..."
npm test || {
  echo "❌ Tests failed"
  exit 1
}

echo "✅ All tests passed"
echo ""

# 4. Type check
echo "📝 Running TypeScript type check..."
npm run type-check || {
  echo "❌ Type check failed"
  exit 1
}

echo "✅ Type check passed"
echo ""

echo "🎉 All pre-commit checks passed!"
PRECOMMIT

chmod +x scripts/pre-commit.sh
echo "✅ Util scripts creados"
echo ""

echo "🚀 Setup inicial completado!"
echo ""
echo "Próximos pasos:"
echo "1. Copiar .env.example a .env"
echo "2. Configurar variables de entorno"
echo "3. Instalar dependencias: npm install"
echo "4. Iniciar desarrollo: npm run dev"
