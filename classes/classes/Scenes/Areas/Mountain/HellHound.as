﻿package classes.Scenes.Areas.Mountain
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.Scenes.Dungeons.RiverDungeon;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class HellHound extends Monster
	{
		public var floor1:RiverDungeon = new RiverDungeon();
		
		protected function hellhoundFire():void {
			//Blind dodge change
			if(player.getEvasionRoll()) {
				outputText("Both the hellhound's heads breathe in deeply before blasting a wave of dark fire at you.  You easily avoid the wave, diving to the side and making the most of your talents at evasion.");
			}
			else {
				//Determine the damage to be taken
				var temp:Number = (tou + rand(10)) * 2;
				temp = Math.round(temp);
				if (player.hasStatusEffect(StatusEffects.Blizzard)) {
					player.addStatusValue(StatusEffects.Blizzard,1,-1);
					temp *= 0.2;
					outputText("Both the hellhound's heads breathe in deeply before blasting a wave of dark fire at you. While the flames don't burn much due to protection of blizzard, the unnatural heat fills your body with arousal. ");
				}
				else outputText("Both the hellhound's heads breathe in deeply before blasting a wave of dark fire at you. While the flames don't burn much, the unnatural heat fills your body with arousal. ");
				temp = Math.round(temp);
				player.takeFireDamage(temp, true);
				player.takeLustDamage(20+(player.effectiveSensitivity()/10), true);
				statScreenRefresh();
				if(Math.round(player.HP) <= Math.round(player.minHP())) {
					doNext(SceneLib.combat.endHpLoss);
					return;
				}
				if(player.lust >= player.maxOverLust() && !SceneLib.combat.tyrantiaTrainingExtension()) {
					doNext(SceneLib.combat.endLustLoss);
					return;
				}
			}
			doNext(EventParser.playerMenu);
		}
		protected function hellhoundScent():void {
			if(player.hasStatusEffect(StatusEffects.NoFlee)) {
				if(spe == 100) {
					hellhoundFire();
					return;
				}
				else {
					outputText("The hellhound sniffs your scent again, seemingly gaining more and more energy as he circles faster around you.");
					speStat.core.value = 100;	
				}
			}
			else {
				speStat.core.value += 40;
				outputText("The hellhound keeps his four eyes on you as he sniffs the ground where you were moments ago. He raises his heads back up and gives you a fiery grin - he seems to have acquired your scent!  It'll be hard to get away now...");
				player.createStatusEffect(StatusEffects.NoFlee,0,0,0,0);
			}
		}
		

		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) SceneLib.combat.cleanupAfterCombatImpl();
			else if (player.hasStatusEffect(StatusEffects.SoulArenaGauntlet)) SceneLib.hexindao.gauntletchallange2fight3();
			else SceneLib.mountain.hellHoundScene.hellHoundPostFightOptions(hpVictory);
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) floor1.defeatedByHellHound();
			else if(pcCameWorms){
				outputText("\n\nThe hellhound snorts and leaves you to your fate.");
				doNext(SceneLib.combat.cleanupAfterCombatImpl);
			}
			else SceneLib.mountain.hellHoundScene.hellhoundRapesPlayer();
		}

		public function HellHound(noInit:Boolean=false)
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				initStrTouSpeInte(69, 69, 54, 1);
				initWisLibSensCor(1, 95, 20, 100);
				this.weaponAttack = 15;
				this.armorDef = 14;
				this.armorMDef = 2;
				this.bonusLust = 125;
				this.level = 6;
				this.gems = 15 + rand(12);
				this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
			}
			else {
				initStrTouSpeInte(281, 281, 270, 1);
				initWisLibSensCor(1, 317, 77, 100);
				this.weaponAttack = 60;
				this.armorDef = 330;
				this.armorMDef = 60;
				this.bonusLust = 443;
				this.level = 49;
				this.gems = 25+rand(7);
			}
			if (noInit) return;
			trace("HellHound Constructor!");
			this.a = "the ";
			this.short = "hellhound";
			this.imageName = "hellhound";
			this.long = "It looks like a large demon on all fours with two heads placed side-by-side. The heads are shaped almost like human heads, but they have dog ears on the top and have a long dog snout coming out where their mouths and noses would be.  Its eyes and mouth are filled with flames and its hind legs capped with dog paws, but its front ones almost look like human hands.  Its limbs end in large, menacing claws. A thick layer of dark fur covers his entire body like armor.  Both heads look at you hungrily as the hellhound circles around you. You get the feeling that reasoning with this beast will be impossible.";
			// this.plural = false;
			this.createCock(8,2,CockTypesEnum.DOG);
			this.createCock(8,2,CockTypesEnum.DOG);
			this.balls = 2;
			this.ballSize = 4;
			this.cumMultiplier = 5;
			// this.hoursSinceCum = 0;
			this.createBreastRow();
			this.createBreastRow();
			this.createBreastRow();
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 47;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE + 1;
			this.lowerBody = LowerBody.DOG;
			this.skin.growFur({color:"black"});
			this.hairColor = "red";
			this.hairLength = 3;
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.armorName = "thick fur";
			this.lust = 25;
			this.drop = new WeightedDrop().add(consumables.CANINEP, 3)
					.addMany(1, consumables.BULBYPP,
							consumables.KNOTTYP,
							consumables.BLACKPP,
							consumables.DBLPEPP,
							consumables.LARGEPP);
			this.tailType = Tail.DOG;
			this.abilities = [
				{call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{call: hellhoundFire, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_FIRE]},
				{call: hellhoundScent, type: ABILITY_SPECIAL, range: RANGE_SELF, tags:[]},
			];
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
