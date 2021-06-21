//
//  Lesson3ViewController.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/2/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import UIKit

class Lesson3ViewController: UIViewController {
   
   var postData: [Post] = []
   
   var newPostData: Post = Post(id: 1, userId: 1, title: "Sample title", body: "Sample body")
   
   let appBar = CustomAppBar()
   
   let toolbarView: UIStackView = {
      let mview = UIStackView()
      mview.axis = .horizontal
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   let searchBar: UISearchBar = {
      let search = UISearchBar()
      search.placeholder = "Search item"
      search.autocapitalizationType = .none
      search.translatesAutoresizingMaskIntoConstraints = false
      return search
   }()
   
   let addButton: UIButton = {
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
   
   let contentView: UIView = {
      let mview = UIView()
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   let tableContent: UITableView = {
      let mview = UITableView()
      mview.estimatedRowHeight = 120
      mview.rowHeight = UITableView.automaticDimension
      mview.register(Lesson3ViewCell.self, forCellReuseIdentifier: Lesson3ViewCell.identifier)
      mview.keyboardDismissMode = .onDrag
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      view.addSubview(appBar)
      view.addSubview(contentView)
      contentView.addSubview(toolbarView)
      contentView.addSubview(tableContent)
      
      view.backgroundColor = .white
      configureAppBar()
      configureToolbar()
      configureConstraint()
      populateView()
   }
   
   private func configureConstraint(){
      var constraint: [NSLayoutConstraint] = []
      
      //content view
      constraint.append(contentView.topAnchor.constraint(equalTo: appBar.bottomAnchor, constant: 15))
      constraint.append(contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
      constraint.append(contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
      constraint.append(contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
      
      //toolbar view
      constraint.append(toolbarView.topAnchor.constraint(equalTo: contentView.topAnchor))
      constraint.append(toolbarView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
      
      //table view
      constraint.append(tableContent.topAnchor.constraint(equalTo: toolbarView.bottomAnchor))
      constraint.append(tableContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15))
      constraint.append(tableContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25))
      constraint.append(tableContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
      
      
      NSLayoutConstraint.activate(constraint)
   }
   
   private func configureToolbar(){
      searchBar.delegate = self
      searchBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
      searchBar.widthAnchor.constraint(equalToConstant: view.bounds.width - 35).isActive = true
      
      addButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
      addButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
      
      toolbarView.addArrangedSubview(searchBar)
      toolbarView.addArrangedSubview(addButton)
   }
   
   private func populateView(){
      API_PostCollection().getAllData { (res) in
         
         //thread for getting data
         let queue = DispatchQueue(label: "data-que")
         queue.async {
            self.postData = res
         }
         
         //thread for updating view
         DispatchQueue.main.async {
            self.tableContent.delegate = self
            self.tableContent.dataSource = self
            self.tableContent.reloadData()
         }
      }
   }
   
   private func configureAppBar(){
      appBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 90)
      appBar.backButton.setTitle("Lesson 3", for: .normal)
      appBar.backButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
   }
   
   @objc private func backToHome(){
      dismiss(animated: true, completion: nil)
   }
   
   @objc private func createData(){
      API_PostCollection().addData(post: newPostData) { (res) in
         let que = DispatchQueue(label: "create-data")
         que.async {
            print(res)
         }
         
         DispatchQueue.main.async {
            self.tableContent.reloadData()
         }
      }
   }
}

extension Lesson3ViewController: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return postData.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: Lesson3ViewCell.identifier) as! Lesson3ViewCell
      let post = postData[indexPath.row]
      cell.setView(post: post)
      
      return cell
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      let navigationController: UINavigationController = {
         let nav = UINavigationController(rootViewController: Lesson3DetailViewController(postData[indexPath.row].id))
         nav.modalPresentationStyle = .fullScreen
         nav.navigationBar.isHidden = true
         nav.toolbar.isHidden = true
         return nav
      }()
      
      self.present(navigationController, animated: true)
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
         let data = postData.filter {
            $0.title.contains(text)
         }
         postData = data
      } else{ populateView() }
      DispatchQueue.main.async {
         self.tableContent.reloadData()
      }
   }
}
