package classes 
{
	/**
	 * ...
	 * @author Fake-Name
	 */
	public class CoC_Settings
	{
		// Horrible static abuse FTW
		public static var haltOnErrors:Boolean = false;
		public static var buttonEvents:Array = new Array();
		
		private static const bufferSize:int = 50;
		
		public static function appendButtonEvent(inString:String):void
		{
			
			CoC_Settings.buttonEvents.unshift(inString);  // Push the new item onto the head of the array

			if (CoC_Settings.buttonEvents.length > CoC_Settings.bufferSize)  // if the array has become too long, pop the last item
				CoC_Settings.buttonEvents.pop();
		}
		
		public function CoC_Settings()
		{

		}
		
	}

}