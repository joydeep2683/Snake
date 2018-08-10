//
//  GameManager.swift
//  Snake
//
//  Created by Joydeep on 09/08/18.
//  Copyright © 2018 Joydeep. All rights reserved.
//

import Foundation
import SpriteKit

class GameManager {
    var scene : GameScene!
    
    init(scene : GameScene) {
        self.scene = scene
    }
    
    func initGame(){
        scene.playerPosition.append((10, 10))
        scene.playerPosition.append((10, 11))
        scene.playerPosition.append((10, 12))
        renderChange()
    }
    
    func renderChange(){
        for (node, row, column) in scene.gameArray{
            if contains(a: scene.playerPosition, v: (row, column)){
                node.fillColor = SKColor.cyan
            } else{
                node.fillColor = SKColor.clear
            }
        }
    }
    
    func contains(a : [(Int, Int)], v : (Int, Int)) -> Bool {
        let (c1, c2) = v
        for (v1, v2) in a {
            if v1 == c1 && v2 == c2 {
                return true
            }
        }
        return false
    }
}
