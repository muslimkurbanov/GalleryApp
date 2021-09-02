//
//  BaseViewOutput.swift
//  kitchenonwheels
//
//  Created by Ramazan Ashurbekov on 08.06.2021.
//

import Foundation

protocol BaseViewOutput: AnyObject {
    
    func viewIsReady()
    func viewWillAppear()
    func viewDidAppear()
    func viewDidDisappear()
    func viewWillDisappear()
}


// MARK: - Default implementation
extension BaseViewOutput {
    
    func viewWillAppear() { }
    func viewWillDisappear() { }
    func viewDidAppear() { }
    func viewDidDisappear() { }
}
