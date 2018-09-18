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
    lazy var lyricsString: String = lyricsOfSong()
    
    func arrayOfLyrics() -> [String]
    {
        var array: [String] = []
        lyricsString.enumerateLines { line, _ in
            array.append(line)
        }
        return array
    }
    
    private func lyricsOfSong() -> String
    {
        let string =
    """
    夢想的旅途 我背井離鄉
    肩上扛的行囊裝著對未來的夢想
    我和你們一樣 也來自遠方
    做著普通的工作在外漂泊思鄉
    有多少人都希望自己的生活能過得好一點
    能改變自己的歷史 讓父母的壓力小一點
    每逢過節的時候少不了對父母的那份思念
    不能回家因為自己的夢想 還沒有實現
    
    他們的堅強他們的夢 他們的苦只有自己懂
    回不到曾經看不到未來 一切都是那麼的空
    還要一直拚命地走著 用盡全力奮鬥著
    然而這也是我的生活 在夢想之途前進著
    拿起了電話 說媽媽我還好
    我回到了現實 繼續解決我的溫飽
    我被別人說好 也被別人嘲笑
    但從沒被現實打倒 這就是北漂
    
    我飄向北方 別問我家鄉 (別問我家鄉)
    高聳古老的城牆 擋不住憂傷
    我飄向北方 (我飄向北方)
    家人是否無恙 (我夢在前方)
    肩上沉重的行囊 盛滿了惆悵
    也是最後期望
    """
        return string
    }
    
    
}
