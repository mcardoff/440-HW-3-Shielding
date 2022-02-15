//
//  RandomWalkView.swift
//  440-HW-3-Shielding
//
//  Created by Michael Cardiff on 2/14/22.
//

import Foundation
import SwiftUI

struct RandomWalkView: View {
    
    @Binding var walkPts : CoordTupleList
    
    var body: some View {
        
        //Create the displayed View
        DrawRandomWalk(points: walkPts)
            .stroke(Color.red, lineWidth: 1)
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
        
        var points: CoordTupleList = []  ///Array of tuples
        
        /// path
        ///
        /// - Parameter rect: rect in which to draw the path
        /// - Returns: path for the Shape
        ///
        func path(in rect: CGRect) -> Path {
            // Create the Path for the Cesaro Fractal
            
            var path = Path()
            
            if points.isEmpty {
                return path
            }
            
            // move to the initial position
            path.move(to: CGPoint(x: points[0].x, y: points[0].y))
            
            // loop over all our points to draw create the paths
            for item in 1..<(points.endIndex) {
                path.addLine(to: CGPoint(x: points[item].x, y: points[item].y))
            }
            
            return (path)
        }
    }
}
