//
//  File.swift
//  
//
//  Created by Tarun Khurana on 6/11/24.
//

import Foundation

protocol VideoUrlFactoryProtocol {
    func makeVideoUrl() -> URL?
    func makeImageUrl(_ imagePath: String) -> URL?
}
