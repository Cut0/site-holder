//
//  ShareSheet.swift
//  url-holder
//
//  Created by Rei Kato on 2022/01/30.
//

import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    var url: String
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityItems: [String] = [url]
        
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil)
        
        return controller
    }
    
    func updateUIViewController(_ vc: UIActivityViewController, context: Context) {
    }
}

struct ShareSheet_Previews: PreviewProvider {
    static var previews: some View {
        ShareSheet(url: "")
    }
}
