package classes 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class room 
	{
		public function room() 
		{
			
		}
		
		public var RoomName:String; // Index name
		public var RoomDisplayName:String; // Header text
		
		public var NorthExit:String;
		public var NorthExitCondition:Function;
		public var NorthExitTime:int = 0;
		
		public var EastExit:String;
		public var EastExitCondition:Function;
		public var EastExitTime:int = 0;
		
		public var SouthExit:String;
		public var SouthExitCondition:Function;
		public var SouthExitTime:int = 0;
		
		public var WestExit:String;
		public var WestExitCondition:Function;
		public var WestExitTime:int = 0;
		
		public var RoomFunction:Function;
	}
}