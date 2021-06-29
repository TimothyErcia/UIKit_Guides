//
//  Lesson4ViewController.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/4/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import UIKit
import ViewAnimator

class Lesson4ViewController: UIViewController {
   
   var viewModel = PhotoListViewModel()
   
   let animation = AnimationType.vector(CGVector(dx: 500, dy: 0))
   let appBar = CustomAppBar()
   
   let contentView: UIView = {
      let mview = UIView()
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   let tableView: UITableView = {
      let tbl = UITableView()
      tbl.rowHeight = 115
      tbl.register(Lesson4ViewCell.self, forCellReuseIdentifier: Lesson4ViewCell.identifier)
      tbl.translatesAutoresizingMaskIntoConstraints = false
      return tbl
   }()
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      UIView.animate(views: tableView.visibleCells,
                     animations: [animation], duration: 1.0)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      view.addSubview(appBar)
      view.addSubview(contentView)
      contentView.addSubview(tableView)
      tableView.delegate = self
      tableView.dataSource = self
      
      bindViewModel()
      fetchData()
      
      view.backgroundColor = .white
      configureAppbar()
      configureConstraint()
   }
   
   private func configureConstraint(){
      var constraint: [NSLayoutConstraint] = []
      
      constraint.append(contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
      constraint.append(contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
      constraint.append(contentView.topAnchor.constraint(equalTo: appBar.bottomAnchor))
      constraint.append(contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
      
      constraint.append(tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
      constraint.append(tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
      constraint.append(tableView.topAnchor.constraint(equalTo: contentView.topAnchor))
      constraint.append(tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))

      NSLayoutConstraint.activate(constraint)
   }
   
   private func configureAppbar(){
      appBar.backButton.setTitle("Lesson 4", for: .normal)
      appBar.backButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
      appBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 90)
   }
   
   @objc private func backToHome(){
      TransitionToLeft()
   }
   
   private func bindViewModel(){
      viewModel.list.bind { [weak self] _ in
         DispatchQueue.main.async {
            self?.tableView.reloadData()
         }
      }
   }
   
   private func fetchData(){
      API_PhotoCollection().getAllData {[weak self] (res) in
         DispatchQueue.global().async {
            switch res {
            case .success(let data):
               self?.viewModel.list.value = data.compactMap({
                  Lesson4ViewCellModel(imageView: $0.thumbnailUrl, titleView: $0.title, urlView: $0.thumbnailUrl)
               })
            case .failure(let error):
               print(error.rawValue)
            }
         }
      }
   }
   
}

extension Lesson4ViewController: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return viewModel.list.value?.count ?? 0
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: Lesson4ViewCell.identifier, for: indexPath) as! Lesson4ViewCell
      
      let photoData = viewModel.list.value?[indexPath.row] ??
         Lesson4ViewCellModel(imageView: "", titleView: "", urlView: "")
      
      cell.setViews(photo: photoData)
      return cell
   }
   
}
