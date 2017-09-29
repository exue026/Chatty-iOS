//
//  Date.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-07.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

extension Date {
    
    var secondsInAWeek: Int { return 604800 }
    var secondsInADay: Int { return 86400 }
    var secondsInAHour: Int { return 3600 }
    var secondsInAMinute: Int { return 60 }
    
    func getTimeSinceNow() -> String {
        let time = Int(Date().timeIntervalSince(self))
        if (time / secondsInAWeek >= 1) {
            return String(time / secondsInAWeek) + " " + "WEEKS_AGO".localized()
        }
        else if (time / secondsInADay >= 1) {
            return String(time / secondsInADay) + " " + "DAYS_AGO".localized()
        }
        else if (time / secondsInAHour >= 1) {
            return String(time / secondsInAHour) + " " + "HOURS_AGO".localized()
        }
        else if (time / secondsInAMinute >= 1) {
            return String(time / secondsInAMinute) + " " + "MINUTES_AGO".localized()
        }
        else {
            return "NOW".localized()
         }
    }
}
