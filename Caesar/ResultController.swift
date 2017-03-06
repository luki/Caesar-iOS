//
//  ResultController.swift
//  Caesar
//
//  Created by L on 3/6/17.
//  Copyright © 2017 Lukas A. Muller. All rights reserved.
//

import UIKit

class ResultController: UIViewController {
  
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
    ibv.backgroundColor = .black
    return ibv
  }()
  
  let outputBackground: UIView = {
    let bg = UIView()
    bg.backgroundColor = UIColor.new(red: 76, green: 175, blue: 80)
    bg.falseAutoresizingTranslation()
    return bg
  }()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    addSubviewsTo(view, views: inputBackground, outputBackground)
    addSubviewsTo(inputBackground, views: inputTextBlock, keyBlock)
    addSubviewsTo(outputBackground, views: outputTextBlock)
    addConstraints(
      inputBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      inputBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      inputBackground.topAnchor.constraint(equalTo: view.topAnchor),
      inputBackground.heightAnchor.constraint(equalToConstant: view.frame.size.height * 0.58),
      
      keyBlock.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
      keyBlock.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
      keyBlock.topAnchor.constraint(equalTo: inputBackground.bottomAnchor, constant: -82),
      
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
      outputTextBlock.topAnchor.constraint(equalTo: outputBackground.topAnchor, constant: 44)
    )
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
