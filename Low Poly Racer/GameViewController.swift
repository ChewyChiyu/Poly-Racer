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
class GameViewController: UIViewController, SCNSceneRendererDelegate{
    
    weak var gameScene: SCNScene?
    weak var gameView: SCNView?
    var gameCamera: SCNNode?
    var car: Car?
    var primaryTouch = CGPoint.zero
    
    var state: gameState = .isLaunched{
        didSet{
            switch(state){
            case .isLaunched:
                changeStateTo(newState: .isStarting)
                break
            case .isStarting:
                changeStateTo(newState: .isPlaying)
                break
            case .isPlaying:
                break
            case .isEnding:
                break
            case .isRestarting:
                break
            }
        }
    }
    
    func changeStateTo(newState: gameState){
        state = newState
    }
    
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
        //gameView?.allowsCameraControl = true
        gameView?.autoenablesDefaultLighting = false
        gameView?.isPlaying = true
        gameView?.delegate = self
        gameCamera = gameScene?.rootNode.childNode(withName: "camera", recursively: true)
        car = Car()
        gameScene?.rootNode.addChildNode(car!)
        changeStateTo(newState: .isLaunched)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if(state == .isPlaying){
            lockCameraOnNode(node: car!)
            car?.applyThrust()
        }
    }
    
    func lockCameraOnNode(node: SCNNode){
        let nodePosition = node.presentation.position
        gameCamera?.position = SCNVector3(x: nodePosition.x, y: nodePosition.y+5, z: nodePosition.z+8)
    }
    
    func loadGameOverLay(){
        let overlay = GameOverLay(fileNamed: "GameOverLay.sks")
        overlay?.scaleMode = .aspectFill
        overlay?.gameViewController = self
        overlay?.isUserInteractionEnabled = false
        gameView?.overlaySKScene = overlay
    }
    
    func gameToPlay(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(state == .isPlaying){
            car?.shouldThrust = true
            primaryTouch = (touches.first?.location(in: gameView))!
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(state == .isPlaying){
            let locaiton = touches.first?.location(in: gameView)
            car?.rotate(increment: Float(locaiton!.x-primaryTouch.x))
            primaryTouch = locaiton!
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(state == .isPlaying){
            car?.shouldThrust = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
