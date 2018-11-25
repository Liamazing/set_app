//
//  Card.swift
//  set_app
//
//  Created by Mia Bendy on 11/25/18.
//  Copyright © 2018 Mia Bendy. All rights reserved.
//

import Foundation
import UIKit
struct Card {
    enum Shape{
        case circle, triangle, square
    }
    enum Shading{
        case solid, striped, outlined
    }
    var shape:Shape
    var shading:Shading
    var color:UIColor
    var number:Int
    
    init(s:Shape, c:Int, n:Int, sh:Shading){
        shape = s
        shading = sh
        color = getColor(c: c)
        number = n
    }
    
}

func getColor(c:Int)->UIColor{
    switch c{
    case 0:
        return UIColor.red
    case 1:
        return UIColor.purple
    case 2:
        return UIColor.green
    default:
        return UIColor.red
    }
}
