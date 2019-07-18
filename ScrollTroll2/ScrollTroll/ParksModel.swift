//
//  ScrollViewController.swift
//  ScrollTroll
//
//  Created by Brittany Chiu on 9/25/16.
//  Copyright © 2016 Brittany Chiu. All rights reserved.
//

import Foundation

struct Photo{
    var imgName = String()
    var caption = String()
//    var tag = Int()
}

struct Park{
    var name = String()
    var photos = [Photo]()
}

class ParksModel {
    
    let photoCount = 20
    let numberFormatter = NSNumberFormatter()
    var name = String()
    var parks = [Park]()
    
    init() {
        numberFormatter.numberStyle = NSNumberFormatterStyle.SpellOutStyle
        configureParks()
    }
    
    func parkNumber()->Int{
        
        var count: Int = 0
        if let path = NSBundle.mainBundle().pathForResource("Photos", ofType: "plist"){
            let parkData = NSArray(contentsOfFile: path)
            count = parkData!.count
        }
        
        return count
    }
    
    func configureParks(){
        let numParks = parkNumber()
        var localName = ""
        var localPhotos = [Photo]()
        
        for i in 0..<numParks{
            localName = getName(parkNumber: i)
            localPhotos = getPhotos(parkNumber: i)
            let park = Park(name: localName, photos: localPhotos)
            parks.append(park)
        }
    }
    
    func getName(parkNumber parkNum: Int)->String{
        
        var localName: String = ""
        
        if let path = NSBundle.mainBundle().pathForResource("Photos", ofType: "plist"){
            let parkData = NSArray(contentsOfFile: path)
            localName = String(parkData![parkNum]["name"])

        }
        
        return localName
    }
    
    func getPhotos(parkNumber parkNum: Int)->[Photo]{
        var localPhotos = [Photo]()
        
        if let path = NSBundle.mainBundle().pathForResource("Photos", ofType: "plist"){
            let parkData = NSArray(contentsOfFile: path)
            let photosData = parkData![parkNum]["photos"]!
            
            for i in 0..<photosData!.count{
                let cap = String(photosData![i]!["caption"]!!)
                let img = String(photosData![i]!["imageName"]!!)
                
                print(img)

                localPhotos.append(Photo(imgName: img, caption: cap))
            }
            
        }
        
        return localPhotos
        
        
    }

    
    func titleForPageNumber(i:Int) -> String {
        return numberFormatter.stringFromNumber(i)!
    }
}