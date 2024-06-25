//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/10/24.
//

import Foundation

public protocol MovieImgeURLFactoryProtocol {
    func makeImageURL(imagePath: String) -> URL?
}
