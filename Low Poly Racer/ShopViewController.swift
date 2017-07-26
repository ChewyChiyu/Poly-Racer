//
//  ShopViewController.swift
//  Low Poly Racer
//
//  Created by Evan Chen on 7/26/17.
//  Copyright © 2017 Evan Chen. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class ShopViewController : UIViewController{
    var alreadyLoaded = false
    weak var shopScene : ShopScene?
    weak var shopView : SKView?
    override func viewDidLoad() {
        super.viewDidLoad()
        alreadyLoaded = true
        loadSceneAndView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard alreadyLoaded == false else { return }
        loadSceneAndView()
    }
    
    func loadSceneAndView(){
        shopView = self.view as? SKView!
        shopScene = ShopScene(fileNamed: "ShopScene.sks")
        shopScene?.shopViewController = self
        shopScene?.scaleMode = .aspectFill
        shopView?.presentScene(shopScene)
        shopView?.ignoresSiblingOrder = true
        shopView?.showsFPS = true
        shopView?.showsNodeCount = true
    }
    
    func shopToPlay(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
