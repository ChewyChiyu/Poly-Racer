//
//  Car.swift
//  Low Poly Racer
//
//  Created by Evan Chen on 7/26/17.
//  Copyright © 2017 Evan Chen. All rights reserved.
//

import Foundation
import SceneKit

class Car : SCNNode{
    
    var shouldThrust = false
    
    override init(){
        super.init()
        let carScene = SCNScene(named: "\(StoredInformation.info.currentCar.rawValue ).scn")
        for carPart in (carScene?.rootNode.childNodes)!{
            carPart.removeFromParentNode()
            self.addChildNode(carPart)
        }
        addPhysicsBody()
    }
    
    func addPhysicsBody(){
        self.physicsBody =  SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: self, options: [SCNPhysicsShape.Option.type:SCNPhysicsShape.ShapeType.convexHull]))
        self.physicsBody?.isAffectedByGravity = false
        self.physicsBody?.angularDamping = 0.4
        self.physicsBody?.damping = 0.4
    }
    
    func rotate(increment: Float){
        let position = self.presentation.position
        self.eulerAngles.x = 0
        self.eulerAngles.y += (increment*0.01)
        if (self.eulerAngles.y >= Float.pi*2) {self.eulerAngles.y = 0}
        if(self.eulerAngles.y <= -Float.pi*2) {self.eulerAngles.y = 0}
        self.position = position
    }
    
    func applyThrust(){
        guard shouldThrust == true else {return}
        let vectorNew = getZForward(node: self.presentation)
        self.position = self.presentation.position
        self.physicsBody?.applyForce(SCNVector3(-vectorNew.x*0.1,0,-vectorNew.z*0.1), asImpulse: true)
        self.position = self.presentation.position
    }
    
    func getZForward(node: SCNNode) -> SCNVector3 {
        return SCNVector3(node.presentation.worldTransform.m31, node.presentation.worldTransform.m32, node.presentation.worldTransform.m33)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
