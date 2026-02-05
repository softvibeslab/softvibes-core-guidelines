# Deployment Guidelines - SoftvibesLab

Guía completa de despliegue para todos los proyectos de SoftvibesLab.

## Estrategia de Despliegue

### Entornos

```
development -> staging -> production
```

- **Development**: Local (localhost)
- **Staging**: Pruebas (staging.softvibeslab.com)
- **Production**: Producción (softvibeslab.com)

---

## Frontend Deployment (React/Next.js)

### 1. Vercel (Recomendado para Next.js)

**Setup Inicial:**
```bash
npm install -g vercel
vercel login
```

**Despliegue:**
```bash
vercel --prod
```

**Configuración vercel.json:**
```json
{
  "buildCommand": "npm run build",
  "devCommand": "npm run dev",
  "installCommand": "npm install",
  "framework": "nextjs",
  "regions": ["iad1"],
  "env": {
    "DATABASE_URL": "@database_url",
    "API_BASE_URL": "@api_base_url"
  }
}
```

**Ambientes:**
```bash
# Desplegar a staging
vercel --env NEXT_PUBLIC_API_URL=https://staging-api.softvibeslab.com

# Desplegar a production
vercel --prod
```

### 2. Netlify (Para sitios estáticos o SPAs)

**Setup:**
```bash
npm install -g netlify-cli
netlify login
```

**Despliegue:**
```bash
netlify deploy --prod
```

**Configuración netlify.toml:**
```toml
[build]
  command = "npm run build"
  publish = "dist"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200

[build.environment]
  NODE_VERSION = "20"
```

---

## Backend Deployment (Node.js/Express)

### 1. AWS EC2 + Nginx

**Prerequisitos:**
- AWS Account con EC2 acceso
- Instancia Ubuntu 22.04 LTS
- Dominio configurado

**Script de despliegue:**
```bash
#!/bin/bash
# deploy.sh

# Actualizar servidor
apt update && apt upgrade -y

# Instalar Node.js 20
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
apt install -y nodejs

# Instalar PM2
npm install -g pm2

# Clonar repositorio
git clone https://github.com/softvibeslab/your-project.git
cd your-project

# Instalar dependencias
npm ci --only=production

# Configurar PM2
pm2 start npm start --name "softvibes-api"
pm2 save
pm2 startup

# Instalar Nginx
apt install -y nginx

# Configurar Nginx reverse proxy
cat > /etc/nginx/sites-available/softvibeslab << 'NGINX'
server {
    listen 80;
    server_name api.softvibeslab.com;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
NGINX

ln -s /etc/nginx/sites-available/softvibeslab /etc/nginx/sites-enabled/
nginx -t
systemctl reload nginx
```

### 2. Railway (Recomendado para Node.js)

**Despliegue automático:**
```bash
npm install -g @railway/cli
railway login
railway up
```

**Configuración railway.json:**
```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "NIXPACKS",
    "buildCommand": "npm run build",
    "watchPatterns": ["src/**", "tests/**"]
  },
  "deploy": {
    "startCommand": "npm start",
    "healthcheckPath": "/health"
  }
}
```

---

## Mobile Deployment (React Native/Expo)

### 1. EAS Build (Expo Application Services)

**Setup:**
```bash
npm install -g eas-cli
eas login
```

**Crear build de Android (APK):**
```bash
eas build --platform android --profile production
```

**Crear build de iOS (IPA):**
```bash
eas build --platform ios --profile production
```

**Configuración eas.json:**
```json
{
  "cli": {
    "version": ">= 13.0.0"
  },
  "build": {
    "development": {
      "developmentClient": true,
      "distribution": "internal"
    },
    "preview": {
      "distribution": "internal"
    },
    "production": {
      "android": {
        "buildType": "apk"
      },
      "ios": {
        "autoIncrement": true
      }
    }
  }
}
```

### 2. Submit a Stores

**Google Play:**
```bash
eas submit --platform android --latest
```

**Apple App Store:**
```bash
eas submit --platform ios --latest
```

---

## Docker Deployment

### 1. Dockerfile Multi-Stage

```dockerfile
# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

RUN npm run build

# Stage 2: Production
FROM node:20-alpine AS runner

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules

ENV NODE_ENV=production

EXPOSE 3000

CMD ["node", "dist/main.js"]
```

### 2. docker-compose.yml

```yaml
version: "3.8"

services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - DATABASE_URL=postgresql://db:5432/app
    depends_on:
      - db
      - redis
    restart: unless-stopped

  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_USER: app
      POSTGRES_PASSWORD: secret
      POSTGRES_DB: app
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: unless-stopped

  redis:
    image: redis:7-alpine
    volumes:
      - redis_data:/data
    restart: unless-stopped

volumes:
  postgres_data:
  redis_data:
```

**Ejecutar con Docker Compose:**
```bash
docker-compose up -d --build
```

---

## CI/CD Pipeline

### GitHub Actions Workflow

```yaml
name: Deploy to Production

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run tests
        run: npm test
      
      - name: Build
        run: npm run build
      
      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v20
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          working-directory: ./
```

---

## Rollback Strategy

### 1. Blue-Green Deployment

```bash
# Deploy new version
vercel deploy --prod --prebuilt

# If successful, keep green. If failed, rollback to blue
```

### 2. Database Migrations

```bash
# Run migrations before deployment
npm run migrate:latest

# If migration fails, rollback database
npm run migrate:rollback
```

### 3. Feature Flags

```typescript
const FEATURE_NEW_DASHBOARD = process.env.FEATURE_NEW_DASHBOARD === 'true';

if (FEATURE_NEW_DASHBOARD) {
  // Show new dashboard
} else {
  // Show old dashboard
}
```

---

## Monitoring & Observability

### 1. Application Performance Monitoring (APM)

**New Relic:**
```typescript
import * as newrelic from 'newrelic';
newrelic.start();

// Track custom metrics
newrelic.recordMetric('user.login', 1);
```

**Sentry:**
```typescript
import * as Sentry from "@sentry/react";

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  tracesSampleRate: 1.0,
  environment: process.env.NODE_ENV
});
```

### 2. Uptime Monitoring

**UptimeRobot:**
- Monitorear endpoints críticos
- Configurar alertas por email/Slack
- Historial de uptime (99.9% objetivo)

---

## Security in Production

### 1. HTTPS Always

```nginx
server {
    listen 443 ssl http2;
    server_name api.softvibeslab.com;
    
    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;
    
    # HSTS
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
}
```

### 2. Rate Limiting

```typescript
import rateLimit from 'express-rate-limit';

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // limit each IP to 100 requests per windowMs
});

app.use('/api', limiter);
```

### 3. CORS Configuration

```typescript
app.use(cors({
  origin: ['https://softvibeslab.com'],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE']
}));
```

---

## Backup Strategy

### 1. Database Backups

Automatizar backups diarios:

```bash
# Crontab para backups
0 2 * * * pg_dump -U app app > /backups/db_$(date +\%Y\%m\%d).sql
```

### 2. Code Backups

- Git history como backup de código
- Releases y tags como puntos de restauración
- GitHub Actions para backups automatizados

---

**Generado con OpenClaw**
