package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class Hel extends Monster
	{

		private function helAttack():void {
			var damage:Number;
			//return to combat menu when finished
			doNext(EventParser.playerMenu);
			//Blind dodge change
			if (hasStatusEffect(StatusEffects.Blind) && rand(3) < 1) {
				outputText(capitalA + short + " completely misses you with a blind attack!\n");
			}
			//Determine if dodged!
			else if (player.spe - spe > 0 && int(Math.random() * (((player.spe-spe) / 4) + 80)) > 80) {
				outputText("You nimbly dodge the salamander's massive sword thrust!");
			}
			//Determine if evaded
			else if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s attack.\n");
			}
			//("Misdirection"
			else if (player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				outputText("Using Raphael's teachings, you anticipate and sidestep " + a + short + "' attacks.\n");
			}
			//Determine if cat'ed
			else if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 6) {
				outputText("With your incredible flexibility, you squeeze out of the way of " + a + short + "");
			}
			//Determine damage - str modified by enemy toughness!
			else
			{
				damage = int((str + weaponAttack) - rand(player.tou/2) - player.armorDef/2);
				//No damage
				if(damage <= 0) {
					damage = 0;
					//Due to toughness or amor...
					if(rand(player.armorDef + player.tou) < player.armorDef) outputText("You absorb and deflect every " + weaponVerb + " with your [armor].");
					else outputText("You deflect and block every " + weaponVerb + " " + a + short + " throws at you.");
				}
				//Take Damage
				else outputText("The salamander lunges at you, sword swinging in a high, savage arc.  You attempt to duck her attack, but she suddenly spins about mid-swing, bringing the sword around on a completely different path.  It bites deep into your flesh, sending you stumbling back. ");
				if(damage > 0) {
					if(lustVuln > 0 && (player.armor.name == "barely-decent bondage straps" || player.armor.name == "nothing")) {
						outputText("\n" + capitalA + short + " brushes against your exposed skin and jerks back in surprise, coloring slightly from seeing so much of you revealed. ");
						lust += 5 * lustVuln;
					}
				}
				if(damage > 0) damage = player.takePhysDamage(damage, true);
			}
			
			statScreenRefresh();
			outputText("\n");
		}

		//Attack 2 – Tail Slap (Hit)
		//low dodge chance, lower damage
		private function helAttack2():void {
			var damage:Number;
			//return to combat menu when finished
			doNext(EventParser.playerMenu);
			//Blind dodge change
			if(hasStatusEffect(StatusEffects.Blind) && rand(3) < 1) {
				outputText(capitalA + short + " completely misses you with a blind attack!\n");
				return;
			}
			//Determine if dodged!
			if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 83) {
				outputText("The salamander rushes at you, knocking aside your defensive feint and trying to close the distance between you.  She lashes out at your feet with her tail, and you're only just able to dodge the surprise attack.");
				return;
			}
			//Determine if evaded
			if(player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 5) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s tail-swipe.\n");
				return;
			}
			//("Misdirection"
			if(player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 5 && player.armorName == "red, high-society bodysuit") {
				outputText("Using Raphael's teachings, you anticipate and sidestep " + a + short + "' tail-swipe.\n");
				return;
			}
			//Determine if cat'ed
			if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 3) {
				outputText("With your incredible flexibility, you squeeze out of the way of a tail-swipe!");
				return;
			}
			//Determine damage - str modified by enemy toughness!
			damage = int((str) - rand(player.tou) - player.armorDef);
			if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
			if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
			damage = Math.round(damage);
			//No damage
			if(damage <= 0) {
				damage = 0;
				//Due to toughness or amor...
				if(rand(player.armorDef + player.tou) < player.armorDef) outputText("The salamander's tail-swipe harmlessly deflects off your armor!");
				else outputText("The salamander's tail-swipe hits you but fails to move or damage you.");
			}
			//Take Damage
			else outputText("The salamander rushes at you, knocking aside your defensive feint and sliding in past your guard.  She lashes out at your feet with her tail, and you can feel the heated wake of the fiery appendage on your ensuing fall toward the now-smouldering grass. ");
			if(damage > 0) {
				if(lustVuln > 0 && player.armorName == "barely-decent bondage straps") {
					outputText("\n" + capitalA + short + " brushes against your exposed skin and jerks back in surprise, coloring slightly from seeing so much of you revealed.");
					lust += 5 * lustVuln;
				}
			}
			if(damage > 0) damage = player.takeMagicDamage(damage, true);
			statScreenRefresh();
			outputText("\n");
		}

		private function helCleavage():void {
			//FAIL
			if((player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 6) || (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) || (player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80)) {
				outputText("To your surprise, the salamander suddenly pulls up her top, letting her hefty breasts hang free in the air; her small, bright pink nipples quickly harden from either arousal or temperature.  Before you can take your eyes off her impressive rack, she jumps at you.  One of her scaled arms reaches around your waist, and the other toward your head, but you roll away from her grip and push her bodily away.  She staggers a moment, but then quickly yanks the jangling bikini top back down with a glare.\n");
			}
			//Attack 3 – Lust – Cleavage (Failure)
			else {
				outputText("To your surprise, the salamander suddenly yanks up her top, letting her hefty breasts hang free in the air; her small, bright pink nipples quickly harden from either arousal or temperature.  Before you can take your eyes off her impressive rack, she jumps at you.  One of her scaled arms encircles your waist, and the other forcefully shoves your face into her cleavage.  She jiggles her tits around your face for a moment before you're able to break free, though you can feel a distinct heat rising in your loins.  As quickly as they were revealed, the breasts are concealed again and your opponent is ready for more combat!");
				var lust:Number = 20 + rand(10) + player.sens/10 + rand(player.lib/20);
				player.dynStats("lus", lust);
				//Apply resistance
				lust *= EngineCore.lustPercent()/100;
				//Clean up
				lust = Math.round(lust * 10)/10;
				outputText(" <b>(<font color=\"#ff00ff\">+" + lust + " lust</font>)</b>\n");
			}
		}
		override protected function performCombatAction():void
		{
			trace("Hel Perform Combat Action Called");
			var select:Number = rand(3);
			trace("Selected: " + select);
			switch(select) {
				case 0:
					helAttack();
					break;
				case 1:
					helAttack2();
					break;
				default:
					helCleavage();
					break;
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if(hasStatusEffect(StatusEffects.Sparring)) SceneLib.helFollower.PCBeatsUpSalamanderSparring();
			else SceneLib.helScene.beatUpHel();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nHelia waits it out in stoic silence...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				if(hasStatusEffect(StatusEffects.Sparring)) SceneLib.helFollower.loseToSparringHeliaLikeAButtRapedChump();
				else SceneLib.helScene.loseToSalamander();
			}
		}

		public function Hel()
		{
			if (game.flags[kFLAGS.HEL_TALKED_ABOUT_HER] == 1) {
				this.a = "";
				this.short = "Hel";
			} else {
				this.a = "the ";
				this.short = "salamander";
			}
			this.imageName = "hel";
			this.long = "You are fighting a (literally) smoking hot salamander – a seven foot tall woman with crimson scales covering her legs, back, and forearms, with a tail swishing menacingly behind her, ablaze with a red-hot fire.  Her red hair whips wildly around her slender shoulders, occasionally flitting over her hefty E-cup breasts, only just concealed within a scale-covered bikini top.  Bright red eyes focus on you from an almost-human face as she circles you, ready to close in for the kill.  Her brutal, curved sword is raised to her side, feinting at you between genuine attacks.";
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_NORMAL);
			createStatusEffect(StatusEffects.BonusVCapacity,85,0,0,0);
			createBreastRow(Appearance.breastCupInverse("E+"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,85,0,0,0);
			this.tallness = 90;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.skinTone = "dusky";
			this.hairColor = "red";
			this.hairLength = 13;
			initStrTouSpeInte(90, 80, 75, 60);
			initWisLibSensCor(60, 70, 25, 30);
			this.weaponName = "sword";
			this.weaponVerb="slashing blade";
			this.weaponAttack = 26;
			this.armorName = "scales";
			this.armorDef = 21;
			this.armorPerk = "";
			this.armorValue = 50;
			this.bonusHP = 300;
			this.bonusLust = 20;
			this.lust = 30;
			this.lustVuln = .35;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 21;
			this.gems = 15 + rand(8);
			this.drop = new ChainedDrop().
					add(armors.CHBIKNI,1/20).
					add(weapons.SCIMITR,1/20).
					add(consumables.SALAMFW,0.7);
			this.tailType = Tail.SALAMANDER;
			this.tailRecharge = 0;
			this.createStatusEffect(StatusEffects.Keen, 0, 0, 0, 0);
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
