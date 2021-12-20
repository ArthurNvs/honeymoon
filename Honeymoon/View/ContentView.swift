//
//  ContentView.swift
//  Honeymoon
//
//  Created by Arthur Neves on 16/12/21.
//

import SwiftUI

struct ContentView: View {
  @State var showAlert = false
  @State var showGuide = false
  @State var showInfo = false
  
  var cardViews: [CardView] = {
    var views = [CardView]()
    for destination in destinationData {
      views.append(CardView(destination: destination))
    }
    
    return views
  }()
  
  private func isTopCard(cardView: CardView) -> Bool {
    guard let index = cardViews.firstIndex(where: { $0.id == cardView.id }) else {
      return false
    }
    return index == 0
  }
  
  var body: some View {
    VStack {
      // MARK: - HEADER
      HeaderView(showGuideView: $showGuide, showInfoVew: $showInfo)
      
      Spacer()
      
      // MARK: - CARDS
      ZStack {
        ForEach(cardViews) { cardView in
          cardView
            .zIndex(self.isTopCard(cardView: cardView) ? 1 : 0)
        }
      }
      
      Spacer()
      
      // MARK: - FOOTER
      FooterView(showBookingAlert: $showAlert)
    } //: VStack
    .alert(isPresented: $showAlert) {
      Alert(
        title: Text("We booked for you!"),
        message: Text("Wishing a lovely and most precious of the times together for the amazing couple."),
        dismissButton: .default(Text("Happy Honeymoon!")))
    } //: alert
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
