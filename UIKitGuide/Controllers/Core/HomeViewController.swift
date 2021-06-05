//
//  HomeViewController.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 5/26/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
   
   let view1Constraint: UIView = {
      let mview = UIView()
      mview.translatesAutoresizingMaskIntoConstraints = false
      mview.backgroundColor = .white
      return mview
   }()
   
   let contentVStack: UIStackView = {
      let mview = UIStackView()
      mview.axis = .vertical
      mview.distribution = .fillEqually
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   let lesson1Controller: UINavigationController = {
      let vc = UINavigationController(rootViewController: Lesson1ViewController())
      vc.modalPresentationStyle = .fullScreen
      vc.isToolbarHidden = true
      vc.navigationBar.isHidden = true
      return vc
   }()
   
   let lesson2Controller: UINavigationController = {
      let vc = UINavigationController(rootViewController: Lesson2ViewController())
      vc.modalPresentationStyle = .fullScreen
      vc.isToolbarHidden = true
      vc.navigationBar.isHidden = true
      return vc
   }()
   
   let lesson3Controller: UINavigationController = {
      let vc = UINavigationController(rootViewController: Lesson3ViewController())
      vc.modalPresentationStyle = .fullScreen
      vc.isToolbarHidden = true
      vc.navigationBar.isHidden = true
      return vc
   }()
   
   let titleLabel: UILabel = {
      let label = UILabel()
      label.text = "Home"
      label.textAlignment = .left
      label.font = .boldSystemFont(ofSize: 40)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      //view 
      view.addSubview(view1Constraint)
      view1Constraint.addSubview(titleLabel)
      view1Constraint.addSubview(contentVStack)
      VStackConfiguration()
      
      //parent constraint
      configureConstraint()
      view.backgroundColor = .white
   }
   
   private func configureConstraint(){
      var constraint: [NSLayoutConstraint] = []
      
      //contentView constraint
      constraint.append(view1Constraint.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))

      constraint.append(view1Constraint.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))

      constraint.append(view1Constraint.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))

      constraint.append(view1Constraint.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
      
      //title constraint
      constraint.append(titleLabel.topAnchor.constraint(equalTo: view1Constraint.topAnchor, constant: 15))
      constraint.append(titleLabel.trailingAnchor.constraint(equalTo: view1Constraint.trailingAnchor))
      constraint.append(titleLabel.leadingAnchor.constraint(equalTo: view1Constraint.leadingAnchor, constant: 15))
      constraint.append(titleLabel.heightAnchor.constraint(equalToConstant: 45))
      
      //contentVStack constraint
      constraint.append(contentVStack.centerYAnchor.constraint(equalTo: view1Constraint.centerYAnchor))
      constraint.append(contentVStack.centerXAnchor.constraint(equalTo: view1Constraint.centerXAnchor))
      
      NSLayoutConstraint.activate(constraint)
   }
   
   private func VStackConfiguration(){
      let lesson1: UIButton = {
         let button = UIButton()
         button.tag = 1
         button.setTitle("Lesson 1", for: .normal)
         button.setTitleColor(.systemBlue, for: .normal)
         button.addTarget(self, action: #selector(toLesson), for: .touchUpInside)
         return button
      }()
      
      let lesson2: UIButton = {
         let button = UIButton()
         button.tag = 2
         button.setTitle("Lesson 2", for: .normal)
         button.setTitleColor(.systemBlue, for: .normal)
         button.addTarget(self, action: #selector(toLesson), for: .touchUpInside)
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
      }()
      
      let lesson3: UIButton = {
         let button = UIButton()
         button.tag = 3
         button.setTitle("Lesson 3", for: .normal)
         button.setTitleColor(.systemBlue, for: .normal)
         button.addTarget(self, action: #selector(toLesson), for: .touchUpInside)
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
      }()
      
      lesson1.heightAnchor.constraint(equalToConstant: 40).isActive = true
      lesson1.widthAnchor.constraint(equalToConstant: 120).isActive = true
      
      lesson2.heightAnchor.constraint(equalToConstant: 40).isActive = true
      lesson2.widthAnchor.constraint(equalToConstant: 120).isActive = true
      
      lesson3.heightAnchor.constraint(equalToConstant: 40).isActive = true
      lesson3.widthAnchor.constraint(equalToConstant: 120).isActive = true
      
      contentVStack.addArrangedSubview(lesson1)
      contentVStack.addArrangedSubview(lesson2)
      contentVStack.addArrangedSubview(lesson3)
   }
   
   @objc private func toLesson(sender: UIButton){
      switch(sender.tag){
      case 1:
         self.present(lesson1Controller, animated: true)
      case 2:
         self.present(lesson2Controller, animated: true)
      case 3:
         self.present(lesson3Controller, animated: true)
      default:
         print("Hello")
      }
   }

}
