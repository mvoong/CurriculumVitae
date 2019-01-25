//
//  CVPresenterTests.swift
//  CurriculumVitaeTests
//
//  Created by Michael Voong on 25/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import XCTest
@testable import CurriculumVitae

class CVPresenterTests: XCTestCase {

    let stubInteractor = StubCVInteractor()
    var displaySectionsCalled: [CVSection]?
    
    func testViewDidLoadCalledRequestsCV() {
        let presenter = CVPresenter(interactor: self.stubInteractor)
        
        presenter.viewDidLoadCalled()
        
        XCTAssertNotNil(self.stubInteractor.requestCVCalledWithCompletion)
    }

    func testViewDidLoadCalledDisplaysSections() {
        let presenter = CVPresenter(interactor: self.stubInteractor)
        presenter.delegate = self
        let cv = CurriculumVitae(summary: "Summary", topics: "", pastExperience: [])
        
        presenter.viewDidLoadCalled()
        self.stubInteractor.requestCVCalledWithCompletion?(cv)
        
        let item = self.displaySectionsCalled?[0].items[0] as? CVDescriptionItem
        XCTAssertEqual(item?.string, "Summary")
        
        // Additional tests go here
    }
    
    func testTitleReturnsLocalizedTitle() {
        let presenter = CVPresenter(interactor: self.stubInteractor)
        
        XCTAssertEqual(presenter.title(), "CV")
    }
}

extension CVPresenterTests: CVPresenterDelegate {
    
    func displaySections(_ sections: [CVSection]) {
        self.displaySectionsCalled = sections
    }
}
