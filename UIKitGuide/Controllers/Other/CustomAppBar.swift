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
      self.addSubview(innerView)
      innerView.addSubview(backButton)
      
      initializeConstraints()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   func initializeConstraints(){
      var constraint: [NSLayoutConstraint] = []
      
      constraint.append(innerView.widthAnchor.constraint(equalTo: self.widthAnchor))
      constraint.append(innerView.heightAnchor.constraint(equalTo: self.heightAnchor))
      constraint.append(innerView.centerYAnchor.constraint(equalTo: self.centerYAnchor))
      constraint.append(innerView.centerXAnchor.constraint(equalTo: self.centerXAnchor))
      
      constraint.append(backButton.heightAnchor.constraint(equalToConstant: 45))
      constraint.append(backButton.centerYAnchor.constraint(equalTo: innerView.centerYAnchor, constant: 20))
      constraint.append(backButton.leadingAnchor.constraint(equalTo: innerView.leadingAnchor))
      
      NSLayoutConstraint.activate(constraint)
      
   }
   
}
