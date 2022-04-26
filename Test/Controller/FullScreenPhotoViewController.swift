//
//  FullScreenPhotoViewController.swift
//  Test
//
//  Created by Alikhan Nursapayev on 26.04.2022.
//

import UIKit
import SDWebImage

class FullScreenPhotoViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var photoViewModel: PhotoViewModel?
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 5.0
        if let photoViewModel = photoViewModel {
            if let imageUrl = URL(string: photoViewModel.photo.url) {
                let scale = UIScreen.main.scale
                let thumbnailSize = CGSize(width: 200 * scale, height: 200 * scale)
                    img.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeholder"), context: [.imageThumbnailPixelSize : thumbnailSize])

            }
            
        }
    }

}


extension FullScreenPhotoViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.img
    }
}
