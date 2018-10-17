//
//  Cloud.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 29.09.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//


import SpriteKit
import GameplayKit



// т.к. от класса Cloud можно унаследоваться и переопределить метод populateIsland, то он уже вернет не то что
// нужно, а это ломает концепцию протокола, потому ставим final
final class Cloud: SKSpriteNode, BackgroundSpritable {
	

	static func populate(at point:CGPoint?) -> Cloud{
		let textureNum = Scene.random(1, 3)
		let cloud = Cloud(imageNamed: "cl" + "\(textureNum)")
		cloud.setScale(CGFloat(Scene.random(2.0, 3.0)))
		cloud.zPosition = 10
		if Scene.random(0, 1) == 1 {
			//			island.xScale = -1
		}
		cloud.name = "backSprite"
		cloud.position = randomPoint()
		cloud.run(move(from: cloud.position))
		
		return cloud
	}
	
	
	
	
	private static func move(from point:CGPoint) -> SKAction{
		
		let movePoint = CGPoint(x: point.x, y: -200)
		let moveDistance = point.y + 200
		let movementSpeed:CGFloat = 150.0 //    поинтов / с
		let duration = moveDistance / movementSpeed
		
		let moveAction = SKAction.move(to: movePoint, duration: TimeInterval(duration))
		let removeAction = SKAction.removeFromParent()
		let sequance = SKAction.sequence([moveAction, removeAction])
		
		return sequance
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
