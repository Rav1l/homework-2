//
//  NavStack.swift
//
//
//  Created by Ravil Gubaidulin on 25.08.2023.
//

import SwiftUI

///Тип перехода для всего NavStack
public enum NavTransition {
    /// Переходы не будут анимированы.
    case none
    /// Используется собственный переход (переход будет применяться как к операциям push, так и к pop).
    case custome(AnyTransition)
    /// Используется [default transition](x-source-tag://defaultTransition).
    case `default`
    
    /// Переход экрана справа налево при push, переход экрана слева направо при pop.
    /// - Tag: defaultTransition
    public static var defaultTransition: (push: AnyTransition, pop: AnyTransition) {
        let pushTransition = AnyTransition.asymmetric(insertion: .move(edge: .trailing),
                                                      removal: .move(edge: .leading))
        let popTransition = AnyTransition.asymmetric(insertion: .move(edge: .leading),
                                                     removal: .move(edge: .trailing))
        return (pushTransition, popTransition)
    }
}

///Альтернатива SwiftUI NavigationView, реализующий классическую навигацию на основе стека, дающий также больший контроль над анимацией и программной навигацией.
public struct NavStack <Root>: View where Root: View {
    @ObservedObject private var navStackVM: NavStackVM
    private let rootScreen: Root
    private let transitions: (push: AnyTransition, pop: AnyTransition)
    
    /// Создание NavStack
    /// - Parameters:
    ///   - transitionType: тип перехода, применяемый между screen в каждой операции push и pop.
    ///   - easing: функция easing, применяемая к каждой операции push и pop.
    ///   - rootView: самое первое представление в NavigationStack.
    public init(transitionType: NavTransition = .default,
                easing: Animation = NavStackVM.deafultEasing,
                @ViewBuilder rootScreen: () -> Root ) {
       
        self.init(transitionType: transitionType,
                  navStackVM: NavStackVM(easing: easing),
                  rootScreen: rootScreen)
    }
    
    /// Создает NavStack с предоставленным NavStackVM.
    /// - Parameters:
    ///   - transitionType: тип перехода, применяемый между screen в каждой операции push и pop.
    ///   - navigationStack: общий файл NavStackVM.
    ///   - rootView: самое первое представление в NavStack.
    public init(transitionType: NavTransition = .default,
                navStackVM: NavStackVM,
                @ViewBuilder rootScreen: () -> Root) {
        
        self.rootScreen = rootScreen()
        self.navStackVM = navStackVM
        switch transitionType {
        case .none:
            self.transitions = (.identity, .identity)
        case .custome(let transition):
            self.transitions = (transition, transition)
        default:
            self.transitions = NavTransition.defaultTransition
        }
    }
    
    public var body: some View {
        let showRoot = navStackVM.current == nil
        let navigationType = navStackVM.navigationType
        
        return ZStack {
            Group {
                if showRoot {
                    rootScreen
                        .transition(navigationType == .push ? transitions.push : transitions.pop)
                        .environmentObject(navStackVM)
                } else {
                    navStackVM.current!.nextScreen
                        .transition(navigationType == .push ? transitions.push : transitions.pop)
                        .environmentObject(navStackVM)
                }
            }
        }
    }
}
