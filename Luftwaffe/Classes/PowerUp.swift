//
//  PoweUp.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 01.10.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//



import SpriteKit



class PowerUp: SKSpriteNode {

	private let initialSize = CGSize(width: 52, height: 52)
	private let textureAtlas: SKTextureAtlas!
	private var animationSpriteArray:[SKTexture] = []
	private var textureBeginName = "" // начальное имя текстуры
	
	init(textureAtlas:SKTextureAtlas){
		self.textureAtlas = textureAtlas
		let textureName = textureAtlas.textureNames.sorted()[0]
		let texture = textureAtlas.textureNamed(textureName)
//		textureBeginName = String(textureName.dropLast(6)) // отбрасываем от имени последние 6 симоволов "...xx.png"
		
		super.init(texture: texture, color: .red, size: initialSize)
		self.setScale(0.7)
		
		self.name = "powerUp"
		self.zPosition = 20
		
		self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
		self.physicsBody?.isDynamic = true
		self.physicsBody?.categoryBitMask = BitMaskCategory.POWER_UP.rawValue
		self.physicsBody?.collisionBitMask = BitMaskCategory.PLAYER.rawValue
		self.physicsBody?.contactTestBitMask = BitMaskCategory.PLAYER.rawValue
		
		startMovement()
	}
	
	
	
	
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	
	private func startMovement(){
		
		performRotation()
		let moveForward = SKAction.moveTo(y: -100, duration: 5)
		run(moveForward)
	}
	
	
	
	
	
	private func performRotation(){

		let textureNamesArray = textureAtlas.textureNames.sorted()
		
		for (_, name) in textureNamesArray.enumerated() {
			let texture = SKTexture(imageNamed: name)
			animationSpriteArray.append(texture)
		}
		
		// т.к. текстуры (атласы) уже предзагружены, можно их использовать без SKTexture.preload
		let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.08, resize: true, restore: false)
		let revers_rot = SKAction.reversed(rotation)
		let loop = SKAction.repeatForever(revers_rot())
		
		self.run(loop)
	}

	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
