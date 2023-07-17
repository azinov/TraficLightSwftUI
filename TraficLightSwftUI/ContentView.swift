//
//  ContentView.swift (5.0)
//  TraficLightSwftUI
//  
//  Created by Alexey Zinoviev on 17.07.2023
//


import SwiftUI

struct ContentView: View {
    @State private var buttonPressCount = 0
    @Environment(\.colorScheme) var colorScheme

    var defaultOpacity = TraficLightSwftUIApp().defaultOpacity
    
    @State var red = LightCircle(circleFill: .red, figure: "")
    @State var yellow = LightCircle(circleFill: .yellow, figure: "")
    @State var green = LightCircle(circleFill: .green, figure: "")
    
    var body: some View {
        VStack {
            VStack {
                red
                yellow
                ZStack {
                    green
                    if buttonPressCount == 3 {
                        GreenLightAnimate()
                    }
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(colorScheme == .light ? .black : .white, lineWidth: 4)
            )
            
            Spacer()
            
            Button(action: nextLight) {
                buttonPressCount == 0 ? Text("START") : Text("NEXT")
            }
            .font(.headline)
            .padding(8)
            .foregroundColor(.white)
            .background(Rectangle()
                .fill(.blue)
                .cornerRadius(8)
                .frame(width: 80))
            .padding()
        }
        .padding(.top)
    }
    
    //MARK: - Private Methods
    
    private func nextLight () {
        buttonPressCount = buttonPressCount < 3 ? buttonPressCount : 0
        switch buttonPressCount {
        case 0:
            resetLights()
            red.circleOpacity = 1.0
            red.figure = Figure().red
        case 1:
            resetLights()
            yellow.circleOpacity = 1.0
            yellow.figure = Figure().yellow
        default:
            resetLights()
            green.circleOpacity = 1.0
            //green.figure = Figure().green
            
        }
        buttonPressCount += 1
    }
    
    private func resetLights() {
        red.circleOpacity = defaultOpacity
        yellow.circleOpacity = defaultOpacity
        green.circleOpacity = defaultOpacity
        
        red.figure = ""
        yellow.figure = ""
        green.figure = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
