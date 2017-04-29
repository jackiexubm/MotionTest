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
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    var gameView: SCNView!
    var gameScene: SCNScene!
    var cameraNode: SCNNode!
    
    var objNode: SCNNode!
    var hollowSphere: SCNNode!
    var lightNode: SCNNode!
    
    var testNode: SCNNode!
    
    var transformTimer: TimeInterval = 0
    weak var walkTimer: Timer?
    weak var heightTimer: Timer?
    
    let motionManager: MyMotion = MyMotion()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initView()
        initScene()
        initCamera()
        initSubviews()
        
        motionManager.getAttitudeAsync(interval: 0.04) { (attitude) in
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
        gameView.autoenablesDefaultLighting = false
        gameView.delegate = self
    }
    
    func initScene(){
        gameScene = SCNScene()
        gameView.scene = gameScene
        
        let importScene: SCNScene = SCNScene.init(named: "shop.dae")!
        
        for node in importScene.rootNode.childNodes {
            
            gameScene.rootNode.addChildNode(node)
            print(node.name ,node.geometry?.firstMaterial?.lightingModel)
            node.geometry?.firstMaterial?.isDoubleSided = true
            
            if node.name!.contains("Wall_2") {
                print(node.name)
                testNode = node
            }

        }
        
        
        gameView.isPlaying = true
    }
    
    func initCamera(){
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        gameScene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3.init(0, 0, 1.4)
        
        cameraNode.camera?.zNear = 0.1
        cameraNode.camera?.zFar = 100
        
        
        //       cameraNode.camera?.xFov = 45
        //        cameraNode.camera?.yFov = 90
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: gameView)
        let hitList = gameView.hitTest(location, options: nil)
        print(hitList.first?.node.name)
        
    }

    

    
//    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
//        if time > transformTimer{
//            //cameraNode.position.y += 0.3
//            testNode.eulerAngles.z += 0.005
//            //                objNode.eulerAngles.z += Float(5 * M_PI / 180)
//            transformTimer = time + 0.1
//        }
//    }
    

    
    
    func addConstraintString(str: String, views: [String: UIView]){
            self.view.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: str,
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views: views)
            )
    
    }
    
    func initSubviews(){
        view.addSubview(walkButtonsImage)
        view.addSubview(heightButtonsImage)
        view.addSubview(upAisleButton)
        view.addSubview(downAisleButton)
        view.addSubview(raiseCameraButton)
        view.addSubview(lowerCameraButton)
        
        addConstraintString(str: "H:|-10-[v0(100)]", views: ["v0": walkButtonsImage])
        addConstraintString(str: "V:|-10-[v0(50)]", views: ["v0": walkButtonsImage])

        addConstraintString(str: "H:|-10-[v0(100)]", views: ["v0": heightButtonsImage])
        addConstraintString(str: "V:[v0(50)]-10-|", views: ["v0": heightButtonsImage])
        
        addConstraintString(str: "H:|[v0(60)][v1(60)]", views: ["v0": downAisleButton, "v1": upAisleButton])
        addConstraintString(str: "V:|[v0(70)]", views: ["v0": upAisleButton])
        addConstraintString(str: "V:|[v0(70)]", views: ["v0": downAisleButton])
        
        addConstraintString(str: "H:|[v0(60)][v1(60)]", views: ["v0": lowerCameraButton, "v1": raiseCameraButton])
        addConstraintString(str: "V:[v0(70)]|", views: ["v0": raiseCameraButton])
        addConstraintString(str: "V:[v0(70)]|", views: ["v0": lowerCameraButton])

        
    }
    
    let walkButtonsImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = #imageLiteral(resourceName: "WalkButtons")
        return view
    }()
    
    let heightButtonsImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = #imageLiteral(resourceName: "HeightButtons")
        return view
    }()
    
    let upAisleButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(startWalkUp), for: UIControlEvents.touchDown)
        button.addTarget(self, action: #selector(stopWalkUp), for: UIControlEvents.touchUpInside)
        button.addTarget(self, action: #selector(stopWalkUp), for: UIControlEvents.touchUpOutside)
        button.addTarget(self, action: #selector(stopWalkUp), for: UIControlEvents.touchDragExit)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let downAisleButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(startWalkDown), for: UIControlEvents.touchDown)
        button.addTarget(self, action: #selector(stopWalkDown), for: UIControlEvents.touchUpInside)
        button.addTarget(self, action: #selector(stopWalkDown), for: UIControlEvents.touchUpOutside)
        button.addTarget(self, action: #selector(stopWalkDown), for: UIControlEvents.touchDragExit)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let raiseCameraButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(startRaiseCamera), for: UIControlEvents.touchDown)
        button.addTarget(self, action: #selector(stopRaiseCamera), for: UIControlEvents.touchUpInside)
        button.addTarget(self, action: #selector(stopRaiseCamera), for: UIControlEvents.touchUpOutside)
        button.addTarget(self, action: #selector(stopRaiseCamera), for: UIControlEvents.touchDragExit)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let lowerCameraButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(startLowerCamera), for: UIControlEvents.touchDown)
        button.addTarget(self, action: #selector(stopLowerCamera), for: UIControlEvents.touchUpInside)
        button.addTarget(self, action: #selector(stopLowerCamera), for: UIControlEvents.touchUpOutside)
        button.addTarget(self, action: #selector(stopLowerCamera), for: UIControlEvents.touchDragExit)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    func startRaiseCamera(){
        heightTimer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { (_) in
            self.cameraNode.position.z += 0.01
        }
    }
    
    func stopRaiseCamera(){
        heightTimer?.invalidate()
    }
    
    func startLowerCamera(){
        heightTimer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { (_) in
            self.cameraNode.position.z -= 0.01
        }
    }
    
    func stopLowerCamera(){
        heightTimer?.invalidate()
    }
    
    func startWalkUp(){
        walkTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (_) in
            self.cameraNode.position.y += 0.1
        }
    }
    
    func stopWalkUp(){
        walkTimer?.invalidate()
    }
    
    func startWalkDown(){
        walkTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (_) in
            self.cameraNode.position.y -= 0.1
        }
    }
    
    func stopWalkDown(){
        walkTimer?.invalidate()
    }
    
    
    

    
    
    
}
