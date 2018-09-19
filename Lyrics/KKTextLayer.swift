//
//  KKTextLayer.swift
//  Lyrics
//
//  Created by Tingwei Hsu on 2018/9/18.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

import Foundation
import UIKit

struct KKTextLayerConfiguration
{
    let fontSize: CGFloat
    let backgroundColor: CGColor
    let foregroundColor: CGColor
    let highlightBgColor: CGColor
    let highlightFgColor: CGColor
    let layerWidth: CGFloat
    let layerHeight: CGFloat
}


class KKTextLayer: CATextLayer
{
    var configuration: KKTextLayerConfiguration?
    {
        didSet{
            setup()
        }
    }
    
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
    
    private func setup()
    {
        guard let config = self.configuration else { return }
        self.fontSize = config.fontSize
        self.foregroundColor = config.foregroundColor
        self.backgroundColor = config.backgroundColor
        self.bounds = CGRect(x: 0, y: 0, width: config.layerWidth, height: config.layerHeight)
    }
    
    override func draw(in ctx: CGContext)
    {
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
        guard
            let config = self.configuration,
            let text = self.string as? String,
            text.count > 0
            else { return }
        self.backgroundColor = isHighlight ? config.highlightBgColor : config.backgroundColor
        self.foregroundColor = isHighlight ? config.highlightFgColor : config.foregroundColor
    }
    
}
