//
//  ShopScene.swift
//  Low Poly Racer
//
//  Created by Evan Chen on 7/26/17.
//  Copyright © 2017 Evan Chen. All rights reserved.
//

import Foundation
import SpriteKit

class ShopScene : SKScene{
    weak var shopViewController : ShopViewController?
    var backButton: Button?
    override func didMove(to view: SKView) {
        backButton = self.childNode(withName: "BackButton") as? Button
        backButton?.playAction = { [weak self] in
            self?.shopViewController?.shopToPlay()
        }
    }
    
    
}
