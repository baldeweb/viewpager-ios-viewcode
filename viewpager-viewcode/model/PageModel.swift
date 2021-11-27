//
//  PageModel.swift
//  ViewPager-ViewCode
//
//  Created by Wallace Baldenebre on 27/11/21.
//

import Foundation
import UIKit

public struct PageModel {
    var icon: UIImage!
    var title: String!
    var description: String!
    var titleButton: String!
    var actionButton: (() -> Void)?
}
