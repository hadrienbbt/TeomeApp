import SwiftUI

extension View {
    public func withBackgoundGradient(alignment: Alignment = .center) -> some View {
        BackgroundGradient(alignment: alignment) { self }
    }
    
    public func withScrollable(_ axis: Axis.Set, showsIndicators: Bool) -> some View {
        ScrollView(axis, showsIndicators: showsIndicators) {
            self
        }
    }
    
    public func withScrollableBackgroundGradient(_ axis: Axis.Set, showsIndicators: Bool, alignment: Alignment = .center) -> some View {
        self
            .withBackgoundGradient(alignment: alignment)
            .withScrollable(axis, showsIndicators: showsIndicators)
    }
    
    @ViewBuilder
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
         if conditional {
             content(self)
         } else {
             self
         }
     }
}

extension Date {
    var timeAgo: String {
        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!

        if minuteAgo < self {
            // let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
            return "À l'instant"
        } else if hourAgo < self {
            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
            return "Il y a \(diff) min"
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            return "Il y a \(diff) h"
        } else if weekAgo < self {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            return "Il y a \(diff) jours"
        }
        let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
        return "Il y a \(diff) semaines"
    }
}

