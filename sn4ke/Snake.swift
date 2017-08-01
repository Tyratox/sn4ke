//
//  Snake.swift
//  sn4ke
//
//  Created by Nico Hauser on 01.08.17.
//  Copyright © 2017 tyratox.ch. All rights reserved.
//

import SpriteKit;

public class Snake: SKShapeNode{
    
    public var velocity : Vec2D;
    public var acceleration : Vec2D;
    public var mass : CGFloat;
    public var length : CGFloat;
    
    public var points = [Vec2D]();
    
    convenience override init(){
        self.init(length: 100);
    }
    
    convenience init(length: CGFloat) {
        self.init(length: length, velocity: Vec2D(x:0,y:0), acceleration: Vec2D(x:0,y:0), mass: 1);
    }
    
    init(length: CGFloat, velocity: Vec2D, acceleration: Vec2D, mass: CGFloat){
        self.velocity = velocity;
        self.acceleration = acceleration;
        self.mass = mass;
        self.length = length;
        
        points.append(Vec2D(x: length, y: 0));
        
        super.init();
        
        self.lineWidth = 2;
        self.strokeColor = UIColor.white;
        //self.fillColor = UIColor.white;
        self.position = CGPoint(x: 0, y: 0);
        
        //snake.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)));
        /*snake.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
         SKAction.fadeOut(withDuration: 0.5),
         SKAction.removeFromParent()]));*/
        
        self.update(time: 0);
    }
    
    convenience required public init?(coder aDecoder: NSCoder) {
        self.init();
    }
    
    func update(time: CGFloat){
        self.acceleration = self.acceleration.multiply(factor: time);
        self.velocity = self.velocity.add(vec: self.acceleration);
        
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
