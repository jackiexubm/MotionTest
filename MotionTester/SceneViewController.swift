//
//  SceneViewController.swift
//  MotionTester
//
//  Created by Jackie Xu on 4/2/17.
//  Copyright © 2017 Jackie Xu. All rights reserved.
//

import UIKit
import SceneKit
import CoreMotion

class SceneViewController: UIViewController, SCNSceneRendererDelegate{
    
    var gameView: SCNView!
    var gameScene: SCNScene!
    var cameraNode: SCNNode!
    
    var objNode: SCNNode!
    var hollowSphere: SCNNode!
    var lightNode: SCNNode!
    
    var transformTimer: TimeInterval = 0
    
    let motionManager: MyMotion = MyMotion()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initScene()
        initCamera()
        //        initLabels()
        createObject()
        
        motionManager.getAttitudeAsync(interval: 0.05) { (attitude) in
            let q: CMQuaternion = attitude.quaternion
            
            DispatchQueue.main.async {
                
                //SCNTransaction.animationDuration = 0.04

                self.cameraNode.orientation = SCNQuaternion.init(q.x, q.y, q.z, q.w)
                
            }
        }
    }
    
    func initView(){
        gameView = SCNView()
        view = gameView
        gameView.backgroundColor = UIColor.black
        gameView.autoenablesDefaultLighting = true
        gameView.delegate = self
    }
    
    func initScene(){
        gameScene = SCNScene()
        gameView.scene = gameScene
        
        gameView.isPlaying = true
    }
    
    func initCamera(){
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        gameScene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3.init(0, 0, 0)
        
        cameraNode.camera?.zNear = 0.3
        cameraNode.camera?.zFar = 2.0
        
   
        cameraNode.camera?.xFov = 0
        cameraNode.camera?.yFov = 90
        
        print(cameraNode.camera?.xFov)
        print(cameraNode.camera?.yFov)
        
    }
    
    func createObject(){
//        let rectangle: SCNGeometry = SCNBox()
//        (rectangle as! SCNBox).height = 4
//        (rectangle as! SCNBox).width = 2
//        (rectangle as! SCNBox).length = 0.2
//        
//        //rectangle.materials.first?.diffuse.contents = UIColor.yellow
//        //objNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "basketball")
//
//        objNode = SCNNode(geometry: rectangle)
//        
//        gameScene.rootNode.addChildNode(objNode)
        
        
        
        
        let importScene = SCNScene.init(named: "collage.dae")
        hollowSphere = importScene!.rootNode.childNodes[0]
        
        
        //hollowSphere = SCNNode(geometry: SCNSphere())
        //hollowSphere.position = SCNVector3.init(0, 0, 2)
        
        
        // the first material is for the surface within the solid of the shell of the hollow sphere
        // hollowSphere.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        // the second material is for the visible surfaces of the solid shell inside and out
        //hollowSphere.geometry?.materials[1].diffuse.contents = UIColor.blue
        
        let mat = hollowSphere.geometry?.materials[0]
        mat?.isDoubleSided = true
        mat?.lightingModel = SCNMaterial.LightingModel.constant
        
        gameScene.rootNode.addChildNode(hollowSphere)

        
        
        
        
        lightNode = SCNNode()
        let light: SCNLight = SCNLight()
        lightNode.light = light
        lightNode.position = SCNVector3.init(0, 0, 0)
        
        //gameScene.rootNode.addChildNode(lightNode)
        print(light.type)
        
        
//        mat?.diffuse.contents = #imageLiteral(resourceName: "rustediron-streaks-albedo")
//        mat?.roughness.contents = #imageLiteral(resourceName: "rustediron-streaks-roughness")
//        mat?.metalness.contents = #imageLiteral(resourceName: "rustediron-streaks-metal")
//        mat?.normal.contents = #imageLiteral(resourceName: "rustediron-streaks-normal")

    }
    
    //    func initLabels(){
    //        view.addSubview(Roll)
    //        view.addSubview(Pitch)
    //        view.addSubview(Yaw)
    //        view.addSubview(RollVal)
    //        view.addSubview(PitchVal)
    //        view.addSubview(YawVal)
    //
    //        addConstraintString(str: "H:|-5-[v0][v1(55)]-5-[v2][v3(55)]-5-[v4][v5(55)]", views: ["v0": Roll, "v1": RollVal, "v2": Pitch, "v3": PitchVal, "v4": Yaw, "v5": YawVal])
    //        addConstraintString(str: "V:[v0]-2-|", views: ["v0":Roll])
    //        addConstraintString(str: "V:[v0]-2-|", views: ["v0":RollVal])
    //        addConstraintString(str: "V:[v0]-2-|", views: ["v0":Pitch])
    //        addConstraintString(str: "V:[v0]-2-|", views: ["v0":PitchVal])
    //        addConstraintString(str: "V:[v0]-2-|", views: ["v0":Yaw])
    //        addConstraintString(str: "V:[v0]-2-|", views: ["v0":YawVal])
    //    }
    
//        func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
//            if time > transformTimer{
//                lightNode.position.z -= 0.02
//                cameraNode.position.z -= 0.02
//                //hollowSphere.eulerAngles.x += Float(3 * M_PI / 180)
//                //hollowSphere.position.z += 0.05
////                objNode.eulerAngles.y += Float(5 * M_PI / 180)
////                objNode.eulerAngles.z += Float(5 * M_PI / 180)
//                transformTimer = time + 0.1
//            }
//        }
  
    //    override var shouldAutorotate: Bool {
    //        return false
    //    }
    
    
    //    let Roll: UILabel = {
    //        let view = UILabel()
    //        view.text = "Roll:  "
    //        view.font = view.font.withSize(16)
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        return view
    //    }()
    //
    //    let Pitch: UILabel = {
    //        let view = UILabel()
    //        view.text = "Pitch:  "
    //        view.font = view.font.withSize(16)
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        return view
    //    }()
    //
    //    let Yaw: UILabel = {
    //        let view = UILabel()
    //        view.text = "Yaw:  "
    //        view.font = view.font.withSize(16)
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        return view
    //    }()
    //
    //    let RollVal: UILabel = {
    //        let view = UILabel()
    //        view.text = "--"
    //        view.font = view.font.withSize(16)
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        return view
    //    }()
    //
    //    let PitchVal: UILabel = {
    //        let view = UILabel()
    //        view.text = "--"
    //        view.font = view.font.withSize(16)
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        return view
    //    }()
    //
    //    let YawVal: UILabel = {
    //        let view = UILabel()
    //        view.text = "--"
    //        view.font = view.font.withSize(16)
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        return view
    //    }()
    //
    //    func addConstraintString(str: String, views: [String: UIView]){
    //        self.view.addConstraints(NSLayoutConstraint.constraints(
    //            withVisualFormat: str,
    //            options: NSLayoutFormatOptions(),
    //            metrics: nil,
    //            views: views)
    //        )
    //
    //}





}
