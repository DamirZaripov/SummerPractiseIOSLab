//
//  CustomProgressView.swift
//  SummerPractiseIOSLab
//
//  Created by Enoxus on 09/04/2019.
//  Copyright © 2019 itisIOSLab. All rights reserved.
//

import UIKit

class CustomProgressView: UIProgressView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: 4.0)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskLayerPath.cgPath
        layer.mask = maskLayer
        
    }

}
