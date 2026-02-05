# Directrices Principales de Core - SoftvibesLab

Guia completa de mejores practicas, arquitectura y patrones para todos los proyectos de SoftvibesLab.

## Contenido

1. Arquitectura General
2. Estructura de Proyecto
3. Principios de Codigo
4. Git Workflow
5. Testing
6. Despliegue
7. Documentacion
8. Configuracion
9. Monitoreo
10. Seguridad

---

## Arquitectura General

### Estandar de Arquitectura

- Separacion de Preocupaciones (SoC)
- Repository Pattern para datos
- Dependency Injection

---

## Estructura de Proyecto

### Carpetas Principales

- src/ - Codigo fuente principal
- tests/ - Todos los tests
- docs/ - Documentacion
- scripts/ - Scripts de automatizacion

---

## Principios de Codigo

### DRY (Don't Repeat Yourself)
Escribe codigo reutilizable.

### KISS (Keep It Simple, Stupid)
Codigo simple y directo.

### SOLID Principles
- Single Responsibility
- Open/Closed
- Liskov Substitution
- Interface Segregation
- Dependency Inversion

---

## Git Workflow

### Convencion de Commits

Usar formato: tipo(scope): descripcion

Tipos:
- feat: nueva funcionalidad
- fix: correccion de bug
- docs: cambios en documentacion
- style: formato
- refactor: refactorizacion
- test: tests
- chore: build, configs

---

## Testing

### Tipos de Tests

1. Unit Tests - pruebas aisladas
2. Integration Tests - pruebas entre modulos
3. E2E Tests - pruebas extremo a extremo

### Cobertura Minima

- Unit: 70%
- Objetivo: 80%
- Critico: 90%

---

## Despliegue

### Entornos

- development - Local
- staging - Pruebas
- production - Produccion

### CI/CD

- Automatizar builds
- Tests automaticos
- Deploy automatico

---

## Documentacion

### Requisitos

- README.md obligatorio
- API.md para endpoints
- Diagramas de arquitectura

---

## Configuracion

### Variables de Entorno

Usar archivos .env y NUNCA commitear .env.local

---

## Monitoreo

### Logging

- Usar niveles: debug, info, warn, error
- No logear informacion sensible

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
- Definicion de arquitectura estandar

---

## Contribuidores

- Roger Garcia Vital (SoftvibesLab)

---

Generado con OpenClaw
