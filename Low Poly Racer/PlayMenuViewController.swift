//
//  PlayMenuViewController.swift
//  Low Poly Racer
//
//  Created by Evan Chen on 7/25/17.
//  Copyright © 2017 Evan Chen. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
class PlayMenuViewContorller: UIViewController{
    weak var playScene: PlayMenu?
    weak var playView : SKView?
    var alreadyLoaded = false
    override func viewDidLoad() {
        super.viewDidLoad()
        alreadyLoaded = true
        loadSceneAndView()
    }
    
    override func viewDidAppear(_ animated: Bool){
        // Do any additional setup after loading the view, typically from a nib.
        guard alreadyLoaded == false else{ return }
        loadSceneAndView()
    }
    
    func loadSceneAndView(){
        //print("loading play menu")
        playView = self.view as? SKView!
        playScene = PlayMenu(fileNamed: "PlayMenu.sks")
        playScene?.playMenuViewController = self
        playScene?.scaleMode = .aspectFill
        playView?.presentScene(playScene)
        playView?.ignoresSiblingOrder = true
        playView?.showsFPS = true
        playView?.showsNodeCount = true
    }
    
    
    func playToLaunch(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func playToShop(){
        self.performSegue(withIdentifier: "PlayToShop", sender: nil)
        alreadyLoaded = false
    }
    
    func playToGame(map: Maps){
        StoredInformation.info.currentMap = map
        self.performSegue(withIdentifier: "PlayToGame", sender: nil)
        alreadyLoaded = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        //print("exited play menu")
    }
}
