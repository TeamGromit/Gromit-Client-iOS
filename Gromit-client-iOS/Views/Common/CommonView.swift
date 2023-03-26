//
//  CommonView.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/03/26.
//
import Foundation
import SwiftUI


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

// Clear Button...
struct UserNameFieldClearButton: ViewModifier {
    @Binding var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            if !text.isEmpty {
                Button(
                    action: {
                        self.text = ""
                    })
                {
                    Image(systemName: "delete_ui")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                }
                .padding(.trailing, 8)
            }
        }
        .navigationBarHidden(true)
    }
}

struct InputButtonStyle: ButtonStyle {

    var backgroundColor = Color(red: 255 / 255, green: 247 / 255, blue: 178 / 255)
    var cornerRadius: CGFloat = 10
    var width: CGFloat
    var height: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.black)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            .background(RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
                .frame(width: width, height: height)
            )
            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .shadow(radius: 2.5)
            .fontWeight(.bold)
    }
}

struct ProgressBar: View {
    @State private var containerWidth: CGFloat = 0
    @State private var step = 8
    private let goal = 10
    
    var maxWidth: Double {
        return min((containerWidth / CGFloat(goal) * CGFloat(step)), containerWidth)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.clear)
                    .onAppear {
                        containerWidth = geo.size.width
                    }
            }
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.white))
                
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("green500"))
                .frame(width: maxWidth, height: 29)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}
