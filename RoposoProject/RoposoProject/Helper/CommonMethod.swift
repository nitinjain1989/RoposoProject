//
//  CommonMethod.swift
//  RoposoProject
//
//  Created by Nitin Jain on 18/09/16.
//  Copyright © 2016 Nitin Jain. All rights reserved.
//

import Foundation
import UIKit

//This function is used to remove the extra line from TableView
public func hideExtraRawFromTable(tableView:UITableView)
{
    tableView.sectionFooterHeight = 0.0;
    tableView.tableFooterView = UIView(frame: CGRect.zero)
    tableView.sectionHeaderHeight = 0.0;
}

//This function is used to register a tableview cell with Tableview
public func registerTableViewWithCell(tableView:UITableView,nibName:String)
{
    tableView.register(UINib(nibName: nibName as String, bundle: nil), forCellReuseIdentifier: nibName as String)
}

