//
//  ProfileTableViewManager.swift
//  arietta
//
//  Created by Christina Kang on 12/8/24.
//

import Foundation
import UIKit

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return progress.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "result", for: indexPath)
            
            let result = progress[indexPath.row]
            cell.textLabel?.text = " Difficulty: \(result.difficulty), Score: \(result.score), Date: \(result.date)"
            
            return cell
        }
}
