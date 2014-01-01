package classes.Monsters
{
	import classes.CoC;
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
		

		public function GenericMonstah(game:CoC)
		{
			super(game);
			trace("GenericMonstah Constructor!");
		}

	}

}