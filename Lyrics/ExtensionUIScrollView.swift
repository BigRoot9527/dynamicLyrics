//
//  ExtensionUIScrollView.swift
//  Lyrics
//
//  Created by Tingwei Hsu on 2018/9/18.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView
{
    func scrollRectToCenter(rect visibleRect: CGRect, animated: Bool)
    {
        let centeredRect: CGRect = CGRect(
            x: visibleRect.origin.x + visibleRect.size.width/2.0 - self.frame.size.width/2.0,
            y: visibleRect.origin.y + visibleRect.size.height/2.0 - self.frame.size.height/2.0,
            width: self.frame.size.width,
            height: self.frame.size.height
        )
        self.scrollRectToVisible(centeredRect, animated: animated)
    }
}
