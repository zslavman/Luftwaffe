//
//  BluePowerUp.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 10.10.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import SpriteKit

class BluePowerUp: PowerUp {
	
	init(){
		let textureAtlas = Assets.share.atlas_BluePowerUp // SKTextureAtlas(named: "BluePowerUp")
		super.init(textureAtlas: textureAtlas)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
