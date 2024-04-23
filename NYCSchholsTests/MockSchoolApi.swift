//
//
// Copyright © 2024 THALES. All rights reserved.
//
    

import Foundation
@testable import NYCSchhols


class MockSchoolApi : SchoolApiLogic {
    
    var loadState : SchoolListLoadingState = .empty
   
    func getSchools(completion: @escaping (NYCSchhols.SchoolListApiResponse)) {
        
        switch loadState {
        case .error:
            completion(.failure(.networkingError("couldn't connect to server")))
        case .loaded:
            let mock = School(
                dbn: "02M260",
                schoolName: Optional("Clinton School Writers & Artists, M.S. 260"),
                overviewParagraph: Optional("Students who are prepared for college must have an education that encourages them to take risks as they produce and perform. Our college preparatory curriculum develops writers and has built a tight-knit community. Our school develops students who can think analytically and write creatively. Our arts programming builds on our 25 years of experience in visual, performing arts and music on a middle school level. We partner with New Audience and the Whitney Museum as cultural partners. We are a International Baccalaureate (IB) candidate school that offers opportunities to take college courses at neighboring universities."),
                schoolEmail: Optional("admissions@theclintonschool.net"),
                academicOpportunities1: Optional("Free college courses at neighboring universities"),
                academicOpportunities2: Optional("International Travel, Special Arts Programs, Music, Internships, College Mentoring English Language Learner Programs: English as a New Language"),
                neighborhood: Optional("Chelsea-Union Sq"),
                phoneNumber: nil, website: Optional("www.theclintonschool.net"), 
                finalGrades: Optional("6-12"),
                totalStudents: Optional("376"),
                schoolSports: Optional("Cross Country, Track and Field, Soccer, Flag Football, Basketball"),
                primaryAddressLine: Optional("10 East 15th Street"), 
                city: Optional("Manhattan"),
                zip: Optional("10003"),
                

                latitude: Optional("40.73653"), longitude: Optional("-73.9927"))
            
            completion(.success([mock]))
            
        case .empty:
            completion(.success([]))
        }
       return
    }
    
    
}
