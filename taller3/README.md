# Colombia API - Datos Abiertos de Colombia

App Flutter que consume la API de Datos Abiertos de Colombia (api-colombia.com) para展示 información sobre departamentos, presidente, áreas naturales y atracciones turísticas del país.

## Descripción de la API

La API de Datos Abiertos de Colombia (api-colombia.com) proporciona acceso a información estructurada sobre el territorio, historia y cultura colombiana. Esta app consume los siguientes 4 endpoints:

### Endpoints Utilizados

| Endpoint | Descripción |
|---------|-------------|
| `/Department` | Información de los 32 departamentos de Colombia (población, superficie, región) |
| `/President` | Historia de los presidentes de Colombia con período de mandato |
| `/NaturalArea` | Parques nacionales y áreas naturales protegidas |
| `/TouristicAttraction` | Atracciones turísticas con coordenadas y descripción |

## Rutas de la App

| Path | Nombre | Descripción |
|------|--------|-------------|
| `/` | dashboard | Pantalla principal con tarjetas de navegación |
| `/departments` | departmentList | Listado de departamentos |
| `/departments/:id` | departmentDetail | Detalle de un departamento |
| `/presidents` | presidentList | Listado de presidentes |
| `/presidents/:id` | presidentDetail | Detalle de un presidente |
| `/natural-areas` | naturalAreaList | Listado de áreas naturales |
| `/natural-areas/:id` | naturalAreaDetail | Detalle de un área natural |
| `/touristic` | touristicList | Listado de atracciones turísticas |
| `/touristic/:id` | touristicDetail | Detalle de una atracción |

## Estructura del Proyecto

```
lib/
├── config/
│   └── app_config.dart        # Configuración con flutter_dotenv
├── models/
│   ├── department.dart      # Modelo de departamento
│   ├── president.dart    # Modelo de presidente
│   ├── natural_area.dart # Modelo de área natural
│   └── touristic_attraction.dart # Modelo de atracción
├── services/
│   ├── department_service.dart
│   ├── president_service.dart
│   ├── natural_area_service.dart
│   └── touristic_attraction_service.dart
├── routes/
│   └── app_router.dart   # Configuración de go_router
├── themes/
│   └── app_theme.dart  # Tema oscuro personalizado
├── views/
│   ├── dashboard/
│   ├── department/
│   ├── president/
│   ├── natural_area/
│   └── touristic_attraction/
├── widgets/
│   ├── state_widget.dart      # Loading/Error/Success
│   ├── dashboard_card.dart   # Card para dashboard
│   └── list_item_card.dart # Card para listados
└── main.dart
```

## Ejemplo de JSON

### Department
```json
{
  "id": 1,
  "name": "Cundinamarca",
  "description": "Departamento de Cundinamarca",
  "population": 2568752,
  "surface": 24098,
  "regionId": 3
}
```

### President
```json
{
  "id": 1,
  "name": "Gustavo",
  "lastName": "Petro",
  "startPeriodDate": "2022-08-07",
  "endPeriodDate": "",
  "description": "Presidente de Colombia",
  "image": "url"
}
```

### NaturalArea
```json
{
  "id": 1,
  "name": "Parque Nacional Natural Tayrona",
  "description": "Área natural protegida",
  "areaType": "Parque Nacional"
}
```

### TouristicAttraction
```json
{
  "id": 1,
  "name": "Ciudad Perdida",
  "description": "Sitio arqueológico",
  "latitude": 11.0333,
  "longitude": -73.9833,
  "cityId": 1
}
```

## Paquetes Utilizados

| Paquete | Versión | Descripción |
|--------|--------|-----------|
| `http` | ^1.2.1 | Cliente HTTP para consumo de APIs |
| `go_router` | ^14.2.0 | Navegación declarativa |
| `flutter_dotenv` | ^5.1.0 | Carga de variables de entorno |

## Instrucciones de Ejecución

```bash
# 1. Instalar dependencias
flutter pub get

# 2. Crear archivo .env (ya included en assets)
# BASE_URL=https://api-colombia.com/api/v1

# 3. Ejecutar la app
flutter run
```

## Características

- Tema oscuro profesional con acentos en violeta, cian y rosa
- Estados de carga, error y éxito reutilizables
- Navegación con go_router
- Diseño responsivo con GridView
- SliverAppBar con gradientes en vistas de detalle

## Requisitos

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0