//
//  LyricsProvider.swift
//  Lyrics
//
//  Created by Tingwei Hsu on 2018/9/18.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

import Foundation

class LyricsProvider
{
    lazy var rawLyrics: String = lyricsOfSong()
    
    func lyricsArray() -> [String]
    {
        var array: [String] = []
        rawLyrics.enumerateLines { line, _ in
            array.append(line)
        }
        return array
    }
    
    private func lyricsOfSong() -> String
    {
        let string =
    """
    菸一支一支一支的點
    酒一杯一杯一杯的乾
    請你要體諒我
    我酒量不好賣尬哇衝康
    時間一天一天一天的走
    汗一滴一滴一滴的流
    有一天 咱都老 帶某子逗陣
    浪子回頭

    親愛的 可愛的 英俊的 朋友
    垃圾的 沒品的 沒路用的 朋友

    佇坎坷的路騎我兩光摩托車
    橫直我的人生甘哪狗屎
    我沒錢沒某沒子甘哪一條命
    朋友阿 逗陣來搏

    菸一支一支一支的點
    酒一杯一杯一杯的乾
    請你要體諒我
    我酒量不好賣給我衝康
    時間一天一天一天的走
    汗一滴一滴一滴的流
    有一天 咱都老 帶某子逗陣
    浪子回頭
    """
        return string
    }
    
    
}
