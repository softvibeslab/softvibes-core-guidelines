# Git Workflow - SoftvibesLab

Flujo de trabajo Git y mejores prácticas de control de versiones.

## Estrategia de Ramas

### Ramas Principales

```
main (production)
├── develop (desarrollo)
│   ├── feature/* (nuevas funcionalidades)
│   ├── bugfix/* (correcciones de bugs)
│   ├── hotfix/* (correcciones urgentes)
│   └── release/* (preparación de releases)
```

### Convención de Nombres

- **main**: Rama principal de producción
- **develop**: Rama de desarrollo
- **feature/nombre**: Nueva funcionalidad
- **bugfix/nombre**: Corrección de bug
- **hotfix/nombre**: Corrección urgente
- **release/x.y.z**: Preparación de versión

---

## Convención de Commits

### Formato

```
<tipo>(<alcance>): <asunto>

[opcional: cuerpo]
```

### Tipos (Types)

- **feat**: Nueva funcionalidad
- **fix**: Corrección de bug
- **docs**: Cambios en documentación
- **style**: Formato, espacios, punto y coma
- **refactor**: Refactorización de código
- **perf**: Mejoras de rendimiento
- **test**: Agregar o actualizar tests
- **chore**: Cambios en build, configuración, etc.
- **ci**: Cambios en CI/CD

### Alcance (Scope)

Opcional: especifica módulo o área afectada

```
feat(auth): add OAuth2 login
fix(api): handle null response
docs(readme): update installation guide
```

### Ejemplos

```
feat(auth): implementar login con JWT
fix(api): resolver error de timeout en endpoints de usuarios
refactor(user): simplificar lógica de actualización de perfil
docs(api): actualizar documentación de endpoints
test(users): agregar tests para registro
style(components): formatear componentes de React
perf(dashboard): optimizar renderizado de gráficos
chore(deps): actualizar lodash a v4.35.0
ci(github): configurar GitHub Actions
```

---

## Flujo de Trabajo

### 1. Nueva Funcionalidad

```bash
# Crear rama desde develop
git checkout develop
git pull origin develop
git checkout -b feature/nombre-de-la-funcionalidad

# Hacer cambios
git add .
git commit -m "feat(scope): descripcion breve"

# Push y crear PR
git push origin feature/nombre-de-la-funcionalidad
```

### 2. Corrección de Bug

```bash
# Crear rama desde develop
git checkout develop
git pull origin develop
git checkout -b bugfix/descripcion-del-bug

# Hacer cambios
git add .
git commit -m "fix(scope): descripcion breve"

# Push y crear PR
git push origin bugfix/descripcion-del-bug
```

### 3. Hotfix Urgente

```bash
# Crear rama desde main (no desde develop)
git checkout main
git pull origin main
git checkout -b hotfix/descripcion-urgente

# Hacer cambios
git add .
git commit -m "fix: descripcion critica urgente"

# Push y crear PR a main y develop
git push origin hotfix/descripcion-urgente
```

### 4. Merge y Release

```bash
# Desde develop, mergear a main
git checkout main
git merge develop
git tag -a v1.2.3 -m "Version 1.2.3"
git push origin main --tags

# Mergear hotfix a develop
git checkout develop
git merge hotfix/descripcion-urgente
git push origin develop
```

---

## Pull Request Guidelines

### Requisitos del PR

1. **Título descriptivo**: Debe seguir la convención de commits
2. **Descripción detallada**: Explicar cambios y por qué
3. **Tests incluidos**: Todos los nuevos features deben tener tests
4. **CI checks deben pasar**: Sin errores
5. **Code review**: Mínimo 1 aprobación requerida
6. **Sin conflictos**: Debe mergear limpiamente

### Plantilla de PR

```markdown
## Tipo
- [ ] feat
- [ ] fix
- [ ] docs
- [ ] style
- [ ] refactor
- [ ] perf
- [ ] test
- [ ] chore
- [ ] ci

## Descripción
Explicar brevemente los cambios realizados.

## Cambios
- Lista de cambios principales
- Issue relacionado (si aplica)

## Tests
- [ ] Tests unitarios agregados
- [ ] Tests de integración actualizados
- [ ] Todos los tests pasan

## Checklist
- [ ] Mi código sigue las directrices de estilo
- [ ] He realizado auto-review de mi código
- [ ] He comentado código complejo
- [ ] He actualizado la documentación
- [ ] No hay console.log ni código comentado
```

---

## Rebase vs Merge

### Usar Rebase

**Cuándo:** Para mantener historial limpio
- Antes de hacer push a una rama larga
- Para incorporar cambios recientes de develop

```bash
git fetch origin
git rebase origin/develop
```

### Usar Merge

**Cuándo:** Para mantener historial de branches
- Cuando trabajes en equipo pequeño
- Para PRs de hotfixes

```bash
git merge origin/develop
```

---

## Tags y Versionado

### Semantic Versioning (SemVer)

Formato: `MAJOR.MINOR.PATCH`

- **MAJOR**: Cambios incompatibles backwards
- **MINOR**: Nuevas funcionalidades compatibles backwards
- **PATCH**: Correcciones de bugs compatibles backwards

### Ejemplos

```
v1.0.0 -> v1.0.1 (patch: bugfix)
v1.0.1 -> v1.1.0 (minor: nueva feature)
v1.1.0 -> v2.0.0 (major: cambios incompatibles)
```

---

## Git Aliases Útiles

```bash
# Ver historial de commits de forma gráfica
git alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Creset'--abbrev-commit'"

# Ver últimos commits
git alias.last "log -1 HEAD --stat"

# Cancelar commits recientes
git alias.undo "reset --soft HEAD~1"

# Ver archivos modificados
git alias.modified "status --short"

# Ver branches recientes
git alias.recent "branch -v --sort=-committerdate"
```

---

## Changelog Automático

### Configurar commitlint y conventional-changelog

```json
{
  "preset": "angular",
  "writerOpts": {
    "commitHardBreak": false
  },
  "types": [
    {"type": "feat", "section": "Features"},
    {"type": "fix", "section": "Bug Fixes"},
    {"type": "chore", "section": "Chore", "hidden": true}
  ]
}
```

---

## Solución de Conflictos

### Estrategia

1. **Pull最新的**: `git pull --rebase origin develop`
2. **Resolver conflictos**: Editar archivos y resolver marcadores `<<<<<<`, `======`, `>>>>>>`
3. **Marcar como resueltos**: `git add <archivo>`
4. **Continuar rebase**: `git rebase --continue`
5. **Forzar push** (si es necesario): `git push --force-with-lease`

---

## Buenas Práticas

### Nunca Commitear

1. **Archivos compilados**: `node_modules/`, `dist/`, `build/`
2. **Archivos de configuración sensible**: `.env`, `.env.local`
3. **Secretos**: API keys, passwords, tokens
4. **Dependencias**: `package-lock.json`, `yarn.lock`

### Siempre Commitear

1. **Documentación**: README.md, docs/
2. **Archivos de configuración no sensibles**: `.gitignore`, `.editorconfig`
3. **Changelog**: CHANGELOG.md

### Commits Atómicos

Cada commit debe hacer UNA sola cosa:

```
✅ BIEN: feat(auth): agregar login con Google
✅ BIEN: fix(api): resolver error de timeout
✅ BIEN: docs(readme): actualizar guía de instalación

❌ MAL: feat(auth): agregar login, arreglar bugs, actualizar docs
```

---

## Revisión de Historial

### Ver Gráficamente

```bash
git log --graph --decorate --oneline
```

### Ver Estadísticas

```bash
git shortlog -sn
git log --stat --summary
```

### Buscar en Historial

```bash
# Por commit message
git log --grep="login" --oneline

# Por autor
git log --author="roger" --oneline

# Por fecha
git log --since="2026-01-01" --until="2026-01-31"
```

---

## Recursos

- [Git Handbook](https://git-scm.com/book/en/v2)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)
- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [A Successful Git Branching Model](https://nvie.com/posts/a-successful-git-branching-model/)

---

**Generado con ❤️ por SoftvibesLab**
