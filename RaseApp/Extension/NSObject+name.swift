//
//  NSObject+name.swift
//  RaseApp
//
//  Created by Evgeny Trifonov on 25.03.2022.
//

import Foundation

extension NSObject {
    var className: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last ?? ""
    }
    
    @nonobjc class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
}
