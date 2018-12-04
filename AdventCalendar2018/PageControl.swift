//
//  PageControl.swift
//  AdventCalendar2018
//
//  Created by sato.k on 2018/12/05.
//  Copyright © 2018 jp.dely.KURASHIRU. All rights reserved.
//

import UIKit

@IBDesignable
class PageControl: UIControl {

    @IBInspectable
    var numberOfPages: Int {
        get {
            return _numberOfPages
        }
        set {
            if newValue >= 0 {
                _numberOfPages = newValue
                dots.forEach { $0.removeFromSuperview() }
                dots = (0..<newValue).map({ (_) -> UIView in
                    let dot = UIView()
//                    dot.isUserInteractionEnabled = false
                    addSubview(dot)
                    return dot
                })
                applyPageIndicatorColor()
                setNeedsDisplay()
            }
        }
    }
    private var _numberOfPages: Int = 0

    @IBInspectable
    var currentPage: Int {
        get {
            return _currentPage
        }
        set {
            if (0..<numberOfPages).contains(newValue) {
                _currentPage = newValue
                applyPageIndicatorColor()
            }
        }
    }

    private var _currentPage = 0

    var hidesForSinglePage: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable
    var dotSize: CGFloat = 7.0 {
        didSet {
            setNeedsDisplay()
            invalidateIntrinsicContentSize()
        }
    }

    @IBInspectable
    var dotMargin: CGFloat = 9.0 {
        didSet {
            setNeedsDisplay()
            invalidateIntrinsicContentSize()
        }
    }

    var defersCurrentPageDisplay: Bool = false

    func updateCurrentPageDisplay() {
        if defersCurrentPageDisplay { return }
        applyPageIndicatorColor()
    }


    func size(forNumberOfPages pageCount: Int) -> CGSize {
        let height = (15.0 * 2) + dotSize
        guard pageCount > 0 else {
            return CGSize(width: dotSize, height: height)
        }
        let width = dotSize * CGFloat(pageCount) + dotMargin * CGFloat(pageCount - 1)
        return CGSize(width: width, height: height)
    }

    @IBInspectable
    var pageIndicatorTintColor: UIColor? {
        didSet {
            applyPageIndicatorColor()
        }
    }

    @IBInspectable
    var currentPageIndicatorTintColor: UIColor? {
        didSet {
            applyPageIndicatorColor()
        }
    }

    private var dots: [UIView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        pageIndicatorTintColor = UIColor.white
        currentPageIndicatorTintColor = UIColor.white.withAlphaComponent(0.2)
    }

    private func commonInit() {
        clipsToBounds = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if dots.count == 1 && hidesForSinglePage {
            dots.first?.isHidden = true
            return
        }
        let baseX = (bounds.width - size(forNumberOfPages: numberOfPages).width)/2
        dots.enumerated().forEach { (index, dot) in
            dot.isHidden = false
            dot.frame.origin.x = baseX + CGFloat(index) * (dotMargin + dotSize)
            dot.frame.size = CGSize(width: dotSize, height: dotSize)
            dot.center.y = bounds.height/2
            dot.layer.cornerRadius = dotSize/2
        }
    }

    override var intrinsicContentSize: CGSize {
        if numberOfPages == 0 {
            return .zero
        } else {
            return self.size(forNumberOfPages: numberOfPages)
        }
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        if numberOfPages == 0 {
            return .zero
        } else {
            return self.size(forNumberOfPages: numberOfPages)
        }
    }

    private func applyPageIndicatorColor() {
        dots.enumerated().forEach { (offset, dot) in
            if offset == currentPage {
                dot.backgroundColor = currentPageIndicatorTintColor
            } else {
                dot.backgroundColor = pageIndicatorTintColor
            }
        }
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let touchPoint = touch?.location(in: self), bounds.contains(touchPoint) else {
            return
        }
        let currentDot = dots[currentPage]
        let newPage: Int
        if touchPoint.x > currentDot.frame.maxX {
            newPage = currentPage + 1
        } else if touchPoint.x < currentDot.frame.minX {
            newPage = currentPage - 1
        } else {
            return
        }
        // for call valueChanged
        if (0..<numberOfPages).contains(newPage) {
            _currentPage = newPage
            updateCurrentPageDisplay()
            sendActions(for: .valueChanged)
        }
    }

}
