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
  
  var body: some View {
    VStack {
      HeaderView(showGuideView: $showGuide)
      
      Spacer()
      
      CardView(destination: destinationData[0])
        .padding()
      
      Spacer()
      
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
