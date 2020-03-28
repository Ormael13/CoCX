package classes.Scenes.Quests.UrtaQuest
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.Scenes.Monsters.AbstractSuccubus;
import classes.Scenes.SceneLib;

use namespace CoC;
	
	public class MilkySuccubus extends AbstractSuccubus
	{

		override protected function performCombatAction():void
		{
			if (!hasStatusEffect(StatusEffects.MilkyUrta) && rand(3) == 0) cowCubiMilkSprayAttack();
			else if (HP < 400) drinkMinoCum();
			else if (player.HP < 100) eAttack();
			else if (player.lust >= 90) succubusTease();
			else if (rand(2) == 0) succubusTease();
			else eAttack();
		}

		private function cowCubiMilkSprayAttack():void
		{
			//Lasts a couple turns like the goblin lust poison?
			outputText("\"<i>How about a taste?</i>\"  The succubus asks, pressing her tits together.  Before you can reply, a veritable jet of milk sprays in your direction!\n");
//Miss:
			if (rand(20) + 1 + player.spe / 20 > 17) {
				outputText("With your trained reflexes, you manage to duck and roll, narrowly avoiding getting sprayed with milk.");
				outputText("\n\n\"<i>Such a waste.</i>\"  The succubus pouts.  \"<i>No worries, I'll just have Fido clean it up later... perhaps I'll even have you do it later, when you become mine.</i>\"  The succubus giggles.");
				player.dynStats("lus", 6);
			}
			//Hit:
			else {
				outputText("All you manage to do is cover your face; the rest of you, however, gets completely soaked in the demon's corrupted milk.  Looking down at yourself, you realize that you are panting, and the places where the milk splashed your fur begin to heat up.  Oh no! <b>You'd better finish off this succubus before you succumb to your lusts!</b>");
				player.dynStats("lus", 15);
				createStatusEffect(StatusEffects.MilkyUrta, 3, 0, 0, 0);
			}
		}

		private function drinkMinoCum():void
		{
			outputText("Smiling wryly and licking her lips, the succubus-cow procures a bottle of her pet's cum with her probing tail.");
//Success:
			if (!hasStatusEffect(StatusEffects.DrankMinoCum) || !hasStatusEffect(StatusEffects.DrankMinoCum2)) {
				outputText("\n\nSmiling triumphantly, she takes the bottle and opens it with a pop, drinking the contents with glee.  When done, she throws the bottle away and smacks her lips.  \"<i>Nothing like a bottle of minotaur cum to get you back on your feet, right?</i>\"  She grins, her pussy dripping with more juices.");
				addHP(400);
				lust += 25;
				if (!hasStatusEffect(StatusEffects.DrankMinoCum)) createStatusEffect(StatusEffects.DrankMinoCum, 0, 0, 0, 0);
				else createStatusEffect(StatusEffects.DrankMinoCum2, 0, 0, 0, 0);
			}
			//Failure:
			else {
				outputText("\n\nShe frowns and looks behind her, pouting slightly when she turns to look back at you.  \"<i>Seems like I'm all out of cum.</i>\"  She grins evilly.  \"<i>I'll just have to get more after I'm done with you.</i>\"");
			}
		}

		private function succubusTease():void
		{
			if (rand(4) == 0) outputText("Turning around, the succubus begins to bounce her rather round derriere in your direction, the cheeks lewdly clapping together with each change in direction, exposing her dark anal star and juicy snatch, literally gushing forth a stream of lubricants.  Her eyes glow with faint, purple light as she whispers, \"<i>Don't you just want to... slide on in?</i>\"");
			else if (rand(3) == 0) outputText("The succubus squeezes her spotted, sweat-oiled breasts together, squirting out trickles of fresh, creamy, succubi milk.  Bending down, she laps at her own bounty, taking to meet your eyes, her own glowing violet.  You can feel her next words as much as hear them, reaching into your brain and stirring a familiar heat in your loins.  \"<i>Giving in would mean pleasure unending, my dear vixen.</i>\"");
			else if (rand(2) == 0) outputText("The succubus turns slightly and slowly bends over, sliding her hands down the sides of her milk laden jugs. \"<i>Mmm, would you help a poor girl relax? These things need some attention,</i>\" she says with a lust filled moan as her hands reach her multitude of nipples.");
			else outputText("The succubus leans forwards holding her tits, while wrapping her fingers around her nipples.  \"<i>My boobs are soo full.  Would you like to help me drain them?</i>\" she says with a husky voice.");
			player.dynStats("lus", 20);
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.urtaQuest.urtaBeatsUpCowcubi();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.urtaQuest.urtaLosesToCowCubi();
		}


		override public function teased(lustDelta:Number, isNotSilent:Boolean = true):void
		{
			outputText(capitalA + short + " smiles, rubbing her hands across herself as she watches your display.  She does not seem greatly affected by your show - at least in the sense of increasing arousal.  She does seem oddly more... vital, as if she drew strength from the very display you put on.");
			str += 5;
			addHP(50);
			applyTease(lustDelta);
		}

		public function MilkySuccubus()
		{
			this.a = "the ";
			this.short = "milky succubus";
			this.imageName = "milkysuccubus";
			this.long = "You are fighting a milky, cow-like succubus.  She stands about seven feet tall and is hugely voluptuous, with breasts three times the size of her head, tipped with a cluster of four obscenely teat-like nipples.  Her hips flare out into an exaggerated hourglass shape, with a long tail tipped with a fleshy arrow-head spade that waves above her spankable butt.  A small cowbell is tied at the base of the arrow-head with a cute little ribbon.  Wide, cow-like horns, easily appropriate for a minotaur, rise from her head, and she flicks bovine ears about the sides of her head whilst sashaying from side to side on demonic, high-heeled feet.  Her skin is a vibrant purple with splotches of shiny black here and there, including one large spot covering her right eye.  She's using a leather whip as a weapon.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 300, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("G"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = 84;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
			this.skinTone = "blue";
			this.hairColor = "black";
			this.hairLength = 13;
			initStrTouSpeInte(130, 100, 180, 120);
			initWisLibSensCor(120, 150, 60, 100);
			this.weaponName = "whip";
			this.weaponVerb="whipping";
			this.weaponAttack = 34;
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.armorDef = 22;
			this.armorMDef = 2;
			this.bonusHP = 700;
			this.bonusLust = 40;
			this.lust = 40;
			this.lustVuln = .3;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 31;
			this.gems = rand(40)+50;
			this.additionalXP = 100;
			this.drop = NO_DROP;
			this.horns.type = Horns.COW_MINOTAUR;
			this.horns.count = 2;
			this.wings.type = Wings.BAT_LIKE_TINY;
			this.wings.desc = "tiny hidden";
			this.tailType = Tail.DEMONIC;
			this.special1 = kissAttack;
			this.special2 = seduceAttack;
			this.special3 = whipAttack;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
