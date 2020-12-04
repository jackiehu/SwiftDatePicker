//
//  HeaderBar.swift
//  ClassTable
//
//  Created by iOS on 2020/10/9.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit
import SnapKit

public enum BarStyle {
    case titleCenter
    case titleLeft
}
public class HeaderBar: UIView {

    fileprivate var barStyle: BarStyle = .titleCenter
    fileprivate var titleString: String = ""
    fileprivate var leftString: String = ""
    fileprivate var rightString: String = ""
    
    public var leftCallBack : (() -> Void)?
    public var rightCallBack : (() -> Void)?
    
    public convenience init(style: BarStyle, title: String, left: String, right: String) {
        self.init()
        
        barStyle = style
        titleString = title
        leftString = left
        rightString = right
        switch barStyle{
        case .titleLeft:
            leftButton.contentHorizontalAlignment = .center
            rightButton.contentHorizontalAlignment = .center
        case .titleCenter:
            leftButton.contentHorizontalAlignment = .leading
            rightButton.contentHorizontalAlignment = .trailing
        }
        setupViews()
    }

    fileprivate lazy var titleLabel: UILabel = {
        let lab = UILabel()
        lab.font = HeadBar.titleFont ?? .systemFont(ofSize: 16)
        lab.textColor = HeadBar.barTitleColor ?? .black
        lab.numberOfLines = 0
        lab.adjustsFontSizeToFitWidth = true
        lab.minimumScaleFactor = 0.5
        return lab
    }()
    
    fileprivate lazy var leftButton : UIButton = {
        let b = UIButton()
        b.titleLabel?.font = HeadBar.buttonFont ?? .systemFont(ofSize: 16)
        b.setTitleColor(HeadBar.barButtonColor ?? .black, for: .normal)
        b.setTitleColor(.lightGray, for: .highlighted)
        b.addTarget(self, action: #selector(leftAction), for: .touchUpInside)
        return b
    }()
    
    fileprivate lazy var rightButton : UIButton = {
        let b = UIButton()
        b.titleLabel?.font = HeadBar.buttonFont ?? .systemFont(ofSize: 16)
        b.setTitleColor(HeadBar.barButtonColor ?? .black, for: .normal)
        b.setTitleColor(.lightGray, for: .highlighted)
        b.addTarget(self, action: #selector(rightAction), for: .touchUpInside)
        return b
    }()
    
    func setupViews(){
        
        backgroundColor = HeadBar.barColor ?? .white
        
        titleLabel.text = titleString
        leftButton.setTitle(leftString, for: .normal)
        rightButton.setTitle(rightString, for: .normal)
        
        addSubview(titleLabel)
        addSubview(leftButton)
        addSubview(rightButton)
        
        rightButton.snp.makeConstraints { (m) in
            m.centerY.equalToSuperview()
            m.right.equalToSuperview().offset(-20)
            m.width.equalTo(60)
            m.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { (m) in
            m.centerY.equalToSuperview()
            switch barStyle{
            case .titleLeft:
                m.left.equalToSuperview().offset(20)
            case .titleCenter:
                m.centerX.equalToSuperview()
            }
        }
        
        leftButton.snp.makeConstraints { (m) in
            m.centerY.equalToSuperview()
            m.width.equalTo(60)
            m.height.equalTo(40)
            switch barStyle{
            case .titleLeft:
                m.right.equalTo(rightButton.snp.left).offset(-10)
            case .titleCenter:
                m.left.equalToSuperview().offset(20)
            }
        }
        
    }
    
    @objc func leftAction(){
        leftCallBack?()
    }
    
    @objc func rightAction(){
        rightCallBack?()
    }
}
