//
//  EventView.swift
//  Milestone5
//
//  Created by admin on 22/02/2023.
//

import SwiftUI

struct AddEventView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var eventVM: EventVM
    @State private var eventTitle = ""
    @State private var eventDescription = ""

    var body: some View {
        VStack {
            
            Image(systemName: "plus.rectangle.fill")
                .frame(width: 350, height: 300)
                .font(.system(size: 60))
                .background(.regularMaterial)
                .cornerRadius(18)
                .padding()
            
            Spacer()
            
            TextField("name event", text: $eventTitle)
                .frame(width: 300)
                .padding()
                .background(.regularMaterial)
                .cornerRadius(18)
            TextField("name event", text: $eventDescription)
                .frame(width: 300)
                .padding()
                .background(.regularMaterial)
                .cornerRadius(18)
            
            Button {
                let newEvent = EventEntity(context: moc)
                newEvent.title = eventTitle
                newEvent.eventDescription = eventDescription
                
                try? moc.save()
            } label: {
                Image(systemName: "plus.app")
            }
                

            
            Spacer()
            
            
        }
        
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView(eventVM: EventVM())
    }
}
