package classes.Scenes.Areas.Forest
{
	import classes.*;
	import classes.internals.WeightedDrop;

	public class Akbal extends Monster
	{

		override public function eAttack():void
		{
			//Chances to miss:
			var damage:Number = 0;
			//Blind dodge change
			if (findStatusEffect(StatusEffects.Blind) >= 0) {
				outputText(capitalA + short + " seems to have no problem guiding his attacks towards you, despite his blindness.\n", false);
			}
			//Determine if dodged!
			if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				if (player.spe - spe < 8)
					outputText("You narrowly avoid " + a + short + "'s " + weaponVerb + "!", false);
				if (player.spe - spe >= 8 && player.spe - spe < 20)
					outputText("You dodge " + a + short + "'s " + weaponVerb + " with superior quickness!", false);
				if (player.spe - spe >= 20)
					outputText("You deftly avoid " + a + short + "'s slow " + weaponVerb + ".", false);
				game.combat.combatRoundOver();
				return;
			}
			//Determine if evaded
			if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s attack.", false);
				game.combat.combatRoundOver();
				return;
			}
			//Determine if flexibilitied
			if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 10) {
				outputText("Using your cat-like agility, you twist out of the way of " + a + short + "'s attack.", false);
				game.combat.combatRoundOver();
				return;
			}
			//Determine damage - str modified by enemy toughness!
			//*Normal Attack A - 
			if (rand(2) == 0) {
				//(medium HP damage)
				damage = int((str + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
				if (damage <= 0) {
					outputText("Akbal lunges forwards but with your toughness", false);
					if (player.armorDef > 0)
						outputText(" and " + player.armorName + ", he fails to deal any damage.", false);
					else
						outputText(" he fails to deal any damage.", false);
				}
				else {
					outputText("Akbal rushes at you, his claws like lightning as they leave four red-hot lines of pain across your stomach.", false);
					player.takeDamage(damage);
				}
			} else { //*Normal Attack B
				//(high HP damage)
				damage = int((str + 25 + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
				if (damage == 0) {
					outputText("Akbal lunges forwards but between your toughness ", false);
					if (player.armorDef > 0)
						outputText("and " + player.armorName + ", he fails to deal any damage.", false);
				}
				else {
					outputText("Akbal snarls as he flies towards you, snapping his ivory teeth on your arm. You scream out in pain as you throw him off.", false);
					player.takeDamage(damage);
				}
			}
			game.combat.combatRoundOver();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.forest.akbalScene.akbalDefeated(hpVictory);
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.forest.akbalScene.akbalWon(hpVictory,pcCameWorms);
			game.combat.cleanupAfterCombat();
		}
		
		public function akbalLustAttack():void
		{
			//*Lust Attack - 
			if (player.findStatusEffect(StatusEffects.Whispered) < 0)
			{
				outputText("You hear whispering in your head. Akbal begins speaking to you as he circles you, telling all the ways he'll dominate you once he beats the fight out of you.", false);
				//(Lust increase)
				game.dynStats("lus", 7 + (100 - player.inte) / 10);
				player.createStatusEffect(StatusEffects.Whispered,0,0,0,0);
			}
			//Continuous Lust Attack - 
			else
			{
				outputText("The whispering in your head grows, many voices of undetermined sex telling you all the things the demon wishes to do to you. You can only blush.", false);
				//(Lust increase)
				game.dynStats("lus", 12 + (100 - player.inte) / 10);
			}
			game.combat.combatRoundOver();
		}
		
		public function akbalSpecial():void
		{
			//*Special Attack A - 
			if (rand(2) == 0 && player.spe > 20)
			{
				var speedChange:Number = player.spe / 5 * -1;
				outputText("Akbal's eyes fill with light, and a strange sense of fear begins to paralyze your limbs.", false);
				//(Speed decrease)
				game.dynStats("spe", speedChange);
				if (player.findStatusEffect(StatusEffects.AkbalSpeed) >= 0)
					player.addStatusValue(StatusEffects.AkbalSpeed, 1, speedChange);
				else
					player.createStatusEffect(StatusEffects.AkbalSpeed, speedChange, 0, 0, 0);
			}
			//*Special Attack B - 
			else
			{
				outputText("Akbal releases an ear-splitting roar, hurling a torrent of emerald green flames towards you.\n", false);
				//(high HP damage)
				//Determine if dodged!
				if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80)
				{
					if (player.spe - spe < 8)
						outputText("You narrowly avoid " + a + short + "'s fire!", false);
					if (player.spe - spe >= 8 && player.spe - spe < 20)
						outputText("You dodge " + a + short + "'s fire with superior quickness!", false);
					if (player.spe - spe >= 20)
						outputText("You deftly avoid " + a + short + "'s slow fire-breath.", false);
					game.combat.combatRoundOver();
					return;
				}
				//Determine if evaded
				if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 20)
				{
					outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s fire-breath.", false);
					game.combat.combatRoundOver();
					return;
				}
				//Determine if flexibilitied
				if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 10)
				{
					outputText("Using your cat-like agility, you contort your body to avoid " + a + short + "'s fire-breath.", false);
					game.combat.combatRoundOver();
					return;
				}
				outputText("You are burned badly by the flames! ("+player.takeDamage(40) +")", false);
				;
			}
			game.combat.combatRoundOver();
		}
		
		//*Support ability - 
		public function akbalHeal():void
		{
			if (HPRatio() >= 1)
				outputText("Akbal licks himself, ignoring you for now.", false);
			else
				outputText("Akbal licks one of his wounds, and you scowl as the injury quickly heals itself.", false);
			addHP(30);
			lust += 10;
			game.combat.combatRoundOver();
		}

		public function Akbal()
		{
			trace("Akbal Constructor!");
			this.a = "";
			this.short = "Akbal";
			this.imageName = "akbal";
			this.long = "Akbal, 'God of the Terrestrial Fire', circles around you. His sleek yet muscular body is covered in tan fur, with dark spots that seem to dance around as you look upon them.  His mouth holds two ivory incisors that glint in the sparse sunlight as his lips tremble to the sound of an unending growl.  Each paw conceals lethal claws capable of shredding men and demons to ribbons.  His large and sickeningly alluring bright green eyes promise unbearable agony as you look upon them.";
			// this.plural = false;
			this.createCock(15,2.5,CockTypesEnum.DOG);
			this.balls = 2;
			this.ballSize = 4;
			this.cumMultiplier = 6;
			this.hoursSinceCum = 400;
			createBreastRow();
			createBreastRow();
			createBreastRow();
			createBreastRow();
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = 4*12;
			this.hipRating = HIP_RATING_SLENDER;
			this.buttRating = BUTT_RATING_TIGHT;
			this.skinTone = "spotted";
			this.skinType = SKIN_TYPE_FUR;
			//this.skinDesc = Appearance.Appearance.DEFAULT_SKIN_DESCS[SKIN_TYPE_FUR];
			this.hairColor = "black";
			this.hairLength = 5;
			initStrTouSpeInte(55, 53, 50, 75);
			initLibSensCor(50, 50, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw-slash";
			this.weaponAttack = 5;
			this.armorName = "shimmering pelt";
			this.armorDef = 5;
			this.bonusHP = 20;
			this.lust = 30;
			this.lustVuln = 0.8;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 6;
			this.gems = 15;
			this.drop = new WeightedDrop().
					add(consumables.INCUBID,4).
					add(consumables.W_FRUIT,3).
					add(consumables.AKBALSL,2).
					add(weapons.PIPE,1);
			this.special1 = akbalLustAttack;
			this.special2 = akbalSpecial;
			this.special3 = akbalHeal;
			this.tailType = TAIL_TYPE_DOG;
			checkMonster();
		}

	}

}