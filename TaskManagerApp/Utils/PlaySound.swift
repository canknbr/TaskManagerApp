//
//  PlaySound.swift
//  TaskManagerApp
//
//  Created by Can Kanbur on 1.06.2023.
//

import AVFoundation
import Foundation
var audioPlayer: AVAudioPlayer?

func playSound(soundName: String, soundType: String) {
    if let path = Bundle.main.path(forResource: soundName, ofType: soundType) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            audioPlayer?.play()
        } catch {
            print("error")
        }
    }
}
