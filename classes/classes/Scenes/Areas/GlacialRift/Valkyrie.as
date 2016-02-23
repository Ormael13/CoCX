package classes.Scenes.Areas.GlacialRift 
{
	import classes.*;
	import classes.internals.WeightedDrop;
	
	public class Valkyrie extends Monster
	{
		public function spearAttack():void {
			outputText("The valkyrie lunges at you, jabbing with her longspear.  You dodge the first attack easily, ")
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_EVADE) {
				outputText("and you anticipate the upcoming spear strikes, dodging her attacks thanks to your incredible evasive ability!", false);
				combatRoundOver();
				return;
			}
			else if (evade == EVASION_FLEXIBILITY) {
				outputText("and you use your incredible flexibility to barely fold your body and avoid her attacks!", false);
				combatRoundOver();
				return;
			}
			else if (evade == EVASION_MISDIRECTION) {
				outputText("and you use technique from Raphael to sidestep and completely avoid her barrage of attacks!", false);
				combatRoundOver();
				return;
			}
			else if (evade == EVASION_SPEED || evade != null) {
				outputText("and you successfully dodge her barrages of spear attacks!", false);
				combatRoundOver();
				return;
			}
			else if (findStatusEffect(StatusEffects.Blind) >= 0 && rand(3) > 0) {
					outputText("and step away as you watch the valkyrie's blind attacks strike only air. ");
					combatRoundOver();
					return;
				}
			else
			{
				outputText("but she follows through with a rapid flurry of spear strikes, tearing into your " + (player.armor.name == "nothing" ? "" : "[armorName] and the underlying") + " flesh. ", false);
				var attacks:int = 1 + rand(3);
				var damage:int = 0
				while (attacks > 0) {
					damage += ((str) + rand(50))
					damage = player.reduceDamage(damage);
					attacks--
				}
				player.takeDamage(damage, true);
			}
			combatRoundOver();
		}
		
		public function shieldBash():void {
			outputText("The valkyrie feints at you with her longspear; you dodge the blow, ")
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_EVADE) {
				outputText("and you anticipate the upcoming shield bash, dodging her thanks to your incredible evasive ability!", false);
				combatRoundOver();
				return;
			}
			else if (evade == EVASION_FLEXIBILITY) {
				outputText("and you use your incredible flexibility to barely fold your body and avoid her shield bash!", false);
				combatRoundOver();
				return;
			}
			else if (evade == EVASION_MISDIRECTION) {
				outputText("and you use technique from Raphael to sidestep and avoid her shield bash!", false);
				combatRoundOver();
				return;
			}
			else if (evade == EVASION_SPEED || evade != null) {
				outputText("and you successfully dodge her shield bash attack!", false);
				combatRoundOver();
				return;
			}
			else if (findStatusEffect(StatusEffects.Blind) >= 0 && rand(3) > 0) {
					outputText("and step away as you watch the valkyrie's blind bash strikes only air. ");
					combatRoundOver();
					return;
				}
			else
			{
				outputText("but you leave yourself vulnerable as she spins around and slams her heavy shield into you, knocking you ", false);
				if (player.findPerk(PerkLib.Resolute) < 0 && rand(2) == 0) 
				{
					outputText("off balance. ", false)
					player.createStatusEffect(StatusEffects.Stunned, 0, 0, 0, 0);
				}
				else outputText("backwards. ", false)
				var damage:int = ((str + 50) + rand(50))
				damage = player.reduceDamage(damage);
				player.takeDamage(damage, true);
			}
			combatRoundOver();
		}
		
		public function aerialRave():void {
			if (rand(2) == 0 || player.canFly() /* it would be stupid to do this with someone winged */) {
				spearAttack()
				return;
			}
			outputText("The valkyrie charges right at you!  You manage to dodge her spear-thrust, but she spins gracefully out of the attack and grabs you by the waist.  ")
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_EVADE) {
				outputText("You manage to shake her hand off thanks to evasion.  ", false);
				combatRoundOver();
				return;
			}
			else if (evade == EVASION_FLEXIBILITY) {
				outputText("Thanks to your incredibly flexibility, her hand slips off your wrist.  ", false);
				combatRoundOver();
				return;
			}
			else if (evade == EVASION_MISDIRECTION) {
				outputText("Using Raphael's technique, you slip freely from her grip.", false);
				combatRoundOver();
				return;
			}
			else if (evade == EVASION_SPEED || evade != null) {
				outputText("You suddenly jerk your arm away, causing her grip to break.", false);
				combatRoundOver();
				return;
			}
			else
			{
				outputText("Before you can react, she launches into the air, propelling the two of you upwards with her powerful wings.  You struggle, but it’s no use -- until she lets go.  You cry out in terror as you fall back to the earth, crashing painfully into a convenient snowbank, while your opponent lands gracefully a few feet away. ", false);
				var damage:int = ((str + 200) + rand(100))
				damage = player.reduceDamage(damage);
				player.takeDamage(damage, true);
			}
			combatRoundOver();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.glacialRift.valkyrieScene.winAgainstValkyrie();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.glacialRift.valkyrieScene.loseToValkyrie();
		}
		
		public function Valkyrie() 
		{
			this.a = "a ";
			this.short = "valkyrie";
			this.imageName = "valkyrie";
			this.long = "She is a tall, pale-skinned woman with long golden locks spilling out from beneath her bronze helm.  She would look almost human, if not for the massive, powerful wings sprouting from her back, stretching perhaps a dozen feet across.  She is wearing a heavy bronze cuirass which curves perfectly around her perky C-cups, and is wielding a spear and shield as her weapons.  She has assumed the stance of a well-trained and experienced combatant, leaving few openings for you to exploit.";
			// this.plural = false;
			this.createVagina(false, 1, 1);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = 7*12;
			this.hipRating = HIP_RATING_SLENDER;
			this.buttRating = BUTT_RATING_TIGHT;
			this.skinTone = "light";
			this.skinType = SKIN_TYPE_PLAIN;
			//this.skinDesc = Appearance.Appearance.DEFAULT_SKIN_DESCS[SKIN_TYPE_FUR];
			this.hairColor = "white";
			this.hairLength = 12;
			initStrTouSpeInte(85, 70, 80, 60);
			initLibSensCor(40, 50, 15);
			this.weaponName = "spear and shield";
			this.weaponVerb="pummel";
			this.weaponAttack = 14;
			this.armorName = "bronze plates";
			this.armorDef = 17;
			this.bonusHP = 380;
			this.lust = 25 + rand(15);
			this.lustVuln = 0.46;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 18;
			this.gems = 30;
			this.drop = new WeightedDrop()
					.add(weapons.SPEAR, 1)
					.add(shields.GREATSH, 2)
					.add(consumables.W__BOOK, 4)					
					.add(null, 18);
			this.wingType = WING_TYPE_HARPY
			this.wingDesc = "fluffy feathery"
			this.special1 = spearAttack;
			this.special2 = shieldBash;
			this.special3 = aerialRave;
			checkMonster();			
		}
		
	}

}
