//
//  Neutron Shielding.swift
//  440-HW-3-Shielding
//
//  Created by Michael Cardiff on 2/14/22.
//

import Foundation

typealias CoordTupleList = [(x: Double, y: Double)]
typealias RandomWalkInfo = (path: CoordTupleList, escaped: Bool)
typealias MultiRandomWalkInfo = (paths: [CoordTupleList], escapedCount: Int)

class RandomWalk : NSObject, ObservableObject {
    
    func nParticleRandomWalk(meanFP: Double, eLoss: Double, eMax: Double, n: Int) -> MultiRandomWalkInfo {
        // do oneParticleRandomWalk(mfp, eLoss, eMax) n times
        var escapedCounter : Int = 0
        var pathList : [CoordTupleList] = []
        
        for _ in 1...n {
            let currentWalk = oneParticleRandomWalk(meanFP: meanFP, eLoss: eLoss, eMax: eMax)
            if(currentWalk.escaped) {
                escapedCounter += 1
            }
            pathList.append(currentWalk.path)
        }
        
        return (paths: pathList, escapedCount: escapedCounter)
    }

    func oneParticleRandomWalk(meanFP: Double, eLoss: Double, eMax: Double) ->
    RandomWalkInfo {
        let LHW = 0.0, RHW = 10.0, UPW = 10.0, BTW = 0.0
        
        var escaped : Bool = false
        var points : CoordTupleList = []
        var energy = eMax - eLoss
        var xCur = 0.1, yCur = 5.0
        
        // Single particle loop
        while (energy > 0.0) {
            let angle = Double.random(in: 0...Double.pi)
            // Move forward a total distance of 1 mfp
            xCur += meanFP * cos(angle)
            yCur += meanFP * sin(angle)
            
            if (xCur < LHW) { // back in reactor, we do not care
                energy = 0
            } else if (xCur > RHW || yCur > UPW || yCur < BTW) {
                energy = 0
                escaped = true
            } else {
                energy -= eLoss
            }
            points.append((x:xCur, y:yCur))
        }
        
        return (path: points, escaped: escaped)
    }

}
