//
//  ViewController.swift
//  Test
//
//  Created by Alikhan Nursapayev on 24.04.2022.
//

import UIKit
import Alamofire


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var albumsListViewModel = AlbumsListViewModel()
    private var selectedId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        albumsListViewModel.delegate = self
        albumsListViewModel.loadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumsListViewModel.numberOfRows(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.cellIdentifier, for: indexPath) as! CustomTableViewCell
        
        var model = albumsListViewModel.modelAt(indexPath.row)
        let viewModel = CellViewModel(title: model.album.title ?? "")
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        selectedId = albumsListViewModel.modelAt(indexPath.row).album.id
        performSegue(withIdentifier: "fromAlbumToPhotoVC", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromAlbumToPhotoVC" {
            let destinationVC = segue.destination as! PhotoViewController
            destinationVC.photoId = selectedId ?? 0
        }
    }

}

extension ViewController: AlbumsListDelegate {
    func albumsDidLoad(vm: [AlbumViewModel]) {
        self.tableView.reloadData()
        print("reloaded")
    }
    
    
}

struct CellViewModel {
    var title: String
}
