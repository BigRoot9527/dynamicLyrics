//
//  TestLyricsProvider.swift
//  LyricsTests
//
//  Created by Tingwei Hsu on 2018/9/19.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

import XCTest
@testable import Lyrics

class TestLyricsProvider: XCTestCase
{
    
    var provider = LyricsProvider()
    
    func testLyricsProviderWithEmptyString()
    {
        provider.rawLyrics = ""
        XCTAssertEqual(provider.lyricsArray().count, 1)
        XCTAssertEqual(provider.lyricsArray()[0], provider.noLyricsMessage)
    }
    
    func testLyricsProviderWithOneLineOfString()
    {
        let textString = "test"
        provider.rawLyrics = textString
        XCTAssertEqual(provider.lyricsArray().count, 1)
        XCTAssertEqual(provider.lyricsArray()[0], textString)
    }
    
    func testLyricsProviderWithMutipleLinesOfString()
    {
        let textString =
            """
            hello
            world
            666666
            hao123
            中文
            @*#@$)!@#
            """
        provider.rawLyrics = textString
        var lineCount = 0
        textString.enumerateLines { line, _ in
            XCTAssertEqual(line, self.provider.lyricsArray()[lineCount])
            lineCount += 1
        }
        

    }

    
}
