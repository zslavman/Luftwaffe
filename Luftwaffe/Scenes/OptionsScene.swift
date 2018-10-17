//
//  OptionsScene.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 12.10.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import SpriteKit

class OptionsScene: ParentScene {
	

	var tip_TF:SKLabelNode!
	let tipsArr = ["Background music:", "Sound effects:", " ON", " OFF"]

	override func didMove(to view: SKView) {
		
		setHeader(withName: "options", andBackground: "header_background")
		
		let texture1 = Settings.isMusic ? "music" : "music_mute"
		let texture2 = Settings.isSound ? "sound" : "sound_mute"
		
		// кортеж (тапл)
		// 0: текст кнопки,
		// 1: текстура,
		// 2: смещение по Х,
		// 3: смещение по Y,
		// 4: имя кнопки
		let cortege = [("", texture1, -50, 0, "music"), ("", texture2, 50, 0, "sound"), ("back", "button_background", 0, -100, "back")]
		
		// рисуем 3 кнопки: "музыка", "звук", "возврат на предыдущий экран"
		for (_, settings) in cortege.enumerated(){
			let bttn = ButtonNode(titled: settings.0, backgroundName: settings.1)
			bttn.position = CGPoint(x: Int(self.frame.midX) + settings.2, y: Int(self.frame.midY) + settings.3)
			bttn.name = settings.4
			bttn.label.isHidden = settings.0 == "" ? true : false
			if !bttn.label.isHidden {
				bttn.label.name = settings.4
			}
			addChild(bttn)
		}
		
		// поле подсказки
		tip_TF = SKLabelNode(text: "")
		tip_TF.fontColor = #colorLiteral(red: 0.8392156863, green: 0.8745098039, blue: 0.8274509804, alpha: 1)
		tip_TF.fontName = "AppleSDGothicNeo-Bold"
		tip_TF.fontSize = 23
		tip_TF.horizontalAlignmentMode = .center
		tip_TF.verticalAlignmentMode = .center
		tip_TF.zPosition = 2
		tip_TF.alpha = 0
		tip_TF.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 80)
		if #available(iOS 11.0, *) {
			tip_TF.lineBreakMode = .byWordWrapping
		}
		addChild(tip_TF)
	}

	
	
	
	
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let location = touches.first!.location(in: self)
		let node = atPoint(location)
		
		if node.name == "music" {
			Settings.isMusic = !Settings.isMusic
			changeButtonState(node: node as! SKSpriteNode, value: Settings.isMusic)
			showTip(tipText: tipsArr[0], flag: Settings.isMusic)
		}
		else if node.name == "sound" {
			Settings.isSound = !Settings.isSound
			changeButtonState(node: node as! SKSpriteNode, value: Settings.isSound)
			showTip(tipText: tipsArr[1], flag: Settings.isSound)
		}
		else if node.name == "back"{
			let transition = SKTransition.push(with: .right, duration: 0.3)
			guard let backScene = backScene else { return }
			backScene.scaleMode = .aspectFill
			self.scene!.view?.presentScene(backScene, transition: transition)
		}
	}
	
	
	
	private func changeButtonState(node:SKSpriteNode, value:Bool){
		if let name = node.name{
			node.texture = value ? SKTexture(imageNamed: name) : SKTexture(imageNamed: name + "_mute")
		}
		// показываем подсказку
		
		
		// сохраняем настройки звука
		settings.saveGameSettings()
	}
	
	
	
	private func showTip(tipText:String, flag:Bool){
		
		var str:String = tipText + (flag ? tipsArr[2] : tipsArr[3])
		
		tip_TF.removeAction(forKey: "fader")
		tip_TF.alpha = 0
		tip_TF.text = str
		
		if #available(iOS 11.0, *) {} else {
			var enter:Bool = false
			while tip_TF.calculateAccumulatedFrame().width >= self.frame.width - 30 {
				enter = true
				str = String(str.dropLast())
				tip_TF.text = str
			}
			if enter {
				tip_TF.text?.append("...")
			}
		}
		
		let fadeIn = SKAction.fadeIn(withDuration: 0.3)
		let wait = SKAction.wait(forDuration: 1.3)
		let fadeOut = SKAction.fadeOut(withDuration: 0.6)
		
		let seq = SKAction.sequence([fadeIn, wait, fadeOut])
		
		tip_TF.run(seq, withKey: "fader")
	}
	
	
	
	
	
	
	
	
	
	
	
}








