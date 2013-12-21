package classes.Monsters
{
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kFLAGS;

	/**
	 * ...
	 * @author aimozg
	 */
	public class Kitsune extends Monster
	{

		public function Kitsune(mainClassPtr:*, hairColor:String)
		{
			super(mainClassPtr);
			this.hairColor = hairColor;

			if (rand(3) != 2) mainClassPtr.flags[kFLAGS.redheadIsFuta] = 1;
			init1Names("a ", "kitsune", "kitsune",
					"A kitsune stands in front of you, about five and a half feet tall.  She has a head of " + ({
						"blonde": "long flaxen",
						"black": "lustrous, ass-length black",
						"red": "unkempt, shoulder-length reddish"
					}[hairColor]) +
							" hair.  She appears mostly human, except for a pair of large, furry ears poking through her hair and six luxurious silky tails swaying in the air behind her.  Her robes are revealing but comfortable-looking, hugging her voluptuous curves and exposing large swaths of tattooed skin.  A layer of ornate tattoos covers patches of her exposed flesh, accentuating her feminine curves nicely, and each movement brings a pleasant jiggle from her plump backside and large breasts.");
			if (hairColor=="red" && mainClassPtr.flags[kFLAGS.redheadIsFuta] == 1) {
				init2Male(new Cock(rand(13) + 14,1.5 + rand(20)/2,CockTypesEnum.HUMAN),
						2,2 + rand(13),1.5,mainClassPtr.player.ballSize * 10);
			}
			init2Female(VAGINA_WETNESS_SLICK,VAGINA_LOOSENESS_NORMAL,20);

			this.temperment = 1;
			this.special1 = 5029;

			//Clothing/Armor
			this.armorName = "skin";
			this.weaponName = "claws";
			this.weaponVerb = "punch";

			//Primary stats
			this.str = 35;
			this.tou = 45;
			this.spe = 90;
			this.inte = 95;
			this.lib = 60;
			this.sens = 65;
			this.cor = 45;

			this.lust = 20;

			this.lustVuln = 0.9;
			//Combat Stats
			this.bonusHP = 120;
			this.HP = eMaxHP();

			//Level Stats
			this.level = 6;
			this.XP = totalXP();
			this.gems = rand(10) + 10;

			//Appearance Variables
			this.tallness = rand(24) + 60;

			this.hairLength = 13 + rand(20);

			this.skinTone = "pale";
			this.skinDesc = "skin";

			//3 - cowface
			this.faceType = FACE_COW_MINOTAUR;

			//7 - cow!
			this.tailType = TAIL_TYPE_FOX;

			this.hipRating = 6;

			this.buttRating = 5;
			//Create imp sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 4;
			this.breastRows[0].nipplesPerBreast = 1;
			this.ass.analLooseness = 1;
			this.ass.analWetness = 1;
			this.createStatusAffect("Bonus vCapacity", 20, 0, 0, 0);
			this.createStatusAffect("Bonus aCapacity", 20, 0, 0, 0);
		}

	}

}