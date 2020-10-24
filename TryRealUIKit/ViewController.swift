//
//  ViewController.swift
//  TryRealUIKit
//
//  Created by Nanda Putra Perkasa on 02/09/20.
//  Copyright © 2020 Nanda Putra Perkasa. All rights reserved.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overlayCoachingView()
        
        // Load the "Box" scene from the "Experience" Reality File
        let toysAnchor = try! Experience.loadToys()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(toysAnchor)
    }
    
    //AR COaching Overlay View function --> auto detect the plane
    func overlayCoachingView(){
        let coachingView = ARCoachingOverlayView.init(frame: CGRect(x: 0, y: 0, width: arView.frame.width, height: arView.frame.height))
        
        coachingView.session = arView.session
        coachingView.activatesAutomatically = true
        coachingView.goal = .anyPlane
        
        view.addSubview(coachingView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.togglePeopleOcclusion()
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer){
        togglePeopleOcclusion()
    }
    
    fileprivate func togglePeopleOcclusion(){
        guard let config = arView.session.configuration as? ARWorldTrackingConfiguration else {
            fatalError("Doesn't get the configuration")
        }
        
        guard ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) else {
            fatalError("People occlusion can't run on this device")
        }
        
        switch config.frameSemantics {
        case [.personSegmentationWithDepth]:
            config.frameSemantics.remove(.personSegmentationWithDepth)
        default:
            config.frameSemantics.insert(.personSegmentationWithDepth)
        }
        arView.session.run(config)
    }
    
}
