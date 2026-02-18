//
//  ParcelDataModel.swift
//  ParcelAppCalculatorTut
//
//  Created by Chidubem Obinwanne on 13/02/2026.
//
import Foundation
import SwiftData

@Model
class ParcelDataModel {
    var weight: String
    var volume: String
    var cost: String
    var postDate: Date
    
    init(weight: String, volume: String, cost: String, postDate: Date) {
        self.weight = weight
        self.volume = volume
        self.cost = cost
        self.postDate = postDate
    }
}
