//
//  TestManager.swift
//  LyricsTests
//
//  Created by Tingwei Hsu on 2018/9/19.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

import XCTest
@testable import Lyrics

class TestManager: XCTestCase {
    
    let stubConfig = KKTextLayerConfiguration(
        fontSize: 15,
        backgroundColor: UIColor.blue.cgColor,
        foregroundColor: UIColor.black.cgColor,
        highlightBgColor: UIColor.brown.cgColor,
        highlightFgColor: UIColor.cyan.cgColor,
        layerWidth: 30,
        layerHeight: 20)
    
    let stubProvider = LyricsProvider()
    
    let stubOrigin = CGPoint(x: 6, y: 6)
    
    var manager: KKTextLayerManager!
    
    override func setUp()
    {
        super.setUp()
        stubProvider.rawLyrics =
        """
        test1
        
        test2
        hao123
        """
        self.manager = KKTextLayerManager(lyricProvider: stubProvider,
                                          textLayerConfiguration: stubConfig,
                                          staredOriginInScrollView: stubOrigin)
    }
    
    override func tearDown() {
        self.manager = nil
        super.tearDown()
    }

    
    func testManagerCeateTextLayerArray() {
        var lineCount = 0
        
        stubProvider.rawLyrics.enumerateLines { line, _ in
            let textLayer = self.manager.textLayerArray[lineCount]
            XCTAssertEqual(line, textLayer.string as? String)
            XCTAssertFalse(textLayer.isHighlight)
            guard let config = textLayer.configuration else {
                XCTFail("textLayer must have config via manager init")
                return
            }
            XCTAssertEqual(textLayer.frame,
                           CGRect(x: self.stubOrigin.x,
                                  y: self.stubOrigin.y + self.stubConfig.layerHeight * CGFloat(lineCount),
                                  width: self.stubConfig.layerWidth,
                                  height: self.stubConfig.layerHeight))
            XCTAssertEqual(textLayer.backgroundColor, config.backgroundColor)
            XCTAssertEqual(textLayer.foregroundColor, config.foregroundColor)
            XCTAssertEqual(textLayer.bounds.height, config.layerHeight)
            XCTAssertEqual(textLayer.bounds.width, config.layerWidth)
            lineCount += 1
        }
    }
    
    func testMangagerHighlightIndex()
    {
        for (index, element) in manager.textLayerArray.enumerated() {
            XCTAssertEqual(element.frame, manager.frameOfHighlightLyrics(onLine: index))
            XCTAssertTrue(element.isHighlight)
            if let text = element.string as? String, text.count > 0 {
                XCTAssertEqual(element.backgroundColor, self.stubConfig.highlightBgColor)
                XCTAssertEqual(element.foregroundColor, self.stubConfig.highlightFgColor)
            } else {
                XCTAssertEqual(element.backgroundColor, self.stubConfig.backgroundColor)
                XCTAssertEqual(element.foregroundColor, self.stubConfig.foregroundColor)
            }
        }
    }
    
    func testMangagerUnhighlightIndex()
    {
        for (index, element) in manager.textLayerArray.enumerated() {
            XCTAssertEqual(element.frame, manager.frameOfUnhighlightLyrics(onLine: index))
            XCTAssertFalse(element.isHighlight)
            XCTAssertEqual(element.backgroundColor, self.stubConfig.backgroundColor)
            XCTAssertEqual(element.foregroundColor, self.stubConfig.foregroundColor)
        }
    }
    
}
