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
            ToolsView()
                .tabItem{
                    Image(systemName: "wrench.and.screwdriver")
                    Text("工具")
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
                .toolbar {
                    // 账户
                    ToolbarItem(placement: .topBarTrailing){
                        Button(
                            action: {
                                showAccountMenu = true
                            }
                        ){
                            Image(systemName: "person.crop.circle")
                        }
                    }
                }
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
struct ToolsView:View{
    var body:some View{
        NavigationStack{
            Text("")
                .navigationTitle("实用工具")
        }
    }
}
