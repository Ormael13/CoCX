package classes.Scenes.Dungeons.DeepCave
{
	import classes.*;
	import classes.internals.*;

	public class ImpHorde extends Monster
	{
		public function impGangAI():void {
			if (findStatusEffect(StatusEffects.ImpUber) >= 0) impGangUber();
			else if (lust > 50 && rand(2) == 0) impGangBukkake();
			else {
				var choice:Number = rand(4);
				if (choice < 3) imtacularMultiHitzilla();
				else impGangUber();
			}
			//(½ chance during any round):
			if (rand(2) == 0) {
				outputText("\nOne of the tiny demons latches onto one of your " + player.legs() + " and starts humping it.  You shake the little bastard off and keep fighting!", false);
				game.dynStats("lus", 1);
			}
			combatRoundOver();
		}
		
		public function impGangUber():void {
			if (findStatusEffect(StatusEffects.ImpUber) < 0) {
				outputText("Three imps on the far side of the room close their eyes and begin murmuring words of darkness and power.  Your eyes widen, recognizing the spell.  Anything but that!  They're building up a massive arousal spell!  They keep muttering and gesturing, and you realize you've got one round to stop them!\n", false);
				createStatusEffect(StatusEffects.ImpUber,0,0,0,0);
			}
			else {
				//(OH SHIT IT GOES OFF) 
				//+50 lust!
				game.dynStats("lus", 50);
				outputText("The imps in the back finish their spell-casting, and point at you in unison.  A wave of pure arousal hits you with the force of a freight train.   Your equipment rubs across your suddenly violently sensitive " + player.nippleDescript(0), false);
				if (player.biggestLactation() > 1) outputText(" as they begin to drip milk", false);
				outputText(".  The lower portions of your coverings ", false);
				if (player.cockTotal() > 0) {
					outputText("are pulled tight by your " + player.multiCockDescript() + ", ", false);
					if (player.totalCocks() > 1) outputText("each ", false);
					outputText("beading a drop of pre-cum at the tip", false);
					if (player.hasVagina()) outputText(", and in addition, the clothes around your groin ", false);
				}
				if (player.hasVagina()) {
					outputText("become stained with feminine moisture", false);
					if (player.clitLength > 3) outputText(" as your clit swells up in a more sensitive imitation of a cock", false);
				}
				if (player.gender == 0) outputText("rub the sensitive skin of your thighs and featureless groin in a way that makes you wish you had a sex of some sort", false);
				outputText(".\n", false);
				removeStatusEffect(StatusEffects.ImpUber);
			}
		}
		
		public function impGangBukkake():void {
			outputText("Many of the imps are overcome by the lust you've inspired.  They hover in the air around you, pumping their many varied demonic rods as they bring themselves to orgasm.\n", false);
			
			//(2-6 hits)
			var hits:Number = rand(5) + 2;
			//Initial damage variable.
			var damage:Number = 0;
			//Loop through and apply dodges and whatnot for each hit.
			while(hits > 0) {
				//+30% chance to avoid attack for evade
				//Clear damage from last loop
				damage = 0;
				//Blind dodge change
				if (findStatusEffect(StatusEffects.Blind) >= 0 && rand(3) < 2) {
					outputText(capitalA + short + "' misguided spooge flies everyone.  A few bursts of it don't even land anywhere close to you!\n", false);
				}
				//Determine if dodged!
				else if (player.spe - spe > 0 && rand(((player.spe-spe)/4) +90) > 80) {
					damage = rand(4);
					if (damage == 0) outputText("A wad of cum spatters into the floor as you narrowly sidestep it.\n", false);
					else if (damage == 1) outputText("One of the imps launches his seed so hard it passes clean over you, painting the wall white.\n", false);
					else if (damage == 2) outputText("You duck a glob of spooge and it passes harmlessly by.  A muffled grunt of disgust can be heard from behind you.\n", false);
					else if (damage == 3) outputText("You easily evade a blast of white fluid.\n", false);
				}
				//Determine if evaded
				else if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 30) {
					damage = rand(4);
					outputText("(Evade) ", false);
					if (damage == 0) outputText("A wad of cum spatters into the floor as you narrowly sidestep it.\n", false);
					else if (damage == 1) outputText("One of the imps launches his seed so hard it passes clean over you, painting the wall white.\n", false);
					else if (damage == 2) outputText("You duck a glob of spooge and it passes harmlessly by.  A muffled grunt of disgust can be heard from behind you.\n", false);
					else if (damage == 3) outputText("You easily evade a blast of white fluid.\n", false);
				}
				else if (player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
					outputText("(Misdirection) ", false);
					if (damage == 0) outputText("A wad of cum spatters into the floor as you narrowly sidestep it.\n", false);
					else if (damage == 1) outputText("One of the imps launches his seed so hard it passes clean over you, painting the wall white.\n", false);
					else if (damage == 2) outputText("You duck a glob of spooge and it passes harmlessly by.  A muffled grunt of disgust can be heard from behind you.\n", false);
					else if (damage == 3) outputText("You easily evade a blast of white fluid.\n", false);
				}
				//Determine if cat'ed
				else if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 15) {
					damage = rand(4);
					outputText("(Agility) ", false);
					if (damage == 0) outputText("A wad of cum spatters into the floor as you narrowly sidestep it.\n", false);
					else if (damage == 1) outputText("One of the imps launches his seed so hard it passes clean over you, painting the wall white.\n", false);
					else if (damage == 2) outputText("You duck a glob of spooge and it passes harmlessly by.  A muffled grunt of disgust can be heard from behind you.\n", false);
					else if (damage == 3) outputText("You easily evade a blast of white fluid.\n", false);
				}
				//(2-6 hits for +10 lust each!) (-5 lust per successful hit)
				else {
					damage = rand(6);
					if (damage == 0) outputText("A squirt of hot demonic cum splatters into your face!\n", false);
					if (damage == 1) outputText("Your " + player.allBreastsDescript() + " are coated with thick demonic spunk!\n", false);
					if (damage == 2) outputText("Some of the fluid splatters into your midriff and drools down to your waist, making your " + player.armorName + " slimy and wet.\n", false);
					if (damage == 3) outputText("Seed lands in your " + player.hairDescript() + ", slicking you with demonic fluid.\n", false);
					if (damage == 4) outputText("Another blast of jizz splatters against your face, coating your lips and forcing a slight taste of it into your mouth.\n", false);
					if (damage == 5) outputText("The last eruption of cum soaks your thighs and the lower portions of your " + player.armorName + ", turning it a sticky white.\n", false);
					game.dynStats("lus", (7+int(player.lib/40+player.cor/40)));
				}
				lust -= 5;
				hits--;
			}
		}
		
		public function imtacularMultiHitzilla():void {
			//Multiattack:
			if (findStatusEffect(StatusEffects.Blind) < 0) outputText("The imps come at you in a wave, tearing at you with claws!\n", false);
			//(ALT BLINDED TEXT)
			else outputText("In spite of their blindness, most of them manage to find you, aided by the clutching claws of their brothers.\n", false);
			//(2-6 hits for 10 damage each)
			var hits:Number = rand(5) + 2;
			//Initial damage variable.
			var damage:Number = 0;
			//Loop through and apply dodges and whatnot for each hit.
			while(hits > 0) {
				//Clear damage from last loop
				damage = 0;
				//Blind dodge change
				if (findStatusEffect(StatusEffects.Blind) >= 0 && rand(3) < 2) {
					outputText(capitalA + short + " completely misses you with a blind attack!\n", false);
				}
				//Determine if dodged!
				else if (player.spe - spe > 0 && rand(((player.spe-spe)/4) +90) > 80) {
					if (player.spe - spe < 8) outputText("You narrowly avoid " + a + short + "'s " + weaponVerb + "!\n", false);
					else if (player.spe - spe >= 8 && player.spe-spe < 20) outputText("You dodge " + a + short + "'s " + weaponVerb + " with superior quickness!\n", false);
					else if (player.spe - spe >= 20) outputText("You deftly avoid " + a + short + "'s slow " + weaponVerb + ".\n", false);
				}
				//Determine if evaded
				else if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
					outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s attack.\n", false);
				}
				else if (player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
					outputText("With the easy movement afforded by your bodysuit and Raphael's teachings, you easily avoid " + a + short + "'s attack.\n", false);
				}
				//Determine if cat'ed
				else if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 6) {
					outputText("With your incredible flexibility, you squeeze out of the way of " + a + short + "", false);
					if (plural) outputText("' attacks.\n", false);
					else outputText("'s attack.\n", false);
				}
				//OH SHIT SON YOU GOT REAPED
				else {
					if (hits == 6) outputText("You're clawed viciously by an imp!", false);
					if (hits == 5) outputText("One bites your ankle!", false);
					if (hits == 4) outputText("An imp rakes his claws down your back.", false);
					if (hits == 3) outputText("One of the little bastards manages to scratch up your legs!", false);
					if (hits == 2) outputText("Another imp punches you in the gut, hard!", false);
					if (hits == 1) outputText("Your arm is mauled by the clawing!", false);
					damage = 20 - rand(player.tou/10);
					if (damage <= 0) damage = 1;
					outputText(" ");
					damage = player.takeDamage(damage, true);
					outputText("\n");
				}
				hits--;
			}
		}
		
		override protected function performCombatAction():void
		{
			impGangAI();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.dungeons.deepcave.impGangVICTORY();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nYour foes don't seem put off enough to leave...");
				doNext(game.combat.endLustLoss);
			} else {
				game.dungeons.deepcave.loseToImpMob();
			}
		}

		public function ImpHorde()
		{
			trace("ImpHorde Constructor!");
			this.a = "the ";
			this.short = "imp horde";
			this.imageName = "impmob";
			this.long = "Imps of all shapes and sizes fill the room around you, keeping you completely surrounded by their myriad forms.  You can see more than a few sporting disproportionate erections, and there's even some with exotic dog-dicks, horse-pricks, and the odd spiny cat-cock.  Escape is impossible, you'll have to fight or seduce your way out of this one!";
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createCock(12,2,CockTypesEnum.DEMON);
			this.balls = 2;
			this.ballSize = 1;
			createBreastRow(0);
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 36;
			this.hipRating = HIP_RATING_SLENDER;
			this.buttRating = BUTT_RATING_TIGHT;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 1;
			initStrTouSpeInte(20, 10, 25, 12);
			initLibSensCor(45, 45, 100);
			this.weaponName = "fists";
			this.weaponVerb="punches";
			this.armorName = "skin";
			this.bonusHP = 450;
			this.lust = 10;
			this.lustVuln = .5;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 10;
			this.gems = 20 + rand(25);
			this.additionalXP = 50;
			this.drop = new WeightedDrop(armors.NURSECL, 1);
			this.wingType = WING_TYPE_IMP;
			this.wingDesc = "imp wings";
			checkMonster();
		}

	}

}