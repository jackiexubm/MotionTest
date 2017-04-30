//
//  CheckoutView.swift
//  MotionTester
//
//  Created by Jackie Xu on 4/29/17.
//  Copyright © 2017 Jackie Xu. All rights reserved.
//

import UIKit

class CheckoutView: UIView{
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
        backgroundColor = UIColor.white
    }
    
    func setupViews(){
        addSubview(itemName)
        addSubview(quantityLabel)
        addSubview(priceLabel)
        addSubview(addButton)
        
        addConstraintString(str: "H:|[v0]|")
        addConstraintString(str: "V:|-20-[v0(80)]")
        
        addConstraintString(str: "H:|[v1]|")
        addConstraintString(str: "H:|[v2]|")
        addConstraintString(str: "H:|-40-[v3]-40-|")
        addConstraintString(str: "V:[v1(30)]-10-[v2(40)]-20-[v3(60)]-20-|")
        
        
        
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
    
    let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to Cart", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 25)
        button.layer.cornerRadius = 30
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    func addButtonPressed(){
        print("touched")
    }

    
    func addConstraintString(str: String){
        let views: [String: UIView] = [
            "v0":itemName,
            "v1":quantityLabel,
            "v2":priceLabel,
            "v3":addButton
            ]
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: str,
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: views)
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
}
