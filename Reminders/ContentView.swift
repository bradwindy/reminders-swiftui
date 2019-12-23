//
//  ContentView.swift
//  Reminders
//
//  Created by Bradley Windybank on 18/12/19.
//  Copyright © 2019 Bradley Windybank. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Reminder.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Reminder.date, ascending: true),
        NSSortDescriptor(keyPath: \Reminder.time, ascending: true)
    ]) var reminders: FetchedResults<Reminder>
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(reminders, id: \.self) { reminder in
                    NavigationLink(destination: ReminderDetailView(reminder: reminder)) {
                        VStack(alignment: .leading) {
                            Text(reminder.contents ?? "Unknown Contents")
                                .font(.headline)
                            
                            Text("\(reminder.category ?? "No Catgegory") - \(dateToString(date: reminder.date)) - \(timeToString(time: reminder.time))")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
                .navigationBarTitle("Reminders")
                .navigationBarItems(trailing:
                    Button(action: {
                        self.showingAddScreen.toggle()
                    }){
                        Image(systemName: "plus")
                    }
                )
                .sheet(isPresented: $showingAddScreen) {
                    AddReminderView().environment(\.managedObjectContext, self.moc)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func dateToString(date: Date?) -> String {
    if let date = date {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
    
    return "No Date"
}

func timeToString(time: Date?) -> String {
    if let time = time {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter.string(from: time)
    }
    
    return "No Time"
}
