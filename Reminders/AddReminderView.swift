//
//  AddReminderView.swift
//  Reminders
//
//  Created by Bradley Windybank on 18/12/19.
//  Copyright © 2019 Bradley Windybank. All rights reserved.
//

import SwiftUI

struct AddReminderView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var contents = ""
    @State private var date = Date()
    @State private var time = Date()
    @State private var category = ""
    //@State private var completed
    
    var categories = ["General", "Work", "Home", "Personal", "Health", "Family", "Friends", "Admin", "Finance", "Shopping", "Pets", "Travel"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Reminder Contents", text: $contents)
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    DatePicker(selection: $date, in: Date()..., displayedComponents: .date) {
                        Text("Select a date")
                    }
                    DatePicker(selection: $time, in: Date()..., displayedComponents: .hourAndMinute) {
                        Text("Select a time")
                    }
                }
                Section {
                    Button("Save") {
                        let reminder = Reminder(context: self.moc)
                        reminder.contents = self.contents
                        reminder.category = self.category
                        reminder.completed = false
                        reminder.date = self.date
                        reminder.time = self.time
                        
                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Reminder")
        }
    }
}

struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView()
    }
}
