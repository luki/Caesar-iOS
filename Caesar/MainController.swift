//
//  ViewController.swift
//  Caesar
//
//  Created by L on 2/11/17.
//  Copyright © 2017 Lukas A. Muller. All rights reserved.
//

import UIKit

extension UIViewController {
  public func addSubviewsTo(_ view: UIView, views: [UIView]) {
    for currentView in views {
      view.addSubview(currentView)
    }
  }
  public func addSubviews(_ views: [UIView]) {
    addSubviewsTo(view, views: views)
  }
  public func addConstraints(_ constraints: [NSLayoutConstraint]) {
    NSLayoutConstraint.activate(constraints)
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
    button.addTarget(self, action: #selector(showHistory), for: .touchUpInside)
    return button
  }()
  
  lazy var shiftLabel: UILabel = {
    let label = UILabel()
    label.text = "Shift Offset".uppercased()
    label.font = UIFont(name: "Okomito-Medium", size: 11.5)
    label.textColor = UIColor.new(red: 69, green: 90, blue: 100)
    label.falseAutoresizingTranslation()
    let gesture = UITapGestureRecognizer(target: self, action: #selector(shiftAction))
    gesture.delegate = self
    label.addGestureRecognizer(gesture)
    return label
  }()
  
  let shiftButton: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Okomito-Light", size: 23)
    label.textColor = .white
    label.text = ""
    label.falseAutoresizingTranslation()
    return label
  }()
  
  lazy var textView: UITextView = {
    let tv = UITextView()
    tv.textColor = UIColor.new(red: 166, green: 166, blue: 166)
    tv.falseAutoresizingTranslation()
    tv.contentInset = UIEdgeInsets(top: 44, left: 44, bottom: 44, right: 44)
    tv.delegate = self
    tv.returnKeyType = .go
    tv.text = "Type in your message..."
    tv.font = UIFont(name: "Okomito-Regular", size: 21.5)
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
    label.font = UIFont(name: "Okomito-Medium", size: 11.5)
    label.textColor = UIColor.new(red: 69, green: 90, blue: 100)
    label.falseAutoresizingTranslation()
    label.isUserInteractionEnabled = true
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    addSubviews([selectionArea, textView])
    addSubviewsTo(selectionArea, views: [button, shiftButton, shiftLabel, methodSelector, selectorLabel])
    addConstraints([
      selectionArea.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      selectionArea.topAnchor.constraint(equalTo: view.topAnchor),
      selectionArea.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      selectionArea.heightAnchor.constraint(equalToConstant: 250),
      
      textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      textView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      textView.topAnchor.constraint(equalTo: selectionArea.bottomAnchor),
      
      button.trailingAnchor.constraint(equalTo: selectionArea.trailingAnchor, constant: -44),
      button.topAnchor.constraint(equalTo: selectionArea.topAnchor, constant: 44),
      
      shiftButton.bottomAnchor.constraint(equalTo: selectionArea.bottomAnchor, constant: -44),
      shiftButton.leadingAnchor.constraint(equalTo: selectionArea.leadingAnchor, constant: 44),
      shiftButton.trailingAnchor.constraint(equalTo: selectionArea.trailingAnchor, constant: -44),
      shiftButton.heightAnchor.constraint(equalToConstant: 23),
      
      shiftLabel.bottomAnchor.constraint(equalTo: shiftButton.topAnchor, constant: -8),
      shiftLabel.leadingAnchor.constraint(equalTo: selectionArea.leadingAnchor, constant: 44),
      
      methodSelector.bottomAnchor.constraint(equalTo: shiftLabel.topAnchor, constant: -20),
      methodSelector.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
      
      selectorLabel.bottomAnchor.constraint(equalTo: methodSelector.topAnchor, constant: -8),
      selectorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44)
    ])
  }
  
  // MARK: Target actions
  
  func showHistory(_ sender: UIButton) {
    self.present(HistoryController(), animated: true, completion: nil)
  }
  
  func shiftAction(_ sender: UILabel) {
    sender.becomeFirstResponder()
    print("Test")
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
      if !(shiftButton.text?.isEmpty)! {
        switch methodSelector.selectedSegmentIndex {
          case 0:
            print(encipher(offset: 5, message: textView.text).message)
          case 1:
            print(decipher(offset: 5, message: textView.text))
          default:
            print("Something weird has been selected")
        }
        return true
      }
      let alert = createAlert(title: "No Shift Offset Found", message: "Please set it before applying cipher", style: .alert, actions: [
        UIAlertAction(title: "I understand", style: .default) { _ in
        }
      ])
    }
    return true
  }
  
  func createAlert(title: String?, message: String?, style: UIAlertControllerStyle, actions: [UIAlertAction]) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    for action in actions {
      alert.addAction(action)
    }
    present(alert, animated: true, completion: nil)
  }
  
}

extension MainController: UIGestureRecognizerDelegate {
  
}
