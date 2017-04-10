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

    public func getAttitudeAsync(interval: TimeInterval = 0.1, values: ((_ attitude: CMAttitude) -> ())? ) {
        
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
            print("Device motion is not available")
        }
    }
    
    
}
