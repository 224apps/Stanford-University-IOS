//
//  OptionalImage.swift
//  EmojiArt
//
//  Created by Abdoulaye Diallo on 6/15/20.
//  Copyright © 2020 Abdoulaye Diallo. All rights reserved.
//

import Foundation
import SwiftUI

struct OptionalImage: View {
    var uiImage: UIImage?
    
    var body: some View {
        Group {
            if uiImage != nil {
                Image( uiImage: uiImage!)
            }
        }
    }
}
