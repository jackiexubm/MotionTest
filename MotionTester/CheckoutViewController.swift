//
//  CheckoutViewController.swift
//  MotionTester
//
//  Created by Jackie Xu on 4/29/17.
//  Copyright © 2017 Jackie Xu. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController{
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        setupViews()
    }
    

    func setupViews(){
        view.addSubview(itemName)
        view.addSubview(quantityLabel)
        view.addSubview(priceLabel)
        view.addSubview(addButton)
        view.addSubview(cancelButton)
        
        addConstraintString(str: "H:|[v0]|")
        addConstraintString(str: "V:|-35-[v0(80)]")
        
        addConstraintString(str: "H:|[v1]|")
        addConstraintString(str: "H:|[v2]|")
        addConstraintString(str: "H:|-10-[v4]-10-[v3]-10-|")
        addConstraintString(str: "[v4(==v3)]")
        addConstraintString(str: "V:[v4(50)]-10-|")
        addConstraintString(str: "V:[v1(30)]-10-[v2(40)]-20-[v3(50)]-10-|")
        
    }

    let itemName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Frosted Flakes"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.init(name: "HelveticaNeue-Light", size: 40)
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
        button.setTitleColor(UIColor.green, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 18)
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(dismissThyself), for: .touchUpInside)
        return button
    }()
    
    
    func addConstraintString(str: String){
        let views: [String: UIView] = [
            "v0":itemName,
            "v1":quantityLabel,
            "v2":priceLabel,
            "v3":addButton,
            "v4":cancelButton
        ]
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: str,
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: views)
        )
    }

    
    func dismissThyself(){
        dismiss(animated: true) {
            //completion block
        }
    }

}
