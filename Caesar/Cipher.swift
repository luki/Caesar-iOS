//
//  Cipher.swift
//  Caesar
//
//  Created by L on 2/13/17.
//  Copyright © 2017 Lukas A. Muller. All rights reserved.
//

import Foundation
import CloudKit
import CoreData

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
  
  // MARK: CoreData section
  
  init(managedObject: NSManagedObject) {
    offset = managedObject.value(forKey: "offset") as! Int
    appliedMethod = managedObject.value(forKey: "appliedMethod") as! Int
    content = managedObject.value(forKey: "content") as! String
    date = managedObject.value(forKey: "date") as! Date
  }

  func saveCoreData(appDelegate: AppDelegate) {
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Cipher", in: managedContext)
    let item = NSManagedObject(entity: entity!, insertInto: managedContext)
    
    item.setValue(self.offset, forKey: "offset")
    item.setValue(self.content, forKey: "content")
    item.setValue(self.appliedMethod, forKey: "appliedMethod")
    item.setValue(self.date, forKey: "date")
    
    do {
      try managedContext.save()
    } catch {
      print("Error saving data")
    }
  }
}
