//
//  LightCircle.swift (5.0)
//  TraficLightSwftUI
//  
//  Created by Alexey Zinoviev on 17.07.2023
//

import SwiftUI

struct Figure {
    var red = "figure.stand"
    var yellow = "figure.wave"
    var green = "figure.walk"
}

struct LightCircle: View {
    @Environment(\.colorScheme) var colorScheme
    
    var circleOpacity = TraficLightSwftUIApp().defaultOpacity
    var circleFill: Color
    var figure: String
            
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(colorScheme == .light ? .black : .white, lineWidth: 2)
                .background(
                    Circle()
                        .fill(circleFill)
                        .opacity(circleOpacity)
                        .background(Circle().fill(.black))
                )
                .frame(width: 100, height: 100)
                .padding(8)
            
            Image(systemName: "\(figure)")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60, alignment: .center)
        }
    }
  
    struct LightCircle_Previews: PreviewProvider {
        static var previews: some View {
            LightCircle(circleFill: .red, figure: Figure().red)
        }
    }
}
