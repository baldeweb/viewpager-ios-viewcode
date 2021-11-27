//
//  JumpButton.swift
//  ViewPager-ViewCode
//
//  Created by Wallace Baldenebre on 27/11/21.
//

import Foundation
import UIKit

open class JumpButton: Button {
    override init(context: UIViewController, title: String, selector: Selector) {
        super.init(context: context, title: title, selector: selector)
        button?.setTitle(title, for: .normal)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func build() -> UIButton {
        button?.setTitleColor(.white, for: .normal)
        button?.layer.cornerRadius = 25
        button?.layer.masksToBounds = true
        button?.backgroundColor = .systemBlue
        return button!
    }
    
}
