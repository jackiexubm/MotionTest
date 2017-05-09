//
//  AisleChooserViewController.swift
//  MotionTester
//
//  Created by Jackie Xu on 4/29/17.
//  Copyright © 2017 Jackie Xu. All rights reserved.
//

import UIKit

class AisleChooserViewController: UIViewController{
    
    // Temporarily hard coded for demo

    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        setupViews()
    }
    
    func setupViews(){
        view.addSubview(options)
        view.addSubview(nextButton)
        
        let height = view.frame.width * 1875 / 1125
        
        addConstraintString(str: "H:|[v0]|")
        addConstraintString(str: "V:[v0(\(height))]|")
        addConstraintString(str: "H:|[v1]|")
        addConstraintString(str: "V:|[v1]|")

        
    }
    
    let options: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = UIViewContentMode.scaleAspectFit
        //view.contentMode = UIViewContentMode.bottom
        view.image = #imageLiteral(resourceName: "pickAisle")
        return view
    }()
    
    let nextButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        return view
    }()
    
    func nextButtonTouched(){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        let newVC = SceneViewController()
        present(newVC, animated: false) {
            //completion block
        }
    }
    
    func addConstraintString(str: String){
        let views: [String: UIView] = [
            "v0": options,
            "v1": nextButton
        ]
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: str,
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: views)
        )
    }
}
