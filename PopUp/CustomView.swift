import UIKit

class CustomView: UIView {
    // Outlet for the main view in the XIB
    @IBOutlet weak var contentView: UIView!
    var arcFrame : CGRect!
    var arrowSide: String = "TOP"
    let screenHeight = UIScreen.main.bounds.height
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var btn: UIButton!

    override init(frame: CGRect) {
        arcFrame = frame
        super.init(frame: frame)
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
        let arrowLayer = CAShapeLayer()
        arrowLayer.fillColor = UIColor.black.cgColor
        arrowLayer.lineWidth = 1.0
        layer.addSublayer(arrowLayer)
        if arcFrame != nil {
            arrowLayer.path = createArrowPath(frame: arcFrame!).cgPath
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let labelTextHeight = labelText.systemLayoutSizeFitting(CGSize(width: labelText.bounds.width, height: CGFloat.greatestFiniteMagnitude)).height
        let totalHeight = labelTextHeight + infoText.frame.height + 40
        contentView.frame.size.height = totalHeight
        self.frame.size.height = totalHeight
        
        
        if frame.origin.y + frame.size.height + contentView.frame.size.height > screenHeight {
            arrowSide = "Bottom"
            self.frame = CGRect(x: CGFloat(20), y: frame.origin.y - contentView.bounds.height - 50, width: 300, height: frame.size.height)
        } else {
            self.frame = CGRect(x: CGFloat(20), y: frame.origin.y + 50, width: 300, height: frame.size.height)
        }
        if let arrowLayer = layer.sublayers?.first as? CAShapeLayer {
            arrowLayer.path = createArrowPath(frame: arcFrame).cgPath
        }
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
        layoutSubviews()
    }
    func show() {
        commonInit()
        updateContent(for: curIndex)
    }
    func createArrowPath(frame: CGRect) -> UIBezierPath {
        
        let arrowPath = UIBezierPath()
        var x = contentView.frame.origin.x + frame.origin.x
        var y = contentView.frame.origin.y
        var width: CGFloat = 24
        var height: CGFloat = 15
        if frame.origin.x <= contentView.frame.origin.x + 30 {
            x += 30
        }

//        print(contentView.bounds.w)
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
        return arrowPath
    }
    
    func createDynamicArrowPath(frame: CGRect) -> UIBezierPath {
        var arrowPath = UIBezierPath()
        var originX = frame.origin.x
        var originY = frame.origin.y

        return arrowPath
    }
}


