//
//  ViewController.swift
//  Caesar
//
//  Created by L on 2/11/17.
//  Copyright © 2017 Lukas A. Muller. All rights reserved.
//

import UIKit
import CloudKit

extension UIViewController {
  public func addSubviewsTo(_ view: UIView, views: UIView...) {
    views.forEach { view.addSubview($0) }
  }
  public func addConstraints(_ constraints: NSLayoutConstraint...) {
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
  
  let publicDb = CKContainer(identifier: "iCloud.guru.luke.Caesar").publicCloudDatabase
  let privateDb = CKContainer(identifier: "iCloud.guru.luke.Caesar").privateCloudDatabase
  
  let cipherHistory: [Cipher] = [
    Cipher(offset: 5, appliedMethod: 0, content: "Hi", date: Date())
  ]
  
  func createCipherRec(cipher: Cipher) {
    let record = CKRecord(recordType: "Cipher")
    record["appliedMethod"] = cipher.appliedMethod as CKRecordValue?
    record["content"] = cipher.content as CKRecordValue?
    record["date"] = cipher.date as CKRecordValue?
    record["offset"] = cipher.offset as CKRecordValue?
    
    var errorMsg: String? = nil
    
    publicDb.save(record) { record, error in
      if record != nil {
        DispatchQueue.main.async {
          self.textView.resignFirstResponder()
          self.textView
                  .text
                  .characters
                  .removeAll()
          
          let recordModel = Cipher(record: record!)
          self.createAlert(title: "Hi", message: nil, style: .actionSheet, actions: [
            UIAlertAction(title: "Dismiss", style: .default) { _ in
              self.dismiss(animated: true, completion: nil)
            },
            UIAlertAction(title: "Delete", style: .destructive) { _ in
              self.publicDb.delete(withRecordID: (record?.recordID)!) { record, error in
                
              }
            },
            UIAlertAction(title: "Copy Input", style: .default) { _ in
            },
            UIAlertAction(title: "Copy Result", style: .default) { _ in
              var stringToCopy = ""
              switch recordModel.appliedMethod {
                case 0:
                  stringToCopy = encipher(offset: recordModel.offset, message: recordModel.content)
                case 1:
                  stringToCopy = decipher(offset: recordModel.offset, message: recordModel.content)
                default:
                  print("An unknown method appeared!")
              }
              self.copyToPasteBoard(stringToCopy)
            },
            UIAlertAction(title: "Copy Offset", style: .default) { _ in
              self.copyToPasteBoard(String(recordModel.offset))
            }
          ])
        }
      } else {
        errorMsg = error!.localizedDescription
      }
    }
    
    if errorMsg != nil {
      let alert = UIAlertController(title: errorMsg, message: nil, preferredStyle: .alert)
      self.present(alert, animated: true, completion: nil)
    }
    
  }
  
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
    return label
  }()
  
  let shiftButton: UIButton = {
    let label = UIButton()
    label.setTitle("1", for: .normal)
    label.titleLabel!.font = UIFont(name: "Okomito-Light", size: 23)!
    label.titleLabel!.textColor = .white
    label.falseAutoresizingTranslation()
    label.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
    label.addTarget(self, action: #selector(offsetTapped), for: .touchUpInside)
    label.isUserInteractionEnabled = true
    return label
  }()
  
  lazy var textView: UITextView = {
    let tv = UITextView()
    tv.textColor = UIColor.new(red: 166, green: 166, blue: 166)
    tv.falseAutoresizingTranslation()
    tv.delegate = self
    tv.returnKeyType = .go
    tv.text = "Type in your message..."
    tv.font = UIFont(name: "Okomito-Regular", size: 21.5)
    tv.isScrollEnabled = false
    tv.textContainerInset = UIEdgeInsets(top: 44, left: 44, bottom: 44, right: 44)
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
    addSubviewsTo(view, views: selectionArea, textView)
    addSubviewsTo(selectionArea, views: button, shiftButton, shiftLabel, methodSelector, selectorLabel)
    addConstraints(
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
    )
  }
  
  // MARK: Target actions
  
  func showHistory(_ sender: UIButton) {
    self.present(HistoryController(), animated: true, completion: nil)
  }
  
  func shiftAction(_ sender: UILabel) {
    sender.becomeFirstResponder()
    print("Test")
  }
  
  func offsetTapped(_ sender: UIButton) {
    print("Tap!")
  }
  
  // MARK: Helper Methods
  
  func copyToPasteBoard(_ input: String) {
    UIPasteboard.general.string = input
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
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text == "" {
      textView.text = "Type in your message..."
    }
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if text == "\n" {
      // NOTE: Check if key is available
      if !(shiftButton.titleLabel!.text?.isEmpty)! {
        let offset = Int(shiftButton.titleLabel!.text!)
        let content = textView.text
        
        var cipher: Cipher!
        
        switch methodSelector.selectedSegmentIndex {
          case 0:
            cipher = Cipher(offset: offset!, appliedMethod: methodSelector.selectedSegmentIndex, content: encipher(offset: offset!, message: content!))
          case 1:
            cipher = Cipher(offset: offset!, appliedMethod: methodSelector.selectedSegmentIndex, content: decipher(offset: offset!, message: content!))
          default:
            print("Something weird has been selected")
        }
        createCipherRec(cipher: cipher)
        return true
      }
      createAlert(title: "No Shift Offset", message: "Please set it before applying cipher", style: .alert, actions: [
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

extension MainController: UIViewControllerTransitioningDelegate { }
