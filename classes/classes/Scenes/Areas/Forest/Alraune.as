/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Forest 
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.internals.ChainedDrop;

	public class Alraune extends Monster
	{
		
		public function alrauneTeaseAttack():void {
			if (rand(2) == 1) {
				outputText("The alraune parts her grass-like hair away to reveal her supple breasts, moving her other hand to her nectar drenched pussy then back to her mouth. She sensually licks her fingers clean, then blows you a kiss.\n\n", false);
				outputText("\"<i>Don’t you want a taste of what my lovely body can offer? It is all yours to play with, all you need to do is give in to me.</i>\"\n\n", false);
			}
			else {
				outputText("The alraune grabs some of her nectar suggestively, letting it flow all over her breast, thigh and even in her hair.\n\n", false);
				outputText("\"<i>Mmmmmmm I so love being covered in sticky fluids. How about you?</i>\"\n\n", false);
			}
			outputText("Unable to take your gaze away from her lewd show, you feel yourself getting more aroused. ", false);
			var lustDmg:int = rand(player.lib / 10) + 8;
			game.dynStats("lus", lustDmg);
			outputText("\n\n", false);
			combatRoundOver();
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(4);
			if (choice == 0) alrauneTeaseAttack();
			if (choice == 1) alrauneTeaseAttack();
			if (choice == 2) {
			/*	if (!player.hasStatusAffect(StatusAffects.WolfHold) && rand(2) == 0) wolfHold();
				else */alrauneTeaseAttack();
			}
			if (choice == 3) {
			/*	if (!hasStatusAffect(StatusAffects.AbilityCooldown1)) paw();
				else */alrauneTeaseAttack();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.forest.alrauneScene.alrauneDeepwoodsWon();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			game.forest.alrauneScene.alrauneDeepwoodsLost();
		}
		
		public function Alraune() 
		{
			super();
			this.a = "an ";
			this.short = "Alraune";
			this.imageName = "alraune";
			this.long = "You are fighting against an alraune, an intelligent plant with the torso of a woman and the lower body of a giant flower. She seems really keen on raping you.";
			this.createVagina(false, VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_GAPING);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = rand(14) + 59;
			this.hipRating = HIP_RATING_CURVY+3;
			this.buttRating = BUTT_RATING_EXPANSIVE;
			this.lowerBody = LOWER_BODY_TYPE_PLANT_FLOWER;
			this.skinTone = "light green";
			this.hairColor = "dark green";
			this.hairLength = 6;
			initStrTouSpeInte(10, 110, 10, 40);
			initLibSensCor(80, 50, 0);
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.weaponAttack = 1 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "skin";
			this.armorDef = 45 + (5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 100;
			this.bonusLust = 20;
			this.lust = 20 + rand(40);
			this.lustVuln = 0.2;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 20;
			this.gems = rand(20) + 5;
			this.drop = new ChainedDrop().add(consumables.MARAFRU, 1 / 6)
				//	.add(consumables.W__BOOK, 1 / 4)
				//	.add(consumables.BEEHONY, 1 / 2)
				//	.elseDrop(useables.B_CHITN);
		//	this.antennae = ANTENNAE_BEE;
		//	this.wingType = WING_TYPE_BEE_LIKE_SMALL;
		//	this.tailType = TAIL_TYPE_BEE_ABDOMEN;
			this.createStatusAffect(StatusAffects.GenericRunDisabled, 0, 0, 0, 0);
			this.str += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 22 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 16 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 500;//x10
			checkMonster();
		}
		
	}

}