//
//  LocationDetail.swift
//  Homework2
//
//  Created by Ravil Gubaidulin on 29.08.2023.
//

import SwiftUI
import NavStack

struct LocationDetail: View {
    
    let name: String
    let type: String
    let demnision: String
    
    
    var body: some View {
        VStack {
            BackButton()
            Spacer()
            Text(name)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding()
            VStack {
                Text("The type of the location:")
                Text(type)
                    .font(.title)
            }
            .padding()
            VStack {
                Text("The dimension in which the location is located:")
                Text(demnision)
                    .font(.title)
            }
            Spacer()
        }
    }
}

//struct LocationDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationDetail()
//    }
//}
