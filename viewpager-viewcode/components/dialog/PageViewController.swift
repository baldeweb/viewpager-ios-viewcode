//
//  PageViewController.swift
//  ViewPager-ViewCode
//
//  Created by Wallace Baldenebre on 27/11/21.
//

import Foundation
import UIKit

open class PageViewController: UIViewController {
    
    open lazy var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    open lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    open lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    open lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 15)
        label.sizeToFit()
        return label
    }()
    
    open var image: UIImageView!
    open var icon: UIImage!
    private let maxDimmedAlpha: CGFloat = 0.6

    
    open var titleText: String?
    open var descriptionText: String?
    private var titleActionButton: String? = ""
    private var actionButton: (() -> Void)?
    
    init?(
        icon: UIImage,
        titleText: String,
        descriptionText: String,
        titleActionButton: String? = nil,
        actionButton: (() -> Void)? = nil
    ) {
        super.init(nibName: nil, bundle: nil)
        self.icon = icon
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.titleActionButton = titleActionButton
        self.actionButton = actionButton
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addViewComponents()
        setupConstraints()
    }
    
    private func setupView() {
        image = UIImageView(image: icon)
        self.titleLabel.text = titleText
        self.descriptionLabel.text = descriptionText
    }
    
    private func addViewComponents() {
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        containerView.addSubview(contentView)
        
        view.addSubview(containerView)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.greaterThanOrEqualTo(0)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(34)
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(0)
            make.height.greaterThanOrEqualTo(0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.width.greaterThanOrEqualTo(0)
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.width.greaterThanOrEqualTo(0)
            make.height.greaterThanOrEqualTo(0)
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
        }
    }
}
