//
//  ExtTableView.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/9/9.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit


protocol TableViewDelegate: UITableViewDelegate, UITableViewDataSource {
    
    func tableViewNumberOfSection(tableView: UITableView) -> Int
    func tableViewNumberOfRow(in section: Int, tableView: UITableView) -> Int
    func tableViewCellType(in indexPath: IndexPath, tableView: UITableView) -> BaseTableViewCell.Type
    
    func tableViewCell(in indexPath: IndexPath, tableView: UITableView) -> BaseTableViewCell
    func tableViewCellDidSelect(in indexPath: IndexPath, tableView: UITableView)
    
    func tableViewHeader(in section: Int, tableView: UITableView) -> UIView
    func tableViewFooter(in section: Int, tableView: UITableView) -> UIView
    
    func tableViewCellHeight(in indexPath: IndexPath, tableView: UITableView) -> CGFloat
    func tableViewHeaderHeight(in section: Int, tableView: UITableView) -> CGFloat
    func tableViewFooterHeight(in section: Int, tableView: UITableView) -> CGFloat
}

extension TableViewDelegate {
    
    func tableViewNumberOfSection(tableView: UITableView) -> Int { return 0 }
    func tableViewNumberOfRow(in section: Int, tableView: UITableView) -> Int { return 0 }
    func tableViewCellType(in indexPath: IndexPath, tableView: UITableView) -> BaseTableViewCell.Type {
        return BaseTableViewCell.self
    }
    func tableViewCell(in indexPath: IndexPath, tableView: UITableView) -> BaseTableViewCell {
        return tableView.get(registerCell: BaseTableViewCell.self)
    }
    
    func tableViewCellDidSelect(in indexPath: IndexPath, tableView: UITableView) {
        
    }
    
    func tableViewHeader(in section: Int, tableView: UITableView) -> UIView {
        return UIView.init(frame: .zero).set(backgroundColor: Color.clear)
    }
    func tableViewFooter(in section: Int, tableView: UITableView) -> UIView {
        return UIView.init(frame: .zero).set(backgroundColor: Color.clear)
    }
    
    func tableViewCellHeight(in indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        return 0.000001
    }
    func tableViewHeaderHeight(in section: Int, tableView: UITableView) -> CGFloat {
        return 0.000001
    }
    func tableViewFooterHeight(in section: Int, tableView: UITableView) -> CGFloat {
        if section == self.tableViewNumberOfSection(tableView: tableView) - 1 {
            return 20
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewNumberOfSection(tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewNumberOfRow(in: section, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableViewCell(in: indexPath, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableViewCellHeight(in: indexPath, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableViewCellDidSelect(in: indexPath, tableView: tableView)
    }
   
}

extension UITableView {
 
    @discardableResult
    class func create(style: UITableView.Style = .grouped) -> Self {
        let tableView = Self.init(frame: .zero, style: style)
        tableView.backgroundColor = Color.clear
        tableView.backgroundView?.backgroundColor = Color.clear
        tableView.separatorColor = Color.clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        
        if #available(iOS 13.0, *) {
            tableView.showsLargeContentViewer = false
        }
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.estimatedRowHeight = 0
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.estimatedSectionFooterHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
        }
        
        return tableView
    }
    
    @discardableResult
    func set<Delegate: UITableViewDelegate, DataSource: UITableViewDataSource>(delegate: Delegate?, dataSource: DataSource?) -> Self {
        self.delegate = delegate
        self.dataSource = dataSource
        return self
    }
    
    @discardableResult
    func get<T: BaseTableViewCell>(registerCell: T.Type) -> T {
        let reuseId = String.init(describing: type(of: registerCell.self))
        if let cell = self.dequeueReusableCell(withIdentifier: reuseId) as? T {
            return cell
        } else {
            self.register(registerCell, forCellReuseIdentifier: reuseId)
            return self.dequeueReusableCell(withIdentifier: reuseId) as! T
        }
    }
    
    func reloadTable() {
        self.reloadData()
    }
    
}


class BaseTableViewCell: UITableViewCell {
    
    
    public var indexPath: IndexPath? {
        didSet {
            self.setIndexPath(indexPath)
        }
    }
    
    var model: Any? {
        didSet {
            self.setModel(model)
        }
    }
    
    public var view: UIView?
    
    public var disposeBag: DisposeBag {
        get {
            
            guard let bag = _disposeBag else {
                _disposeBag = .init()
                return _disposeBag ?? .init()
            }
            return bag
        }
    }

    fileprivate var _disposeBag: DisposeBag?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = Color.clear
        self.contentView.backgroundColor = Color.clear
        
        self.selectionStyle = .none
        
        self.view = UIView.init(frame: .zero)
            .set(superView: self.contentView)
            .set(snp: { make in
                make.edges.equalToSuperview()
            })
        
        self.initSubView()
        
    }
    
    open func initSubView() {
        
    }
    
    func setModel(_ model: Any?) {
        guard model != nil else {
            self.view?.set(hidden: true)
            return
        }
        self.view?.set(hidden: false)
    }
    
    func setIndexPath(_ indexPath: IndexPath?) {
        
    }
    
    
    class func cellHeightWithModel(_ model: Any?) -> CGFloat {
        guard model != nil else {
            return 0.00001
        }
        return 0.00001
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    deinit {
        _disposeBag = nil
    }
    
}
