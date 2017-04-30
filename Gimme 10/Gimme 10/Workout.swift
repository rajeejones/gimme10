//
//  Workout.swift
//  Gimme 10
//
//  Created by Rajee Jones on 4/29/17.
//  Copyright © 2017 Rajee Jones. All rights reserved.
//

import UIKit

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
