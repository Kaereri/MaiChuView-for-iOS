//
//  Untitled.swift
//  maimaidx_prober
//
//  Created by 枫羽云玲 on 2025/6/8.

/*
 本函数使用实例：
 // 初始化SwiftData
 let container = try! ModelContainer(for: User.self)
 let context = container.mainContext
 let accountManager = UserAccountManager(context: context)

 // 添加用户
 do {
     try accountManager.addUser(
         username: "john_doe",
         rating: 5,
         grade: "Gold",
         token: "secure_token_123"
     )
     print("用户添加成功")
 } catch {
     print("添加失败: \(error)")
 }

 // 获取用户
 do {
     let result = try accountManager.getUser(username: "john_doe")
     print("用户数据: \(result.user), Token: \(result.token)")
 } catch {
     print("获取失败: \(error)")
 }

 // 更新Token
 do {
     try accountManager.updateToken(username: "john_doe", newToken: "new_secure_token")
     print("Token更新成功")
 } catch {
     print("更新失败: \(error)")
 }

 // 删除用户
 do {
     try accountManager.deleteUser(username: "john_doe")
     print("用户删除成功")
 } catch {
     print("删除失败: \(error)")
 }
 */

import Foundation
import SwiftData
@MainActor

enum AccountError: Error {
    case userNotFound
    case tokenSaveFailed
    case tokenRetrieveFailed
    case tokenDeleteFailed
}

struct UserAccountManager {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    // 1. 添加账户
    func addUser(username: String, rating: Int, grade: String, token: String) throws {
        let user = User(username: username, rating: rating, grade: grade)
        // 在 addUser 方法中
        let descriptor = FetchDescriptor<User>(predicate: #Predicate { $0.username == username })
        if let existing = try? context.fetch(descriptor).first {
            throw NSError(domain: "Account", code: 1001, userInfo: [NSLocalizedDescriptionKey: "用户 \(username) 已存在"])
        }
        context.insert(user)
        
        do {
            guard KeychainManager.saveToken(for: username, token: token) else {
                context.delete(user)
                throw AccountError.tokenSaveFailed
            }
        } catch {
            context.delete(user)
            throw error
        }
    }
    
    // 2. 获取账户信息
    func getUser(username: String) throws -> (user: User, token: String) {
        guard let user = try? context.fetch(FetchDescriptor<User>(
            predicate: #Predicate { $0.username == username }
        )).first else {
            throw AccountError.userNotFound
        }
        
        guard let token = KeychainManager.getToken(for: username) else {
            throw AccountError.tokenRetrieveFailed
        }
        
        return (user, token)
    }
    
    // 3. 删除账户
    func deleteUser(username: String) throws {
        guard let user = try? context.fetch(FetchDescriptor<User>(
            predicate: #Predicate { $0.username == username }
        )).first else {
            throw AccountError.userNotFound
        }
        
        context.delete(user)
        
        if !KeychainManager.deleteToken(for: username) {
            throw AccountError.tokenDeleteFailed
        }
    }
    
    // 4. 更新用户明文数据
    func updateUser(username: String, newRating: Int? = nil, newGrade: String? = nil) throws {
        guard let user = try? context.fetch(FetchDescriptor<User>(
            predicate: #Predicate { $0.username == username }
        )).first else {
            throw AccountError.userNotFound
        }
        
        if let newRating { user.rating = newRating }
        if let newGrade { user.grade = newGrade }
    }
    
    // 5. 更新token
    func updateToken(username: String, newToken: String) throws {
        guard let _ = try? context.fetch(FetchDescriptor<User>(
            predicate: #Predicate { $0.username == username }
        )).first else {
            throw AccountError.userNotFound
        }
        
        guard KeychainManager.saveToken(for: username, token: newToken) else {
            throw AccountError.tokenSaveFailed
        }
    }
}
