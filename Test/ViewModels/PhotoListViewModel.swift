//
//  PhotoViewModel.swift
//  Test
//
//  Created by Alikhan Nursapayev on 26.04.2022.
//

import Foundation
import Alamofire

protocol PhotoDelegate {
    func photoDidLoad()
}


class PhotoListViewModel {
    private var photoListViewModel = [PhotoViewModel]()
    
    var delegate: PhotoDelegate?
    
    
    func addAlbumViewModel(_ vm: PhotoViewModel) {
        photoListViewModel.append(vm)
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return photoListViewModel.count
    }
    
    func modelAt(_ index: Int) ->PhotoViewModel {
        return photoListViewModel[index]
    }
    
    func loadData(id: Int) ->Void {
        let request = AF.request("https://jsonplaceholder.typicode.com/photos?id=\(id)").response {
            (responseData) in
            guard let data = responseData.data else {return}
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([PhotoData].self, from: data)
                
                for item in decodedData {
                    let photo = PhotoModel(albumId: item.albumId ?? 0, id: item.id ?? 0, title: item.title ?? "", url: item.url ?? "", thumbnailUrl: item.thumbnailUrl ?? "")
                    let vm = PhotoViewModel(photo: photo)
                    self.photoListViewModel.append(vm)
                    print(id)
                }
                
                self.delegate?.photoDidLoad()
            } catch {
                print(error)
            }
        }
    }
}


class PhotoViewModel {
    let photo: PhotoModel
    
    init(photo: PhotoModel) {
        self.photo = photo
    }
}
