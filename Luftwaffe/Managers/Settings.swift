//
//  Settings.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 15.10.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//


//struct DefaultsKey {
//
//	public static let musicKey:String = "musicKey"
//	public static let soundKey:String = "soundKey"
//}



import UIKit

class Settings: NSObject {
	
	let ud = UserDefaults.standard
	
	public static var isMusic = true
	public static var isSound = true
	private let musicKey = "music"
	private let soundKey = "sound"
	
	public var highscore: [Int] = []
	private let highscoreKey = "highscore"
	public var currentScore = 0
	
	
	override init() {
		super.init()
		
		loadGameSettings()
		loadScores()
	}
	
	
	public func saveScores(){
		// добавляем текущие очки
		highscore.append(currentScore)
		// сортируем в обратном порядке и оставляем только 3 лушчих результата
		highscore = Array(highscore.sorted{$0 > $1}.prefix(3))
		
		ud.set(highscore, forKey: highscoreKey)
		ud.synchronize()
	}
	
	public func loadScores(){
		
		if ud.value(forKey: highscoreKey) != nil{
			highscore = ud.array(forKey: highscoreKey) as! [Int]
		}
		
	}
	
	
	
	public func saveGameSettings(){
		ud.set(Settings.isMusic, forKey: musicKey)
		ud.set(Settings.isSound, forKey: soundKey)
	}
	
	private func loadGameSettings(){
		// проверяем ключи для первого запуска
		if ud.value(forKey: musicKey) != nil && ud.value(forKey: soundKey) != nil{
			Settings.isMusic = ud.bool(forKey: musicKey)
			Settings.isSound = ud.bool(forKey: soundKey)
		}
		
	}
	
	
	

}










