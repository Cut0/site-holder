//
//  ContentView.swift
//  url-holder
//
//  Created by Rei Kato on 2022/01/30.
//

import SwiftUI
import OpenGraph

struct URLListView: View{
    let key: String
    let groupName: String
    @State private var isLoading = false
    @State private var hasError = false
    @State private var inputSiteURL: String = ""
    @State private var siteList: [SiteData] = []
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List {
                ForEach(siteList) { site in
                    SiteItem(site: site)
                        .onTapGesture {
                            if let url = URL(string: site.url) {
                                UIApplication.shared.open(url)
                            }
                        }.onLongPressGesture{
                            sharePost(url: site.url)
                        }
                }
                .onMove(perform: rowReplace)
                .onDelete(perform: delete)
                
            }.padding(.bottom, 60.0)
            
            HStack{
                TextField("サイトのURLを入力してください。", text: $inputSiteURL)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.vertical)
                
                Button(action: {
                    addSite()
                }) {
                    Text("追加")
                        .fontWeight(.semibold)
                        .frame(width: 72, height: 32)
                        .foregroundColor(Color(.white))
                        .background(Color(.blue))
                        .cornerRadius(24)
                }.alert(isPresented: $hasError) {
                    Alert(
                        title: Text("エラー"),
                        message: Text("サイト情報を取得できませんでした。再度お試しください。")
                    )
                }
            }.padding(.vertical, 4.0).padding(.horizontal, 16.0).background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
            
            LoadingIndicator(isLoading: isLoading)
        }
        .onAppear {
            if let data = UserDefaults.standard.value(forKey: key) as? Data {
                siteList = try! PropertyListDecoder().decode(Array<SiteData>.self, from: data)
            }else{
                siteList = []
            }
        }
        .navigationTitle(groupName)
        .navigationBarItems(trailing: EditButton())
        
        
    }
    private func rowReplace(_ from: IndexSet, _ to: Int) {
        siteList.move(fromOffsets: from, toOffset: to)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(siteList), forKey: key)
    }
    
    private func delete(at offsets: IndexSet) {
        siteList.remove(atOffsets: offsets)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(siteList), forKey: key)
    }
    
    private func addSite() {
        if isLoading {
            return
        }
        isLoading = true
        Task {
            let data = await fetchData(siteUrl: inputSiteURL)
            if let data = data {
                siteList.append(data)
                UserDefaults.standard.set(try? PropertyListEncoder().encode(siteList), forKey: key)
            }else{
                hasError = true
            }
            isLoading = false
            inputSiteURL = ""
        }
    }
    
    private func fetchData(siteUrl:String) async  -> SiteData? {
        do {
            guard let url = URL(string: siteUrl) else { return nil }
            let openGraph = try await OpenGraph.fetch(url: url)
            return SiteData(
                title: openGraph[.title] ?? "",
                type: openGraph[.type] ?? "",
                description: openGraph[.description] ?? "",
                imageURL: openGraph[.image] ?? "",
                url: siteUrl)
        } catch {
            print(error)
        }
        return nil
    }
    
    private func sharePost(url: String){
        guard let urlShare = URL(string: url) else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        URLListView(key:"TEST",groupName:"テスト")
    }
}
