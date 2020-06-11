//
//  Array+only.swift
//  Memorize
//
//  Created by Abdoulaye Diallo on 6/8/20.
//  Copyright © 2020 Abdoulaye Diallo. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first: nil
    }
}
