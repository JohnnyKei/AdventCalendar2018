//
//  ViewController.swift
//  AdventCalendar2018
//
//  Created by sato.k on 2018/12/05.
//  Copyright © 2018 jp.dely.KURASHIRU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bottomBar: BottomBar!

    let pageControl = UIPageControl()
    let customPageControl = PageControl()
    let customPageControl2 = PageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let numberOfPages = 3
        let currentPageIndicatorTintColor = UIColor.blue
        let pageIndicatorTintColor = UIColor.blue.withAlphaComponent(0.2)

        pageControl.numberOfPages = numberOfPages
        pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        pageControl.pageIndicatorTintColor = pageIndicatorTintColor

        customPageControl.numberOfPages = numberOfPages
        customPageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        customPageControl.pageIndicatorTintColor = pageIndicatorTintColor

        customPageControl2.dotSize = 12.0
        customPageControl2.dotMargin = 10.0
        customPageControl2.numberOfPages = numberOfPages
        customPageControl2.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        customPageControl2.pageIndicatorTintColor = pageIndicatorTintColor

        let label1 = UILabel()
        label1.textColor = UIColor.darkText
        label1.text = "UIPageControl"
        label1.sizeToFit()

        let label2 = UILabel()
        label2.textColor = UIColor.darkText
        label2.text = "PageControl"
        label2.sizeToFit()

        pageControl.sizeToFit()
        pageControl.center = view.center
        pageControl.center.y -= 80
        view.addSubview(pageControl)

        label1.center = view.center
        label1.frame.origin.y = pageControl.frame.minY - (10 + label1.frame.size.height)
        view.addSubview(label1)

        label2.center = view.center
        label2.frame.origin.y = pageControl.frame.maxY + 40
        view.addSubview(label2)

        customPageControl.sizeToFit()
        customPageControl.center = view.center
        customPageControl.frame.origin.y = label2.frame.maxY + 10
        view.addSubview(customPageControl)

        customPageControl2.sizeToFit()
        customPageControl2.center = view.center
        customPageControl2.frame.origin.y = customPageControl.frame.maxY + 10
        view.addSubview(customPageControl2)

        let stepper = UIStepper()
        stepper.addTarget(self, action: #selector(handleStepChanged(_:)), for: .valueChanged)
        stepper.sizeToFit()
        stepper.center = view.center
        stepper.frame.origin.y = customPageControl2.frame.maxY + 40
        view.addSubview(stepper)

        let bottomBar = BottomBar()
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomBar)
        NSLayoutConstraint.activate([
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -BottomBar.viewHeight),
            bottomBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sample", for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 0.48, blue: 1, alpha: 1), for: .normal)
        bottomBar.contentView.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: bottomBar.contentView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: bottomBar.contentView.centerYAnchor)
            ])
    }


    @objc func handleStepChanged(_ stepper: UIStepper) {
        let page = Int(stepper.value)
        pageControl.currentPage = page
        customPageControl.currentPage = page
        customPageControl2.currentPage = page
    }

}
