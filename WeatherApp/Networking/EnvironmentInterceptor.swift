//
//  EnvironmentInterceptor.swift
//  WeatherApp
//
//  Created by Savka Mykhailo on 29.01.2023.
//

import Alamofire

struct EnvironmentInterceptor: RequestInterceptor {

    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        Log.info("🚀 Running request: \(urlRequest.httpMethod ?? "") - \(urlRequest.url?.absoluteString ?? "")")

        let userAgentKey = "User-Agent"

        var urlRequest = urlRequest

        let userAgent = UAString()
        urlRequest.setValue(userAgent, forHTTPHeaderField: userAgentKey)
        return completion(.success(urlRequest))
    }

    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse,
            response.statusCode == 401 else {
                completion(.doNotRetry)
                return
        }
    }
}
