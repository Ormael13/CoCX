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
		public var xmlLoadError:Boolean = false;
		


		public function ImageManager()
		{
			trace("Creating Image File hashmap");
			loadImageList();
		}
		
		public function loadImageList():void
		{
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, processXML);
			loader.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
			loader.load(new URLRequest("./img/images.xml"));
		}
		
		// you can't catch loader errors with a try/catch
		private function ioErrorHandler(error:IOErrorEvent)
		{
			this.xmlLoadError = true;
			trace("Could not find images.xml");
		}

		private function processXML(e:Event):void
		{
			var imgList:XML;
			var imgLoader:Loader;


			imgList = new XML(e.target.data);
			trace("imglist = ", imgList);
			
			for (var i:int = 0; i < imgList.*.length(); i++)
			{
				imgLoader = new Loader();
				imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, fileLoaded);
				imgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, fileNotFound);
				var req = new URLRequest(imgList.Image[i]);
				trace("Loading: ", imgList.Image[i]);
				trace("URLRequest = ", req);
				imgLoader.load(req);
				
			}
		}
		
		private function fileLoaded(e:Event):void
		{

			var extImage:Image;


			// split the image name out from the image path.
			var urlPattern:RegExp = /\.\/+img\/+(.*)\.\w+/
			var url:String = e.target.url;
			var result:Object = urlPattern.exec(url);
			
			trace("Raw String", url, "Regex out = ", result);
			trace("pic url: ", result[0], ", pic ID: ", result[1]);
			// result[1]: pic url, result[0]: pic ID
			extImage = new Image(result[1], result[0], e.target.width, e.target.height);
			_imageTable[extImage.id] = extImage;
		}
		
		private function fileNotFound(e:IOErrorEvent):void
		{
			trace("File not Found: " + e);
		}
		public function getLoadedImageCount():int
		{
			var cnt:int=0;
			for (var s:String in _imageTable) cnt++;
			return cnt;
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