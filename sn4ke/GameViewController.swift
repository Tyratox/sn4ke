//
//  GameViewController.swift
//  sn4ke
//
//  Created by Nico Hauser on 01.08.17.
//  Copyright © 2017 tyratox.ch. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad();
        
        let scene = GameScene(size: view.bounds.size);
        scene.scaleMode = .aspectFill;
        
        let skView = self.view as! SKView;
        skView.showsFPS = true;
        skView.showsNodeCount = true;
        skView.ignoresSiblingOrder = true;
        skView.showsPhysics = true;
        skView.presentScene(scene);
    }

    override var shouldAutorotate: Bool {
        return true;
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if (UIDevice.current.userInterfaceIdiom == .phone) {
            return .allButUpsideDown;
        } else {
            return .all;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true;
    }
}
