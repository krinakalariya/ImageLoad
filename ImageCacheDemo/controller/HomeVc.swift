//
//  HomeVc.swift
//  ImageCacheDemo
//
//  Created by krina kalariya on 08/03/25.
//

import UIKit

class HomeVc: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = ImageViewModel()
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .black
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchData()
        setupActivityIndicator()
        // Do any additional setup after loading the view.
    }
    
    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func fetchData() {
        activityIndicator.startAnimating()
        viewModel.fetchPhotosAsync()
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
}
extension HomeVc : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let photo = viewModel.photos[indexPath.row]
        cell.configure(with: photo)
        return cell

    }
}
extension HomeVc {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight - 200 {
            activityIndicator.startAnimating()
            viewModel.fetchPhotosAsync() // Load more images
        }
    }
}
