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
        let walks = randomWalk.nParticleRandomWalk(meanFP: 3.0, eLoss: 1.0, eMax: 5.1, n: 10)
        print(String(format: "Num Escaped: %d\n", walks.escapedCount))
        for walk in walks.paths {
            for pt in walk {
                print(String(format: "%f, %f\n",pt.x,pt.y))
            }
            print("------------------------\n")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
