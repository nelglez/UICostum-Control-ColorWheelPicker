//
//  ColorWheel.swift
//  ColorPicker
//
//  Created by Nelson Gonzalez on 5/21/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
//This is really just a view
@IBDesignable class ColorWheel: UIControl {
    
    var color: UIColor = .white

    override func layoutSubviews() {
        super.layoutSubviews()
        
        //gets called after the drawing occurs, like the view did load of views

        clipsToBounds = true //outside of the corner radius not gets shown
        
        layer.cornerRadius = frame.width / 2
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        //How would we go through and get each point in this view? CGPoint..
        
        for x in stride(from: 0, to: bounds.maxX, by: 1) {
            for y in stride(from: 0, to: bounds.maxY, by: 1) {
              let rectColor = color(for: CGPoint(x: x, y: y))
                
                let squarePixel = CGRect(x: x, y: y, width: 1, height: 1)
                
                rectColor.setFill()
                
                UIRectFill(squarePixel)
                
            }
        }
    }
  
    func color(for location: CGPoint) -> UIColor {
        //The center of the color wheel
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        let dy = location.y - center.y
        let dx = location.x - center.x
        
        //the offset
        let offset = CGSize(width: dx / center.x, height: dy / center.y)
        //Fix for black pixel in the middle of the circle.
        if offset == CGSize.zero {
            return UIColor(hue: 0, saturation: 0, brightness: 0.8, alpha: 1.0)
        }
        let (hue, saturation) = Color.getHueSaturation(at: offset)
        
        return UIColor(hue: hue, saturation: saturation, brightness: 0.8, alpha: 1.0)
    }
    
    
    
    //MARK: -Handle touch events and send actions to the target (the view controller)
    
    //This gets called on the initial touch to the control.
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        //get the touch point where i touch in this color wheel view
        let touchPoint = touch.location(in: self) //40, 90
        //get color for this location
        let touchedColor = color(for: touchPoint) //What do we want to do with this color?
        //every time i begin tracking this touch i will set the views color to this color
        self.color = touchedColor
        
        //Try to send as many actions as possible (that makes sense)
        sendActions(for: [.valueChanged, .touchDown])
        
        return true
    }
    
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
       
        //get the touch point where i touch in this color wheel view
        let touchPoint = touch.location(in: self) //40, 90
        //get color for this location
        let touchedColor = color(for: touchPoint) //What do we want to do with this color?
        
        if bounds.contains(touchPoint) {
        
        //every time i begin tracking this touch i will set the views color to this color
        self.color = touchedColor
        
        //Try to send as many actions as possible (that makes sense)
        sendActions(for: [.touchDragInside, .valueChanged])
        } else {
            sendActions(for: [.touchDragOutside])
        }
        
        return true
    }
    
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        //calls A chunck of code that runs right before the function returns. This gets called when the function returns, no matter if return is called early or the method just finishes.
        defer {
            super.endTracking(touch, with: event)
        }
       
        //get the touch point where i touch in this color wheel view
        guard let touchPoint = touch?.location(in: self) else { return } //40, 90
        //get color for this location
        let touchedColor = color(for: touchPoint) //What do we want to do with this color?
        
        if bounds.contains(touchPoint) {
            
            //every time i begin tracking this touch i will set the views color to this color
            self.color = touchedColor
            
            //Try to send as many actions as possible (that makes sense)
            sendActions(for: [.touchDragInside, .valueChanged])
        } else {
            sendActions(for: [.touchDragOutside])
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
       //Used to reset your control if applicable. get a phone call, etc
        sendActions(for: .touchCancel)
    }
}
