//
//  StoryDetailViewController.swift
//  RoposoProject
//
//  Created by Nitin Jain on 18/09/16.
//  Copyright © 2016 Nitin Jain. All rights reserved.
//

import UIKit

class StoryDetailViewController: UIViewController,StoryCardCellDelegate,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var detailTableView: UITableView!
    var data:StoryData!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpTableView()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:
    // This function is used to hide extra rows and register TableviewCell with UITableView
    func setUpTableView() -> Void
    {
        hideExtraRawFromTable(tableView: detailTableView)
        registerTableViewWithCell(tableView: detailTableView, nibName: "StoryCardTableViewCell")
        registerTableViewWithCell(tableView: detailTableView, nibName: "StoryDetailTableViewCell")
        self.detailTableView.estimatedRowHeight = 500.0
        self.detailTableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    //MARK:- UITableView Data Source Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : BaseTableViewCell!
        if indexPath.row == 0
        {
            cell  = tableView.dequeueReusableCell(withIdentifier: "StoryCardTableViewCell", for: indexPath) as! StoryCardTableViewCell
            (cell as! StoryCardTableViewCell).delegate = self
        }
        else
        {
            cell  = tableView.dequeueReusableCell(withIdentifier: "StoryDetailTableViewCell", for: indexPath) as! StoryDetailTableViewCell
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.setUpCellData(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        if(tableView.responds(to: #selector(setter: UIView.layoutMargins)))
        {
            tableView.layoutMargins = UIEdgeInsets.zero
        }
        
        if(cell.responds(to: #selector(setter: UIView.layoutMargins)))
        {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
    
    
    //MARK: Story Card Delegate Function
    func followUnFollow()
    {
        self.detailTableView.reloadData()
    }
}
