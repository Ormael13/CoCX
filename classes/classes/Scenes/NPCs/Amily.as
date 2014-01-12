package classes.Scenes.NPCs
{
	import classes.CoC;
	import classes.CoC_Settings;
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Amily extends Monster 
	{

		override protected function performCombatAction():void
		{
			if(hasStatusAffect("Concentration") < 0 && rand(4) == 0) amilyConcentration();
			else if(rand(3) == 0) amilyDartGo();
			else if(rand(2) == 0) amilyDoubleAttack();
			else amilyAttack();
		}

		//COMBAT AMILY STUFF
		//(Has regular attack)
		public function amilyAttack():void {
			var dodged:Number = 0;
			var damage:Number;
			//return to combat menu when finished
			doNext(1);
			//Blind dodge change
			if(hasStatusAffect("Blind") >= 0 && rand(3) < 2) {
				outputText(capitalA + short + " completely misses you with a blind attack!\n", false);
				game.combatRoundOver();
				return;
			}
			//Determine if dodged!
			if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80) {
				dodged = 1;
			}
			//Determine if evaded
			if(player.hasPerk("Evade") >= 0 && rand(100) < 10) {
				dodged = 2;
			}
			//("Misdirection"
			if(player.hasPerk("Misdirection") >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				dodged = 3;
			}
			//Determine if cat'ed
			if(player.hasPerk("Flexibility") >= 0 && rand(100) < 6) {
				dodged = 4;
			}
			//Determine damage - str modified by enemy toughness!
			damage = int((str + weaponAttack) - Math.random()*(player.tou+player.armorDef));
			//Dodged
			if(dodged > 0) {
				outputText("Amily dashes at you and swipes her knife, but you quickly sidestep the blow.", false);
				//Add tags for miss/evade/flexibility/etc.
				switch(dodged) {
					case 1:
						outputText(" [Dodge]", false);
						break;
					case 2:
						outputText(" [Evade]", false);
						break;
					case 3:
						outputText(" [Misdirect]", false);
						break;
					case 4:
						outputText(" [Flexibility]", false);
						break;
					default:
						CoC_Settings.error();
						outputText(" <b>[ERROR]</b>", false);
						break;
				}
			}
			//Blocked
			else if(damage <= 0) {
				damage = 0;
				//Due to toughness or amor...
				if(rand(player.armorDef + player.tou) < player.armorDef) outputText("Your " + player.armorName + " absorb and deflect every " + weaponVerb + " from " + a + short + ".", false);
				else outputText("You deflect and block every " + weaponVerb + " " + a + short + " throws at you.", false);
			}
			//Got hit!
			else {
				damage = player.takeDamage(damage);
				outputText("Amily dashes at you and swipes her knife, cutting you (" + damage + ").", false);
			}
			if(damage > 0) {
				if(lustVuln > 0 && player.armorName == "barely-decent bondage straps") {
					if(!plural) outputText("\n" + capitalA + short + " brushes against your exposed skin and jerks back in surprise, coloring slightly from seeing so much of you revealed.", false);
					else outputText("\n" + capitalA + short + " brush against your exposed skin and jerk back in surprise, coloring slightly from seeing so much of you revealed.", false);
					lust += 10 * lustVuln;
				}
			}
			game.statScreenRefresh();
			outputText("\n", false);
			game.combatRoundOver();
		}

		//(Special Attacks)
		//-Double Attack: Same as a normal attack, but hits twice.
		public function amilyDoubleAttack():void {
			var dodged:Number = 0;
			var damage:Number = 0;
			//return to combat menu when finished
			doNext(1);
			//Blind dodge change
			if(hasStatusAffect("Blind") >= 0 && rand(3) < 2) {
				dodged++;
			}
			//Determine if dodged!
			if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80) {
				dodged++;
			}
			//Determine if evaded
			if(player.hasPerk("Evade") >= 0 && rand(100) < 10) {
				dodged++;
			}
			//("Misdirection"
			if(player.hasPerk("Misdirection") >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				dodged++;
			}
			//Determine if cat'ed
			if(player.hasPerk("Flexibility") >= 0 && rand(100) < 6) {
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
					outputText("Amily dashes at you and slashes at you twice in the time it would take most to throw a single blow, but she can't cut deep enough to wound you!", false);
				}
				//NOT BLOCKED!
				else {
					damage = player.takeDamage(damage);
					if(dodged > 0) outputText("Amily dashes at you and quickly slashes you twice; you manage to avoid the first blow, but the second one hits home, cutting you", false);
					else outputText("Amily dashes at you and slashes at you twice in the time it would take most to throw a single blow", false);
					outputText(" (" + damage + ")!", false);
				}
			}
			//Dodge all!
			else outputText("Amily dashes at you and quickly slashes you twice, but you quickly sidestep her first blow and jump back to avoid any follow-ups.", false);

			game.combatRoundOver();
		}

		//-Poison Dart: Deals speed and str damage to the PC. (Not constant)
		private function amilyDartGo():void
		{
			var dodged:Number = 0;
			//Blind dodge change
			if (hasStatusAffect("Blind") >= 0 && rand(3) < 2) {
				outputText(capitalA + short + " completely misses you with a blind attack from her dartgun!\n", false);
				game.combatRoundOver();
				return;
			}
			//Determine if dodged!
			if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				dodged = 1;
			}
			//Determine if evaded
			if (player.hasPerk("Evade") >= 0 && rand(100) < 10) {
				dodged = 2;
			}
			//("Misdirection"
			if (player.hasPerk("Misdirection") >= 0 && rand(100) < 15 && player.armorName == "red, high-society bodysuit") {
				dodged = 3;
			}
			//Determine if cat'ed
			if (player.hasPerk("Flexibility") >= 0 && rand(100) < 15) {
				dodged = 4;
			}
			//Dodged
			if (dodged > 0) {
				outputText("Amily dashes at you and swipes her knife rather slowly. You easily dodge the attack; but it was all a feint, her other hands tries to strike at you with a poisoned dart. Luckily you manage to avoid it.", false);
				//Add tags for miss/evade/flexibility/etc.
				switch (dodged) {
					case 1:
						outputText(" [Dodge]", false);
						break;
					case 2:
						outputText(" [Evade]", false);
						break;
					case 3:
						outputText(" [Misdirect]", false);
						break;
					case 4:
						outputText(" [Flexibility]", false);
						break;
					default:
						CoC_Settings.error("");
						outputText(" <b>[ERROR]</b>", false);
						break;
				}
			}
			//Else hit!
			else {
				outputText("Amily dashes at you and swipes her knife at you, surprisingly slowly.  You easily dodge the attack; but it was a feint - her other hand tries to strike at you with a poisoned dart. However, she only manages to scratch you, only causing your muscles to grow slightly numb.", false);
				//Set status
				if (player.hasStatusAffect("Amily Venom") < 0) player.createStatusAffect("Amily Venom", 0, 0, 0, 0);
				var poison:Number = 2 + rand(5);
				while (poison > 0) {
					poison--;
					if (player.str >= 2) {
						player.str--;
						showStatDown("str");
						// strDown.visible = true;
						// strUp.visible = false;
						player.addStatusValue("Amily Venom", 1, 1);
					}
					if (player.spe >= 2) {
						player.spe--;
						showStatDown("spe");
						// speDown.visible = true;
						// speUp.visible = false;
						player.addStatusValue("Amily Venom", 2, 1);
					}
				}
				//If PC is reduced to 0 Speed and Strength, normal defeat by HP plays.
				if (player.spe <= 2 && player.str <= 2) {
					outputText("  You've become so weakened that you can't even make an attempt to defend yourself, and Amily rains blow after blow down upon your helpless form.", false);
					player.takeDamage(8999);
				}
			}
			game.combatRoundOver();
		}

		//Concentrate: always avoids the next attack. Can be disrupted by tease/seduce.
		private function amilyConcentration():void {
			outputText("Amily takes a deep breath and attempts to concentrate on your movements.", false);
			createStatusAffect("Concentration",0,0,0,0);
			game.combatRoundOver();
		}

		//(if PC uses tease/seduce after this)
		//Deals big lust increase, despite her resistance.
		override public function teased(lustDelta:Number):void
		{
			if(hasStatusAffect("Concentration") >= 0) {
				outputText("Amily flushes hotly; her concentration only makes her pay more attention to your parts!", false);
				lustDelta += 25+lustDelta;
				removeStatusAffect("Concentration");
				applyTease(lustDelta);
			} else {
				super.teased(lustDelta);
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.amilyScene.conquerThatMouseBitch();
		}

		public function Amily()
		{
			init01Names("", "Amily", "amily", "You are currently fighting Amily. The mouse-morph is dressed in rags and glares at you in rage, knife in hand. She keeps herself close to the ground, ensuring she can quickly close the distance between you two or run away.");
			init02Female(VAGINA_WETNESS_NORMAL, VAGINA_LOOSENESS_NORMAL, 48);
			init03BreastRows("C");
			init04Ass(ANAL_LOOSENESS_VIRGIN,ANAL_WETNESS_DRY);
			init05Body("4'",HIP_RATING_AMPLE,BUTT_RATING_TIGHT);
			init06Skin("tawny",SKIN_TYPE_FUR);
			init07Hair("brown",5);
			init08Face();
			init09PrimaryStats(30,30,85,60,45,45,10);
			init10Weapon("knife","slash",6);
			init11Armor("rags",1);
			init12Combat(20,20,.85);
			init13Level(4,2 + rand(5));
		}
		
	}

}