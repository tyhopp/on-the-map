//
//  StoryboardPreview.swift
//  OnTheMap
//
//  Created by Ty Hopp on 12/11/21.
//

import UIKit

#if canImport(SwiftUI) && DEBUG
import SwiftUI

extension UIViewController {
    private struct Preview: UIViewRepresentable {
        let currentStoryboardId: String
        
        init(storyboardId: String) {
            currentStoryboardId = storyboardId
        }
        
        @available(iOS 13.0.0, *)
        func makeUIView(context: Context) -> UIView {
            return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: currentStoryboardId).view
        }

        func updateUIView(_ uiViewController: UIView, context: Context) {}
    }

    func preview(storyboardId: String) -> some View {
        Preview(storyboardId: storyboardId)
    }
}
#endif
