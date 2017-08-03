//
//  Food.swift
//  sn4ke
//
//  Created by Nico Hauser on 02.08.17.
//  Copyright © 2017 tyratox.ch. All rights reserved.
//

import SpriteKit;

class Food : SKShapeNode {
    static let categoryBitMask: UInt32 = 0x1 << 1;
    
    private var size : CGFloat;
    
    convenience override init(){
        self.init(size: 1);
    }
    
    init(size: CGFloat){
        
        self.size = size;
        
        super.init();
        
        self.updatePath(size: size);
        
        self.fillColor = SKColor.green;
        self.strokeColor = SKColor.clear;
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size, height: size));
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.isDynamic = true;
        self.physicsBody?.categoryBitMask = Food.categoryBitMask;
        self.physicsBody?.collisionBitMask = Snake.categoryBitMask;
        self.physicsBody?.contactTestBitMask = Snake.categoryBitMask;
    }
    
    private func updatePath(size: CGFloat){
        self.path = CGPath.init(rect: CGRect(origin: CGPoint(x:0,y:0), size: CGSize(width: size*2, height: size*2)), transform: nil);
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init();
    }
    
    func setSize(size: CGFloat){
        self.size = size;
        self.updatePath(size: size);
    }
    
    func getSize() -> CGFloat{
        return self.size;
    }
    
    func startRemovalTimer(){
        self.run(SKAction.sequence([SKAction.wait(forDuration: 10.0), SKAction.fadeOut(withDuration: 0.3), SKAction.removeFromParent()]));
    }
    
}
