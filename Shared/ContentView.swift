//
//  ContentView.swift
//  Shared
//
//  Created by Michael Cardiff on 2/14/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var randomWalk = RandomWalk()
    @State var numParticleString : String = "1000"
    @State var mfpString : String = "50.0"
    @State var eLossString : String = "0.50"
    @State var eMaxString : String = "10"
    @State var boxHeightString : String = "600"
    @State var boxWidthString : String = "600"
    @State var escaped : String = "0"
    @State var box : [CoordTupleList] = [];
    
    var body: some View {
        HStack {
            VStack {
                
                VStack {
                    Text("Number of Particles")
                    TextField("", text: $numParticleString)
                        .frame(width: 100.0)
                }.padding()
                
                VStack {
                    Text("Mean Free Path")
                    TextField("Distance Travelled per step", text: $mfpString)
                        .frame(width: 100.0)
                }.padding()
                
                VStack {
                    Text("% Energy Lost")
                    TextField("Per MFP", text: $eLossString)
                        .frame(width: 100.0)
                }.padding()
                
                VStack {
                    Text("Max Energy")
                    TextField("Incoming energy", text: $eMaxString)
                        .frame(width: 100.0)
                }.padding()
                
                VStack {
                    Text("Box Height")
                    TextField("", text: $boxHeightString)
                        .frame(width: 100.0)
                }.padding()
                
                VStack {
                    Text("Box Width")
                    TextField("", text: $boxWidthString)
                        .frame(width: 100.0)
                }.padding()
                
                // should be last
                VStack {
                    Text("Number Escaped")
                    TextField("Get Beyond the Box", text: $escaped)
                        .frame(width: 100.0)
                        .disabled(randomWalk.enableButton == false)
                }.padding()
                
                // Buttons
                Button("Calc Walks", action: self.calculate)
                    .padding()
                    .frame(width: 200.0)
                    .disabled(randomWalk.enableButton == false)
                
                Button("Clear", action: self.clear)
                    .padding()
                    .frame(width: 200.0)
            }
            
            // Drawing
            RandomWalkView(walkPts: $randomWalk.walks, boxPts: $box)
                .padding()
                .aspectRatio(1, contentMode: .fit)
                .drawingGroup()
        }
    }
    
    func calculate() {
        
        randomWalk.setButtonEnable(state: false)
        
        self.randomWalk.objectWillChange.send()
        
        let rw = randomWalk.nParticleRandomWalk(
            meanFP: Double(mfpString)!, eLoss: Double(eLossString)!, eMax: Double(eMaxString)!,
            rightWall: Double(boxWidthString)!, upWall: Double(boxHeightString)!,
            n: Int(numParticleString)!)
        
        escaped = String(rw.escapedCount)
//        for walk in rw.paths {
//            for pt in walk {
//                print(String(format: "%f, %f\n",pt.x,pt.y))
//            }
//            print("------------------------\n")
//        }
        randomWalk.setButtonEnable(state: true)
        
        box.append([(x: Double(boxWidthString)!, y: 0),
               (x: Double(boxWidthString)!, y: Double(boxHeightString)!),
               (x: 0, y: Double(boxHeightString)!),
               (x: 0, y: 0),
               (x: Double(boxWidthString)!, y:0)]);
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
