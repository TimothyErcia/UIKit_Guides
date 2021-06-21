//
//  CustomAppBarwithSegment.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/14/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import UIKit

class CustomAppBarwithSegment: UIView {
   
   let innerView: UIView = {
      let mview = UIView()
      mview.backgroundColor = .systemBlue
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   let vstack: UIStackView = {
      let mview = UIStackView()
      mview.axis = .vertical
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   let hstack: UIStackView = {
      let mview = UIStackView()
      mview.axis = .horizontal
      mview.distribution = .fillEqually
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   let topView: UIView = {
      let mview = UIView()
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   public let backButton: UIButton = {
      let btn = UIButton()
      let image = UIImage(named: "chevron.left")
      let template = image?.withRenderingMode(.alwaysTemplate)
      
      btn.setImage(template, for: .normal)
      btn.imageView?.contentMode = .scaleAspectFit
      btn.imageView?.tintColor = .white
      btn.clipsToBounds = true
      btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -80, bottom: 0, right: 0)
      btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -180, bottom: 0, right: 0)
      btn.translatesAutoresizingMaskIntoConstraints = false
      return btn
   }()
   
   public let modalButton: UIButton = {
      let btn = UIButton()
      let image = UIImage(named: "add-circle")
      let template = image?.withRenderingMode(.alwaysTemplate)
      
      btn.setImage(template, for: .normal)
      btn.imageView?.contentMode = .scaleAspectFit
      btn.imageView?.tintColor = .white
      btn.imageView?.clipsToBounds = true
      btn.translatesAutoresizingMaskIntoConstraints = false
      return btn
   }()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      self.addSubview(innerView)
      innerView.addSubview(vstack)
      
      vstack.addArrangedSubview(topView)
      vstack.addArrangedSubview(hstack)
      
      topView.addSubview(backButton)
      topView.addSubview(modalButton)
      
      createSegmentButton(name: "seg 1")
      createSegmentButton(name: "seg 2")
      createSegmentButton(name: "seg 3")
      
      initializeConstraint()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   func initializeConstraint(){
      innerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
      innerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
      innerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
      innerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
   
      vstack.leadingAnchor.constraint(equalTo: innerView.leadingAnchor).isActive = true
      vstack.trailingAnchor.constraint(equalTo: innerView.trailingAnchor).isActive = true
      vstack.centerYAnchor.constraint(equalTo: innerView.centerYAnchor, constant: 20).isActive = true
      
      topView.leadingAnchor.constraint(equalTo: vstack.leadingAnchor).isActive = true
      topView.trailingAnchor.constraint(equalTo: vstack.trailingAnchor).isActive = true
      topView.heightAnchor.constraint(equalToConstant: 45).isActive = true
      
      backButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
      backButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
      backButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10).isActive = true
      backButton.widthAnchor.constraint(equalToConstant: 127).isActive = true
      
      modalButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
      modalButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
      modalButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16).isActive = true
      modalButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
      
      hstack.heightAnchor.constraint(equalToConstant: 35).isActive = true
   }
   
   func createSegmentButton(name title: String) {
      let segmentButton = UIButton()
      segmentButton.setTitle(title, for: .normal)
      segmentButton.translatesAutoresizingMaskIntoConstraints = false
      
      segmentButton.heightAnchor.constraint(equalToConstant: hstack.bounds.height).isActive = true
      
      hstack.addArrangedSubview(segmentButton)
   }
   
}
