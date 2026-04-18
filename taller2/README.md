# Taller de Procesamiento en Segundo Plano - Flutter

Este proyecto demuestra el uso de conceptos avanzados de procesamiento en segundo plano en Flutter, incluyendo `Future`, `async/await`, `Timer` e `Isolate`.

## Funcionalidades Implementadas

### 1. Asincronía con Future / async / await
- Servicio simulado que usa `Future.delayed` para retrasos de 2-3 segundos.
- Manejo de estados: Cargando, Éxito, Error.
- Relanzar consulta con botón.
- Prints en consola para evidenciar orden de ejecución.

### 2. Cronómetro con Timer
- Cronómetro que actualiza cada segundo usando `Timer.periodic`.
- Botones: Iniciar, Pausar, Reanudar, Reiniciar.
- Limpieza del Timer en `dispose()` y al pausar.
- Formato de tiempo HH:MM:SS.

### 3. Isolate para tarea pesada
- Tarea CPU-bound: suma de números del 1 al 100,000,000.
- Ejecución en isolate separado usando `Isolate.spawn`.
- Estados: Procesando, Resultado final.
- Prints desde isolate y hilo principal para demostrar separación.

## Estructura del Proyecto

```
lib/
├── main.dart
├── screens/
│   ├── home_screen.dart
│   ├── async_screen.dart
│   ├── timer_screen.dart
│   └── isolate_screen.dart
└── services/
    └── simulated_data_service.dart
```

## Diagrama de Pantallas

```
HomeScreen
├── Asincronía con Future
│   ├── Cargando...
│   ├── Éxito / Error
│   └── Botón Relanzar
├── Cronómetro con Timer
│   ├── 00:00:00
│   └── Botones: Iniciar/Pausar/Reanudar/Reiniciar
└── Isolate para Tarea Pesada
    ├── Procesando...
    └── Resultado
```

## Cuándo Usar Cada Concepto

- **Future / async / await**: Para operaciones I/O asíncronas como llamadas a API, lecturas de archivos, o cualquier tarea que no bloquee el hilo principal. Permite mantener la UI responsiva.

- **Timer**: Para tareas repetitivas o temporizadas, como cronómetros, contadores regresivos, o actualizaciones periódicas de UI.

- **Isolate**: Para tareas CPU-intensivas que podrían bloquear la UI. Los isolates corren en hilos separados, permitiendo paralelismo real.

## Instrucciones para Correr el Proyecto

1. Asegúrate de tener Flutter instalado y configurado.
2. Navega al directorio del proyecto: `cd taller2`
3. Instala dependencias: `flutter pub get`
4. Corre la app: `flutter run`

## Rama de Trabajo

Este taller se desarrolla en la rama `feature/taller_segundo_plano`, creada desde `dev`. Al finalizar, se hará un PR a `dev` y merge a `main`.
