//
//  CartViewController.swift
//  MotionTester
//
//  Created by Jackie Xu on 4/29/17.
//  Copyright © 2017 Jackie Xu. All rights reserved.
//

import UIKit

class CartViewController: UIViewController{
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        setupViews()
    }
    
    func setupViews(){
        view.addSubview(topLabel)
        view.addSubview(checkoutButton)
        view.addSubview(closeButton)
        view.addSubview(content)
        
        addConstraintString(str: "H:|[v0]|")
        addConstraintString(str: "H:|-20-[v1]-20-|")
        addConstraintString(str: "H:|[v3]|")
        addConstraintString(str: "V:|-20-[v0(50)]-10-[v3(500)]-[v1(60)]-20-|")
        
        addConstraintString(str: "H:|-10-[v2(30)]")
        addConstraintString(str: "V:|-30-[v2(30)]")
        
    }
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Cart"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.init(name: "HelveticaNeue-Light", size: 30)
        return label
    }()
    
    let checkoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Checkout", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 25)
        button.layer.cornerRadius = 30
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(checkoutButtonTouched), for: .touchUpInside)
        return button
    }()
    
    func checkoutButtonTouched(){
        print("touched")
    }
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(dismissThyself), for: .touchUpInside)
        // add down arrow image
        
        return button
    }()
    
    func dismissThyself(){
        print("dismiss")
    }
    
    let content: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.green
        
        
        return view
    }()
    
    func addConstraintString(str: String){
        let views: [String: UIView] = [
            "v0": topLabel,
            "v1": checkoutButton,
            "v2": closeButton,
            "v3": content
        ]
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: str,
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: views)
        )
    }
    
    
}
