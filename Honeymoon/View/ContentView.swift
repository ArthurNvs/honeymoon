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
  @GestureState private var dragState = DragState.inactive
  
  // MARK: - CARD VIEWS
  var cardViews: [CardView] = {
    var views = [CardView]()
    for index in 0..<2 {
      views.append(CardView(destination: destinationData[index]))
    }
    
    return views
  }()
  
  // MARK: - TOP CARD
  private func isTopCard(cardView: CardView) -> Bool {
    guard let index = cardViews.firstIndex(where: { $0.id == cardView.id }) else {
      return false
    }
    return index == 0
  }
  
  // MARK: - DRAG STATES
  enum DragState {
    case inactive
    case pressing
    case dragging(translation: CGSize)
    
    var translation: CGSize {
      switch self {
      case .inactive, .pressing:
        return .zero
      case .dragging(let translation):
        return translation
      }
    }
    
    var isDragging: Bool {
      switch self {
      case .dragging:
        return true
      case .pressing, .inactive:
        return false
      }
    }
    
    var isPressing: Bool {
      switch self {
      case .pressing, .dragging:
        return true
      case .inactive:
        return false
      }
    }
  }
  
  var body: some View {
    VStack {
      // MARK: - HEADER
      HeaderView(showGuideView: $showGuide, showInfoView: $showInfo)
        .opacity(dragState.isDragging ? 0.0 : 1.0)
        .animation(.default)
      
      Spacer()
      
      // MARK: - CARDS
      ZStack {
        ForEach(cardViews) { cardView in
          cardView
            .zIndex(self.isTopCard(cardView: cardView) ? 1 : 0)
            .gesture(LongPressGesture(minimumDuration: 0.01)
                      .sequenced(before: DragGesture())
                      .updating(self.$dragState, body: { (value, state, transaction) in
              switch value {
              case .first(true):
                state = .pressing
              case .second(true, let drag):
                state = .dragging(translation: drag?.translation ?? .zero)
              default:
                break
              } //: switch
            } //:updating body
          ))
        }
      }
      
      Spacer()
      
      // MARK: - FOOTER
      FooterView(showBookingAlert: $showAlert)
        .opacity(dragState.isDragging ? 0.0 : 1.0)
        .animation(.default)
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
