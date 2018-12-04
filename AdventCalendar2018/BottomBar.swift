//
//  BottomBar.swift
//  AdventCalendar2018
//
//  Created by sato.k on 2018/12/05.
//  Copyright © 2018 jp.dely.KURASHIRU. All rights reserved.
//

import UIKit

@IBDesignable
class BottomBar: UIView {

    static let viewHeight: CGFloat = 49.0

    private(set) var contentView: UIView!

    @IBInspectable
    var borderColor: UIColor? {
        get { return topBorder.backgroundColor }
        set { topBorder.backgroundColor = newValue }
    }

    @IBOutlet weak var topBorder: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        clipsToBounds = false

        let nib = UINib(nibName: "BottomBar", bundle: Bundle(for: type(of: self)))
        contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView

        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.clipsToBounds = false

        borderColor = UIColor.black.withAlphaComponent(0.3)

        addSubview(contentView)
        contentView.addSubview(topBorder)

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.heightAnchor.constraint(equalToConstant: BottomBar.viewHeight)
            ])
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: -1, height: BottomBar.viewHeight)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: BottomBar.viewHeight)
    }

}
