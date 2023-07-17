//
//  GreenLightAnimate.swift (5.0)
//  TraficLightSwftUI
//  
//  Created by Alexey Zinoviev on 18.07.2023
//

//  Собрал этот код из stackexchange

import SwiftUI

enum ImageEnum: String {
    case img1 = "figure.run"
    case img2 = "figure.walk"

    func next() -> ImageEnum {
        switch self {
        case .img1: return .img2
        case .img2: return .img1
        }
    }
}

struct GreenLightAnimate: View {
    @State private var img = ImageEnum.img1
    @State private var fadeOut = false
   
    let imageSwitchTimer = Timer.publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
    
    var body: some View {
        Image(systemName: img.rawValue)
            .resizable()
            .opacity(fadeOut ? 0 : 1)
            .scaledToFit()
            .frame(width: 60, height: 60)
            .animation(.easeInOut(duration: 0.1), value: fadeOut)
            .onReceive(imageSwitchTimer) { _ in
                self.fadeOut.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation {
                        self.img = self.img.next()
                        self.fadeOut.toggle()
                    }
                }
            }
    }
}

struct GreenLightAnimate_Previews: PreviewProvider {
    static var previews: some View {
        GreenLightAnimate()
    }
}
