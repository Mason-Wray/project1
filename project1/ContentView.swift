//
//  ContentView.swift
//  project1
//
//  Created by Student on 10/4/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var amount = 0.0
    @State private var peopleNumber = 2
    @State private var tipPercentage = 20
    @FocusState var amountFocuses: Bool
    
    var tipPercentages = [ 0, 10, 15, 20, 25]
    
    var totalperPerson: Double {
        let peopleCount = Double(peopleNumber + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = amount + tipSelection
        let absTotal = tipValue + amount
        let amountPerPerson = absTotal / peopleCount
        return amountPerPerson
    }
    var body: some View {
        Form {
            Section {
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountFocuses)
                Picker("individuals?", selection: $peopleNumber) {
                    ForEach(2..<100){
                        Text("\($0) people")
                    }
                }
                .pickerStyle(.navigationLink)
            }
            Section("hou much tip would you like to leave?") {
                Picker("Tip percentage", selection: $tipPercentage){
                    ForEach(tipPercentages, id: \.self){
                        Text($0, format: .percent)
                    }
                }
                .pickerStyle(.segmented)
            }
            Section{
                Text(totalperPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .foregroundColor(tipPercentage == 0 ? .red : .black)
                if(tipPercentage == 0){
                    Text("get a job")
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
