//
//  AsyncImageView.swift
//  Pokedex_MVVM
//
//  Created by Arian Mohajer on 2/16/22.
//

import UIKit

class AsyncImageView: UIImageView, APIDataProvidable {

    func setImage(using urlRequest: URLRequest) {
        perform(urlRequest) { [weak self] result in
            DispatchQueue.main.async {
                guard let imageData = try? result.get() else { return }
                self?.image = UIImage(data: imageData)
            }
        }
    }
}
