//
//  SiteItem.swift
//  url-holder
//
//  Created by Rei Kato on 2022/01/30.
//

import SwiftUI

struct SiteItem: View {
    let site: SiteData
    
    var body: some View {
        VStack{
            HStack{
                URLImage(viewModel: .init(url: site.imageURL)).scaledToFit()
                    .frame(width: 64, height: 64)
                Text(site.title.isEmpty ? "無名のサイト" : site.title).font(.headline)
            }.padding(.bottom, 8.0)
            if !site.description.isEmpty {
                Text(site.description).font(.footnote).foregroundColor(Color.secondary)
            }
            HStack{
                Spacer()
                Text(site.url).font(.footnote).foregroundColor(Color.blue).multilineTextAlignment(.trailing).padding(.vertical, 4.0).lineLimit(1)
            }
        }
    }
}

struct SiteItem_Previews: PreviewProvider {
    static var previews: some View {
        SiteItem(site: .mock1)
    }
}
