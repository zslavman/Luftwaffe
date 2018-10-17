//
//  Assets.swift
//  Luftwaffe
//
//  Created by Zinko Vyacheslav on 10.10.2018.
//  Copyright © 2018 Zinko Vyacheslav. All rights reserved.
//

import SpriteKit

class Assets {

	static let share = Assets()
	
	public var isLoaded:Bool = false
	
	public let atlas_YellowAmmo = SKTextureAtlas(named: "YellowAmmo")
	public let atlas_Enemy_1 = SKTextureAtlas(named: "Enemy_1")
	public let atlas_Enemy_2 = SKTextureAtlas(named: "Enemy_2")
	public let atlas_GreenPowerUp = SKTextureAtlas(named: "GreenPowerUp")
	public let atlas_BluePowerUp = SKTextureAtlas(named: "BluePowerUp")
	public let atlas_PlayerPlane = SKTextureAtlas(named: "PlayerPlane")
	
	private var allTextureCount = 0

	public var loaded:Int = 0 {
		didSet{
			let calc = Int(Double(loaded) / Double(allTextureCount) * 100)
			MainView.shared.scene.percentage = calc
		}
	}
	
	public func preloadAssets(){
		
//		let fileName = "Enemy_1"
//		let fileType = "atlas"
//		let filesSubDirectory = "Atlases/"
//
//		if let gortex = Bundle.main.path(forAuxiliaryExecutable: fileName){
//			print(gortex)
//		}
//		if let path = Bundle.main.path(forResource: fileName, ofType: fileType, inDirectory: filesSubDirectory){
//			print(path)
//		}
		
		
		let array = [atlas_YellowAmmo, atlas_Enemy_1, atlas_Enemy_2, atlas_GreenPowerUp, atlas_BluePowerUp, atlas_PlayerPlane]
		
		for item in array {
			allTextureCount += item.textureNames.count
		}
		
		
		DispatchQueue.main.async { // если без асинхронного потока - иногда вылетает ошибка при загрузке атласов
			self.atlas_YellowAmmo.preload {
//				print("preloaded: atlas_YellowAmmo")
				self.loaded += self.atlas_YellowAmmo.textureNames.count
			}
			self.atlas_Enemy_1.preload {
//				print("preloaded: atlas_Enemy_1")
				self.loaded += self.atlas_Enemy_1.textureNames.count
			}
			self.atlas_Enemy_2.preload {
//				print("preloaded: atlas_Enemy_2")
				self.loaded += self.atlas_Enemy_2.textureNames.count
			}
			self.atlas_GreenPowerUp.preload {
//				print("preloaded: atlas_GreenPowerUp")
				self.loaded += self.atlas_GreenPowerUp.textureNames.count
			}
			self.atlas_BluePowerUp.preload {
//				print("preloaded: atlas_BluePowerUp")
				self.loaded += self.atlas_BluePowerUp.textureNames.count
			}
			self.atlas_PlayerPlane.preload {
//				print("preloaded: atlas_PlayerPlane")
				self.loaded += self.atlas_PlayerPlane.textureNames.count
			}
		}
	}
	
	
	
	

	
	
	func fileSize(fromPath path: String) -> String? {
		guard let size = try? FileManager.default.attributesOfItem(atPath: path)[FileAttributeKey.size],
			let fileSize = size as? UInt64 else {
				return nil
		}
		
		if fileSize < 1023 {
			return String(format: "%lu bytes", CUnsignedLong(fileSize))
		}
		var floatSize = Float(fileSize / 1024)
		if floatSize < 1023 {
			return String(format: "%.1f KB", floatSize)
		}
		floatSize = floatSize / 1024
		if floatSize < 1023 {
			return String(format: "%.1f MB", floatSize)
		}
		floatSize = floatSize / 1024
		return String(format: "%.1f GB", floatSize)
	}
	
	
	
	
	
	
	
	
	
	
	
}













