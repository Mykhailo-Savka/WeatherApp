//
//  Log.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 31.01.2023.
//

import Foundation

public final class Log {

    /// Not so important đ
    static func verbose(_ message: Any) {
        let appendix = "đ VERBOSE -"
        print(appendix, message)
    }

    /// Something to debug đ
    static func debug(_ message: Any) {
        let appendix = "đ DEBUG -"
        print(appendix, message)
    }

    /// Good to know âšī¸
    static func info(_ message: Any) {
        let appendix = "âšī¸ INFO -"
        print(appendix, message)
    }

    /// Something bad happened â ī¸
    static func warning(_ message: Any) {
        let appendix = "â ī¸ WARNING -"
        NSLog("\(appendix) \(message)")
        print(appendix, message)
    }

    /// ERROR!!!!11 âī¸
    static func error(_ message: Any) {
        let appendix = "âī¸ ERROR -"
        NSLog("\(appendix) \(message)")
        print(appendix, message)
    }
}
