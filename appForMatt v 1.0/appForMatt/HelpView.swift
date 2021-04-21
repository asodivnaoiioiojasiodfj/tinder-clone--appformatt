//
//  HelpView.swift
//  appForMatt
//
//  Created by Steve Schmeltzer on 2/21/21.
//

import SwiftUI

struct HelpView: View {
    @Binding var isHelp: Bool
    
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    Spacer()
                    Button(action: {
                        isHelp.toggle()
                    }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(minWidth: 10, idealWidth: 15, maxWidth: 20, minHeight: 10, idealHeight: 15, maxHeight: 20, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                    })
                        
                }
                Spacer()
                Text("What is this app for?")
                    .font(.title)
                Spacer()
                Text("This app is to help people. This app is to help people. This app is to help people. This app is to help people. This app is to help people. This app is to help people. This app is to help people. This app is to help people. This app is to help people. This app is to help people. This app is to help people. This app is to help people. This app is to help people. This app is to help people. This app is to help people. This app is to help people. This app is to help people. This app is to help people.")
                Spacer()
                Text("examplewebsite.com")
                    .font(.subheadline)
            }
            .padding()
            .foregroundColor(Color("myBlack"))
            .multilineTextAlignment(.center)
        }
    }
}
