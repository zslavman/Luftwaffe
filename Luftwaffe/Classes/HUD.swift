//
//  HUD.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 12.10.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import SpriteKit

// Heads Up Display
class HUD: SKNode {
	
	
	private let scoreBack = SKSpriteNode(imageNamed: "scores") 	// фон очков
	private let scoreLabel = SKLabelNode(text: "0")				// текст очков
	private let menuBttn = SKSpriteNode(imageNamed: "menu-1")		// кнопка меню
	private let life1 = SKSpriteNode(imageNamed: "life")		// жизнь1
	private let life2 = SKSpriteNode(imageNamed: "life")		// жизнь2
	private let life3 = SKSpriteNode(imageNamed: "life")		// жизнь3
	private var screenSize:CGSize = UIScreen.main.bounds.size
	private var livesArr:[SKSpriteNode] = []
	public var score:Int = 0 {
		didSet {
			scoreLabel.text = score.description
		}
	}
	

	override init() {
		super.init()
		configureUI()
		livesArr = [life1, life2, life3]
	}
	

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	private func configureUI(){
		
		scoreBack.anchorPoint = CGPoint(x: 1.0, y: 1)
		scoreBack.zPosition = 99
		addChild(scoreBack)
		
		scoreLabel.horizontalAlignmentMode = .right
		scoreLabel.verticalAlignmentMode = .center
		scoreLabel.position = CGPoint(x: -10, y: -(scoreBack.size.height / 2) + 3)
		scoreLabel.zPosition = 100
		scoreLabel.fontName = "AppleSDGothicNeo-Bold"
		scoreLabel.fontSize = 30
		scoreBack.addChild(scoreLabel)
		
		// немного уменьшим
		scoreBack.setScale(0.7)
		scoreBack.alpha = 0.8
		scoreBack.position = CGPoint(x: scoreBack.size.width + 5, y: screenSize.height - 5)
		
		menuBttn.position = CGPoint(x: menuBttn.size.width / 2 + 10, y: menuBttn.size.height / 2 + 10)
		menuBttn.zPosition = 100
		menuBttn.name = "pause"
		addChild(menuBttn)
		
		let lifesArr = [life1, life2, life3]
		let lifesContainer = SKSpriteNode()
		lifesContainer.anchorPoint = CGPoint(x: 0, y: 0.5)
		addChild(lifesContainer)
		
		//		var srartX = menuBttn.position.x + menuBttn.size.width / 2 + life1.size.width / 2 + 10
		var srartX:CGFloat = 0
		
		for (_, life) in lifesArr.enumerated() {
			life.position = CGPoint(x: srartX, y: 0)
			lifesContainer.addChild(life)
			life.zPosition = 100
			srartX += life.size.width + 5
		}
		lifesContainer.position = CGPoint(x: UIScreen.main.bounds.width - lifesContainer.calculateAccumulatedFrame().width + 10, y: menuBttn.position.y)
	}
	
	
	
	
	
	public func updateLives(totalLives: Int) {
		
		for (index, node) in livesArr.enumerated(){
			
			if (totalLives >= index + 1){
				node.run(SKAction.fadeAlpha(to: 1, duration: 0.4))
			}
			else {
				node.run(SKAction.fadeAlpha(to: 0.1, duration: 0.4))
			}
			
		}
	}
	
	
	

}






























