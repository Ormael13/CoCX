package classes 
{
	/**
	 * ...
	 * @author Yoffy
	 */
	public class Image 
	{
		private var _id:String;
		private var _url:String
		private var _width:int;
		private var _height:int;		
		
		public function Image(id:String, url:String, w:String, h:String) 
		{
			_id = id;
			_url = url;
			_width = int(w);
			_height = int(h);
		}
		
		public function get id():String 
		{
			return _id;
		}
		
		public function get url():String 
		{
			return _url;
		}
		
		public function get width():int 
		{
			return _width;
		}
		
		public function get height():int 
		{
			return _height;
		}
		
	}

}