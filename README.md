# LoyaltySDK – Integración para iOS

[![iOS 13+](https://img.shields.io/badge/iOS-13%2B-blue)](https://developer.apple.com/ios/)
[![Versión](https://img.shields.io/badge/Version-1.0.0-brightgreen)]()
[![Licencia](https://img.shields.io/badge/License-MIT-green)]()

---

## 📌 Visión General

**LoyaltySDK** es un SDK modular en formato `XCFramework`. Este repositorio incluye:

- ✅ SDK precompilado (`LoyaltySDK.xcframework`)
- ✅ Proyecto de ejemplo (`DemoApp/UIKIt-Storyboard`)
- ✅ Documentación completa de integración


## 🚀 Requisitos Técnicos

- Xcode 12 o superior
- iOS 15.6 o superior
- Swift 6+


## 📦 Instalación del SDK

### 1. Obtener el SDK

- Descargar el archivo `LoyaltySDK.xcframework.zip` desde la carpeta SDK
- Descomprimir el archivo `LoyaltySDK.xcframework.zip`
- Abra su proyecto Xcode
- Arrastre `LoyaltySDK.xcframework` a la sección Project Navigator
- Asegúrese de marcar Copy items if needed
- Seleccione su target principal
- Vaya a Target → General → Frameworks, Libraries, and `Embedded Content`
- Verifique que aparezca `LoyaltySDK.xcframework`
- En la columna Embed, seleccione `Embed & Sign`


## 🛠 Configuración Inicial

### 1. Importar el SDK (por ejemplo, en AppDelegate.swift)


```swift
import LoyaltySDK
```


### 2. Configurar el SDK (por ejemplo, en AppDelegate.swift)

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    ILoyalty.configure(
        appKey: "test_FJiceIdJtRJbyiwkDa+vxG+xpfVwoLg8q4EhfCDZPF4=",
        environment: .development, // Opcional: .development o .production (default: .production)
        debug: true // Opcional: Habilita logs (default: false)
    ) { result in
        switch result {
        case .success:
            print("SDK configurado correctamente")
        case .failure(let error):
            print("Error en ILoyaltySDK: \(error.localizedDescription)")
        }
    }
    
    return true
}
```
### ℹ️ Este paso debe ejecutarse una sola vez al inicio de la app.

### 3. Mostrar la Vista del SDK (Ejemplo en un UIViewController)

```swift
Task { @MainActor in
    if let sdkVC = await ILoyalty.shared.showViewController(
        tokenSAML: "token_saml_de_usuario",    // Requerido: Autenticación del usuario
        section: "loyalty",                    // Sección a mostrar
        idSection: "hy6",                      // ID de la sección
        typeView: 1                            // Tamaño de la vista (1 = 80%, 2 = 100%)
    ) {
        // Configurar delegado para eventos del SDK
        sdkVC.eventDelegate = self
        
        // Integrar la vista del SDK en el ViewController actual
        self.sdkViewController = sdkVC
        self.addChild(sdkVC)
        sdkVC.view.frame = self.view.bounds
        sdkVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(sdkVC.view)
        sdkVC.didMove(toParent: self)
    } else {
        print("Error: No se pudo crear LoyaltyViewController")
    }
}
```

### 4. Manejo de Eventos Genéricos desde el SDK
Para recibir eventos genéricos enviados desde el SDK, implementar el método delegado `didReceiveEvent(name:payload:)` en tu UIViewController.

```swift
func didReceiveEvent(name: String, payload: [String : Any]) {
        print("Evento recibido: \(name), datos: \(payload)")
}
```

## 🔍 Ejemplo de Uso
La aplicación de referencia ubicada en `DemoApp/UIKIt-Storyboard` muestra cómo:

- Configurar el SDK

- Usar el controlador LoyaltyViewController embebido en un UITabBarController

- Usar delegados para detectar eventos o errores

## ▶️ Ejecutar la demo

- Abrir DemoApp/TestApp/TestApp.xcodeproj

- Seleccionar un simulador o dispositivo físico

- Ejecutar (Cmd + R) y navegar entre las pestañas

## ❗ Solución de Problemas
### Error
    No such module 'LoyaltySDK'
### Solución

    Verifique que el XCFramework esté agregado en “Frameworks, Libraries...”
### Error
    Framework not embedded	
### Solución
    En la columna Embed seleccione “Embed & Sign”
### Error
    El SDK no responde o no se inicializa
### Solución
    Verifique que el appKey sea válido y que haya conexión a internet

## 📬 Soporte Técnico
Si tiene preguntas o necesita ayuda:

📧 Email: soporte@ideeolabs.mx

----------
## 📄 Notas
- Este SDK es compatible con futuras versiones de Swift y Xcode gracias al uso de:

    BUILD_LIBRARY_FOR_DISTRIBUTION=YES.

- Consulte el archivo CHANGELOG.md para conocer las novedades por versión.

## 📄 Licencia

Los archivos en este repositorio están bajo licencia propietaria de Ideeolabs.

© 2025 Ideeolabs. Todos los derechos reservados.