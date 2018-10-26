import UIKit
import Hero
class GalleryViewController: UICollectionViewController {
    
    var viewModel: GalleryViewModel!
    
    private var panGR = UIPanGestureRecognizer()
    private  var pageControl : ISPageControl?
    private  var cancelButton : UIButton?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = viewModel.getBackgorundColor()
        collectionView.prefetchDataSource = self
        collectionView.isPrefetchingEnabled = true
        collectionView?.contentInsetAdjustmentBehavior = .never
        preferredContentSize = CGSize(width: view.bounds.width, height: view.bounds.width)
        
        view.layoutIfNeeded()
        collectionView!.reloadData()
        
        collectionView?.scrollToItem(at: IndexPath(item: viewModel.getStartingIndex(), section: 0), at: .right, animated: false)
        
        panGR.addTarget(self, action: #selector(pan))
        panGR.delegate = self
        collectionView?.addGestureRecognizer(panGR)
        
    }
    
    deinit {
        self.collectionView = nil
        self.viewModel = nil
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        hero.dismissViewController()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        for v in (collectionView!.visibleCells as? [GalleryImageCollectionViewCell])! {
            v.topInset = view.safeAreaInsets.top
        }
    }

    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        guard let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        let cellSize =  size
        flowLayout.itemSize = cellSize
        flowLayout.invalidateLayout()
        
        let pageNumber = self.pageControl?.currentPage
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.collectionView.scrollToItem(at: IndexPath(item: pageNumber!, section: 0), at: .centeredHorizontally, animated: false)
            self.pageControl?.removeFromSuperview()
            self.pageControl = nil
            self.addPageControl()
            self.pageControl?.currentPage = pageNumber!
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addButton()
        addPageControl()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func pan() {
        
        let translation = panGR.translation(in: nil)
        let progress = translation.y / 1 / collectionView!.bounds.height
        switch panGR.state {
        case .began:
            hero.dismissViewController()
        case .changed:
            Hero.shared.update(progress)
        default:
            if (progress + panGR.velocity(in: nil).y / collectionView!.bounds.height).magnitude > 0.2 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    private func addButton(){
        
        guard let _ = cancelButton else {
            cancelButton = UIButton()
            cancelButton?.translatesAutoresizingMaskIntoConstraints = false
            cancelButton?.setTitle("Close", for: UIControl.State.normal)
            cancelButton?.setTitleColor(UIColor.white, for: UIControl.State.normal)
            self.view.addSubview(cancelButton!)
            
            cancelButton?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
            cancelButton?.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
            cancelButton?.addTarget(self, action: #selector(cancelButtonAction(_:)), for: .touchUpInside)
            
            return
        }
        
    }
    
    private func addPageControl(){
        guard let _ = pageControl else {
            let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35)
            pageControl = ISPageControl(frame: frame, numberOfPages: viewModel.numberOfImages())
            pageControl?.inactiveTintColor = UIColor.gray
            pageControl?.currentPageTintColor = UIColor.white
            pageControl?.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(pageControl!)

            pageControl?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
            pageControl?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            pageControl?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            pageControl?.heightAnchor.constraint(equalToConstant: 35).isActive = true
            if !(viewModel.numberOfImages() > 1) {
                pageControl!.isHidden = true
            }
            pageControl?.currentPage = viewModel.getStartingIndex()
            return
        }
    }
}

extension GalleryViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfImages()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let imageCell = GalleryImageCollectionViewCell.dequeue(collectionView: collectionView, indexPath: indexPath)
        imageCell.viewModel = viewModel.viewModel(for: indexPath)

        imageCell.imageView.hero.modifiers = [.position(CGPoint(x:view.bounds.width/2, y:view.bounds.height+view.bounds.width/2)), .scale(0.6), .fade]
        imageCell.topInset = view.safeAreaInsets.top
        
        
        return imageCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let cell = cell as? GalleryImageCollectionViewCell{
            cell.config()
        }
        self.pageControl?.currentPage = indexPath.row
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GalleryImageCollectionViewCell{
            cell.imageView.image = nil
        }
        
        if let visibleIndexPath = collectionView.indexPathsForVisibleItems.first{
            self.pageControl?.currentPage = visibleIndexPath.row
        }
    }
}

extension  GalleryViewController : UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths{
            let model = viewModel.viewModel(for: indexPath)
            model?.prefetch()
        }
    }
}
extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.bounds.size
    }
}

extension GalleryViewController:UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let cell = collectionView?.visibleCells[0] as? GalleryImageCollectionViewCell,
            cell.scrollView.zoomScale == 1 {
            let v = panGR.velocity(in: nil)
            return v.y > abs(v.x)
        }
        return false
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        
        return true
    }
}
