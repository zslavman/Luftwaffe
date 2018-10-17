//
//  Shot.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 10.10.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import SpriteKit

class Shot: SKSpriteNode {

	private let initialSize = CGSize(width: 187, height: 237)
	private let textureAtlas: SKTextureAtlas!
	private var animationSpriteArray:[SKTexture] = []
//	private var textureBeginName = "" // начальное имя текстуры
	private let screenSize = UIScreen.main.bounds
	
	init(textureAtlas:SKTextureAtlas){
		self.textureAtlas = textureAtlas
		let textureName = textureAtlas.textureNames.sorted()[0]
		let texture = textureAtlas.textureNamed(textureName)
//		textureBeginName = String(textureName.dropLast(6)) // отбрасываем от имени последние 6 симоволов "...xx.png"
		
		super.init(texture: texture, color: .red, size: initialSize)
		self.setScale(0.4)
		
		self.name = "shotSprite"
		self.zPosition = 30
		
		self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
		self.physicsBody?.isDynamic = false
		self.physicsBody?.categoryBitMask = BitMaskCategory.SHOT.rawValue
		self.physicsBody?.collisionBitMask = BitMaskCategory.ENEMY.rawValue
		self.physicsBody?.contactTestBitMask = BitMaskCategory.ENEMY.rawValue
		
		startMovement()
	}
	
	
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	
	
	
	
	private func startMovement(){
		
		performRotation()
		let moveForward = SKAction.moveTo(y: screenSize.height + 100, duration: 2)
		let removeAct = SKAction.removeFromParent()
		let seq = SKAction.sequence([moveForward, removeAct])
		
		run(seq)
	}
	
	
	
	
	
	private func performRotation(){
		
//		for i in 1...32 { // кадров анимации
//			let number = String(format: "%02d", i)
//			let texture = SKTexture(imageNamed: textureBeginName + number)
//			animationSpriteArray.append(texture)
//		}
		
		let textureNamesArray = textureAtlas.textureNames.sorted()
		
		for (_, name) in textureNamesArray.enumerated() {
			let texture = SKTexture(imageNamed: name)
			animationSpriteArray.append(texture)
		}

		let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.04, resize: true, restore: false)
		let revers_rot = SKAction.reversed(rotation)
		let loop = SKAction.repeatForever(revers_rot())
		
		run(loop)
	}
		
		
}




