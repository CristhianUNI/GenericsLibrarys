//
//  ViewModelTableBuilder.swift
//  Pods
//
//  Created by COCOMSYS One on 6/29/17.
//
//

import UIKit

public typealias BindHandlerType = (UITableView, UITableViewCell) -> Void

public class ViewModelTableBuilder {
    
    var sections = [ViewModelSection]()
    var tableView: UITableView
    
    public init(tableView: UITableView) {
        self.tableView  = tableView
    }
    
    public func getSection<E: RawRepresentable>(section: E) -> ViewModelSection where E.RawValue == Int {
        return sections[section.rawValue]
    }
    
    public func addSection(section: ViewModelSection) {
        self.sections.append(section)
        registerRows(rows: section.rows) //TODO: validate if cells are not registered
        //TODO: notify
    }
    
    public func addSections(newSections: [ViewModelSection]) {
        self.sections.append(contentsOf: newSections)
        for section in newSections {
            registerRows(rows: section.rows)
        }
    }
    
    public func getSectionsCount() -> Int {
        return self.sections.count
    }
    
    public func getCellsCountInSection(section index: Int) -> Int {
        return self.sections[index].rows.count
    }
    
    public func bind(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let vmCell = getRowByIndex(indexPath: indexPath)
        return vmCell.load(tableView: tableView, indexPath: indexPath)
    }
    
    public func onDisplay(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let vmCell = getRowByIndex(indexPath: indexPath)
        vmCell.willDisplay(tableView: tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
    }
    
    public func applyCommonRowConfigOnBind(onBindHandler: @escaping BindHandlerType) {
        for section in self.sections {
            for row in section.rows {
                row.setOnBindHandler(handler: onBindHandler)
            }
        }
    }
    
    public func onSelect(tableView: UITableView, indexPath: NSIndexPath) {
        let vmCell = getRowByIndex(indexPath: indexPath)
        return vmCell.onSelect(tableView: tableView, indexPath: indexPath)
    }
    
    public func buildHeader(tableView: UITableView, section: Int) -> UIView? {
        return sections[section].buildHeader(tableView: tableView, section: section)
    }
    
    public func getHeaderHeight(section: Int) -> CGFloat {
        if sections.isInvalidIndex(index: section) { return 0.0 }
        guard let height = sections[section].getHeaderHeight() else {
            return 0.0
        }
        return height
    }
    
    public func getRowByIndex(indexPath: NSIndexPath) -> ViewModelRowProtocol {
        return sections[indexPath.section].rows[indexPath.row]
    }
    
    public func setRowModelByIndex( indexPath: NSIndexPath, model: AnyClass) {
        getRowByIndex(indexPath: indexPath).setModel(model: model)
    }
    
    public func setRowModelBySection<E: RawRepresentable>(section: E, rowIndex: Int, model: AnyObject) where E.RawValue == Int {
        getSection(section: section).setRowModel(position: rowIndex, model: model)
    }
    
    public func setRowModelBySection<E: RawRepresentable, T: RawRepresentable>
        (section: E, rowIndex: T, model: AnyObject) where E.RawValue == Int, T.RawValue == Int {
        getSection(section: section).setRowModel(position: rowIndex, model: model)
    }
    
    public func setRowsModelsBySection<E: RawRepresentable>(section: E, model: AnyObject) where E.RawValue == Int {
        for row in getSection(section: section).rows {
            row.setModel(model: model)
        }
    }
    
    public func registerRows(rows: [ViewModelRowProtocol]) {
        for row in rows {
            self.registerRow(row: row)
        }
    }
    
    public func registerRow(row: ViewModelRowProtocol) {
        if let fileName = row.getFileName() , row.getRowClass() == nil{
            tableView.register(UINib(nibName: fileName, bundle: nil), forCellReuseIdentifier: row.getViewId())
            return
        }
        
        if let rowClass = row.getRowClass() {
            tableView.register(rowClass, forCellReuseIdentifier: row.getViewId())
            return
        }
    }
    
    public func reloadData() {
        self.tableView.reloadData()
    }
}

public class ViewModelRow<Model>: ViewModelRowProtocol {
    
    public var model: Model?
    public var tag: Int?
    public var hideSeparator: Bool
    var onBindHandler: BindHandlerType?
    
    public init(model: Model? = nil, hideSeparator: Bool = false) {
        self.model         = model
        self.hideSeparator = hideSeparator
    }
    
    public init(model: Model? = nil, tag: Int?, hideSeparator: Bool = false) {
        self.model         = model
        self.tag           = tag
        self.hideSeparator = hideSeparator
    }
    
    public func getViewId() -> String {
        preconditionFailure("method not implemented")
    }
    
    public func getRowClass() -> AnyClass? {
        return nil
    }
    
    public func getFileName() -> String? {
        if getViewId().isEmpty {
            preconditionFailure("method not implemented")
        }
        return getViewId()
    }
    
    public func getHeight(tableView: UITableView) -> CGFloat? {
        preconditionFailure("method not implemented")
    }
    
    public func getEstimatedHeight(tableView: UITableView) -> CGFloat? {
        guard let height = getHeight(tableView: tableView) else {
            preconditionFailure("method not implemented")
        }
        return height
    }
    
    public func bind(tableView: UITableView, cell: UITableViewCell, indexPath: NSIndexPath) {
        self.hideSeparatorIfApply(cell: cell)
    }
    
    public func onSelect(tableView: UITableView, indexPath: NSIndexPath) { }
    
    public func willDisplay(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) { }
    
    public func setOnBindHandler(handler: @escaping BindHandlerType) {
        self.onBindHandler = handler
    }
    
    public func load(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let vCell = tableView.dequeueReusableCell(withIdentifier: getViewId(), for: indexPath as IndexPath)
        bind(tableView: tableView, cell: vCell, indexPath: indexPath)
        
        self.onBindHandler?(tableView, vCell)
        return vCell
    }
    
    public func setModel(model newModel: AnyObject) {
        guard let newModel = newModel as? Model else {
            return
        }
        self.model = newModel
    }
    
    public func hideSeparatorIfApply(cell: UITableViewCell) {
        if self.hideSeparator {
            CommonViewHelper.hideCellSeparator(cell: cell)
        }
    }
    
}
