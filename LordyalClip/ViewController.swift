//
//  ViewController.swift
//  LordyalClip
//
//  Created by Vu Doan on 4/17/23.
//

import UIKit
import StoreKit

class ViewController: UIViewController, SKOverlayDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            
    }

    @IBAction func downloadFullVersionPressed(_ sender: Any) {
        guard let scene = view.window?.windowScene else { return }
        let config = SKOverlay.AppClipConfiguration(position: .bottom)
        let overlay = SKOverlay(configuration: config)
        overlay.delegate = self
        overlay.present(in: scene)
    }

}

