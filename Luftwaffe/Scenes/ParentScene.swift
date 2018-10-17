//
//  ParentScene.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 12.10.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import SpriteKit

class ParentScene: SKScene {

	
	public let sceneManager = SceneManager.shared
	public var settings = Settings()
	// сцена для возврата "назад" в:
	// 1) главное меню
	// 2) экран паузы
	public var backScene:SKScene?
	
	
	override init(size: CGSize) {
		super.init(size: size)
		self.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
		
		let sceneOpened = String(describing: type(of: self))
		print("You opened: \(sceneOpened)")
	}
	
	
	convenience init(size: CGSize, backScene: SKScene) {
		self.init(size: size)
		self.backScene = backScene
	}
	
	
	
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	public func setHeader(withName name:String?, andBackground backgroungName:String){
		let header = ButtonNode(titled: name, backgroundName: backgroungName)
		header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
		addChild(header)
	}
	
	
}
