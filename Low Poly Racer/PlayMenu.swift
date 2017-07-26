//
//  PlayMenu.swift
//  Low Poly Racer
//
//  Created by Evan Chen on 7/25/17.
//  Copyright © 2017 Evan Chen. All rights reserved.
//

import Foundation
import SpriteKit

class PlayMenu : SKScene{
    
    weak var playMenuViewController: PlayMenuViewContorller?
    var backButton: Button?
    var carDisplay: Button?
    var map1: Button?
    var map2: Button?
    var map3: Button?
    override func didMove(to view: SKView) {
        backButton = self.childNode(withName: "BackButton") as? Button
        carDisplay = self.childNode(withName: "CarDisplay") as? Button
        map1 = self.childNode(withName: "Map1") as? Button
        map2 = self.childNode(withName: "Map2") as? Button
        map3 = self.childNode(withName: "Map3") as? Button
        backButton?.playAction = { [weak self] in
            self?.playMenuViewController?.playToLaunch()
        }
        carDisplay?.playAction = { [weak self] in
            self?.playMenuViewController?.playToShop()
        }
        map1?.playAction = { [weak self] in
            self?.playMenuViewController?.playToGame(map: .Map1)
        }
        map2?.playAction = { [weak self] in
            self?.playMenuViewController?.playToGame(map: .Map2)
        }
        map3?.playAction = { [weak self] in
            self?.playMenuViewController?.playToGame(map: .Map3)
        }
    }
}
