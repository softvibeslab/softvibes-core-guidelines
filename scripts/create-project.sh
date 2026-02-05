#!/bin/bash

# Script de creación de proyectos para SoftvibesLab
# Uso: ./create-project.sh <tipo> <nombre>

PROJECT_TYPE=\$1
PROJECT_NAME=\$2

if [ -z "\$PROJECT_TYPE" ] || [ -z "\$PROJECT_NAME" ]; then
  echo "Uso: ./create-project.sh <tipo> <nombre>"
  echo ""
  echo "Tipos disponibles:"
  echo "  nextjs       - Next.js App"
  echo "  node-api      - Node.js API"
  echo "  mobile        - React Native Expo"
  echo "  n8n           - n8n Workflow"
  exit 1
fi

echo "🎯 Creando proyecto: \$PROJECT_NAME"
echo "📁 Tipo: \$PROJECT_TYPE"

case "\$PROJECT_TYPE" in
  nextjs)
    echo "📦 Creando Next.js app..."
    npx create-next-app@latest --typescript --tailwind --eslint "\$PROJECT_NAME"
    cd "\$PROJECT_NAME"
    echo "✅ Next.js creado"
    ;;
    
  node-api)
    echo "📦 Creando Node.js API..."
    mkdir "\$PROJECT_NAME"
    cd "\$PROJECT_NAME"
    npm init -y
    npm install express typescript @types/express @types/node tsx prisma @prisma/client
    echo "✅ Node.js API creado"
    ;;
    
  mobile)
    echo "📦 Creando React Native Expo app..."
    npx create-expo-app@latest --template blank-typescript "\$PROJECT_NAME"
    cd "\$PROJECT_NAME"
    echo "✅ React Native creado"
    ;;
    
  n8n)
    echo "📦 Creando n8n workflow..."
    mkdir "\$PROJECT_NAME"
    cd "\$PROJECT_NAME"
    npm init -y
    echo "✅ n8n workflow creado"
    ;;
    
  *)
    echo "❌ Tipo de proyecto desconocido: \$PROJECT_TYPE"
    exit 1
    ;;
esac

echo ""
echo "🚀 Proyecto \$PROJECT_NAME creado exitosamente!"
echo ""
echo "Próximos pasos:"
echo "1. cd \$PROJECT_NAME"
echo "2. Configurar variables de entorno (.env)"
echo "3. Leer directrices en: https://github.com/softvibeslab/softvibes-core-guidelines"
echo "4. Iniciar desarrollo"
