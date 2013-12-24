package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class HarpyMob extends Monster 
	{
		
		public function HarpyMob(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init01Names("the ","harpy horde","harpymob","You are surrounded by a wing of particularly large and muscular harpies, perhaps a dozen of them in total.  All of them are clad in simple brown shifts that give them good camouflage in the mountains, and are using their talon-like claws as weapons against you. While not a great threat to a champion of your ability individually, a whole brood of them together is... something else entirely.",true);
			init02Female(VAGINA_WETNESS_SLAVERING,VAGINA_LOOSENESS_GAPING_WIDE);
			init03BreastRows("B");
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_SLIME_DROOLING);
			init05Body(rand(8) + 70,HIP_RATING_CURVY+2,BUTT_RATING_LARGE);
			init06Skin("red");
			init07Hair("black",15);

			var temperment:int = Monster.TEMPERMENT_LOVE_GRAPPLES;

			var armorName:String = "armor";
			var weaponName:String = "claw";
			var weaponVerb:String = "claw";
			var armorDef:Number = 20;

			var weaponAttack:Number = 10;

			init09PrimaryStats(50,50,120,40,60,45,50);

			var lustVuln:Number = .2;

			var bonusHP:Number = 1000;
			var lust:Number = 20;

			var level:int = 18;
			this.XP = totalXP() + 50;
			var gems:int = rand(25)+140;


			initX_Horns(HORNS_DEMON);

			initX_Tail(TAIL_TYPE_DEMONIC)
			init08Face(faceType,earType,tongueType,eyeType);
			init10Weapon(weaponName,weaponVerb,weaponAttack,weaponPerk,weaponValue);
			init11Armor(armorName,armorDef,armorPerk,armorValue);
			init12Combat(bonusHP,lust,lustVuln,temperment,fatigue);
			init13Level(level,gems);
			initX_Specials(special1,special2,special3);

		}
		
	}

}