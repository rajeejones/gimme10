//
//  Challenge+CoreDataProperties.swift
//  Gimme 10
//
//  Created by Rajee Jones on 4/29/17.
//  Copyright © 2017 Rajee Jones. All rights reserved.
//

import Foundation
import CoreData


extension Challenge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Challenge> {
        return NSFetchRequest<Challenge>(entityName: "Challenge")
    }

    @NSManaged public var currentSet: Int16
    @NSManaged public var dailyReps: Int16
    @NSManaged public var endDate: NSDate?
    @NSManaged public var isCurrent: Bool
    @NSManaged public var repsPerSet: Int16
    @NSManaged public var startDate: NSDate?
    @NSManaged public var startHour: Int16
    @NSManaged public var title: String
    @NSManaged public var totalSets: Int16
    @NSManaged public var workout: Workout

}
