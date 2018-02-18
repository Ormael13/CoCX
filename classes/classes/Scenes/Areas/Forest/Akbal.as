package classes.Scenes.Areas.Forest
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

public class Akbal extends Monster
	{

		override public function eAttack():void
		{
			//Chances to miss:
			var damage:Number = 0;
			//Blind dodge change
			if (hasStatusEffect(StatusEffects.Blind)) {
				outputText(capitalA + short + " seems to have no problem guiding his attacks towards you, despite his blindness.\n");
			}
			//Determine if dodged!
			if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				if (player.spe - spe < 8)
					outputText("You narrowly avoid " + a + short + "'s " + weaponVerb + "!");
				if (player.spe - spe >= 8 && player.spe - spe < 20)
					outputText("You dodge " + a + short + "'s " + weaponVerb + " with superior quickness!");
				if (player.spe - spe >= 20)
					outputText("You deftly avoid " + a + short + "'s slow " + weaponVerb + ".");
				return;
			}
			//Determine if evaded
			if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s attack.");
				return;
			}
			//Determine if flexibilitied
			if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 10) {
				outputText("Using your cat-like agility, you twist out of the way of " + a + short + "'s attack.");
				return;
			}
			//Determine damage - str modified by enemy toughness!
			//*Normal Attack A - 
			if (rand(2) == 0) {
				//(medium HP damage)
				damage = int((str + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
				if (damage <= 0) {
					outputText("Akbal lunges forwards but with your toughness");
					if (player.armorDef > 0)
						outputText(" and [armor], he fails to deal any damage.");
					else
						outputText(" he fails to deal any damage.");
				}
				else {
					outputText("Akbal rushes at you, his claws like lightning as they leave four red-hot lines of pain across your stomach.");
					player.takePhysDamage(damage);
				}
			} else { //*Normal Attack B
				//(high HP damage)
				damage = int((str + 25 + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
				if (damage == 0) {
					outputText("Akbal lunges forwards but between your toughness ");
					if (player.armorDef > 0)
						outputText("and [armor], he fails to deal any damage.");
				}
				else {
					outputText("Akbal snarls as he flies towards you, snapping his ivory teeth on your arm. You scream out in pain as you throw him off.");
					player.takePhysDamage(damage);
				}
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.forest.akbalScene.akbalDefeated(hpVictory);
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.forest.akbalScene.akbalWon(hpVictory,pcCameWorms);
			SceneLib.combat.cleanupAfterCombatImpl();
		}
		
		public function akbalLustAttack():void
		{
			//*Lust Attack - 
			if (!player.hasStatusEffect(StatusEffects.Whispered))
			{
				outputText("You hear whispering in your head. Akbal begins speaking to you as he circles you, telling all the ways he'll dominate you once he beats the fight out of you.");
				//(Lust increase)
				player.dynStats("lus", 9 + rand(9));
				player.createStatusEffect(StatusEffects.Whispered,0,0,0,0);
			}
			//Continuous Lust Attack - 
			else
			{
				outputText("The whispering in your head grows, many voices of undetermined sex telling you all the things the demon wishes to do to you. You can only blush.");
				//(Lust increase)
				player.dynStats("lus", 12 + rand(12));
			}
		}
		
		public function akbalSpecial():void
		{
			//*Special Attack A - 
			if (rand(2) == 0 && player.spe > 20)
			{
				outputText("Akbal's eyes fill with light, and a strange sense of fear begins to paralyze your limbs.");
				
				//(Speed decrease)
				player.addCombatBuff('spe', -player.spe / 5);
			}
			//*Special Attack B - 
			else
			{
				outputText("Akbal releases an ear-splitting roar, hurling a torrent of emerald green flames towards you.\n");
				//(high HP damage)
				//Determine if dodged!
				if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80)
				{
					if (player.spe - spe < 8)
						outputText("You narrowly avoid " + a + short + "'s fire!");
					if (player.spe - spe >= 8 && player.spe - spe < 20)
						outputText("You dodge " + a + short + "'s fire with superior quickness!");
					if (player.spe - spe >= 20)
						outputText("You deftly avoid " + a + short + "'s slow fire-breath.");
					return;
				}
				//Determine if evaded
				if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 20)
				{
					outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s fire-breath.");
					return;
				}
				//Determine if flexibilitied
				if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 10)
				{
					outputText("Using your cat-like agility, you contort your body to avoid " + a + short + "'s fire-breath.");
					return;
				}
				if (player.hasStatusEffect(StatusEffects.Blizzard)) {
					player.addStatusValue(StatusEffects.Blizzard, 1, -1);
					var damage2:int = inte / 4;
					if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage2 *= 3;
					if (player.findPerk(PerkLib.FireAffinity) >= 0) damage2 *= 0.3;
					damage2 = Math.round(damage2);
					outputText("Surrounding your blizzard absorbed huge part of the attack at the price of loosing some of it protective power.\n");
					outputText("You are burned badly by the flames! ");
					damage2 = player.takeMagicDamage(damage2, true);
					return;
				}
				var damage:int = inte;
				if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
				if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
				damage = Math.round(damage);
				outputText("You are burned badly by the flames! ");
				damage = player.takeMagicDamage(damage, true);
			}
		}
		
		//*Support ability - 
		public function akbalHeal():void
		{
			if (HPRatio() >= 1)
				outputText("Akbal licks himself, ignoring you for now.");
			else
				outputText("Akbal licks one of his wounds, and you scowl as the injury quickly heals itself.");
			addHP(30 * (1 + rand(4)));
			lust += 10;
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
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 4*12;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.skin.growFur({color:"spotted"});
			this.hairColor = "black";
			this.hairLength = 5;
			initStrTouSpeInte(61, 89, 75, 86);
			initWisLibSensCor(85, 80, 50, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw-slash";
			this.weaponAttack = 17;
			this.armorName = "shimmering pelt";
			this.armorDef = 10;
			this.bonusHP = 100;
			this.bonusLust = 40;
			this.lust = 30;
			this.lustVuln = 0.8;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 20;
			this.gems = 40;
			this.drop = new WeightedDrop().
					add(consumables.INCUBID,4).
					add(consumables.W_FRUIT,3).
					add(consumables.AKBALSL,2).
					add(weapons.PIPE,1);
			this.special1 = akbalLustAttack;
			this.special2 = akbalSpecial;
			this.special3 = akbalHeal;
			this.tailType = Tail.DOG;
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
