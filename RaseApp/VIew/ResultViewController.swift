//
//  ResultViewController.swift
//  RaseApp
//
//  Created by Evgeny Trifonov on 25.03.2022.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var label: UILabel?
    @IBOutlet weak var tableView: UITableView?
    
    var result: String?
    
    var dataResults:[Result]?
    
    let imagesFonView = UIImageView(image: UIImage(named: "oboi"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label?.text = result
        
        tableView?.dataSource = self
        tableView?.delegate = self
        
        let data = UserDefaults.standard.value([Result].self, forKey: "results")
        dataResults = data?.sorted(by: { $0.exp > $1.exp })
        dataResults?.removeSubrange(8...)
        
        //create Fon
        imagesFonView.contentMode = .scaleAspectFill
        view.addSubview(imagesFonView)
        imagesFonView.frame = CGRect(x: CGFloat.zero, y: CGFloat.zero, width: view.frame.width, height: view.frame.height)
        view.sendSubviewToBack(imagesFonView)
     
    }
    @IBAction func restartAction(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _:ResultCell = (self.tableView?.dequeueReusableCell(withIdentifier: ResultCell.className, for: indexPath) as? ResultCell)!
        guard let tableView = self.tableView,
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as? ResultCell else {
                return UITableViewCell()
        }
        
        cell.set(model: self.dataResults?[indexPath.row] ?? Result())
        return cell
    }
    
}
