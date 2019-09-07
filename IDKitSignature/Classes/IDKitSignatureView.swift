//
//  IDKitSignatureView.swift
//  IDKitSignature
//
//  Created by 周双建 on 2019/9/1.
//

import Foundation

@objc public class IDKitSignatureView: UIView {

    /// Draw Status
    @objc public var status:((String) ->Void)?

    // Custom parameters
    /// Set line width
    @objc public var lineWidth:CGFloat = 5.0;
    /// Set line color
    @objc public var lineColor:UIColor = .black
    /// Set view bgcolor
    @objc public var bgViewColor:UIColor {
        get {
            return .white
        }
        set {
            self.backgroundColor = newValue
        }
    }
    
    /// Initialize the container
    var pointsArray:NSMutableArray = NSMutableArray.init()
    var tempPointsArray:NSMutableArray?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = self.bgViewColor
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

extension IDKitSignatureView {

    /// Obtain the signature figure
    ///
    /// - Returns: Signature image object
    @objc public func getSignatureImage() -> UIImage? {
        UIGraphicsBeginImageContext(self.frame.size)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    /// Redraw view
    @objc public func redraw() {
        pointsArray.removeAllObjects()
        self.setNeedsDisplay()
    }

    /// Undo the last operation
    @objc public func undoLastOperation() {
        guard pointsArray.count <= 0 else {
            return
        }
        pointsArray.removeLastObject()
        self.setNeedsDisplay()
    }

    /// Save image
    ///
    /// - Parameter filePath: Image save path
    @objc public func save(filePath:String?) {
        if filePath != nil {
            if FileManager.default.isExecutableFile(atPath: filePath!) {
                if let image = self.getSignatureImage() {
                    if let imageData = image.jpegData(compressionQuality: 0.8) {
                        try? imageData.write(to: URL.init(string: filePath!)!)
                    }
                }
            }

        } else {
            // Save photo album
            if let image = self.getSignatureImage() {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(idkitSave(image:didFinishSavingWithError:contextInfo:)), nil)
            }
        }
    }

    /// Image save delegate
    ///
    /// - Parameters:
    ///   - image: Image obj
    ///   - error: error info
    ///   - contextInfo: Image information
    @objc func idkitSave(image:UIImage,didFinishSavingWithError error:NSError?, contextInfo:AnyObject) {
        if error != nil {
            if let block = status {
                block("存储失败")
            }
        } else {
            if let block = status {
                block("存储成功")
            }
        }
    }
}
