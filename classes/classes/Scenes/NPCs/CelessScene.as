package classes.Scenes.NPCs 
{
	import classes.CoC;
	import classes.SaveAwareInterface;
	import classes.TimeAwareInterface;
	/**
	 * ...
	 * @author 
	 */
	public class CelessScene extends NPCAwareContent implements TimeAwareInterface
	{
		private var _age:int;
		private var _corruption:int;
		private var _name:String;
		
		public function CelessScene() 
		{
			CoC.timeAwareClassAdd(this);
			CoC.saveAwareClassAdd(this);
		}
		
		/* INTERFACE classes.TimeAwareInterface */
		
		public function timeChange():Boolean 
		{
			
		}
		
		public function timeChangeLarge():Boolean 
		{
			
		}
		
		public function campInteraction():void{
			
		}
		
	}
}