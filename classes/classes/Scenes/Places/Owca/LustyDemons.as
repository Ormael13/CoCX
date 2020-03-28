/**
 * Created by aimozg on 26.12.13.
 */
package classes.Scenes.Places.Owca
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

public class LustyDemons extends Monster
	{

		override protected function performCombatAction():void
		{
			var storeStr:Number = str;
			str = 70;
			this.weaponAttack *= 0.2;
			createStatusEffect(StatusEffects.Attacks, 4, 0, 0, 0);
			eAttack();
			str = storeStr;
			this.weaponAttack *= 5;
			eAttack();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.owca.defeetVapulasHorde();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nThe demons smile to one at another as they watch your display, then close in...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.owca.loseOrSubmitToVapula();
			}
		}

		override public function teased(lustDelta:Number, isNotSilent:Boolean = true):void
		{
			if(lustDelta > 0 && lustDelta < 5) outputText("  The demons lessen somewhat in the intensity of their attack, and some even eye up your assets as they strike at you. Vapula has trouble giving her orders.");
			if(lustDelta >= 5 && lustDelta < 10) outputText("  The demons are obviously avoiding damaging anything you might use to fuck and they're starting to leave their hands on you just a little longer after each blow.  Some are copping quick feels and you can smell the demonic lust on the air.  Vapula is starting to get frustrated as her minions are more and more reluctant to attack you, preferring to caress each other instead.");
			if(lustDelta >= 10) outputText("  The demons are decreasingly willing to hit you and more and more willing to just stroke their hands sensuously over you.  Vapula is uncontrollably aroused herself and shivers even as she tries to maintain some semblance of offense, but most of the demons are visibly uncomfortable and some just lie on the ground, tamed by their own lust.");
			applyTease(lustDelta);
		}

		public function LustyDemons()
		{
			this.a = "the ";
			this.short = "lusty demons";
			this.imageName = "demonmob";
			this.long = "You're facing a group of thirty demons of various kinds.  Imps, incubi and succubi of all sizes and colors are encircling you, doing their best to show their genitals or their gigantic rows of breasts, often both.  You can see an impressive number of towering cocks, drooling pussies, and jiggling tits wiggle around as they move.  Most of the genitalia are monstrous, ridiculously disproportionate to the actual demons sporting them - to say nothing of the imps!  Some of the succubi are winking at you, blowing invisible kisses as they dance in circles around your pole.  Among them, you can easily spot the tallest demoness of the horde, Vapula; her perfect purple-skinned body, big perky boobs, luscious buttocks, fleshy lips, and seductive stare draw your attention like a magnet.  She's sporting a pair of magnificent wings and her abundant hair gives her face a fierce, lion-like appearance.  While her eyes ravage you with an insatiable hunger, she gives orders with the assurance of a well-established dominatrix.";
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
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(8) + 70;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(180, 100, 10, 10);
			initWisLibSensCor(10, 120, 60, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 4;
			this.armorName = "demonic skin";
			this.armorDef = 8;
			this.armorMDef = 1;
			//6 attacks: 5 from demons (10 damage each), 1 from Vapula (80 damage), 200 gems, 200 xp, 700 hp*/
			this.bonusHP = 1200;
			this.bonusLust = 350;
			this.lust = 30;
			this.lustVuln = .3;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 28;
			this.gems = 500 + rand(250);
			this.special1 = SceneLib.combat.packAttack;
			this.special2 = SceneLib.combat.lustAttack;
			this.tailType = Tail.DEMONIC;
			this.horns.type = Horns.DEMON;
			this.horns.count = 2;
			this.drop = new WeightedDrop().
					add(weapons.PSWHIP,5).
					add(weapons.SUCWHIP,4).
					add(armors.NURSECL,3).
					add(armors.BONSTRP,2).
					add(consumables.IMPFOOD, 1);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			createStatusEffect(StatusEffects.Vapula,0,0,0,0);
			checkMonster();
		}
	}
}
