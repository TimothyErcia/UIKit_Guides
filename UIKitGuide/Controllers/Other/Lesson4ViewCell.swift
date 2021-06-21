//
//  Lesson4ViewCell.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 6/6/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import UIKit

class Lesson4ViewCell: UITableViewCell {
   
   static let identifier = "Lesson4ViewCell"
  
   private let innerView: UIView = {
      let mview = UIView()
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   private let hstack: UIStackView = {
      let mview = UIStackView()
      mview.axis = .horizontal
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   private let vstack: UIStackView = {
      let mview = UIStackView()
      mview.axis = .vertical
      mview.translatesAutoresizingMaskIntoConstraints = false
      return mview
   }()
   
   private var photoImageView: UIImageView = {
      let img = UIImageView()
      img.contentMode = .scaleAspectFit
      img.layer.borderWidth = 0.5
      img.translatesAutoresizingMaskIntoConstraints = false
      return img
   }()
   
   private var titleLabel: UILabel = {
      let lb = UILabel()
      lb.numberOfLines = 1
      lb.translatesAutoresizingMaskIntoConstraints = false
      return lb
   }()
   
   private var urlLabel: UILabel = {
      let lb = UILabel()
      lb.adjustsFontSizeToFitWidth = true
      lb.translatesAutoresizingMaskIntoConstraints = false
      return lb
   }()
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      addSubview(hstack)
      hstack.addArrangedSubview(photoImageView)
      hstack.addArrangedSubview(innerView)
      innerView.addSubview(vstack)
      vstack.addArrangedSubview(titleLabel)
      vstack.addArrangedSubview(urlLabel)
      
      configureConstraint()
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
   
   func setViews(photo: Lesson4ViewCellModel){
      guard let dataUrl = URL(string: photo.imageView ?? "") else { return }
      
      DispatchQueue.global(qos: .utility).async {
         do {
            let data = try Data(contentsOf: dataUrl)
            DispatchQueue.main.async {
               self.photoImageView.image = UIImage(data: data)
            }
         } catch {
            print("URL image not found")
         }
      }
      
      titleLabel.text = photo.titleView
      urlLabel.text = photo.urlView
   }
   
   private func configureConstraint(){
      var constraint: [NSLayoutConstraint] = []
      
      //hstack
      constraint.append(hstack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8))
      constraint.append(hstack.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -8))
      constraint.append(hstack.topAnchor.constraint(equalTo: topAnchor, constant: 8))
      constraint.append(hstack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8))
      
      //photoImage
      constraint.append(photoImageView.widthAnchor.constraint(equalToConstant: 100))
      constraint.append(photoImageView.heightAnchor.constraint(equalToConstant: 100))
      
      //vstack
      constraint.append(vstack.trailingAnchor.constraint(equalTo: innerView.trailingAnchor))
      constraint.append(vstack.leadingAnchor.constraint(equalTo: innerView.leadingAnchor, constant: 5))
      constraint.append(vstack.bottomAnchor.constraint(equalTo: innerView.bottomAnchor, constant: -10))
      
      NSLayoutConstraint.activate(constraint)
   }
   
}
