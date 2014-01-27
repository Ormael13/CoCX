package classes
{
	import fl.controls.UIScrollBar;
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.errors.IOError;
	import flash.net.*;
	import flash.events.*;
	import classes.Image;

	import flash.system.Security;
	import flash.text.TextField;
	import flash.text.TextFormat;
		
	/**
	 * ...
	 * @author Yoffy
	 */
	public final class ImageManager
	{
		//Hashmap of all images
		private static var _imageTable:Object = new Object();
		private var mStage:Stage;
		
		//Maximum image box size
		private const MAXSIZE:int = 400;
		
		public var xmlLoadError:Boolean = false;
		
		//The magic embedding sauce. Skips around sandbox issue by embedding the
		//xml into the swf. Makes it possible to load images even from a browser.
		[Embed(source="../../img/images.xml",mimeType="application/octet-stream")]
		private static const XML_IMAGES:Class;
		
		public function ImageManager(stage:Stage)
		{
			mStage = stage;
			if (Security.sandboxType != Security.REMOTE)
			{
				trace("Creating Image File hashmap");
				loadImageList();
			}
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
				imgLoader.load(req);				
			}
			trace("Loading imagelist", imgLoader, req, imgList)
		}
		
		private function fileLoaded(e:Event):void
		{
			var extImage:Image;
			// split the image name out from the image path.
			var urlPattern:RegExp = /\/+img\/+(.*)\.\w+/
			var url:String = e.target.url;
			var result:Object = urlPattern.exec(url);
			
			extImage = new Image(result[1], '.' + result[0], e.target.width, e.target.height);
			_imageTable[extImage.id] = extImage;
			trace("Loaded file", e)
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
			//trace("Loading image: " + imageID + ", html: " + imageString);
			fixupImage();
			return imageString;
		}
		
		// Begin our image fixing code
		private function fixupImage():void
		{
			mStage.addEventListener(Event.ADDED, fixupListener);
		}
		
		// Event listener hooks into the stage to find objects added to the display list at any point in the heirarchy
		private function fixupListener(e:Event):void
		{
			// We're looking for Loader objects -- there /could/ be other types of loaders in future, but right now,
			// the only thing that will create loaders is the mainText field when it parses an <img> tag
			if (e.target is Loader)
			{
				mStage.removeEventListener(Event.ADDED, fixupListener);
				var loader:Loader = e.target as Loader;
				
				// Hook the loader to notify us when the image has finished loading
				// this gaurantees that anything we do to the content of mainText will ONLY happen after a scene's calls
				// to outputText has finished
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, doFixup);
			}
		}
		
		/**
		 * Meat of the image padding fix.
		 * The images XY position is relative to its position inside of the containing TextField. Compare the image.Y + image.height
		 * to the maximal Y position of text in the TextField /once the image has reflowed the text, possibly adding more height to the text.
		 * Handwave the difference in this pixel height as a line count (this could be more accurate by using TextMetrics, but fuck it) and 
		 * add this many blank lines to the text.
		 * Critical point; once the new lines have been added to the text, force an update of the scrollbar UI element (its actually a seperate
		 * UI component that "targets" the TextField, and not actually a part of the TextField itself) to account for the new text height.
		 * 
		 * Handwavey Bullshit Internals:
		 * TextField.htmlText doesn't continually "parse" content added to it, it's done at the end of a frame when the property has changed.
		 * 		(TextField has two internal properties to check its current displayed content after parsing, and what other code has told it to have there,
		 * 	     the difference is only resolved on EVENT.EXIT_FRAME or EVENT.ENTER_FRAME, I'm not sure which but thats basically the mechanic in play)
		 * TextField never directly updates the UIScrollBar, it's kinda the other way around but not really; the UIScrollBar targets a specific DisplayObject
		 * and targets specific properties thereof. It's probably (internally) adding a listener to EVENT.CHANGE which, I believe, will only be fired when
		 * the textfields internal text property is updated (ie not htmlText but the comparison with it). Anything that changes the actual content layout
		 * of the TextField (and thus the maxScrollV property, which tracks the maximum number of lines displayed via the text field) does not fire the event.
		 * 
		 * In summary. ADOBE DURR. This kind of stupid, half-implemented interaction between base UI components is systematic.
		 * @param	e
		 */
		private function doFixup(e:Event):void
		{
			// Remove the Completion event listener
			e.target.removeEventListener(Event.COMPLETE, doFixup);
			var imgRef:Loader = e.target.loader as Loader;
			var mainText:TextField = (mStage.getChildByName("mainView") as MovieClip).mainText as TextField;
			var scrollBar:UIScrollBar = (mStage.getChildByName("mainView") as MovieClip).scrollBar as UIScrollBar;
			
			var imgRefTopY:int = imgRef.getBounds(mainText).y; 							// 272
			var imgHeight:int = getImageHeight(imgRef.contentLoaderInfo.url); 			// 400
			var imgRefBottomY:int = imgRefTopY + imgHeight;
			var totalTextHeight:int = mainText.textHeight; 								// 264 -- Total displayed pixel height of text
			
			if (totalTextHeight > imgRefBottomY)
			{
				// Total displayed text height should be larger than the image
				return;
			}
			
			// Here comes the bullshit... get ready
			var txFormat:TextFormat = mainText.defaultTextFormat;
			var lineHeight:int = txFormat.size as int;
			lineHeight += 4;
			var padLines:int = Math.ceil((imgRefBottomY - totalTextHeight) / lineHeight);
			

			// Generate the paddings
			var padding:String = "";
			for (var i:int = 0; i < padLines; i++)
			{
				padding += "\n";
			}
			mainText.htmlText += padding;
			scrollBar.update();
		}
	}
}
