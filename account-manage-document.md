# 账户管理使用实例
总览：本项目账户管理为，token使用Keychain管理，其他明文存储。
账户处理函数写在UserAccountManager.swift内，在contentView中使用时，需在函数头部添加下列内容
```swift
    @Environment(\.modelContext) private var modelContext
    @State private var username = ""
    var accountManager: UserAccountManager {
            UserAccountManager(context: modelContext)
        }
```

## 下面是使用方法

 ### 添加用户
 ```swift
 do {
     try accountManager.addUser(
         username: "田所浩二",
         rating: 88888,
         grade: "初心者",
         token: "HOMO1145141919810"
     )
     print("用户添加成功")
 } catch {
     print("添加失败: \(error)")
 }
 ```

 ### 获取用户
 ```swift
 do {
     let result = try accountManager.getUser(username: "田所浩二")
     print("用户数据: \(result.user), Token: \(result.token)")
 } catch {
     print("获取失败: \(error)")
 }
```
 ### 更新Token
 ```swift
 do {
     try accountManager.updateToken(username: "田所浩二", newToken: "HOMO1145141919810")
     print("Token更新成功")
 } catch {
     print("更新失败: \(error)")
 }
```

 ### 删除用户
 ```swift
 do {
     try accountManager.deleteUser(username: "田所浩二")
     print("用户删除成功")
 } catch {
     print("删除失败: \(error)")
 }
```
