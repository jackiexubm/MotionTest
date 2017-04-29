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
        gameView.autoenablesDefaultLighting = false
        gameView.delegate = self
        //gameView.allowsCameraControl = true
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
        
        
        
        
        // let importScene = SCNScene.init(named: "shop.dae")
        
        
        //        hollowSphere = importScene!.rootNode.childNodes[0]
        //
        //
        //        let mat = hollowSphere.geometry?.materials[0]
        //        print(hollowSphere.geometry?.materials.count)
        //        mat?.isDoubleSided = true
        //        mat?.lightingModel = SCNMaterial.LightingModel.constant
        //
        //        gameScene.rootNode.addChildNode(hollowSphere)
        //
        
        
        
        //        lightNode = SCNNode()
        //        let light: SCNLight = SCNLight()
        //        lightNode.light = light
        //        lightNode.position = SCNVector3.init(0, 0, 0)
        //
        //gameScene.rootNode.addChildNode(lightNode)
        
        //        mat?.lightingModel = SCNMaterial.LightingModel.physicallyBased
        //        mat?.diffuse.contents = #imageLiteral(resourceName: "rustediron-streaks-albedo")
        //        mat?.roughness.contents = #imageLiteral(resourceName: "rustediron-streaks-roughness")
        //        mat?.metalness.contents = #imageLiteral(resourceName: "rustediron-streaks-metal")
        //        mat?.normal.contents = #imageLiteral(resourceName: "rustediron-streaks-normal")
        
    }
    

    
//    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
//        if time > transformTimer{
//            //cameraNode.position.y += 0.3
//            testNode.eulerAngles.z += 0.005
//            //                objNode.eulerAngles.z += Float(5 * M_PI / 180)
//            transformTimer = time + 0.1
//        }
//    }
    
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
        heightTimer = Timer.scheduledTimer(withTimeInterval: 0.06, repeats: true) { (_) in
            self.cameraNode.position.z += 0.02
        }
    }
    
    func stopRaiseCamera(){
        heightTimer?.invalidate()
    }
    
    func startLowerCamera(){
        heightTimer = Timer.scheduledTimer(withTimeInterval: 0.06, repeats: true) { (_) in
            self.cameraNode.position.z -= 0.02
        }
    }
    
    func stopLowerCamera(){
        heightTimer?.invalidate()
    }
    
    func startWalkUp(){
        walkTimer = Timer.scheduledTimer(withTimeInterval: 0.06, repeats: true) { (_) in
            self.cameraNode.position.y += 0.09
        }
    }
    
    func stopWalkUp(){
        walkTimer?.invalidate()
    }
    
    func startWalkDown(){
        walkTimer = Timer.scheduledTimer(withTimeInterval: 0.06, repeats: true) { (_) in
            self.cameraNode.position.y -= 0.09
        }
    }
    
    func stopWalkDown(){
        walkTimer?.invalidate()
    }
    
    
    

    
    
    
}
