//
//  PhotoViewController.swift
//  Test
//
//  Created by Alikhan Nursapayev on 26.04.2022.
//

import UIKit

class PhotoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    


    @IBOutlet weak var tableView: UITableView!
    
    private var photoListViewModel = PhotoListViewModel()
    var selectedPhotoViewModel: PhotoViewModel?
    
    var photoId: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PhotoTableViewCell.nib(), forCellReuseIdentifier: PhotoTableViewCell.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        photoListViewModel.delegate = self
        photoListViewModel.loadData(id: photoId)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoListViewModel.numberOfRows(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.cellIdentifier, for: indexPath) as! PhotoTableViewCell
        
        var model = photoListViewModel.modelAt(indexPath.row)
        let viewModel = PhotosCellViewModel(img: model.photo.thumbnailUrl, title: model.photo.title)
        cell.configure(with: viewModel)
        print(viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedPhotoViewModel = photoListViewModel.modelAt(indexPath.row)
        performSegue(withIdentifier: "fromPhotoVCtoFullScreenVC", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromPhotoVCtoFullScreenVC" {
            let destinationVC = segue.destination as! FullScreenPhotoViewController
            
            destinationVC.photoViewModel = selectedPhotoViewModel
        }
    }
    
    

}

extension PhotoViewController: PhotoDelegate {
    func photoDidLoad() {
        tableView.reloadData()
        print("Reloaded")
    }
}

struct PhotosCellViewModel {
    var img: String
    var title: String
}
