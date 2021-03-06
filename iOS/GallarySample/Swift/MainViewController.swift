// The MIT License (MIT)
//
// Copyright (c) 2020 Reflect Code Technologies (OPC) Pvt. Ltd. (http://ReflectCode.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software
// and associated documentation files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute,
// sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
// BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit


// Source - http://www.androidauthority.com/how-to-build-an-image-gallery-app-718976/

public class MainViewController : UIViewController {

    var adapter: MyAdapter? = nil
    
    override public func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        var recyclerView: UICollectionView? = imageGalleryViewOutlet // RC-Note : Use correct outlet to UICollectionView
        var layoutManager: UICollectionViewFlowLayout? = UICollectionViewFlowLayout()
        layoutManager!.minimumLineSpacing = CGFloat(8)
        layoutManager!.minimumInteritemSpacing = CGFloat(8)
        layoutManager!.itemSize = CGSize(width: recyclerView!.frame.width * 0.48 , height: 260.0)
        recyclerView!.setCollectionViewLayout( layoutManager!, animated: true)
        recyclerView!.collectionViewLayout.invalidateLayout()
    }
        
    @IBOutlet weak var imageGalleryViewOutlet: UICollectionView!
    private let image_titles: [String?] = ["Img1", "Img2", "Img3", "Img4", "Img5", "Img6", "Img7", "Img8", ]
    private let image_ids: [Int?] = [R.drawable.img1, R.drawable.img2, R.drawable.img3, R.drawable.img4, R.drawable.img5, R.drawable.img6, R.drawable.img7, R.drawable.img8, ]


    // Note - source android method is onCreate()
    // RC Note : Any code refering to UI should be moved to viewDidAppear()
    override public func viewDidLoad(){
        super.viewDidLoad()

        var recyclerView: UICollectionView? = imageGalleryViewOutlet

        var layoutManager: UICollectionViewFlowLayout? = UICollectionViewFlowLayout()

        
        layoutManager!.minimumLineSpacing = CGFloat(8)
        layoutManager!.minimumInteritemSpacing = CGFloat(8)
        layoutManager!.itemSize = CGSize(width: recyclerView!.frame.width * 0.48 , height: 260.0) //RC ToDo-0001 : Update width and height as per cell dimention
        // layoutManager!.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        // layoutManager!.scrollDirection = UICollectionView.ScrollDirection.vertical
        recyclerView!.setCollectionViewLayout( layoutManager!, animated: true)

        var imageInfoListsArray: [ImageData] = prepareData()
        
        adapter = MyAdapter( self, imageInfoListsArray)
        recyclerView!.dataSource = adapter
        
        //RC ToDo-0002 : Check if variable "adapter" is defined at class level scope. 
        recyclerView!.delegate = adapter
        recyclerView!.register( MyAdapter.ViewHolder.self , forCellWithReuseIdentifier: "main_view_cell")

    }


    private func prepareData() -> [ImageData]{

        var theImageArrayList: [ImageData] = Array()
        for i in sequence( first: 0, next: { i in i + 1}).prefix( while: { i in i < image_titles.count }) {
            var imageData: ImageData? = ImageData()
            imageData!.setImage_title(image_titles[i]!)
            imageData!.setImage_ID(image_ids[i]!)

            theImageArrayList.append(imageData!)
        }

        return theImageArrayList
    }
}
