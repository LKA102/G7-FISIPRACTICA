# 📌 G7 - FISIPRACTICA

FISIPRACTICA es una aplicación móvil desarrollada en **Flutter** con el objetivo de conectar a estudiantes de la FISI con oportunidades de prácticas pre-profesionales. La app cuenta con tres tipos de usuarios: **Administrador, Reclutador y Estudiante**.

## 📂 Estructura del Proyecto

```
FISIPRACTICA/
│-- lib/
│   │-- app/
│   │   │-- screens/       # Contiene las pantallas principales
│   │   │-- widgets/       # Componentes reutilizables
│   │-- main.dart          # Punto de entrada de la aplicación
│-- assets/                # Recursos estáticos (imágenes, logos, etc.)
│-- pubspec.yaml           # Configuración de dependencias de Flutter
```

## 🚀 Instalación y Configuración

1. **Clonar el repositorio**  
   ```bash
   git clone https://github.com/TU_USUARIO/FISIPRACTICA.git
   cd FISIPRACTICA
   ```

2. **Instalar dependencias**  
   Ejecuta el siguiente comando para instalar todas las dependencias del proyecto:  
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación**  
   Para ejecutar la app en un emulador o dispositivo físico:  
   ```bash
   flutter run
   ```
   Si deseas ejecutarlo en **Windows**, usa:  
   ```bash
   flutter run -d windows
   ```

## 📱 Flujo de la Aplicación

1. **Inicio** → El usuario elige su rol en `PickUserScreen`.
2. **Login** → Dependiendo del rol, se muestra `LoginScreen` (Estudiante) o `LoginReclutadorScreen` (Reclutador).
3. **Home** → Después del login, se redirige a `HomeEstudianteScreen` o `HomeReclutadorScreen` según corresponda.


## ✨ Contribuciones

Si deseas contribuir al proyecto, ¡bienvenido! Puedes hacer un **fork**, crear una nueva rama y luego hacer un **pull request**. 🙌
