//
//  Todo.swift
//  TodoList
//
//  Created by joonwon lee on 2020/03/19.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit


// TODO: Codable과 Equatable 추가
// 객체 간의 동등 비교를 위해서는 Equatable 필요
// Codable로 json 파싱을 쉽게 할 수 있게 하고, struct를 json으로 쉽게 만들기도
struct Todo: Codable, Equatable {
    let id: Int
    var isDone: Bool
    var detail: String
    var isToday: Bool
    
    mutating func update(isDone: Bool, detail: String, isToday: Bool) {
        // TODO: update 로직 추가
        self.isDone = isDone
        self.detail = detail
        self.isToday = isToday
        
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        // TODO: 동등 조건 추가
        // 왼쪽 아이디 == 오른쪽 아이디
        return lhs.id == rhs.id
    }
}

// viewModel 객체에서 매니저 많이 사용할 예정
class TodoManager {
    
    // 싱글톤 객체 생성
    static let shared = TodoManager()
    
    static var lastId: Int = 0
    
    var todos: [Todo] = []
    
    func createTodo(detail: String, isToday: Bool) -> Todo {
        // [x] TODO: create로직 추가
        
        let nextId = TodoManager.lastId + 1
        TodoManager.lastId = nextId
        return Todo(id: nextId, isDone: false, detail: detail, isToday: isToday)
    }
    
    func addTodo(_ todo: Todo) {
        // [x] TODO: add로직 추가
        todos.append(todo)
        saveTodo()
    }
    
    func deleteTodo(_ todo: Todo) {
        // [x] TODO: delete 로직 추가
        
        todos = todos.filter { existingTodo in
            return existingTodo.id != todo.id
        }
        // 위 코드 축약버전
        //todos = todos.filter { $0.id != todo.id  }
        
        // delete 다른 방법
//        if let index = todos.firstIndex(of: todo) {
//            todos.remove(at: index)
//        }
        
        saveTodo()
    }
    
    func updateTodo(_ todo: Todo) {
        // [x] TODO: updatee 로직 추가
        guard let index = todos.firstIndex(of: todo) else { return }
        todos[index].update(isDone: todo.isDone, detail: todo.detail, isToday: todo.isToday)
        saveTodo()
    }
    
    func saveTodo() {
        Storage.store(todos, to: .documents, as: "todos.json")
    }
    
    func retrieveTodo() {
        todos = Storage.retrive("todos.json", from: .documents, as: [Todo].self) ?? []
        
        let lastId = todos.last?.id ?? 0
        TodoManager.lastId = lastId
    }
}

class TodoViewModel {
    
    enum Section: Int, CaseIterable {
        case today
        case upcoming
        
        var title: String {
            switch self {
            case .today: return "Today"
            default: return "Upcoming"
            }
        }
    }
    
    private let manager = TodoManager.shared
    
    var todos: [Todo] {
        return manager.todos
    }
    
    var todayTodos: [Todo] {
        return todos.filter { $0.isToday == true }
    }
    
    var upcompingTodos: [Todo] {
        return todos.filter { $0.isToday == false }
    }
    
    var numOfSection: Int {
        return Section.allCases.count
    }
    
    func addTodo(_ todo: Todo) {
        manager.addTodo(todo)
    }
    
    func deleteTodo(_ todo: Todo) {
        manager.deleteTodo(todo)
    }
    
    func updateTodo(_ todo: Todo) {
        manager.updateTodo(todo)
    }
    
    func loadTasks() {
        manager.retrieveTodo()
    }
}

