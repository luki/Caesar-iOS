//
//  ResultController.swift
//  Caesar
//
//  Created by L on 3/6/17.
//  Copyright © 2017 Lukas A. Muller. All rights reserved.
//

import UIKit

class ResultController: UIViewController {
  
  let uploadToCloudButton: UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 88, height: 88))
    button.contentMode = .scaleAspectFit
    button.setImage(UIImage(named: "upload"), for: UIControlState.normal)
    button.falseAutoresizingTranslation()
//    button.addTarget(self, action: #selector(clearHistory), for: .touchUpInside)
    return button
  }()
  
  let saveButton: UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 88, height: 88))
    button.contentMode = .scaleAspectFit
    button.setImage(UIImage(named: "save"), for: UIControlState.normal)
    button.falseAutoresizingTranslation()
//    button.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
    return button
  }()
  
  let closeButton: UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 88, height: 88))
    button.contentMode = .scaleAspectFit
    button.setImage(UIImage(named: "close"), for: UIControlState.normal)
    button.falseAutoresizingTranslation()
    button.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
    return button
  }()
  
  // Input Views
  
  let inputBackground: UIView = {
    let bg = UIView()
    bg.backgroundColor = .white
    bg.falseAutoresizingTranslation()
    return bg
  }()
  
  let inputTextBlock: InfoBlockView = {
    let ibv = InfoBlockView()
    ibv.falseAutoresizingTranslation()
    ibv.titleLabel.text = "Input".uppercased()
    ibv.textLabel.text = "Some example text"
    return ibv
  }()
  
  let keyBlock: InfoBlockView = {
    let ibv = InfoBlockView()
    ibv.falseAutoresizingTranslation()
    ibv.titleLabel.text = "Key".uppercased()
    ibv.textLabel.text = "21"
    ibv.backgroundColor = .black
    return ibv
  }()
  
  // Output Views
  
  let outputTextBlock: InfoBlockView = {
    let ibv = InfoBlockView()
    ibv.falseAutoresizingTranslation()
    ibv.titleLabel.text = "Output".uppercased()
    ibv.textLabel.text = "Some example text"
    ibv.titleLabel.textColor = UIColor.new(red: 60, green: 117, blue: 62)
    ibv.textLabel.textColor = .white
//    ibv.backgroundColor = .black
    return ibv
  }()
  
  let outputBackground: UIView = {
    let bg = UIView()
    bg.backgroundColor = UIColor.new(red: 76, green: 175, blue: 80)
    bg.falseAutoresizingTranslation()
    return bg
  }()
  
  let copyArea: UIView = {
    let bg = UIView()
    bg.backgroundColor = .clear
    bg.isUserInteractionEnabled = true
    bg.falseAutoresizingTranslation()
    return bg
  }()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    addSubviewsTo(view, views: inputBackground, outputBackground, copyArea)
    addSubviewsTo(inputBackground, views: uploadToCloudButton, saveButton, closeButton, inputTextBlock, keyBlock)
    addSubviewsTo(outputBackground, views: outputTextBlock)
    addConstraints(
      inputBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      inputBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      inputBackground.topAnchor.constraint(equalTo: view.topAnchor),
      inputBackground.heightAnchor.constraint(equalToConstant: view.frame.size.height * 0.58),
      
      closeButton.trailingAnchor.constraint(equalTo: inputBackground.trailingAnchor, constant: -44),
      closeButton.topAnchor.constraint(equalTo: inputBackground.topAnchor, constant: 44),
      uploadToCloudButton.leadingAnchor.constraint(equalTo: inputBackground.leadingAnchor, constant: 44),
      uploadToCloudButton.topAnchor.constraint(equalTo: inputBackground.topAnchor, constant: 44),
      saveButton.leadingAnchor.constraint(equalTo: uploadToCloudButton.trailingAnchor, constant: 22),
      saveButton.topAnchor.constraint(equalTo: inputBackground.topAnchor, constant: 44),
      
      keyBlock.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
      keyBlock.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
      keyBlock.topAnchor.constraint(equalTo: inputBackground.bottomAnchor, constant: -90),
      
      inputTextBlock.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
      inputTextBlock.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
      inputTextBlock.topAnchor.constraint(equalTo: keyBlock.topAnchor, constant: -74),
      
      // Output
      outputBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      outputBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      outputBackground.topAnchor.constraint(equalTo: inputBackground.bottomAnchor),
      outputBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      outputTextBlock.leadingAnchor.constraint(equalTo: outputBackground.leadingAnchor, constant: 44),
      outputTextBlock.trailingAnchor.constraint(equalTo: outputBackground.trailingAnchor, constant: -44),
      outputTextBlock.topAnchor.constraint(equalTo: outputBackground.topAnchor, constant: 44),
      outputTextBlock.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44),
      
      copyArea.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      copyArea.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      copyArea.topAnchor.constraint(equalTo: inputBackground.bottomAnchor),
      copyArea.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    )
  }
  
  override func viewDidAppear(_ animated: Bool) {
    copyArea.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(copyAction)))
  }
  
  // MARK: Target Methods
  
  func closeScreen(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  func copyAction(_ sender: UITapGestureRecognizer) {
    UIPasteboard.general.string = outputTextBlock.textLabel.text
  }
  
}

class InfoBlockView: UIView {
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.falseAutoresizingTranslation()
    label.numberOfLines = 1
    label.font = UIFont(name: "Okomito-Medium", size: 11.5)
    label.textColor = UIColor.new(red: 69, green: 90, blue: 100)
    return label
  }()
  
  let textLabel: UILabel = {
    let label = UILabel()
    label.falseAutoresizingTranslation()
    label.numberOfLines = 0
    label.font = UIFont(name: "Okomito-Regular", size: 20.5)
    label.textColor = UIColor.new(red: 166, green: 166, blue: 166)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviews(titleLabel, textLabel)
    addConstraints(
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
    )
  }
  
  func addSubviews(_ views: UIView...) {
    for view in views {
      addSubview(view)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
