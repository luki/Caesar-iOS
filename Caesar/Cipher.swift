//
//  Cipher.swift
//  Caesar
//
//  Created by L on 2/13/17.
//  Copyright © 2017 Lukas A. Muller. All rights reserved.
//

import Foundation
import CloudKit

class Cipher {
  var offset: Int
  var appliedMethod: Int
  var content: String
  var date: Date
  var id: CKRecordID? = nil
  
  init(offset: Int, appliedMethod: Int, content: String, date: Date) {
    self.offset = offset
    self.appliedMethod = appliedMethod
    self.content = content
    self.date = date
  }
  
  convenience init(offset: Int, appliedMethod: Int, content: String) {
    self.init(offset: offset, appliedMethod: appliedMethod, content: content, date: Date())
  }
  
  init(record: CKRecord) {
    offset = (record["offset"] as? Int)!
    appliedMethod = (record["appliedMethod"] as? Int)!
    content = (record["content"] as? String)!
    date = (record["date"] as? Date)!
    id = record.recordID
  }
  
}
