//
//
// Copyright © 2024 THALES. All rights reserved.
//
    

import Foundation


extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(params: CVarArg...) -> String {
        return String(format: localized(), params)
    }
}
