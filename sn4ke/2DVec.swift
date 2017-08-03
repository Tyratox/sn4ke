//
//  2DVec.swift
//  sn4ke
//
//  Created by Nico Hauser on 01.08.17.
//  Copyright © 2017 tyratox.ch. All rights reserved.
//

import SpriteKit;
import Foundation;

public struct Vec2D{
    
    var x: CGFloat;
    var y: CGFloat;
    
    init(x: CGFloat, y: CGFloat){
        self.x = x;
        self.y = y;
    }
    
    init(point: CGPoint){
        self.x = point.x;
        self.y = point.y;
    }
    
    func add(vec: Vec2D) -> Vec2D{
        return Vec2D(x: self.x + vec.x, y: self.y + vec.y);
    }
    
    func sub(vec: Vec2D) -> Vec2D{
        return Vec2D(x: self.x - vec.x, y: self.y - vec.y);
    }
    
    func multiply(factor: CGFloat) -> Vec2D{
        return Vec2D(x: self.x * factor, y: self.y * factor);
    }
    
    func dotProduct(vec: Vec2D) -> CGFloat{
        return self.x * vec.x + self.y * vec.y;
    }
    
    func toCGPoint() -> CGPoint{
        return CGPoint(x: self.x, y: self.y);
    }
    
    func toCGVector() -> CGVector{
        return CGVector(dx: self.x, dy: self.y);
    }
    
    func distance(vec: Vec2D) -> CGFloat{
        return sqrt((self.x - vec.x) * (self.x - vec.x) + (self.y - vec.y) * (self.y - vec.y));
    }
    
    static func addCGPoints(point1: CGPoint, point2: CGPoint) -> CGPoint{
        return CGPoint(x: point1.x + point2.x, y: point1.y + point2.y);
    }
    
    static func subCGPoints(point1: CGPoint, point2: CGPoint) -> CGPoint{
        return CGPoint(x: point1.x - point2.x, y: point1.y - point2.y);
    }
    
    static func multiplyCGPoint(point: CGPoint, factor: CGFloat) -> CGPoint{
        return CGPoint(x: point.x * factor, y: point.y * factor);
    }
    
}

