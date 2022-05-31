/**
 * ...
 * @author ...
 */
package classes.Scenes.Explore 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.internals.*;

	public class KitsuneAncestor extends Monster
	{
		public function kitsunespellMod():Number {
			var kmods:Number = 1;
			var kmods2:Number = 1;
			if (hasPerk(PerkLib.Archmage) && inte >= 75) kmods += .3;
			if (hasPerk(PerkLib.Channeling) && inte >= 60) kmods += .2;
			if (hasPerk(PerkLib.GrandArchmage) && inte >= 100) kmods += .4;
			if (hasPerk(PerkLib.GrandGreyArchmage) && inte >= 225) kmods2 += .4;
			if (hasPerk(PerkLib.GreyArchmage) && inte >= 175) kmods2 += .3;
			if (hasPerk(PerkLib.GreyMage) && inte >= 125) kmods2 += .2;
			if (hasPerk(PerkLib.GreyMageApprentice) && inte >= 75) kmods2 += .1;
			if (hasPerk(PerkLib.JobSorcerer) && inte >= 25) kmods += .1;
			if (hasPerk(PerkLib.Mage) && inte >= 50) kmods += .2;
			if (hasPerk(PerkLib.Spellpower) && inte >= 50) kmods += .1;
			kmods *= kmods2;
			return kmods;
		}
		
		public function kitsunesoulskillMod():Number {
			var kmodss:Number = 1;
			if (hasPerk(PerkLib.DaoistCultivator) && wis >= 20) kmodss += .2;
			if (hasPerk(PerkLib.DaoistApprenticeStage)) kmodss += .12;
			if (hasPerk(PerkLib.DaoistWarriorStage)) kmodss += 1.8;
			if (hasPerk(PerkLib.DaoistElderStage)) kmodss += 2.4;
			if (hasPerk(PerkLib.DaoistOverlordStage)) kmodss += 3;
			return kmodss;
		}
		
		public function KitsuneCastsFoxFire():void {
			mana -= 300;
			soulforce -= 108;
			outputText("Holding out his palm, he conjures a blaze of blue flames, dancing across his palm. He casts the flame towards you, the flames twisting mid air to foil your attempts to dodge them.  On contact, the azure fires burst like fireworks, covering the area around you with color and light. ");
			var damage:Number = 0;
			damage += inteligencescalingbonus() * 1.25;
			damage += wisdomscalingbonus() * 1.25;
			damage *= (kitsunespellMod() + kitsunesoulskillMod());
			damage = Math.round(damage);
			player.takeFireDamage(damage, true);
			outputText(" ");
			var lustDmg:Number = player.lustVuln * ((this.inte / 10) + rand(player.lib + player.cor) / 5);
			lustDmg *= 2;
			lustDmg = Math.round(lustDmg);
			player.dynStats("lus", lustDmg, "scale", false);
		}
		
		public function KitsuneCastsComet():void {
			soulforce -= 216;
			outputText("He raises a hand, focusing with intensity.  From above comes a crystalline meteor, which you barely manage to dodge.  The crystal shatters upon contact with the ground, sending a shower of splinters that you cannot avoid. ");
			if (player.armorName == "Drider-weave Armor" || player.armorPerk == "Heavy" || player.armorPerk == "Light Ayo" || player.armorPerk == "Heavy Ayo" || player.armorPerk == "Ultra Heavy Ayo") outputText("Thankfully, your armor manages to absorb most of the impact. ");
			var damage:Number = 0;
			damage += inteligencescalingbonus();
			damage *= kitsunesoulskillMod();
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 3;
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 0.3;
			if (player.armorPerk != "Heavy" && player.armorPerk != "Light Ayo" && player.armorPerk != "Heavy Ayo" && player.armorPerk != "Ultra Heavy Ayo") damage *= 2;
			damage = Math.round(damage);
			player.takeMagicDamage(damage, true);
		}
		
		private function kitsuneSealAttack():void
		{
			var resist:int = 0;
			if (player.inte < 30) resist = Math.round(player.inte);
			else resist = 30;
			if (player.hasPerk(PerkLib.Whispered)) resist += 20;
			if ((player.hasPerk(PerkLib.HistoryReligious) || player.hasPerk(PerkLib.PastLifeReligious)) && player.cor < 20) resist += 20 - player.cor;
			var select:int = rand(7);
			//Attack:
			if (select == 0) {
				outputText("The kitsune darts around you, grinning sly.  He somehow slips in under your reach, and before you can react, draws a small circle on your chest with his fingertip.  As you move to strike again, the flaming runic symbol he left on you glows brightly, and your movements are halted mid-swing.");
				outputText("\n\n\"<i>Junior, you should be careful with that.</i>\"");
				outputText("\n\nDespite your best efforts, every time you attempt to attack him, your muscles recoil involuntarily and prevent you from going through with it.  <b>The kitsune's spell has sealed your attack!</b>  You'll have to wait for it to wear off before you can use your basic attacks.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 0, 0, 0);
			}
			else if (select == 1) {
				//Tease:
				outputText("You are taken by surprise when the kitsune appears in front of you out of nowhere, trailing a fingertip down your chest.  He draws a small circle, leaving behind a glowing, sparking rune made of flames.  You suddenly find that all your knowledge of seduction and titillation escapes you.  <b>The kitsune's spell has sealed your ability to tease!</b>  Seems you won't be getting anyone hot and bothered until it wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 1, 0, 0);
			}
			//Spells:
			else if (select == 2) {
				outputText("\"<i>Oh silly, trying to beat me at my own game are you?</i>\"  the kitsune says with a smirk, surprising you as he appears right in front of you.  He traces a small circle around your mouth, and you find yourself stricken mute!  You try to remember the arcane gestures to cast your spell and find that you've forgotten them too.  <b>The kitsune's spell has sealed your magic!</b>  You won't be able to cast any spells until it wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 2, 0, 0);
			}
			//Items:
			else if (select == 3) {
				outputText("\"<i>Tsk tsk, using items?  That's cheating!</i>\"  the kitsune says as he appears right in front of you, taking you off guard.  His finger traces a small circle on your pouch, leaving behind a glowing rune made of crackling flames.  No matter how hard you try, you can't seem to pry it open.  <b>The kitsune's spell has sealed your item pouch!</b>  Looks like you won't be using any items until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 3, 0, 0);
			}
			//Run:
			else if (select == 4) {
				outputText("\"<i>Tsk tsk, leaving so soon?</i>\"  the kitsune says, popping up in front of you suddenly as you attempt to make your escape.  Before you can react, he draws a small circle on your chest with his fingertip, leaving behind a glowing rune made of crackling blue flames.  You try to run the other way, but your [legs] won't budge!\n\n\"<i>Sorry junior, you'll just have to stay and get lectured.</i>\" he says in a strict tone, appearing in front of you again.  <b>The kitsune's spell prevents your escape!</b>  You'll have to tough it out until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 4, 0, 0);
			}
			//P.Special:
			else if (select == 5) {
				outputText("You jump with surprise as the kitsune appears in front of you, grinning sly.  As he draws a small circle on your forehead with his fingertip, you find that you suddenly can't remember how to use any of your physical skills!");
				outputText("\n\n\"<i>Oh no junior, </i>I'm<i> the one with all the tricks here.</i>\"");
				outputText("\n\n<b>The kitsune's spell has sealed your physical skills!</b>  You won't be able to use any of them until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 5, 0, 0);
			}
			//M.Special:
			else {
				outputText("You jump with surprise as the kitsune appears in front of you, grinning sly.  As he draws a small circle on your forehead with his fingertip, you find that you suddenly can't remember how to use any of your magical skills!");
				outputText("\n\n\"<i>Oh no junior, </i>I'm<i> the one with all the tricks here.</i>\"");
				outputText("\n\n<b>The kitsune's spell has sealed your magical skills!</b>  You won't be able to use any of them until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 6, 0, 0);
			}
			if (resist >= rand(100)) {
				outputText("\n\nUpon your touch, the seal dissipates, and you are free of the kitsune's magic!  He frown in disappointment, looking thoroughly irritated, but quickly resumes his coy trickster facade.");
				player.removeStatusEffect(StatusEffects.Sealed);
			}
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(4);
			if (choice == 0) eAttack();
			if (choice == 1) {
				if (!player.hasStatusEffect(StatusEffects.Sealed)) kitsuneSealAttack();
				else eAttack();
			}
			if (choice > 1) {
				if (rand(3) == 0) {
					if (soulforce >= 216) KitsuneCastsComet();
					else eAttack();
				}
				else {
					if (mana >= 300 && soulforce >= 108) KitsuneCastsFoxFire();
					else eAttack();
				}
			}//dodać Illusion special+VPT soulskill+2 jakieś soulskille jak wiecej dodam
		}
		
		override public function get long():String
		{
			var sageBelow40:Boolean = (HP < maxHP() * 0.4);
			return "You’re facing a kitsune ancestor. The grey furred kitsune is wearing a "+
					(sageBelow40?("torn "):"") +
					"red kimono, flickering with magical flames. "+
					(hasStatusEffect(StatusEffects.KnowsChargeA)?"It seems he's using a variant of charged armor. ":"") +
					"His left hand is lit up by an aura of blue flames, ready to flare up into gouts of foxfire at a moment’s notice. In his right hand is his metal staff, foxfire burning at it’s tip.";
		}
		
		public function KitsuneAncestor() 
		{
			this.a = "a ";
			this.short = "kitsune ancestor";
			this.long = "";
			// this.plural = false;
			this.createCock(30,4,CockTypesEnum.FOX);
			this.balls = 2;
			this.ballSize = 6;
			this.cumMultiplier = 6;
			this.hoursSinceCum = 400;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = rand(14) + 70;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.skinTone = "grey";
			this.hairColor = "grey";
			this.hairLength = 31 + rand(10);
			initStrTouSpeInte(95, 160, 420, 330);
			initWisLibSensCor(330, 160, 190, 45);
			this.weaponName = "worn down staff";
			this.weaponVerb="smack";
			this.weaponAttack = 8;
			this.armorName = "red kimono";
			this.armorDef = 20;
			this.armorMDef = 50;
			this.bonusHP = 1000;
			this.bonusLust = 430;
			this.bonusMana = 3000;
			this.bonusSoulforce = 3000;
			this.lust = 20;
			this.lustVuln = 0.9;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 80;
			this.gems = rand(20) + 20;
			this.drop = NO_DROP;/*
			this.drop = new WeightedDrop().
				add(consumables.MG_SFRP,1).
				add(consumables.FOXJEWL, 4);*/
			this.tailType = Tail.FOX;
			this.tail.count = 9;
			this.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulApprentice, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulPersonage, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulWarrior, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulSprite, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulScholar, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulElder, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulExalt, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulOverlord, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulTyrant, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulKing, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulEmperor, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulAncestor, 0, 0, 0, 0);
			this.createPerk(PerkLib.DaoistCultivator, 0, 0, 0, 0);
			this.createPerk(PerkLib.DaoistApprenticeStage, 0, 0, 0, 0);
			this.createPerk(PerkLib.DaoistWarriorStage, 0, 0, 0, 0);
			this.createPerk(PerkLib.DaoistElderStage, 0, 0, 0, 0);
			this.createPerk(PerkLib.DaoistOverlordStage, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
			this.createPerk(PerkLib.Spellpower, 0, 0, 0, 0);
			this.createPerk(PerkLib.Mage, 0, 0, 0, 0);
			this.createPerk(PerkLib.Channeling, 0, 0, 0, 0);
			this.createPerk(PerkLib.Archmage, 0, 0, 0, 0);
			this.createPerk(PerkLib.GrandArchmage, 0, 0, 0, 0);
			this.createPerk(PerkLib.GreyMageApprentice, 0, 0, 0, 0);
			this.createPerk(PerkLib.GreyMage, 0, 0, 0, 0);
			this.createPerk(PerkLib.GreyArchmage, 0, 0, 0, 0);
			this.createPerk(PerkLib.GrandGreyArchmage, 0, 0, 0, 0);
			checkMonster();
		}	
	}
}