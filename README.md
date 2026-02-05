# Directrices Principales de Core - SoftvibesLab

Guía completa de mejores prácticas, arquitectura y patrones para todos los proyectos de SoftvibesLab.

## Tabla de Contenido

1. [Arquitectura General](#arquitectura-general)
2. [Estructura de Proyecto](#estructura-de-proyecto)
3. [Principios de Código](#principios-de-código)
4. [Git Workflow](#git-workflow)
5. [Testing](#testing)
6. [Despliegue](#despliegue)
7. [Documentación](#documentación)
8. [Configuración](#configuración)
9. [Monitoreo](#monitoreo)
10. [Seguridad](#seguridad)

---

## Arquitectura General

### Estándar de Arquitectura

- Separación de Preocupaciones (SoC)
- Repository Pattern para datos
- Dependency Injection

---

## Estructura de Proyecto

### Carpetas Principales

- src/ - Código fuente principal
- tests/ - Todos los tests
- docs/ - Documentación
- scripts/ - Scripts de automatización

---

## Principios de Código

### DRY (Don't Repeat Yourself)
Escribe código reutilizable.

### KISS (Keep It Simple, Stupid)
Código simple y directo.

### SOLID Principles
- Single Responsibility
- Open/Closed
- Liskov Substitution
- Interface Segregation
- Dependency Inversion

---

## Git Workflow

### Convención de Commits

Usar formato: tipo(scope): descripción

Tipos:
- feat: nueva funcionalidad
- fix: corrección de bug
- docs: cambios en documentación
- style: formato
- refactor: refactorización
- test: tests
- chore: build, configs

---

## Testing

### Tipos de Tests

1. Unit Tests - pruebas aisladas
2. Integration Tests - pruebas entre módulos
3. E2E Tests - pruebas extremo a extremo

---

## Despliegue

### Estrategia de Deployment

1. Development - Entorno local
2. Staging - Pruebas en entorno de pruebas
3. Production - Entorno de producción

---

## Documentación

### Requisitos

- README.md obligatorio
- API.md para endpoints
- Diagramas de arquitectura

---

## Configuración

### Variables de Entorno

Usar archivos .env y NUNCA commitear .env.local.

---

## Monitoreo

### Logging

- Usar niveles: debug, info, warn, error
- No logear información sensible

---

## Seguridad

### OWASP Top 10

1. Injection
2. Broken Authentication
3. XSS
4. Insecure Direct Object References
5. Security Misconfiguration
6. Sensitive Data Exposure
7. Missing Function Level Access Control
8. CSRF
9. Using Components with Known Vulnerabilities
10. Insufficient Logging & Monitoring

---

## Herramientas

### Linting

- ESLint
- Prettier

### Testing

- Jest
- Supertest
- Playwright

### CI/CD

- GitHub Actions

---

## Changelog

### v1.0.0 (2026-02-05)
- Directrices iniciales creadas
- Definición de arquitectura estándar

---

## Contribuidores

- Roger García Vital (SoftvibesLab)

---

Generado con OpenClaw
