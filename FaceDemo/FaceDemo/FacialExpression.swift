//
//  FacialExpression.swift
//  FaceDemo
//
//  Created by Abdoulaye Diallo on 05/28/17.
//  Copyright © 2016 Abdoulaye Diallo. All rights reserved.
//

import Foundation

// UI-independent representation of a facial expression

struct FacialExpression
{
    enum Eyes: Int {
        case Open
        case Closed
        case Squinting
    }
    
    enum Mouth: Int {
        case Frown
        case Smirk
        case Neutral
        case Grin
        case Smile
        
        func sadderMouth() -> Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .Frown
        }
        func happierMouth() -> Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .Smile
        }
    }
//    enum EyeBrows: Int {
//        case Relaxed
//        case Normal
//        case Furrowed
//        
//        func moreRelaxedBrow() -> EyeBrows {
//            return EyeBrows(rawValue: rawValue - 1) ?? .Relaxed
//        }
//        func moreFurrowedBrow() -> EyeBrows {
//            return EyeBrows(rawValue: rawValue + 1) ?? .Furrowed
//        }
//    }
    
    
    
    var happier: FacialExpression {
         return FacialExpression(eyes: self.eyes, mouth: self.mouth.happierMouth())
    }
    var sadder: FacialExpression {
        return FacialExpression(eyes: self.eyes, mouth: self.mouth.sadderMouth())
    }
    
    let eyes: Eyes
    //var eyeBrows: EyeBrows
    let mouth: Mouth
}
