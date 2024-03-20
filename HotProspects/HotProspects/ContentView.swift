//
//  ContentView.swift
//  HotProspects
//
//  Created by Yuta on 2023/12/22.
//

import SwiftUI
import UserNotifications
import SamplePackage


//MARK: - ContentView
struct ContentView: View {
    let possibleNumbers = Array(1...60)
    var results: String{
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    var body: some View {
        
    }
    
    
}



