//
//  GroupListView.swift
//  url-holder
//
//  Created by Rei Kato on 2022/01/30.
//

import SwiftUI

struct GroupListView: View {
    @State var groupNames: [String] = []
    @State private var inputGroupName: String = ""
    @State private var hasError: Bool = false
    @State private var complete: Bool = false
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                List {
                    ForEach(groupNames, id: \.self) { name in
                        NavigationLink(destination: URLListView(key:"GRUPKEY_"+name,groupName:name)) {
                            Text(name)
                                .font(Font.system(size: 20))
                        }
                    }
                    .onMove(perform: rowReplace)
                    .onDelete(perform: delete)
                }
                
                HStack{
                    TextField("グループ名を入力してください。", text: $inputGroupName)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.vertical)
                    
                    Button(action: {
                        addGroup(name: inputGroupName)
                    }) {
                        Text("作成")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 32)
                            .background(.orange)
                            .cornerRadius(24)
                    }.alert(isPresented: $complete) {
                        Alert(
                            title: Text("作成完了"),
                            message: Text("グループを作成しました。")
                        )
                    }.alert(isPresented: $hasError) {
                        Alert(
                            title: Text("エラー"),
                            message: Text("重複しない名前を登録してください。")
                        )
                    }
                }.padding(.vertical, 4.0).padding(.horizontal, 16.0).background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                
                
            }
            .onAppear {
                if let groupNames = UserDefaults.standard.array(forKey: "GROUPKEYS") as? [String] {
                    self.groupNames = groupNames
                }
            }
            .navigationTitle("グループ一覧")
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    private func rowReplace(_ from: IndexSet, _ to: Int) {
        groupNames.move(fromOffsets: from, toOffset: to)
        UserDefaults.standard.setValue(groupNames, forKey: "GROUPKEYS")
    }
    
    private func delete(at offsets: IndexSet) {
        for i in offsets.makeIterator() {
            UserDefaults.standard.removeObject(forKey: "GRUPKEY_"+groupNames[i])
        }
        groupNames.remove(atOffsets: offsets)
        UserDefaults.standard.setValue(groupNames, forKey: "GROUPKEYS")
    }
    
    private func addGroup(name: String) {
        if name.isEmpty{
            return
        }
        inputGroupName = ""
        if groupNames.contains(name){
            hasError = true
            return
        }
        groupNames.append(name)
        UserDefaults.standard.setValue(groupNames, forKey: "GROUPKEYS")
        complete = true
    }
}

struct GroupListView_Previews: PreviewProvider {
    static var previews: some View {
        GroupListView()
    }
}
