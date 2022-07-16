//
//  ContentView.swift
//  WeSplit
//
//  Created by Tan Leblebici on 16.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercantage = 20
    @FocusState private var amountIsFocused: Bool

    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double { //--> Calculating total per person
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercantage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView{ //--> Slide and pick
        Form{
            Section{
                TextField("Amount", value: $checkAmount, format: .currency(code:  Locale.current.currencyCode ?? "USD"))
                    .keyboardType(.decimalPad) //--> Reading text from the user with TextField
                    .focused($amountIsFocused)
                
                Picker("Number of People", selection:  $numberOfPeople) {
                    ForEach(2..<100){
                        Text("\($0) people") //--> Creating pickers in a Form
                    }
                }
            }
            
            Section{ //--> Adding Segmented control for tip percentages
                Picker("Tip percentage", selection: $tipPercantage) {
                    ForEach(tipPercentages, id: \.self) {
                        Text($0, format: .percent)
                    }
                }
                .pickerStyle(.segmented) //--> makes segmented bar
            } header: { //--> adds header
                Text("How much tip do you want to leave")
            }
            
            Section{
                Text(totalPerPerson, format: .currency(code:
                    Locale.current.currencyCode ?? "USD"))
            } header: {
                Text("Amount per person")
            }
            }
            .navigationTitle("WeSplit")
            .toolbar{ //--> let us specify toolbar items for review
                ToolbarItemGroup(placement: .keyboard) {//-->Keyboard slides down
                    Spacer() //--> to show done button at the corner
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
