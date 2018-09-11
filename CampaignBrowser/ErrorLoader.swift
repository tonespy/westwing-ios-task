//
//  ErrorLoader.swift
//  CampaignBrowser
//
//  Created by Abubakar Oladeji on 11/09/2018.
//  Copyright © 2018 Westwing GmbH. All rights reserved.
//

import UIKit

class ErrorLoader: NSObject {
    
    static let sharedInstance = ErrorLoader()
    
    var popupView : ErrorView!
    
    typealias RetryErrorCompletion = () -> ()
    
    private func showPopup(completion: @escaping RetryErrorCompletion) {
        hidePopup()
        
        var vc = UIApplication.shared.keyWindow?.rootViewController
        while let presentedViewController = vc!.presentedViewController {
            vc = presentedViewController
        }
        
        self.popupView = ErrorView(frame: vc!.view.frame)
        vc!.view.addSubview(self.popupView)
        vc!.view.bringSubview(toFront: self.popupView)
        vc!.view.backgroundColor = UIColor.black
        self.popupView.performRetry = {
            completion()
            self.hidePopup()
        }
    }
    
    func hidePopup() {
        if popupView != nil && popupView.superview != nil {
            self.popupView.removeFromSuperview()
        }
    }
    
    func isLoaderVisible() -> Bool {
        return popupView != nil
    }
    
    func genericInitialze(show: Bool, completion: @escaping RetryErrorCompletion) {
        if show {
            showPopup(completion: completion)
        } else {
            hidePopup()
        }
    }
}
