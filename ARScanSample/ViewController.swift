//
//  ViewController.swift
//  ARScanSample
//
//  Created by Company on 2019/05/25.
//  Copyright © 2019 Active User Co.,LTD. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.showsStatistics = true
        //create configuration
        let configuration = ARWorldTrackingConfiguration()
        guard let refObjects = ARReferenceObject.referenceObjects(inGroupNamed: "gallery", bundle: nil) else {
            fatalError("Missing expected assets")
        }
        configuration.detectionObjects = refObjects;
        
        //Run
        sceneView.session.run(configuration)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    //This method is called when object detected
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let objectAnchor = anchor as? ARObjectAnchor {
            //Detected object
            let translation = objectAnchor.transform.columns.3
            let pos = float3(translation.x, translation.y, translation.z)
            let nodeArrow = getArrowNode()
            nodeArrow.position = SCNVector3(pos)
            sceneView.scene.rootNode.addChildNode(nodeArrow)
        }
    }
    
    func getArrowNode() -> SCNNode {
        let sceneUrl = Bundle.main.url(forResource: "arrow_yellow", withExtension: "scn", subdirectory: "art.scnassets")!
        let referenceNode = SCNReferenceNode(url: sceneUrl)!
        referenceNode.load()
        return referenceNode
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
