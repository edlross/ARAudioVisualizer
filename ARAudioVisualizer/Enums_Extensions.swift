//
//  Enums_Extensions.swift
//  ARAudioVisualizer
//
//

import SwiftUI


enum PlaybackState { case playing, paused, stopped }


extension Double {
    var second: Int { Int(truncatingRemainder (dividingBy: 60)) }
    var minute: Int{ Int((self/60).truncatingRemainder (dividingBy: 60)) }
    
    var minuteSecond: String {
        String(format: "%d:%02d", minute, second)
    }
}
