//
//  
//  ProfileDetailView.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/10/24.
//
//

import SwiftUI
import ComposableArchitecture

public struct ProfileDetailView: View {
    
    let entity: ProfileEntity
    public init(entity: ProfileEntity) {
        self.entity = entity
    }
    
    public var body: some View {
        VStack {
                Text("\(entity)")
        }
    }
}

#Preview {
ProfileDetailView(entity: ProfileEntity())
}
