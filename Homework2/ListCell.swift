//
//  ListCell.swift
//  Homework2
//
//  Created by Ravil Gubaidulin on 04.09.2023.
//

import SwiftUI

public struct ListCell: View {
    
    @Environment(\.colorScheme) var colorScheme
    let darkBackgroundColor: Color = Color(hue: 0.67, saturation: 0.05, brightness: 0.38)
    let lightBackgruondColor: Color = Color(hue: 0.67, saturation: 0, brightness: 0.94)
    
    let title: String
    
    public var body: some View {
        
//                Button {
//                    withAnimation(.easeOut(duration: 1)) {
//                        isTap = true
//                    }
//                } label: {
//                    Text(title)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding([.leading,.trailing], 20)
//                        .padding([.bottom, .top], 7)
//
//                }
//                .background(colorScheme == .light ? lightBackgruondColor : darkBackgroundColor)
//                .cornerRadius(10)
//                .offset(y: isTap ? yPosition2 : yPosition)
//            }
//
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(colorScheme == .light ? lightBackgruondColor : darkBackgroundColor)
            VStack {
                Text(title)
                    .padding([.leading,.trailing], 20)
                    .padding([.top,.bottom], 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
}
