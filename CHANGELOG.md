# Historial de Versiones

## [1.1.0] - 25-07-2025
### Added
- Soporte para Swift 6 y iOS 15.6+ como nuevos requisitos mínimos.
- Parámetros opcionales en `ILoyalty.configure`: 
  - `environment` (.development/.production)
  - `debug` (modo logs)
- Método delegado `didReceiveEvent(name:payload:)` para eventos genéricos desde el SDK.
- Documentación ampliada en README con:
  - Configuración de entornos
  - Manejo de eventos
  - Ejemplos de implementación

### Changed
- Renombrado de `Loyalty` a `ILoyalty` en todos los métodos del SDK.
- Mejoras en el sistema de logs (solo activo con `debug: true`).

### Fixed
- Optimización de arquitecturas en XCFramework .

## [1.0.0] - 09-07-2025
### Added
- Versión inicial del XCFramework
- Proyecto demo de implementación