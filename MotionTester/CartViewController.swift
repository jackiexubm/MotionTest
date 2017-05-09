//
//  CartViewController.swift
//  MotionTester
//
//  Created by Jackie Xu on 4/29/17.
//  Copyright © 2017 Jackie Xu. All rights reserved.
//

import UIKit

class CartViewController: UIViewController{
    
    // Temporarily hard coded for demo
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        setupViews()
    }
    
    func setupViews(){
        view.addSubview(checkoutButton)
        view.addSubview(content)
        view.addSubview(closeButton)
        
        let imageHeight = view.frame.width * 1737 / 1125
        
        addConstraintString(str: "H:|-20-[v1]-20-|")
        addConstraintString(str: "H:|[v3]|")
        addConstraintString(str: "V:|[v3(\(imageHeight))]-[v1(50)]-10-|")
        
        addConstraintString(str: "H:|-5-[v2(40)]")
        addConstraintString(str: "V:|-20-[v2(40)]")
        
    }

    
    let checkoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Checkout", for: .normal)
        button.setTitleColor(UIColor(red: 39/255, green: 174/255, blue: 96/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 25)
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor(red: 39/255, green: 174/255, blue: 96/255, alpha: 1).cgColor
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
        button.addTarget(self, action: #selector(dismissThyself), for: .touchUpInside)
        
        return button
    }()
    
    func dismissThyself(){
        dismiss(animated: true) { 
            // completion block
        }
    }
    
    let content: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = #imageLiteral(resourceName: "myCart")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    func addConstraintString(str: String){
        let views: [String: UIView] = [
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
