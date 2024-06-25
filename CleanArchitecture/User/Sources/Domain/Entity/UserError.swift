//
//  File.swift
//  
//
//  Created by Tarun Khurana on 4/28/24.
//

import Foundation

// MARK: SOLID - Liskov Substitution priciple.
/*
 NOTES:
 Derived or child classes/ structures must be substitutable for their base or parent class.
 */
public enum UserError: Error {
    case unauthorized
    case requestNotFormed
}
