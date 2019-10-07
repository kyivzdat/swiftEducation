//
//  ScrollView.swift
//  Imges
//
//  Created by Vladyslav PALAMARCHUK on 10/4/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

class ScrollView: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scroll: UIScrollView!
    
    var imageView : UIImageView?
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: image)
        setupScroll()
    }
    
    func setupScroll() {
        scroll.addSubview(imageView!)
        scroll.contentSize = (imageView?.frame.size)!
        scroll.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        setZoomScale()
    }
    
    func setZoomScale() {
        let scrollValue = self.view.bounds.size
        let imageViewValue = imageView!.bounds.size
        let minZoom = min(scrollValue.width / imageViewValue.width,
                          scrollValue.height / imageViewValue.height)
        scroll.minimumZoomScale = minZoom;
        scroll.zoomScale = minZoom
    }
    
    func viewForZooming(in scroll: UIScrollView) -> UIView? {
        return imageView
    }

}
