//
//  ViewController.swift
//  Qi_MAMapDemo
//
//  Created by liusiqi on 2019/9/9.
//  Copyright © 2019 QiShare. All rights reserved.
//

import UIKit

let userAnnotationViewTag = 360

class ViewController: UIViewController {
    
    private var mapView: MAMapView = MAMapView.init() // 高德地图MapView
    private var userAnnotationView: CustomAnnotationView? // 用户头像的View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "地图首页"
        
        initMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initAnnotationData()
    }
    
    func initMapView() {
        
        AMapServices.shared()?.enableHTTPS = true
        mapView = MAMapView(frame: self.view.bounds)
        mapView.showsUserLocation = false
        mapView.isRotateEnabled = true // 允许旋转手势
        mapView.userTrackingMode = .follow // 打开定位方向
        mapView.isRotateCameraEnabled = false // 禁止倾斜手势
        mapView.showsCompass = false // 禁止显示指南针
        mapView.delegate = self
        mapView.setZoomLevel(13.0, animated: true) // 默认缩放等级为13
        mapView.pausesLocationUpdatesAutomatically = false
        self.view.addSubview(mapView)
    }
    
    
    func initAnnotationData() {
        
        let pointAnnotation = MAPointAnnotation()
        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: 39.98289153831738, longitude: 116.4903445241268)
        pointAnnotation.title = "360大厦"
        pointAnnotation.subtitle = "北京朝阳区酒仙桥路6号院电子城"
        mapView.addAnnotation(pointAnnotation)
    }
}

extension ViewController: MAMapViewDelegate {
    
    /**
     * @brief 根据anntation生成对应的View。
     * @param mapView 地图View
     * @param annotation 指定的标注
     * @return 生成的标注View
     */
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        
        // 改变用户定位的Annotation
        if annotation.isKind(of: MAUserLocation.self) {

            userAnnotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: "UserLocationId") as CustomAnnotationView
            userAnnotationView?.annotation = annotation

            userAnnotationView?.headBoaderColor = .red
            userAnnotationView?.headImage = UIImage.init(named: "QiShare")!
            userAnnotationView?.canShowCallout = false
            userAnnotationView?.tag = userAnnotationViewTag
            userAnnotationView?.zIndex = 360 // 控制annotationView的层级，zIndex值越大越在上层

            weak var weakSelf = self
            userAnnotationView?.leftBtnBlock = { _ in
                let vc1 = UIViewController.init()
                vc1.view.backgroundColor = .red
                weakSelf?.navigationController?.pushViewController(vc1, animated: true)
            }
            
            userAnnotationView?.rightBtnBlock = { _ in
                let vc2 = UIViewController.init()
                vc2.view.backgroundColor = .green
                weakSelf?.navigationController?.pushViewController(vc2, animated: true)
            }
            
            return userAnnotationView!
        }

        // 改变普通标注的AnnotationView
        if annotation.isKind(of: MAPointAnnotation.self) {
            let pointReuseIndetifier = "pointReuseIndetifier"
            var annotationView: MAPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier) as! MAPinAnnotationView?
            
            if annotationView == nil {
                annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
            }
            
            annotationView!.canShowCallout = true
            annotationView!.animatesDrop = true
            annotationView!.isDraggable = true
            annotationView?.leftCalloutAccessoryView = UIButton(type: UIButton.ButtonType.contactAdd)
            annotationView!.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)
            
            return annotationView!
        }
        
        return nil
    }
}

