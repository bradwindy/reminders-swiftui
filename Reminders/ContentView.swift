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
    @FetchRequest(entity: Reminder.entity(), sortDescriptors: []) var reminders: FetchedResults<Reminder>
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
             Text("Reminder Count: \(reminders.count)")
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
