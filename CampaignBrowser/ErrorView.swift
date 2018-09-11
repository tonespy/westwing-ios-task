//
//  ErrorView.swift
//  CampaignBrowser
//
//  Created by Abubakar Oladeji on 11/09/2018.
//  Copyright © 2018 Westwing GmbH. All rights reserved.
//

import UIKit

class ErrorView: UIView {

    /*
     Base view
     */
    let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.elevate(elevation: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /*
     Message label
     */
    let errorMessage: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = Constants.DEFAULT_ERROR_MESSAGE
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /*
     Retry button
     */
    lazy var retryBtn: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.RETRY_TITLE, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = UIColor.red
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.contentHorizontalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /*
     Retry helper
     */
    var performRetry: (() -> Void)?
    
    struct Constants {
        static let DEFAULT_ERROR_MESSAGE = "There was an error. Please check your internet connection and try again."
        static let RETRY_TITLE = "Retry"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    /*
     Layout function for laying out views after initialization
     */
    func setupViews() {
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        addSubview(baseView)
        
        baseView.widthAnchor.constraint(equalTo: widthAnchor, constant: -64).isActive = true
        baseView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        baseView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        baseView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        baseView.addSubview(errorMessage)
        baseView.addSubview(retryBtn)
        
        errorMessage.bottomAnchor.constraint(equalTo: baseView.centerYAnchor, constant: -8).isActive = true
        errorMessage.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        errorMessage.widthAnchor.constraint(equalTo: baseView.widthAnchor, constant: -32).isActive = true
        
        retryBtn.topAnchor.constraint(equalTo: baseView.centerYAnchor, constant: 8).isActive = true
        retryBtn.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        retryBtn.widthAnchor.constraint(equalTo: baseView.widthAnchor, constant: -64).isActive = true
        retryBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        retryBtn.addTarget(self, action: #selector(retry(_:)), for: .touchUpInside)
    }
    
    /*
     Action for retrying failed request
     */
    @IBAction func retry(_ sender: UIButton) {
        performRetry?()
    }

}
