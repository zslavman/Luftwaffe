//
//  YellowShot.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 10.10.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import SpriteKit

class YellowShot: Shot {

	init(){
		let textureAtlas = Assets.share.atlas_YellowAmmo // SKTextureAtlas(named: "YellowAmmo")
		super.init(textureAtlas: textureAtlas)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
