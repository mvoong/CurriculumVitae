//
//  CVViewController.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 25/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import UIKit

class CVViewController: UIViewController {

    private lazy var presenter: CVPresenter = {
        let modelFetcher = ModelFetcher(requestExecuter: RequestExecuter(urlSession: URLSession.shared))
        return CVPresenter(interactor: CVInteractor(modelFetcher: modelFetcher))
    }()

    private var sections = [CVSection]()
    
    @IBOutlet private weak var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.presenter.title()
        self.presenter.delegate = self
        self.presenter.viewDidLoadCalled()
    }
    
}

extension CVViewController: CVPresenterDelegate {
    
    func displaySections(_ sections: [CVSection]) {
        DispatchQueue.main.async {
            self.sections = sections
            self.tableView?.reloadData()
        }
    }
}

extension CVViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.sections[indexPath.section].items[indexPath.item]
        return item.dequeueCell(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section].title
    }
}

extension CVViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension CVDescriptionItem {
    
    func dequeueCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: CVDescriptionCell.self, identifier: "DescriptionIdentifier", indexPath: indexPath)
        cell.label?.text = self.string
        return cell
    }
}
