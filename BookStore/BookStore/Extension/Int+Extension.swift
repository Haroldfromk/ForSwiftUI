//
//  Int+Extension.swift
//  BookStore
//
//  Created by Dongik Song on 11/25/24.
//
import Foundation

extension Int {
    func toString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self as NSNumber) ?? String(describing: self)
    }
}
