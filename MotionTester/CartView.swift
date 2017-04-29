//
//  CartView.swift
//  MotionTester
//
//  Created by Jackie Xu on 4/29/17.
//  Copyright © 2017 Jackie Xu. All rights reserved.
//

import UIKit

class CartView: UIView{

    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
        backgroundColor = UIColor.white
    }
    
    func setupViews(){
        
        
    }
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.red
        label.text = "Cart"
        return label
    }()
    
    func addConstraintString(str: String){
        let views: [String: UIView] = [
            "v0":title,
            
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