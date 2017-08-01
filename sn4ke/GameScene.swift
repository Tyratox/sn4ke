//
//  GameScene.swift
//  sn4ke
//
//  Created by Nico Hauser on 01.08.17.
//  Copyright © 2017 tyratox.ch. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?;
    private var snake : Snake?;
	private var lastRender : TimeInterval?;
	
	private var player : Snake?;
	
	func swipedRight(sender:UISwipeGestureRecognizer){
		player?.velocity.x = 50;
		player?.velocity.y = 0;
	}
	
	func swipedLeft(sender:UISwipeGestureRecognizer){
		player?.velocity.x = -50;
		player?.velocity.y = 0;
	}
	
	func swipedUp(sender:UISwipeGestureRecognizer){
		player?.velocity.x = 0;
		player?.velocity.y = 50;
	}
	
	func swipedDown(sender:UISwipeGestureRecognizer){
		player?.velocity.x = 0;
		player?.velocity.y = -50;
	}
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.black;
		
		let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedRight));
		swipeRight.direction = .right;
		view.addGestureRecognizer(swipeRight);
		
		
		let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedLeft));
		swipeLeft.direction = .left;
		view.addGestureRecognizer(swipeLeft);
		
		
		let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedUp))
		swipeUp.direction = .up;
		view.addGestureRecognizer(swipeUp);
		
		
		let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown));
		swipeDown.direction = .down;
		view.addGestureRecognizer(swipeDown);
		
		
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
		
		
		self.snake = Snake.init(length: (self.size.width + self.size.height) * 0.05);
		
		if let n = self.snake?.copy() as! Snake? {
			n.position = CGPoint(x:50, y:50);
			n.strokeColor = SKColor.green;
			n.velocity = Vec2D(x: 50,y: 0);
			self.addChild(n);
			
			self.player = n;
		}
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        /*if let n = self.snake?.copy() as! Snake? {
			n.position = pos;
			n.strokeColor = SKColor.green;
			n.velocity = Vec2D(x: 1,y: 1);
			self.addChild(n);
        }*/
    }
	
	func touchMoved(touch : UITouch) {
		/*let loc : CGPoint = touch.location(in: self),
		prevLoc : CGPoint = touch.previousLocation(in: self),
		diffX   : CGFloat = loc.x - prevLoc.x,
		diffY   : CGFloat = loc.y - prevLoc.y;
		
		var vel : Vec2D = (player?.velocity)!;
		
		if(diffX > diffY && diffX > 3*diffY){
			if(diffX > 0){
				//right
				vel.x = 1;
			}else if(diffX == 0){
				//nothing
			}else{
				//left
				vel.x = -1;
			}
		}else if(diffY > diffX && diffY > 3*diffX){
			if(diffY > 0){
				//down
				vel.y = 1;
			}else if(diffY == 0){
				//nothing
			}else{
				//top
				vel.y = -1;
			}
		}
		
		print("x:"+String(describing: vel.x)+",y:"+String(describing: vel.y));
		
		player?.velocity = vel;*/
	}
	
    func touchUp(atPoint pos : CGPoint) {
		
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
			label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut");
        }
        
		for t in touches { self.touchDown(atPoint: t.location(in: self)) };
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		for t in touches { self.touchMoved(touch: t) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
		if((lastRender) != nil){
			let diff: CGFloat = CGFloat(currentTime.subtracting(lastRender!));
			for node in self.children{
				if(node is Snake){
					(node as! Snake).update(time: CGFloat(diff));
				}
			}
		}
		
		lastRender = currentTime;
    }
}
