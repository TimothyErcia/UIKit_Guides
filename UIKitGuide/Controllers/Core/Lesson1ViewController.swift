//
//  Lesson1ViewController.swift
//  UIKitGuide
//
//  Created by Timothy Ercia on 5/26/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import UIKit

class Lesson1ViewController: UIViewController {
   
   var splitValue: UILabel!
   var billInput: UITextField!
   var tipInput: UITextField!
   var totalInput: UITextField!
   
   var splitInt: Int = 1
   var billValue: Double = 0.00
   var tipValue: Double = 0.00
   var totalValue: Double = 0.00
   

   let appBar = CustomAppBar()
   
   let contentView: UIView = {
      let mview = UIView()
      mview.translatesAutoresizingMaskIntoConstraints = false
      mview.backgroundColor = .white
      return mview
   }()
   
   let lessonTitle: UILabel = {
      let label = UILabel()
      label.text = "Tip Calculator"
      label.font = .systemFont(ofSize: 30)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   let contentvstack: UIStackView = {
      let mview = UIStackView()
      mview.axis = .vertical
      mview.distribution = .fillEqually
      mview.spacing = 10
      mview.translatesAutoresizingMaskIntoConstraints = false
      mview.layer.borderWidth = 1.0
      return mview
   }()
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.navigationBar.barStyle = .black
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      navigationController?.navigationBar.barStyle = .default
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      view.addSubview(appBar)
      configureAppBar()
      
      view.addSubview(contentView)
      contentView.addSubview(lessonTitle)
      contentView.addSubview(contentvstack)
      configureContent()
      
      view.backgroundColor = .white
      configureConstraint()
      hideKeyboardWhenTappedAround()
   }
   
   private func configureConstraint(){
      var constraint: [NSLayoutConstraint] = []
      
      //content constraint
      constraint.append(contentView.topAnchor.constraint(equalTo: appBar.bottomAnchor))
      constraint.append(contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
      constraint.append(contentView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor))
      
      //content title
      constraint.append(lessonTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15))
      constraint.append(lessonTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,   constant: 15))
      constraint.append(lessonTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
      
      //content VStack constraint
      constraint.append(contentvstack.topAnchor.constraint(equalTo: lessonTitle.bottomAnchor, constant: 15))
      constraint.append(contentvstack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
      constraint.append(contentvstack.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -30))
      
      NSLayoutConstraint.activate(constraint)
   }
   
   private func configureAppBar(){
      appBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 90)
      appBar.backButton.setTitle("Lesson 1", for: .normal)
      appBar.backButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
   }
   
   private func configureContent(){
      contentvstack.addArrangedSubview(inputView("Bill"))
      contentvstack.addArrangedSubview(inputView("Tip"))
      contentvstack.addArrangedSubview(stepperView())
      contentvstack.addArrangedSubview(inputView("Total"))
   }
   
   private func stepperView() -> UIStackView{
      let hstack: UIStackView = {
         let mview = UIStackView()
         mview.axis = .horizontal
         mview.translatesAutoresizingMaskIntoConstraints = false
         return mview
      }()
      
      let label: UILabel = {
         let lb = UILabel()
         lb.text = "Split"
         lb.font = .boldSystemFont(ofSize: 18)
         return lb
      }()
      
      splitValue = {
         let label = UILabel()
         label.text = "\(splitInt)"
         label.textAlignment = .right
         return label
      }()
      
      let addBtn: UIButton = {
         let btn = UIButton()
         let image = UIImage(named: "add-circle-outline")
         let template = image?.withRenderingMode(.alwaysTemplate)
         
         let imageView = UIImageView()
         imageView.image = template
         imageView.contentMode = .scaleAspectFit
         imageView.tintColor = .systemBlue
         
         btn.setImage(imageView.image, for: .normal)
         btn.addTarget(self, action: #selector(addSplitValue), for: .touchUpInside)
         return btn
      }()
      
      let removeBtn: UIButton = {
         let btn = UIButton()
         let image = UIImage(named: "remove-circle-outline")
         let template = image?.withRenderingMode(.alwaysTemplate)
         
         let imageView = UIImageView()
         imageView.image = template
         imageView.contentMode = .scaleAspectFit
         imageView.tintColor = .systemBlue
         
         btn.setImage(imageView.image, for: .normal)
         btn.addTarget(self, action: #selector(removeSplitValue), for: .touchUpInside)
         return btn
      }()
      
      label.widthAnchor.constraint(equalToConstant: 80).isActive = true
      addBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
      removeBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
      
      hstack.addArrangedSubview(label)
      hstack.addArrangedSubview(splitValue)
      hstack.addArrangedSubview(addBtn)
      hstack.addArrangedSubview(removeBtn)
      
      hstack.setCustomSpacing(15, after: splitValue)
      
      return hstack
   }
   
   private func inputView(_ text: String) -> UIStackView{
      let hstack: UIStackView = {
         let mview = UIStackView()
         mview.axis = .horizontal
         mview.translatesAutoresizingMaskIntoConstraints = false
         return mview
      }()
      
      let label: UILabel = {
         let lb = UILabel()
         lb.text = text
         lb.font = .boldSystemFont(ofSize: 18)
         return lb
      }()
      
      label.heightAnchor.constraint(equalToConstant: 30).isActive = true
      label.widthAnchor.constraint(equalToConstant: 80).isActive = true
      
      hstack.addArrangedSubview(label)
      
      switch text {
      case "Bill":
         billInput = {
            let textField = UITextField()
            textField.layer.borderWidth = 0.5
            textField.textAlignment = .right
            textField.keyboardType = .numbersAndPunctuation
            textField.addTarget(self, action: #selector(getInputs), for: .editingDidBegin)
            return textField
         }()
         
         billInput.heightAnchor.constraint(equalToConstant: 30).isActive = true
         hstack.addArrangedSubview(billInput)
         break
      case "Tip":
         tipInput = {
            let textField = UITextField()
            textField.layer.borderWidth = 0.5
            textField.textAlignment = .right
            textField.keyboardType = .numbersAndPunctuation
            textField.addTarget(self, action: #selector(getInputs), for: .editingDidBegin)
            return textField
         }()
         
         tipInput.heightAnchor.constraint(equalToConstant: 30).isActive = true
         hstack.addArrangedSubview(tipInput)
         break
      case "Total":
         totalInput = {
            let textField = UITextField()
            textField.layer.borderWidth = 0.5
            textField.textAlignment = .right
            textField.keyboardType = .numbersAndPunctuation
            textField.addTarget(self, action: #selector(getInputs), for: .editingDidBegin)
            return textField
         }()
         
         totalInput.heightAnchor.constraint(equalToConstant: 30).isActive = true
         hstack.addArrangedSubview(totalInput)
         
         break
      default:
         print("hello")
      }
      
      return hstack
   }
   
   @objc private func backToHome(){
      dismiss(animated: true, completion: nil)
   }
   
   @objc private func addSplitValue(){
      self.splitInt+=1
      splitValue.text = "\(splitInt)"
      calculate()
   }
   
   @objc private func removeSplitValue(){
      self.splitInt = self.splitInt <= 1 ? 1 : self.splitInt - 1
      splitValue.text = "\(splitInt)"
      calculate()
   }
   
   @objc private func getInputs(){
      
      if let bill = billInput.text {
         billValue = Double(bill) ?? 0.00
      }
      
      if let tip = tipInput.text {
         tipValue = Double(tip) ?? 0.00
      }
      calculate()
   }
   
   private func calculate(){
      totalValue = (billValue / Double(splitInt)) + tipValue
      totalInput.text = "\(totalValue)"
   }
   
}
