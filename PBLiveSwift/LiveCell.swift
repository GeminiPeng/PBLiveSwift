//
//  LiveCell.swift
//  PBLiveSwift
//
//  Created by Pengbo on 2017/1/4.
//  Copyright © 2017年 LivewSwift. All rights reserved.
//

import UIKit
import SnapKit


class LiveCell: UITableViewCell {
    
    var _liveList : PBLiveCell?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubViews() -> Void {
        
        
        
        self.addSubview(headImage)
        headImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(self.snp.top).offset(20)
        }
        headImage.layer.cornerRadius = 30
        headImage.clipsToBounds = true
        
        self.addSubview(nickLable)
        nickLable.snp.makeConstraints { (make) in
            make.left.equalTo(headImage.snp.right).offset(12)
            make.top.equalTo(self.snp.top).offset(20)
        }
        
        self.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nickLable.snp.bottom).offset(20)
            make.left.equalTo(headImage.snp.right).offset(12)
        }
        
        self.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(locationLabel.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-20)
        }
        
        self.addSubview(bigImage)
        bigImage.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self.snp.top).offset(100)
            make.height.equalTo(600)
        }
        bigImage.contentMode = UIViewContentMode.scaleAspectFill
        
    }

    lazy var nickLable: UILabel = {
        let nick = UILabel()
        nick.font = UIFont.systemFont(ofSize: 14)
        nick.textColor = UIColor.gray
        nick.text = "Gemini"
        return nick
    }()
    
    lazy var headImage: UIImageView = {
        let head = UIImageView()
        head.backgroundColor = UIColor.green
        return head
    }()
    
    lazy var locationLabel: UILabel = {
        let location = UILabel()
        location.text = "上海市"
        location.textColor = UIColor.lightGray
        location.font = UIFont.systemFont(ofSize: 14)
        return location
    }()
    
    lazy var numberLabel: UILabel = {
        let number = UILabel()
        number.text = "10000人正在观看"
        number.font = UIFont.systemFont(ofSize: 14)
        number.textColor = UIColor.lightGray
        return number
    }()
    
    lazy var bigImage: UIImageView = {
        let big = UIImageView()
        big.backgroundColor = UIColor.yellow
        return big
    }()
    
    var liveList : PBLiveCell? {
        
        didSet {
            _liveList = liveList
            
            headImage.image = UIImage(data: NSData(contentsOf: NSURL(string: _liveList!.headImage) as! URL) as! Data)
            nickLable.text = _liveList!.nick
            locationLabel.text = _liveList!.location
            numberLabel.text = String(stringInterpolationSegment: _liveList!.number) + "人正在观看"
            bigImage.image = UIImage(data: NSData(contentsOf: NSURL(string: _liveList!.headImage) as! URL) as! Data)
            
        }
    }
    
}
 
