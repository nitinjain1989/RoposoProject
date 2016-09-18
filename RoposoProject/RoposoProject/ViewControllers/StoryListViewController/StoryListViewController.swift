//
//  StoryListViewController.swift
//  RoposoProject
//
//  Created by Nitin Jain on 18/09/16.
//  Copyright © 2016 Nitin Jain. All rights reserved.
//

import UIKit

class StoryListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,StoryCardCellDelegate
{
    var storyDataList:[StoryData] = [StoryData]()
    var userDataList:[UserData] = [UserData]()
    
    @IBOutlet weak var storyTableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpTableView()
        fetchStory()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.storyTableView.reloadData()
    }
    
    //MARK: 
    // This function is used to hide extra rows and register TableviewCell with UITableView
    func setUpTableView() -> Void
    {
        hideExtraRawFromTable(tableView: storyTableView)
        registerTableViewWithCell(tableView: storyTableView, nibName: "StoryCardTableViewCell")
    }
    
    //MARK:- UITableView Data Source Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return storyDataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 370.0
    }
    
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : StoryCardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StoryCardTableViewCell", for: indexPath) as! StoryCardTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let storyData = self.storyDataList[indexPath.section]
        cell.delegate = self
        cell.setUpCellData(data: storyData)
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let detailVC = StoryDetailViewController(nibName: "StoryDetailViewController", bundle: nil)
         let storyData = self.storyDataList[indexPath.section]
        detailVC.data = storyData
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
    //MARK: Story Card Delegate Function
    func followUnFollow()
    {
        storyTableView.reloadData()
    }
    
    //MARK: Create UserData Object from NSDictionary append data in to userDataList's Array
    func createUserData(dict:NSDictionary) -> Void
    {
        let userData = UserData()
        userData.id = dict["id"] as? String
        userData.imageUrl = dict["image"] as? String
        userData.userName = dict["username"] as? String
        userData.isFollow = dict["is_following"] as? Bool
        self.userDataList.append(userData)
    }
    
    //MARK: Create StoryData Object from NSDictionary and append data in to storyDataList's Array
    func createStoryData(dict:NSDictionary) -> Void
    {
        let storyData = StoryData()
        storyData.storyId = dict["id"] as? String
        storyData.storyDescription = dict["description"] as? String
        storyData.storyTitle = dict["title"] as? String
        storyData.type = dict["type"] as? String
        storyData.storyImageUrl = dict["si"] as? String
        
        let db = dict["db"] as? String
        
        for value in userDataList
        {
            if value.id! == db
            {
                storyData.userData = value
                break
            }
        }
        
        self.storyDataList.append(storyData)
    }
    
    //MARK: Fetch Json from File
    //This function is used to fetch data from JSON file and create modals(UserData and StoryData)
    func fetchStory() -> Void
    {
        if let path = Bundle.main.path(forResource: "data", ofType: "json")
        {
            do
            {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult: [NSDictionary] = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [NSDictionary]
                    
                    print(jsonResult)
                    
                    //Get all user data from array
                    for value in jsonResult
                    {
                        if value["username"] != nil
                        {
                             createUserData(dict: value)
                        }
                    }
                    //Get all story data from array
                    for value in jsonResult
                    {
                        let type:String? = value["type"] as? String
                        if type != nil && type! == "story"
                        {
                            createStoryData(dict: value)
                        }
                    }
                    storyTableView.reloadData()
                }
                catch
                {
                    print("Error in JSON parsing")
                }
            }
            catch
            {
                print("Error in file reading")
            }
        }
    }
}
