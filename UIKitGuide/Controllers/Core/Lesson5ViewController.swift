//
//  Lesson5ViewController.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/13/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import UIKit
import Combine
import ViewAnimator

class Lesson5ViewController: UIViewController {
   
   private var subscription = Set<AnyCancellable>()
   private var viewModel = TodoListViewModel()
   
   private let appBar = CustomAppBarwithSegment()
   
   private let tableView: UITableView = {
      let tbl = UITableView()
      tbl.rowHeight = 80
      tbl.register(Lesson5ViewCell.self, forCellReuseIdentifier: Lesson5ViewCell.identifier)
      tbl.translatesAutoresizingMaskIntoConstraints = false
      return tbl
   }()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      navigationController?.navigationBar.barStyle = .black
      view.addSubview(appBar)
      view.addSubview(tableView)
      tableView.delegate = self
      tableView.dataSource = self
      
      configureAppbar()
      configureConstraint()
      fetchData()
      view.backgroundColor = .white
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      let animation = AnimationType.vector(CGVector(dx: 0, dy: -1000))
      UIView.animate(views: [appBar, tableView], animations: [animation])
   }
   
   private func configureConstraint(){
      var constraint: [NSLayoutConstraint] = []
      
      constraint.append(tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
      constraint.append(tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
      constraint.append(tableView.topAnchor.constraint(equalTo: appBar.bottomAnchor))
      constraint.append(tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
      
      NSLayoutConstraint.activate(constraint)
   }
   
   private func fetchData(){
      viewModel.todoListData.sink(receiveValue: {[weak self] _ in
         self?.tableView.reloadData()
      }).store(in: &subscription)
   }
   
   private func configureAppbar(){
      appBar.backButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
      appBar.modalButton.addTarget(self, action: #selector(openModal), for: .touchUpInside)
      appBar.backButton.setTitle("Lesson 5", for: .normal)
      appBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 130)
      
   }
   
   @objc private func openModal(){
//      CoreDataCollection().createItem(name: "Has Status", hasStatus: true)
//      fetchData()
   }
   
   @objc private func backToHome(){
      TransitionToBottom()
   }
   
}

extension Lesson5ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return viewModel.todoListData.value.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: Lesson5ViewCell.identifier, for: indexPath) as! Lesson5ViewCell
      
      let todoData = viewModel.todoListData.value[indexPath.row]
      cell.setViews(views: todoData)
      
      return cell
   }
}
