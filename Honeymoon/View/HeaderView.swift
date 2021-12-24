//
//  HeaderView.swift
//  Honeymoon
//
//  Created by Arthur Neves on 16/12/21.
//

import SwiftUI

struct HeaderView: View {
  @Binding var showGuideView: Bool
  @Binding var showInfoView: Bool
  let haptics = UINotificationFeedbackGenerator()
  
  var body: some View {
    HStack {
      Button {
        playSound(sound: "sound-click", type: "mp3")
        self.haptics.notificationOccurred(.success)
        self.showInfoView.toggle()
      } label: {
        Image(systemName: "info.circle")
          .font(.system(size: 24, weight: .regular))
      } //: Button
      .accentColor(.primary)
      .sheet(isPresented: $showInfoView) {
        InfoView()
      }
      
      Spacer()
      
      Image("logo-honeymoon-pink")
        .resizable()
        .scaledToFit()
        .frame(height: 28)
      
      Spacer()
      
      Button {
        playSound(sound: "sound-click", type: "mp3")
        self.haptics.notificationOccurred(.success)
        self.showGuideView.toggle()
      } label: {
        Image(systemName: "questionmark.circle")
          .font(.system(size: 24, weight: .regular))
      } //: Button
      .accentColor(.primary)
      .sheet(isPresented: $showGuideView) {
        GuideView()
      }
    } //: HStack
    .padding()
  }
}

struct HeaderView_Previews: PreviewProvider {
  @State static var showGuide = false
  @State static var showInfo = false
  
  static var previews: some View {
    HeaderView(showGuideView: $showGuide, showInfoView: $showInfo)
      .previewLayout(.fixed(width: 375, height: 80))
  }
}
