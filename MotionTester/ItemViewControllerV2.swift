//
//  ItemViewControllerV2.swift
//  MotionTester
//
//  Created by Jackie Xu on 5/28/17.
//  Copyright © 2017 Jackie Xu. All rights reserved.
//

import UIKit
import SceneKit

class ItemViewControllerV2: UIViewController, SCNSceneRendererDelegate{
    
    var sceneView: SCNView!
    var scene: SCNScene!
    
    var selectedItem: SCNNode!
    var itemName: String!
    var price: String!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.clear
        setupItem3D()
        setupViews()
        itemNameLabel.text = itemName
        priceLabel.text = price
    
    }
    
    func setupViews(){
        view.addSubview(item3D)
        item3D.addSubview(sceneView)

        view.addSubview(backgroundView)
        backgroundView.addSubview(itemNameLabel)
        backgroundView.addSubview(quantityLabel)
        backgroundView.addSubview(priceLabel)
        backgroundView.addSubview(addButton)
        backgroundView.addSubview(increaseQuantity)
        backgroundView.addSubview(decreaseQuantity)
        backgroundView.addSubview(cancelButton)
        
        let height = view.frame.height - 285
        
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-15-[v0]-15-|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: ["v0": backgroundView])
        )
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[v0(250)]-15-|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: ["v0": backgroundView])
        )

        addConstraintStringToBG(str: "H:|[v1]|")
        
        addConstraintStringToBG(str: "V:|-10-[v1(50)]-10-[v2(40)]-10-[v3(50)]")
        addConstraintStringToBG(str: "V:|-70-[v6(40)]")
        addConstraintStringToBG(str: "V:|-70-[v7(40)]")

        addConstraintStringToBG(str: "V:[v4(50)]-10-|")
        addConstraintStringToBG(str: "V:[v5(50)]-10-|")
        
        backgroundView.addConstraint(NSLayoutConstraint(item: quantityLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: backgroundView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        backgroundView.addConstraint(NSLayoutConstraint(item: priceLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: backgroundView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        addConstraintStringToBG(str: "H:[v6(40)]-5-[v2(40)]-5-[v7(40)]")
        addConstraintStringToBG(str: "H:|[v3]|")
        addConstraintStringToBG(str: "H:|-10-[v5]-10-[v4]-10-|")
        addConstraintStringToBG(str: "H:[v5(==v4)]")
        
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[v0]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: ["v0": item3D])
        )
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-10-[v0(\(height))]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: ["v0": item3D])
        )
        
        item3D.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[v0]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: ["v0": sceneView])
        )
        item3D.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[v0]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: ["v0": sceneView])
        )
        
    }
    
    func setupItem3D(){
        sceneView = SCNView()
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.backgroundColor = UIColor.clear
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.delegate = self
        
        scene = SCNScene()
        sceneView.scene = scene
        
        selectedItem.scale.x *= 5
        selectedItem.scale.y *= 5
        selectedItem.scale.z *= 5
        
        
        
        selectedItem.eulerAngles.y = Float.pi / 2 * -1
        selectedItem.eulerAngles.z = Float.pi / 2 * -1
        
        // not sure why frosted flakes not working
        //        if selectedItem.name!.contains("Frosted"){
        //            selectedItem.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "frostedflakes")
        //        }
        
        scene.rootNode.addChildNode(selectedItem!)
        
        sceneView.isPlaying = true
        
    }
    
    let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 1, alpha: 0.8)
        view.layer.cornerRadius = 10
        return view
        
    }()
    
    let itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Frosted Flakes"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.init(name: "HelveticaNeue", size: 30)
        return label
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.init(name: "HelveticaNeue", size: 25)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$4.99"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.init(name: "HelveticaNeue-Light", size: 35)
        return label
    }()
    
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        //button.setTitleColor(UIColor.gray, for: .normal)
        button.setTitleColor(UIColor(white: 85/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 18)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(white: 0, alpha: 0.14)
        //button.layer.borderColor = UIColor.gray.cgColor
        //button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(dismissThyself), for: .touchUpInside)
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to Cart", for: .normal)
        //button.setTitleColor(UIColor(red: 39/255, green: 174/255, blue: 96/255, alpha: 1), for: .normal)
        button.setTitleColor(UIColor(white: 85/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 18)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 39/255, green: 174/255, blue: 96/255, alpha: 0.6)
        //button.layer.borderColor = UIColor(red: 39/255, green: 174/255, blue: 96/255, alpha: 1).cgColor
        //button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(addButtonTouched), for: .touchUpInside)
        return button
    }()
    
    let increaseQuantity: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(increaseQuantityTouched), for: .touchUpInside)
        return button
    }()
    
    let decreaseQuantity: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "minus"), for: .normal)
        button.addTarget(self, action: #selector(decreaseQuantityTouched), for: .touchUpInside)
        return button
    }()
    
    let item3D: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func addButtonTouched(){
        (presentingViewController as! SceneViewController).itemsCount += 1
        //shrink while going down? looks like going into cart
        dismissThyself()
    }
    
    func dismissThyself(){
        // show buttons
        (presentingViewController as! SceneViewController).showUI()

        dismiss(animated: true) {
            //completion block
        }
    }
    
    func increaseQuantityTouched(){
        let str: String = quantityLabel.text!
        let newNum = Int(str)! + 1
        quantityLabel.text = String(newNum)
    }
    
    func decreaseQuantityTouched(){
        let str: String = quantityLabel.text!
        
        let newNum = Int(str)! - 1
        if newNum >= 1 {
            quantityLabel.text = String(newNum)
        }
        
    }
    
    func addConstraintStringToBG(str: String){
        let views: [String: UIView] = [
            "v1": itemNameLabel,
            "v2": quantityLabel,
            "v3": priceLabel,
            "v4": addButton,
            "v5": cancelButton,
            "v6": decreaseQuantity,
            "v7": increaseQuantity,
        ]
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: str,
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: views)
        )
    }
    
    
    
    
}
