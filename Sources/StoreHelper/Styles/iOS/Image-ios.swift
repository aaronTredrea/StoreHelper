//
//  BodyImage.swift
//  StoreHelper
//
//  Created by Russell Archer on 20/12/2021.
//

import SwiftUI

#if os(iOS)
@available(iOS 15.0, *)
public extension Image {
    
    // Read images from the Sources/Resources folder
    init(packageResource name: String, ofType type: String) {
        #if canImport(UIKit)
        guard let path = Bundle.module.path(forResource: name, ofType: type),
              let image = UIImage(contentsOfFile: path) else {
                  self.init(name)
                  return
              }
        
        self.init(uiImage: image)
        #elseif canImport(AppKit)
        guard let path = Bundle.module.path(forResource: name, ofType: type),
              let image = NSImage(contentsOfFile: path) else {
                  self.init(name)
                  return
              }
        self.init(nsImage: image)
        #else
        self.init(name)
        #endif
    }
    
    func bodyImage() -> some View {
        self
            .resizable()
            .cornerRadius(15)
            .aspectRatio(contentMode: .fit)
    }
    
    func bodyImageNotRounded() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
#endif


//
//  BodyImage.swift
//  StoreHelper
//
//  Created by Russell Archer on 20/12/2021.
//

import SwiftUI

#if os(visionOS)
@available(iOS 15.0, *)
public extension Image {
    func bodyImage() -> some View {
        self
    }
    
    func bodyImageNotRounded() -> some View {
        self
    }
}

public struct SheetBarView: View {
    public var body: some View {
        EmptyView()
    }
}
#endif
