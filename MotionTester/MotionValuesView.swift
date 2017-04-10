//
//  MotionValuesView.swift
//  MotionTester
//
//  Created by Jackie Xu on 3/31/17.
//  Copyright © 2017 Jackie Xu. All rights reserved.
//

import UIKit

class MotionValuesView: UIView{
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupViews()
    }
    
    let Rx: UILabel = {
        let view = UILabel()
        view.text = "Rx:  "
        view.font = view.font.withSize(20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let Ry: UILabel = {
        let view = UILabel()
        view.text = "Ry:  "
        view.font = view.font.withSize(20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let Rz: UILabel = {
        let view = UILabel()
        view.text = "Rz:  "
        view.font = view.font.withSize(20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let RxVal: UILabel = {
        let view = UILabel()
        view.text = "15"
        view.font = view.font.withSize(20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let RyVal: UILabel = {
        let view = UILabel()
        view.text = "57"
        view.font = view.font.withSize(20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let RzVal: UILabel = {
        let view = UILabel()
        view.text = "69"
        view.font = view.font.withSize(20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let Roll: UILabel = {
        let view = UILabel()
        view.text = "Roll:  "
        view.font = view.font.withSize(20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let Pitch: UILabel = {
        let view = UILabel()
        view.text = "Pitch:  "
        view.font = view.font.withSize(20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let Yaw: UILabel = {
        let view = UILabel()
        view.text = "Yaw:  "
        view.font = view.font.withSize(20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let RollVal: UILabel = {
        let view = UILabel()
        view.text = "25"
        view.font = view.font.withSize(20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let PitchVal: UILabel = {
        let view = UILabel()
        view.text = "57"
        view.font = view.font.withSize(20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let YawVal: UILabel = {
        let view = UILabel()
        view.text = "69"
        view.font = view.font.withSize(20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let Ax: UILabel = {
        let view = UILabel()
        view.text = "Ax:  "
        view.font = view.font.withSize(20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let Ay: UILabel = {
        let view = UILabel()
        view.text = "Ay:  "
        view.font = view.font.withSize(20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let Az: UILabel = {
        let view = UILabel()
        view.text = "Az:  "
        view.font = view.font.withSize(20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let AxVal: UILabel = {
        let view = UILabel()
        view.text = "25"
        view.font = view.font.withSize(20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let AyVal: UILabel = {
        let view = UILabel()
        view.text = "57"
        view.font = view.font.withSize(20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let AzVal: UILabel = {
        let view = UILabel()
        view.text = "69"
        view.font = view.font.withSize(20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

//    let Rx: UILabel = {
//        let view = UILabel()
//        view.text = "Rx:  "
//        view.backgroundColor = UIColor.white
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    let Ry: UILabel = {
//        let view = UILabel()
//        view.text = "Ry:  "
//        view.backgroundColor = UIColor.white
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    let Rz: UILabel = {
//        let view = UILabel()
//        view.text = "Rz:  "
//        view.backgroundColor = UIColor.white
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()

    func setupViews(){
        addSubview(Rx)
        addSubview(Ry)
        addSubview(Rz)
        addSubview(RxVal)
        addSubview(RyVal)
        addSubview(RzVal)
        addSubview(Ax)
        addSubview(Ay)
        addSubview(Az)
        addSubview(AxVal)
        addSubview(AyVal)
        addSubview(AzVal)
        addSubview(Roll)
        addSubview(Pitch)
        addSubview(Yaw)
        addSubview(RollVal)
        addSubview(PitchVal)
        addSubview(YawVal)
        
        addConstraintString(str: "H:|-100-[v0]-50-[v1]", views: ["v0":Rx, "v1": RxVal])
        addConstraintString(str: "H:|-100-[v0]-50-[v1]", views: ["v0":Ry, "v1": RyVal])
        addConstraintString(str: "H:|-100-[v0]-50-[v1]", views: ["v0":Rz, "v1": RzVal])
        addConstraintString(str: "H:|-100-[v0]-50-[v1]", views: ["v0":Ax, "v1": AxVal])
        addConstraintString(str: "H:|-100-[v0]-50-[v1]", views: ["v0":Ay, "v1": AyVal])
        addConstraintString(str: "H:|-100-[v0]-50-[v1]", views: ["v0":Az, "v1": AzVal])
        addConstraintString(str: "H:|-100-[v0]-50-[v1]", views: ["v0":Roll, "v1": RollVal])
        addConstraintString(str: "H:|-100-[v0]-50-[v1]", views: ["v0":Pitch, "v1": PitchVal])
        addConstraintString(str: "H:|-100-[v0]-50-[v1]", views: ["v0":Yaw, "v1": YawVal])
        
        addConstraintString(str: "V:|-100-[v0]-5-[v1]-5-[v2]-15-[v3]-5-[v4]-5-[v5]-15-[v6]-5-[v7]-5-[v8]", views: ["v0":Rx, "v1": Ry, "v2":Rz, "v3":Ax, "v4": Ay, "v5":Az, "v6":Roll, "v7": Pitch, "v8":Yaw])
        addConstraintString(str: "V:|-100-[v0]-5-[v1]-5-[v2]-15-[v3]-5-[v4]-5-[v5]-15-[v6]-5-[v7]-5-[v8]", views: ["v0":RxVal, "v1": RyVal, "v2":RzVal, "v3":AxVal, "v4": AyVal, "v5":AzVal, "v6":RollVal, "v7": PitchVal, "v8":YawVal])
        
    }
    
    func addConstraintString(str: String, views: [String: UIView]){
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
