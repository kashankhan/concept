//
//  UITestScenario.swift
//  RoadrunnerUITests
//
//  Created by Kabir Khan on 30.05.18.
//  Copyright © 2018 Foodora. All rights reserved.
//

import Foundation
import XCTest


protocol UITestScenario: TestScenario {

}

extension UITestScenario where Self: XCTestCase {
        
    // MARK: Waiting
    
    func waitforExistence(_ element: XCUIElement,
                          timeout: TimeInterval = 10.0,
                          file: String = #file,
                          line: UInt = #line) {
        waitFor(element, with: "exists == true", timeout: timeout, file: file, line: line)
    }
    
    func waitforNoExistence(_ element: XCUIElement,
                            timeoutValue: TimeInterval = 10.0,
                            file: String = #file,
                            line: UInt = #line) {
        waitFor(element, with: "exists != true", timeout: timeoutValue, file: file, line: line)
    }
    
    func waitForValueContains(_ element: XCUIElement,
                              value: String,
                              file: String = #file,
                              line: UInt = #line) {
        waitFor(element, with: "value CONTAINS '\(value)'", file: file, line: line)
    }
    
    private func waitFor(_ element: XCUIElement,
                         with predicateString: String,
                         description: String? = nil,
                         timeout: TimeInterval = 10.0,
                         file: String,
                         line: UInt) {
        let predicate = NSPredicate(format: predicateString)
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        if result != .completed {
            let message = description ?? "Expect predicate \(predicateString) for \(element.description)"
            self.recordFailure(withDescription: message, inFile: file, atLine: Int(line), expected: false)
        }
    }
}
