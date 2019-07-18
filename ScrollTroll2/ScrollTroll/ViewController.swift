//
//  ViewController.swift
//  ScrollTroll
//
//  Created by Brittany Chiu on 9/25/16.
//  Copyright © 2016 Brittany Chiu. All rights reserved.
//

import UIKit

// Use a tag to get imageview and label data


class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var parksScrollView: UIScrollView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var parkLabel: UILabel!

    let park = ParksModel()
    var currentParkNumber = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        // Do any additional setup after loading the view, typically from a nib.
        configureScrollView()
        loadParkImages()
        
        parksScrollView.userInteractionEnabled = true
    }
 
    func loadParkImages(){
        
        let size = view.bounds.size
        let width = view.bounds.width
        let height = view.bounds.height
        let numberParks = park.parkNumber()
        
        for j in 0..<numberParks{
            let photoCount = park.parks[j].photos.count
            for i in 0..<photoCount{
                let imgName = park.parks[j].photos[i].imgName + ".jpg"
                let image = UIImage(named: imgName)
                let imageView = UIImageView(image: image)
                
                imageView.contentMode = .ScaleAspectFit
                
                let origin = CGPoint(x: size.width * CGFloat(j), y: size.height * CGFloat(i))
                let size = CGSize(width: size.width, height: size.height)
                
                
                imageView.frame = CGRect(origin: origin, size: size)
            
                parksScrollView.addSubview(imageView)
                // Make content size no more than images
                parksScrollView.contentSize = CGSize(width: width * CGFloat(numberParks+1), height: height * CGFloat(photoCount+1))
            
            }
        }
    }
    
    // if y is neg lock
    
    func configureScrollView() {
        let parkNumber = park.parkNumber()
        
        for i in 0..<parkNumber{
            let currentPark = park.parks[i].photos
            let photoCount = currentPark.count
            let size = view.bounds.size
            
            let contentSize = CGSize(width: size.width * CGFloat(parkNumber), height: size.height * CGFloat(photoCount))
            parksScrollView.contentSize = contentSize
            parksScrollView.pagingEnabled = true
            
            parksScrollView.delegate = self
        }
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let screenWidth = view.bounds.size.width
        let screenHeight = view.bounds.size.height
        let contentOffset = scrollView.contentOffset
        let numParkPhotos = park.parks[currentParkNumber].photos.count
        print(numParkPhotos)
        // TOP - can change park number
        if(contentOffset.y == 0.0){
            currentParkNumber = Int(round(contentOffset.x/screenWidth))
//            print(currentParkNumber)
//           
//            print("Content Offset: \(contentOffset.x)")
//            print("screenWidth:  \(screenWidth)")
        }
        else{
//            print("y: \(contentOffset.y)")
//            print("x: \(contentOffset.x)")
            // NOT TOP - go to bound
            if(contentOffset.x < screenWidth * CGFloat(currentParkNumber)){
                let point = CGPoint(x: screenWidth * CGFloat(currentParkNumber), y:contentOffset.y)
                parksScrollView.setContentOffset(point, animated: false)
            }
            
            if(contentOffset.x > (screenWidth * CGFloat(currentParkNumber))){
                let point = CGPoint(x: screenWidth * CGFloat(currentParkNumber), y:contentOffset.y)
                parksScrollView.setContentOffset(point, animated: false)
            }
        }
        
        if(contentOffset.y > screenHeight * CGFloat(numParkPhotos)){
            print("hit")
            let point = CGPoint(x: contentOffset.x, y:screenHeight * CGFloat(numParkPhotos-1))
            parksScrollView.setContentOffset(point, animated: false)
        }
        
        

    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        self.parksScrollView.minimumZoomScale = 1.0
        self.parksScrollView.maximumZoomScale = 2.0
        print(parksScrollView.subviews[0])
        return parksScrollView.subviews[0]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

