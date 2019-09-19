//
//  CustomCalloutView.swift
//  Qi_MAMapDemo
//
//  Created by liusiqi on 2019/9/16.
//  Copyright © 2019 QiShare. All rights reserved.
//

import UIKit

class CustomCalloutView: UIView {

    var leftBtn: UIButton!
    var rightBtn: UIButton!
    
    var leftBtnBlock : ((_:UIButton?)->Void)? // 左边按钮的回调
    var rightBtnBlock : ((_:UIButton?)->Void)? // 右边按钮的回调
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
        
        leftBtn = UIButton(type: .custom)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 45.0, height: 45.0)
        leftBtn.setImage(UIImage(named: "QiShare"), for: .normal)
        leftBtn.addTarget(self, action: #selector(leftBtnClicked(button:)), for: UIControl.Event.touchUpInside)
        self.addSubview(leftBtn)
        
        rightBtn = UIButton(type: .custom)
        rightBtn.frame = CGRect(x: self.frame.size.width - 45.0, y: 0, width: 45.0, height: 45.0)
        rightBtn.setImage(UIImage(named: "QiShare"), for: .normal)
        rightBtn.addTarget(self, action: #selector(rightBtnClicked(button:)), for: UIControl.Event.touchUpInside)
        self.addSubview(rightBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func leftBtnClicked(button: UIButton) {
        print("left button clicked")
        if leftBtnBlock != nil {
            leftBtnBlock!(button)
        }
    }
    
    @objc func rightBtnClicked(button: UIButton) {
        print("right button clicked")
        if rightBtnBlock != nil {
            rightBtnBlock!(button)
        }
    }
}
