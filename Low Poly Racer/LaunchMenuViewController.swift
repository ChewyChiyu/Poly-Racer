//
//  LaunchMenuViewController.swift
//  Low Poly Racer
//
//  Created by Evan Chen on 7/25/17.
//  Copyright © 2017 Evan Chen. All rights reserved.
//

import UIKit
import SpriteKit
class LaunchMenuViewController: UIViewController {
    
    weak var launchScene: LaunchScene?
    weak var launchView : SKView?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        launchView = self.view as? SKView!
        launchScene = LaunchScene(fileNamed: "LaunchScene.sks")
        launchScene?.launchViewController = self
        launchScene?.scaleMode = .aspectFill
        launchView?.presentScene(launchScene)
        launchView?.ignoresSiblingOrder = true
        launchView?.showsFPS = true
        launchView?.showsNodeCount = true
    }
    func launchToPlay(){
        self.performSegue(withIdentifier: "LaunchToPlay", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        //print("exited launch menu")
    }
    
}

