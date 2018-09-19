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
    private let staredPointYInScrollView: CGFloat = 0
    private var manager: KKTextLayerManager!
    //playing
    private var playingLineIndex: Int = 0

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupLyricsScrollView()
        setupGradientLayer()
    }

    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        setupManager()
        lyricsScrollView.contentSize = CGSize(
                width: lyricsScrollView.frame.width,
                height: manager.totalHeightOfLayers
        )
        updateGradientLayerFrame()
    }
    
    private func setupManager()
    {
        let config = KKTextLayerConfiguration(
            fontSize: 16,
            backgroundColor: lyricsScrollView.backgroundColor!.cgColor,
            foregroundColor: UIColor.white.cgColor,
            highlightBgColor: UIColor.white.cgColor,
            highlightFgColor: UIColor.black.cgColor,
            layerWidth: lyricsScrollView.bounds.width,
            layerHeight: 30)
        let staredOrigin = lyricsScrollView.bounds.origin
        manager = KKTextLayerManager(textLayerConfiguration: config, staredOriginInScrollView: staredOrigin)
        manager.textLayerArray.forEach { layer in
            lyricsScrollView.layer.addSublayer(layer)
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
        let index: Int = playingLineIndex < manager.textLayerArray.count ? playingLineIndex : 0
        guard let rect = manager.frameOfHighlightLyrics(onLine: index) else { return }
        lyricsScrollView.scrollRectToCenter(rect: rect, animated: true)
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self](_) in
            let _ = self?.manager.frameOfUnhighlightLyrics(onLine: index)
        }
        playingLineIndex = index + 1
    }
}

extension ViewController: UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        updateGradientLayerFrame()
    }
}

