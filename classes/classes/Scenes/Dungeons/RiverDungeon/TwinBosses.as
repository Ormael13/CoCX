/**
 * ...
 * @author Ormael & Pyromania
 */
package classes.Scenes.Dungeons.RiverDungeon 
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;
import classes.internals.*;

import coc.view.CoCButton;

use namespace CoC;

	public class TwinBosses extends Monster
	{
		public function onisunetwinspellMod():Number {
			var kmods:Number = 1;
			if (hasPerk(PerkLib.Archmage) && inte >= 75) kmods += .3;
			if (hasPerk(PerkLib.Channeling) && inte >= 60) kmods += .2;
			if (hasPerk(PerkLib.GrandArchmage) && inte >= 100) kmods += .4;
			if (hasPerk(PerkLib.JobSorcerer) && inte >= 25) kmods += .1;
			if (hasPerk(PerkLib.Mage) && inte >= 50) kmods += .2;
			if (hasPerk(PerkLib.Spellpower) && inte >= 50) kmods += .1;
			return kmods;
		}
		
		public function onisunetwinsoulskillMod():Number {
			var kmodss:Number = 1;
			if (hasPerk(PerkLib.DaoistApprenticeStage)) kmodss += .3;
			if (hasPerk(PerkLib.DaoistWarriorStage)) kmodss += .6;
			return kmodss;
		}
		
		public function onisunetwinCastsFoxFire():void {
			mana -= 200;
			soulforce -= 108;
			outputText("Holding out his palm, he conjures a blaze of blue flames, dancing across his palm. He casts the flame towards you, the flames twisting mid air to foil your attempts to dodge them.  On contact, the azure fires burst like fireworks, covering the area around you with color and light. ");
			var damage:Number = 0;
			damage += inteligencescalingbonus() * 0.75;
			damage += wisdomscalingbonus() * 0.75;
			damage *= (onisunetwinspellMod() + onisunetwinsoulskillMod());
			damage = Math.round(damage);
			player.takeFireDamage(damage, true);
			outputText(" ");
			var lustDmg:Number = player.lustVuln * ((this.inte / 10) + rand(player.lib + player.cor) / 5);
			lustDmg *= 0.5;
			lustDmg = Math.round(lustDmg);
			player.takeLustDamage(lustDmg, true);
		}
		
		public function onisunetwinCastsComet():void {
			soulforce -= 162;
			outputText("He raises a hand, focusing with intensity.  From above comes a crystalline meteor, which you barely manage to dodge.  The crystal shatters upon contact with the ground, sending a shower of splinters that you cannot avoid. ");
			if (player.isInHeavyArmor() || player.isInAyoArmor()) outputText("Thankfully, your armor manages to absorb most of the impact. ");
			var damage:Number = 0;
			damage += inteligencescalingbonus();
			damage *= onisunetwinsoulskillMod();
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 3;
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.FireShadowAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 0.3;
			if (player.armorPerk != "Heavy" && player.armorPerk != "Light Ayo" && player.armorPerk != "Heavy Ayo" && player.armorPerk != "Ultra Heavy Ayo") damage *= 2;
			damage = Math.round(damage);
			player.takeMagicDamage(damage, true);
		}
		
		private function onisunetwinSealAttack():void
		{
			var resist:int = 0;
			if (player.inte < 30) resist = Math.round(player.inte);
			else resist = 30;
			if (player.hasPerk(PerkLib.Whispered)) resist += 20;
			if ((player.hasPerk(PerkLib.HistoryReligious) || player.hasPerk(PerkLib.PastLifeReligious)) && player.cor < 20) resist += 20 - player.cor;
			var select:int = rand(7);
			//Attack:
			if (select == 0) {
				outputText("The onisune twin darts around you, grinning sly.  He somehow slips in under your reach, and before you can react, draws a small circle on your chest with his fingertip.  As you move to strike again, the flaming runic symbol he left on you glows brightly, and your movements are halted mid-swing.");
				outputText("\n\n\"<i>Junior, you should be careful with that.</i>\"");
				outputText("\n\nDespite your best efforts, every time you attempt to attack him, your muscles recoil involuntarily and prevent you from going through with it.  <b>The onisune twin's spell has sealed your attack!</b>  You'll have to wait for it to wear off before you can use your basic attacks.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 0, 0, 0);
			}
			else if (select == 1) {
				//Tease:
				outputText("You are taken by surprise when the onisune twin appears in front of you out of nowhere, trailing a fingertip down your chest.  He draws a small circle, leaving behind a glowing, sparking rune made of flames.  You suddenly find that all your knowledge of seduction and titillation escapes you.  <b>The onisune twin's spell has sealed your ability to tease!</b>  Seems you won't be getting anyone hot and bothered until it wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 1, 0, 0);
			}
			//Spells:
			else if (select == 2) {
				outputText("\"<i>Oh silly, trying to beat me at my own game are you?</i>\"  the onisune twin says with a smirk, surprising you as he appears right in front of you.  He traces a small circle around your mouth, and you find yourself stricken mute!  You try to remember the arcane gestures to cast your spell and find that you've forgotten them too.  <b>The onisune twin's spell has sealed your magic!</b>  You won't be able to cast any spells until it wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 2, 0, 0);
			}
			//Items:
			else if (select == 3) {
				outputText("\"<i>Tsk tsk, using items?  That's cheating!</i>\"  the onisune twin says as he appears right in front of you, taking you off guard.  His finger traces a small circle on your pouch, leaving behind a glowing rune made of crackling flames.  No matter how hard you try, you can't seem to pry it open.  <b>The onisune twin's spell has sealed your item pouch!</b>  Looks like you won't be using any items until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 3, 0, 0);
			}
			//Run:
			else if (select == 4) {
				outputText("\"<i>Tsk tsk, leaving so soon?</i>\"  the onisune twin says, popping up in front of you suddenly as you attempt to make your escape.  Before you can react, he draws a small circle on your chest with his fingertip, leaving behind a glowing rune made of crackling blue flames.  You try to run the other way, but your [legs] won't budge!\n\n\"<i>Sorry junior, you'll just have to stay and get lectured.</i>\" he says in a strict tone, appearing in front of you again.  <b>The onisune twin's spell prevents your escape!</b>  You'll have to tough it out until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 4, 0, 0);
			}
			//P.Special:
			else if (select == 5) {
				outputText("You jump with surprise as the onisune twin appears in front of you, grinning sly.  As he draws a small circle on your forehead with his fingertip, you find that you suddenly can't remember how to use any of your physical skills!");
				outputText("\n\n\"<i>Oh no junior, </i>I'm<i> the one with all the tricks here.</i>\"");
				outputText("\n\n<b>The onisune twin's spell has sealed your physical skills!</b>  You won't be able to use any of them until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 5, 0, 0);
			}
			//M.Special:
			else {
				outputText("You jump with surprise as the onisune twin appears in front of you, grinning sly.  As he draws a small circle on your forehead with his fingertip, you find that you suddenly can't remember how to use any of your magical skills!");
				outputText("\n\n\"<i>Oh no junior, </i>I'm<i> the one with all the tricks here.</i>\"");
				outputText("\n\n<b>The onisune twin's spell has sealed your magical skills!</b>  You won't be able to use any of them until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 6, 0, 0);
			}
			if (resist >= rand(100)) {
				outputText("\n\nUpon your touch, the seal dissipates, and you are free of the onisune twin's magic!  He frown in disappointment, looking thoroughly irritated, but quickly resumes his coy trickster facade.");
				player.removeStatusEffect(StatusEffects.Sealed);
			}
		}
		
		private function onisunetwinRampage():void {
			if (hasStatusEffect(StatusEffects.AbilityChanneled)) {
				removeStatusEffect(StatusEffects.AbilityChanneled);
				outputText("A terrifying red aura of power shroud his body as he shout a loud thundering war cry and enter a murderous rampage.\n\n");
				createStatusEffect(StatusEffects.OniRampage,12,0,0,0);
			}
			else {
				fatigue += 50;
				outputText("He crouch and lift a leg then another in alternance, stomping the ground as he focus his anger.");
				createStatusEffect(StatusEffects.AbilityChanneled, 0, 0, 0, 0);
			}
		}
		
		override protected function performCombatAction():void
		{
			wrath += 10;
			if (hasStatusEffect(StatusEffects.AbilityChanneled)) onisunetwinRampage();
			var choice:Number = rand(5);
			if (choice == 0) eAttack();
			if (choice == 1) {
				if (!player.hasStatusEffect(StatusEffects.Sealed)) onisunetwinSealAttack();
				else eAttack();
			}
			if (choice == 2) {
				if (!hasStatusEffect(StatusEffects.OniRampage) && fatigue + 50 <= maxFatigue()) onisunetwinRampage();
				else eAttack();
			}
			if (choice > 2) {
				if (rand(3) == 0) {
					if (soulforce >= 162) onisunetwinCastsComet();
					else eAttack();
				}
				else {
					if (mana >= 200 && soulforce >= 108) onisunetwinCastsFoxFire();
					else eAttack();
				}
			}
		}

		override public function postPlayerBusyBtnSpecial(btnSpecial1:CoCButton, btnSpecial2:CoCButton):void{
			if (!player.hasStatusEffect(StatusEffects.MinoKing) && player.companionsInPCParty()) btnSpecial1.show("Dish Helper", SceneLib.dungeons.riverdungeon.dishHelperTB);
			else btnSpecial1.showDisabled("Dish Helper", "You don't have anyone to take care of other twin!");
		}

		private function twinSwitchWithOtherOne():void {
			clearOutput();
			outputText(this.short + " stops his actions defeated.");
			outputText("\n\n\"<i>Tricky one opponent. Need assistance.</i>\"");
			outputText("\n\nHe jumps away before you manage to react and empty spot is occupied in a brink of eye by his twin brother, while the defeated one is recovering at the room side.");
			HP = maxHP();
			lust = 0;
			if (hasStatusEffect(StatusEffects.Stunned)) removeStatusEffect(StatusEffects.Stunned);
			if (hasStatusEffect(StatusEffects.StunnedTornado)) removeStatusEffect(StatusEffects.StunnedTornado);
			if (hasStatusEffect(StatusEffects.InkBlind)) removeStatusEffect(StatusEffects.InkBlind);
			if (hasStatusEffect(StatusEffects.Fascinated)) removeStatusEffect(StatusEffects.Fascinated);
			if (hasStatusEffect(StatusEffects.FrozenSolid)) removeStatusEffect(StatusEffects.InkBlind);
			if (hasStatusEffect(StatusEffects.Sleep)) removeStatusEffect(StatusEffects.InkBlind);
			if (hasStatusEffect(StatusEffects.Polymorphed)) removeStatusEffect(StatusEffects.Polymorphed);
			if (hasStatusEffect(StatusEffects.JabberwockyVenom)) {
				removeStatusEffect(StatusEffects.JabberwockyVenom);
				buff("Poison").remove();
			}
			doNext(SceneLib.combat.combatMenu, false);
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.MinoKing)) {
				player.removeStatusEffect(StatusEffects.MinoKing);
				SceneLib.dungeons.riverdungeon.defeatTwinBosses();
			}
			else {
				if (hpVictory && !player.hasStatusEffect(StatusEffects.MinoKing)) SceneLib.combat.disableEachHelperIfTheyCauseSoftLock();
				twinSwitchWithOtherOne();
			}
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.riverdungeon.defeatedByTwinBosses();
		}
		
		override public function get long():String
		{
			var twinBelow40:Boolean = (HP < maxHP() * 0.4);
			return "You’re facing one of onisune twins. He's wearing a "+
					(twinBelow40?("torn "):"") +
					"white kimono, flickering with magical flames. His left hand is lit up by an aura of blue flames, ready to flare up into gouts of foxfire at a moment’s notice. In his right hand is Oni Tetsubo, foxfire burning at it’s tip." +
					(hasStatusEffect(StatusEffects.OniRampage)?"\n\n<b>Looking at his posture and gaze indicates that he's currently under effect of some sort of rampage state.</b>":"");
		}
		
		public function TwinBosses() 
		{
			this.a = "";
			this.short = "Onisune Twin";
			this.long = "";
			this.createCock(30,5);
			this.balls = 2;
			this.ballSize = 5;
			this.cumMultiplier = 1;
			this.hoursSinceCum = 1000;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 120;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_TIGHT;
			this.bodyColor = "ashen";
			this.hairColor = "metalic silver";
			this.hairLength = 10;
			this.horns.type = Horns.ONI_X2;
			this.horns.count = 2;
			initStrTouSpeInte(380, 450, 560, 420);
			initWisLibSensCor(580, 560, 380, 60);
			this.weaponAttack = 108;
			this.weaponName = "Oni Tetsubo";
			this.weaponVerb="smash";
			this.armorName = "kimono";
			this.armorDef = 150;
			this.armorMDef = 300;
			this.bonusHP = 2000;
			this.bonusLust = 995;
			this.lust = 30;
			this.lustVuln = .8;
			this.level = 55;
			this.gems = 100 + rand(20);
			this.drop = new WeightedDrop().
					add(consumables.FOXJEWL,3).
					add(consumables.ONISAKE,2).
					add(useables.EL_CORE,1);
			this.arms.type = Arms.ONI;
			this.lowerBody = LowerBody.ONI;
			this.tailType = Tail.FOX;
			this.tailCount = 5;
			this.tailRecharge = 0;
			this.createPerk(PerkLib.JobWarrior, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobBrawler, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulApprentice, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulPersonage, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulWarrior, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulSprite, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulScholar, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulGrandmaster, 0, 0, 0, 0);
			this.createPerk(PerkLib.DaoistApprenticeStage, 0, 0, 0, 0);
			this.createPerk(PerkLib.DaoistWarriorStage, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
			this.createPerk(PerkLib.Spellpower, 0, 0, 0, 0);
			this.createPerk(PerkLib.Mage, 0, 0, 0, 0);
			this.createPerk(PerkLib.Channeling, 0, 0, 0, 0);
			this.createPerk(PerkLib.Archmage, 0, 0, 0, 0);
			this.createPerk(PerkLib.GrandArchmage, 0, 0, 0, 0);
			this.createPerk(PerkLib.EpicStrength, 0, 0, 0, 0);
			this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
			this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
