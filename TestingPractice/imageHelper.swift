//
//  imageHelper.swift
//  TestingPractice
//
//  Created by C4Q on 4/25/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//
import UIKit

class ImageHelper {
    private init() {}
    static let manager = ImageHelper()
    func loadImage(urlString: String, completionHandler: @escaping (Error?, UIImage?) -> Void) {
        if let image = ImageCaching.manager.retrieveImage(url: urlString) {
             completionHandler(nil, image)
             return
        }
        guard let url = URL(string: urlString) else {
            completionHandler(AppError.badURL(url: urlString), nil)
            return
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: { (data) in
            guard let image = UIImage(data: data) else {
                completionHandler(AppError.badData, nil)
                return
            }
            ImageCaching.manager.cacheImage(url: urlString, image: image)
            completionHandler(nil, image)
        }) { (error) in
            completionHandler(AppError.other(rawError: error), nil)
        }
    }
}
