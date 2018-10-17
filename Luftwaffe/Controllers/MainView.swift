//
//  GameViewController.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 29.09.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class MainView: UIViewController {
	
//	public static var shared = MainView()
	public static var shared:MainView!
	public var scene:MenuScene!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		MainView.shared = self
        
        if let view = self.view as! SKView? {

			scene = MenuScene(size: self.view.bounds.size)
			scene.scaleMode = .aspectFill
			
			// Present the scene
			view.presentScene(scene)
			
			
			view.ignoresSiblingOrder = true
			
			view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }


    override var prefersStatusBarHidden: Bool {
        return true
    }
}
