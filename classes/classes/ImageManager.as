package classes
{
	import flash.display.Loader;
	import flash.display.Stage;
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
		
		//The magic embedding sauce. Skips around sandbox issue by embedding the
		//xml into the swf. Makes it possible to load images even from a browser.
		[Embed(source="../../img/images.xml",mimeType="application/octet-stream")]
		private static const XML_IMAGES:Class;
		
		public function ImageManager()
		{
			trace("Creating Image File hashmap");
			loadImageList();
		}
		
		public function loadImageList():void
		{			
			var imgList:XML = new XML(new XML_IMAGES);
			var imgLoader:Loader;
			
			for (var i:int = 0; i < imgList.*.length(); i++)
			{
				imgLoader = new Loader();
				imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, fileLoaded);
				imgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, fileNotFound);
				var req:URLRequest = new URLRequest(imgList.Image[i]);
				//trace("Loading: ", imgList.Image[i]);
				//trace("URLRequest = ", req);
				imgLoader.load(req);				
			}
		}
		
		private function fileLoaded(e:Event):void
		{
			var extImage:Image;
			// split the image name out from the image path.
			var urlPattern:RegExp = /\/+img\/+(.*)\.\w+/
			var url:String = e.target.url;
			var result:Object = urlPattern.exec(url);
			
			//trace("Raw String", url, "Regex out = ", result);
			//trace("pic url: ", result[0], ", pic ID: ", result[1]);
			// result[0]: pic url, result[1]: pic ID
			extImage = new Image(result[1], '.' + result[0], e.target.width, e.target.height);
			_imageTable[extImage.id] = extImage;
		}
		
		private function fileNotFound(e:IOErrorEvent):void
		{
			//trace("File not Found: " + e);
		}
		
		public function getLoadedImageCount():int
		{
			var cnt:int=0;
			for (var s:String in _imageTable) cnt++;
			return cnt;
		}
		
		// Find the image data for the given image URL and return the displayed height
		public function getImageHeight(imageURL:String):int
		{
			// Slice off the leading directories and extension to get the image name
			var startSlice:int = imageURL.lastIndexOf('/') + 1;
			var endSlice:int = imageURL.lastIndexOf('.');
			var imageIdent:String = imageURL.slice(startSlice, endSlice);
			
			var imageTarget:Image = _imageTable[imageIdent];
			
			if (imageTarget == null)
			{
				return 1;
			}
			else
			{
				var ratio:Number = imageTarget.width / imageTarget.height;
				
				// Image resized vertically
				if (ratio >= 1)
				{
					return Math.ceil(imageTarget.height * (MAXSIZE / imageTarget.width));
				}
				// Image was scaled horizontally, return max height
				else
				{
					return MAXSIZE;
				}
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
						imageString = "<img src='" + image.url + "' width='" + MAXSIZE + "' height='" + Math.ceil(image.height * scaler) + "' align='" + align + "' id='img'>";
					}
					else
					{
						scaler = MAXSIZE / image.height;
						imageString = "<img src='" + image.url + "' width='" + Math.ceil(image.width * scaler) + "' height='" + MAXSIZE + "' align='" + align + "' id='img'>";
					}
				}
			}
			trace("Loading image: " + imageID + ", html: " + imageString);
			return imageString;
		}
	}
}