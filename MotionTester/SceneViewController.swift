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
    
    var transformTimer: TimeInterval = 0
    
    let motionManager: MyMotion = MyMotion()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initScene()
        initCamera()
        initLabels()
        createObject()
        
        motionManager.getAttitudeAsync(interval: 0.1) { (attitude) in
            let q: CMQuaternion = attitude.quaternion

            DispatchQueue.main.async {
                self.cameraNode.orientation = SCNQuaternion.init(q.x, q.y, q.z, q.w)
                
            }
        }
    }
    
    func initView(){
        gameView = SCNView()
        view = gameView
        gameView.allowsCameraControl = true
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
        cameraNode.position = SCNVector3.init(0, 0, 5)
    }
    
    func createObject(){
        let obj: SCNGeometry = SCNBox()
        (obj as! SCNBox).height = 4
        (obj as! SCNBox).width = 2
        (obj as! SCNBox).length = 0.2
        
        obj.materials.first?.diffuse.contents = UIColor.yellow
        objNode = SCNNode(geometry: obj)
        
        gameScene.rootNode.addChildNode(objNode)
        gameScene.rootNode.position.z -= 2
    }
    
    func initLabels(){
        view.addSubview(Roll)
        view.addSubview(Pitch)
        view.addSubview(Yaw)
        view.addSubview(RollVal)
        view.addSubview(PitchVal)
        view.addSubview(YawVal)
        
        addConstraintString(str: "H:|-5-[v0][v1(55)]-5-[v2][v3(55)]-5-[v4][v5(55)]", views: ["v0": Roll, "v1": RollVal, "v2": Pitch, "v3": PitchVal, "v4": Yaw, "v5": YawVal])
        addConstraintString(str: "V:[v0]-2-|", views: ["v0":Roll])
        addConstraintString(str: "V:[v0]-2-|", views: ["v0":RollVal])
        addConstraintString(str: "V:[v0]-2-|", views: ["v0":Pitch])
        addConstraintString(str: "V:[v0]-2-|", views: ["v0":PitchVal])
        addConstraintString(str: "V:[v0]-2-|", views: ["v0":Yaw])
        addConstraintString(str: "V:[v0]-2-|", views: ["v0":YawVal])
    }
    
    //    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
    //        if time > transformTimer{
    //            objNode.eulerAngles.x += Float(5 * M_PI / 180)
    //            objNode.eulerAngles.y += Float(5 * M_PI / 180)
    //            objNode.eulerAngles.z += Float(5 * M_PI / 180)
    //            transformTimer = time + 0.1
    //        }
    //    }
    
    
    //    override var shouldAutorotate: Bool {
    //        return false
    //    }
    
    
    let Roll: UILabel = {
        let view = UILabel()
        view.text = "Roll:  "
        view.font = view.font.withSize(16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let Pitch: UILabel = {
        let view = UILabel()
        view.text = "Pitch:  "
        view.font = view.font.withSize(16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let Yaw: UILabel = {
        let view = UILabel()
        view.text = "Yaw:  "
        view.font = view.font.withSize(16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let RollVal: UILabel = {
        let view = UILabel()
        view.text = "--"
        view.font = view.font.withSize(16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let PitchVal: UILabel = {
        let view = UILabel()
        view.text = "--"
        view.font = view.font.withSize(16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let YawVal: UILabel = {
        let view = UILabel()
        view.text = "--"
        view.font = view.font.withSize(16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func addConstraintString(str: String, views: [String: UIView]){
        self.view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: str,
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: views)
        )
        
    }
    
    
    
    
    
}
