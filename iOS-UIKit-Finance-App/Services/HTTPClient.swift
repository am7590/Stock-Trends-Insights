//
//  HTTPClient.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/20/22.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> {
        
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            return .failure(.invalidURL)
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
                        
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            print("zz \(response)")
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try?
                        JSONDecoder().decode(responseModel, from: data) else {
                            print("Failed to decode \(T.Type.self)")
                    return .failure(.decode)
                }
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
    
    func sendRequest<T: Decodable>(url: String, responseModel: T.Type) async -> Result<T, RequestError> {
        print(url)
        
        guard let url = URL(string: url) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
                        
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            print("zz \(response)")
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try?
                        JSONDecoder().decode(responseModel, from: data) else {
                            print("Failed to decode \(T.Type.self)")
                    return .failure(.decode)
                }
                print(decodedResponse)
                return .success(decodedResponse)
                
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
