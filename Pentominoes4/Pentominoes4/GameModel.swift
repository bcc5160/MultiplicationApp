//
//  GameModel.swift
//  Pentominoes4
//
//  Created by Brittany Chiu on 9/17/16.
//  Copyright © 2016 Brittany Chiu. All rights reserved.
//

import Foundation

// Parent of Board class (contains all the boards)
class Game{
    
    let totalBoards = 5
    var currentBoard = 0
    var boards = [Board]()
    var dictionaryList = [NSDictionary]()
    
    init(){
        
        if let path = NSBundle.mainBundle().pathForResource("Solutions", ofType: "plist"){
            let boardData = NSArray(contentsOfFile: path)
            
            for item in boardData!{
                dictionaryList.append(NSDictionary(dictionary: item as! [NSObject : AnyObject]))
            }
            
            var i = 0
            for item in dictionaryList{
                print(item)
                boards.append(Board(curBoardName: "Item " +  String(i), boardData: item))
                i += 1
            }
        }

       
    }
    
    func changeBoard(board boardNum:Int){
        currentBoard = boardNum
        
    }
    
    func getCurBoard()->Int{
        return currentBoard
    }
    
    
    
    
    
    

}