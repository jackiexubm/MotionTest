//
//  MotionValuesViewController.swift
//  MotionTester
//
//  Created by Jackie Xu on 3/31/17.
//  Copyright © 2017 Jackie Xu. All rights reserved.
//

import UIKit
import CoreMotion

class MotionValuesViewController: UIViewController {
    
    let motionValuesView = MotionValuesView()
    let motionManager: MyMotion = MyMotion()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = motionValuesView
//        motionManager.getAccelerometerValues(interval: 0.2) { (x, y, z, roll, pitch) -> () in
//            DispatchQueue.main.async {
//                self.setLabels(x, y, z, roll, pitch)
//            }
//        }
//        
//        motionManager.getMagnetometerValues { (x, y, z) in
//            
//        }
        
        motionManager.getAttitudeAsync(interval: 0.2) { (attitude) in
//            print(attitude.roll * 180 / M_PI)
//            print(attitude.pitch * 180 / M_PI)
//            print(attitude.yaw * 180 / M_PI)
       
            let quat: CMQuaternion = attitude.quaternion

            var roll: Double
            var pitch: Double
            var yaw: Double
            
            // Quaternion to Euler method 1
            
            let w: Double = quat.w
            let x: Double = quat.x
            let y: Double = quat.y
            let z: Double = quat.z
            
//            var roll  = atan2(2*y*w - 2*x*z, 1 - 2*y*y - 2*z*z)
//            var pitch = atan2(2*x*w - 2*y*z, 1 - 2*x*x - 2*z*z)
//            var yaw   =  asin(2*x*y + 2*z*w)
            
            roll = atan2(2*(quat.y*quat.w - quat.x*quat.z), 1 - 2*quat.y*quat.y - 2*quat.z*quat.z) * 180 / M_PI
            pitch = atan2(2*(quat.x*quat.w + quat.y*quat.z), 1 - 2*quat.x*quat.x - 2*quat.z*quat.z) * 180 / M_PI - 90
            yaw = asin(2*quat.x*quat.y + 2*quat.w*quat.z) * 180 / M_PI
            
//            print(roll * 180 / M_PI)
//            print(pitch * 180 / M_PI)
//            print(yaw * 180 / M_PI)
            
            DispatchQueue.main.async {
                self.setLabels(w, x, y, z, roll, pitch, yaw)
            }
            
        }
    }


    func setLabels(_ w: Double, _ x: Double, _ y: Double, _ z: Double, _ roll: Double, _ pitch: Double, _ yaw: Double){
        self.motionValuesView.RxVal.text = String(w)
        self.motionValuesView.RyVal.text = String(x)
        self.motionValuesView.RzVal.text = String(y)
        self.motionValuesView.AxVal.text = String(z)

        self.motionValuesView.RollVal.text = String(roll)
        self.motionValuesView.PitchVal.text = String(pitch)
        self.motionValuesView.YawVal.text = String(yaw)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
