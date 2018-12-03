//
//  DoubleCard.swift
//  set_app
//
//  Created by Mia Bendy on 12/1/18.
//  Copyright © 2018 Mia Bendy. All rights reserved.
//

import UIKit

//colleciton view cell for a set card with two shapes
class DoubleCard: UICollectionViewCell {
    private var theCard:Card?
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var owner: NSObject!
    
    func setCard(card: Card){
        theCard = card
        var colorString:String = ""
        var shapeString:String = ""
        var shadingString:String = ""
        
        switch (theCard!.color){
        case UIColor.red:
            colorString = "red"
        case UIColor.purple:
            colorString = "purple"
        case UIColor.green:
            colorString = "green"
        default:
            colorString = "red"
        }
        
        switch (theCard!.shape){
        case Card.Shape.circle:
            shapeString = "circle"
        case Card.Shape.square:
            shapeString = "square"
        case Card.Shape.triangle:
            shapeString = "triangle"
        }
        
        switch (theCard!.shading){
        case Card.Shading.outlined:
            shadingString = "outlined"
        case Card.Shading.solid:
            shadingString = "solid"
        case Card.Shading.striped:
            shadingString = "striped"
        }
        
        let imageString = colorString + "_" + shadingString + "_" + shapeString
        
        imageOne.image = UIImage(named: imageString)
        imageTwo.image = UIImage(named: imageString)
    }
}
