//
//  ImageDownloader.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/13/23.
//

import Foundation

protocol ImageDownloaderProtocol {
    static var shared: ImageDownloader { get }
    func download(url: URL, completion: @escaping (Data?, Error?) -> Void)
}

final class ImageDownloader: ImageDownloaderProtocol {
    
    static let shared = ImageDownloader()
    
    init() {}
    
    func download(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, error)
        }
        task.resume()
    }
    
}
