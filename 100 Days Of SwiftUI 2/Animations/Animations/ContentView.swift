//
//  ContentView.swift
//  Animations
//
//  Created by Jaylen on 7/30/22.
//

import SwiftUI

struct CornerRotateModififer: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: self.anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModififer(amount: -90, anchor: .topLeading),
            identity: CornerRotateModififer(amount: 0, anchor: .topLeading
                                           )
        )
    }
}

struct ContentView: View {
    
    
    let letters = Array("Hello, SwiftUI")
    
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        ZStack {
           Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            if enabled {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                enabled.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
