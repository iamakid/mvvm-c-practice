//
//  UIColor+image.swift
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/6/4.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
