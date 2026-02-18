//
//  ContentView.swift
//  ParcelAppCalculatorTut
//
//  Created by Chidubem Obinwanne on 06/02/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    //TODO: Add @State properties for height, weight, width, depth and cost in modelContext
    @Environment(\.modelContext) private var modelContext
    @AppStorage("weight") private var weight: String = ""
    @AppStorage("height") private var height: String = ""
    @AppStorage("width") private var width: String = ""
    @AppStorage("depth") private var depth: String = ""
    @AppStorage("cost") private var cost: Double = 0.00
    @AppStorage("errorMessage") private var errorMessage: String = ""
    @State private var useAdvanceCalculator: Bool = false
    @AppStorage("postDate") private var postDate: Date = Date()
    
    var isDisabled: Bool{
        weight.isEmpty || height.isEmpty || width.isEmpty || depth.isEmpty
    }
    var body: some View {
            VStack(spacing:20) {
                Text("📦 Parcel Calculator").font(.title).padding()
                
                Toggle(isOn: $useAdvanceCalculator) {
                    Text("Use Advanced Pricing")
                }.padding(.horizontal)
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                
                DatePicker("Select Date", selection: $postDate, in: ...Date(), displayedComponents: .date)
                    .padding()
                HStack {
                    Label("Weight (kg)", systemImage: "").labelStyle(.titleOnly).frame(width: 120, alignment: .trailing)
                    TextField("Enter weight", text: $weight).textFieldStyle(RoundedBorderTextFieldStyle()).border(Color.black, width:2).keyboardType(.decimalPad)
                }
                HStack {
                    Label("Height (cm)", systemImage: "").labelStyle(.titleOnly).frame(width: 120, alignment: .trailing)
                    TextField("Enter height", text: $height).textFieldStyle(RoundedBorderTextFieldStyle()).border(Color.black, width:2).keyboardType(.decimalPad)
                }
                HStack {
                    Label("Width (cm)", systemImage: "").labelStyle(.titleOnly).frame(width: 120, alignment: .trailing)
                    TextField("Enter width", text: $width).textFieldStyle(RoundedBorderTextFieldStyle()).border(Color.black, width:2).keyboardType(.decimalPad)
                }
                HStack {
                    Label("Depth (cm)", systemImage: "").labelStyle(.titleOnly).frame(width: 120, alignment: .trailing)
                    TextField("Enter depth", text: $depth).textFieldStyle(RoundedBorderTextFieldStyle()).border(Color.black, width:2).keyboardType(.decimalPad)
                }
                Button("Calculate Cost"){
                    
                    print("Cost \(cost)")
                    print("Error: \(errorMessage)")
                    
                    calculateCost(height: height, weight: weight, width: width, depth: depth)
                    

                }.buttonStyle(.borderedProminent).padding().disabled(isDisabled).background(isDisabled ? Color.gray : Color.blue).foregroundColor(Color.white).cornerRadius(8)
                
                if cost > 0.00 {
                    Text("Total Cost: £\((String(format: "%.2f",cost)))").fontWeight(.bold).foregroundStyle(Color.blue)
                }else if !errorMessage.isEmpty {
                    Text(errorMessage).foregroundColor(.red)
                    }
            }//vstack
            .padding().frame(maxHeight: .infinity, alignment: .top)
    
    }

    private func calculateCost(height: String, weight: String, width: String, depth: String){
        cost = 0.00
        errorMessage = ""
        
        guard let weightValue = Double(weight), weightValue > 0, let heightValue = Double(height), heightValue > 0, let widthValue = Double(width), widthValue > 0, let depthValue = Double(depth), depthValue > 0 else {
            errorMessage = "Error: Please enter valid numeric amounts"
            return
        }
        
        if useAdvanceCalculator {
            if weightValue > 30 {
                errorMessage = "Error: Max weight is 30kg"
                return
            }
            if depthValue > 150 || widthValue > 150 || heightValue > 150 {
                errorMessage = "Error: Max dimension is 150cm"
                return
            }
            cost = calculateAdvancedCost(height: heightValue, weight: weightValue, width: widthValue, depth: depthValue)
        }else{
            cost = calculateBasicCost(height: heightValue, weight: weightValue, width: widthValue, depth: depthValue)
        }
    }
    
    private func calculateBasicCost(height: Double, weight: Double, width: Double, depth: Double) -> Double {
        
       
            let volume = height * width * depth
            var totalCost = 3.00
            
            totalCost += weight * 0.50
            totalCost += (volume / 1000) * 0.10
            totalCost = max(totalCost, 4.00)
            
        let newRecord = ParcelDataModel(weight: String(weight), volume: String(volume), cost: String(totalCost), postDate: postDate)
        modelContext.insert(newRecord)
        try? modelContext.save()
        
        return  totalCost
        
    }
    
    private func calculateAdvancedCost(height: Double, weight: Double, width: Double, depth: Double) -> Double {
        
       
            let volume = height * width * depth
        let dimensionalWeight = volume / 5000
        let chargeableWeight = weight > dimensionalWeight ? weight : dimensionalWeight
        let baseCost = 2.50
            var totalCost = baseCost
            
            totalCost += chargeableWeight * 1.50
            totalCost += (volume / 1000) * 0.75
        if weight > 20 {
            totalCost *= 1.50
        }else if weight > 10 {
            totalCost *= 1.25
        }
        
        let newRecord = ParcelDataModel(weight: String(weight), volume: String(volume), cost: String(totalCost), postDate: postDate)
        modelContext.insert(newRecord)
        try? modelContext.save()
            
        return max(totalCost, 5.00)
        
    }
}

#Preview {
    ContentView()
}
