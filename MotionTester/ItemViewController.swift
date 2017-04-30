//
//  CheckoutViewController.swift
//  MotionTester
//
//  Created by Jackie Xu on 4/29/17.
//  Copyright © 2017 Jackie Xu. All rights reserved.
//

import UIKit
import SceneKit

class ItemViewController: UIViewController, SCNSceneRendererDelegate{
    
    var sceneView: SCNView!
    var scene: SCNScene!
    
    var selectedItem: SCNNode!
    var itemName: String!
    var price: String!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        setupItem3D()
        setupViews()
        itemNameLabel.text = itemName
        priceLabel.text = price
    }
    
    func setupViews(){
        view.addSubview(itemNameLabel)
        view.addSubview(quantityLabel)
        view.addSubview(priceLabel)
        view.addSubview(addButton)
        view.addSubview(increaseQuantity)
        view.addSubview(decreaseQuantity)
        view.addSubview(cancelButton)
        view.addSubview(item3D)
        item3D.addSubview(sceneView)
        
        
        addConstraintString(str: "H:|[v0]|")
        addConstraintString(str: "V:|-35-[v0(80)]")
        
        
        self.view.addConstraint(NSLayoutConstraint(item: quantityLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        addConstraintString(str: "H:[v7(40)]-15-[v1(25)]-15-[v6(40)]")
        
        
        addConstraintString(str: "H:|[v2]|")
        addConstraintString(str: "H:|-10-[v4]-10-[v3]-10-|")
        addConstraintString(str: "[v4(==v3)]")
        addConstraintString(str: "V:[v4(50)]-10-|")
        addConstraintString(str: "H:|[v5]|")
        addConstraintString(str: "V:|-20-[v0(50)]-10-[v5]-10-[v1(30)]-10-[v2(40)]-20-[v3(50)]-10-|")
        addConstraintString(str: "V:[v6(40)]-125-|")
        addConstraintString(str: "V:[v7(40)]-125-|")
        
        //addConstraintString(str: "[v4(==v3)]")
        
        
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
        sceneView.backgroundColor = UIColor.black
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.delegate = self
        
        scene = SCNScene()
        sceneView.scene = scene
        
        scene.rootNode.addChildNode(selectedItem!)
        print(selectedItem.childNodes.count)
        selectedItem?.position = SCNVector3Make(0, 0, 0)
        
        sceneView.isPlaying = true
        
    }
    
    let itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Frosted Flakes"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.init(name: "HelveticaNeue-Light", size: 30)
        return label
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.init(name: "HelveticaNeue", size: 30)
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
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 18)
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(dismissThyself), for: .touchUpInside)
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to Cart", for: .normal)
        button.setTitleColor(UIColor(red: 39/255, green: 174/255, blue: 96/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 18)
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor(red: 39/255, green: 174/255, blue: 96/255, alpha: 1).cgColor
        button.layer.borderWidth = 2
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
        if newNum >= 0{
            quantityLabel.text = String(newNum)
        }
        
    }
    
    func addConstraintString(str: String){
        let views: [String: UIView] = [
            "v0": itemNameLabel,
            "v1": quantityLabel,
            "v2": priceLabel,
            "v3": addButton,
            "v4": cancelButton,
            "v5": item3D,
            "v6": increaseQuantity,
            "v7": decreaseQuantity
        ]
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: str,
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: views)
        )
    }
    
    
    
}
