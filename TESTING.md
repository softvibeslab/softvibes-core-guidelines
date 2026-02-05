# Testing Guidelines - SoftvibesLab

Guía completa de testing para todos los proyectos de SoftvibesLab.

## Tipos de Tests

### 1. Unit Tests
Prueban unidades de código aisladas (funciones, componentes, servicios).

### 2. Integration Tests
Prueban cómo interactúan múltiples módulos entre sí.

### 3. E2E (End-to-End) Tests
Prueban flujos completos del usuario de extremo a extremo.

### 4. Component Tests
Prueban componentes React en aislamiento.

---

## Estrategia de Testing

### Piramide de Testing

```
     E2E Tests (10%)
         /    \
          /      \
     /          \
  /______________\
  Integration Tests (20%)
   /                \
  /                  \
 /____________________\
 Unit Tests (70%)
```

- Unit Tests: 70% - Rápidos, baratos
- Integration Tests: 20% - Medium
- E2E Tests: 10% - Lentos, costosos

---

## Frontend Testing (React/Next.js)

### Component Tests

Usar React Testing Library:

```typescript
import { render, screen } from '@testing-library/react';
import UserProfile from './UserProfile';

describe('UserProfile', () => {
  it('should render user name', () => {
    const mockUser = { nombre: 'Juan', apellido: 'Garcia' };
    render(<UserProfile user={mockUser} />);
    
    expect(screen.getByText('Juan Garcia')).toBeInTheDocument();
  });

  it('should call onUpdate when edit button is clicked', () => {
    const mockUser = { nombre: 'Juan', apellido: 'Garcia' };
    const mockOnUpdate = jest.fn();
    
    render(<UserProfile user={mockUser} onUpdate={mockOnUpdate} />);
    
    const editButton = screen.getByText('Editar');
    editButton.click();
    
    expect(mockOnUpdate).toHaveBeenCalledWith(mockUser);
  });
});
```

### Hooks Tests

```typescript
import { renderHook, act } from '@testing-library/react';
import { useUserProfile } from './useUserProfile';

describe('useUserProfile', () => {
  it('should fetch user data on mount', async () => {
    const mockUserId = '123';
    const mockUser = { id: '123', nombre: 'Juan' };
    
    (fetch as jest.fn).mockResolvedValueOnce({
      json: async () => mockUser
    } as any);
    
    const { result } = renderHook(() => useUserProfile(mockUserId));
    
    await act(async () => {
      await result.current.refetch();
    });
    
    expect(result.current.user).toEqual(mockUser);
  });
});
```

---

## Backend Testing (Node.js/Express)

### Controller Tests

```typescript
import request from 'supertest';
import { app } from '../app';
import { UserService } from '../services/user.service';

jest.mock('../services/user.service');

describe('UserController', () => {
  let mockUserService: jest.Mocked<UserService>;

  beforeEach(() => {
    mockUserService = new UserService() as any;
  });

  describe('GET /users/:id', () => {
    it('should return user by id', async () => {
      const mockUser = { id: '123', nombre: 'Juan' };
      mockUserService.findById.mockResolvedValue(mockUser);
      
      const response = await request(app)
        .get('/users/123')
        .expect(200);
      
      expect(response.body).toEqual(mockUser);
      expect(mockUserService.findById).toHaveBeenCalledWith('123');
    });

    it('should return 404 if user not found', async () => {
      mockUserService.findById.mockResolvedValue(null);
      
      const response = await request(app)
        .get('/users/999')
        .expect(404);
      
      expect(response.body).toHaveProperty('error');
    });
  });
});
```

### Service Tests

```typescript
import { UserService } from './user.service';
import { UserRepository } from './user.repository';

jest.mock('./user.repository');

describe('UserService', () => {
  let userService: UserService;
  let mockRepo: jest.Mocked<UserRepository>;

  beforeEach(() => {
    mockRepo = new UserRepository() as any;
    userService = new UserService(mockRepo);
  });

  describe('create', () => {
    it('should create user with encrypted password', async () => {
      const userData = {
        nombre: 'Juan',
        email: 'juan@test.com',
        password: 'plainpassword'
      };
      
      const mockUser = { id: '123', ...userData, password: 'encrypted' };
      mockRepo.create.mockResolvedValue(mockUser);
      
      // Mock bcrypt
      const bcrypt = require('bcrypt');
      bcrypt.hash = jest.fn().mockResolvedValue('encrypted');
      
      const result = await userService.create(userData);
      
      expect(result).toEqual(mockUser);
      expect(mockRepo.create).toHaveBeenCalledWith(
        expect.objectContaining({ password: 'encrypted' })
      );
    });
  });
});
```

---

## E2E Testing (Playwright)

### Setup de Playwright

```typescript
import { test, expect } from '@playwright/test';

test.describe('E2E - User Registration', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('http://localhost:3000/register');
  });

  test('should register new user successfully', async ({ page }) => {
    // Fill registration form
    await page.fill('input[name="nombre"]', 'Juan');
    await page.fill('input[name="apellido"]', 'Garcia');
    await page.fill('input[name="email"]', 'juan@test.com');
    await page.fill('input[name="password"]', 'Password123!');
    await page.fill('input[name="confirmPassword"]', 'Password123!');
    
    // Submit form
    await page.click('button[type="submit"]');
    
    // Verify success
    await expect(page.locator('.success-message')).toBeVisible();
    await expect(page).toHaveURL(/\/dashboard/);
  });

  test('should show error for invalid email', async ({ page }) => {
    await page.fill('input[name="email"]', 'invalid-email');
    await page.fill('input[name="password"]', 'Password123!');
    
    await page.click('button[type="submit"]');
    
    await expect(page.locator('.error-message')).toBeVisible();
    await expect(page.locator('.error-message')).toHaveText(
      'Email inválido'
    );
  });
});
```

---

## Mobile Testing (React Native/Expo)

### Component Tests

```typescript
import { render } from '@testing-library/react-native';
import UserList from './UserList';

describe('UserList', () => {
  it('should render list of users', () => {
    const users = [
      { id: '1', nombre: 'Juan' },
      { id: '2', nombre: 'Maria' }
    ];
    
    const { getByText } = render(<UserList users={users} />);
    
    expect(getByText('Juan')).toBeTruthy();
    expect(getByText('Maria')).toBeTruthy();
  });

  it('should call onUserPress when user is pressed', () => {
    const users = [{ id: '1', nombre: 'Juan' }];
    const mockOnPress = jest.fn();
    
    const { getByText } = render(
      <UserList users={users} onUserPress={mockOnPress} />
    );
    
    fireEvent.press(getByText('Juan'));
    
    expect(mockOnPress).toHaveBeenCalledWith(users[0]);
  });
});
```

---

## n8n Workflow Testing

### Workflow Tests

```typescript
import { Workflow } from 'n8n-core';
import { WorkflowRunner } from './workflow-runner';

describe('Workflow Runner', () => {
  it('should execute complete workflow', async () => {
    const workflow: Workflow = {
      name: 'Test Workflow',
      nodes: [
        { id: '1', type: 'webhook' },
        { id: '2', type: 'httpRequest' }
      ],
      connections: [
        { source: 1, target: 2 }
      ]
    };
    
    const runner = new WorkflowRunner();
    const result = await runner.execute(workflow, {
      webhookData: { test: 'data' }
    });
    
    expect(result.status).toBe('success');
    expect(result.data).toBeDefined();
  });

  it('should handle errors gracefully', async () => {
    const workflow: Workflow = {
      name: 'Failing Workflow',
      nodes: [
        { id: '1', type: 'httpRequest' }
      ],
      connections: []
    };
    
    const runner = new WorkflowRunner();
    const result = await runner.execute(workflow);
    
    expect(result.status).toBe('error');
    expect(result.error).toBeDefined();
  });
});
```

---

## Configuración de Jest

### jest.config.js

```javascript
module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  roots: ['<rootDir>/src'],
  testMatch: ['**/__tests__/**/*.ts?(x)', '**/?(*.)+(spec|test).ts?(x)'],
  collectCoverageFrom: [
    'src/**/*.{js,jsx,ts,tsx}',
    '!src/**/*.d.ts',
    '!src/**/*.stories.tsx',
    '!src/main.tsx'
  ],
  coverageThreshold: {
    global: {
      branches: 70,
      functions: 80,
      lines: 70,
      statements: 70
    }
  },
  moduleNameMapper: {
    '^@/(.*)$': '<rootDir>/src/$1'
  },
  setupFilesAfterEnv: ['<rootDir>/src/setupTests.ts']
};
```

---

## Mocking

### Mock de API

```typescript
// __mocks__/api.ts
export const mockUserAPI = {
  getUsers: jest.fn(() => Promise.resolve([
    { id: '1', nombre: 'Juan' },
    { id: '2', nombre: 'Maria' }
  ])),
  getUserById: jest.fn((id) => 
    Promise.resolve({ id, nombre: 'Test User' })
  ),
  createUser: jest.fn((user) => 
    Promise.resolve({ ...user, id: 'new-id' })
  )
};
```

---

## Buenas Prácticas

### 1. AAA Pattern

- **Arrange**: Configurar el test
- **Act**: Ejecutar la acción
- **Assert**: Verificar el resultado

### 2. Tests Independientes

Cada test debe poder ejecutarse de forma aislada.

### 3. Tests Predecibles

Siempre mismo input = siempre mismo output.

### 4. Tests Rápidos

Tests unitarios deben ejecutarse en menos de 100ms.

### 5. Tests Descriptivos

El nombre del test debe describir qué hace y qué espera.

---

## CI/CD Integration

### GitHub Actions

```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run tests
        run: npm test
      
      - name: Generate coverage
        run: npm run test:coverage
      
      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v3
```

---

**Generado con OpenClaw**
