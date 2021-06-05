//
//  CustomAppBar.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/4/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import UIKit

class CustomAppBar: UIView {
   
   let innerView: UIView = {
      let mview = UIView()
      mview.translatesAutoresizingMaskIntoConstraints = false
      mview.backgroundColor = .systemBlue
      return mview
   }()
   
   let backButton: UIButton = {
      let btn = UIButton()
      let image = UIImage(named: "chevron.left")
      let imageView = UIImageView()
      imageView.image = image

      btn.setTitleColor(.white, for: .normal)
      btn.setImage(imageView.image, for: .normal)
      btn.imageView?.contentMode = .scaleAspectFit
      btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -80, bottom: 0, right: -80)
      btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -160, bottom: 0, right: 0)
      btn.translatesAutoresizingMaskIntoConstraints = false
      return btn
   }()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      initializeSharedView()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   func initializeSharedView(){
      self.addSubview(innerView)
      innerView.addSubview(backButton)
      
      innerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
      innerView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
      innerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
      innerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
      
      backButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
      backButton.centerYAnchor.constraint(equalTo: innerView.centerYAnchor, constant: 20).isActive = true
      backButton.leadingAnchor.constraint(equalTo: innerView.leadingAnchor).isActive = true
   }
   
}
