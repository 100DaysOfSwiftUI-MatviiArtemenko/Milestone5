//
//  CarouselView.swift
//  Milestone5
//
//  Created by admin on 22/02/2023.
//

import Foundation
import SwiftUI
import CoreData

struct EventItem: Identifiable, Hashable {
    var id: UUID
    var title: String
    var color: Color
    
}

class EventVM: ObservableObject {
    @Published var items: [EventItem] = []
    
    let colors: [Color] = [.red, .green, .purple, .yellow, .orange, .mint, .cyan, .brown, .blue]
    
    
}

struct CarouselView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var vm: DataController
    @ObservedObject var carousel: EventVM
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    var body: some View {
        NavigationView {
            ZStack {
//                AngularGradient(colors: [.orange, .indigo, .black, .orange, .mint], center: .leading)
//                    .grayscale(0.55) // can play with colors later
//                    .ignoresSafeArea()
//                    .scaleEffect(1.4)
                
                ForEach(vm.savedEvents) { item in
                    VStack {
                        ZStack {
                            VStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 300, height: 500)
                                    .background(.regularMaterial)
                                    .opacity(0.15)
                                    .cornerRadius(15)
                                
                                    .overlay(alignment: .top) {
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(.teal)
                                            .frame(width: 300, height: 375)
                                        
                                        Text(item.wrappedTitle)
                                            .bold()
                                            .padding()
                                        
                                    }
                                    .overlay(alignment: .bottom) {
                                        Text(item.wrappedDescription)
                                            .font(.caption)
                                            .frame(width: 220)
                                            .padding()
                                            .background(.regularMaterial)
                                            .cornerRadius(15)
                                            .padding()
                                    }
                            }
                        }
                        Spacer()
                    }
                    .scaleEffect(1.0 - abs(distance(Int(indexOfEvent(vm.savedEvents, item)))) * 0.2)
                    .opacity(1.0 - abs(indexOfEvent(vm.savedEvents, item)) * 0.3)
                    .blur(radius: abs(indexOfEvent(vm.savedEvents, item)) * 1.0)
                    .offset(x: myXOffset(Int(indexOfEvent(vm.savedEvents, item))), y: 0)
                    .zIndex(1.0 - abs(indexOfEvent(vm.savedEvents, item)) * 0.1)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        withAnimation {
                            draggingItem = snappedItem + value.translation.width / 100
                        }
                    })
                    .onEnded({ value in
                        withAnimation {
                            draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                            draggingItem = round(draggingItem).remainder(dividingBy: Double(carousel.items.count))
                            snappedItem = draggingItem
                        }
                        
                    })  )
            VStack {
                NavigationLink {
                    AddEventView(eventVM: carousel, vm: vm)
                } label: {
                    Text("Add new event.")
                }
            }
        }
        .navigationBarHidden(true)
    }
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(carousel.items.count))
    }
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2/Double(carousel.items.count) * (distance(item))
        return sin(angle) * 200
    }
    func indexOfEvent(_ items: [EventEntity], _ item: EventEntity) -> Double {
        var itemIndex = 0.0
        if let index = items.firstIndex(of: item) {
            itemIndex = Double(index)
            return Double(index)
        }
        return itemIndex
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

