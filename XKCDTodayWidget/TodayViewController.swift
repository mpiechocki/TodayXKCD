//
//  TodayViewController.swift
//  XKCDTodayWidget
//
//  Created by Mikolaj Piechocki on 01/10/2018.
//  Copyright © 2018 Mikolaj Piechocki. All rights reserved.
//

import UIKit
import NotificationCenter

@objc (TodayViewController)

class TodayViewController: UIViewController, NCWidgetProviding {

    let maxSize = CGSize(width: 320, height: 400)
    let minSize = CGSize(width: 320, height: 50)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }

    override func loadView() {
        let view = XKCDWidgetView()
        self.view = view
    }

    private var xkcdWidgetView: XKCDWidgetView! {
        return view as? XKCDWidgetView
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }

    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let expanded = activeDisplayMode == .expanded
        preferredContentSize = expanded ? maxSize : minSize
    }
    
}
