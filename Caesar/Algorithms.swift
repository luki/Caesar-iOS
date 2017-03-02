//
//  Algorithms.swift
//  Caesar
//
//  Created by L on 2/13/17.
//  Copyright © 2017 Lukas A. Muller. All rights reserved.
//

import Foundation

extension Array {
  public func lastPosition() -> Int {
    return self.count - 1
  }
  
  public func distanceArray(from: Int, to: Int) -> [Element] {
    var tempArray = [Element]()
    for i in from...to {
      tempArray.append(self[i])
    }
    return tempArray
  }
}

public func shiftSequence(offset: Int, baseSequence: String) -> String {
  var newSequence: String
  
  var seqArray = [String]()
  baseSequence.characters.forEach { seqArray.append("\($0)") }
  
  if offset >= seqArray.count {
    newSequence = seqArray
      .distanceArray(from: offset % seqArray.count, to: seqArray.lastPosition())
      .joined()
    if (offset % seqArray.count) != 0 {
      newSequence += seqArray
        .distanceArray(from: 0, to: offset % seqArray.count - 1)
        .joined()
    }
  } else {
    newSequence = seqArray
      .distanceArray(from: offset, to: seqArray.lastPosition())
      .joined()
    if offset != 0 {
      newSequence += seqArray
        .distanceArray(from: 0, to:  offset - 1)
        .joined()
    }
  }
  return newSequence
}

public func encipher(offset: Int, message: String) -> String {
  let base = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  
  var baseSeq = [String]()
  base.characters.forEach { baseSeq.append("\($0)")}
  
  var newSeq = [String]()
  shiftSequence(offset: offset, baseSequence: base).characters.forEach { newSeq.append("\($0)")}
  
  var newString = String()
  
  message.characters.forEach {
    var found = false
    for i in 0...baseSeq.count - 1 {
      if "\($0)" == baseSeq[i] {
        newString += newSeq[i]
        found = true
      }
    }
    // If it couldn't find a match, it uses the actual letter
    if !found {
      newString += "\($0)"
    }
  }
  
  return newString
}

public func decipher(offset: Int, message: String) -> String {
  let base = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  
  var cipherSeq = [String]()
  shiftSequence(offset: offset, baseSequence: base).characters.forEach { cipherSeq.append("\($0)") }
  
  var baseSeq = [String]()
  base.characters.forEach { baseSeq.append("\($0)") }
  
  var newString = String()
  
  message.characters.forEach {
    var found = false
    for i in 0...cipherSeq.count - 1 {
      if "\($0)" == cipherSeq[i] {
        newString += baseSeq[i]
        found = true
      }
    }
    if !found {
      newString += "\($0)"
    }
  }
  return newString
}
