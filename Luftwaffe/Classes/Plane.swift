//
//  Plane.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 29.09.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import SpriteKit
import CoreMotion

class Plane: SKSpriteNode {
	
	private let motionManager = CMMotionManager()
	private var xAcceleration:CGFloat = 0
	private let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
	
	private var left_textureArrayAnim:[SKTexture] = []
	private var right_textureArrayAnim:[SKTexture] = []
	private var forward_textureArrayAnim:[SKTexture] = []
	private let animationStrides = [(13, 1, -1), (13, 26, 1), (13, 13, 1)] // настройки загрузки анимации из атласа
	
	private var moveDirection:TurnDirection = .none
	private var stillTurning:Bool = false // начался ли уже поворот
	
	
	
	
	/// Создаем самолет
	static func populate(at point:CGPoint) -> Plane{
		let planTexture:SKTexture = Assets.share.atlas_PlayerPlane.textureNamed("airplane_3ver2_13")
		// т.к. Plane наследуется от SKSpriteNode, можно использовать его инициализаторы
		let plane = Plane(texture: planTexture)
		plane.setScale(0.4)
		
		plane.position = point
		plane.zPosition = 40
		plane.name = "personage"
		
		// создание физического тела с помощью CGPath (http://insyncapp.net/SKPhysicsBodyPathGenerator.html)
//		let offsetX = plane.frame.size.width * plane.anchorPoint.x
//		let offsetY = plane.frame.size.height * plane.anchorPoint.y
//
//		let path = CGMutablePath()
//		path.move(to: CGPoint(x: 7 - offsetX, y: 75 - offsetY))
//		path.addLine(to: CGPoint(x: 64 - offsetX, y: 84 - offsetY))
//		path.addLine(to: CGPoint(x: 70 - offsetX, y: 98 - offsetY))
//		path.addLine(to: CGPoint(x: 79 - offsetX, y: 99 - offsetY))
//		path.addLine(to: CGPoint(x: 84 - offsetX, y: 85 - offsetY))
//		path.addLine(to: CGPoint(x: 141 - offsetX, y: 75 - offsetY))
//		path.addLine(to: CGPoint(x: 141 - offsetX, y: 66 - offsetY))
//		path.addLine(to: CGPoint(x: 85 - offsetX, y: 57 - offsetY))
//		path.addLine(to: CGPoint(x: 8 - offsetX, y: 64 - offsetY))
//		path.closeSubpath()
//		plane.physicsBody = SKPhysicsBody(polygonFrom: path)
		//-----------------------------------------------------
		
		
		plane.physicsBody = SKPhysicsBody(texture: planTexture, alphaThreshold: 0.5, size: plane.size)
		plane.physicsBody?.isDynamic = false
		plane.physicsBody?.categoryBitMask = BitMaskCategory.PLAYER.rawValue
		plane.physicsBody?.collisionBitMask = BitMaskCategory.ENEMY.rawValue | BitMaskCategory.POWER_UP.rawValue
		plane.physicsBody?.contactTestBitMask = BitMaskCategory.ENEMY.rawValue | BitMaskCategory.POWER_UP.rawValue
		return plane
	}
	
	
	
	
	
	public func performFly(){
		
		fillTexturesArray()
		motionManager.accelerometerUpdateInterval = 0.2
		motionManager.startAccelerometerUpdates(to: OperationQueue.current!) {
			[unowned self] (data, error) in
			guard error == nil else { return }
			
			if let data = data {
				let acceleration = data.acceleration
				//				self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
				self.xAcceleration = CGFloat(acceleration.x) * 0.4 + self.xAcceleration * 0.2
			}
		}
		
		
		// запускаем переодично проверку на переключение анимации
		let planeWaitAct = SKAction.wait(forDuration: 1.0)
		let planeDirectionCheckAct = SKAction.run {
			[unowned self] in
			self.movementDirectionCheck()
		}
		let sequance = SKAction.sequence([planeWaitAct, planeDirectionCheckAct])
		let loop = SKAction.repeatForever(sequance)
		run(loop)
	}
	
	
	
	
	public func checkPosition(){
		
		self.position.x += xAcceleration * 50
		
		if self.position.x < -70 {
			self.position.x = screenSize.width + 70
		}
		else if self.position.x > screenSize.width + 70 {
			self.position.x = -70
		}
	}
	
	
	
	
	
	/// заполняем массивы анимаций текстурами (Часть 1)
	private func fillTexturesArray(){
		
		for i in 0...animationStrides.count - 1 {
			preloadArray(_stride: animationStrides[i]) {
				[unowned self] array in
				switch i {
				case 0: self.left_textureArrayAnim = array
				case 1: self.right_textureArrayAnim = array
				case 2: self.forward_textureArrayAnim = array
				default: ()
				}
			}
		}
	}

	/// заполняем массивы анимаций текстурами (Часть 2)
	private func preloadArray(_stride:(Int, Int, Int), callback: @escaping(_ array:[SKTexture]) -> Void){
		
		var tempArr: [SKTexture] = []
		
		// stride - умный перебор - перебираем от 13 до 1 с шагом -1
		for i in stride(from: _stride.0, through: _stride.1, by: _stride.2){
			let number = String(format: "%02d", i)
			let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
			tempArr.append(texture)
		}
		SKTexture.preload(tempArr) {
			callback(tempArr)
		}
	}
	
	
	

	
	
	
	
	
	/// определение направления полета (кадров анимации)
	private func movementDirectionCheck(){
		
		// вправо
		// если наклоняем телефон вправо, если еще не выполнили этот поворот, если уже начали поворот - не прерываем его
		if xAcceleration > 0.015, moveDirection != .right, !stillTurning {
			stillTurning = true
			moveDirection = .right
			turnPlane(direction: .right)
		}
			// влево
		else if xAcceleration < -0.015, moveDirection != .left, !stillTurning {
			stillTurning = true
			moveDirection = .left
			turnPlane(direction: .left)
		}
			// прямо
		else if !stillTurning {
			turnPlane(direction: .none)
		}
	}
	
	
	
	
	
	/// сама анимация поворота полета
	private func turnPlane(direction: TurnDirection){
		var tempArray:[SKTexture] = []
		
		if direction == .right {
			tempArray = right_textureArrayAnim
		}
		else if direction == .left {
			tempArray = left_textureArrayAnim
		}
		else {
			tempArray = forward_textureArrayAnim
		}
		
		let forwardAct = SKAction.animate(with: tempArray, timePerFrame: 0.025, resize: true, restore: false)
		let backwardAct = SKAction.animate(with: tempArray.reversed(), timePerFrame: 0.025, resize: true, restore: false)
		
		let sequanse = SKAction.sequence([forwardAct, backwardAct])
		run(sequanse) {
			// чтоб цыкл сильных ссылок не создавался, напишем лист захвата (self не может быть nil)
			[unowned self] in
			self.stillTurning = false
		}
	}
	
	
	
	
	
	
	
	/// заполняем массивы анимаций текстурами
	//	private func planeAnimFillArray(){
	//
	//		// подгружаем атлас в память, PlayerPlane - имя папки-атласа
	//		SKTextureAtlas.preloadTextureAtlases([SKTextureAtlas(named: "PlayerPlane")]) {
	//			// значение массива - то что возвращается с клоужера
	//
	//			//*****************
	//			//  Поворот влево *
	//			//*****************
	//			self.left_textureArrayAnim = {
	//
	//				var array:[SKTexture] = []
	//				// stride - умный перебор - перебираем от 13 до 1 с шагом -1
	//				for i in stride(from: 13, through: 1, by: -1){
	//					let number = String(format: "%02d", i)
	//					let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
	//					array.append(texture)
	//				}
	//				return array
	//			}()
	//
	//
	//			//*****************
	//			// Поворот вправо *
	//			//*****************
	//			self.right_textureArrayAnim = {
	//
	//				var array:[SKTexture] = []
	//				// stride - умный перебор - перебираем от 13 до 1 с шагом -1
	//				for i in stride(from: 13, through: 26, by: 1){
	//					let number = String(format: "%02d", i)
	//					let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
	//					array.append(texture)
	//				}
	//				return array
	//			}()
	//
	//			//******************
	//			//  Нормальный вид *
	//			//******************
	//			self.forward_textureArrayAnim = {
	//				var array:[SKTexture] = []
	//				let texture = SKTexture(imageNamed: "airplane_3ver2_13")
	//				array.append(texture)
	//
	//				return array
	//			}()
	//
	//		}
	//	}
	
}




enum TurnDirection {
	case left
	case right
	case none
}



















