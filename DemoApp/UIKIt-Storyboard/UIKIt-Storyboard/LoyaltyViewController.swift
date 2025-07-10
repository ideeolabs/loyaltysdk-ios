//
//  LoyaltyViewController.swift
//  UIKIt-Storyboard
//
//  Created by Hugo Reza on 08/07/25.
//

import UIKit
import LoyaltySDK

// Controlador de vista para integrar el SDK de Loyalty en un tab de la aplicación.
// Este ViewController embebe la vista del SDK como una vista hijo dentro del tab,
// permitiendo mantener la navegación con tabs sin presentar una vista modal.
class LoyaltyTabViewController: UIViewController, LoyaltyViewDelegate {

    // Instancia del controlador de LoyaltySDK
    private var sdkViewController: LoyaltyViewController?
    
    // Indicador de carga mostrado mientras se carga y configura la vista
    private var loader: UIActivityIndicatorView!
    
    // configuracion el SDK y el loader.
    override func viewDidLoad() {
        super.viewDidLoad()
        embedLoyaltySDK()
        setupLoader()
    }

    // Crear e insertar el controlador del SDK como hijo del controlador actual.
    private func embedLoyaltySDK() {
        // Evita instanciar múltiples veces el SDK
        if sdkViewController != nil { return }

        // Obtener controlador del SDK con el método público del SDK
        guard let sdkVC = ILoyalty.shared.showViewController(
            // Reemplazar con el token del usuario autenticado
            token: "token_abc123"
        ) else {
            print("LoyaltyViewController could not be created")
            return
        }
        
        // Asignar self como delegado para suscribirse a eventos del SDK
        sdkVC.eventDelegate = self

        // Guardar referencia y agregar el controlador como hijo
        sdkViewController = sdkVC
        addChild(sdkVC)
        sdkVC.view.frame = view.bounds
        sdkVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(sdkVC.view)
        sdkVC.didMove(toParent: self)
    }
    
    // Muestra un `UIActivityIndicatorView` centrado mientras se carga el contenido del SDK.
    private func setupLoader() {
        loader = UIActivityIndicatorView(style: .large)
        loader.center = view.center
        loader.color = .blue
        loader.startAnimating()
        view.addSubview(loader)
    }
    
    // MARK: - LoyaltyViewDelegate
    
    // Delegate que indica que la vista del SDK ha terminado de cargar y configurar.
    // Se detiene y oculta el indicador de carga.
    func loyaltyViewDidFinishLoading() {
        print("Loyalty view is fully loaded")
        loader.stopAnimating()
        loader.removeFromSuperview()
    }
}
