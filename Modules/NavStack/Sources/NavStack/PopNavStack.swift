//
//  PopNavStack.swift
//
//
//  Created by Ravil Gubaidulin on 25.08.2023.
//

import SwiftUI

/// Определяет тип операции pop.
public enum PopDestination {
    /// Возвращение к предыдущему screen.
    case previous
    
    /// Возвращиние к корневому screen  (т. е. к первому screen, добавленному в NavStack во время процесса инициализации).
    case root
    
    /// Возвращиние к screen, с определенным id.
    case screen(withId: String)
}

/// view, используемое для возврата к предыдущему screen через включающий его NavStackVM
public struct PopNavStack<Label, Tag>: View where Label: View, Tag: Hashable {
    @EnvironmentObject private var navStakVM: NavStackVM
    private let label: Label
    private let destination: PopDestination
    private let tag: Tag?
    @Binding private var isActive: Bool
    @Binding private var selection: Tag?
    
    /// Создание PopNavStack, который запускает навигацию при нажатии или когда тег соответствует определенному значению.
    /// - Parameters:
    ///   - destination: тип destination операции pop.
    ///   - tag: значение представляющее pop операцию.
    ///   - selection: привязка, которая запускает навигацию, если и когда ее значение соответствует значению тега.
    ///   - label: фактическое view, которое нужно нажать, чтобы вызвать навигацию.
    public init(destination: PopDestination = .previous,
                tag: Tag,
                selection: Binding<Tag?>,
                @ViewBuilder label: () -> Label) {
        
        self.init(destination: destination,
                  isActive: Binding.constant(false),
                  tag: tag,
                  selection: selection,
                  label: label)
    }
    
    private init(destination: PopDestination,
                 isActive: Binding<Bool>,
                 tag: Tag?,
                 selection: Binding<Tag?>,
                 @ViewBuilder label: () -> Label) {
        
        self.label = label()
        self.destination = destination
        self._isActive = isActive
        self._selection = selection
        self.tag = tag
    }
    
    public var body: some View {
        if let selection = selection, let tag = tag, selection == tag {
            DispatchQueue.main.async {
                self.selection = nil
                pop()
            }
        }
        if isActive {
            DispatchQueue.main.async {
                isActive = false
                pop()
            }
        }
        return label.onTapGesture {
            pop()
        }
    }
    
    private func pop() {
        navStakVM.pop(to: destination)
    }
}

public extension PopNavStack where Tag == Never {
    
    /// Создает PopNavStack, который запускает навигацию при нажатии.
    /// - Parameters:
    ///   - destination: тип destination операции pop.
    ///   - label: фактическое view, которое нужно нажать, чтобы вызвать навигацию.
    init(destination: PopDestination = .previous,
         @ViewBuilder label: () -> Label) {
        
        self.init(destination: destination,
                  isActive: Binding.constant(false),
                  tag: nil,
                  selection: Binding.constant(nil),
                  label: label)
    }
    
    /// Создает PopNavStack, который запускает навигацию при нажатии или когда логическое значение становится истинным.
    /// - Parameters:
    ///   - destination: тип destination операции pop.
    ///   - isActive: логическая привязка, которая запускает навигацию, если и когда становится истинным.
    ///   - label: фактическое view, которое нужно нажать, чтобы вызвать навигацию.
    init(destination: PopDestination = .previous,
         isActive: Binding<Bool>,
         @ViewBuilder label: () -> Label) {
        
        self.init(destination: destination,
                  isActive: isActive,
                  tag: nil,
                  selection: Binding.constant(nil),
                  label: label)
    }
}
