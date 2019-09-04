//
//  IDKitSignatureView.swift
//  IDKitSignature
//
//  Created by 周双建 on 2019/9/1.
//

import Foundation

@objc public class IDKitSignatureView: UIView {

    // Custom parameters
    /// Set line width
    @objc var lineWidth:CGFloat = 5.0;
    /// Set line color
    @objc var lineColor:UIColor = .black
    
    /// Initialize the container
    fileprivate var pointsArray:Array<Array<NSValue>> = []
    fileprivate var tempPointsArray:Array<NSValue>?

    // Get view context
    fileprivate let context = UIGraphicsGetCurrentContext()

    /// View draw method
    override public func draw(_ rect: CGRect) {
        // Set
        context!.setLineWidth(lineWidth)
        context!.setStrokeColor(lineColor.cgColor)
        // Set drew start point
        pointsArray.forEach { (valuesArray) in
            let startPoint = valuesArray.first!.cgPointValue
            context!.move(to: startPoint)
            valuesArray.forEach({ (value) in
                context!.addLine(to: value.cgPointValue)
            })
        }
        context!.strokePath()
    }

    /// View touch began method
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Initialize container
        tempPointsArray = Array.init()
        // Temporary points are added to the formal container container
        pointsArray.append(tempPointsArray!)
    }

    /// View touch ended method
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Remove elements in the container
        tempPointsArray!.removeAll()
    }

    /// View touch moved method
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Get your fingers object
        let touch = touches.first
        // Get your fingers touch the point of view
        let point = touch!.location(in: self)
        // Container can contain points can be converted to objects
        let value = NSValue.init(cgPoint: point)
        // Add points to the temporary containers
        tempPointsArray?.append(value)
        // Draw View
        self.setNeedsDisplay()
    }
}
