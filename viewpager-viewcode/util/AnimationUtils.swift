//
//  AnimationUtils.swift
//  viewpager-viewcode
//
//  Created by Wallace Baldenebre on 27/11/21.
//

import Foundation
import UIKit

func animatePresentationView(
    viewTarget: UIView,
    duration: CGFloat,
    startAlpha: CGFloat,
    finalAlpha: CGFloat,
    completion: @escaping () -> Void
) {
    viewTarget.alpha = startAlpha
    UIView.animate(withDuration: duration) {
        viewTarget.alpha = finalAlpha
        completion()
    }
}

func animateDismissView(
    context: UIViewController,
    viewTarget: UIView,
    duration: CGFloat,
    startAlpha: CGFloat,
    finalAlpha: CGFloat
) {
    viewTarget.alpha = startAlpha
    UIView.animate(withDuration: duration) {
        viewTarget.alpha = finalAlpha
    } completion: { _ in
        context.dismiss(animated: false)
    }
    
    context.view.layoutIfNeeded()
}
