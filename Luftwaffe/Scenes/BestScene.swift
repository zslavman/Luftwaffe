//
//  BestScene.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 12.10.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import SpriteKit

class BestScene: ParentScene {
	
	
	private var scores:[Int] = []

	
	override func didMove(to view: SKView) {

		settings.loadScores()
		scores = settings.highscore
		
		setHeader(withName: "best", andBackground: "header_background")

		// кн. возврата на предыдущий экран
		let back = ButtonNode(titled: "back", backgroundName: "button_background")
		back.position = CGPoint(x: self.frame.midX, y: 150)
		back.name = "back"
		back.label.name = "back"
		addChild(back)
		
		var startY = self.frame.midY + 80
		
		for (index, value) in scores.enumerated(){
			let label = SKLabelNode(text: String(index + 1) + ". " + value.description)
			label.fontColor = #colorLiteral(red: 0.8392156863, green: 0.8745098039, blue: 0.8274509804, alpha: 1)
			label.fontName = "AmericanTypeWriter-Bold"
			label.fontSize = 30
			label.horizontalAlignmentMode = .left
			label.position = CGPoint(x: self.frame.midX - 70, y: startY)
			startY -= label.calculateAccumulatedFrame().height + 20
			addChild(label)
		}
		
	}

	

	
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let location = touches.first!.location(in: self)
		let node = atPoint(location)
		
		if node.name == "back" {
			let transition = SKTransition.push(with: .right, duration: 0.3)
			guard let backScene = backScene else { return }
			backScene.scaleMode = .aspectFill
			self.scene!.view?.presentScene(backScene, transition: transition)
		}
	}
	
	
	
}
