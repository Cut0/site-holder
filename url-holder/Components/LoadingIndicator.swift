//
//  LoadingIndicator.swift
//  url-holder
//
//  Created by Rei Kato on 2022/01/30.
//

import SwiftUI

struct LoadingIndicator: View {
    let isLoading: Bool
    @State private var isAnimating = false
    private let animation = Animation.linear(duration: 1).repeatForever(autoreverses: false)
    
    var body: some View {
        if isLoading{
            GeometryReader { geometry in
                ZStack {
                    Color(.black)
                        .opacity(0.01)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .edgesIgnoringSafeArea(.all)
                        .disabled(isLoading)
                    Circle()
                        .trim(from: 0, to: 0.6)
                        .stroke(AngularGradient(gradient: Gradient(colors: [.gray, .white]), center: .center),
                                style: StrokeStyle(
                                    lineWidth: 8,
                                    lineCap: .round,
                                    dash: [0.1, 16],
                                    dashPhase: 8))
                        .frame(width: 48, height: 48)
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                        .onAppear() {
                            withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                                isAnimating = true
                            }
                        }
                        .onDisappear() {
                            isAnimating = false
                        }
                }
            }
        }
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator(isLoading: true)
    }
}
