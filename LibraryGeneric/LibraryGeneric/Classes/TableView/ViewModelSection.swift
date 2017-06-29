//
//  ViewModelSection.swift
//  Pods
//
//  Created by COCOMSYS One on 6/29/17.
//
//

import UIKit

public class ViewModelSection {
    
    public var rows = [ViewModelRowProtocol]()
    private var position: Int!
    
    public init(position: Int) {
        self.position = position
    }
    
    convenience public init(position: Int, rows: [ViewModelRowProtocol]) {
        self.init(position: position)
        self.rows = rows
    }
    
    public init<E: RawRepresentable>(position enumPosition: E, rows: [ViewModelRowProtocol]) where E.RawValue == Int {
        self.position = enumPosition.rawValue
        self.rows = rows
    }
    
    public init<E: RawRepresentable>(position enumPosition: E) where E.RawValue == Int {
        self.position = enumPosition.rawValue
    }
    
    public func getPosition() -> Int {
        return self.position
    }
    
    public func setRowModel(position: Int, model: AnyObject) {
        rows[position].setModel(model: model)
    }
    
    public func setRowModel<E: RawRepresentable>(position: E, model: AnyObject) where E.RawValue == Int {
        setRowModel(position: position.rawValue, model: model)
    }
    
    public func buildHeader(tableView: UITableView, section: Int) -> UIView? {
        return nil
    }
    
    public func getHeaderHeight() -> CGFloat? {
        return nil
    }
}
