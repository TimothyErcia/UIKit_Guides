//
//  Lesson3DetailViewController.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/4/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import UIKit

class Lesson3DetailViewController: UIViewController {
   
   private var selectedId: Int?
   private var postData: Post = Post(id: 0, userId: 0, title: "", body: "")
   
   private var postTitle: UILabel = {
      let lb = UILabel()
      lb.numberOfLines = 1
      lb.font = .systemFont(ofSize: 18)
      return lb
   }()
   
   private var postBody: UILabel = {
      let lb = UILabel()
      lb.numberOfLines = 0
      lb.font = .systemFont(ofSize: 18)
      return lb
   }()
   
   private var postId: UILabel = {
      let lb = UILabel()
      lb.font = .systemFont(ofSize: 18)
      return lb
   }()
   
   private var postUserID: UILabel = {
      let lb = UILabel()
      lb.font = .systemFont(ofSize: 18)
      return lb
   }()
   
   let appBar = CustomAppBar()
   
   private let contentView: UIView = {
      let mview = UIView()
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   private let wrapper: UIStackView = {
      let mview = UIStackView()
      mview.axis = .vertical
      mview.spacing = 10
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   init(_ selectedId: Int) {
      super.init(nibName: nil, bundle: nil)
      self.selectedId = selectedId
   }

   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   deinit {
      print("recall memory \(self.postData)")
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      view.addSubview(appBar)
      view.addSubview(contentView)
      contentView.addSubview(wrapper)
      configureContent()
      
      view.backgroundColor = .white
      configureAppbar()
      configureConstraint()
      fetchData()
   }
   
   private func configureConstraint(){
      var constraint: [NSLayoutConstraint] = []
      
      //content constraint
      constraint.append(contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
      constraint.append(contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
      constraint.append(contentView.topAnchor.constraint(equalTo: appBar.bottomAnchor))
      constraint.append(contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
      
      //vstack constraint
      constraint.append(wrapper.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
      constraint.append(wrapper.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
      constraint.append(wrapper.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -30))
      
      NSLayoutConstraint.activate(constraint)
   }
   
   private func configureContent(){
      wrapper.addArrangedSubview(postId)
      wrapper.addArrangedSubview(postUserID)
      wrapper.addArrangedSubview(postTitle)
      wrapper.addArrangedSubview(postBody)
   }
   
   private func fetchData(){
      API_PostCollection().getData(param: "\(selectedId ?? 0)") { (res) in
         DispatchQueue.global(qos: .userInitiated).async {
            self.postData = res
         }
         
         DispatchQueue.main.async {
            self.postTitle.text = "Title: \(self.postData.title)"
            self.postBody.text = "Body: \(self.postData.body)"
            self.postUserID.text = "UserId: " + "\(self.postData.userId)"
            self.postId.text = "ID: " + "\(self.postData.id)"
         }
      }
   }
   
   private func configureAppbar(){
      appBar.backButton.setTitle("Detail", for: .normal)
      appBar.backButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
      appBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 90)
   }
   
   @objc private func backToHome(_ sender: UIButton){
      TransitionToLeft()
   }
   
   
}
