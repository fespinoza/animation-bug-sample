//
//  ViewController.swift
//  AnimationBug
//
//  Created by Felipe Espinoza on 11/01/2018.
//  Copyright © 2018 Felipe Espinoza. All rights reserved.
//

import UIKit

struct Tab {
  let background: UIImage?
}

struct Story {
  let tabs: [Tab]
}

class ViewController: UITableViewController {
  var stories: [Story] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem

    stories = [
      Story(tabs: [
        Tab(background: UIImage(named: "bg_1")),
        Tab(background: UIImage(named: "bg_2")),
        Tab(background: UIImage(named: "bg_3")),
      ]),
      Story(tabs: [
        Tab(background: UIImage(named: "bg_4")),
        Tab(background: UIImage(named: "bg_5")),
        Tab(background: UIImage(named: "bg_6")),
        Tab(background: UIImage(named: "bg_7")),
        Tab(background: UIImage(named: "bg_8")),
      ]),
      Story(tabs: [
        Tab(background: UIImage(named: "bg_9")),
        Tab(background: UIImage(named: "bg_10")),
        Tab(background: UIImage(named: "bg_11")),
        Tab(background: UIImage(named: "bg_1")),
      ]),
      Story(tabs: [
        Tab(background: UIImage(named: "bg_12")),
        Tab(background: UIImage(named: "bg_8")),
        Tab(background: UIImage(named: "bg_2")),
        Tab(background: UIImage(named: "bg_4")),
        Tab(background: UIImage(named: "bg_9")),
      ]),
      Story(tabs: [
        Tab(background: UIImage(named: "bg_2")),
        Tab(background: UIImage(named: "bg_9")),
        Tab(background: UIImage(named: "bg_6")),
      ]),
    ]
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.tableView.rowHeight = self.view.bounds.height
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return stories.count
  }

   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SuperCell

    let story = stories[indexPath.row]

    cell.story = story
    print(">>>>>> set the images 0 and 1 for the image swapper view")
    cell.imageSwapperView.foregroundImage = story.tabs[0].background
    cell.imageSwapperView.backgroundImage = story.tabs[1].background

    cell.imageSwapperView.prepareAnimation()

    return cell
   }

  override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if let cell = cell as? SuperCell {
      print("cleanup after end displaying")
      cell.imageSwapperView.cleanup()
    }
  }

  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */

  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */

  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

   }
   */

  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */

}
