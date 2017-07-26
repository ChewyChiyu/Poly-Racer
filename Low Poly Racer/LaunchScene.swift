//
//  LaunchScene.swift
//  Low Poly Racer
//
//  Created by Evan Chen on 7/25/17.
//  Copyright © 2017 Evan Chen. All rights reserved.
//

import Foundation
import SpriteKit


class LaunchScene: SKScene{
    
    weak var launchViewController: LaunchMenuViewController?
    var playButton: Button?
    override func didMove(to view: SKView) {
        playButton = self.childNode(withName: "PlayButton") as? Button
        playButton?.playAction = { [weak self] in
            self?.launchViewController?.launchToPlay()
        }
    }
}
