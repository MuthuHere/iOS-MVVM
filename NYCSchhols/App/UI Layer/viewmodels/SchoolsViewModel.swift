//
//
// Copyright © 2024 THALES. All rights reserved.
//
    

import Foundation
import Combine

class SchoolsViewModel {
    
   @Published private(set) var schools : [School]? = []
   @Published private(set) var error : DataError? = nil
    
    private let apiService : SchoolApiLogic
    
    init(apiService: SchoolApiLogic = SchoolDirectoryApi()) {
        self.apiService = apiService
    }
    
    func getSchools() {
        apiService.getSchools {[weak self] result in
            switch result {
            case .success(let schools):
                self?.schools = schools ?? []
            case .failure(let error):
                self?.error = error
            }
        }
        
    }
}
