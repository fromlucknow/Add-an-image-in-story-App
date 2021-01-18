//
//  ViewController.swift
//  Edunomics App
//
//  Created by Saifur Rahman on 15/01/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var storyCollectionView: UICollectionView!
    let picker = UIImagePickerController()
    var dataArray : [UIImage]? {didSet{
        storyCollectionView.reloadData()
    }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
//        layout.estimatedItemSize = CGSize(width: storyCollectionView.frame.height, height: storyCollectionView.frame.width)
        dataArray = []
        layout.scrollDirection = .horizontal
        
        storyCollectionView.collectionViewLayout = layout
        storyCollectionView.collectionViewSetupWithViewC(ViewController: self, cellArrayToRegister: [ImageCollectionViewCell.getCellIdentifier()])
    }
    @IBAction func select_pic(_ sender: Any) {
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func upload_pictureAction(_ sender: Any) {
        if let _ = previewImageView.image{
            dataArray!.append(previewImageView.image!)
            previewImageView.image = nil
        }
        

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        previewImageView.image = image
        self.storyCollectionView.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
}
//extension ViewController:UIImagePickerControllerDelegate{
//
//}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray!.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeIs = CGSize(width: storyCollectionView.frame.height - 10, height: storyCollectionView.frame.height - 10)
        
        return sizeIs
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        print(storyCollectionView.frame.height,cell.frame.height,cell.View_for_image.frame.height)
      //  cell.View_for_image.layer.cornerRadius = (cell.View_for_image.frame.height)/2
        cell.imageView.image = dataArray![indexPath.row]
        cell.View_for_image.backgroundColor = UIColor.red
        cell.contentView.backgroundColor = UIColor.blue
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell,cell == cell1{
            
            cell1.View_for_image.layer.cornerRadius = (cell1.View_for_image.frame.height)/2
        }
    }
    
}
extension UICollectionViewCell
{
    class func getCellIdentifier() -> String
    {
        return String(describing : self)
    }
}
extension UICollectionView{
    func collectionViewSetupWithViewC(ViewController: UIViewController, cellArrayToRegister:[String])
    {
        self.delegate = ViewController as? UICollectionViewDelegate
        self.dataSource = ViewController as? UICollectionViewDataSource
        _ = cellArrayToRegister.map {
            self.register(UINib(nibName: $0, bundle: nil), forCellWithReuseIdentifier: $0)
        }
    }

}
