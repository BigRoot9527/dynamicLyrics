//
//  KKTextLayer.swift
//  Lyrics
//
//  Created by Tingwei Hsu on 2018/9/18.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

import Foundation
import UIKit

class KKTextLayer: CATextLayer
{
    
    var isHighlight: Bool
    {
        didSet{
            changeColor()
        }
    }
    
    override init()
    {
        isHighlight = false
        super.init()
    }
    
    override init(layer: Any)
    {
        isHighlight = false
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(in ctx: CGContext) {
        
        let height: CGFloat = self.bounds.size.height
        let fontSize: CGFloat = self.fontSize
        let yDiff = (height - fontSize) / 2 - fontSize / 6
        ctx.saveGState()
        ctx.translateBy(x: 0.0, y: yDiff)
        super.draw(in: ctx)
        ctx.restoreGState()
    }

    private func changeColor()
    {
        guard let text = self.string as? String, text.count > 0 else {
            return
        }
        self.backgroundColor = isHighlight ? UIColor.white.cgColor : UIColor.clear.cgColor
        self.foregroundColor = isHighlight ? UIColor.black.cgColor : UIColor.white.cgColor
    }
    
}
