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
			if (player.getEvasionRoll()) {
				outputText("You nimbly dodge the salamander's massive sword thrust!");
			}
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
			//Determine if dodged!
			if(player.getEvasionRoll()) {
				outputText("The salamander rushes at you, knocking aside your defensive feint and trying to close the distance between you.  She lashes out at your feet with her tail, and you're only just able to dodge the surprise attack.");
				return;
			}
			//Determine damage - str modified by enemy toughness!
			damage = int((str) - rand(player.tou) - player.armorDef);
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
			if(damage > 0) damage = player.takeFireDamage(damage, true);
			statScreenRefresh();
			outputText("\n");
		}

		private function helCleavage():void {
			//FAIL
			if(player.getEvasionRoll()) {
				outputText("To your surprise, the salamander suddenly pulls up her top, letting her hefty breasts hang free in the air; her small, bright pink nipples quickly harden from either arousal or temperature.  Before you can take your eyes off her impressive rack, she jumps at you.  One of her scaled arms reaches around your waist, and the other toward your head, but you roll away from her grip and push her bodily away.  She staggers a moment, but then quickly yanks the jangling bikini top back down with a glare.\n");
			}
			//Attack 3 – Lust – Cleavage (Failure)
			else {
				outputText("To your surprise, the salamander suddenly yanks up her top, letting her hefty breasts hang free in the air; her small, bright pink nipples quickly harden from either arousal or temperature.  Before you can take your eyes off her impressive rack, she jumps at you.  One of her scaled arms encircles your waist, and the other forcefully shoves your face into her cleavage.  She jiggles her tits around your face for a moment before you're able to break free, though you can feel a distinct heat rising in your loins.  As quickly as they were revealed, the breasts are concealed again and your opponent is ready for more combat!");
				var lust:Number = 20 + rand(10) + player.effectiveSensitivity()/10 + rand(player.lib/20);
				player.takeLustDamage(lust, true);
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) cleanupAfterCombat();
			else {
				if(hasStatusEffect(StatusEffects.Sparring)) SceneLib.helFollower.PCBeatsUpSalamanderSparring();
				else SceneLib.helScene.beatUpHel(); //mocking goes here too
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) SceneLib.dungeons.riverdungeon.defeatedByMistSalamander();
			else {
				if (pcCameWorms){
					outputText("\n\nHelia waits it out in stoic silence...");
					doNext(SceneLib.combat.endLustLoss);
				} else {
					if(hasStatusEffect(StatusEffects.Sparring)) SceneLib.helFollower.loseToSparringHeliaLikeAButtRapedChump();
					else SceneLib.helScene.loseToSalamander(); //mocking goes here too
				}
			}
		}

		public function Hel()
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				this.a = "the ";
				this.short = "mist salamander";
				this.long = "You are fighting a (literally) smoking hot mist salamander – a seven foot tall woman with crimson scales covering her legs, back, and forearms, purple veins covering all unprotected by scales parts fo the body, with a tail swishing menacingly behind her, ablaze with a red-hot fire.  Her violet hair whips wildly around her slender shoulders, occasionally flitting over her hefty E-cup breasts, only just concealed within a scale-covered bikini top.  Bright purple eyes focus on you from an almost-human face as she circles you, ready to close in for the kill.  Her brutal, curved sword is raised to her side, feinting at you between genuine attacks.";
				this.hairColor = "violet";
				initStrTouSpeInte(480, 440, 410, 240);
				initWisLibSensCor(240, 280, 150, -60);
				this.weaponAttack = 52;
				this.armorDef = 176;
				this.armorMDef = 24;
				this.bonusHP = 2400;
				this.bonusLust = 489;
				this.level = 54;
				this.gems = 75 + rand(12);
				this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
				this.drop = new ChainedDrop().
						add(weapons.SCIMITR, 0.3).
						add(consumables.SALAMFW, 0.7).
						add(useables.PCSHARD, 1);
			}
			else {
				if (game.flags[kFLAGS.HEL_TALKED_ABOUT_HER] == 1) {
					this.a = "";
					this.short = "Hel";
				} else {
					this.a = "the ";
					this.short = "salamander";
				}
				this.long = "You are fighting a (literally) smoking hot salamander – a seven foot tall woman with crimson scales covering her legs, back, and forearms, with a tail swishing menacingly behind her, ablaze with a red-hot fire.  Her red hair whips wildly around her slender shoulders, occasionally flitting over her hefty E-cup breasts, only just concealed within a scale-covered bikini top.  Bright red eyes focus on you from an almost-human face as she circles you, ready to close in for the kill.  Her brutal, curved sword is raised to her side, feinting at you between genuine attacks.";
				this.hairColor = "red";
				initStrTouSpeInte(90, 80, 75, 60);
				initWisLibSensCor(60, 70, 25, -60);
				this.weaponAttack = 26;
				this.armorDef = 22;
				this.armorMDef = 3;
				this.bonusHP = 300;
				this.bonusLust = 116;
				this.level = 21;
				this.gems = 15 + rand(8);
				this.drop = new ChainedDrop().
						add(armors.CHBIKNI,1/20).
						add(weapons.SCIMITR,1/20).
						add(consumables.SALAMFW,0.7);
			}
			this.imageName = "hel";
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_NORMAL);
			createStatusEffect(StatusEffects.BonusVCapacity,85,0,0,0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,85,0,0,0);
			this.tallness = 84;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.bodyColor = "dusky";
			this.hairLength = 13;
			this.weaponName = "sword";
			this.weaponVerb="slashing blade";
			this.armorName = "scales";
			this.armorPerk = "";
			this.armorValue = 50;
			this.lust = 30;
			this.lustVuln = .35;
			this.noFetishDrop = true;
			this.tailType = Tail.SALAMANDER;
			this.tailRecharge = 0;
			this.createStatusEffect(StatusEffects.Keen, 0, 0, 0, 0);
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			this.abilities = [
				{call: helAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_WEAPON]},
				{call: helAttack2, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_WEAPON]},
				{call: helCleavage, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[]},
			];
			checkMonster();
		}
		
	}

}
