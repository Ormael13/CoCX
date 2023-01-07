package classes.Scenes.Dungeons.DeepCave
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Wings;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class ImpHorde extends Monster
	{
		public function impGangAI():void {
			if(hasStatusEffect(StatusEffects.ImpUber)) impGangUber();
			else if(lust > 50 && rand(2) == 0) impGangBukkake();
			else {
				var choice:Number = rand(4);
				if(choice < 3) imtacularMultiHitzilla();
				else impGangUber();
			}
			//(½ chance during any round):
			if(rand(2) == 0) {
				outputText("\nOne of the tiny demons latches onto one of your [legs] and starts humping it.  You shake the little bastard off and keep fighting!");
				player.takeLustDamage(3, true);
			}
		}
		
		public function impGangUber():void {
			if(!hasStatusEffect(StatusEffects.ImpUber)) {
				outputText("Three imps on the far side of the room close their eyes and begin murmuring words of darkness and power.  Your eyes widen, recognizing the spell.  Anything but that!  They're building up a massive arousal spell!  They keep muttering and gesturing, and you realize you've got one round to stop them!\n");
				createStatusEffect(StatusEffects.ImpUber,0,0,0,0);
			}
			else {
				//(OH SHIT IT GOES OFF)
				//+50 lust!
				player.takeLustDamage(500, true);
				outputText("The imps in the back finish their spell-casting, and point at you in unison.  A wave of pure arousal hits you with the force of a freight train.   Your equipment rubs across your suddenly violently sensitive " + nippleDescript(0));
				if(player.biggestLactation() > 1) outputText(" as they begin to drip milk");
				outputText(".  The lower portions of your coverings ");
				if(player.cockTotal() > 0) {
					outputText("are pulled tight by your " + multiCockDescript() + ", ");
					if(player.cockTotal() > 1) outputText("each ");
					outputText("beading a drop of pre-cum at the tip");
					if(player.hasVagina()) outputText(", and in addition, the clothes around your groin ");
				}
				if(player.hasVagina()) {
					outputText("become stained with feminine moisture");
					if(player.clitLength > 3) outputText(" as your clit swells up in a more sensitive imitation of a cock");
				}
				if(player.gender == 0) outputText("rub the sensitive skin of your thighs and featureless groin in a way that makes you wish you had a sex of some sort");
				outputText(".\n");
				removeStatusEffect(StatusEffects.ImpUber);
			}
		}
		
		public function impGangBukkake():void {
			outputText("Many of the imps are overcome by the lust you've inspired.  They hover in the air around you, pumping their many varied demonic rods as they bring themselves to orgasm.\n");
			
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
				if(player.getEvasionRoll()) {
					damage = rand(4);
					if(damage == 0) outputText("A wad of cum spatters into the floor as you narrowly sidestep it.\n");
					else if(damage == 1) outputText("One of the imps launches his seed so hard it passes clean over you, painting the wall white.\n");
					else if(damage == 2) outputText("You duck a glob of spooge and it passes harmlessly by.  A muffled grunt of disgust can be heard from behind you.\n");
					else if(damage == 3) outputText("You easily evade a blast of white fluid.\n");
				}
				//(2-6 hits for +10 lust each!) (-5 lust per successful hit)
				else {
					damage = rand(6);
					if(damage == 0) outputText("A squirt of hot demonic cum splatters into your face!\n");
					if(damage == 1) outputText("Your [allbreasts] are coated with thick demonic spunk!\n");
					if(damage == 2) outputText("Some of the fluid splatters into your midriff and drools down to your waist, making your [armor] slimy and wet.\n");
					if(damage == 3) outputText("Seed lands in your [hair], slicking you with demonic fluid.\n");
					if(damage == 4) outputText("Another blast of jizz splatters against your face, coating your lips and forcing a slight taste of it into your mouth.\n");
					if(damage == 5) outputText("The last eruption of cum soaks your thighs and the lower portions of your [armor], turning it a sticky white.\n");
					player.takeLustDamage((7+int(player.lib/40+player.cor/40)), true);
				}
				lust -= 5;
				hits--;
			}
		}
		
		public function imtacularMultiHitzilla():void {
			//Multiattack:
			if(!hasStatusEffect(StatusEffects.Blind)) outputText("The imps come at you in a wave, tearing at you with claws!\n");
			//(ALT BLINDED TEXT)
			else outputText("In spite of their blindness, most of them manage to find you, aided by the clutching claws of their brothers.\n");
			//(2-6 hits for 10 damage each)
			var hits:Number = rand(5) + 2;
			//Initial damage variable.
			var damage:Number = 0;
			//Loop through and apply dodges and whatnot for each hit.
			while(hits > 0) {
				//Clear damage from last loop
				damage = 0;
				//Blind dodge change
				if(player.getEvasionRoll()) {
					if(player.spe - spe < 8) outputText("You narrowly avoid " + a + short + "'s " + weaponVerb + "!\n");
					else if(player.spe - spe >= 8 && player.spe-spe < 20) outputText("You dodge " + a + short + "'s " + weaponVerb + " with superior quickness!\n");
					else if(player.spe - spe >= 20) outputText("You deftly avoid " + a + short + "'s slow " + weaponVerb + ".\n");
				}
				//OH SHIT SON YOU GOT REAPED
				else {
					if(hits == 6) outputText("You're clawed viciously by an imp!");
					if(hits == 5) outputText("One bites your ankle!");
					if(hits == 4) outputText("An imp rakes his claws down your back.");
					if(hits == 3) outputText("One of the little bastards manages to scratch up your legs!");
					if(hits == 2) outputText("Another imp punches you in the gut, hard!");
					if(hits == 1) outputText("Your arm is mauled by the clawing!");
					damage = 20 - rand(player.tou/10);
					if (damage <= 4) damage = 5;
					outputText(" ");
					damage = player.takePhysDamage(damage, true);
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
			SceneLib.dungeons.deepcave.impGangVICTORY();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foes don't seem put off enough to leave...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.dungeons.deepcave.loseToImpMob();
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
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 36;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.bodyColor = "red";
			this.hairColor = "black";
			this.hairLength = 1;
			initStrTouSpeInte(52, 35, 30, 12);
			initWisLibSensCor(10, 50, 50, 100);
			this.weaponName = "fists";
			this.weaponVerb="punches";
			this.weaponAttack = 15;
			this.armorName = "skin";
			this.armorDef = 10;
			this.armorMDef = 3;
			this.bonusHP = 900;
			this.bonusLust = 134;
			this.lust = 10;
			this.lustVuln = .5;
			this.level = 34;
			this.gems = 30 + rand(30);
			this.additionalXP = 100;
			this.drop = new WeightedDrop(armors.NURSECL, 1);
			this.wings.type = Wings.IMP;
			this.wings.desc = "imp";
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyLargeGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, 34, 0, 0, 0);
			checkMonster();
		}

	}

}
