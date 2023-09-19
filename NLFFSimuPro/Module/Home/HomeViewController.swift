//
//  HomeViewController.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/8/11.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class HomeViewController: BaseViewController {
    
    var settingButton: UIButton!
    
    var tableView: UITableView!
    
    lazy var dataList: [LevelModel] = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configData()
        
        self.configNav()
        
        self.configView()
    }
    
}

fileprivate extension HomeViewController {
    func configData() {
        
        guard let filePath = Bundle.main.path(forResource: "Level", ofType: "json") else {
            return
        }
        do {
            let str = try String.init(contentsOfFile: filePath)
            guard let data = str.data(using: String.Encoding.utf8) else {
                return
            }
            guard let dic = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return
            }
            guard let dataList = dic["data"] as? [[String: Any]] else {
                return
            }
            let list = try APIDataEncoder.arrModel(with: dataList, modelType: LevelModel.self)
            self.dataList.removeAll()
            self.dataList.append(contentsOf: list)
            
        } catch let error {
            Log.Error(error)
        }
        
    }
}

fileprivate extension HomeViewController {
    
    func configNav() {
        
        weak var weakSelf = self
        
        let rightView = UIView.create(frame: CGRect.create(x: 0, y: 0, width: 44, height: 44))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightView)
        
        self.settingButton = UIButton.create()
            .set(frame: .create(x: 0, y: 0, width: 44, height: 44))
            .set(image: .create(name: "Home_Nav_Setting"))
            .add(tap: {
                weakSelf?.navSettingAction()
            }, disposeBag: self.disposeBag)
            .set(superView: rightView)
        
    }
    
    func navSettingAction() {
        self.tabBarController?.selectTab(1)
    }
    
    
}

fileprivate extension HomeViewController {
    func configView() {
        
        self.tableView = UITableView.create(style: .grouped)
            .set(superView: self.view)
            .set(snp: { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: App.navigationbarHeight(), left: 0, bottom: App.tabbarHeight(), right: 0))
            })
            .set(delegate: self, dataSource: self)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {}


extension HomeViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dataList.count < 1 {
            return 0
        }
        if self.dataList.count <= section {
            return 0
        }
        let model = self.dataList[section]
        if (model.isValid ?? 0) < 1 {
            return 0
        }
        return (model.mechanismList?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.dataList.count <= indexPath.section {
            let cell = tableView.get(registerCell: BaseTableViewCell.self)
            return cell
        }
        
        let model = self.dataList[indexPath.section]
        
        if indexPath.row == 0 {
            let cell = tableView.get(registerCell: HomeTableHeaderCell.self)
            cell.indexPath = indexPath
            cell.model = model
            return cell
        } else if (model.mechanismList?.count ?? 0) <= indexPath.row - 1 {
            let cell = tableView.get(registerCell: BaseTableViewCell.self)
            return cell
        } else if model.cellModel.isExpend == 0 {
            let cell = tableView.get(registerCell: BaseTableViewCell.self)
            return cell
        } else {
            let cell = tableView.get(registerCell: HomeTableMechanismCell.self)
            cell.indexPath = IndexPath.init(row: indexPath.row - 1, section: indexPath.section)
            cell.model = model.mechanismList?[indexPath.row - 1]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.dataList.count <= indexPath.section {
            return 0.00001
        }
        let model = self.dataList[indexPath.section]
        if indexPath.row == 0 {
            return HomeTableHeaderCell.cellHeightWithModel(model)
        } else if (model.mechanismList?.count ?? 0) <= indexPath.row - 1 {
            return 0.0001
        } else if model.cellModel.isExpend == 0 {
            return 0.0001
        } else {
            return HomeTableMechanismCell.cellHeightWithModel(model.mechanismList?[indexPath.row - 1])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.dataList.count <= indexPath.section {
            return
        }
        if indexPath.row == 0 {
            let isExpand = self.dataList[indexPath.section].cellModel.isExpend
            self.dataList[indexPath.section].cellModel.isExpend = 1 - isExpand
            tableView.reloadTable()
        } else {
            
        }
    }
    
}

extension HomeViewController {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.create(frame: .zero)
            .set(backgroundColor: Color.clear)
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.create(frame: .zero)
            .set(backgroundColor: Color.clear)
        return view
    }
    
    
}
