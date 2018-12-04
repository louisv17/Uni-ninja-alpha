import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
//        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
//
////        // Create shape node to use during mouse interaction
////        let w = (self.size.width + self.size.height) * 0.05
////        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
////
////        if; let spinnyNode = self.spinnyNode {
////            self.spinnyNode.lineWidth = 2.5
//
//            self.spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
        
                var score = 0
                
                func addRandomNode() {
                    
                    let randomX = arc4random_uniform(UInt32(frame.width))
                    let randomY = arc4random_uniform(UInt32(frame.height))
                    
                    
                    let spaceship = SKSpriteNode(imageNamed: "spaceship")
                    spaceship.position = CGPoint(x: CGFloat(randomX), y: CGFloat(randomY))
                    spaceship.xScale = 0.2
                    spaceship.yScale = 0.2
                    addChild(spaceship)
                    
                    
                }
                
                func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                    
                    addRandomNode()
                    
                    for t in touches { self.touchDown(atPoint: t.location(in: self)) }
                    
                    let touch = touches.first! as UITouch
                    let positionInScene = touch.location(in: self)
                    
                    let touchedNodes = self.nodes(at: positionInScene)
                    
                    for node in touchedNodes {
                        node.removeFromParent()
                        score += 5
                    }
                    
                    print(score)
        
        }
    }
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

