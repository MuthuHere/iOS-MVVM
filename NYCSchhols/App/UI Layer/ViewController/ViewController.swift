//
//
// Copyright © 2024
//
    

import UIKit
import Combine

class ViewController: UIViewController {
    
    let viewModel = SchoolsViewModel()
    var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listenSchoolsList()
        viewModel.getSchools()
        
        let title = "app_title".localized()
        print(title)

    }

    private func listenSchoolsList() {
        
        viewModel.$schools
            .receive(on: RunLoop.main)
            .sink { schools in
                if let schools = schools {
                    print ("received value and count is \(schools.count)")
                }
            }
            .store(in: &cancellable)
        
        viewModel.$error
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                if let error = error {
                    let alert = UIAlertController(title: "School", message: "Could not get school list \(error)", preferredStyle: .alert)
                    
                    //actions
                    let action = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(action)
                    
                    self?.present(alert, animated: true)
                }
            }
            .store(in: &cancellable)

       
    }

}

