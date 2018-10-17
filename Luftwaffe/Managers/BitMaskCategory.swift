//
//  BitMaskCategory.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 11.10.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import SpriteKit


extension SKPhysicsBody {
	
	var category:BitMaskCategory {
		get {
			return BitMaskCategory(rawValue: self.categoryBitMask)
		}
		set(newValue) {
			self.categoryBitMask = newValue.rawValue
		}
	}
}

struct BitMaskCategory : OptionSet {
	
	let rawValue: UInt32
	
	// можно не использовать инициализатор, т.к. он и так отрабатывает по дефолту
	//	init(rawValue: UInt32){
	//		self.rawValue = rawValue
	//	}
	
	public static let NONE 		= BitMaskCategory(rawValue: 0 << 0)
	public static let PLAYER 	= BitMaskCategory(rawValue: 1 << 0)
	public static let ENEMY 	= BitMaskCategory(rawValue: 1 << 1)
	public static let POWER_UP 	= BitMaskCategory(rawValue: 1 << 2)
	public static let SHOT 		= BitMaskCategory(rawValue: 1 << 3)
	
	public static let ALL		= BitMaskCategory(rawValue: UInt32.max)
	
	
//	public static let NONE 	: UInt32 	= 0		   // 000000...0000  или 0
//	public static let PLAYER: UInt32 	= 0x1 << 0 // 000000...0001  или 1
//	public static let ENEMY: UInt32 	= 0x1 << 1 // 000000...0010  или 2
//	public static let POWER_UP: UInt32 	= 0x1 << 2 // 000000...0100  или 4
//	public static let SHOT: UInt32 		= 0x1 << 3 // 000000...1000  или 8
	
}
