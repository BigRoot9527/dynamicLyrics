//
//  ViewController.swift
//  Lyrics
//
//  Created by Tingwei Hsu on 2018/9/18.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var lyricsScrollView: UIScrollView!
    //gradientLayer
    private var gradientMaskLayer: CAGradientLayer = CAGradientLayer()
    private let fadePercentage: Double = 0.2
    //KKTextLayer
    private var textLayerArray: [KKTextLayer] = []
    private let heightForLyricsLine: CGFloat = 30.0
    private let textLayerFontSize: CGFloat = 16
    //playing
    private var playingLineIndex: Int = 0

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupTextLayer()
        setupLyricsScrollView()
        setupGradientLayer()
    }

    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        lyricsScrollView.contentSize = CGSize(
                width: lyricsScrollView.frame.width,
                height: heightForLyricsLine * CGFloat(textLayerArray.count)
        )
        for (index, element) in textLayerArray.enumerated() {
            let x: CGFloat = lyricsScrollView.bounds.minX
            let y: CGFloat = heightForLyricsLine * CGFloat(index)
            let h: CGFloat = heightForLyricsLine
            let w: CGFloat = lyricsScrollView.bounds.width
            element.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        updateGradientLayerFrame()
    }
    
    private func setupTextLayer()
    {
        let provider = LyricsProvider()
        provider.lyricsArray().forEach { lyric in
            let textLayer = KKTextLayer()
            textLayer.string = lyric
            textLayer.fontSize = textLayerFontSize
            textLayer.alignmentMode = kCAAlignmentCenter
            textLayer.backgroundColor = lyricsScrollView.backgroundColor?.cgColor
            textLayerArray.append(textLayer)
            lyricsScrollView.layer.addSublayer(textLayer)
        }
    }
    
    private func setupGradientLayer()
    {
        let transparent = UIColor.clear.cgColor
        let opaque = self.view.backgroundColor!.cgColor
        gradientMaskLayer.colors = [transparent, opaque, opaque, transparent]
        gradientMaskLayer.locations = [0, NSNumber(floatLiteral: fadePercentage), NSNumber(floatLiteral: 1 - fadePercentage), 1]
        self.lyricsScrollView.layer.mask = gradientMaskLayer
    }
    
    private func setupLyricsScrollView()
    {
        lyricsScrollView.showsVerticalScrollIndicator = false
        lyricsScrollView.delegate = self
        lyricsScrollView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 60, right: 0)
    }
    
    private func updateGradientLayerFrame()
    {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        gradientMaskLayer.frame = CGRect(
            x: 0,
            y: lyricsScrollView.contentOffset.y,
            width: lyricsScrollView.bounds.width,
            height: lyricsScrollView.bounds.height
        )
        CATransaction.commit()
    }

    @IBAction func didTapPlayButton(_ sender: UIButton)
    {
        Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { [weak self](_) in
            self?.playNextLine()
        }
        sender.isEnabled = false
    }
    
    private func playNextLine()
    {
        let index:Int = playingLineIndex < textLayerArray.count ? playingLineIndex : 0
        highlightLyrics(onLine: index)
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self](_) in
            self?.unHighlightLyrics(onLine: index)
        }
        playingLineIndex = index + 1
    }
    
    private func highlightLyrics(onLine line:Int)
    {
        guard line >= 0 && line < textLayerArray.count else {
            return
        }
        textLayerArray[line].isHighlight = true
        lyricsScrollView.scrollRectToCenter(rect: textLayerArray[line].frame, animated: true)
    }
    
    private func unHighlightLyrics(onLine line:Int)
    {
        guard line >= 0 && line < textLayerArray.count else {
            return
        }
        textLayerArray[line].isHighlight = false
    }
}

extension ViewController: UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        updateGradientLayerFrame()
    }
}

