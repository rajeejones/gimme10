//
//  Workout.swift
//  Gimme 10
//
//  Created by Rajee Jones on 4/29/17.
//  Copyright © 2017 Rajee Jones. All rights reserved.
//

import UIKit
import Foundation
import CoreData

public class Workout: NSManagedObject, NSCoding {
  
  var type: WorkoutType!
  
  init(withType type: WorkoutType) {
    self.type = type
  }
  
  required public init(coder aDecoder: NSCoder) {
    self.type = aDecoder.decodeObject(forKey: "type") as! WorkoutType
  }
  
  public func encode(with aCoder: NSCoder) {
    aCoder.encode(self.type, forKey: "type")
  }

}

enum WorkoutType: String {
  case pushups = "Pushup Challenge"
  case crunches = "Crunches Challenge"
  case squats = "Squat Challange"
  case lunges = "Lunges Challenge"
  case empty = ""
  
  func toString () -> String {
    return self.rawValue
  }
  
}
