//
//  ProductModel.swift
//  MotionTester
//
//  Created by Jackie Xu on 5/29/17.
//  Copyright © 2017 Jackie Xu. All rights reserved.
//

import SceneKit

struct ProductModel {

    var name: String
    var price: Float
    var node: SCNNode
    
    static func getProducts() -> [ProductModel] {
        
        // to be replaced in the future with a fetch request to server
        
        var ret: [ProductModel] = []
     
        let productsScene = SCNScene.init(named: "justCereals.dae")
        
        
        for node in productsScene!.rootNode.childNodes {
            var name: String = "-"
            
            if node.name!.contains("Fruit_Loops"){
                node.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "fruitloops")
                name = "Froot Loops"
            }else if node.name!.contains("Honey_Nut"){
                node.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "honeynut")
                name = "Honey Nut Cheerios"
            }else if node.name!.contains("Rice_Krispies"){
                node.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "rice")
                name = "Rice Krispies"
            }else if node.name!.contains("Apple_Jacks"){
                node.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "applejacks")
                name = "Apple Jacks"
            }else if node.name!.contains("Lucky_Charms"){
                node.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "luckycharms")
                name = "Lucky Charms"
            }else if node.name!.contains("Frosted"){
                node.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "frostedflakes")
                name = "Frosted Flakes"
            }
            
            node.geometry?.firstMaterial?.isDoubleSided = true
            
            let product: ProductModel = ProductModel(name: name, price: 4.99, node: node)
            ret.append(product)
        }
        return ret
    }

}
