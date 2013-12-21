package classes 
{
	import classes.Creature;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Yoffy, Fake-Name
	 */
	public class Monster extends Creature 
	{
		
		protected var mainClassPtr:*;
		//For enemies
		public var bonusHP:Number = 0;
		public var long:String = "<b>You have encountered an unitialized monster. Please report this as a bug</b>.";
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
		
		public function Monster(mainClassPtr:*) 
		{
			// trace("Generic Monster Constructor!");
			this.mainClassPtr = mainClassPtr;
		}
		

		public function eMaxHP():Number 
		{
			return this.tou * 2 + 50 + this.bonusHP;
		}

		protected function totalXP(playerLevel:Number=-1):Number 
		{
			if (playerLevel == -1) return mainClassPtr.player.level;
			//Nerf xp gains by 20% per level over.
			var difference:Number = playerLevel - this.level;
			//No bonuses for underlevel!
			if(difference < 0) difference = 0;
			//No craziness for crazy over-level!
			if(difference > 6) difference = 6;
			//First two levels make no difference
			if(difference <= 2) difference = 0;
			else difference -= 2;
			//convert into something we can multiply by
			difference = (5 - difference) * 20 / 100;
			//Super high level folks only get 1 xp!
			if(playerLevel - this.level > 10) return 1;	
			
			return Math.round((this.baseXP() + this.bonusXP()) * difference);
		}
		protected function baseXP():Number 
		{
			var xp:Number = 0;
			var lev:Number = Math.round(this.level);
			switch(lev) {
				case 1:
					xp = 10;
					break;
				case 2:
					xp = 20;
					break;
				case 3:
					xp = 30;
					break;
				case 4:
					xp = 40;
					break;
				case 5:
					xp = 50;
					break;
				case 6:
					xp = 55;
					break;
				case 7:
					xp = 60;
					break;
				case 8:
					xp = 66;
					break;
				case 9:
					xp = 75;
					break;
				case 10:
					xp = 83;
					break;
				case 11:
					xp = 85;
					break;
				case 12:
					xp = 92;
					break;
				case 13:
					xp = 100;
					break;
				case 14:
					xp = 107;
					break;
				case 15:
					xp = 115;
					break;
				case 16:
					xp = 118;
					break;
				case 17:
					xp = 121;
					break;
				case 18:
					xp = 128;
					break;
				case 19:
					xp = 135;
					break;
				case 20:
					xp = 145;
					break;
				default:
					xp = 200;
					break;
			}
			return xp;
		}
		protected function bonusXP():Number 
		{
			var xp:Number = 0;
			var lev:Number = Math.round(this.level);
			switch(lev) {
				case 1:
					xp = 10;
					break;
				case 2:
					xp = 20;
					break;
				case 3:
					xp = 30;
					break;
				case 4:
					xp = 40;
					break;
				case 5:
					xp = 50;
					break;
				case 6:
					xp = 55;
					break;
				case 7:
					xp = 58;
					break;
				case 8:
					xp = 66;
					break;
				case 9:
					xp = 75;
					break;
				case 10:
					xp = 83;
					break;
				case 11:
					xp = 85;
					break;
				case 12:
					xp = 85;
					break;
				case 13:
					xp = 86;
					break;
				case 14:
					xp = 92;
					break;
				case 15:
					xp = 94;
					break;
				case 16:
					xp = 96;
					break;
				case 17:
					xp = 98;
					break;
				case 18:
					xp = 99;
					break;
				case 19:
					xp = 101;
					break;
				case 20:
					xp = 107;
					break;
				default:
					xp = 130;
					break;
			}
			return rand(xp);
		}

	}
}