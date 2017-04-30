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
            
            if node.name!.contains("Floor"){
                //node.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "FloorBakeHiRes")
                //node.geometry?.firstMaterial?.lightingModel = .constant
            }
            
            if node.name!.contains("Fruit_Loops"){
                node.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "fruitloops")
            }else if node.name!.contains("Honey_Nut"){
                node.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "honeynut")
            }else if node.name!.contains("Rice_Krispies"){
                node.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "rice")
            }else if node.name!.contains("Apple_Jacks"){
                node.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "applejacks")
            }else if node.name!.contains("Lucky_Charms"){
                node.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "luckycharms")
            }else if node.name!.contains("Frosted_Flakes"){
                node.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "frostedflakes")
            }
            
            node.geometry?.firstMaterial?.isDoubleSided = true

        }
        
        lightNode = SCNNode()
        let lit = SCNLight()
        
        lit.castsShadow = true
        lit.intensity = 3000
        lightNode.light = lit
        
        lightNode.position = SCNVector3Make(0, 10, 3.7)
        gameScene.rootNode.addChildNode(lightNode)
        
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
        let nodeName = hitList.first?.node.name
        print(nodeName)
        
        
        switch nodeName{
        case "Ceiling"?:
            print("ceil")
        case "Frosted_Flakes"?:
            let newVC = CheckoutViewController()
            
            present(newVC, animated: true, completion: { 
                //completion block
            })
        default:
            print("neither")
        }
        
        
    }

    

    
//    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
//        if time > transformTimer{
//            lightNode.position.y -= 0.7
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
        view.addSubview(cartButton)
        
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
        
        addConstraintString(str: "V:[v0(80)]", views: ["v0" : cartButton])
        addConstraintString(str: "H:|[v0(40)]", views: ["v0" : cartButton])
        self.view.addConstraint(NSLayoutConstraint(item: cartButton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
        

        
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
    
    let cartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(openCart), for: UIControlEvents.touchUpInside)
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
            self.cameraNode.position.y += 0.5
        }
    }
    
    func stopWalkUp(){
        walkTimer?.invalidate()
    }
    
    func startWalkDown(){
        walkTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (_) in
            self.cameraNode.position.y -= 0.5
        }
    }
    
    func stopWalkDown(){
        walkTimer?.invalidate()
    }
    
    func openCart(){
    
        //print(lightNode.light?.shadow)
        
    }
    
    
    

    
    
    
}
