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

package com.reflectcode.demo.recyclerviewdemo;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.RecyclerView;
import java.util.ArrayList;

// Source - http://www.androidauthority.com/how-to-build-an-image-gallery-app-718976/

public class MainActivity extends AppCompatActivity {
    private final String image_titles[] = { "Img1", "Img2", "Img3", "Img4", "Img5", "Img6", "Img7", "Img8", };

    private final Integer image_ids[] = { R.drawable.img1, R.drawable.img2, R.drawable.img3,
            R.drawable.img4, R.drawable.img5, R.drawable.img6, R.drawable.img7, R.drawable.img8, };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        RecyclerView recyclerView = (RecyclerView)findViewById(R.id.imageGalleryView);
        recyclerView.setHasFixedSize(true);

        RecyclerView.LayoutManager layoutManager = new GridLayoutManager(getApplicationContext(),2);

        recyclerView.setLayoutManager(layoutManager);

        ArrayList<ImageData> imageInfoListsArray = prepareData();
        MyAdapter adapter = new MyAdapter(getApplicationContext(), imageInfoListsArray);
        recyclerView.setAdapter(adapter);

    }


    private ArrayList<ImageData> prepareData(){

        ArrayList<ImageData> theImageArrayList = new ArrayList<>();
        for(int i = 0; i< image_titles.length; i++){
            ImageData imageData = new ImageData();
            imageData.setImage_title(image_titles[i]);
            imageData.setImage_ID(image_ids[i]);

            theImageArrayList.add(imageData);
        }

        return theImageArrayList;
    }
}