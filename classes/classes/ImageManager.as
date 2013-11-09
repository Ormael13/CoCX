package classes
{
	import flash.display.Loader;
	import flash.errors.IOError;
	import flash.net.*;
	import flash.events.*;
	import classes.Image;
	
	/**
	 * ...
	 * @author Yoffy
	 */
	public final class ImageManager
	{
		//Hashmap of all images
		private static var _imageTable:Object = new Object();
		
		//Maximum image box size
		private const MAXSIZE:int = 400;
		
		public function ImageManager()
		{
			trace("Creating Image File hashmap");
			loadImageList();
		}
		
		public function loadImageList():void
		{
			var imgList:XML;
			var extImage:Image;
			var imgLoader:Loader;
			var loader:URLLoader = new URLLoader();
			
			try
			{
				loader.addEventListener(Event.COMPLETE, processXML);
				loader.load(new URLRequest("./img/images.xml"));
			}
			catch (error:Error)
			{
				trace("Could not find images.xml");
			}
			
			function processXML(e:Event):void
			{
				imgList = new XML(e.target.data);
				for (var i:int = 0; i < imgList.*.length(); i++)
				{
					imgLoader = new Loader();
					imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, fileFound);
					imgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, fileNotFound);
					imgLoader.load(new URLRequest(imgList.Image[i]));
					
				}
			}
			
			function fileFound(e:Event):void
			{
				var urlPattern:RegExp = /\.\\img\\(.*)\.\w+/
				var url:String = e.target.url;
				var result:Object = urlPattern.exec(url);
				//result[1]: pic url, result[0]: pic ID
				extImage = new Image(result[1], result[0], e.target.width, e.target.height);
				_imageTable[extImage.id] = extImage;
			}
			
			function fileNotFound(e:IOErrorEvent):void
			{
				trace("File not Found: " + e);
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
					var scaler:Number;
					
					if (ratio >= 1)
					{
						scaler = MAXSIZE / image.width;
						imageString = "<img src='" + image.url + "' width='" + MAXSIZE + "' height='" + Math.ceil(image.height * scaler) + "' align='" + align + "'>";
					}
					else
					{
						scaler = MAXSIZE / image.height;
						imageString = "<img src='" + image.url + "' width='" + Math.ceil(image.width * scaler) + "' height='" + MAXSIZE + "' align='" + align + "'>";
					}
				}
			}
			trace("Loading image: " + imageID + ", html: " + imageString);
			return imageString;
		}
	}
}