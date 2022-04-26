//
//  AlbumsListViewModel.swift
//  Test
//
//  Created by Alikhan Nursapayev on 26.04.2022.
//

import Foundation
import Alamofire


protocol AlbumsListDelegate {
    func albumsDidLoad(vm: [AlbumViewModel])
}

class AlbumsListViewModel {
    private var albumsListViewModel = [AlbumViewModel]()
    
    var delegate: AlbumsListDelegate?
    
    func addAlbumViewModel(_ vm: AlbumViewModel) {
        albumsListViewModel.append(vm)
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return albumsListViewModel.count
    }
    
    func modelAt(_ index: Int) ->AlbumViewModel {
        return albumsListViewModel[index]
    }
    
    func loadData() ->Void {
        let request = AF.request("https://jsonplaceholder.typicode.com/albums").response {
            (responseData) in
            guard let data = responseData.data else {return}
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([AlbumData].self, from: data)
                
                for item in decodedData {
                    let album = AlbumModel(userId: item.userId, id: item.id, title: item.title)
                    let vm = AlbumViewModel.init(album: album)
                    self.albumsListViewModel.append(vm)
                }
                
                self.delegate?.albumsDidLoad(vm: self.albumsListViewModel)
            } catch {
                print(error)
            }
            
        }
    }
}

class AlbumViewModel {
    let album: AlbumModel
    
    init(album: AlbumModel) {
        self.album = album
    }
}
