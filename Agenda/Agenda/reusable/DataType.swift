//
//  DataType.swift
//  MyOrder
//
//  Created by Pawar, Youraj on 10/20/16.
//  Copyright © 2016 Pawar, Youraj (Contractor). All rights reserved.
//

import Foundation


protocol DataType {
    var numberOfItems: Int {get}
    func deleteItemAt(index:Int) -> Self
    func deleteItem(dataObject:Any) -> Self
    func moveItems(fromIndex:Int, toIndex:Int) -> Self
    func addItemAtIndex(index:Int) -> Self
}
