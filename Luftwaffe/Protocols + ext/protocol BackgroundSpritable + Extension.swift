//
//  protocol BackgroundSpritable.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 30.09.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import SpriteKit
import GameplayKit


protocol BackgroundSpritable {
	// Self - либо тип протокола либо тип класса (BackgroundSpritable / Cloud)
	static func populate(at point:CGPoint?) -> Self
	static func randomPoint() -> CGPoint
}

// т.к. нужно добавить один и тот же метод (randomPoint) в два класса, напишем расширение, которое добавит этот метод в Cloud и Island, потому что они подписаны под протокол BackgroundSpritable
extension BackgroundSpritable {
	static func randomPoint() -> CGPoint {
		let screen = UIScreen.main.bounds
		let destribution = GKRandomDistribution(lowestValue: Int(screen.size.height + 100), highestValue: Int(screen.size.height + 200))
		
		let y:CGFloat = CGFloat(destribution.nextInt())
		let x:CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
		
		return CGPoint(x: x, y: y)
	}
}



