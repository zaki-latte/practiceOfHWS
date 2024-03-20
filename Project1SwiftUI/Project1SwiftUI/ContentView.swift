//
//  ContentView.swift
//  Project1SwiftUI
//
//  Created by Yuta on 2024/02/21.
//

import SwiftUI

struct ContentView: View {
    //MARK: - Property
    @State private var pictures = [String]()
    
    //MARK: - Property: body
    var body: some View {
        Text("")
            .onAppear{
                viewDidLoad()
            }
    }
    
    //MARK: - Method
    func viewDidLoad(){
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items{
            if item.hasPrefix("nssl"){
                pictures.append(item)
            }
        }
        
        print(pictures)
    }
}

