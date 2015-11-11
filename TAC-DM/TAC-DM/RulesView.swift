//
//  RulesView.swift
//  TAC-DM
//
//  Created by Apple Club on 15/11/11.
//  Copyright © 2015年 TAC. All rights reserved.
//

import UIKit
import CoreText

class RulesView: UIView {

    override func drawRect(rect: CGRect)
    {
        super.drawRect(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetTextMatrix(context, CGAffineTransformIdentity)
        CGContextTranslateCTM(context, 0, self.bounds.size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        
        let path = CGPathCreateMutable()
        
        CGPathAddRect(path, nil ,self.bounds)
        
        let attString = NSAttributedString(string: "Tongji Apple Club 设备借还通知")
        
        let frameSetter = CTFramesetterCreateWithAttributedString(attString)
       
        
        let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attString.length), path, nil)
        
        CTFrameDraw(frame, context!);
        
        
    }

}
