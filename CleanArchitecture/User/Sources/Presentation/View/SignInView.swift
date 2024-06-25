//
//  SwiftUIView.swift
//  
//
//  Created by Tarun Khurana on 4/28/24.
//

import SwiftUI
import ComposableArchitecture

public struct SignInView: View {
    
    let store: StoreOf<SignInViewReducer>
    
    @State private var email = ""
    @State private var password = ""
    
    public init(store: StoreOf<SignInViewReducer>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            Spacer()
                
            Text("welcome_message")
                .font(.largeTitle).bold()
                .foregroundColor(.white)
                .padding([.top, .bottom], 40)
                .shadow(radius: 10.0, x:20, y:20)
            
            VStack(alignment: .leading, spacing: 15) {
                
                TextField("login_email", text: $email)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x:20, y:20)
                    .foregroundColor(.white)
                    .bold()
                SecureField("login_password", text: $password)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x:20, y:20)
                
            }.padding([.leading, .trailing], 27.5)
            Button(action:{
                store.send(.signInButtonTapped($email.wrappedValue, password: $password.wrappedValue))
            }) {
                ZStack{
                    HStack {
                        Text("user_signin")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .bold()
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x:20, y:20)
                    }
                    
                    
                    if store.loading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .foregroundColor(.white)
                            .controlSize(.mini)
                    }
                }
            }
            .background(.red)
            .cornerRadius(15.0)
            .padding(.top, 50)
            .disabled(store.loading)
            
            Spacer()
            VStack {
                if case let .error(message) = store.loginState {
                    Text(message)
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                } else if case let .signedIn(userId, username) = store.loginState {
                    Text("Successfully logged in \(username) - \(userId)")
                        .font(.title2)
                        .foregroundColor(.black)
                        .bold()
                } else {
                    Text("Enter Credentials to login")
                }
            }.animation(.linear(duration: 1), value: 1.0)
            
            Spacer()
            
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.red, .black]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
        )
    }
}

extension Color {
    fileprivate static var themeTextField: Color {
        return Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.3)
    }
}

#Preview {
    SignInView(
        store: Store(initialState: SignInViewReducer.State()) {
            SignInViewReducer()
        }
    )        .environment(\.locale, .init(identifier: "en-US"))
}
