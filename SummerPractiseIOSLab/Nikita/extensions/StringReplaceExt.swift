//
//  StringReplaceExt.swift
//  SummerPractiseIOSLab
//
//  Created by Enoxus on 12/04/2019.
//  Copyright © 2019 itisIOSLab. All rights reserved.
//

import Foundation

extension String {
    func stringByReplacingFirstOccurrenceOfString(
        target: String, withString replaceString: String) -> String
    {
        if let range = self.range(of: target) {
            return self.replacingCharacters(in: range, with: replaceString)
        }
        return self
    }
}
