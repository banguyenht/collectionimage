//
//  LoadImageViewController.swift
//  ImgCollection
//
//  Created by Ba NH on 6/1/19.
//  Copyright © 2019 Ba NH. All rights reserved.
//

import UIKit

class LoadImageViewController: UIViewController, UICollectionViewDataSource {
    var arrimg: [UIImage]?
    var loadImagDelegate: AddImageDelegate?
    var foodImagePickerController: UIImagePickerController?
    @IBOutlet weak var testImgView: UIImageView!
    @IBOutlet weak var btnpickimg: UIButton!
    @IBOutlet weak var uicollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        uicollection.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imgcell")
        uicollection.dataSource = self
        arrimg = [UIImage]()
         loadImagDelegate = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrimg?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgcell", for: indexPath) as! ImageCollectionViewCell
        cell.imgview.image = arrimg?[indexPath.row]
        return cell
    }
    
    @IBAction func pickAction(_ sender: Any) {
        let pickImagController:UIImagePickerController = UIImagePickerController()
        pickImagController.delegate = self
//        pickImagController.sourceType = .photoLibrary
//        loadImagDelegate = self
        //self.present(pickImagController, animated: true, completion: nil)
        let alChooseImage  = UIAlertController(title: "Choose image", message: "Choose image source", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (UIAlertAction) in
            self.openCamera()
        }
        let photoAction = UIAlertAction(title: "Photo library", style: .default) { (UIAlertAction) in
            self.openPhoto()
        }
        alChooseImage.addAction(cameraAction)
        alChooseImage.addAction(photoAction)
        present(alChooseImage, animated: true)
    }
    private func openCamera(){
        foodImagePickerController = UIImagePickerController()
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            return
        }
        foodImagePickerController?.delegate = self
        foodImagePickerController?.sourceType = .camera
        present(foodImagePickerController!, animated: true)
    }
    
    private func openPhoto(){
        foodImagePickerController = UIImagePickerController()
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        foodImagePickerController?.delegate = self
        foodImagePickerController?.sourceType = .photoLibrary
        present(foodImagePickerController!, animated: true)
    }
}
extension LoadImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageChose = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        testImgView.image = imageChose
        loadImagDelegate?.addImage(image: imageChose)
        dismiss(animated: true, completion: nil)
    }
}

extension LoadImageViewController: AddImageDelegate {
    func addImage(image: UIImage?) {
        if let img = image{
            print("loading image")
            arrimg?.append(img)
            uicollection.reloadData()
        }
    }
}
