//
//  KKTextLayerProvider.swift
//  Lyrics
//
//  Created by Tingwei Hsu on 2018/9/19.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

import Foundation
import UIKit

class KKTextLayerManager
{
    private(set) var textLayerArray: [KKTextLayer] = []
    var totalHeightOfLayers: CGFloat = 0
    private let provider: LyricsProvider
    private let configuration: KKTextLayerConfiguration
    private var tempOriginPoint: CGPoint
    
    init(lyricProvider: LyricsProvider = LyricsProvider(), textLayerConfiguration: KKTextLayerConfiguration, staredOriginInScrollView: CGPoint)
    {
        self.provider = lyricProvider
        self.configuration = textLayerConfiguration
        self.tempOriginPoint = staredOriginInScrollView
        createTextLayers()
    }
    
    private func createTextLayers()
    {
        provider.lyricsArray().forEach { lyric in
            let textLayer = KKTextLayer()
            textLayer.configuration = self.configuration
            textLayer.string = lyric
            textLayer.alignmentMode = kCAAlignmentCenter
            textLayer.frame = CGRect(origin: tempOriginPoint, size: textLayer.bounds.size)
            textLayerArray.append(textLayer)
            tempOriginPoint = CGPoint(x: tempOriginPoint.x, y: tempOriginPoint.y + textLayer.bounds.height)
            totalHeightOfLayers += textLayer.bounds.height
        }
    }
    
    func frameOfHighlightLyrics(onLine line:Int) -> CGRect?
    {
        guard line >= 0 && line < textLayerArray.count else {
            return nil
        }
        textLayerArray[line].isHighlight = true
        return textLayerArray[line].frame
    }
    
    func frameOfUnhighlightLyrics(onLine line:Int) -> CGRect?
    {
        guard line >= 0 && line < textLayerArray.count else {
            return nil
        }
        textLayerArray[line].isHighlight = false
        return textLayerArray[line].frame
    }

}
