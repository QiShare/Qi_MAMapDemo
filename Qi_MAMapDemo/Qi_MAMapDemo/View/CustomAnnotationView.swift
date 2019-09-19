//
//  CustomAnnotationView.swift
//  Qi_MAMapDemo
//
//  Created by liusiqi on 2019/9/10.
//  Copyright © 2019 QiShare. All rights reserved.
//

import UIKit
import MAMapKit

class CustomAnnotationView: MAAnnotationView {

    var calloutView: CustomCalloutView?
    
    private var headImageView: UIImageView! // 头像View
    private var headBorderView: UIView! // 边框
    
    var leftBtnBlock : ((_:UIButton?)->Void)?
    var rightBtnBlock : ((_:UIButton?)->Void)?
    
    var headImage: UIImage {
        get {
            return self.headImageView!.image!
        }
        set {
            self.headImageView?.image = newValue
        }
    }
    
    var headBoaderColor: UIColor {
        get {
            return self.headBorderView!.backgroundColor!
        }
        set {
            self.headBorderView?.backgroundColor = newValue
        }
    }
    
    override init!(annotation: MAAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        let viewWidth = 50
        let viewHeight = 50
        let headWidth = 40
        let headHeight = 40
        
        self.bounds = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        
        headBorderView = UIView.init(frame: .zero)
        headBorderView.backgroundColor = .white
        headBorderView.frame.size = CGSize.init(width: viewWidth, height: viewHeight)
        headBorderView.center = CGPoint(x: 50 / 2, y: 50 / 2)
        headBorderView.layer.masksToBounds = true
        headBorderView.layer.cornerRadius = CGFloat(viewWidth / 2)
        headBorderView.isUserInteractionEnabled = false
        self.addSubview(headBorderView)
        
        headImageView = UIImageView.init(frame: CGRect.zero)
        headImageView.backgroundColor = .white
        headImageView.frame.size = CGSize.init(width: headWidth, height: headHeight)
        headImageView.frame.origin.x = CGFloat((viewWidth - headWidth) / 2)
        headImageView.frame.origin.y = CGFloat((viewHeight - headHeight) / 2)
        headImageView.layer.masksToBounds = true
        headImageView.layer.cornerRadius = CGFloat(headWidth / 2)
        headImageView.isUserInteractionEnabled = false
        self.addSubview(headImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        if self.isSelected == selected{
            return;
        }
        
        if selected {
            if calloutView == nil {
                calloutView = CustomCalloutView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 45))
                calloutView!.center = CGPoint.init(x: bounds.width/2 + calloutOffset.x, y: -calloutView!.bounds.height/2 + calloutOffset.y)
                calloutView?.leftBtnBlock = leftBtnBlock
                calloutView?.rightBtnBlock = rightBtnBlock
            }
            addSubview(calloutView!)
        } else {
            calloutView!.removeFromSuperview()
        }
        super.setSelected(selected, animated: animated)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        var view = super.hitTest(point, with: event)
        
        if view == nil {
            
            if self.calloutView == nil {
                return view
            }
            
            let temPoint1: CGPoint = (self.calloutView?.leftBtn.convert(point, from: self))!
            let temPoint2: CGPoint = (self.calloutView?.rightBtn.convert(point, from: self))!
            
            if (self.calloutView?.leftBtn.bounds.contains(temPoint1))! {
                view = self.calloutView!.leftBtn
            }
            
            if (self.calloutView?.rightBtn.bounds.contains(temPoint2))! {
                view = self.calloutView!.rightBtn
            }
        }
        
        return view
    }
}
