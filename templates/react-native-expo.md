# React Native Expo Template

Plantilla de mobile app con Expo 50, React Native, TypeScript.

## Iniciar

\`\`\`bash
npx create-expo-app@latest --template blank-typescript
npx expo install @react-navigation/native @react-navigation/stack @react-navigation/native-stack expo-linking expo-secure-store expo-splash-screen
\`\`\`

## Dependencias

\`\`\`json
{
  "dependencies": {
    "expo": "~50.0.0",
    "react": "18.2.0",
    "react-native": "0.73.0",
    "@react-navigation/native": "^6.1.0",
    "@react-navigation/stack": "^6.3.0",
    "expo-linking": "^6.3.0",
    "expo-secure-store": "^12.8.0",
    "expo-splash-screen": "^0.27.0"
  }
}
\`\`\`

## Scripts

\`\`\`json
{
  "scripts": {
    "start": "expo start",
    "android": "expo start --android",
    "ios": "expo start --ios",
    "web": "expo start --web",
    "test": "jest",
    "lint": "eslint ."
  }
}
\`\`\`

## Estructura

\`\`\`
app/
├── (tabs)/           # Bottom Tabs
├── _layout.tsx       # Root Layout
├── _sitemap.tsx      # Sitemap
├── screens/          # React Native Screens
└── components/       # Reusable Components
\`\`\`

---

Generado con OpenClaw
