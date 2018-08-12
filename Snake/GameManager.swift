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
    var nextTime : Double?
    var timeExtension : Double = 0.15
    var playerDirection : Int = 4
    
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
    
    func update(time : Double){
        if nextTime == nil {
            nextTime = time + timeExtension
        } else if time >= nextTime! {
            nextTime = time + timeExtension
            
            updatePlayerPosition()
        }
        
    }
    
    private func updatePlayerPosition(){
        var xChange = -1
        var yChange = 0
        
        switch playerDirection {
        case 1:
            // Left
            xChange = -1
            yChange = 0
            break
        case 2:
            // Right
            xChange = 1
            yChange = 0
        case 3:
            // Up
            xChange = 0
            yChange = -1
        case 4:
            // Down
            xChange = 0
            yChange = 1
        default:
            break
        }
        
        if scene.playerPosition.count > 0 {
            var start = scene.playerPosition.count - 1
            while start > 0 {
                scene.playerPosition[start] = scene.playerPosition[start - 1]
                start -= 1
            }
            scene.playerPosition[0] = (scene.playerPosition[0].0 + yChange, scene.playerPosition[0].1 + xChange)
        }
        renderChange()
        
        if scene.playerPosition.count > 0 {
            let x = scene.playerPosition[0].1
            let y = scene.playerPosition[0].0
            
            if y > 40 {
                scene.playerPosition[0].0 = 0
            } else if y < 0 {
                scene.playerPosition[0].0 = 40
            } else if x > 20 {
                scene.playerPosition[0].1 = 0
            } else if x < 0 {
                scene.playerPosition[0].1 = 20
            }
        }
    }
    func swipe(ID : Int){
        if !(ID == 1 && playerDirection == 2) && !(ID == 2 && playerDirection == 1){
            if !(ID == 3 && playerDirection == 4) && !(ID == 4 && playerDirection == 3){
                playerDirection = ID
            }
        }
    }
}
