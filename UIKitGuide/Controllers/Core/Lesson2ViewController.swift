//
//  Lesson2ViewController.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 5/26/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import UIKit
import ViewAnimator

class Lesson2ViewController: UIViewController {
   
   private let appBar = CustomAppBar()
   
   private let contentView: UIView = {
      let mview = UIView()
      mview.translatesAutoresizingMaskIntoConstraints = false
      mview.backgroundColor = .white
      return mview
   }()
   
   private let lessonTitle: UILabel = {
      let label = UILabel()
      label.text = "Animations"
      label.font = .boldSystemFont(ofSize: 25)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private let contentvstack: UIStackView = {
      let mview = UIStackView()
      mview.axis = .vertical
      mview.spacing = 10
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      view.addSubview(appBar)
      configureAppBar()
      
      view.addSubview(contentView)
      contentView.addSubview(lessonTitle)
      contentView.addSubview(contentvstack)
      configureContent()
      
      configureConstraint()
      view.backgroundColor = .white
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.navigationBar.barStyle = .black
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      navigationController?.navigationBar.barStyle = .default
   }
   
   private func configureConstraint(){
      var constraint: [NSLayoutConstraint] = []
      
      
      //content constraint
      constraint.append(contentView.topAnchor.constraint(equalTo: appBar.bottomAnchor))
      constraint.append(contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
      constraint.append(contentView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor))
      
      //title constraint
      constraint.append(lessonTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10))
      constraint.append(lessonTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
      constraint.append(lessonTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10))
      constraint.append(lessonTitle.heightAnchor.constraint(equalToConstant: 30))
      
      //content vstack constraint
      constraint.append(contentvstack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
      constraint.append(contentvstack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30))
      
      NSLayoutConstraint.activate(constraint)
   }
   
   private func configureAppBar(){
      appBar.backButton.setTitle("Lesson 2", for: .normal)
      appBar.backButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
   }
   
   private func configureContent(){
      let animation1: UIButton = {
         let button = UIButton()
         button.setTitle("Animation 1", for: .normal)
         button.setTitleColor(.systemBlue, for: .normal)
         button.tag = 1
         button.addTarget(self, action: #selector(animate), for: .touchUpInside)
         return button
      }()
      
      let animation2: UIButton = {
         let button = UIButton()
         button.setTitle("Animation 2", for: .normal)
         button.setTitleColor(.systemBlue, for: .normal)
         button.tag = 2
         button.addTarget(self, action: #selector(animate), for: .touchUpInside)
         return button
      }()
      
      let animation3: UIButton = {
         let button = UIButton()
         button.setTitle("Animation 3", for: .normal)
         button.setTitleColor(.systemBlue, for: .normal)
         button.tag = 3
         button.addTarget(self, action: #selector(animate), for: .touchUpInside)
         return button
      }()
      
      animation1.widthAnchor.constraint(equalToConstant: 120).isActive = true
      animation1.heightAnchor.constraint(equalToConstant: 30).isActive = true
      
      animation2.widthAnchor.constraint(equalToConstant: 120).isActive = true
      animation2.heightAnchor.constraint(equalToConstant: 30).isActive = true
      
      animation3.widthAnchor.constraint(equalToConstant: 120).isActive = true
      animation3.heightAnchor.constraint(equalToConstant: 30).isActive = true
      
      contentvstack.addArrangedSubview(animation1)
      contentvstack.addArrangedSubview(animation2)
      contentvstack.addArrangedSubview(animation3)
   }
   
   @objc private func backToHome(){
      dismiss(animated: true, completion: nil)
   }
   
   @objc private func animate(_ sender: UIButton){
      
      let animationView: UIView = {
         let mview = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
         mview.center = view.center
         mview.backgroundColor = .purple
         mview.tag = 100
         mview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideView)))
         return mview
      }()
      
      switch sender.tag {
      case 2:
         view.addSubview(animationView)
         let animation = AnimationType.zoom(scale: 3)
         animationView.animate(animations: [animation], duration: 0.5)
      case 3:
         view.addSubview(animationView)
         let animation = AnimationType.vector(CGVector(dx: -100, dy: 0))
         animationView.animate(animations: [animation], duration: 0.5)
      default:
         view.addSubview(animationView)
         let animation = AnimationType.rotate(angle: .pi/2)
         animationView.animate(animations: [animation], duration: 0.5)
      }
   }
   
   @objc private func hideView(){
      if let viewWithTag = view.viewWithTag(100) {
         viewWithTag.removeFromSuperview()
      }
   }
   
}
