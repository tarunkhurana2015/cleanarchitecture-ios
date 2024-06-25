//
//  SwiftUIView.swift
//
//
//  Created by Tarun Khurana on 4/28/24.
//

import SwiftUI

public struct SignUpView: View {
    public var body: some View {
        VStack {
            
        }
    }
}

extension Color {
    fileprivate static var themeTextField: Color {
        return Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.3)
    }
}

#Preview {
    SignUpView()
        .environment(\.locale, .init(identifier: "en-US"))
}
