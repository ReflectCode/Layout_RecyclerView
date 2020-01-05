<h1 align="center">
  <a href="http://www.reflectcode.com">
    ReflectCode
  </a>
</h1>
<p align="center">
  <strong>Automated Source Code Transformation service</strong><br>
  <strong>Re-cycle / Re-use / Re-purpose</strong><br>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green" alt="Platform - Android | iOS" />
  <a href="https://twitter.com/intent/follow?screen_name=reflectcode">
    <img src="https://img.shields.io/twitter/follow/reflectcode.svg?label=Follow%20@reflectcode" alt="Follow @reflectcode" />
  </a>
</p>


-----
# RecyclerView + Toast + Snackbar + R.java (Resources)
This project demonstrates the conversion of RecyclerView Layout to iOS UICollectionView.
This repository contains the Android source code which was used as input and generated iOS source code project.
 
| Class | Package |
|---------|------------|
| RecyclerView | android.support.v7.widget.RecyclerView | 
| GridLayoutManager | android.support.v7.widget.GridLayoutManager| 
| Snackbar | android.support.design.widget.Snackbar| 
| Toast | android.widget.Toast| 
| ArrayList | java.util.ArrayList| 
| R | Resources | 


## Statement Estimation
| File | Statement |
|---------|------------|
| ImageData.java | 16 |
| MainActivity.java | 67 |
| MyAdapter.java | 90 |
| activity_main.xml | 393 |
| cell_layout.xml | 249 |
| Resource xml | 48 |
| Images | 120 |
| **Total** | **1437** |


## Dev Notes

* Credits for Android project - http://www.androidauthority.com/how-to-build-an-image-gallery-app-718976/

* **RecyclerView**

For RecyclerView on iOS side 'UICollectionView' is used. The 'cell_layout.xml' from android project is ported to xib file and used as layout for the 'UICollectionViewCell'
To handle button tap event addTarget() is used. UILabel and UIImageView do not have addTarget(), for these controls 'UITapGestureRecognizer' is assigned

* **Snackbar**

Swift implementation of android 'Snackbar' control is provided using custom lib 'RC_Snackbar.swift' developed by ReflectCode

* **Toast**

Swift implementation of android 'Toast' control is provided using custom lib 'RC_toast.swift' developed by ReflectCode

* **Resources**

During compilation Android creates R.java providing good type-safety. 
Taking inspiration from [R.swift lib](https://github.com/mac-cain13/R.swift), RC generates 'R.swift' file which provide type-safe access to all the resources.
To access the resources 'RC_GetResources.swift' provides various methods which are inlined with android 'Resources' class


## Screen shots

<img src="/Visuals/Side-by-Side-Small.gif" alt="Side-by-Side-Video"/>

-----

<img src="/Visuals/ScreenShot-01.png" alt="ScreenShot-01"/>

-----

<img src="/Visuals/ScreenShot-02.png" alt="ScreenShot-02"/>

-----

<img src="/Visuals/ScreenShot-03.png" alt="ScreenShot-03"/>

-----


## License

This project is made available under the MIT license. See the LICENSE file for more details.
