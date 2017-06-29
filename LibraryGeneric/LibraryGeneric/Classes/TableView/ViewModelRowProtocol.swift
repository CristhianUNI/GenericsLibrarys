//
//  ViewModelRowProtocol.swift
//  Pods
//
//  Created by COCOMSYS One on 6/29/17.
//
//

import UIKit

typealias GenSelectHandler<T> = (T) -> Void

public protocol ViewModelRowProtocol {
    
    func getHeight(tableView: UITableView) -> CGFloat?
    func getEstimatedHeight(tableView: UITableView) -> CGFloat?
    func getViewId() -> String
    func getFileName() -> String?
    func getRowClass() -> AnyClass?
    func bind(tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath)
    func load(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func setModel(model: AnyObject)
    
    func onSelect(tableView: UITableView, indexPath: IndexPath) //TODO: should be optional
    func willDisplay(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath)
    
    func setOnBindHandler(handler: @escaping BindHandlerType)
}
