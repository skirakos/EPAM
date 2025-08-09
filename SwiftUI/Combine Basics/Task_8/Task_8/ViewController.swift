//
//  ViewController.swift
//  Task_8
//
//  Created by Seda Kirakosyan on 08.08.25.
//

import UIKit
import Combine

class ViewModel: ObservableObject {
    @Published var isLoading: Bool = false
}

class ViewController: UIViewController {
    private let viewModel = ViewModel()
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancellable = viewModel.$isLoading
            .sink { isLoading in
                if isLoading {
                    print("Loading...")
                } else {
                    print("Loaded!")
                }
            }
        
        viewModel.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.isLoading = false
        }
    }
    


}

