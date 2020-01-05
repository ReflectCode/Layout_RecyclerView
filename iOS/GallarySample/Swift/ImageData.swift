
import UIKit


public class ImageData {

    private var image_title: String? = ""
    private var image_id: Int? = 0
    
    open func getImage_title() -> String?{
        return self.image_title
    }

    open func setImage_title(_ image_name: String?) -> Void {
        self.image_title = image_name!
    }

    open func getImage_ID() -> Int?{
        return self.image_id
    }

    open func setImage_ID(_ android_image_url: Int?) -> Void {
        self.image_id = android_image_url!
    }
}
