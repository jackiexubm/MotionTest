//
//  MyMotionManager.swift
//  MotionTester
//
//  Created by Jackie Xu on 4/1/17.
//  Copyright © 2017 Jackie Xu. All rights reserved.
//

import CoreMotion


public class MyMotion{
    
    let manager = CMMotionManager()
    
    
    public func getAccelerometerValues (interval: TimeInterval = 0.1, values: ((_ x: Double, _ y: Double, _ z: Double, _ roll: Double, _ pitch: Double) -> ())? ){
        if manager.isAccelerometerAvailable{
            var valX: Double!
            var valY: Double!
            var valZ: Double!
            var roll: Double!
            var pitch: Double!
            manager.accelerometerUpdateInterval = interval
            manager.startAccelerometerUpdates(to: OperationQueue(), withHandler: {
                (data, error) in
                
                if let isError = error {
                    NSLog(isError as! String)
                }
                
                valX = data!.acceleration.x
                valY = data!.acceleration.y
                valZ = data!.acceleration.z
                
                if valX >= 0 {
                    if valY >= 0 {
                        roll = 180 - atan(valX/valY) * 180 / M_PI
                    }else{
                        roll = -1 * atan(valX/valY) * 180 / M_PI
                    }
                }else{
                    if valY >= 0 {
                        roll = -180 - atan(valX/valY) * 180 / M_PI
                    }else{
                        roll = -1 * atan(valX/valY) * 180 / M_PI
                    }
                }
                
                if valZ >= 0 {
                    if valY >= 0 {
                        pitch = 180 - atan(valZ/valY) * 180 / M_PI
                    }else{
                        pitch = -1 * atan(valZ/valY) * 180 / M_PI
                    }
                }else{
                    if valY >= 0 {
                        pitch = -180 - atan(valZ/valY) * 180 / M_PI
                    }else{
                        pitch = -1 * atan(valZ/valY) * 180 / M_PI
                    }
                }

                values!(valX,valY,valZ,roll,pitch)

                
                
            })
        } else {
            NSLog("The Accelerometer is not available")
        }
    }
    
    func stopAccelerometerUpdates(){
        self.manager.stopAccelerometerUpdates()
        NSLog("Accelaration Updates Status - Stopped")
    }
    

    public func getMagnetometerValues (interval: TimeInterval = 0.1, values: ((_ x: Double, _ y:Double, _ z:Double) -> ())? ){
        
        var valX: Double!
        var valY: Double!
        var valZ: Double!
        if manager.isMagnetometerAvailable {
            manager.magnetometerUpdateInterval = interval
            manager.startMagnetometerUpdates(to: OperationQueue()){
                (data, error) in
                
                if error != nil{
                    NSLog(error as! String)
                }
                valX = data!.magneticField.x
                valY = data!.magneticField.y
                valZ = data!.magneticField.z
                
                print(valX, valY, valZ)
                
                values!(valX, valY, valZ)
            }
            
        } else {
            NSLog("Magnetometer is not available")
        }
    }
    

    public func getAttitude(interval: TimeInterval = 0.1, values: ((_ attitude: CMAttitude) -> ())? ) {
        
        if manager.isDeviceMotionAvailable{
            manager.deviceMotionUpdateInterval = interval
            manager.startDeviceMotionUpdates(to: OperationQueue()){
                (data, error) in
                
                if (error != nil){
                    NSLog(error as! String)
                }
                
                values!(data!.attitude)
         //       manager.attitudeReferenceFrame.
            }
            
        } else {
            NSLog("Device Motion is not available")
        }
    }
    
    
}
