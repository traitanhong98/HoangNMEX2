//
//  DeptViewController.swift
//  NguyenMinhHoangEx02
//
//  Created by Hoang on 11/14/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CreditorViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var creditorTableView: UITableView!
    private let dataModel = DataModel.shared
    let disposeBag = DisposeBag()
    var seeMode: BehaviorRelay<SeeMode> = BehaviorRelay(value: .minimize)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    // MARK: - ConfigRx
    func setupTableView() {
        creditorTableView.register(UINib(nibName: "DeptInfoTableViewCell", bundle: nil), forCellReuseIdentifier: DeptInfoTableViewCell.identifier)
        dataModel.listCreditor.subscribe(onNext: { (_) in
            DispatchQueue.main.async {
                self.creditorTableView.reloadData()
            }
        }).disposed(by: disposeBag)
        seeMode.subscribe(onNext: {[weak self] (_) in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.creditorTableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
}
extension CreditorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.listCreditor.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DeptInfoTableViewCell.identifier, for: indexPath) as? DeptInfoTableViewCell else {
            return UITableViewCell()
        }
        cell.bindData(person: dataModel.listCreditor.value[indexPath.row])
        cell.changeMode(seeMode: self.seeMode.value)
        return cell
    }
}
