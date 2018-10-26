import UIKit

class GalleryImageCollectionViewCell: UICollectionViewCell,DequeueInitializable {
    var imageView: UIImageView!
    var scrollView: UIScrollView!
    var dTapGR: UITapGestureRecognizer!
    var viewModel : GalleryImageCollectionViewCellViewModel!
    private var overlay : UIView?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        scrollView = UIScrollView(frame: bounds)
        imageView = UIImageView(frame: bounds)
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
        scrollView.maximumZoomScale = 5
        scrollView.delegate = self
        scrollView.contentMode = .center
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        addSubview(scrollView)
        
        dTapGR = UITapGestureRecognizer(target: self, action: #selector(doubleTap(gr:)))
        dTapGR.numberOfTapsRequired = 2
        addGestureRecognizer(dTapGR)
        
        
    }
    
    func config() {

        scrollView.setZoomScale(1, animated: false)
        
        if !viewModel.isZoomEnable(){
            scrollView.maximumZoomScale = 1
        }
        
        // imageView.hero.id = viewModel.getAnimationId()
        imageView.isOpaque = true
        
        
        let img = viewModel.image()
        if let uimage = img as? UIImage{
            imageView.image = uimage
        } else if let imgUrl = img as? URL {
            DispatchQueue.main.async {
                self.viewModel.loadImage(url: imgUrl, placeHolder: self.viewModel.getImagePlaceHolder(), in: self.imageView)
            }
        } else if let imageName = img as? String {
            
                if let img = UIImage(named: imageName){
                        self.imageView.image = img
                        
                } else {
                    if let imgUrl = imageName.url() {
                        DispatchQueue.main.async {
                            self.viewModel.loadImage(url: imgUrl, placeHolder: self.viewModel.getImagePlaceHolder(), in: self.imageView)
                        }
                    }
                }
        }
        
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width  = imageView.frame.size.width  / scale
        let newCenter = imageView.convert(center, from: scrollView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    @objc func doubleTap(gr: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1 {
            scrollView.zoom(to: zoomRectForScale(scale: scrollView.maximumZoomScale, center: gr.location(in: gr.view)), animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    fileprivate func frameSetting() {
        
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scrollView.frame = rect
        
        imageView.frame = rect
        
        scrollView.contentSize = rect.size
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        frameSetting()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scrollView.setZoomScale(1, animated: false)
    
    }
    
}

extension GalleryImageCollectionViewCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
