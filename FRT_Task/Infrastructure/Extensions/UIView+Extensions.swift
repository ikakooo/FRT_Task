//
//  UIView+Extensions.swift
//  FRT_Task
//
//  Created by Irakli Chkhitunidzde on 01.04.22.
//

import UIKit

extension UIView {
    func mySkeletonAnimation(){
        self.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .gray, secondaryColor: .white), animation: nil, transition: .crossDissolve(0.25))
    }
}
