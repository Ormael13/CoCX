/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Ashlands
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;
	
	public class PhoenixSquadAshland extends Monster
	{
		//ATTACK ONE: SPARTAN RUSH
		public function phoenixSquadRush():void {
			outputText("You fall back under a hail of scimitar attacks.  The sheer number of quasi-phoenixes attacking is bad enough, but their attacks are perfectly coordinated, leaving virtually no room for escape or to maneuver without getting hit!\n");
			//(Effect: Multiple medium-damage attacks)
			//(Effect: Multiple light attacks)
			createStatusEffect(StatusEffects.Attacks, 4 + rand(3),0,0,0);
			eAttack();
		}

		//ATTACK TWO: FIRE BREATH
		public function phoenixSquadFireBreath():void {
			//(Effect: One heavy-damage attack)
			var damage:Number = ((inte + wis) * 1.2) + rand(80);
			outputText("Suddenly, the shield wall parts, revealing two particularly muscular members of the platoon with raging erections.  Before you can react, they rear back, light erupting from their throats as they unleash a burst of fire-breath right at you.  You dive, but are still partially caught in the inferno.");
			if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				player.addStatusValue(StatusEffects.Blizzard, 1, -1);
				outputText("Luckily, you still have your blizzard spell active, the whirling snow mitigating the phoenix's flame somewhat");
				damage *= 0.2;
			}
			damage = Math.round(damage);
			damage = player.takeFireDamage(damage, true);
			damage = player.takeFireDamage(damage, true);
		}
		//ATTACK THREE: LUSTBANG GRENADE
		public function phoenixSquadLustbang():void {
			outputText("\"<i>LUSTBANGS OUT!</i>\" one of the rear-most quasi-phoenixes shouts, causing all the other warriors to duck down behind their shields.  Oh, shit!  Several large glass spheres are thrown out from behind the shield wall, immediately exploding into a great pink cloud.  You cough and wave your arms, but by the time the cloud has dissipated, you feel lightheaded and horny. Despite yourself...Those quasi-Phoenixes aren't bad looking... and their cocks and cunts are tempting.");
			//(Effect: Large lust increase)
			player.takeLustDamage(Math.round(75+(player.lib*1.2)), true);
		}
		
		override protected function performCombatAction():void
		{
			if(!hasStatusEffect(StatusEffects.Platoon)) {
				phoenixSquadRush();
				createStatusEffect(StatusEffects.Platoon,0,0,0,0);
			}
			else if(statusEffectv1(StatusEffects.Platoon) == 0) {
				phoenixSquadFireBreath();
				addStatusValue(StatusEffects.Platoon,1,1);
			}
			else {
				phoenixSquadLustbang();
				removeStatusEffect(StatusEffects.Platoon);
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.highMountains.phoenixScene.winAgainstPhoenix(true);
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nYour foes doesn't seem disgusted enough to leave...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.highMountains.phoenixScene.loseToPhoenix(true);
			}
		}
		
		public function PhoenixSquadAshland()
		{
			this.a = "the ";
			this.short = "quasi-phoenix squad";
			this.imageName = "phoenixmob";
			this.long = "You are faced with a squad of heavy infantry, all armed to the teeth and protected by chain vests and shields. They look like a cross between a salamander and a harpy, humanoid save for crimson wings, scaled feet, and long fiery tails. They stand in a tight-knit shield wall, each quasi-phoenix protecting herself and the warrior next to her with her tower-shield. Their scimitars cut great swaths through the room as they slowly advance upon you.";
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createCock();
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 3;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_LOOSE);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = rand(8) + 70;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.lowerBody = LowerBody.SALAMANDER;
			this.bodyColor = "red";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(253, 204, 225, 120);
			initWisLibSensCor(110, 151, 103, 10);
			this.weaponName = "spears";
			this.weaponVerb="stab";
			this.weaponAttack = 100;
			this.armorName = "armor";
			this.armorDef = 104;
			this.armorMDef = 24;
			this.bonusHP = 1500;
			this.bonusLust = 295;
			this.lust = 20;
			this.lustVuln = .15;
			this.level = 41;
			this.gems = rand(40)+300;
			this.additionalXP = 300;
			this.horns.type = Horns.DRACONIC_X2;
			this.horns.count = 2;
			this.tailType = Tail.SALAMANDER;
			this.wings.type = Wings.FEATHERED_PHOENIX;
			this.drop = new WeightedDrop(consumables.NOCELIQ, 1);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			checkMonster();
		}
	}
}
