//
//  ContentView.swift
//  maimaidx_prober
//
//  Created by 枫羽云玲 on 2025/6/2.
//


import SwiftUI
import SwiftData

//UI主要控件
struct ContentView: View {
    var body: some View {
        TabView{
            //概况
            HomeView()
                .tabItem{
                    Image(systemName: "house.fill")
                    Text("首页")
                }
            //分数
            ScoreView()
                .tabItem{
                    Image(systemName: "list.number")
                    Text("分数")
                }
            //二维码
            CodeView()
                .tabItem{
                    Image(systemName: "qrcode")
                    Text("二维码")
                }
            //歌曲
            MusicView()
                .tabItem{
                    Image(systemName: "music.note.list")
                    Text("歌曲")
                }
            //选项
            OptView()
                .tabItem{
                    Image(systemName: "wrench.and.screwdriver")
                    Text("设置")
                }
            
        }
    }
}
#Preview{
        ContentView()
    }

// 概况界面
struct HomeView:View{
    @State private var showAccountMenu:Bool = false
    //账户选项
    var body:some View{
        NavigationStack{
            Text("")
                .navigationTitle("概况")
            // 传分
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing){
                        Button(
                            action: {
                                print("")
                            }
                        ){
                            Image(systemName: "icloud.and.arrow.up")
                        }
                    }
                }
            // 重新获取信息
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing){
                        Button(
                            action: {
                                print("")
                            }
                        ){
                            Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.icloud")
                        }
                    }
                }
            
        }
        .popover(isPresented: $showAccountMenu){
            VStack{
                Button("1"){}
                Button("关闭"){showAccountMenu = false}
            }
            .padding()
        }
    }
}
// 分数界面
struct ScoreView:View{
    var body:some View{
        NavigationStack{
            Text("")
                .navigationTitle("详细分数")
        }
    }
}
// 二维码界面
struct CodeView:View{
    var body:some View{
        NavigationStack{
            Text("")
                .navigationTitle("登入二维码")
        }
    }
}

// 歌曲界面
struct MusicView:View{
    var body:some View{
        NavigationStack{
            Text("")
                .navigationTitle("歌曲查询")
        }
    }
}
// 选项界面
struct OptView:View{
    @State private var showAddUser = false
    @State private var inputUsername = ""
    @State private var inputToken = ""
    @State private var inputQQ = ""
    var body:some View{
        NavigationStack{
            Text("")
            Button("添加用户"){
                showAddUser = true
            }
            .sheet(isPresented: $showAddUser){
                AddUserPop(inputUsername: $inputUsername, inputToken: $inputToken,inputQQ: $inputQQ,isPresented: $showAddUser)
            }
                .navigationTitle("设置")
            
        }
    }
}

//添加用户界面

struct AddUserPop: View {
    @Environment(\.modelContext) private var modelContext
    @State private var username = ""
    var accountManager: UserAccountManager {
            UserAccountManager(context: modelContext)
        }
    // 原有的用户名绑定变量
    @Binding var inputUsername: String
    
    // 新增加的绑定变量
    @Binding var inputToken: String      // token（密码样式）
    @Binding var inputQQ: String         // QQ号
    
    @Binding var isPresented: Bool
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack {
            Form {  // 使用Form以获得更好的分组样式
                // 用户名
                Section(header: Text("用户信息")) {
                    TextField("用户名", text: $inputUsername)
                    
                    // Token（密码样式）
                    SecureField("Token", text: $inputToken)
                    
                    // QQ号（带数字键盘）
                    TextField("QQ号", text: $inputQQ)
                        .keyboardType(.numberPad)
                }
                
                // 备注（多行文本）
            }
            .navigationTitle("添加新用户")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // 左上角取消按钮
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        isPresented = false
                    }
                }
                
                // 右上角确定按钮
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("确定") {
                        // 在这里处理确定逻辑
                        print("用户: \(inputUsername)")
                        print("Token: \(inputToken)")
                        print("QQ号: \(inputQQ)")
                        do {
                            try accountManager.addUser(
                                username: inputUsername,
                                rating: 88888,
                                grade: "初心者",
                                token: inputToken
                            )
                        } catch {
                            print("添加失败: \(error)")
                        }
                        isPresented = false
                    }
                    .disabled(inputUsername.isEmpty)  // 用户名不能为空
                }
            }
        }
    }
}
