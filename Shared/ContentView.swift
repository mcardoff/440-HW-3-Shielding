//
//  ContentView.swift
//  Shared
//
//  Created by Michael Cardiff on 2/14/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var randomWalk = RandomWalk()
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            
            Button("Do Stuff", action: self.calculate)
            
        }
    }
    
    func calculate() {
        var points = randomWalk.oneParticleRandomWalk(meanFP: 1.0, eLoss: 1.0, eMax: 5.1)
        for pt in points {
            print(String(format: "%f, %f\n",pt.x,pt.y))
        }
        print("------------------------\n")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
