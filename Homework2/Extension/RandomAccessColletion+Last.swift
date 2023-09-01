//
//  RandomAccessColletion+Last.swift
//  Lesson 5 PagingExample
//
//  Created by Ravil Gubaidulin on 29.08.2023.
//

import Foundation


extension RandomAccessCollection where Self.Element: Identifiable {
    func isLastItem<Item: Identifiable>(_ item: Item) -> Bool {
        guard isEmpty == false else { return false }
        guard let itemIndex = firstIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) }) else { return false }
        let distance = self.distance(from: itemIndex, to: endIndex)
        
        return distance == 3
    }
}
