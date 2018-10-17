//
//  Background.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 29.09.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import SpriteKit

class Background: SKSpriteNode {
	
	
	/// Возвращает фон
	///
	/// - Parameter point: точка, относительно которой будет распологатся фон по центру
	public static func populateBackground(at point:CGPoint) -> Background{
		
//		let back = Background(imageNamed: "background")
		let back = Background(color: #colorLiteral(red: 0, green: 0.309272882, blue: 0.7013432781, alpha: 1), size: UIScreen.main.bounds.size)
		back.position = point
		return back
		
	}
	
	
	

}
