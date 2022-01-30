//
//  URLImageView.swift
//  url-holder
//
//  Created by Rei Kato on 2022/01/30.
//

import SwiftUI

class URLImageModel: ObservableObject {
    
    @Published var downloadData: Data? = nil
    
    let url: String
    
    init(url: String, isSync: Bool = false) {
        self.url = url
        if isSync {
            downloadImageSync(url: self.url)
        } else {
            downloadImageAsync(url: self.url)
        }
    }
    
    func downloadImageAsync(url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async {
                self.downloadData = data
            }
        }
    }
    
    func downloadImageSync(url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        let data = try? Data(contentsOf: imageURL)
        self.downloadData = data
    }
}

struct URLImage: View {
    @ObservedObject var viewModel: URLImageModel
    var body: some View {
        if let imageData = self.viewModel.downloadData {
            if let image = UIImage(data: imageData) {
                return Image(uiImage: image).resizable()
            } else {
                return Image(uiImage: UIImage()).resizable()
            }
        } else {
            return Image(uiImage: UIImage()).resizable()
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(viewModel: .init(url: "https://portfolio-ray.web.app/img/profileIcon.2340c5e8.svg")).frame(width: 256, height: 256)
    }
}


