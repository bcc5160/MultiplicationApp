//
//  TileModel.swift
//  Pentominoes4
//
//  Created by Brittany Chiu on 9/17/16.
//  Copyright © 2016 Brittany Chiu. All rights reserved.
//

import Foundation

class Tile{

    var tileName = String()
    var x = Int()
    var y = Int()
    var rotations = Int()
    var flips = Int()
    
//    init(tileLetter letter: String, tileData data: [NSDictionary]){
//        for item in data{
//    
//            print(item)
//        }
//    }
    
     init(tileLetter tile: String, xCoord xcoord: Int, yCoord ycoord: Int, numRotations rotationNum:Int, numFlips flipsNum:Int){
        tileName = tile
        x = xcoord
        y = ycoord
        rotations = rotationNum
        flips = flipsNum
    }
    
}