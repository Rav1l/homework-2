//
//  PushNavStack.swift
//  
//
//  Created by Ravil Gubaidulin on 25.08.2023.
//

import SwiftUI

/// view, используемое для перехода к screen через включающий его NavStackVM
public struct PushNavStack<Label, Destination, Tag>: View where Label: View, Destination: View, Tag: Hashable {
    
    @EnvironmentObject private var navStakVM: NavStackVM
    private let label: Label?
    private let destinationId: String?
    private let destination: Destination
    private let tag: Tag?
    @Binding private var isActive: Bool
    @Binding private var selection: Tag?

    /// Создфние  PushNavStack, который запускает навигацию при нажатии или когда тег соответствует определенному значению.
    /// - Parameters:
    ///   - destination: screen к которому нужно перейти.
    ///   - destinationId: ID screen к которому нужно перейти (используется для быстрого возврата к screen в случае необходимости).
    ///   - tag: значение, представляющее эту операцию push.
    ///   - selection: привязка, которая запускает навигацию, если и когда ее значение соответствует значению тега.
    ///   - label: фактическое view, которое нужно нажать, чтобы вызвать навигацию.
    public init(destination: Destination,
                    destinationId: String? = nil,
                    tag: Tag,
                    selection: Binding<Tag?>,
                    @ViewBuilder label: () -> Label) {

            self.init(destination: destination,
                      destinationId: destinationId,
                      isActive: Binding.constant(false),
                      tag: tag,
                      selection: selection,
                      label: label)
        }
    
    private init(destination: Destination,
                     destinationId: String?,
                     isActive: Binding<Bool>,
                     tag: Tag?,
                     selection: Binding<Tag?>,
                     @ViewBuilder label: () -> Label) {

            self.label = label()
            self.destinationId = destinationId
            self._isActive = isActive
            self.tag = tag
            self.destination = destination
            self._selection = selection
        }

    public var body: some View {
            if let selection = selection, let tag = tag, selection == tag {
                DispatchQueue.main.async {
                    self.selection = nil
                    push()
                }
            }
            if isActive {
                DispatchQueue.main.async {
                    isActive = false
                    push()
                }
            }
            return label.onTapGesture {
                DispatchQueue.main.async {
                    push()
                }
                
            }
        }

        private func push() {
            navStakVM.push(destination, withId: destinationId)
        }
    }

public extension PushNavStack where Tag == Never {
    
    /// Creates a PushView that triggers the navigation on tap.
    /// - Parameters:
    ///   - destination: screen к которому нужно перейти.
    ///   - destinationId: ID screen к которому нужно перейти (используется для быстрого возврата к screen в случае необходимости).
    ///   - label: фактическое view, которое нужно нажать, чтобы вызвать навигацию.
    init(destination: Destination,
         destinationId: String? = nil,
         @ViewBuilder label: () -> Label) {
        
        self.init(destination: destination,
                  destinationId: destinationId,
                  isActive: Binding.constant(false),
                  tag: nil,
                  selection: Binding.constant(nil),
                  label: label)
    }
    
    /// Создает PushView, который запускает навигацию при нажатии или когда логическое значение становится истинным.
    /// - Parameters:
    ///   - destination: screen к которому нужно перейти.
    ///   - destinationId: ID screen к которому нужно перейти  (используется для быстрого возврата к нему в случае необходимости).
    ///   - isActive: логическая привязка, которая запускает навигацию, если и когда становится истинным.
    ///   - label:  фактическое view, которое нужно нажать, чтобы вызвать навигацию.
    init(destination: Destination,
             destinationId: String? = nil,
             isActive: Binding<Bool>,
             @ViewBuilder label: () -> Label) {

            self.init(destination: destination,
                      destinationId: destinationId,
                      isActive: isActive,
                      tag: nil,
                      selection: Binding.constant(nil),
                      label: label)
        }
}
