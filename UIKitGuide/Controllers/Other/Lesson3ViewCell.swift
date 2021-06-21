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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
   private func configureLabelContraint(){
      label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
      label.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
      label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
      label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
   }
   
   func setView(post: Post){
      label.text = post.body
   }

}
