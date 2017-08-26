/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Beach 
{
	import classes.*;
	import classes.internals.WeightedDrop;
	import classes.GlobalFlags.kFLAGS;
	
	public class DemonPackBeach extends Monster
	{
		override protected function performCombatAction():void
		{
			if (rand(2) == 0)
				special1();
			else special2();
		}
		
		override public function teased(lustDelta:Number):void
		{
			outputText("\n");
			if(lustDelta == 0) outputText("\n" + capitalA + short + " seems unimpressed.");
			else if(lustDelta > 0 && lustDelta < 5) outputText("The demons lessen somewhat in the intensity of their attack, and some even eye up your assets as they strike at you.");
			else if(lustDelta >= 5 && lustDelta < 10) outputText("The demons are obviously steering clear from damaging anything you might use to fuck and they're starting to leave their hands on you just a little longer after each blow. Some are starting to cop quick feels with their other hands and you can smell the demonic lust of a dozen bodies on the air.");
			else if(lustDelta >= 10) outputText("The demons are less and less willing to hit you and more and more willing to just stroke their hands sensuously over you. The smell of demonic lust is thick on the air and part of the group just stands there stroking themselves openly.");
			applyTease(lustDelta);
		}
		
		public function DemonPackBeach() 
		{
			this.a = "the ";
			this.short = "beach demons";
			this.imageName = "demonmob";
			this.long= "The group is composed of roughly fifty tan-skinned demons, mostly humanoid in shape with many and varied corruptions across the mob. You see demonic high heels, twisting horns and swinging cocks of all shapes and sizes. There even seems to be a shark head in there somewhere. You also make out plenty of breasts ranging from tiny ones to a pair that requires a second person to carry them, and with those breasts a wide range of pussies, dripping and dry, sometimes nestled below some form of demonic dick.  The small crew carries no weapons and what little clothing they wear is well-shredded, except for one hefty male wearing a cloak of what appears to be snakeskin across his broad shoulders and eye path over his left eye.  You spot an odd patch that reads, \"<i>42nd East Sea Company: Vaginal Clearance</i>\" on his shoulder.";
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createCock(18,2);
			this.createCock(18,2,CockTypesEnum.DEMON);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			this.createVagina(false, VAGINA_WETNESS_SLICK, VAGINA_LOOSENESS_LOOSE);
			createBreastRow(0);
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_SLIME_DROOLING;
			this.tallness = rand(8) + 70;
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(110, 150, 40, 20);
			initLibSensCor(100, 70, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 44 + (9 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "demonic skin";
			this.armorDef = 40 + (5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 200;
			this.bonusLust = 200;
			this.lust = 30;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 30;
			this.gems = rand(60)+20;
			this.drop = new WeightedDrop().addMany(1,
							consumables.SUCMILK,
							consumables.INCUBID,
							consumables.OVIELIX,
							consumables.B__BOOK);
			this.special1 = game.combat.packAttack;
			this.special2 = game.combat.lustAttack;
			this.tailType = TAIL_TYPE_DEMONIC;
			this.hornType = HORNS_DEMON;
			this.horns = 2;
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.str += 33 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 45 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 30 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 4240;
			checkMonster();
		}
		
	}

}