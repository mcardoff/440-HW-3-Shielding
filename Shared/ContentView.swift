//
//  ContentView.swift
//  Shared
//
//  Created by Michael Cardiff on 2/14/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var randomWalk = RandomWalk()
    @State var escaped : String = "0"
    
    var body: some View {
        HStack {
            VStack {
                Button("Calc Walks", action: self.calculate)
                    .padding()
                    .frame(width: 200.0)
                    .disabled(randomWalk.enableButton == false)
                
                Button("Clear", action: self.clear)
                    .padding()
                    .frame(width: 200.0)
                
                VStack {
                    Text("Number Escaped")
                    TextField("Get Beyond the Box", text: $escaped)
                        .padding()
                        .frame(width: 100.0)
                        .disabled(randomWalk.enableButton == false)
                }
            }
            
            // Drawing
            //                if(randomWalk.hasBeenCalled) {
            RandomWalkView(walkPts: $randomWalk.walks)
                .padding()
                .aspectRatio(1, contentMode: .fit)
                .drawingGroup()
            //                }
        }
    }
    
    func calculate() {
        
        randomWalk.setButtonEnable(state: false)
        self.randomWalk.objectWillChange.send()
        let rw = randomWalk.nParticleRandomWalk(meanFP: 100.0, eLoss: 1.0, eMax: 10.0, n: 10)
        escaped = String(rw.escapedCount)
        print(String(format: "Num Escaped: %d\n", rw.escapedCount))
        //        for walk in walks.paths {
        //            for pt in walk {
        //                print(String(format: "%f, %f\n",pt.x,pt.y))
        //            }
        //            print("------------------------\n")
        //        }
        randomWalk.setButtonEnable(state: true)
    }
    
    func clear() {
        randomWalk.eraseData()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
