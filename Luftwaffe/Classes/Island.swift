//
//  Island.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 29.09.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import SpriteKit
import GameplayKit

final class Island: SKSpriteNode,BackgroundSpritable {

	public static func populate(at point:CGPoint?) -> Island{
		let textureNum = Scene.random(1, 4)
		let island = Island(imageNamed: "is" + "\(textureNum)")
		island.setScale(CGFloat(Scene.random(0.4, 1.0)))
		island.zPosition = 1
		if Scene.random(0, 1) == 1 {
			//			island.xScale = -1
		}
		island.name = "backSprite"
		island.position = point ?? randomPoint()
		island.run(rotateForRandomAngle())
		island.run(move(from: island.position))
		
		return island
	}
	
	
	
	
	
	
	
	private static func rotateForRandomAngle() -> SKAction{
		let distribution = GKRandomDistribution(lowestValue: 0, highestValue: 360)
		let randomNumber = CGFloat(distribution.nextInt())
		
		return SKAction.rotate(toAngle: randomNumber * CGFloat(Double.pi / 180), duration: 0)
	}
	
	
	
	
	private static func move(from point:CGPoint) -> SKAction{
		
		let movePoint = CGPoint(x: point.x, y: -200)
		let moveDistance = point.y + 200
		let movementSpeed:CGFloat = 100.0 //    поинтов / с
		let duration = moveDistance / movementSpeed

		let moveAction = SKAction.move(to: movePoint, duration: TimeInterval(duration))
		let removeAction = SKAction.removeFromParent()
		let sequance = SKAction.sequence([moveAction, removeAction])
		
		return sequance
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
