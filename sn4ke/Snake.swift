//
//  Snake.swift
//  sn4ke
//
//  Created by Nico Hauser on 01.08.17.
//  Copyright © 2017 tyratox.ch. All rights reserved.
//

import SpriteKit;

public class Snake: SKShapeNode{
    
    static let categoryBitMask: UInt32 = 0x1 << 0;
    
    public var velocity : Vec2D;
    public var acceleration : Vec2D;
    public var mass : CGFloat;
    public var length : CGFloat;
    
    public var points = [Vec2D]();
    
    private var label : SKLabelNode;
    
    convenience override init(){
        self.init(length: 100);
    }
    
    convenience init(length: CGFloat) {
        self.init(length: length, velocity: Vec2D(x:0,y:0), acceleration: Vec2D(x:0,y:0), mass: 1);
    }
    
    convenience init(length: CGFloat, velocity: Vec2D, acceleration: Vec2D, mass: CGFloat){
        self.init(length: length, velocity: velocity, acceleration: acceleration, mass: mass, labelText: "nico");
    }
    
    init(length: CGFloat, velocity: Vec2D, acceleration: Vec2D, mass: CGFloat, labelText: String){
        self.velocity = velocity;
        self.acceleration = acceleration;
        self.mass = mass;
        self.length = length;
        self.label = SKLabelNode(text: labelText);
        
        points.append(Vec2D(x: length, y: 0));
        
        super.init();
        
        //style line
        self.lineWidth = 2;
        self.strokeColor = UIColor.white;
        self.position = CGPoint(x: 0, y: 0);
        
        //snake.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)));
        /*snake.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
         SKAction.fadeOut(withDuration: 0.5),
         SKAction.removeFromParent()]));*/
        
        //add label
        self.label.fontName = "GillSans-UltraBold";
        self.label.fontSize = 14;
        self.label.fontColor = UIColor.white;
        self.label.alpha = 0.8;
        
        self.addChild(self.label);
        
        self.update(time: 0);
    }
    
    convenience required public init?(coder aDecoder: NSCoder) {
        self.init();
    }
    
    func update(time: CGFloat){
        
        //update velocity and "position"
        self.acceleration = self.acceleration.multiply(factor: time);
        self.velocity = self.velocity.add(vec: self.acceleration);
        
        //update drawing
        let last : Vec2D = points.last!;
        
        points.append(last.add(vec: self.velocity.multiply(factor: time)));
        
        var actualLength : CGFloat = 0;
        let mutablePath: CGMutablePath = CGMutablePath();
        mutablePath.move(to: CGPoint(x: last.x, y: last.y));
        for i : Int in (0...(points.count - 2)).reversed() {
            actualLength += points[i+1].distance(vec: points[i]);
            if(actualLength < length){
                mutablePath.addLine(to: CGPoint(x: points[i].x, y: points[i].y));
            }else{
                points.removeFirst(i);
                break;
            }
        }
        self.path = mutablePath;
        
        //udpate hitbox
        self.physicsBody = SKPhysicsBody(edgeChainFrom: mutablePath);
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.isDynamic = true;
        self.physicsBody?.categoryBitMask = Snake.categoryBitMask;
        self.physicsBody?.collisionBitMask = Snake.categoryBitMask | Food.categoryBitMask;
        self.physicsBody?.contactTestBitMask = Snake.categoryBitMask | Food.categoryBitMask;
        self.physicsBody?.usesPreciseCollisionDetection = true;
        
        //update label position
        var v = Vec2D(x: 0, y: 10);
        
        if(self.velocity.x > 0){
            v.x = 0;
        }else if(self.velocity.x < 0){
            v.x = 0;
        }
        
        if(self.velocity.y > 0){
            v.y = self.label.frame.height * 1.5;
        }else if(self.velocity.y < 0){
            v.y = -(self.label.frame.height * 2);
        }
        
        self.label.run(SKAction.move(to: last.add(vec: v).toCGPoint(), duration: 0.3));
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
