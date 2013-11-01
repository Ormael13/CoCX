package classes
{
	import flash.net.*;
	import flash.events.*;
	
	/**
	 * ...
	 * @author Yoffy
	 */
	public class ImageManager
	{
		//Hashmap of all images
		private var _imageTable:Object = new Object();
		private var _urlStream:URLStream;
		
		//Maximum image box size
		private const MAXSIZE:int = 400;
		
		public function ImageManager()
		{
			trace("Creating Image File hashmap");
			loadImageList();
		}
		
		public function loadImageList()
		{
			var imgList:XML;
			var loader:URLLoader = new URLLoader();
			loader.load(new URLRequest("./img/images.xml"));
			loader.addEventListener(Event.COMPLETE, processXML);
			
			function processXML(e:Event):void
			{
				imgList = new XML(e.target.data);
				for (var i:int = 0; i < imgList.*.length(); i++)
				{
					var extImage:Image = new Image(imgList.Image[i].@id, imgList.Image[i], imgList.Image[i].@width, imgList.Image[i].@height)
					_imageTable[imgList.Image[i].@id] = extImage;
				}
				trace("SUCCESS: Image hashmap created");
			}
		}
		
		public function showImage(imageID:String, align:String = "left"):String
		{
			var imageString:String = "";
			var image:Image = _imageTable[imageID];

			if (image != null)
			{
				if (align == "left" || align == "right")
				{
					//Scale images down to fit the box
					var ratio:Number = image.width / image.height;
					
					if (ratio >= 1)
					{
						var scaler:Number = MAXSIZE / image.width;
						imageString = "<img src='" + image.url + "' width='" + MAXSIZE + "' height='" + image.height * scaler + "' align='" + align + "'>";
					}
					else
					{
						var scaler:Number = MAXSIZE / image.height;
						imageString = "<img src='" + image.url + "' width='" + image.width * scaler + "' height='" + MAXSIZE + "' align='" + align + "'>";						
					}
				}
			}
			trace("Loading image: " + imageID + ", html: " + imageString);
			return imageString;
		}
	}
}