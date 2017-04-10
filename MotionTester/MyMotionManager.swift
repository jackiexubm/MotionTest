//
//  MyMotionManager.swift
//  MotionTester
//
//  Created by Jackie Xu on 3/31/17.
//  Copyright © 2017 Jackie Xu. All rights reserved.
//


// SEE MOTION KIT https://github.com/MHaroonBaig/MotionKit

import CoreMotion
import Foundation


@objc protocol MotionKitDelegate {
    @objc optional  func retrieveAccelerometerValues (x: Double, y:Double, z:Double)
    //    optional  func retrieveGyroscopeValues     (x: Double, y:Double, z:Double, absoluteValue: Double)
    //    optional  func retrieveDeviceMotionObject  (deviceMotion: CMDeviceMotion)
    //    optional  func retrieveMagnetometerValues  (x: Double, y:Double, z:Double, absoluteValue: Double)
    
    //    optional  func getAccelerationValFromDeviceMotion        (x: Double, y:Double, z:Double)
    //    optional  func getGravityAccelerationValFromDeviceMotion (x: Double, y:Double, z:Double)
    //    optional  func getRotationRateFromDeviceMotion           (x: Double, y:Double, z:Double)
    //    optional  func getMagneticFieldFromDeviceMotion          (x: Double, y:Double, z:Double)
    //    optional  func getAttitudeFromDeviceMotion               (attitude: CMAttitude)
}

public class MyMotionManager{
    
    let manager = CMMotionManager()
    var delegate: MotionKitDelegate?
    var viewController: MotionValuesViewController?
    
//    func getAccelerometerValues (interval: TimeInterval = 0.1){
//        var valX: Double!
//        var valY: Double!
//        var valZ: Double!
//        if manager.isAccelerometerAvailable {
//            manager.accelerometerUpdateInterval = interval
//            manager.startAccelerometerUpdates(to: OperationQueue(), withHandler: {
//                (data, error) in
//                
//                if (error != nil) {
//                    print(error!)
//                }
//                
//                valX = data!.acceleration.x
//                valY = data!.acceleration.y
//                valZ = data!.acceleration.z
//                
//                //                if values != nil{
//                //                    values!(x: valX,y: valY,z: valZ)
//                //                }
//                let absoluteVal = sqrt(valX * valX + valY * valY + valZ * valZ)
//                self.delegate?.retrieveAccelerometerValues!(x: valX, y: valY, z: valZ, absoluteValue: absoluteVal)
//            })
//        } else {
//            NSLog("The Accelerometer is not available")
//        }
//    }

//    init(controller: MotionValuesViewController){
//        self.viewController = controller
//    }

    public func getAccelerometerValues (interval: TimeInterval = 0.1, values: ((_ x: Double, _ y: Double, _ z: Double) -> ())? ){
        var valX: Double!
        var valY: Double!
        var valZ: Double!
        if manager.isAccelerometerAvailable{
            manager.accelerometerUpdateInterval = interval
            manager.startAccelerometerUpdates(to: OperationQueue(), withHandler: {
                (data, error) in
                
                if let isError = error {
                    NSLog(isError as! String)
                }
                valX = data!.acceleration.x
                valY = data!.acceleration.y
                valZ = data!.acceleration.z
                var input: [Double] = [Double]()
                input.append(valX)
                input.append(valY)
                input.append(valZ)
                if values != nil{
                    values!(valX,valY,valZ)
                }
                //let absoluteVal = sqrt(valX * valX + valY * valY + valZ * valZ)
               // self.delegate?.retrieveAccelerometerValues!(x: valX, y: valY, z: valZ, absoluteValue: absoluteVal)
                self.delegate?.retrieveAccelerometerValues!(x: valX, y: valY, z: valZ)
                
            })
        } else {
            NSLog("The Accelerometer is not available")
        }
    }
    
    func stopAccelerometerUpdates(){
        self.manager.stopAccelerometerUpdates()
        NSLog("Accelaration Updates Status - Stopped")
    }
    
    

}
