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
            Button("Calc Walks", action: self.calculate)
                .padding()
                .frame(width: 100.0)
                .disabled(randomWalk.enableButton == false)
            
            HStack {
                // Drawing
//                if(randomWalk.hasBeenCalled) {
                    RandomWalkView(walkPts: $randomWalk.walks)
                    .padding()
                    .aspectRatio(1, contentMode: .fit)
                    .drawingGroup()
//                }
            }
        }
    }
    
    func calculate() {
        
        randomWalk.setButtonEnable(state: false)
        self.randomWalk.objectWillChange.send()
        let _ = randomWalk.nParticleRandomWalk(meanFP: 20.0, eLoss: 1.0, eMax: 10.0, n: 1)
//        print(String(format: "Num Escaped: %d\n", walks.escapedCount))
//        for walk in walks.paths {
//            for pt in walk {
//                print(String(format: "%f, %f\n",pt.x,pt.y))
//            }
//            print("------------------------\n")
//        }
        randomWalk.setButtonEnable(state: true)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
