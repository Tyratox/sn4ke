//
//  Food.swift
//  sn4ke
//
//  Created by Nico Hauser on 02.08.17.
//  Copyright © 2017 tyratox.ch. All rights reserved.
//

import SpriteKit;

class Enemy : SKShapeNode {
    static let categoryBitMask: UInt32 = 0x1 << 2;
    static let sizeFactor: CGFloat = 2;
    
    private var size : CGFloat;
    
    convenience override init(){
        self.init(size: 1);
    }
    
    init(size: CGFloat){
        
        self.size = size * Food.sizeFactor;
        
        super.init();
        
        self.fillColor = SKColor.red;
        self.strokeColor = SKColor.clear;
        
        updatePath();
        updateHitbox();
    }
    
    private func updateHitbox(){
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size, height: size), center: CGPoint(x: size/2, y: size/2));
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.isDynamic = true;
        self.physicsBody?.categoryBitMask = Enemy.categoryBitMask;
        self.physicsBody?.collisionBitMask = Snake.categoryBitMask;
        self.physicsBody?.contactTestBitMask = Snake.categoryBitMask;
    }
    
    private func updatePath(){
        self.path = CGPath(rect: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size, height: size)), transform: nil);
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init();
    }
    
    func setSize(size: CGFloat){
        self.size = size * Food.sizeFactor;
        updatePath();
        updateHitbox();
    }
    
    func getSize() -> CGFloat{
        return self.size;
    }
    
    func startRemovalTimer(){
        self.run(SKAction.sequence([SKAction.wait(forDuration: 30.0), SKAction.fadeOut(withDuration: 0.3), SKAction.removeFromParent()]));
    }
    
}
