//
//  BoardModel.swift
//  Pentominoes4
//
//  Created by Brittany Chiu on 9/17/16.
//  Copyright © 2016 Brittany Chiu. All rights reserved.
//

import Foundation

// One board
class Board{
    
    var boardName = String()
//    var tileObjects = [Tile]()
    var tiles = [Tile]()
//    var tileDictionary = NSDictionary()
    
    init(curBoardName curBoard: String, boardData data: NSDictionary){
        boardName = curBoard
//        tileDictionary = data
        setTiles(data)
        
    }
    
    func setTiles(dictionary:NSDictionary){
        
        for(key, value) in dictionary{
            let data = NSDictionary(dictionary: value as! [NSObject : AnyObject])
            
            let x = Int(data.valueForKey("x") as! NSNumber)
            let y = Int(data.valueForKey("y") as! NSNumber)
            let flips = Int(data.valueForKey("flips") as! NSNumber)
            let rotations = Int(data.valueForKey("rotations") as! NSNumber)
            
            tiles.append(Tile(tileLetter: String(key), xCoord: x, yCoord: y, numRotations: rotations, numFlips: flips))
        }
    }

}