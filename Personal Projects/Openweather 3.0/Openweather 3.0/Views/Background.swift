//
//  Background.swift
//  Openweather 3.0
//
//  Created by Jaylen on 8/8/22.
//

import SwiftUI

struct Background: View {
    var body: some View {
        ZStack {
            Color.white
            LinearGradient(colors: [.blue, Color.white], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack {
                HStack {
                    Text("\(Date.now.formatted(date: .long, time: .omitted))")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                }.padding()
                Spacer()
            }
        }
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
