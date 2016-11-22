//
//  ArrayExtension.swift
//  MyOrder
//
//  Created by Pawar, Youraj on 10/20/16.
//  Copyright © 2016 Pawar, Youraj (Contractor). All rights reserved.
//

import Foundation

extension Array where Element : Equatable {
    
    mutating func removeObject(object: Element){
        
        if let index  = index(of: object){
            
            remove(at: index)
        }
    }
}
