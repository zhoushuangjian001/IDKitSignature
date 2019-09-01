//
//  IDKitSignatureView.swift
//  IDKitSignature
//
//  Created by 周双建 on 2019/9/1.
//

import Foundation

class IDKitSignatureView: UIView {

    /// Initialize the container
    fileprivate var pointsArray:Array<Array<NSValue>> = []
    fileprivate var tempPointsArray:Array<NSValue>?

    /// View draw method
    override func draw(_ rect: CGRect) {

    }

    /// View touch began method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Initialize container
        tempPointsArray = Array.init()
        // Temporary points are added to the formal container container
        pointsArray.append(tempPointsArray!)
    }

    /// View touch ended method
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Remove elements in the container
        tempPointsArray!.removeAll()
    }

    /// View touch moved method
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
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
