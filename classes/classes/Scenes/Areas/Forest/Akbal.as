package classes.Scenes.Areas.Forest
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
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
			if (player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s attack.");
				return;
			}
			//Determine if flexibilitied
			if (player.hasPerk(PerkLib.Flexibility) && rand(100) < 10) {
				outputText("Using your cat-like agility, you twist out of the way of " + a + short + "'s attack.");
				return;
			}
			//Determine damage - str modified by enemy toughness!
			//*Normal Attack A - 
			if (rand(2) == 0) {
				//(medium HP damage)
				if (flags[kFLAGS.AKBAL_LVL_UP] >= 12) damage = int((str + 40 + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
				else if (flags[kFLAGS.AKBAL_LVL_UP] >= 8) damage = int((str + 20 + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
				else if (flags[kFLAGS.AKBAL_LVL_UP] >= 4) damage = int((str + 10 + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
				else damage = int((str + 5 + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
				if (damage <= 0) {
					outputText("Akbal lunges forwards but with your toughness");
					if (player.armorDef > 0)
						outputText(" and [armor], he fails to deal any damage.");
					else
						outputText(" he fails to deal any damage.");
				}
				else {
					outputText("Akbal rushes at you, his claws like lightning as they leave four red-hot lines of pain across your stomach.");
					player.takePhysDamage(damage, true);
				}
			} else { //*Normal Attack B
				//(high HP damage)
				if (flags[kFLAGS.AKBAL_LVL_UP] >= 12) damage = int((str + 240 + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
				else if (flags[kFLAGS.AKBAL_LVL_UP] >= 8) damage = int((str + 120 + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
				else if (flags[kFLAGS.AKBAL_LVL_UP] >= 4) damage = int((str + 60 + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
				else damage = int((str + 30 + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
				if (damage == 0) {
					outputText("Akbal lunges forwards but between your toughness ");
					if (player.armorDef > 0)
						outputText("and [armor], he fails to deal any damage.");
				}
				else {
					outputText("Akbal snarls as he flies towards you, snapping his ivory teeth on your arm. You scream out in pain as you throw him off.");
					player.takePhysDamage(damage, true);
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
				var lustattack1:Number = 9 + rand(9);
				if (flags[kFLAGS.AKBAL_LVL_UP] >= 1) lustattack1 += flags[kFLAGS.AKBAL_LVL_UP] + rand(flags[kFLAGS.AKBAL_LVL_UP]);
				player.dynStats("lus", lustattack1);
				player.createStatusEffect(StatusEffects.Whispered,0,0,0,0);
			}
			//Continuous Lust Attack - 
			else
			{
				outputText("The whispering in your head grows, many voices of undetermined sex telling you all the things the demon wishes to do to you. You can only blush.");
				var lustattack2:Number = 12 + rand(12);
				if (flags[kFLAGS.AKBAL_LVL_UP] >= 1) lustattack2 += 3 + flags[kFLAGS.AKBAL_LVL_UP] + rand(flags[kFLAGS.AKBAL_LVL_UP]);
				player.dynStats("lus", lustattack2);
			}
		}
		
		public function akbalSpecial():void
		{
			//*Special Attack A - 
			if (rand(2) == 0 && player.spe > 20)
			{
				outputText("Akbal's eyes fill with light, and a strange sense of fear begins to paralyze your limbs.");
				
				//(Speed decrease)
				player.addCombatBuff('spe', -player.spe / 5, "Combat Debuff", "AkbalDebuff");
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
				if (player.hasPerk(PerkLib.Evade) && rand(100) < 20)
				{
					outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s fire-breath.");
					return;
				}
				//Determine if flexibilitied
				if (player.hasPerk(PerkLib.Flexibility) && rand(100) < 10)
				{
					outputText("Using your cat-like agility, you contort your body to avoid " + a + short + "'s fire-breath.");
					return;
				}
				if (player.hasStatusEffect(StatusEffects.Blizzard)) {
					player.addStatusValue(StatusEffects.Blizzard, 1, -1);
					var damage2:int = inte / 4;
					if (flags[kFLAGS.AKBAL_LVL_UP] >= 1) damage2 *= (1 + (flags[kFLAGS.AKBAL_LVL_UP] * 0.1));
					damage2 = Math.round(damage2);
					outputText("Surrounding your blizzard absorbed huge part of the attack at the price of loosing some of it protective power.\n");
					outputText("You are burned badly by the flames! ");
					damage2 = player.takeFireDamage(damage2, true);
					return;
				}
				var damage:int = inte;
				damage = Math.round(damage);
				outputText("You are burned badly by the flames! ");
				damage = player.takeFireDamage(damage, true);
			}
		}
		
		//*Support ability - 
		public function akbalHeal():void
		{
			if (HPRatio() >= 1)
				outputText("Akbal licks himself, ignoring you for now.");
			else
				outputText("Akbal licks one of his wounds, and you scowl as the injury quickly heals itself.");
			var addedHP:Number = 30;
			if (flags[kFLAGS.AKBAL_LVL_UP] >= 1) addedHP += 5 * flags[kFLAGS.AKBAL_LVL_UP];
			addedHP *= (1 + rand(4));
			addHP(addedHP);
			lust += 10;
		}

		public function Akbal()
		{
			var mod:int = flags[kFLAGS.AKBAL_LVL_UP]; //just to be concise
			var addIntWis:int = (mod <= 4) ? mod * 19 : 4*19 + (mod - 4) * 9;
			trace("Akbal Constructor!");
			//New levelling
			initStrTouSpeInte(61 + mod*13, 89 + mod*20, 75 + mod*15, 126 + addIntWis); //int might be too much, but it's scalable now
			initWisLibSensCor(85 + addIntWis, 80 + mod*17, 50 + mod*10, 100); //wis too
			this.weaponAttack = 17 + mod*3;
			this.armorDef = 10 + mod*2;
			this.armorMDef = 20 + mod*4;
			this.bonusHP = 100 + mod*100;
			this.bonusLust = 150 + mod*33;
			this.level = 20 + mod*6;
			this.additionalXP = 50 + mod*50;
			//
			this.a = "";
			this.short = "Akbal";
			this.imageName = "akbal";
			this.long = "Akbal, 'God of the Terrestrial Fire', circles around you. His sleek yet muscular body is covered in tan fur, with dark spots that seem to dance around as you look upon them.  His mouth holds two ivory incisors that glint in the sparse sunlight as his lips tremble to the sound of an unending growl.  Each paw conceals lethal claws capable of shredding men and demons to ribbons.  His large and sickeningly alluring bright green eyes promise unbearable agony as you look upon them.";
			// this.plural = false;
			this.createCock(15,2.5,CockTypesEnum.CAT);
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
			this.weaponName = "claws";
			this.weaponVerb="claw-slash";
			this.armorName = "shimmering pelt";
			this.lust = 30;
			this.lustVuln = 0.8;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.gems = 40;
			this.drop = new WeightedDrop().
					add(consumables.INCUBID,4).
					add(consumables.W_FRUIT,3).
					add(consumables.AKBALSL,2).
					add(weapons.PIPE,1);
			this.abilities = [
				{call: eAttack(), type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{call: akbalLustAttack, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[]},
				{call: akbalSpecial, type: ABILITY_MAGIC, range: RANGE_RANGED, tags:[TAG_FIRE]},
				{call: akbalHeal, type: ABILITY_MAGIC, range: RANGE_SELF, tags:[TAG_HEAL]},
			];
			this.tailType = Tail.CAT;
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, (20 + mod*6), 0, 0, 0);
			this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			if (flags[kFLAGS.AKBAL_LVL_UP] >= 1) this.createPerk(PerkLib.JobRanger, 0, 0, 0, 0);
			if (flags[kFLAGS.AKBAL_LVL_UP] >= 2) this.createPerk(PerkLib.JobRogue, 0, 0, 0, 0);
			if (flags[kFLAGS.AKBAL_LVL_UP] >= 3) this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
			if (flags[kFLAGS.AKBAL_LVL_UP] >= 4) this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			if (flags[kFLAGS.AKBAL_LVL_UP] >= 5) this.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
			if (flags[kFLAGS.AKBAL_LVL_UP] >= 6) this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			if (flags[kFLAGS.AKBAL_LVL_UP] >= 7) this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			if (flags[kFLAGS.AKBAL_LVL_UP] >= 8) this.createPerk(PerkLib.LegendarySpeed, 0, 0, 0, 0);
			if (flags[kFLAGS.AKBAL_LVL_UP] >= 9) this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			if (flags[kFLAGS.AKBAL_LVL_UP] >= 10) this.createPerk(PerkLib.PrestigeJobTempest, 0, 0, 0, 0);
			if (flags[kFLAGS.AKBAL_LVL_UP] >= 11) this.createPerk(MutationsLib.CatlikeNimblenessPrimitive, 0, 0, 0, 0);
			if (flags[kFLAGS.AKBAL_LVL_UP] >= 12) this.createPerk(PerkLib.MythicalSpeed, 0, 0, 0, 0);
			if (flags[kFLAGS.AKBAL_LVL_UP] >= 13) this.createPerk(MutationsLib.CatlikeNimblenessEvolved, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
