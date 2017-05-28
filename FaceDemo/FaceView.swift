//
//  FaceView.swift
//  FaceDemo
//
//  Created by Abdoulaye Diallo on 6/16/16.
//  Copyright © 2016 Abdoulaye Diallo. All rights reserved.
//

import UIKit

enum Eye {
    case left
    case right
}

private struct Ratios {
    static let skullRadiusToEyeOffset: CGFloat = 3
    static let skullRadiusToEyeRadius: CGFloat = 10
    static let skullRadiusToMouthWidth: CGFloat = 1
    static let skullRadiusToMouthHeight : CGFloat = 3
    static let skullRadiusToMouthOffset: CGFloat = 3
}
class FaceView: UIView {
    
    let scale : CGFloat = 0.9
    let eyeOpen: Bool = true
    var mouthCurvature : Double = -0.5
    private var skullRadius :CGFloat{
        return min(bounds.size.width, bounds.size.height) / 2  * scale
    }
    
    private var skullCenter : CGPoint {
        return   CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    

    private func pathForSkull() -> UIBezierPath {
        
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: CGFloat( 2 * Double.pi), clockwise: false)
        UIColor.blue.set()
        path.lineWidth = 5.0
        return path
    }
    
    private func pathForEye(_ eye:Eye) -> UIBezierPath{
        
        func centerOfEye(_ eye:Eye) -> CGPoint {
            let eyeOffset = skullRadius / Ratios.skullRadiusToEyeOffset
            var eyeCenter = skullCenter
            eyeCenter.y -= eyeOffset
            eyeCenter.x += ((eye == .left) ? -1 : 1) * eyeOffset
            return eyeCenter
        }
        let eyeRadius =  skullRadius / Ratios.skullRadiusToEyeRadius
        let eyeCenter = centerOfEye(eye)
        
        let path: UIBezierPath
        
        if eyeOpen {
            
            path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle:2 * CGFloat(Double.pi), clockwise: true)
        } else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius , y: eyeCenter.y ))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius , y: eyeCenter.y))
        }
    
        UIColor.blue.set()
        path.lineWidth = 5.0
        return path
        
    }
    
    private func pathForMouth() ->UIBezierPath {
     
         let mouthWidth  = skullRadius / Ratios.skullRadiusToMouthWidth
         let mouthHeight = skullRadius / Ratios.skullRadiusToMouthHeight
         let mouthOffset = skullRadius / Ratios.skullRadiusToMouthOffset
        
          let mouthRect = CGRect(x: skullCenter.x - mouthWidth / 2,
                                 y: skullCenter.y + mouthOffset,
                                 width: mouthWidth,
                                 height: mouthHeight
        )
        
        
         let smileOffSet = CGFloat( max(-1, min(mouthCurvature, 1))) * mouthRect.height
         let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY )
         let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        
         let cp1 = CGPoint(x: start.x + mouthRect.width / 3, y: start.y + smileOffSet)
         let cp2 = CGPoint(x: end.x - mouthRect.width / 3, y: start.y + smileOffSet)
        
         let path = UIBezierPath()
         path.move(to: start)
         path.lineWidth = 5.0
         path.addCurve(to:end, controlPoint1: cp1, controlPoint2: cp2)
          return path
    }
    
    
    override func draw(_ rect: CGRect) {
        pathForSkull().lineWidth = 3
        pathForSkull().stroke()
        pathForEye(.left).stroke()
        pathForEye(.right).stroke()
        pathForMouth().stroke()
        
        
        
        
    }
}