//
//  ReminderDetailView.swift
//  Reminders
//
//  Created by Bradley Windybank on 23/12/19.
//  Copyright © 2019 Bradley Windybank. All rights reserved.
//

import CoreData
import SwiftUI

struct ReminderDetailView: View {
    let reminder: Reminder
    
    var body: some View {
        var dateString: String = "No Date"
        var timeString: String = "No Time"
        
        if let date = reminder.date, let time = reminder.time {
            let formatter = DateFormatter()
            formatter.timeStyle = .none
            formatter.dateStyle = .short
            dateString = formatter.string(from: date)
            
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            timeString = formatter.string(from: time)
        }
        
        return VStack(alignment: .leading) {
            Image(systemName: reminder.completed ?
                "checkmark.circle.fill" : "minus.circle.fill").resizable()
                .frame(width: 48, height: 48)
                .foregroundColor(reminder.completed ? .green : .gray)
            
            Text(reminder.contents ?? "Unknown Contents")
                .font(.title)
                .fontWeight(.heavy)
            
            Text("\(reminder.category ?? "No Catgegory") - \(timeString) - \(dateString)")
                
            Text(reminder.completed ? "Done" : "Incomplete")
                .font(.headline)
                .foregroundColor(reminder.completed ? .green : .gray)
        }
    }
}

struct ReminderDetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let reminder = Reminder(context: moc)
        reminder.contents = "Last Minute Shopping"
        reminder.category = "Home"
        reminder.completed = true
        reminder.date = Date()
        reminder.time = Date()

        return NavigationView {
            ReminderDetailView(reminder: reminder)
        }
    }
}
