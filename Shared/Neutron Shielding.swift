//
//  Neutron Shielding.swift
//  440-HW-3-Shielding
//
//  Created by Michael Cardiff on 2/14/22.
//

import Foundation

typealias CoordTupleList = [(x: Double, y: Double)]

class RandomWalk : NSObject, ObservableObject {
    
    func nParticleRandomWalk(meanFP: Double, eLoss: Double, eMax: Double) {}

    func oneParticleRandomWalk(meanFP: Double, eLoss: Double, eMax: Double) ->
    CoordTupleList {
        let LHW = -3.0, RHW = 10.0, UPW = 10.0, BTW = -3.0
        
        var counter : Int = 1
        var points : CoordTupleList = []
        var energy = eMax - eLoss
        var xCur = 0.1, yCur = 5.0
        
        while (energy > 0.0) {
            let angle = Double.random(in: 0...2*Double.pi)
            // Move forward a total distance of 1 mfp
            xCur += meanFP * cos(angle)
            yCur += meanFP * sin(angle)
            
            if (xCur < LHW) { // back in reactor, we do not care
                energy = 0
            } else if (xCur > RHW || yCur > UPW || yCur < BTW) {
                energy = 0
            } else {
                energy -= eLoss
            }
            points.append((x:xCur, y:yCur))
        }
        
        return points
    }

}
