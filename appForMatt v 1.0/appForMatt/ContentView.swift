//
//  ContentView.swift
//  appForMatt
//
//  Created by Steve Schmeltzer on 2/21/21.
//

import SwiftUI

struct ContentView: View {
    @State var cards = Card.data.shuffled()
    @State var topCardIndex: Int = 0
    var visibleCards: [Card] { Array(cards.dropFirst(topCardIndex).prefix(2))}
    
    @State var isHelp = false
    
    var body: some View {
        VStack {
            ZStack {
                AnimatedBackground()
                    .ignoresSafeArea()
                    .blur(radius: 25)
                VStack {
                    //Top Stack
                    Spacer()
                    TopStack()
                    //Card
                    ZStack {
                        ForEach(visibleCards.reversed(), id: \.id) { index in
                            CardView(card: index, topCardIndex: $topCardIndex.animation(.interpolatingSpring(stiffness: 50, damping: 8)))
                                .padding(8)
                        }
                    }
                    //Bottom Stack
                    BottomStack(topCardIndex: $topCardIndex)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

struct CardView: View {
    @State var card: Card
    @Binding var topCardIndex: Int
    
    var body: some View {
        ZStack {
            Color("myBlue")
            Text("\(card.text)")
                .font(.title)
                .padding()
                .foregroundColor(.white)
            
        }
        
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("myWhite"), lineWidth: 2)
        )
        // Step 1 - ZStack follows the coordinate of the card model
        .offset(x: card.x, y: card.y)
        .rotationEffect(.init(degrees: card.degree))
        // Step 2 - Gesture recognizer updaets the coordinate calues of the card model
        .gesture (
            DragGesture()
                .onChanged { value in
                    // user is dragging the view
                    withAnimation(.default) {

                        card.x = value.translation.width
                        card.y = value.translation.height
                        card.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                    }
                }
            
                .onEnded { value in 
                    // do something when the user stops dragging
                    withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 8, initialVelocity: 0)) {
                        switch value.translation.width {
                        case 0...100:
                            card.x = 0; card.degree = 0; card.y = 0
                        case let x where x > 100:
                            card.x = 500; card.degree = 12;
                            topCardIndex += 1
                        case (-100)...(-1):
                            card.x = 0; card.degree = 0; card.y = 0;
                        case let x where x < -100:
                            card.x = -500; card.degree = -12;
                            topCardIndex += 1
                        default: card.x = 0; card.y = 0
                        }
                    }
                }
            
        )
    }
}

struct TopStack: View {
    @State var isHelp: Bool = false
    
    var body: some View {
        HStack {
            Spacer()
            Spacer()
            Spacer()
            Button(action: {
                isHelp.toggle()
            }, label: {
                Image(systemName: "questionmark.circle.fill")
                    .resizable()
                    .foregroundColor(Color("myBlack"))
                    .frame(minWidth: 10, idealWidth: 20, maxWidth: 40, minHeight: 10, idealHeight: 20, maxHeight: 40, alignment: .center)
                    .aspectRatio(contentMode: .fit)
            })
            .sheet(isPresented: $isHelp, content: {
                HelpView(isHelp: $isHelp)
            })
        }
        .padding()
    }
}

struct BottomStack: View {
    @Binding var topCardIndex: Int
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                if topCardIndex > 0 {
                topCardIndex -= 1
                } else {
                    topCardIndex += 0
                }
            }, label: {
                Image(systemName: "arrowshape.turn.up.left.circle.fill")
                    .resizable()
                    .foregroundColor(Color("myBlack"))
                    .frame(minWidth: 10, idealWidth: 30, maxWidth: 50, minHeight: 10, idealHeight: 30, maxHeight: 50, alignment: .center)
                    .aspectRatio(contentMode: .fit)
            })
            Spacer()
            Image(systemName: "sleep")
                .resizable()
                .frame(minWidth: 10, idealWidth: 30, maxWidth: 50, minHeight: 10, idealHeight: 30, maxHeight: 50, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .shadow(radius: 10)
            Spacer()
            Button(action: {
                topCardIndex += 1
            }, label: {
                Image(systemName: "arrowshape.turn.up.right.circle.fill")
                    .resizable()
                    .foregroundColor(Color("myBlack"))
                    .frame(minWidth: 10, idealWidth: 30, maxWidth: 50, minHeight: 10, idealHeight: 30, maxHeight: 50, alignment: .center)
                    .aspectRatio(contentMode: .fit)
            })
            Spacer()
        }
        .padding()
    }
}

struct AnimatedBackground: View {
    @State var start = UnitPoint(x: 0, y: -2)
    @State var end = UnitPoint(x: 4, y: 0)
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    let colors = [Color("myGray"), Color(.white)]
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
            .animation(Animation.easeInOut(duration: 10)
                        .repeatForever()
            ).onReceive(timer, perform: { _ in
                self.start = UnitPoint(x: 4, y: 0)
                self.end = UnitPoint(x: 0, y: 2)
                self.start = UnitPoint(x: -4, y: 20)
                self.start = UnitPoint(x: 4, y: 0)
            })
    }
}
