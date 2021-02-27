//
//  DynamicMember.swift
//  HashimGit
//
//  Created by Hashim M H on 27/02/21.
//

import Foundation

class AClass{
    var aProperty:String?
    let aFu = aFun
    func aFun(){

    }
}

@dynamicMemberLookup
class WrapperAClass {
    let wrapOf = AClass()
    subscript<T>(dynamicMember keyPath: KeyPath<AClass, T>) -> T {
        return wrapOf[keyPath: keyPath]
    }
}
