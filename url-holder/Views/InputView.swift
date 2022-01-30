//
//  InputView.swift
//  url-holder
//
//  Created by Rei Kato on 2022/01/30.
//

import SwiftUI
import OpenGraph

protocol InputViewDelegate {
    func addSite(siteData: SiteData)
}

struct InputView: View {
    let delegate: InputViewDelegate
    @Environment(\.presentationMode) var presentation
    @State var siteURL: String
    @State var isLoading: Bool = false
    
    var body: some View {
        ZStack{
            if isLoading {
                ProgressView("loading...")
            }
            VStack(spacing: 16) {
                TextField("Input Site URL", text: $siteURL)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Add") {
                    if isLoading {
                        return
                    }
                    isLoading = true
                    Task {
                        let data = await fetchData(siteUrl: siteURL)
                        if let data = data {
                            delegate.addSite(siteData:data)
                            presentation.wrappedValue.dismiss()
                        }
                        isLoading = false
                    }
                }
            }
            .padding()
        }
    }
    
    private func fetchData(siteUrl:String) async  -> SiteData? {
        do {
            guard let url = URL(string: siteURL) else { return nil}
            let openGraph = try await OpenGraph.fetch(url: url)
            return SiteData(
                title: openGraph[.title] ?? "",
                type: openGraph[.type] ?? "",
                description: openGraph[.description] ?? "",
                imageURL: openGraph[.image] ?? "",
                url: openGraph[.url] ?? "")
        } catch {
            print(error)
        }
        return nil
    }
}
