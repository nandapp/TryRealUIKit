//
//  ViewController.swift
//  TryRealUIKit
//
//  Created by Nanda Putra Perkasa on 02/09/20.
//  Copyright © 2020 Nanda Putra Perkasa. All rights reserved.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
    }
}
