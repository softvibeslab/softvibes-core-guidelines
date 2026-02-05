# Coding Guidelines - SoftvibesLab

Mejores prácticas y convenciones de código para todos los proyectos.

## Tipos de Proyectos

- Frontend (React/Next.js/TypeScript)
- Backend (Node.js/Python/TypeScript)
- Mobile (React Native/Expo/TypeScript)
- n8n Workflows (JSON)
- Docker/DevOps

---

## React/Next.js Guidelines

### Component Structure

```typescript
interface UserProfileProps {
  user: User;
  onUpdate: (user: User) => void;
}

export const UserProfile: React.FC<UserProfileProps> = ({
  user,
  onUpdate,
}) => {
  // Hooks al inicio
  const [loading, setLoading] = useState(false);
  
  // Event handlers
  const handleUpdate = (updatedUser: User) => {
    onUpdate(updatedUser);
  };
  
  // Render
  return (
    <div className="user-profile">
      <h1>{user.name}</h1>
      <button onClick={() => handleUpdate(user)}>
        Edit Profile
      </button>
    </div>
  );
};
```

### Hooks Personalizados

```typescript
// hooks/useAuth.ts
export const useAuth = () => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  
  useEffect(() => {
    // Fetch user
  }, []);
  
  return { user, loading, isAuthenticated: !!user };
};
```

### API Calls en Hooks

```typescript
export const useUserProfile = (userId: string) => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  
  useEffect(() => {
    fetchUserProfile(userId)
      .then(setUser)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [userId]);
  
  return { user, loading, error, refetch: () => fetchUserProfile(userId) };
};
```

---

## TypeScript Guidelines

### Type Definitions

```typescript
// types/user.ts
export interface User {
  id: string;
  nombre: string;
  apellido_paterno: string;
  email: string;
  empresa?: string;
  created_at: string;
  updated_at: string;
}

export type UserRole = 'admin' | 'user' | 'guest';
```

### Generics

```typescript
// types/api.ts
export interface ApiResponse<T> {
  data: T;
  status: boolean;
  message?: string;
}

export const fetchData = async <T>(
  url: string
): Promise<ApiResponse<T>> => {
  const response = await fetch(url);
  return response.json();
};
```

---

## Node.js/Backend Guidelines

### Service Layer Pattern

```typescript
// services/userService.ts
export class UserService {
  async findAll(): Promise<User[]> {
    return this.userRepository.findAll();
  }
  
  async findById(id: string): Promise<User> {
    const user = await this.userRepository.findById(id);
    if (!user) {
      throw new Error('User not found');
    }
    return user;
  }
  
  async create(dto: CreateUserDto): Promise<User> {
    const user = await this.userRepository.create(dto);
    // Emitir evento
    this.eventEmitter.emit('user.created', user);
    return user;
  }
}
```

### Middleware

```typescript
// middleware/auth.ts
export const authMiddleware = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) {
      return res.status(401).json({ error: 'No token provided' });
    }
    
    const decoded = verifyJWT(token);
    req.user = decoded;
    next();
  } catch (error) {
    return res.status(401).json({ error: 'Invalid token' });
  }
};
```

---

## Testing Guidelines

### Unit Tests

```typescript
// user.service.test.ts
describe('UserService', () => {
  let service: UserService;
  let mockRepo: jest.Mocked<UserRepository>;
  
  beforeEach(() => {
    mockRepo = createMockUserRepository();
    service = new UserService(mockRepo);
  });
  
  describe('findAll', () => {
    it('should return all users', async () => {
      const expectedUsers = [{ id: '1', name: 'Test' }];
      mockRepo.findAll.mockResolvedValue(expectedUsers);
      
      const result = await service.findAll();
      
      expect(result).toEqual(expectedUsers);
      expect(mockRepo.findAll).toHaveBeenCalled();
    });
  });
});
```

---

## Docker Guidelines

### Dockerfile

```dockerfile
# Multi-stage build
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM node:20-alpine AS runner

WORKDIR /app

ENV NODE_ENV production

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY package*.json ./

EXPOSE 3000

CMD ["node", "dist/main.js"]
```

### docker-compose.yml

```yaml
version: '3.8'

services:
  api:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - DATABASE_URL=postgresql://db:5432/app
    depends_on:
      - db
      - redis
  
  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_USER: app
      POSTGRES_PASSWORD: secret
      POSTGRES_DB: app
    volumes:
      - postgres_data:/var/lib/postgresql/data
  
  redis:
    image: redis:7-alpine
    volumes:
      - redis_data:/data

volumes:
  postgres_data:
  redis_data:
```

---

## n8n Workflow Guidelines

### Estructura de Workflow JSON

```json
{
  "name": "Workflow Nombre",
  "nodes": [
    {
      "name": "Webhook",
      "type": "n8n-nodes-base.webhook",
      "position": [250, 300],
      "parameters": {}
    },
    {
      "name": "HTTP Request",
      "type": "n8n-nodes-base.httpRequest",
      "position": [450, 300],
      "parameters": {
        "url": "https://api.example.com/endpoint",
        "method": "POST",
        "headers": {
          "Content-Type": "application/json"
        }
      }
    }
  ],
  "connections": [
    {
      "source": 0,
      "target": 1
    }
  ]
}
```

---

## Comentarios

### Cuándo Comentar

SI:
- Algoritmos complejos
- Lógica de negocio no evidente
- Trabajos temporales (TODO, FIXME)
- Explicar POR QUÉ no se puede hacer de otra forma

NO:
- Código obvio (user.name = 'Juan')
- Código duplicado (DRY es mejor)
- Código comentado en vez de refactorizar

---

## Git Ignore

```gitignore
# Dependencies
node_modules/
package-lock.json

# Environment
.env
.env.local
.env.*.local

# Build
dist/
build/
.next/

# IDE
.vscode/
.idea/

# OS
.DS_Store
Thumbs.db

# Logs
*.log
logs/
```

---

Generado con OpenClaw
