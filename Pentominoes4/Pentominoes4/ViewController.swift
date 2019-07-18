//
//  ViewController.swift
//  Pentominoes4
//
//  Created by Brittany Chiu on 9/17/16.
//  Copyright © 2016 Brittany Chiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct ViewLocation{
        var image = UIImageView()
        var x = CGFloat()
        var y = CGFloat()
    };
    
    // MARK - Outlets
    @IBOutlet weak var board0Button: UIButton!
    @IBOutlet weak var board1Button: UIButton!
    @IBOutlet weak var board2Button: UIButton!
    @IBOutlet weak var board3Button: UIButton!
    @IBOutlet weak var board4Button: UIButton!
    @IBOutlet weak var board5Button: UIButton!
    @IBOutlet weak var gameBoard: UIImageView!
    @IBOutlet weak var solveButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    let kAnimationInterval = 1.0
    let numPentominoes = 12
    let imageArray = ["F", "I","L","N","P","T","U","V","W","X","Y","Z"]
    var ImageViewArray = [UIImageView]()
    var UIImageArrayWithPts = [ViewLocation]()
    
    var curGame = Game()

    func loadPieces(){
        var imgPieceName = ""
        var image = UIImage()
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        var curWidth = CGFloat(30)
        var curHeight = CGFloat(600)
        var piece = 0
        
        for i in 0...imageArray.count-1{
            imgPieceName = "tile" + imageArray[i] + ".png"
            image = UIImage(named: imgPieceName)! // Name of the image that we copied. You don't have to write extension of the image.
            
            let imageView = UIImageView(image: image)
            ImageViewArray.append(imageView)
            
            // Place piece
            let offset = CGFloat(157)
            
            if(curWidth+(offset*CGFloat(piece)) > screenWidth){
                curHeight += CGFloat(150)
                curWidth = CGFloat(30)
                piece = 0
                imageView.frame = CGRectMake(curWidth + (offset*CGFloat(piece)),curHeight-1 ,image.size.width-1,image.size.height-1)
            }
            else{
                imageView.frame = CGRectMake(curWidth + (offset*CGFloat(piece)),curHeight ,image.size.width-1,image.size.height-1)
            }
            
            piece += 1
            
            self.view.addSubview(imageView)
            
            UIImageArrayWithPts.append(ViewLocation(image: imageView, x: imageView.frame.origin.x, y: imageView.frame.origin.y))
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.JPG")!)
        loadPieces()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func boardButtonTapped(sender: UIButton) {
        board0Button.tag = 0
        board1Button.tag = 1
        board2Button.tag = 2
        board3Button.tag = 3
        board4Button.tag = 4
        board5Button.tag = 5
        
        let imageName = "Board" + String(sender.tag) + ".png"
        let flipAnimation : UIViewAnimationOptions = UIViewAnimationOptions.TransitionFlipFromBottom
        
        UIImageView.transitionWithView(gameBoard, duration: kAnimationInterval, options: flipAnimation, animations: {
            
            self.gameBoard.image = UIImage(named: imageName)
            self.curGame.changeBoard(board: sender.tag)
            
        }, completion: {
            (finished: Bool) in
                print("")})

    }

    @IBAction func solveButtonTapped(sender: UIButton) {
        solveBoard(currentBoard: curGame.getCurBoard())
        
    }
    
    @IBAction func resetButtonTapped(sender: UIButton) {
        
        resetBoard(currentBoard: curGame.currentBoard)
    
    }
    
    func degreesToRadians(angle : Float) -> CGFloat {
        return CGFloat(angle / 180.0 * Float(M_PI))
    }
    
    func resetBoard(currentBoard curBoard: Int){
        
        if(curBoard == 0){
            return
        }
        
        solveButton.enabled = true
        solveButton.hidden = false
        board0Button.enabled = true
        board1Button.enabled = true
        board2Button.enabled = true
        board3Button.enabled = true
        board4Button.enabled = true
        board5Button.enabled = true
        
        var name = String()
        var indexUIViewImg = Int()
        
        let currentBoard = curGame.boards[curBoard-1]
        
        let UIViewAnimationOptionTransitionCrossDissolve : UIViewAnimationOptions = UIViewAnimationOptions.AllowAnimatedContent
        for i in 0...numPentominoes-1{ // look for letter directly
            name = currentBoard.tiles[i].tileName
           
            
            indexUIViewImg = imageArray.indexOf(name)!
            
            self.changeView(self.ImageViewArray[indexUIViewImg], toView: self.gameBoard.superview!)
        
            UIImageView.transitionWithView(ImageViewArray[indexUIViewImg], duration: kAnimationInterval, options: UIViewAnimationOptionTransitionCrossDissolve, animations: {

                
                self.ImageViewArray[indexUIViewImg].transform = CGAffineTransformIdentity
                
                self.ImageViewArray[indexUIViewImg].frame.origin.x = self.UIImageArrayWithPts[indexUIViewImg].x
                self.ImageViewArray[indexUIViewImg].frame.origin.y = self.UIImageArrayWithPts[indexUIViewImg].y
                
                }, completion: {
                    (finished: Bool) in
                    print("")})
        }

    }
    
    func solveBoard(currentBoard curBoard:Int){
        
        if(curBoard == 0){
            resetBoard(currentBoard: curBoard)
            return
        }
        
        // CGRectContainsRect()// second completely encap first
        
        var x = CGFloat()
        var y = CGFloat()
        var flips = Int()
        var rotations = Int()
        var name = String()
        var indexUIViewImg = Int()
        let currentBoard = curGame.boards[curBoard-1]
        let UIViewAnimationOptionTransitionCrossDissolve : UIViewAnimationOptions = UIViewAnimationOptions.AllowAnimatedContent
        
        for i in 0...numPentominoes-1{
            name = currentBoard.tiles[i].tileName
            x = CGFloat(currentBoard.tiles[i].x)
            y = CGFloat(currentBoard.tiles[i].y)
            flips = currentBoard.tiles[i].flips
            rotations = currentBoard.tiles[i].rotations
            
            indexUIViewImg = imageArray.indexOf(name)!
            
            self.changeView(self.ImageViewArray[indexUIViewImg], toView: self.gameBoard)
            
            UIImageView.transitionWithView(ImageViewArray[indexUIViewImg], duration: kAnimationInterval, options: UIViewAnimationOptionTransitionCrossDissolve, animations: {
        
                self.ImageViewArray[indexUIViewImg].transform
                    = CGAffineTransformRotate(self.ImageViewArray[indexUIViewImg].transform, self.degreesToRadians(Float(90*rotations)))
            
                    if flips > 0 {
                            self.ImageViewArray[indexUIViewImg].transform = CGAffineTransformScale(self.ImageViewArray[indexUIViewImg].transform, CGFloat(-1), CGFloat(1))
                
                    }
                
                    self.ImageViewArray[indexUIViewImg].frame.origin.x = x * 30
                    self.ImageViewArray[indexUIViewImg].frame.origin.y = y * 30
                
                }, completion: {
                (finished: Bool) in
                    self.solveButton.enabled = false
                    self.solveButton.hidden = true
                    self.board0Button.enabled = false
                    self.board1Button.enabled = false
                    self.board2Button.enabled = false
                    self.board3Button.enabled = false
                    self.board4Button.enabled = false
                    self.board5Button.enabled = false
                })
        }
       

    }
    
    
    func changeView(view:UIView, toView newView: UIView) {
        let newCenter = newView.convertPoint(view.center, fromView: view.superview)
        view.center = newCenter
        newView.addSubview(view)
    }

}

