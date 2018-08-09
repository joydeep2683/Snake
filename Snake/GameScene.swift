//
//  GameScene.swift
//  Snake
//
//  Created by Joydeep on 09/08/18.
//  Copyright © 2018 Joydeep. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit //changed myself

class GameScene: SKScene {
    
    var gameLogo : SKLabelNode!
    var bestScore : SKLabelNode!
    var playButton : SKShapeNode!
    var game : GameManager!
    
    
        
    override func didMove(to view: SKView) {
        initializeMenu()
        game = GameManager()
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode{
                if node.name == "PlayButton"{
                    startGame()
                }
            }
        }
    }
    
    
    func initializeMenu(){
        
        // Create game title
        gameLogo = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        gameLogo.zPosition = 1
        gameLogo.position = CGPoint(x: 0.0, y: (view?.frame.size.width)!/3) //changed myself
        gameLogo.fontSize = 60
        gameLogo.text = "SNAKE"
        gameLogo.fontColor = UIColor.white //changed myself
        addChild(gameLogo)
        
        // Create best score label
        bestScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        bestScore.zPosition = 1
        bestScore.position = CGPoint(x: 0.0, y: gameLogo.position.y - 70)
        bestScore.fontSize = 40
        bestScore.text = "Best Score: 0"
        bestScore.fontColor = UIColor.white
        addChild(bestScore)
        
        // Create play button label
        playButton = SKShapeNode()
        playButton.name = "PlayButton"
        playButton.zPosition = 1
        playButton.position = CGPoint(x: 0.0, y: bestScore.position.y - 150)
        playButton.fillColor = SKColor.cyan
        let topCorner = CGPoint(x: -50.0, y: 50.0)
        let bottomCorner = CGPoint(x: -50.0, y: -50.0)
        let middle = CGPoint(x: 50.0, y: 0.0)
        let path = CGMutablePath()
        path.addLine(to: topCorner)
        path.addLines(between: [topCorner, middle, bottomCorner])
        playButton.path = path
        addChild(playButton)
    }
    
    private func startGame(){
        print("start game")
        // Remove logo by animation
        gameLogo.run(SKAction.move(by: CGVector(dx: 0.0, dy: 600.0), duration: 0.5)){
            self.gameLogo.isHidden = true
        }
        
        // Remove play button by animation
        playButton.run(SKAction.scale(to: 0.0, duration: 0.3)){
            self.playButton.isHidden = true
        }
        
        // Moved best score to bottom middle
        let bottomMiddle = CGPoint(x: 0.0, y: -frame.size.height/2 + 20)
        bestScore.run(SKAction.move(to: bottomMiddle, duration: 0.4))
    }
    
    
    
    
}
