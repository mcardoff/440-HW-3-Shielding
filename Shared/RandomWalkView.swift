//
//  RandomWalkView.swift
//  440-HW-3-Shielding
//
//  Created by Michael Cardiff on 2/14/22.
//

import Foundation
import SwiftUI

struct RandomWalkView: View {
    
    @Binding var walkPts : [CoordTupleList]

    var body: some View {
        
        //Create the displayed View
        DrawRandomWalk(walks: walkPts)
            .stroke(Color.red, lineWidth: 3)
            .frame(width: 600, height: 600)
            .background(Color.white)
        
    }
    
    
    
    /// CesaroFractalShape
    ///
    /// calculates the Shape displayed in the Cesaro Fractal View
    ///
    /// - Parameters:
    ///   - points: array of tuples containing the points of the walk to draw at
    ///
    struct DrawRandomWalk: Shape {
        
        var walks: [CoordTupleList] = []  ///Array of tuples
        
        /// path
        ///
        /// - Parameter rect: rect in which to draw the path
        /// - Returns: path for the Shape
        ///
        func path(in rect: CGRect) -> Path {
            // Create the Path for the Cesaro Fractal
            
            var path = Path()
            
            if walks.isEmpty {
                print("Walks is empty! \(Date())")
                return path // ensures that something is shown on screen
            }
            
            let scale = 1.0
            
            for walk in walks {
                // move to the initial position
                path.move(to: CGPoint(x: scale * walk[0].x, y: scale * walk[0].y))
                
                // loop over all our points to draw create the paths
                for item in 1..<(walk.endIndex) {
//                    path.addLine(to: CGPoint(x: scale * walk[item].x, y: scale * walk[item].y))
                    path.addLine(to: CGPoint(x: 100+item, y: 200+item))
                }
            }
            return (path)
        }
    }
}
