import UIKit

class CustomView: UIView {
    // Outlet for the main view in the XIB
    @IBOutlet weak var contentView: UIView!
    var arcFrame : CGRect!
    var arrowSide: String = "TOP"
    var contentHeight1 : CGFloat = 0.0
    let screenHeight = UIScreen.main.bounds.height
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var btn: UIButton!

    override init(frame: CGRect) {
        arcFrame = frame
        print(frame)
        var newFrame = frame
        newFrame.size.width = 300
        newFrame.origin.x = 20
        if arcFrame.origin.y >= screenHeight/2 {
            arrowSide = "BOTTOM"
        }
        super.init(frame: newFrame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    var curIndex = 0
    var items: [String] = []
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.layer.cornerRadius = 15
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //Adding target for the button
        btn.addTarget(self, action: #selector(hideCustomView), for: .touchUpInside)
        btn.setTitle("Next", for: .normal)

//        let arrowLayer = CAShapeLayer()
//        arrowLayer.fillColor = UIColor.green.cgColor
//        arrowLayer.lineWidth = 1.0
//        layer.name = "arrow"
//        layer.addSublayer(arrowLayer)
//        if arcFrame != nil {
//            arrowLayer.path = createArrowPath(frame: arcFrame!, contentHeight: 200).cgPath
////            setNeedsLayout()
//        }
    }
    
    override func layoutSubviews() {
        let labelTextHeight = labelText.systemLayoutSizeFitting(CGSize(width: labelText.bounds.width, height: CGFloat.greatestFiniteMagnitude)).height
        let totalHeight = labelTextHeight + infoText.frame.height + 40
        contentView.frame.size.height = totalHeight//totalHeight
        self.frame.size.height = totalHeight//totalHeight
        contentHeight1 = totalHeight
        self.backgroundColor = .cyan
        if arrowSide == "BOTTOM" {
            self.frame.origin.y = arcFrame.origin.y - totalHeight - 15
        } else {
            self.frame.origin.y = arcFrame.origin.y + 50
        }
        //        if let arrowLayer = layer.sublayers?.first as? CAShapeLayer {
//        //            arrowLayer.path = createArrowPath(frame: arcFrame).cgPath
//        //        }
//        if let arrowLayer = layer.sublayers?.first as? CAShapeLayer{
//            arrowLayer.path = createArrowPath(frame: arcFrame!, contentHeight: totalHeight).cgPath
//
//    }else{
//
//    }
        
//        if let layers = layer.sublayers, layers.count > 0{
//            for layer in layers {
////                if layer.name == "arrow"{
//                    if let arrowLayer = layer as? CAShapeLayer{
//                        arrowLayer.backgroundColor = UIColor.red.cgColor
//                        arrowLayer.path = createArrowPath(frame: arcFrame!, contentHeight: totalHeight).cgPath
//
//                    }
//                    break
////                }
//            }
//        }
    
            let arrowLayer = CAShapeLayer()
        arrowLayer.fillColor = UIColor.blue.cgColor
            arrowLayer.lineWidth = 1.0
            layer.name = "arrow"
            if let layers = layer.sublayers, layers.count > 1{
                self.layer.sublayers?.remove(at: 1)
            }
        layer.addSublayer(arrowLayer)
        if arcFrame != nil {
            arrowLayer.path = createArrowPath(frame: arcFrame!, contentHeight: totalHeight).cgPath
        }
        
       
        super.layoutSubviews()
    }
    
    @objc func hideCustomView() {
        curIndex += 1
        print(items.count)
        if curIndex < items.count {
            updateContent(for: curIndex)
        } else {
            self.removeFromSuperview()
        }
    }
    private func updateContent(for index: Int) {
        let item = items[index]
        labelText.text = item
        infoText.text = "\(index + 1) / \(items.count)"
        if index+1 == items.count {
            btn.setTitle("Done", for: .normal)
        }
        setNeedsLayout()
        
    }
    func show() {
        updateContent(for: curIndex)
    }
    func createArrowPath(frame: CGRect, contentHeight: CGFloat) -> UIBezierPath {
        
        let arrowPath = UIBezierPath()
        var x = contentView.frame.origin.x + frame.origin.x
        var y = contentView.frame.origin.y
        let width: CGFloat = 24
        var height: CGFloat = 15
        if frame.origin.x <= contentView.frame.origin.x + 30 {
            x += 30
        }
        if arrowSide == "TOP" {
            if frame.origin.x <= contentView.frame.size.width/2 {
                arrowPath.move(to: CGPoint(x: x + width, y: y))
                arrowPath.addLine(to: CGPoint(x: x + width, y: y - height))
                arrowPath.addQuadCurve(to: CGPoint(x: x + 17, y: y - height), controlPoint: CGPoint(x: (x + width), y: y - height - (width / 3)))
                arrowPath.addLine(to: CGPoint(x: x , y: y))
                arrowPath.addLine(to: CGPoint(x: x + width, y: y))
            } else {
                x += width/2
                if frame.origin.x >= contentView.frame.size.width {
                    x = contentView.frame.size.width - 50
                }
                arrowPath.move(to: CGPoint(x: x, y: y))
                arrowPath.addLine(to: CGPoint(x: x, y: y - height))
                arrowPath.addQuadCurve(to: CGPoint(x: x + width - 17, y: y - height), controlPoint: CGPoint(x: x, y: y - height - (width / 3)))
                arrowPath.addLine(to: CGPoint(x: x + width, y: y))
                arrowPath.addLine(to: CGPoint(x: x, y: y))
            }
        } else {

            y += contentHeight + 20
            x += frame.size.width/4
            if frame.origin.x <= contentView.frame.size.width/2 {
                arrowPath.move(to: CGPoint(x: x, y: y))
                arrowPath.addLine(to: CGPoint(x: x, y: y - 20))
                arrowPath.addLine(to: CGPoint(x: x - 30 , y: y - 20))
                arrowPath.addLine(to: CGPoint(x: x - 5 , y: y - 5))
                arrowPath.addQuadCurve(to: CGPoint(x: x, y: y - 5), controlPoint: CGPoint(x: x - 0.8, y: y - 1))
            } else {
                // need to add reverse triangle if button is on right side
//                x += width/2
//                if frame.origin.x >= contentView.frame.size.width {
//                    x = contentView.frame.size.width - 50
//                }
//                arrowPath.move(to: CGPoint(x: x, y: y))
//                arrowPath.addLine(to: CGPoint(x: x, y: y - height))
//                arrowPath.addLine(to: CGPoint(x: x + width, y: y))
//                arrowPath.addLine(to: CGPoint(x: x, y: y))
            }
        }
        arrowPath.close()
        return arrowPath
    }
    
}


