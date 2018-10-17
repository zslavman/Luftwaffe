//
//  ButtonNode.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 12.10.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import SpriteKit

class ButtonNode: SKSpriteNode {

	
	public let label:SKLabelNode = {
//		let l = SKLabelNode(text: "whatever")
		let l = SKLabelNode(text: "")
		l.fontColor = #colorLiteral(red: 0.8392156863, green: 0.8745098039, blue: 0.8274509804, alpha: 1)
//		l.fontName = "AppleSDGothicNeo-Bold"
		l.fontName = "AmericanTypeWriter-Bold"
		l.fontSize = 30
		l.horizontalAlignmentMode = .center
		l.verticalAlignmentMode = .center
		l.zPosition = 2
		return l
	}()
	
	init(titled title:String?, backgroundName:String){
		let texture = SKTexture(imageNamed: backgroundName)
		super.init(texture: texture, color: .red, size: texture.size())
		if let title = title {
			label.text = title.uppercased()
		}
		addChild(label)
	}
	
	
	
	
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	
	
	
}
