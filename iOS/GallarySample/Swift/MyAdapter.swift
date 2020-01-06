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

public class MyAdapter : NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private static var Rc_CellRootView: UIView? = UIView()     // Used to store the root view for 'UICollectionViewCell'

    @objc func viewHolder_img_onClick(tapGestureRecognizer: UITapGestureRecognizer){
        //RC ToDo-0004 : Call this method from 'collectionView(_:didSelectItemAt: indexPath)'
        // viewHolder_img_onClick(v)
        RC_Toast.makeText(context: context!, text : "Image clicked", duration: ToastDuration.Short).show()
    }


    @objc func viewHolder_title_onClick(tapGestureRecognizer: UITapGestureRecognizer){
        //RC ToDo-0006 : Call this method from 'collectionView(_:didSelectItemAt: indexPath)'
        // viewHolder_title_onClick(v)
        RC_Toast.makeText(context: context!, text : "Title clicked", duration: ToastDuration.Short).show()
    }


    @IBAction func viewHolder_btnSelect_onClick(_ v: UIView?){
        //RC ToDo-0007 : Call this method from 'collectionView(_:didSelectItemAt: indexPath)'
        //Toast.makeText(context,"Button clicked",Toast.LENGTH_SHORT).show();
        var snb: RC_Snackbar? = RC_Snackbar.make(view: v!, text: "Button clicked", duration: RC_Snackbar.LENGTH_LONG)
        snb!.setAction(text: "Action", delegate: { (v : UIButton) in
            print("RC : Snackbar action clicked")
            RC_Toast.makeText(context: self.context!, text : "Snackbar action clicked", duration: ToastDuration.Short).show()
        })
        
        snb!.show()

    }

    static var ViewHolderCellView: UIView? = UIView()
    private var galleryArrayList: [ImageData] = Array()
    private var context: UIViewController?

    init(_ context: UIViewController?, _ newArrayList: [ImageData]?){
        self.galleryArrayList = newArrayList!
        self.context = context!
        super.init()
        MyAdapter.Rc_CellRootView = createCellView()
        MyAdapter.ViewHolderCellView = createCellView()
    }


    public func createCellView() -> UIView {
        var view: UIView? = UINib(nibName: "cell_layout", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView 
        MyAdapter.Rc_CellRootView = view!
        return view!
    }


    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Function to handle click event on cell
        var viewModel = collectionView.cellForItem(at: indexPath) as! MyAdapter.ViewHolder
        var v = collectionView.cellForItem(at: indexPath)?.backgroundView
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewHolder: MyAdapter.ViewHolder? = collectionView.dequeueReusableCell(withReuseIdentifier: "main_view_cell", for: indexPath) as! MyAdapter.ViewHolder
        let i = indexPath.row
        viewHolder!.title!.text = galleryArrayList[i].getImage_title()
        viewHolder!.img!.contentMode = UIView.ContentMode.scaleAspectFill
        viewHolder!.img!.image = (RC_GetResources.getDrawable((galleryArrayList[i].getImage_ID()!)))
        //Picasso.with(context).load(galleryArrayList.get(i).getImage_ID()).resize(240, 120).into(viewHolder.img);

        viewHolder!.img!.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector( viewHolder_img_onClick(tapGestureRecognizer:) )))
        //RC ToDo-0003 : UITapGestureRecognizer' used, change method signature to - @objc func viewHolder_img_onClick(tapGestureRecognizer: UITapGestureRecognizer) and add the UI control to func hitTest()

        viewHolder!.title!.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector( viewHolder_title_onClick(tapGestureRecognizer:) )))
        //RC ToDo-0005 : UITapGestureRecognizer' used, change method signature to - @objc func viewHolder_title_onClick(tapGestureRecognizer: UITapGestureRecognizer) and add the UI control to func hitTest()

        viewHolder!.btnSelect!.addTarget(self,action:#selector(viewHolder_btnSelect_onClick(_:) ), for: .touchUpInside)
        return viewHolder!
    }


    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryArrayList.count
    }

    //*******************************

    public class ViewHolder : UICollectionViewCell {
        var title: UILabel? = UILabel()
        var img: UIImageView? = UIImageView()
        var btnSelect: UIButton? = nil

        // RC Note : Required to detect the touch event
        override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            guard isUserInteractionEnabled else { return nil }
            guard !isHidden else { return nil }
            guard alpha >= 0.01 else { return nil }
            
            // Add below template code for all controls in cell view which needs to respond to touch event
            // if (self.<<control>>?.point(inside: convert(point, to: <<control>>), with: event))! {
                // return self.<<control>>
            // }
            
            if (self.title?.point(inside: convert(point, to: title), with: event))! {
                return self.title
            }

            if (self.img?.point(inside: convert(point, to: img), with: event))! {
                return self.img
            }

            if (self.btnSelect?.point(inside: convert(point, to: btnSelect), with: event))! {
                return self.btnSelect
            }
            
            return super.hitTest(point, with: event)
        }
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            //fatalError("init(coder:) has not been implemented")
        }
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            let view: UIView? = NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: MyAdapter.Rc_CellRootView )) as! UIView
            self.backgroundView = view

            title = view!.viewWithTag(R.id.title) as? UILabel
            img = view!.viewWithTag(R.id.img) as? UIImageView
            btnSelect = view!.viewWithTag(R.id.btnSelect) as? UIButton
        }

        open func getItemCount() -> Int{
            return 10
        }

    }
}
