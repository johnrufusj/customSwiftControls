//
//  BubbleSegmentedConrol.swift
//
//  Created by John Johnson on 11/13/15.
//

import UIKit

@IBDesignable class BubbleSegmentedControl: UIControl{
    
    private var labels = [UILabel]()
    var selectedView = UIView()
    
    var items:[UIColor] = [UIColor.greenColor(), UIColor.yellowColor(), UIColor.redColor()] {
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
        
        for  index in 1...items.count{
            let label = UILabel(frame: CGRectZero)
     
            label.textAlignment = .Center
            label.layer.borderWidth = 2
            label.backgroundColor = UIColor.whiteColor()
            
            label.layer.borderColor = items[index - 1].CGColor
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
        
        selectedView.backgroundColor =  items[0]
        selectedView.layer.cornerRadius =  18
    
        let labelHeight = self.bounds.height
        let labelWidth = self.bounds.width / CGFloat(labels.count)
        
        for index in 0...labels.count - 1 {
            let label = labels[index]
            
            let xPosition = CGFloat(index) * labelWidth
            label.frame = CGRectMake(xPosition, 0, labelWidth, labelHeight)
            
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 18
            label.clipsToBounds = true
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
        let label = labels[selectedIndex]
        self.selectedView.backgroundColor = items[selectedIndex]
        self.selectedView.frame = label.frame
    }
    
    
 
}
