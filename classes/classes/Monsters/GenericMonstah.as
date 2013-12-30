package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */

	/*
	this class is mostly intended to be copy&pasted as the base for reworking the monsters.
	*/

	public class GenericMonstah extends Monster
	{
		

		public function GenericMonstah(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("GenericMonstah Constructor!");
		}

	}

}