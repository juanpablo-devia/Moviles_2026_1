# Moviles_2026_1

Repositorio de la asignatura Desarrollo de Aplicaciones Móviles — UCEVA 2026-1.  
**Autor:** Juan Pablo Devia Massó

---

## Estructura del repositorio

| Carpeta | Descripción |
|---|---|
| `taller1_flutter/` | StatefulWidget, imágenes, ListView y GridView |
| `taller2/` | App base con color dinámico, usada para distribución |

---

## Taller — Firebase App Distribution

### Objetivo

Distribuir y probar un APK de la app Flutter usando Firebase App Distribution, siguiendo buenas prácticas de versionado y GitFlow.

---

### Flujo completo

```
Generar APK → Firebase App Distribution → Testers → Instalación → Actualización
```

**1. Generar APK release**

```bash
cd taller2
flutter clean
flutter pub get
flutter build apk --release
```

El APK queda en: `build/app/outputs/flutter-apk/app-release.apk`

**2. Configurar Firebase**

- Crear proyecto en [Firebase Console](https://console.firebase.google.com)
- Registrar la app Android con el `applicationId`: `com.example.taller2`
- Descargar `google-services.json` y colocarlo en `taller2/android/app/`
- Agregar el plugin `com.google.gms.google-services` en `settings.gradle.kts` y `app/build.gradle.kts`

**3. App Distribution**

- Ir a App Distribution en Firebase Console
- Crear grupo de testers: `QA_Clase`
- Agregar tester: `dduran@uceva.edu.co`
- Subir el APK y asignarlo al grupo con Release Notes descriptivas
- Distribuir y copiar el enlace de instalación

**4. Actualización incremental**

Cambiar la versión en `pubspec.yaml`:

```yaml
# Versión inicial
version: 1.0.0+1

# Versión actualizada
version: 1.0.1+2
```

Rebuildar el APK y subir la nueva versión a App Distribution con Release Notes actualizadas.

---

### Sección Publicación — Cómo replicar el proceso

1. Clonar el repositorio y posicionarse en la rama `feature/app_distribution`
2. Verificar que `google-services.json` esté en `taller2/android/app/`
3. Ejecutar los comandos de build descritos arriba
4. Acceder a Firebase Console con la cuenta del proyecto `Moviles2026`
5. Subir el APK generado al grupo `QA_Clase`
6. Para distribuir una nueva versión: incrementar `versionName` y `versionCode` en `pubspec.yaml`, rebuildar y subir

---

### Versionado

Se usa el formato estándar de Flutter:

```
version: MAJOR.MINOR.PATCH+BUILD
```

| Campo | Descripción |
|---|---|
| `MAJOR.MINOR.PATCH` | `versionName` visible en App Distribution |
| `BUILD` | `versionCode` interno de Android (debe incrementarse siempre) |

**Historial de versiones:**

| Versión | Fecha | Cambios |
|---|---|---|
| 1.0.0+1 | 04/05/2026 | Primera distribución vía Firebase App Distribution |
| 1.0.1+2 | 04/05/2026 | Actualización de color primario: violeta → verde neón |

---

### Formato de Release Notes

```
Versión X.X.X - [Título del cambio]
Fecha: DD/MM/AAAA
Responsable: [Nombre]
Cambios: [Descripción clara de qué cambió]
```

---

### GitFlow aplicado

```
feature/app_distribution → dev (PR #6)
dev → main (PR #7)
```

---

### Enlace de distribución

[Firebase App Distribution — Taller2](https://appdistribution.firebase.google.com/testerapps/1:121268131873:android:d1af26e558ddc5a15fab60/releases/7mjj9k9qfkf90?utm_source=firebase-console)
