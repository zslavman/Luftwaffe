//
//  Enemy.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 01.10.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode {

	public static var textureAtlas:SKTextureAtlas?
	var enemyTexture: SKTexture!
	
	
	init(enemyTexture: SKTexture){
		self.enemyTexture = enemyTexture
//		let texture = Enemy.textureAtlas?.textureNamed("airplane_4ver2_13")
		let texture = enemyTexture
		super.init(texture: texture, color: .red, size: CGSize(width: 221, height: 204)) // размер картинки
		self.xScale = 0.4
		self.yScale = -0.4
		self.zPosition = 20
		self.name = "sprite"
		
		self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
		self.physicsBody?.isDynamic = true
		self.physicsBody?.categoryBitMask = BitMaskCategory.ENEMY.rawValue
		self.physicsBody?.collisionBitMask = BitMaskCategory.NONE.rawValue
		self.physicsBody?.contactTestBitMask = BitMaskCategory.PLAYER.rawValue | BitMaskCategory.SHOT.rawValue
		flySpiral()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	private func flySpiral(){
		
		let screenSize = UIScreen.main.bounds
		let horizontalTime:TimeInterval = 3 // время за которое враг пролетит всю ширину экрана
		let verticalTime:TimeInterval = 5 // время за которое враг пролетит всю ширину экрана
		
		let moveLeft = SKAction.moveTo(x: 50, duration: horizontalTime) // недолетит до ширины экрана на 50
		let moveRight = SKAction.moveTo(x: screenSize.width - 50 , duration: horizontalTime)
		moveLeft.timingMode = .easeInEaseOut
		moveRight.timingMode = .easeInEaseOut
		
		// рандом от 0 до указанного числа (верхняя граница не входит в диапазон)
		let randomNum = Int(arc4random_uniform(2))
		
		let asideMovmentSeq = (randomNum == EnemyDirection.left.rawValue) ? SKAction.sequence([moveLeft, moveRight]) : SKAction.sequence([moveRight, moveLeft])
		
		let asideLoop = SKAction.repeatForever(asideMovmentSeq)
		
		let forwardMovment = SKAction.moveTo(y: -105, duration: verticalTime)
		let kickAction = SKAction.removeFromParent()
		let forwardAct = SKAction.sequence([forwardMovment, kickAction])
		
		let groupMovment = SKAction.group([asideLoop, forwardAct]) // одновременное выполнение нескольких экшнов
		self.run(groupMovment)
		
	}
	
	

	
	
	
	
	
}




enum EnemyDirection:Int {
	case left = 0
	case right // = 1 присваивается автоматом, т.к. тип Int
}













