//
//  NSObject+name.swift
//  RaseApp
//
//  Created by Evgeny Trifonov on 25.03.2022.
//

import Foundation

extension NSObject {
    static var className: String {
            return String(describing: self)
        }

        var className: String {
            return type(of: self).className
        }
}


