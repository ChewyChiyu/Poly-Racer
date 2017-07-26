//
//  GameViewController.swift
//  Low Poly Racer
//
//  Created by Evan Chen on 7/26/17.
//  Copyright © 2017 Evan Chen. All rights reserved.
//

import Foundation
import SceneKit
import QuartzCore
import SpriteKit
class GameViewController: UIViewController{
    
    weak var gameScene: SCNScene?
    weak var gameView: SCNView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSceneAndView()
        loadGameOverLay()
    }
    
    func loadSceneAndView(){
        gameView = self.view as? SCNView!
        gameScene = SCNScene(named: "\(StoredInformation.info.currentMap?.rawValue ?? "").scn")
        gameView?.scene = gameScene
        gameView?.showsStatistics = true
        gameView?.allowsCameraControl = true
        gameView?.autoenablesDefaultLighting = false
        gameView?.isPlaying = true
    }
    
    func loadGameOverLay(){
        let overlay = GameOverLay(fileNamed: "GameOverLay.sks")
        overlay?.scaleMode = .aspectFill
        overlay?.gameViewController = self
        gameView?.overlaySKScene = overlay
    }

    func gameToPlay(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
