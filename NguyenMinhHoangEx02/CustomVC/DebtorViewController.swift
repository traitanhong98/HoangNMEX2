//
//  BorrowingViewController.swift
//  NguyenMinhHoangEx02
//
//  Created by Hoang on 11/14/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DebtorViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var debtorsTableView: UITableView!
    private let dataModel = DataModel.shared
    let disposeBag = DisposeBag()
    var seeMode: BehaviorRelay<SeeMode> = BehaviorRelay(value: .minimize)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    func setupTableView() {
        debtorsTableView.register(UINib(nibName: "DeptInfoTableViewCell", bundle: nil), forCellReuseIdentifier: DeptInfoTableViewCell.identifier)
        dataModel.listDebtors.subscribe(onNext: { (_) in
            DispatchQueue.main.async {
                self.debtorsTableView.reloadData()
            }
        }).disposed(by: disposeBag)
        seeMode.asObservable().subscribe(onNext: {[weak self] (_) in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.debtorsTableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
    
}
extension DebtorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.listDebtors.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DeptInfoTableViewCell.identifier, for: indexPath) as? DeptInfoTableViewCell else {
            return UITableViewCell()
        }
        cell.bindData(person: dataModel.listDebtors.value[indexPath.row])
        cell.changeMode(seeMode: self.seeMode.value)
        return cell
    }
}
