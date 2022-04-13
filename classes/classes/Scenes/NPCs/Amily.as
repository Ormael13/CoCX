package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
import classes.StatusEffects.Combat.AmilyVenomDebuff;

/**
	 * ...
	 * @author ...
	 */
	public class Amily extends Monster 
	{

		override protected function performCombatAction():void
		{
			if(!hasStatusEffect(StatusEffects.Concentration) && rand(4) == 0) amilyConcentration();
			else if(rand(3) == 0) amilyDartGo();
			else if(rand(2) == 0) amilyDoubleAttack();
			else amilyAttack();
		}

		//COMBAT AMILY STUFF
		//(Has regular attack)
		public function amilyAttack():void {
			var damage:Number;
			//return to combat menu when finished
			doNext(EventParser.playerMenu);
			//Blind dodge change
			if(hasStatusEffect(StatusEffects.Blind) && rand(3) < 2) {
				outputText(capitalA + short + " completely misses you with a blind attack!\n");
				return;
			}
			//Determine if dodged!
			var dodged:String = player.getEvasionReason();
			//Determine damage - str modified by enemy toughness!
			damage = int((str + weaponAttack) - Math.random()*(player.tou+player.armorDef));
			//Dodged
			if(dodged != null) {
				outputText("Amily dashes at you and swipes her knife, but you quickly sidestep the blow.");
				//Add tags for miss/evade/flexibility/etc.
				switch(dodged) {
					case EVASION_SPEED:
						outputText(" [Dodge]");
						break;
					case EVASION_EVADE:
						outputText(" [Evade]");
						break;
					case EVASION_MISDIRECTION:
						outputText(" [Misdirect]");
						break;
					case EVASION_FLEXIBILITY:
						outputText(" [Flexibility]");
						break;
					case EVASION_UNHINDERED:
						outputText(" [Unhindered]");
						break;
					default:
						CoC_Settings.error();
						outputText(" <b>[ERROR]</b>");
						break;
				}
			}
			//Blocked
			else if(damage <= 0) {
				damage = 0;
				//Due to toughness or amor...
				if(rand(player.armorDef + player.tou) < player.armorDef) outputText("Your [armor] absorb and deflect every " + weaponVerb + " from " + a + short + ".");
				else outputText("You deflect and block every " + weaponVerb + " " + a + short + " throws at you.");
			}
			//Got hit!
			else {
				outputText("Amily dashes at you and swipes her knife, cutting you. ");
				damage = player.takePhysDamage(damage, true);
			}
			if(damage > 0) {
				if(lustVuln > 0 && player.armorName == "barely-decent bondage straps") {
					if(!plural) outputText("\n" + capitalA + short + " brushes against your exposed skin and jerks back in surprise, coloring slightly from seeing so much of you revealed.");
					else outputText("\n" + capitalA + short + " brush against your exposed skin and jerk back in surprise, coloring slightly from seeing so much of you revealed.");
					lust += 10 * lustVuln;
				}
			}
			EngineCore.statScreenRefresh();
			outputText("\n");
		}

		//(Special Attacks)
		//-Double Attack: Same as a normal attack, but hits twice.
		public function amilyDoubleAttack():void {
			var dodged:Number = 0;
			var damage:Number = 0;
			//return to combat menu when finished
			doNext(EventParser.playerMenu);
			//Blind dodge change
			if(hasStatusEffect(StatusEffects.Blind) && rand(3) < 2) {
				dodged++;
			}
			//Determine if dodged!
			if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80) {
				dodged++;
			}
			//Determine if evaded
			if(player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
				dodged++;
			}
			//("Misdirection"
			if(player.hasPerk(PerkLib.Misdirection) && rand(100) < 10 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
				dodged++;
			}
			//Determine if cat'ed
			if(player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
				dodged++;
			}
			//Get hit!
			if(dodged < 2) {
				//Determine damage - str modified by enemy toughness!
				damage = int((str + weaponAttack) - Math.random()*(player.tou+player.armorDef));
				//Double damage if no dodge.
				if(dodged == 0) damage *= 2;
				//Blocked?
				if(damage == 0) {
					outputText("Amily dashes at you and slashes at you twice in the time it would take most to throw a single blow, but she can't cut deep enough to wound you!");
				}
				//NOT BLOCKED!
				else {
					if(dodged > 0) outputText("Amily dashes at you and quickly slashes you twice; you manage to avoid the first blow, but the second one hits home, cutting you");
					else outputText("Amily dashes at you and slashes at you twice in the time it would take most to throw a single blow");
					outputText("! ");
					damage = player.takePhysDamage(damage, true);
				}
			}
			//Dodge all!
			else outputText("Amily dashes at you and quickly slashes you twice, but you quickly sidestep her first blow and jump back to avoid any follow-ups.");

		}

		//-Poison Dart: Deals speed and str damage to the PC. (Not constant)
		private function amilyDartGo():void
		{
			var dodged:Number = 0;
			if (player.hasStatusEffect(StatusEffects.WindWall)) {
				outputText(capitalA + short + " attack from her dartgun stops at wind wall weakening it slightly.\n");
				player.addStatusValue(StatusEffects.WindWall,2,-1);
				return;
			}
			//Blind dodge change
			if (hasStatusEffect(StatusEffects.Blind) && rand(3) < 2) {
				outputText(capitalA + short + " completely misses you with a blind attack from her dartgun!\n");
				return;
			}
			//Determine if dodged!
			if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				dodged = 1;
			}
			//Determine if evaded
			if (player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
				dodged = 2;
			}
			//("Misdirection"
			if (player.hasPerk(PerkLib.Misdirection) && rand(100) < 15 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
				dodged = 3;
			}
			//Determine if cat'ed
			if (player.hasPerk(PerkLib.Flexibility) && rand(100) < 15) {
				dodged = 4;
			}
			//Dodged
			if (dodged > 0) {
				outputText("Amily dashes at you and swipes her knife rather slowly. You easily dodge the attack; but it was all a feint, her other hands tries to strike at you with a poisoned dart. Luckily you manage to avoid it.");
				//Add tags for miss/evade/flexibility/etc.
				switch (dodged) {
					case 1:
						outputText(" [Dodge]");
						break;
					case 2:
						outputText(" [Evade]");
						break;
					case 3:
						outputText(" [Misdirect]");
						break;
					case 4:
						outputText(" [Flexibility]");
						break;
					default:
						CoC_Settings.error("");
						outputText(" <b>[ERROR]</b>");
						break;
				}
			}
			//Else hit!
			else {
				outputText("Amily dashes at you and swipes her knife at you, surprisingly slowly.  You easily dodge the attack; but it was a feint - her other hand tries to strike at you with a poisoned dart. However, she only manages to scratch you, only causing your muscles to grow slightly numb.");
				//Set status
				var ase:AmilyVenomDebuff = player.createOrFindStatusEffect(StatusEffects.AmilyVenom) as AmilyVenomDebuff;
				ase.increase();
			}
		}

		//Concentrate: always avoids the next attack. Can be disrupted by tease/seduce.
		private function amilyConcentration():void {
			outputText("Amily takes a deep breath and attempts to concentrate on your movements.");
			createStatusEffect(StatusEffects.Concentration,0,0,0,0);
		}

		//(if PC uses tease/seduce after this)
		//Deals big lust increase, despite her resistance.
		override public function teased(lustDelta:Number, isNotSilent:Boolean = true):void
		{
			if(hasStatusEffect(StatusEffects.Concentration)) {
				outputText("Amily flushes hotly; her concentration only makes her pay more attention to your parts!");
				lustDelta += 25+lustDelta;
				removeStatusEffect(StatusEffects.Concentration);
				applyTease(lustDelta);
			} else {
				super.teased(lustDelta);
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.amilyScene.conquerThatMouseBitch();
		}

		public function Amily()
		{
			this.a = "";
			this.short = "Amily";
			this.imageName = "amily";
			this.long = "You are currently fighting Amily. The mouse-morph is dressed in rags and glares at you in rage, knife in hand. She keeps herself close to the ground, ensuring she can quickly close the distance between you two or run away.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 48, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 4*12;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_TIGHT;
			this.skin.growFur({color:"tawny"});
			this.hairColor = "brown";
			this.hairLength = 5;
			initStrTouSpeInte(40, 40, 120, 80);
			initWisLibSensCor(80, 44, 45, 10);
			this.weaponName = "knife";
			this.weaponVerb="slash";
			this.weaponAttack = 9;
			this.armorName = "rags";
			this.armorDef = 1;
			this.armorMDef = 1;
			this.bonusHP = 20;
			this.bonusLust = 101;
			this.lust = 20;
			this.lustVuln = .85;
			this.level = 12;
			this.gems = 8 + rand(11);
			this.drop = NO_DROP;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
