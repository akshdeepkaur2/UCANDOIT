//
//  ShadowView.swift
//  LVLFi Hub
//
//  Created by Pardeep on 25/07/19.
//  Copyright © 2019 Pardeep. All rights reserved.
//

import UIKit

final class ShadowView: UIView {
    
    var contentView : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override func layoutSubviews() {
        self.xibSetup()
        super.layoutSubviews()
    }
    
    func xibSetup() {
        //Manage the Shadow view layers
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = true ? UIScreen.main.scale : 1
    }
}
