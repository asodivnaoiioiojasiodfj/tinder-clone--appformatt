//
//  card.swift
//  appForMatt
//
//  Created by Steve Schmeltzer on 2/21/21.
//

import Foundation
import UIKit

struct Card: Identifiable {
    let id = UUID()
    let text: String
    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
    var degree: Double = 0.0
    
    static var data: [Card] {
        [
            Card(text:"aaa This is a sample text quote. This is a sample text quote."),
            Card(text:"bbb This is a sample text quote. This is a sample text quote."),
            Card(text:"ccc This is a sample text quote. This is a sample text quote."),
            Card(text:"ddd This is a sample text quote. This is a sample text quote."),
            Card(text:"eee This is a sample text quote. This is a sample text quote."),
            Card(text:"fff This is a sample text quote. This is a sample text quote."),
            Card(text:"ggg This is a sample text quote. This is a sample text quote."),
            Card(text:"hhh This is a sample text quote. This is a sample text quote.")
        ]
    }
}

struct myArrayStruct {
    static var myArray = ["aaa This is a sample text quote. This is a sample text quote.", "bbb This is a sample text quote. This is a sample text quote.", "ccc This is a sample text quote. This is a sample text quote."]
}
