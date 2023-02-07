//
//  JSONDataConverterService.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 29.01.2023.
//

import Foundation

typealias ConverterType<T> = (Data) -> T?

final class JSONDataConverterService {
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()

    func getParser<T: Decodable>() -> ConverterType<T> {
        return { data in
            return try? self.decoder.decode(T.self, from: data)
        }
    }
}
