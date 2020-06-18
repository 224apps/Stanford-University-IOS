//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Abdoulaye Diallo on 6/11/20.
//  Copyright © 2020 Abdoulaye Diallo. All rights reserved.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    
    @ObservedObject var document: EmojiArtDocument
    
    @State private var chosenPalette: String = ""
    
    init(document: EmojiArtDocument) {
        self.document = document
        _chosenPalette = State(wrappedValue: self.document.defaultPalette)
    }
    
    var body: some View {
        VStack {
            HStack{
                PaletteChooser(document: self.document, chosenPalette: $chosenPalette)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(chosenPalette.map { String($0)}, id: \.self){ emoji  in
                            Text(emoji)
                                .font(Font.system(size: self.defaultEmojiSize))
                                .onDrag{ return NSItemProvider(object: emoji as NSString)}
                        }
                    }
                }
                .onAppear { self.chosenPalette = self.document.defaultPalette }
            }
            .padding(.horizontal)
            GeometryReader { geometry in
                ZStack {
                    Color.white.overlay(
                        OptionalImage(uiImage: self.document.backgroundImage)
                            .scaleEffect(self.zoomScale)
                            .offset(self.panOffset)
                    )
                        .gesture(self.doubleTapToZoom(in: geometry.size))
                    
                    if self.isLoading {
                        Image(systemName: "hourglass").imageScale(.large).spinning()
                    }else{
                        ForEach(self.document.emojis) { emoji in
                            Text(emoji.text)
                                .font(animatableWithSize: emoji.fontSize * self.zoomScale)
                                .position(self.position(for: emoji, in: geometry.size))
                        }
                    }
                }
                .clipped()
                .gesture(self.zoomGesture())
                .gesture(self.panGesture())
                .edgesIgnoringSafeArea([.horizontal, .bottom])
                .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { providers, location in
                    var location = geometry.convert(location, from: .global)
                    location = CGPoint(x: location.x - geometry.size.width / 2, y: location.y - geometry.size.height/2)
                    location = CGPoint(x: location.x - self.panOffset.width, y: location.y -  self.panOffset.height)
                    location = CGPoint(x: location.x / self.zoomScale, y: location.y / self.zoomScale)
                    return self.drop(providers: providers, at: location)
                }
                .navigationBarItems(trailing:
                    Button(action: {
                        if let url = UIPasteboard.general.url {
                            self.document.backgroundURL = url
                            self.confirmBackgroundPaste = true
                        }else {
                            self.explainBackgroundPaste = true
                        }
                    }, label: {
                        Image(systemName: "doc.on.clipboard").imageScale(.large)
                            .alert(isPresented: self.$explainBackgroundPaste) {
                                return Alert(
                                    title: Text("Paste Background"),
                                    message: Text("Copy the url of an image to the clipboard and touch this button to make it  the background of your document"),
                                    dismissButton: .default(Text("OK")))
                        }
                    }))
            }
        .zIndex(-1)
        }
        .alert(isPresented: self.$confirmBackgroundPaste) {
            return Alert(
                title: Text("Paste Background"),
                message: Text("Replace your background the url with \(UIPasteboard.general.url?.absoluteString ?? "nothing")?."),
                primaryButton:  .default(Text("OK")){
                    self.document.backgroundURL = UIPasteboard.general.url
                },
                secondaryButton: .cancel())
            
        }
    }
    @State private var explainBackgroundPaste = false
    @State private var confirmBackgroundPaste = false
    
    
    var isLoading: Bool {
        document.backgroundURL != nil && document.backgroundImage == nil
    }
    
    
    @State private var steadyStateZoomScale:CGFloat = 1.0
    @GestureState private var gestureZoomScale: CGFloat = 1.0
    
    private var zoomScale: CGFloat {
        steadyStateZoomScale * gestureZoomScale
    }
    private func zoomGesture() -> some Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale){ lastestGestureScale, gestureZoomScale, transaction in
                gestureZoomScale = lastestGestureScale
        }
        .onEnded { finalGestureScale in
            self.steadyStateZoomScale *= finalGestureScale
        }
    }
    
    
    @GestureState private var gesturePanOffset: CGSize = .zero
    
    private var panOffset: CGSize {
        (document.steadyStatePanOffset + gesturePanOffset) * zoomScale
    }
    
    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset){ latestDragGestureValue, gesturePanOffset, transaction in
                gesturePanOffset = latestDragGestureValue.translation / self.zoomScale
        }
        .onEnded { finalDragGestureValue in
            self.document.steadyStatePanOffset = self.document.steadyStatePanOffset + (finalDragGestureValue.translation / self.zoomScale)
        }
    }
    
    private func doubleTapToZoom(in size: CGSize) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation(.linear(duration: 2)){
                    self.zoomToFit(image: self.document.backgroundImage, in: size)
                }
        }
    }
    private func zoomToFit(image: UIImage?, in size: CGSize){
        if let image = image, image.size.width > 0, image.size.height > 0, size.height > 0 && size.height > 0 {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            document.steadyStatePanOffset = .zero
            self.steadyStateZoomScale = min(hZoom, vZoom)
        }
    }
    
    
    private func position(for emoji:EmojiArt.Emoji, in size:CGSize) -> CGPoint {
        var location = emoji.location
        location = CGPoint(x: location.x * zoomScale, y: location.y * zoomScale )
        location = CGPoint(x: location.x + size.width / 2, y: emoji.location.y + size.height / 2)
        location = CGPoint(x: location.x + panOffset.width, y: location.y + panOffset.height)
        return location
    }
    
    private func drop(providers: [NSItemProvider], at location: CGPoint) -> Bool{
        var found  = providers.loadFirstObject(ofType: URL.self) { (url) in
            self.document.backgroundURL = url
        }
        if !found {
            found = providers.loadObjects(ofType: String.self){ string in
                self.document.addEmoji(string, at: location, size: self.defaultEmojiSize)
            }
        }
        return found
    }
    private  let defaultEmojiSize: CGFloat  = 40.0
}




