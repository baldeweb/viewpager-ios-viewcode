//
//  PageButton.swift
//  ViewPager-ViewCode
//
//  Created by Wallace Baldenebre on 27/11/21.
//

import Foundation
import UIKit

open class PageButton: Button {
    
    override init(context: UIViewController, title: String, selector: Selector) {
        super.init(context: context, title: title, selector: selector)
        button?.setTitle(title, for: .normal)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func build() -> UIButton {
        button?.setTitleColor(.blue, for: .normal)
        button?.backgroundColor = .white
        return button!
    }
}
