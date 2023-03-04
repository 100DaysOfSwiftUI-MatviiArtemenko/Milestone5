//
//  ContentView.swift
//  Milestone5
//
//  Created by admin on 20.09.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @StateObject var eventVM = EventVM()
    @StateObject var vm = DataController()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    @State private var addEventIsShowing = false

    var body: some View {
        NavigationView {
            ZStack {
                AngularGradient(colors: [.orange, .indigo, .black, .orange, .mint], center: .leading)
                    .grayscale(0.55) // can play with colors later
                    .ignoresSafeArea()
                    .scaleEffect(1.4)
                // if there are no events --> show "addNewEventView" else show "CarouselView"
                
                if vm.savedEvents.isEmpty {
                    VStack {
                        Button {
                            addEventIsShowing = true
                        } label: {
                            Image("plus.app.fill")
                                .font(.system(size: 50))
                                .padding()
                                .background(.thinMaterial)
                                .cornerRadius(18)
                        }
                       
                    }
                } else {
                
                    CarouselView(vm: vm, carousel: eventVM)
                }
            }
            
        }
        .onAppear {
            for event in vm.savedEvents {
                print(event.id ?? "not found")
            }
        }
        .sheet(isPresented: $addEventIsShowing) { AddEventView(eventVM: eventVM, vm: vm) }
        .navigationTitle(Text("new name"))
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(eventVM.items.count))
    }
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2/Double(eventVM.items.count) * (distance(item))
        return sin(angle) * 200
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
