//
//  ViewController.swift
//  Network Layer Flicker
//
//  Created by Vignesh on 29/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var photoUrl: [FlickImageUrl] = []
    var viewModel : ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewModel = ViewModel(apiManager: NetworkEngine())
        viewModel.bindCallBack = { self.updateDataSource()}
        
        self.searchBar.delegate = self
        self.imageTableView.delegate = self
        self.imageTableView.dataSource = self
        
    }
    //binded function
    func updateDataSource(){
        self.photoUrl = self.viewModel.photoUrl
        self.imageTableView.reloadData()
    }

}
extension ViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.search(key: searchBar.text)
        self.view.endEditing(true)
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoUrl.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell") as! ImageTableViewCell
        cell.setImage(url: photoUrl[indexPath.item].url)
        return cell
    }
    
    
}
