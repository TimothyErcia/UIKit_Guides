//
//  Lesson3ViewCell.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/6/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import UIKit

class Lesson3ViewCell: UITableViewCell {
   
   static let identifier = "Lesson3ViewCell"
   
   private var label: UILabel = {
      let lb = UILabel()
      lb.numberOfLines = 0
      lb.textAlignment = .left
      lb.translatesAutoresizingMaskIntoConstraints = false
      return lb
   }()
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      addSubview(label)
      configureLabelContraint()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
   }
   
   override func prepareForReuse() {
      self.label.text = nil
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
      // Configure the view for the selected state
   }
   
   private func configureLabelContraint(){
      var constraint: [NSLayoutConstraint] = []
      
      constraint.append(label.leadingAnchor.constraint(equalTo: leadingAnchor))
      constraint.append(label.topAnchor.constraint(equalTo: topAnchor, constant: 15))
      constraint.append(label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15))
      constraint.append(label.trailingAnchor.constraint(equalTo: trailingAnchor))
      
      NSLayoutConstraint.activate(constraint)
   }
   
   func setView(post: Post){
      label.text = post.title
   }
   
}
