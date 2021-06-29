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
   
   let titleLabel: UILabel = {
      let label = UILabel()
      label.text = "Home"
      label.textAlignment = .left
      label.font = .boldSystemFont(ofSize: 40)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   let lesson1Controller = UINavigationController().setController(lesson: Lesson1ViewController())
   let lesson2Controller = UINavigationController().setController(lesson: Lesson2ViewController())
   let lesson3Controller = UINavigationController().setController(lesson: Lesson3ViewController())
   let lesson4Controller = UINavigationController().setController(lesson: Lesson4ViewController())
   let lesson5Controller = UINavigationController().setController(lesson: Lesson5ViewController())
   let lesson6Controller = UINavigationController().setController(lesson: Lesson6ViewController())
   
   override func viewDidLoad() {
      super.viewDidLoad()

      //view 
      view.addSubview(view1Constraint)
      view1Constraint.addSubview(titleLabel)
      view1Constraint.addSubview(contentVStack)
      VStackConfiguration("Lesson 1", 1)
      VStackConfiguration("Lesson 2", 2)
      VStackConfiguration("Lesson 3", 3)
      VStackConfiguration("Lesson 4", 4)
      VStackConfiguration("Lesson 5", 5)
      VStackConfiguration("Lesson 6", 6)
      
      //parent constraint
      configureConstraint()
      view.backgroundColor = .white
   }
   
   override var prefersStatusBarHidden: Bool {
      return true
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
   
   private func VStackConfiguration(_ lessonTitle: String, _ lessonTag: Int){
      let lesson: UIButton = {
         let button = UIButton()
         button.setTitle(lessonTitle, for: .normal)
         button.tag = lessonTag
         button.setTitleColor(.systemBlue, for: .normal)
         button.addTarget(self, action: #selector(toLesson), for: .touchUpInside)
         return button
      }()
      
      lesson.heightAnchor.constraint(equalToConstant: 40).isActive = true
      lesson.widthAnchor.constraint(equalToConstant: 120).isActive = true
      
      contentVStack.addArrangedSubview(lesson)
   }
   
   @objc private func toLesson(sender: UIButton){
      switch(sender.tag){
      case 1:
         self.present(lesson1Controller, animated: true)
      case 2:
         self.present(lesson2Controller, animated: true)
      case 3:
         self.present(lesson3Controller, animated: true)
      case 4:
         self.present(lesson4Controller, animated: false)
      case 5:
         self.present(lesson5Controller, animated: false)
      case 6:
         self.present(lesson6Controller, animated: false)
      default:
         print("Hello world")
      }
   }
}

extension UINavigationController {
   fileprivate func setController(lesson: UIViewController) -> UINavigationController{
      let vc = UINavigationController(rootViewController: lesson)
      vc.modalPresentationStyle = .fullScreen
      vc.isToolbarHidden = true
      vc.navigationBar.isHidden = true
      return vc
   }
}
