//
//  GameScene.swift
//  sn4ke
//
//  Created by Nico Hauser on 01.08.17.
//  Copyright © 2017 tyratox.ch. All rights reserved.
//

import SpriteKit;
import GameplayKit;

class GameScene: SKScene, SKPhysicsContactDelegate {
	
	private var lastRender : TimeInterval?;
	
	private var player : Snake?;
	private var food : Food?;
	private var enemy : Enemy?;
	
	private let spawnNode : SKNode = SKNode();
	
	private let displaySize : CGRect = UIScreen.main.bounds;
	
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
		//setup "world"
		self.physicsWorld.contactDelegate = self;
        self.backgroundColor = SKColor.black;
		
		//setup controls
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
		
		//add spawner
		self.addChild(spawnNode);
		
		//spawn food
		self.food = Food(size: 1);
		spawnNode.run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 5), SKAction.run(spawnFood)])));
		
		//spawn enemies
		self.enemy = Enemy(size: 1);
		spawnNode.run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 8), SKAction.run(spawnEnemies)])));
		
		
		
		//add player
		self.player = Snake.init(length: (self.size.width + self.size.height) * 0.05);
		self.player?.position = CGPoint(x:50, y:50);
		self.player?.strokeColor = SKColor.white;
		self.player?.velocity = Vec2D(x: 50,y: 0);
		self.addChild(self.player!);
    }
	
	func didBegin(_ contact: SKPhysicsContact) {
		var player : Snake? = nil;
		var node : SKNode = SKNode();
		
		if(contact.bodyA.categoryBitMask == Snake.categoryBitMask){
			player = contact.bodyA.node as? Snake;
			node = contact.bodyB.node!;
		}else if(contact.bodyB.categoryBitMask == Snake.categoryBitMask){
			player = contact.bodyB.node as? Snake;
			node = contact.bodyA.node!;
		}
		
		if(node.physicsBody?.categoryBitMask == Food.categoryBitMask){
			player?.length += (node as! Food).getSize() * 10;
			self.removeChildren(in: [node]);
		}
	}
	
	func spawnFood(){
		if let n = self.food?.copy() as! Food? {
			n.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(displaySize.width))), y: CGFloat(arc4random_uniform(UInt32(displaySize.height))));
			n.setSize(size: 1 + CGFloat(arc4random_uniform(10)));
			n.startRemovalTimer();
			
			self.addChild(n);
		}
	}
	
	func spawnEnemies(){
		if let n = self.enemy?.copy() as! Enemy? {
			n.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(displaySize.width))), y: CGFloat(arc4random_uniform(UInt32(displaySize.height))));
			n.setSize(size: 1 + CGFloat(arc4random_uniform(10)));
			n.startRemovalTimer();
			
			self.addChild(n);
		}
	}
    
    
    func touchDown(touch : UITouch) {
		if(touch.tapCount == 2){
			player?.velocity = (player?.velocity.multiply(factor: 2))!;
			let dblVel : Vec2D = (player?.velocity)!;
			
			player?.run(SKAction.sequence([SKAction.wait(forDuration: 5), SKAction.run({
				if((self.player?.velocity)! == dblVel){
					self.player?.velocity = (self.player?.velocity.multiply(factor: 0.5))!;
				}
			})]));
		}
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
        /*if let label = self.label {
			label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut");
        }*/
        
		for t in touches { self.touchDown(touch: t) };
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
