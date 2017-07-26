//
//  GameOverLay.swift
//  Low Poly Racer
//
//  Created by Evan Chen on 7/26/17.
//  Copyright © 2017 Evan Chen. All rights reserved.
//

import SpriteKit

class GameOverLay: SKScene {
    weak var gameViewController: GameViewController?
    var backButton: Button?
    
    override func didMove(to view: SKView) {
        backButton = self.childNode(withName: "BackButton") as? Button
        backButton?.playAction = { [weak self] in
            self?.gameViewController?.gameToPlay()
        }
    }
}
