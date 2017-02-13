//
//  ViewController.swift
//  Caesar
//
//  Created by L on 2/11/17.
//  Copyright © 2017 Lukas A. Muller. All rights reserved.
//

import UIKit

extension UIViewController {
  public func addSubviewsTo(_ parentView: UIView, views: [UIView]) {
    for currentView in views {
      parentView.addSubview(currentView)
    }
  }
  public func addSubviews(_ views: [UIView]) {
    addSubviewsTo(view, views: views)
  }
}

extension UIView {
  func falseAutoresizingTranslation() {
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}

extension UIColor {
  static func new(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
  }
}

class MainController: UIViewController {
    
  let selectionArea: UIView = {
    let sa = UIView()
    sa.backgroundColor = UIColor.new(red: 38, green: 50, blue: 56)
    sa.falseAutoresizingTranslation()
    return sa
  }()
  
  let button: UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 88, height: 88))
    button.contentMode = .scaleAspectFit
    button.setImage(UIImage(named: "history"), for: UIControlState.normal)
    button.falseAutoresizingTranslation()
    return button
  }()
  
  let shiftLabel: UILabel = {
    let label = UILabel()
    label.text = "Shift Offset".uppercased()
    label.font = UIFont.systemFont(ofSize: 11.5, weight: UIFontWeightMedium)
    label.textColor = UIColor.new(red: 69, green: 90, blue: 100)
    label.falseAutoresizingTranslation()
    return label
  }()
  
  let shiftButton: UIButton = {
    let button = UIButton()
    button.titleLabel?.text = "21"
    button.falseAutoresizingTranslation()
    button.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: UIFontWeightRegular)
    button.titleLabel?.textColor = .white
    return button
  }()
  
  lazy var textView: UITextView = {
    let tv = UITextView()
    tv.textColor = UIColor.new(red: 166, green: 166, blue: 166)
    tv.font = UIFont.systemFont(ofSize: 21.5, weight: UIFontWeightRegular)
    tv.falseAutoresizingTranslation()
    tv.contentInset = UIEdgeInsets(top: 44, left: 44, bottom: 44, right: 44)
    tv.delegate = self
    tv.returnKeyType = .go
    tv.text = "Type in your message..."
    return tv
  }()
  
  let methodSelector: UISegmentedControl = {
    let sc = UISegmentedControl(items: ["Encipher", "Decipher"])
    sc.selectedSegmentIndex = 0
    sc.falseAutoresizingTranslation()
    return sc
  }()
  
  let selectorLabel: UILabel = {
    let label = UILabel()
    label.text = "Method".uppercased()
    label.font = UIFont.systemFont(ofSize: 11.5, weight: UIFontWeightMedium)
    label.textColor = UIColor.new(red: 69, green: 90, blue: 100)
    label.falseAutoresizingTranslation()
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    shiftButton.titleLabel?.text = "233"
    addSubviews([selectionArea, textView])
    addSubviewsTo(selectionArea, views: [button, shiftButton, shiftLabel, methodSelector, selectorLabel])
    addConstraints(view)
  }
  
  func addConstraints(_ parentView: UIView) {
    NSLayoutConstraint.activate([
      selectionArea.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
      selectionArea.topAnchor.constraint(equalTo: parentView.topAnchor),
      selectionArea.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
      selectionArea.heightAnchor.constraint(equalToConstant: 250),
      
      button.trailingAnchor.constraint(equalTo: selectionArea.trailingAnchor, constant: -44),
      button.topAnchor.constraint(equalTo: selectionArea.topAnchor, constant: 44),
      
      shiftButton.bottomAnchor.constraint(equalTo: selectionArea.bottomAnchor, constant: -44),
      shiftButton.leadingAnchor.constraint(equalTo: selectionArea.leadingAnchor, constant: 44),
      
      shiftLabel.bottomAnchor.constraint(equalTo: shiftButton.topAnchor, constant: 16),
      shiftLabel.leadingAnchor.constraint(equalTo: selectionArea.leadingAnchor, constant: 44),
      
      textView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
      textView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
      textView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
      textView.topAnchor.constraint(equalTo: selectionArea.bottomAnchor),
      
      methodSelector.bottomAnchor.constraint(equalTo: shiftLabel.topAnchor, constant: -20),
      methodSelector.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 44),
      
      selectorLabel.bottomAnchor.constraint(equalTo: methodSelector.topAnchor, constant: -8),
      selectorLabel.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 44)
    ])
  }
}

extension MainController: UITextViewDelegate {
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    textView.text = ""
    return true
  }
  func textViewDidBeginEditing(_ textView: UITextView) {
    textView.becomeFirstResponder()
  }
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if text == "\n" {
      
      // NOTE: Check if key is available
      
      switch methodSelector.selectedSegmentIndex {
        case 0:
          print(encipher(offset: 5, message: textView.text).message)
        case 1:
          print(decipher(offset: 5, message: textView.text))
        default:
          print("Something weird has been selected")
      }
      textView.resignFirstResponder()
    }
    return true
  }

  
}
