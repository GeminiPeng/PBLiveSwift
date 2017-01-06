//
//  DetailView.swift
//  PBLiveSwift
//
//  Created by Pengbo on 2017/1/5.
//  Copyright © 2017年 LivewSwift. All rights reserved.
//

import UIKit
import SnapKit



class DetailView: UIView {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func setSubView() -> Void {
        self.addSubview(backImage)
        backImage.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalTo(0)
        }
        backImage.clipsToBounds = true
        backImage.contentMode = UIViewContentMode.scaleAspectFill
        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        backImage.addSubview(effectView)
        
        
    }
    
    
    lazy var backImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        image.backgroundColor = UIColor.lightGray
        return image
    }()
    
    

}
