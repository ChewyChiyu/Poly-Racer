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
    var numOfFormations = 0
    var mapFormationFirst = SCNNode()
    var mapFormationSecond = SCNNode()
    var mapFormations = [SCNNode(), SCNNode(), SCNNode(), SCNNode()]
    let formationLength = 110 // 10 block buffer
    
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
        if (StoredInformation.info.currentMap?.rawValue == "Map1"){
            gameScene?.background.contents = UIColor(colorLiteralRed: 48/255, green: 17/255, blue: 102/255, alpha: 1)
        }
        gameView?.scene = gameScene
        gameView?.showsStatistics = true
        //gameView?.allowsCameraControl = true
        gameView?.autoenablesDefaultLighting = false
        gameView?.debugOptions = SCNDebugOptions.showPhysicsShapes
        gameView?.isPlaying = true
        gameView?.delegate = self
        gameCamera = gameScene?.rootNode.childNode(withName: "camera", recursively: true)
        car = Car()
        gameScene?.rootNode.addChildNode(car!)
        for index in 0..<mapFormations.count{
            newMapFormation(index: index)
        }
        changeStateTo(newState: .isLaunched)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if(state == .isPlaying){
            lockCameraOnNode(node: car!)
            car?.applyThrust()
            manageMapGeneration()
        }
    }
    
    func newMapFormation(index: Int){
        mapFormations[index] = getRandomMapFormation()
        gameScene?.rootNode.addChildNode(mapFormations[index])
    }
    
    func getRandomMapFormation() -> SCNNode{
        var formationName = String()
        formationName = "_FormationA.scn"
        let sceneFormationName = "\(StoredInformation.info.currentMap?.rawValue ?? "")\(formationName)"
        let randomFormation = SCNScene(named: sceneFormationName)
        let newNode = SCNNode()
        for randPart in (randomFormation?.rootNode.childNodes)!{
            randPart.removeFromParentNode()
            newNode.addChildNode(randPart)
            randPart.position.z -= Float(numOfFormations * formationLength)
        }
        numOfFormations += 1
        return newNode
    }
    
    
    func manageMapGeneration(){
        checkForNodeRemoval()
        checkForNewFormation()
    }
    
    func checkForNewFormation(){
        for index in 0..<mapFormations.count{
            if(mapFormations[index].childNodes.count <= 0){
                newMapFormation(index: index)
            }
        }
    }
    
    func checkForNodeRemoval(){
        for map in mapFormations{
            for mapPart in (map.childNodes){
                if (mapPart.position.z > (car?.presentation.position.z)! + 10){
                    mapPart.removeFromParentNode()
                }
            }
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
