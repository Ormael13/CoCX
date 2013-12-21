package classes.Monsters 
{
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
			this.short="demons";
			this.imageName="demonmob";
			this.plural = true;
			this.long = "The group is composed of roughly twenty tan-skinned demons, mostly humanoid in shape with many and varied corruptions across the mob. You see demonic high heels, twisting horns and swinging cocks of all shapes and sizes. There even seems to be a bull head in there somewhere. You also make out plenty of breasts ranging from tiny ones to a pair that requires a second person to carry them, and with those breasts a wide range of pussies, dripping and dry, sometimes nestled below some form of demonic dick.  The small tribe carries no weapons and what little clothing they wear is well-shredded, except for one hefty male wearing a cloak of what appears to be snakeskin across his broad shoulders.";
			if(mainClassPtr.silly()) 
				this.long += "  You spot an odd patch that reads, \"<i>41st Engineer Company: Vaginal Clearance</i>\" on his shoulder.";
			this.a ="the ";

			this.temperment = 3;
			//Regular attack
			this.special1 = 5043;
			//Lust attack
			this.special2 = 5044;

			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";

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
			//Gender 1M, 2F, 3H
			this.gender = 3;
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
			this.createCock();
			this.cocks[0].cockLength = 18;
			this.cocks[0].cockThickness = 2;
			this.cocks[0].cockType = CockTypesEnum.HUMAN;
			this.createCock();
			this.cocks[1].cockLength = 18;
			this.cocks[1].cockThickness = 2;
			this.cocks[1].cockType = CockTypesEnum.HUMAN;
			this.createVagina();
			this.vaginas[0].virgin = false;
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLICK;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;

			this.cumMultiplier = 3;
			this.ballSize = 1;
			this.ass.analLooseness = 4;
			this.ass.analWetness = 5;

		}

	}

}