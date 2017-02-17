//
//  Cipher.swift
//  Caesar
//
//  Created by L on 2/13/17.
//  Copyright © 2017 Lukas A. Muller. All rights reserved.
//

import Foundation

struct Cipher {
  var offset: Int
  var appliedMethod: Int
  var content: String
  var date: Date
  
  init(offset: Int, appliedMethod: Int, content: String, date: Date) {
    self.offset = offset
    self.appliedMethod = appliedMethod
    self.content = content
    self.date = date
  }
}
