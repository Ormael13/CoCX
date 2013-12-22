package classes.Monsters
{
	import classes.Cock;
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class DemonPack extends Monster
	{
		

		public function DemonPack(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("DemonPack Constructor!");
			init1Names("the ", "demons", "demonmob", "The group is composed of roughly twenty tan-skinned demons, mostly humanoid in shape with many and varied corruptions across the mob. You see demonic high heels, twisting horns and swinging cocks of all shapes and sizes. There even seems to be a bull head in there somewhere. You also make out plenty of breasts ranging from tiny ones to a pair that requires a second person to carry them, and with those breasts a wide range of pussies, dripping and dry, sometimes nestled below some form of demonic dick.  The small tribe carries no weapons and what little clothing they wear is well-shredded, except for one hefty male wearing a cloak of what appears to be snakeskin across his broad shoulders." + (mainClassPtr.silly() ? "  You spot an odd patch that reads, \"<i>41st Engineer Company: Vaginal Clearance</i>\" on his shoulder." : ""),true);
			init2Male([new Cock(18,2),new Cock(18,2)],0,1,3);
			init2Female(VAGINA_WETNESS_SLICK,VAGINA_LOOSENESS_LOOSE);
			init4Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_SLIME_DROOLING);

			this.temperment = 3;
			//Regular attack
			this.special1 = 5043;
			//Lust attack
			this.special2 = 5044;


			//Clothing/Armor
			this.armorName = "demonic skin";
			this.weaponName = "claws";
			this.weaponVerb = "claw";

			//Primary stats
			this.str = 80;
			this.tou = 10;
			this.spe = 10;
			this.inte = 5;
			this.lib = 50;
			this.sens = 60;
			this.cor = 20;

			//Combat Stats
			this.bonusHP = 200;
			this.HP = eMaxHP();
			this.lust = 30;

			//Level Stats
			this.level = 6;
			this.XP = this.totalXP(mainClassPtr.player.level);
			this.gems = rand(25)+10;

			//Appearance Variables
			this.tallness = rand(8) + 70;
			this.hairColor = "black";
			this.hairLength = 15;

			this.skinTone = "red";
			this.skinDesc = "skin";

			this.hornType = HORNS_DEMON;

			this.tailType = TAIL_TYPE_DEMONIC;

			this.hipRating = 8;

			this.buttRating = 8;
			//Create imp sex attributes

		}

	}

}