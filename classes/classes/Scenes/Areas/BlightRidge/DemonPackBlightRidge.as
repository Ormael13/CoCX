/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.BlightRidge 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

public class DemonPackBlightRidge extends Monster
	{
		
		override protected function performCombatAction():void
		{
			//Demon pack has different AI
			if (rand(2) == 0) special1();
			else special2();
		}
		
		override public function teased(lustDelta:Number, isNotSilent:Boolean = true):void
		{
			outputText("\n");
			if(lustDelta == 0) outputText("\n" + capitalA + short + " seems unimpressed.");
			else if(lustDelta > 0 && lustDelta < 5) outputText("The demons lessen somewhat in the intensity of their attack, and some even eye up your assets as they strike at you.");
			else if(lustDelta >= 5 && lustDelta < 10) outputText("The demons are obviously steering clear from damaging anything you might use to fuck and they're starting to leave their hands on you just a little longer after each blow. Some are starting to cop quick feels with their other hands and you can smell the demonic lust of a dozen bodies on the air.");
			else if(lustDelta >= 10) outputText("The demons are less and less willing to hit you and more and more willing to just stroke their hands sensuously over you. The smell of demonic lust is thick on the air and part of the group just stands there stroking themselves openly.");
			applyTease(lustDelta);
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			clearOutput();
			outputText("With the demons in front of you defeated, you turn to see that your mystery partner has finished his half as well.");
			postIntroFight();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			clearOutput();
			outputText("You fall, knowing what comes next. But in spite of your expectations, the demons suddenly collapse, one by one. This time you see what happens, flashes of crystal impacting their foreheads, knocking the demons out one by one.  You turn to see your savior.");
			postIntroFight();
		}
		
		public function postIntroFight():void {
			outputText(" This figure, masculine in build, is wearing a hooded traveling cloak over a set of robes. In his right hand is a staff made of grey metal, still burning with azure flames. He turns to face you and flips his hood down, revealing a white-furred vulpine face.  Except, now that you’re getting a proper look at him, you can see he has more than one tail...  a Kitsune! \"<i>I hope i didn’t interrupt anything</i>\" He extends his hand.  Somewhat baffled, you shake it, feeling glad that he’s on your side. \"<i>My name is Ignis, i’m a traveling...  well, a traveler.</i>\" You tell him your name");
			if (flags[kFLAGS.SAND_WITCHES_FRIENDLY] > 0) outputText(", noticing his eyes flash in recognition");
			outputText(". Looking around, a thought suddenly comes to you. Why would a pure traveler be in somewhere as unsavory as blight ridge? \"<i>");
			if (player.cor < 60) outputText("I could ask the same of you. ");
			if (flags[kFLAGS.SAND_WITCHES_FRIENDLY] > 0) outputText("I’m a mercenary in the employ of the sand covens. ");
			outputText("I’ve been investigating reports of new magics being seen amongst demonic covens in this area. I trust you could imagine the consequences if the demon armies got their hands on it?</i>\" You nod solemnly");
			if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) outputText(" picturing the effects of this magic on Tel’Adre’s defenders");
			outputText(".");
			if (player.cocks.length > 0) {
				outputText(" He walks up to you, fondling you");
				if (!player.isNaked()) outputText(" through your armor");
				outputText(" with a mischievous look on his face. \"<i>Well, it seems I did save you from an ambush.  Would you mind if I claim my...  reward?</i>\"");
			//	menu();
			//	addButton(0, "Yes");
			//	addButton(1, "No");
			}
			flags[kFLAGS.IGNIS_ARENA_SEER] = 1;
			cleanupAfterCombat();
		}
		
		public function DemonPackBlightRidge() 
		{
			this.a = "the ";
			this.short = "demons pack";
			this.imageName = "demonmob";
			this.long= "The group is composed of roughly thirty tan-skinned demons, mostly humanoid in shape with many and varied corruptions across the mob. You see demonic high heels, twisting horns and swinging cocks of all shapes and sizes. You also make out plenty of breasts ranging from tiny ones to a pair that requires a second person to carry them, and with those breasts a wide range of pussies, dripping and dry, sometimes nestled below some form of demonic dick.  The small group carries no weapons and what little clothing they wear is well-shredded, except for one hefty male wearing mage cloak and what appears to be snakeskin across his broad shoulders.  You spot an odd patch that reads, \"<i>43rd East Mage Company: Vaginal Clearance</i>\" on his shoulder.";
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
			initStrTouSpeInte(110, 120, 50, 90);
			initWisLibSensCor(70, 70, 70, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 62;
			this.armorName = "demonic skin";
			this.armorDef = 30;
			this.armorMDef = 3;
			this.bonusHP = 500;
			this.bonusLust = 200;
			this.lust = 30;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 30;
			this.gems = rand(40)+70;
			this.drop = new WeightedDrop().addMany(1,
							consumables.SUCMILK,
							consumables.INCUBID,
							consumables.OVIELIX,
							consumables.B__BOOK);
			this.special1 = SceneLib.combat.packAttack;
			this.special2 = SceneLib.combat.lustAttack;
			this.tailType = Tail.DEMONIC;
			this.horns.type = Horns.DEMON;
			this.horns.count = 2;
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}