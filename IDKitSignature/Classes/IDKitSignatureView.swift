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
    /// Set view bgcolor
    @objc var bgViewColor:UIColor = .white
    
    /// Initialize the container
    var pointsArray:NSMutableArray = NSMutableArray.init()
    var tempPointsArray:NSMutableArray?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = bgViewColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// View draw method
    override public func draw(_ rect: CGRect) {
        // Get view context
        if let context = UIGraphicsGetCurrentContext() {
            // Set
            context.setLineWidth(lineWidth)
            context.setStrokeColor(lineColor.cgColor)
            // Set drew start point
            pointsArray.forEach { (valuesArray) in
                let mValuesArray = NSMutableArray.init(array: valuesArray as! NSMutableArray)
                let startPoint = (mValuesArray.firstObject as! NSValue).cgPointValue
                context.move(to: startPoint)
                // Remove container frist point
                mValuesArray.remove(mValuesArray.firstObject!)
                mValuesArray.forEach({ (value) in
                    context.addLine(to: (value as! NSValue).cgPointValue)
                })
            }
            context.strokePath()
        }
    }

    /// View touch began method
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Initialize container
        tempPointsArray = NSMutableArray.init()
        // Temporary points are added to the formal container container
        pointsArray.add(tempPointsArray!)
    }

    /// View touch ended method
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Remove elements in the container
//        tempPointsArray!.removeAll()
        print(pointsArray)
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
        tempPointsArray!.add(value)
        // Draw View
        self.setNeedsDisplay()
    }
}
