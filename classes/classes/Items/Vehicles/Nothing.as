package classes.Items.Vehicles 
{
	import classes.ItemType;
	import classes.Items.Vehicles;
	import classes.Player;
	
	public class Nothing extends Vehicles
	{
		
		public function Nothing() 
		{
			super("novehicle", "novehicle", "nothing", "nothing", 0, 0, 0, "no vehicle", "vehicle");
		}
		
		override public function playerRemove():Vehicles {
			return null; //There is nothing!
		}
	}
}