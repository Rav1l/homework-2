//
//  NavStackVM.swift
//  
//
//  Created by Ravil Gubaidulin on 25.08.2023.
//

import SwiftUI

enum NavType {
    case push
    case pop
}

/** Менеджер NavStack. Он также обеспечивает программную навигацию.
    NavStackVM автоматически добавляется как @EnvironmentObject в иерархию NavStack.
    Кроме того, его можно создать вне иерархии NavigationStack и внедрить в нее вручную во время процесса инициализации NavStack.
 */
public class NavStackVM: ObservableObject {
    
    /// Функция easing по умолчанию для переходов push и pop.
    /// - Тег: defaultEasing
    public static let deafultEasing = Animation.easeOut(duration: 0.2)
    
    /// Текущий экран
    @Published var current: Screen?
    ///Тип перехода push или pop
    @Published private(set) var navigationType = NavType.push
    private let easing: Animation
    
    ///Создание NavStackVM
    ///Параметр easing: функция easing, применяется к переходам push и pop. По умолчанию будет использоваться defaultEasing).
    public init(easing: Animation = deafultEasing) {
        self.easing = easing
    }
    
    private var screenStack = ScreenStack() {
        didSet {
            current = screenStack.top()
        }
    }
    
    /// Текущая глубина стека навигации.
    /// Корень имеет глубину = 0
    public var depth: Int {
        screenStack.depth
    }
    
    /// Возвращает булево значение, указывающее, содержит ли стек screen с указанным идентификатором.
    /// - Параметр id: ID искомого screen.
    /// - Возвращает: **true**, если стек содержит screen с указанным ID; в противном случае — **false**.
    public func containsScreen(withId id: String) -> Bool {
        screenStack.indexForScreen(withId: id) != nil
    }
    
    /// Переход к screen.
    /// - Parameters:
    ///   - screen:  screen к которому нужно перейти..
    ///   - identifier: ID  screen к которому нужно перейти. (используется для быстрого возврата к screen при необходимости).
    public func push<S: View>(_ screen: S, withId identifier: String? = nil) {
        let screen: Screen = .init(id: identifier == nil ? UUID().uuidString : identifier!,
                                   nextScreen: AnyView(screen))
        navigationType = .push
        withAnimation(easing) {
            screenStack.push(screen)
        }
    }
    
    /// Переход к предыдущему screen.
    /// -  Parameter: destination type операции перехода.
    public func pop(to: PopDestination = .previous) {
        navigationType = .pop
        withAnimation(easing) {
            switch to {
            case .root:
                screenStack.popToRoot()
            case .screen(let id):
                screenStack.popToScreen(withId: id)
            default:
                screenStack.popToPrevious()
            }
        }
    }
}

//MARK: - Base Logic

struct Screen: Identifiable, Equatable {
    
    let id: String
    let nextScreen: AnyView
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
}

private struct ScreenStack {
    private var screens = [Screen]()
    
    func top() -> Screen? {
        screens.last
    }
    
    var depth: Int {
        screens.count
    }
    
    mutating func push(_ screen: Screen) {
        guard indexForScreen(withId: screen.id) == nil else {
            print("Duplicated view identifier: \"\(screen.id)\". You are trying to push a view with an identifier that already exists on the navigation stack.")
            return
        }
        screens.append(screen)
    }
    
    mutating func popToPrevious() {
        _ = screens.popLast()
    }
    
    mutating func popToScreen(withId identifier: String) {
        guard let screenIndex = indexForScreen(withId: identifier) else {
            print("Identifier \"\(identifier)\" not found. You are trying to pop to a view that doesn't exist.")
            return
        }
        screens.removeLast(screens.count - (screenIndex + 1))
    }
    
    mutating func popToRoot() {
        screens.removeAll()
    }
    
    ///Метод возвращает индекс элемента, у которого первым совпал id в массиве.
    func indexForScreen(withId identifier: String) -> Int? {
            screens.firstIndex {
                $0.id == identifier
            }
        }
}
