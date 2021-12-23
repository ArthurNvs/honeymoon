//
//  PlaySound.swift
//  Honeymoon
//
//  Created by Arthur Neves on 23/12/21.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
  if let path = Bundle.main.path(forResource: sound, ofType: type) {
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
      audioPlayer?.play()
    } catch {
      print("Couldn't find and play sound file.")
    }
  }
}
