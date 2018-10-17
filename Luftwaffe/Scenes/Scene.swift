//
//  GameScene.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 29.09.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import SpriteKit
import GameplayKit



class Scene: ParentScene {
    
	public var player:Plane!
	public var hud:HUD!
	private var lives = 3
	private var gameOverFlag:Bool = false
	
	private var backMusic:SKAudioNode!
	
	
    override func didMove(to view: SKView) {
		
		if Settings.isMusic && backMusic == nil{
			if let musicURL = Bundle.main.url(forResource: "backgroundMusic", withExtension: "m4a") {
				backMusic = SKAudioNode(url: musicURL)
				backMusic.run(SKAction.changeVolume(to: Float(0.01), duration: 0))
				// т.к. в звук невозможно изменить громкость звука мгновенно и в начале слышна полная громкость, делаем задержку
				let wait = SKAction.wait(forDuration: 0.4)
				let doIt = SKAction.run {
					self.addChild(self.backMusic)
				}
				let seq = SKAction.sequence([wait, doIt])
				run(seq)
			}
		}
		else if !Settings.isMusic && backMusic != nil { // вырубаем музыку если она есть
			backMusic.removeFromParent()
		}
		
		

		// снимаем с паузы, если возвращаемся сюда из экрана паузы
		isPaused = false
		
		// проверяем существует ли сцена
		guard sceneManager.gameScene == nil else{ return }
		
		// после первой загрузки сохраняем сцену
		sceneManager.gameScene = self
		
		physicsWorld.contactDelegate = self
		physicsWorld.gravity = CGVector.zero
		
		prepareStartScene()
		spawnClouds()
		spawnIslands()
		
		hud = HUD()
		addChild(hud)

		
		// делаем небольшую задержку для устранения бага с недогруженными текстурами
//		let pauseTime = DispatchTime.now() + .nanoseconds(1)
//		DispatchQueue.main.asyncAfter(deadline: pauseTime) {
//			[unowned self] in
//			self.player.performFly()
//		}
		
		player.performFly()
		
		spawnEnemies()
		spawnPowerUp()
		
	}

	

	
	/// Создаем бонусы
	private func spawnPowerUp(){
		
		let spawnAct = SKAction.run {
			let randomNum = Int(arc4random_uniform(2))
			let powerUp = (randomNum == 1) ? BluePowerUp() : GreenPowerUp()
			let randomX = arc4random_uniform(UInt32(self.size.width - 30))
			
			powerUp.position = CGPoint(x: CGFloat(randomX), y: self.size.height + 100)
			self.addChild(powerUp)
		}
		let randomTime = Double(arc4random_uniform(10) + 10)
		let waitAct = SKAction.wait(forDuration: randomTime)
		
		self.run(SKAction.repeatForever(SKAction.sequence([spawnAct, waitAct])))
	}
	
	
	
	
	private func spawnEnemies(){
		
		let wait = SKAction.wait(forDuration: 3.0)
		let spawnAct = SKAction.run {
			[unowned self] in
			self.spawnSpiralOfEnemies()
		}
		self.run(SKAction.repeatForever(SKAction.sequence([wait, spawnAct])))
	}
	
	
	
	
	
	
	
	
	/// Спавним врагов
	private func spawnSpiralOfEnemies(){
		
		let enemyTextureAtlas1 = Assets.share.atlas_Enemy_1 // SKTextureAtlas(named: "Enemy_1")
		let enemyTextureAtlas2 = Assets.share.atlas_Enemy_2
		
		SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas1, enemyTextureAtlas2]) {
			[unowned self] in
			
			let arrayOfAtlases = [enemyTextureAtlas1, enemyTextureAtlas2]
			
			let textureAtlas = Scene.randArrElemen(array: arrayOfAtlases)
			let waitAct = SKAction.wait(forDuration: 1.0)
			
			let spawnEnemy = SKAction.run({
				[unowned self] in
				// т.к. textureAtlas.textureNames возвращает несортированный массив, его нужно сортировать
				var textureNames:[String] = textureAtlas.textureNames
				textureNames = textureNames.sorted()
				
//				let textureName:String = textureNames[12] // используем имя 12-го элемента массива
				let textureName:String = Scene.randArrElemen(array: textureNames) // используе рандомную(из его анимаций) текстуру врага
				
				let enemy = Enemy(enemyTexture: textureAtlas.textureNamed(textureName))
				enemy.position = CGPoint(x: self.size.width/2, y: self.size.height + 110)
				self.addChild(enemy)
			})
			
			let seq = SKAction.sequence([spawnEnemy, waitAct])
			let loop = SKAction.repeat(seq, count: Scene.random(1, 2))
			
			self.run(loop)
		}
	}
	
	
	
	
	
	/// Спавним тучи
	private func spawnClouds() {
		let spawnWait = SKAction.wait(forDuration: 3)
		let spawnAction = SKAction.run {
			let cloud = Cloud.populate(at: nil)
			self.addChild(cloud)
		}
		
		let sequence = SKAction.sequence([spawnWait, spawnAction])
		let loop = SKAction.repeatForever(sequence)
		run(loop)
	}
	
	
	
	/// Спавним островки
	private func spawnIslands() {
		let spawnWait = SKAction.wait(forDuration: 2)
		let spawnAction = SKAction.run {
			let island = Island.populate(at: nil)
			self.addChild(island)
		}
		
		let sequence = SKAction.sequence([spawnWait, spawnAction])
		let loop = SKAction.repeatForever(sequence)
		run(loop)
	}
	
	
	
	
	
	
	/// Подготовка сцены, создание игрока
	private func prepareStartScene(){
		
		let screenCenterPoint = CGPoint(x: self.frame.midX, y: self.frame.midY)
		let backgroung = Background.populateBackground(at: screenCenterPoint)
		addChild(backgroung)
		
		// в начале игры острова будут в заданных координатах, потом - рандомные
		let island1 = Island.populate(at: CGPoint(x: 100, y: 200))
		addChild(island1)
		
		let island2 = Island.populate(at: CGPoint(x: self.size.width - 100, y: self.size.height - 200))
		addChild(island2)
		
		player = Plane.populate(at: CGPoint(x: screenCenterPoint.x, y: 100))
		addChild(player)
	}
	
	
	
	override func didSimulatePhysics() {
		
		player.checkPosition()
		
		enumerateChildNodes(withName: "powerUp") {
			(node, stop) in
			if node.position.y <= -100 {
				node.removeFromParent()
				
				// проверяем, если объект имееет в своей иерархии класс PowerUp
				if node.isKind(of: PowerUp.self){
//					print("PowerUp удален со сцены")
				}
			}
		}
	}
	
	
	
	
	
	
	private func playerFire(){
		
		let shot = YellowShot()
		shot.position = player.position
		addChild(shot)
		
	}
	
		
	/// клик по значку конфига на рабочем экране (аля пауза)
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		// находим координаты точки касания
		let location = touches.first!.location(in: self)
		// находим объект под точкой касания
		let node = atPoint(location)
		
		if node.name == "pause" {
			let transition = SKTransition.doorsCloseHorizontal(withDuration: 0.3)
			let pauseScene = PauseScene(size: self.size) // размер контроллера куда переходим должен занимать такой же размер как и эта сцена
			// как должна отображаться сцена
			pauseScene.scaleMode = .aspectFill
			
			// обновляем состояние сцены, сохраненной в менеджере сцен
			sceneManager.gameScene = self
			isPaused = true

			self.scene!.view!.presentScene(pauseScene, transition: transition)
		}
		else {
			playerFire()
		}
			
	}
	
	
	

	/// Возвращает рандомное число между min и max
	///
	/// - Parameters:
	///   - min: минимальное значение
	///   - max: максимальное значение
	public static func random(_ min: Int, _ max: Int) -> Int {
		guard min < max else {return min}
		return Int(arc4random_uniform(UInt32(1 + max - min))) + min
	}
	
	public static func random(_ min: Double, _ max: Double) -> Double {
		return (Double(arc4random()) / 0xFFFFFFFF) * (max - min) + min
	}
	
	
	/// Возвращает рандомный элемент массива
	///
	/// - Parameter arr: массив
	public static func randArrElemen<T>(array arr:Array<T>) -> T{
		
		let randomIndex = Int(arc4random_uniform(UInt32(arr.count)))
		return arr[randomIndex]
	}
	
}



extension Scene: SKPhysicsContactDelegate {
	
	
	
	// начало столкновения
	func didBegin(_ contact: SKPhysicsContact) {
		
		let bodies:Array = [contact.bodyA, contact.bodyB]
		let contactCategory:BitMaskCategory = [contact.bodyA.category, contact.bodyB.category] // category - из расширения

		// на реальных устройтвах бывают странные косания, между телом и nil!!
		if (contact.bodyA.node == nil || contact.bodyB.node == nil){
			return
		}

		switch contactCategory {
		case [.ENEMY, .PLAYER]:
			for item in bodies {
				if (item.node?.name != "personage"){
					item.category = BitMaskCategory.NONE
					smallExplosion(tar: item.node!)
					break
				}
			}
			playSound(soundName: "enemy_down")
			updLives(count: -1)

		case [.POWER_UP, .PLAYER]:
			for item in bodies {
				if (item.node?.name != "personage"){
					item.categoryBitMask = BitMaskCategory.NONE.rawValue
					item.node?.removeAllActions()
					item.node?.removeFromParent()
					break
				}
			}
			playSound(soundName: "take_bonus")
			updLives(count: 1)

		case [.SHOT, .ENEMY]:
			for item in bodies {
				if item.node?.name == "sprite"{ // если это враг
					item.categoryBitMask = BitMaskCategory.NONE.rawValue
					smallExplosion(tar: item.node!, shotDown: true)
					continue
				}
				item.node!.removeFromParent()
			}
			hud.score += 5
			playSound(soundName: "enemy_down")
			
		default:
			()
//			print("Невозможно установить сигнатуру маски")
//			preconditionFailure("Невозможно установить сигнатуру маски")
		
		}
	}
	
	
	
	
	
	private func playSound(soundName:String){
		
		guard Settings.isSound else { return }
		run(SKAction.playSoundFileNamed(soundName, waitForCompletion: false))
	}
	
	
	
	
	private func updLives(count:Int){
		
		if gameOverFlag {
			return
		}
		lives += count
		
		if lives > 3 {
			lives = 3
			return
		}
		if lives <= 0 {
			gameOverFlag = true
			
			// сохраняем результат в "Лучшие результаты"
			settings.currentScore = hud.score
			settings.saveScores()
			
			let waitAction = SKAction.wait(forDuration: 0.5)
			let gameoverAction = SKAction.run {
				let transition = SKTransition.crossFade(withDuration: 0.3)
				let gameOverScene = GameOverScene(size: self.size)
				gameOverScene.scaleMode = .aspectFill
				self.scene!.view!.presentScene(gameOverScene, transition: transition)
			}
			let seq = SKAction.sequence([waitAction, gameoverAction])
			run(seq)
		}
		hud.updateLives(totalLives: lives)
	}
	
	
	
	
	
	
	func didEnd(_ contact: SKPhysicsContact) {
		
	}
	
	
	private func smallExplosion(tar:SKNode, shotDown:Bool = false){
		
		if let explosionFile = Bundle.main.path(forResource: "FireParticles", ofType: "sks"){
			let explosion = NSKeyedUnarchiver.unarchiveObject(withFile: explosionFile) as! SKEmitterNode
			explosion.setScale(0.4)
			if shotDown {
				explosion.yAcceleration = -4000
				explosion.numParticlesToEmit = 100
				explosion.particleScaleSpeed = -1
			}
			addChild(explosion)
			explosion.position = tar.position
			tar.removeFromParent()
			
			let fade = SKAction.fadeIn(withDuration: 0.4)
			let remove = SKAction.removeFromParent()
			
			let seq = SKAction.sequence([fade, remove])
			explosion.run(seq)
		}
	}
	
	
}















