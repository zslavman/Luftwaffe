//
//  MenuScene.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 10.10.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import SpriteKit

class MenuScene: ParentScene {

	private var tip_TF:SKLabelNode!
	
	public var percentage:Int = 0 {
		didSet{
			tip_TF.text = "Loaded: \(percentage)%"
			if percentage == 100 {
				createButtons()
			}
		}
	}
	
	
	
	
	override func didMove(to view: SKView) {
		
		setHeader(withName: nil, andBackground: "header1")
		
		// подгрузка всех атласов
		if !Assets.share.isLoaded {
			createPreloaderLabel()
			Assets.share.preloadAssets()
			Assets.share.isLoaded = true
		}
		
	}
	
	
	
	
	
	
	
	private func createPreloaderLabel(){
		tip_TF = SKLabelNode(text: "")
		tip_TF.fontColor = #colorLiteral(red: 0.8392156863, green: 0.8745098039, blue: 0.8274509804, alpha: 1)
		tip_TF.fontName = "AppleSDGothicNeo-Bold"
		tip_TF.fontSize = 23
		tip_TF.horizontalAlignmentMode = .center
		tip_TF.verticalAlignmentMode = .center
		tip_TF.zPosition = 2
		tip_TF.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 70)
		if #available(iOS 11.0, *) {
			tip_TF.lineBreakMode = .byWordWrapping
		}
		addChild(tip_TF)
	}
	
	
	
	private func createButtons(){
		
		if tip_TF != nil {
			let wait = SKAction.wait(forDuration: 0.5)
			let fadeOut = SKAction.fadeOut(withDuration: 0.4)
			let remove = SKAction.removeFromParent()
			let seq = SKAction.sequence([wait, fadeOut, remove])
			tip_TF.run(seq)
		}
		
		let titles = ["play", "options", "best"]
		
		for (index, title) in titles.enumerated(){
			let button = ButtonNode(titled: title, backgroundName: "button_background")
			button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(100 * index))
			button.name = title
			button.label.name = title
			button.setScale(0)
			addChild(button)
			delayForButtons(bttn: button, delay: index)
		}
	}
	
	
	
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		// находим координаты точки касания
		let location = touches.first!.location(in: self)
		// находим объект под точкой касания
		let node = atPoint(location)
		
		var transition:SKTransition!
		var destination:SKScene!
	
		if node.name == "play" {
			transition = SKTransition.doorsOpenHorizontal(withDuration: 0.3)
			destination = Scene(size: self.size)
		}
		else if node.name == "options"{
			transition = SKTransition.push(with: .left, duration: 0.3)
			destination = OptionsScene(size: self.size, backScene: self)
		}
		else if node.name == "best"{
			transition = SKTransition.push(with: .left, duration: 0.3)
			destination = BestScene(size: self.size, backScene: self)
		}
		if (destination != nil){
			destination.scaleMode = .aspectFill
			self.scene!.view!.presentScene(destination, transition: transition)
		}
	}
	
	

	private func delayForButtons(bttn:ButtonNode, delay:Int){
		
		let wait = SKAction.wait(forDuration: TimeInterval(delay) * 0.1)
		let scale = SKAction.scale(to: 1, duration: 0.3)
		scale.timingMode = .easeInEaseOut
		let seq = SKAction.sequence([wait, scale])
		bttn.run(seq)
	}
	
	
		
	
	
	
	
}








