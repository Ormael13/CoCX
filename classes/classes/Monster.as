package classes 
{
	import classes.creature;
	
	/**
	 * ...
	 * @author Yoffy
	 */
	public class Monster extends creature 
	{
		//For enemies
		public var bonusHP:Number = 0;
		public var long:String = "An imp is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from his head, parted by two four inch long horns.  His eyes are solid black, save for tiny red irises that seem to glow with evil intent.  His skin is bright red, and unencumbered by clothing or armor, save for a small loincloth at his belt.  His feet are covered by tiny wooden sandles, and his hands tipped with sharp claws.";
		public var capitalA:String = "A ";
		//Is a creature a 'plural' encounter - mob, etc. 
		public var plural:Boolean = false;
		public var imageName:String = "";
		
		//Lust vulnerability
		public var lustVuln:Number = 1;
		
		//temperment - used for determining grapple behaviors
		//0 - avoid grapples/break grapple
		//1 - lust determines > 50 grapple
		//2 - random
		//3 - love grapples
		public var temperment:Number = 0;		
		
		//Used for special attacks. Event codes EVERYWHERE
		public var special1:Number = 0;
		public var special2:Number = 0;
		public var special3:Number = 0;
		
		//he
		public var pronoun1:String = "";
		//him
		public var pronoun2:String = "";
		//3: Possessive his 
		public var pronoun3:String = "";
		
		//Head ornaments. Definitely need to convert away from hard coded types.
		public var antennae:Number = 0;
		public var horns:Number = 0;		
		
		public function Monster() 
		{
			
		}
		
	}

}