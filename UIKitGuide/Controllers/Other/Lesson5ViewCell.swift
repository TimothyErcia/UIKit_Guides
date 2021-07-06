//
//  Lesson5ViewCell.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/14/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import UIKit
import Foundation

class Lesson5ViewCell: UITableViewCell {
   
   static let identifier = "Lesson5ViewCell"
   
   private let vstack: UIStackView = {
      let mview = UIStackView()
      mview.axis = .vertical
      mview.distribution = .fillEqually
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   private let name: UILabel = {
      let lb = UILabel()
      lb.translatesAutoresizingMaskIntoConstraints = false
      return lb
   }()
   
   private let createDate: UILabel = {
      let lb = UILabel()
      lb.translatesAutoresizingMaskIntoConstraints = false
      return lb
   }()

   private let statusLabel: UILabel = {
      let lb = UILabel()
      lb.backgroundColor = .systemYellow
      lb.layer.cornerRadius = 12.0
      lb.textColor = .white
      lb.text = "Hello Yellow world"
      lb.translatesAutoresizingMaskIntoConstraints = false
      return lb
   }()
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      addSubview(vstack)
      
      initializeLayout()
      vstack.addArrangedSubview(name)
      vstack.addArrangedSubview(createDate)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
      // Configure the view for the selected state
   }
   
   private func initializeLayout(){
      var constraint: [NSLayoutConstraint] = []
      
      constraint.append(vstack.leadingAnchor.constraint(equalTo: leadingAnchor))
      constraint.append(vstack.trailingAnchor.constraint(equalTo: trailingAnchor))
      constraint.append(vstack.bottomAnchor.constraint(equalTo: bottomAnchor))
      constraint.append(vstack.topAnchor.constraint(equalTo: topAnchor))
      
      NSLayoutConstraint.activate(constraint)
   }
   
   func setViews(views: TodoItem){
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "mm-dd-yyyy"
      
      name.text = views.name ?? ""
      createDate.text = dateFormatter.string(from: views.createdAt!)
      if views.hasStatus {
         vstack.addArrangedSubview(statusLabel)
      }
   }
   
}
