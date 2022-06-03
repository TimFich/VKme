//
//  DateConverter.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 03.05.2022.
//

 import Foundation

 protocol DateConverter {
     func convert(_ date: Int) -> String
 }

 class DateConverterImpl: DateConverter {

     let currentTime = NSDate() as Date

     func convert(_ date: Int) -> String {
         let time = Date(timeIntervalSince1970: TimeInterval(date))
         let dif = Calendar.current.dateComponents([.minute], from: time, to: currentTime).minute
         if date == 0 {
             return "last seen recently"
         }
         if dif == 0 {
             return "online"
         }
         
         var buf = dif!
         var hours = 0
         var days = 0
         
         while buf > 1440 || buf > 60 {
             if buf > 1440 {
                 buf -= 1440
                 days += 1
             } else if buf > 60 {
                 buf -= 60
                 hours += 1
             }
         }
         if days != 0 {
             return "last seen \(days) days ago"
         } else if days != 0 {
             return "last seen \(hours) hours ago"
         }
         return "last seen \(buf) minutes ago"
     }
 }
