//
//  HistoryView.swift
//  ParcelAppCalculatorTut
//
//  Created by Chidubem Obinwanne on 13/02/2026.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var parcels: [ParcelDataModel]
    
    var body: some View {
        NavigationStack{
            List(parcels){ parcel in
//                Text(parcel.postDate, format: Date.FormatStyle().day().month().year())
//                Text(parcel.weight)
//                Text(parcel.volume)
//                Text(parcel.cost)
//            
                
            HStack{
//                    Text("📦")
                Image(systemName: "shippingbox").foregroundStyle(Color.blue).imageScale(.large).padding(.trailing, 10)
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "calendar")
                        Text(parcel.postDate, format: Date.FormatStyle().day().month().year())
                    }
                    
                    HStack{
                        Image(systemName: "scalemass").foregroundStyle(Color.yellow)
                        Text("\(parcel.weight)kg").padding(.trailing,5)
                        Image(systemName: "shippingbox").foregroundStyle(Color.green)
                        Text("\(parcel.volume)cm³")
                    }
                    
                }
                Spacer()
                Text("£\(parcel.cost)").fontWeight(.bold).foregroundStyle(Color.blue)
            }.frame(width: .infinity)
            }
            .padding(.vertical, 5)
            .navigationTitle("Calculation History")
            
        }
    }
}

#Preview {
    HistoryView()
}
