//
//  BackButton.swift
//  
//
//  Created by Ravil Gubaidulin on 03.09.2023.
//

import SwiftUI

public struct BackButton: View {
    public var body: some View {
        HStack{
            PopNavStack {
                Text("\(Image(systemName: "chevron.backward")) Back")
                    .foregroundColor(.blue)
            }
            .padding(.leading, 10)
            Spacer()
        }
    }
    public init() {}
}

