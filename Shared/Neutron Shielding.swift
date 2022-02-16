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
    
    //@Published var walks : MultiRandomWalkInfo = (paths: [[(x: 300.0, y:300.0),(x: 150.0,y: 150.0)]], escapedCount: 0)
    @Published var walks : [CoordTupleList] = []
    @Published var escapedCount = 0
    @Published var enableButton = true
    
    func nParticleRandomWalk(meanFP: Double, eLoss: Double, eMax: Double, n: Int) -> MultiRandomWalkInfo {
        // do oneParticleRandomWalk(mfp, eLoss, eMax) n times
        var escapedCounter : Int = 0
        var pathList : [CoordTupleList] = []
        
        for _ in 1...n {
//            let currentWalk = oneParticleRandomWalk(meanFP: meanFP, eLoss: eLoss, eMax: eMax)
            let currentWalk = oneParticleRandomWalkPercent(meanFP: meanFP, eLoss: eLoss, eMax: eMax)
            if(currentWalk.escaped) {
                escapedCounter += 1
            }
            pathList.append(currentWalk.path)
        }
        
        let ret = (paths: pathList, escapedCount: escapedCounter)
        print("Adding in \(pathList.count) things, \(walks.count) total")
        self.walks.append(contentsOf: pathList)
        self.escapedCount = escapedCounter
        return ret
    }
    
    /// oneParticleRandomWalk
    /// Returns a single particle's random walk complete path
    ///  - Parameters:
    ///     - meanFP: The mean free path of the particle
    ///     - eLoss: Energy lost per mean free path, set number, not a percent
    ///     - eMax: Energy of incoming particle, before walk
    ///  - Returns: Coordinate Tuple list and whether or not the particle escaped
    func oneParticleRandomWalk(meanFP: Double, eLoss: Double, eMax: Double) ->
    RandomWalkInfo {
        let LHW = 0.0, RHW = 600.0, UPW = 600.0, BTW = 0.0
        
        var escaped : Bool = false
        var energy = eMax - eLoss
        var xCur = 0.0, yCur = UPW/2.0
        var points : CoordTupleList = [(x:xCur, y:yCur)] // always needs to be at least one point
        
        // Single particle loop
        while (energy > 0.0) {
            let angle = Double.random(in: -0.5*Double.pi...0.5*Double.pi) // always move forward in x and y
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
    
    /// oneParticleRandomWalkPercent
    /// Returns a single particle's random walk complete path, changes meaning of ELoss
    ///  - Parameters:
    ///     - meanFP: The mean free path of the particle
    ///     - eLoss: Energy lost per mean free path, set number, not a percent
    ///     - eMax: Energy of incoming particle, before walk
    ///  - Returns: Coordinate Tuple list and whether or not the particle escaped
    func oneParticleRandomWalkPercent(meanFP: Double, eLoss: Double, eMax: Double) ->
    RandomWalkInfo {
        let LHW = 0.0, RHW = 600.0, UPW = 600.0, BTW = 0.0
        
        var escaped : Bool = false
        var energy = eMax - eLoss
        var xCur = 0.0, yCur = UPW/2.0
        var points : CoordTupleList = [(x:xCur, y:yCur)] // always needs to be at least one point
        
        // Single particle loop
        while (energy > 0.0) {
            let angle = Double.random(in: -0.5*Double.pi...0.5*Double.pi) // always move forward in x and y
            // Move forward a total distance of 1 mfp
            xCur += meanFP * cos(angle)
            yCur += meanFP * sin(angle)
            
            if (xCur < LHW) { // back in reactor, we do not care
                energy = 0
            } else if (xCur > RHW || yCur > UPW || yCur < BTW) {
                energy = 0
                escaped = true
            } else {
                energy -= eLoss * energy
            }
            points.append((x:xCur, y:yCur))
        }
        
        return (path: points, escaped: escaped)
    }
    
    func setButtonEnable(state: Bool) {
        if state {
            Task.init {
                await MainActor.run {
                    self.enableButton = true
                }
            }
        } else {
            Task.init {
                await MainActor.run {
                    self.enableButton = false
                }
            }
        }
    }
    
    func eraseData() {
        walks.removeAll()
    }

}
