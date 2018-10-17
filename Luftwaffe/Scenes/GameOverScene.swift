//
//  GameOverScene.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 15.10.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import SpriteKit

class GameOverScene: ParentScene {

	
	override func didMove(to view: SKView) {
		
		setHeader(withName: "game over", andBackground: "header_background")
		
		let titles = ["restart", "options", "best"]
		
		for (index, title) in titles.enumerated(){
			let button = ButtonNode(titled: title, backgroundName: "button_background")
			button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(100 * index))
			button.name = title
			button.label.name = title
			addChild(button)
		}
	}
	
	
	
	
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		// находим координаты точки касания
		let location = touches.first!.location(in: self)
		// находим объект под точкой касания
		let node = atPoint(location)
		
		var transition:SKTransition!
		var destination:SKScene!
		
		if node.name == "restart" {
			sceneManager.gameScene = nil
			transition = SKTransition.doorsOpenHorizontal(withDuration: 0.3)
			destination = Scene(size: self.size)
		}
		else if node.name == "options"{
			transition = SKTransition.push(with: .left, duration: 0.3)
			destination = OptionsScene(size: self.size, backScene: self)
		}
		else if node.name == "best" {
			transition = SKTransition.push(with: .left, duration: 0.3)
			destination = BestScene(size: self.size, backScene: self)
		}
		if (destination != nil){
			destination.scaleMode = .aspectFill
			self.scene!.view!.presentScene(destination, transition: transition)
		}
	}
	
	
	
	
	
}
