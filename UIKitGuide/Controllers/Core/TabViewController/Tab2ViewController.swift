//
//  Tab2ViewController.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/21/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import UIKit

class Tab2ViewController: UIViewController {
   
   private let collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .vertical
      layout.minimumLineSpacing = 1
      layout.minimumInteritemSpacing = 1
      layout.itemSize = CGSize(width: ((UIScreen.main.bounds.width)/4)-4, height: 100)
      
      let mview = UICollectionView(frame: .zero, collectionViewLayout: layout)
      mview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collection")
      mview.backgroundColor = .white
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      view.addSubview(collectionView)
      
      collectionView.delegate = self
      collectionView.dataSource = self
      view.backgroundColor = .systemBlue
      
      configureConstraints()
   }
   
   private func configureConstraints(){
      var constraint: [NSLayoutConstraint] = []
      
      constraint.append(collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
      constraint.append(collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
      constraint.append(collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55))
      constraint.append(collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
      
      NSLayoutConstraint.activate(constraint)
   }
   
}

extension Tab2ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 5
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath)
      
      cell.contentView.backgroundColor = .brown
      return cell
   }
   
}
