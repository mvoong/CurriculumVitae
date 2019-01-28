//
//  CVPresenter.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 25/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation

protocol CVPresenterDelegate: class {
    
    func displaySections(_ sections: [CVSection])
}

class CVPresenter {
    
    weak var delegate: CVPresenterDelegate?
    
    private let interactor: CVInteractorProtocol
    
    init(interactor: CVInteractorProtocol) {
        self.interactor = interactor
    }
    
    func viewDidLoadCalled() {
        self.interactor.requestCV() { [weak self] cv in
            if let sections = self?.createSections(cv: cv) {
                self?.delegate?.displaySections(sections)
            }
        }
    }
    
    func title() -> String {
        return NSLocalizedString("CV_TITLE", comment: "")
    }
    
    private func createSections(cv: CurriculumVitae) -> [CVSection] {
        var sections = [CVSection]()
        sections.append(self.createSummarySection(cv: cv))
        sections.append(contentsOf: self.createPastExperienceSections(cv: cv))
        return sections
    }
    
    private func createSummarySection(cv: CurriculumVitae) -> CVSection {
        return CVSection(title: nil, items: [CVDescriptionItem(string: cv.summary),
                                             CVDescriptionItem(string: cv.topics)])
    }
    
    private func createPastExperienceSections(cv: CurriculumVitae) -> [CVSection] {
        return cv.pastExperience.map { experience in
            var items = [TableItem]()
            items.append(CVDescriptionItem(string: experience.roleName))
            items.append(CVDescriptionItem(string: "\(experience.dateFrom.displayableDate()) - \(experience.dateTo.displayableDate())"))
            items.append(CVDescriptionItem(string: experience.description))
            return CVSection(title: experience.companyName, items: items)
        }
    }
}
