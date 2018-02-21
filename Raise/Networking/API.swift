//
//  API.swift
//  Raise
//
//  Created by Stephen Hayes on 2/20/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import Foundation

class API {

    private static let host: URL = {
        guard let url = URL(string: "https://raise.cameronvwilliams.com/api") else {
            fatalError("Host must be a valid url")
        }
        return url
    }()
    

    static func createGame(_ request: CreateRequest, completion: @escaping (CreateResponse?) -> Void) {
        var urlRequest = URLRequest(url: host.appendingPathComponent("poker-game"))
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(request)

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    completion(nil)
                    return
                }

                do {
                    let createResponse = try JSONDecoder().decode(CreateResponse.self, from: data)
                    completion(createResponse)
                } catch {
                    assertionFailure(error.localizedDescription)
                    completion(nil)
                }
            }
        }.resume()
    }
}
