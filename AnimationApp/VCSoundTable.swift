//
//  VCSoundTable.swift
//  AnimationApp
//
//  Created by TY on 29/09/2024.
//

import UIKit

class VCSoundTable: UIViewController {
    
    @IBOutlet weak var soundTable: UITableView!
    var soundNames: [String] = [ "sound1","sound2","sound3","sound4","sound5","sound6","sound7",
        "sound8","sound9", "sound10" ]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialization code
        
       
        
        soundTable.dataSource = self
        soundTable.delegate = self
        
        for sound in soundNames {
            print(sound)
        }
    }

}
extension VCSoundTable: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //thiết lập sl phần tử muốn hiển thị
        return soundNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = soundNames[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(soundNames[indexPath.row]) is selected") //khai báo sự kiện tg ưgs với 1 cell dc chọn
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.tintColor = .yellow
    }
    
    
    
    
}
