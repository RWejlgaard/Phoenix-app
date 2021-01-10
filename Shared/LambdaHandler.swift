//
//  LambdaHandler.swift
//  Phoenix
//
//  Created by Pez on 09/01/2021.
//

import Foundation
import SwiftUI
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

func executeLambda(method: String, url: String, data: String) -> String {
    var semaphore = DispatchSemaphore (value: 0)
    var ret = ""
    let parameters = data
    let postData = parameters.data(using: .utf8)

    var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    request.httpMethod = method
    request.httpBody = postData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
        }
        print(String(data: data, encoding: .utf8)!)
        
        ret = String(data: data, encoding: .utf8)!
        
        semaphore.signal()
    }

    task.resume()
    semaphore.wait()
    return ret
}
