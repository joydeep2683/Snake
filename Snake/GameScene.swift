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
    var currentScore : SKLabelNode!
    var playerPosition : [(Int, Int)] = []
    var gameBackGround : SKShapeNode!
    var gameArray : [(node : SKShapeNode, row: Int, column: Int)] = []
    var scorePos : CGPoint?
    
    
        
    override func didMove(to view: SKView) {
        initializeMenu()
        game = GameManager(scene : self)
        initializeGameView()
        
        // Swipe gesture recognizer
        let swipeRight : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeR))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeL))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeUp : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeU))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeD))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    @objc func swipeL() {
        game.swipe(ID: 1)
    }
    @objc func swipeR() {
        game.swipe(ID: 2)
    }
    @objc func swipeU() {
        game.swipe(ID: 3)
    }
    @objc func swipeD() {
        game.swipe(ID: 4)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        game.update(time : currentTime)
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
        bestScore.run(SKAction.move(to: bottomMiddle, duration: 0.4)){
            self.gameBackGround.setScale(0)
            self.currentScore.setScale(0)
            self.gameBackGround.isHidden = false
            self.currentScore.isHidden = false
            self.gameBackGround.run(SKAction.scale(to: 1, duration: 0.4))
            self.currentScore.run(SKAction.scale(to: 1, duration: 0.4))
            self.game.initGame()
        }
    }
    
    private func initializeGameView(){
        // Create current score label
        currentScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        currentScore.zPosition = 1
        currentScore.position = CGPoint(x: 0.0, y: -frame.size.height/2 + 70)
        currentScore.fontSize = 40
        currentScore.isHidden = true
        currentScore.text = "Current Score: 0"
        currentScore.fontColor = UIColor.white
        addChild(currentScore)
        
        // Create a shapenode to represent our game's playable area
        let width = 550
        let height = 1100
        let rect = CGRect(x: -width/2, y: -height/2, width: width, height: height)
        gameBackGround = SKShapeNode(rect: rect, cornerRadius: 0.02)
        gameBackGround.fillColor = UIColor.lightGray
        gameBackGround.zPosition = 2
        gameBackGround.isHidden = true
        addChild(gameBackGround)
        
        createGameBoard(width: width, height: height)
    }
    
    private func createGameBoard(width: Int, height : Int){
        let cellWidth : CGFloat = 27.5
        let numOfRows = 40
        let numOfColumns = 20
        
        /* Did not understand these two lines */
        var x = CGFloat(-width/2) + (cellWidth/2)
        var y = CGFloat(height/2) - (cellWidth/2)
        
        // Loop through the rows and columns to create cells
        for row in 0..<numOfRows{
            for column in 0..<numOfColumns{
                let cellNode = SKShapeNode(rectOf: CGSize(width: cellWidth, height: cellWidth))
                cellNode.strokeColor = UIColor.black
                cellNode.zPosition = 2
                cellNode.position = CGPoint(x: x, y: y)
                // add array of cells -- then add to game board
                gameArray.append((node: cellNode, row: row, column: column))
                gameBackGround.addChild(cellNode)
                
                x += cellWidth
            }
            // Reset x and iterate y
            x = CGFloat(width / -2) + (cellWidth / 2)
            y -= cellWidth
        }
    }
    

    
    
    
    
}
