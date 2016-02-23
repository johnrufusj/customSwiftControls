//
//  UnderlineSegmentedControl.swift
//
//  Created by John Johnson on 11/13/15.
//

import UIKit

@IBDesignable class UnderlineSegmentedControl: UIControl{
    
    private var labels = [UILabel]()
    var selectedView = UIView()
    
    var labelColor = UIColor.blackColor()
    var labelFont = UIFont (name: "HelveticaNeue", size: 18)
    var selectedFont = UIFont (name: "HelveticaNeue-Bold", size: 18)
    var selectedColor = UIColor.redColor()
    var underlineColor = UIColor.blackColor()
    var showUnderline = true
    
    var items:[String] = ["Label 1", "Label 2", "Label 3"] {
        didSet{
            setupLabels()
        }
    }
    
    var selectedIndex : Int = 0 {
        didSet{
            displayNewSelectedIndex()
        }
    }
    
    
    func setupView(){
        backgroundColor = UIColor.clearColor()
        
        setupLabels()
        addSubview(selectedView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
   func setupLabels(){
        for label in labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll(keepCapacity: true)
        
        for _ in 1...items.count{
            let label = UILabel(frame: CGRectZero)
     
            label.textAlignment = .Center
            label.layer.borderWidth = 0
            label.backgroundColor = UIColor.clearColor()
            label.textColor = labelColor
            label.font = labelFont
            
            self.addSubview(label)
            labels.append(label)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var selectedFrame = self.bounds
        let newWidth = CGRectGetWidth(selectedFrame) / CGFloat(items.count)
        selectedFrame.size.width = newWidth
        selectedView.frame = selectedFrame
        
        let labelHeight = self.bounds.height
        let labelWidth = self.bounds.width / CGFloat(labels.count)
        
        for index in 0...labels.count - 1 {
            let label = labels[index]
            label.text =  items[index]
        
    let xPosition = CGFloat(index) * labelWidth
            label.frame = CGRectMake(xPosition, 0, labelWidth, labelHeight)

        }
    }
    
    
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        
        let location = touch.locationInView(self)
        
        var calculatedIndex : Int?
        
        for(index, item) in labels.enumerate(){
            if item.frame.contains(location){
                calculatedIndex = index
            }
        }
        
        if calculatedIndex != nil{
            selectedIndex = calculatedIndex!
            sendActionsForControlEvents(.ValueChanged)
        }
        
        return false
        
    }
    
    func displayNewSelectedIndex(){
        labels.map {
            $0.textColor = labelColor
            $0.font = labelFont
        }
        
        let label = labels[selectedIndex]
        label.textColor = selectedColor
        label.font = selectedFont
       
        if showUnderline{
            let bottomBorder = CALayer()
            bottomBorder.backgroundColor = underlineColor.CGColor
            bottomBorder.frame = CGRectMake(0, label.frame.size.height, label.frame.size.width, 1)
            self.selectedView.layer.addSublayer(bottomBorder)
        }
        
        
        self.selectedView.frame = label.frame
    }
    
    
 
}
