//
//  Lesson3ViewController.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/2/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import UIKit
import Combine

class Lesson3ViewController: UIViewController {
   
   private var newPostData: Post = Post(id: 1, userId: 1, title: "Sample title", body: "Sample body")
   private var viewModel = PostViewModel()
   private var subscription = Set<AnyCancellable>()
   
   private var lastOffset: CGFloat = 0
   
   private let appBar = CustomAppBar()
   
   private let toolbarView: UIStackView = {
      let mview = UIStackView()
      mview.axis = .horizontal
      mview.backgroundColor = .white
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   private var searchBar: UISearchBar = {
      let search = UISearchBar()
      search.placeholder = "Search item"
      search.autocapitalizationType = .none
      search.searchBarStyle = .minimal
      search.backgroundColor = .white
      search.translatesAutoresizingMaskIntoConstraints = false
      return search
   }()
   
   private let addButton: UIButton = {
      let btn = UIButton()
      let image = UIImage(named: "add-circle")
      let template = image?.withRenderingMode(.alwaysTemplate)
      
      let imageView = UIImageView()
      imageView.image = template
      imageView.tintColor = .white
      imageView.contentMode = .scaleAspectFit
      
      btn.setImage(imageView.image, for: .normal)
      btn.addTarget(self, action: #selector(createData), for: .touchUpInside)
      btn.translatesAutoresizingMaskIntoConstraints = false
      return btn
   }()
   
   private let contentView: UIView = {
      let mview = UIView()
      mview.backgroundColor = .white
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   private let tableContent: UITableView = {
      let mview = UITableView()
      mview.estimatedRowHeight = 120
      mview.rowHeight = UITableView.automaticDimension
      mview.register(Lesson3ViewCell.self, forCellReuseIdentifier: Lesson3ViewCell.identifier)
      mview.keyboardDismissMode = .onDrag
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   deinit {
      print("recall memory")
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      view.addSubview(appBar)
      view.addSubview(contentView)
      contentView.addSubview(toolbarView)
      contentView.addSubview(tableContent)
      
      tableContent.dataSource = self
      tableContent.delegate = self
      searchBar.delegate = self
      
      view.backgroundColor = .systemBlue
      configureAppBar()
      configureToolbar()
      configureConstraint()
      populateView()
   }
   
   private func configureConstraint(){
      var constraint: [NSLayoutConstraint] = []
      
      //content view
      constraint.append(contentView.topAnchor.constraint(equalTo: appBar.bottomAnchor))
      constraint.append(contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
      constraint.append(contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
      constraint.append(contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
      
      //toolbar view
      constraint.append(toolbarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8))
      
      //table view
      constraint.append(tableContent.topAnchor.constraint(equalTo: toolbarView.bottomAnchor, constant: 8))
      constraint.append(tableContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15))
      constraint.append(tableContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15))
      constraint.append(tableContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15))
      
      
      NSLayoutConstraint.activate(constraint)
   }
   
   private func configureToolbar(){
      searchBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
      searchBar.widthAnchor.constraint(equalToConstant: view.bounds.width - 35).isActive = true
      
      addButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
      addButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
      
      toolbarView.addArrangedSubview(searchBar)
      toolbarView.addArrangedSubview(addButton)
   }
   
   private func populateView(){
      self.viewModel.postListData.sink(receiveValue: { [weak self] data in
         self?.tableContent.reloadData()
      }).store(in: &subscription)
   }
   
   private func configureAppBar(){
      appBar.backButton.setTitle("Lesson 3", for: .normal)
      appBar.backButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
   }
   
   @objc private func backToHome(){
      TransitionToLeft()
   }
   
   @objc private func createData(){
      self.viewModel.postAddData.sink(receiveValue: { data in
         print(data)
      }).store(in: &subscription)
   }
}

extension Lesson3ViewController: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return viewModel.postListData.value.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: Lesson3ViewCell.identifier) as! Lesson3ViewCell
      let post = viewModel.postListData.value[indexPath.row]
      cell.setView(post: post)
      
      return cell
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if let id = viewModel.postListData.value[indexPath.row].id {
         navigationController?.pushViewController(Lesson3DetailViewController(id), animated: true)
      }
   }
   
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
      if(scrollView.contentOffset.y > lastOffset){
         UIView.animate(withDuration: 0.5, animations: {
            self.appBar.frame = CGRect(x: 0, y: 40, width: self.view.bounds.width, height: 0)
            self.view.layoutIfNeeded()
         })
      }
      else {
         UIView.animate(withDuration: 0.5, animations: {
            self.appBar.frame = CGRect(x: 0, y: 40, width: self.view.bounds.width, height: 55)
            self.view.layoutIfNeeded()
         })
      }
      
      lastOffset = scrollView.contentOffset.y
   }
}

extension Lesson3ViewController: UISearchBarDelegate {
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      print(searchText)
      doSearch(searchText)
   }
   
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      print(searchBar.text ?? "")
      doSearch(searchBar.text ?? "")
   }
   
   func doSearch(_ text: String){
      if(text != ""){
         let data = viewModel.postListData.value.filter {
            $0.title!.contains(text)
         }
         viewModel.postListData.value = data
      } else{ populateView() }
   }
}
