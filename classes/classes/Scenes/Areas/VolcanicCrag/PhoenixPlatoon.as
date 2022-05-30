/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.VolcanicCrag 
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
	
	public class PhoenixPlatoon extends Monster
	{
		//ATTACK ONE: SPARTAN RUSH
		public function phoenixPlatoonRush():void {
			outputText("You fall back under a hail of scimitar attacks.  The sheer number of phoenixes attacking is bad enough, but their attacks are perfectly coordinated, leaving virtually no room for escape or maneuver without getting hit!\n");
			//(Effect: Multiple medium-damage attacks)
			//(Effect: Multiple light attacks)
			createStatusEffect(StatusEffects.Attacks, 6 + rand(4),0,0,0);
			eAttack();
		}

		//ATTACK TWO: FIRE BREATH
		public function phoenixPlatoonFireBreath():void {
			//(Effect: One heavy-damage attack)
			var damage:Number = ((inte + wis) * 1.2) + rand(80);
			outputText("Suddenly, the shield wall parts, revealing three members of the platoon, a particularly muscular girls with a raging erections.  Before you can consider what's going on, they rears back and huffs at you.  To your horror, a great gout of fire erupts from their mouths, rolling towards you.  You dive, but are still caught partially in the inferno.");
			if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				player.addStatusValue(StatusEffects.Blizzard, 1, -1);
				outputText("  Luckly blizzard still surrounding you lowering amount of fire that pass throu it.");
				damage *= 0.2;
			}
			damage = Math.round(damage);
			damage = player.takeFireDamage(damage, true);
			damage = player.takeFireDamage(damage, true);
			damage = player.takeFireDamage(damage, true);
		}
		//ATTACK THREE: LUSTBANG GRENADE
		public function phoenixPlatoonLustbang():void {
			outputText("\"<i>LUSTBANGS OUT!</i>\" one of the rear-most phoenixes shouts, causing all the other warriors to duck down behind their shields.  Oh, shit!  Few large glass spheres rolls out from the shield wall, and immediately explodes in a great pink cloud.  You cough and wave your arms, but by the time the cloud has dissipated, you feel lightheaded and lusty, barely able to resist the urge to throw yourself at the phoenixes and beg for their cocks and cunts.");
			//(Effect: Large lust increase)
			player.dynStats("lus", Math.round(120+(player.lib*1.4)));
		}
		
		override protected function performCombatAction():void
		{
			if(!hasStatusEffect(StatusEffects.Platoon)) {
				phoenixPlatoonRush();
				createStatusEffect(StatusEffects.Platoon,0,0,0,0);
			}
			else if(statusEffectv1(StatusEffects.Platoon) == 0) {
				phoenixPlatoonFireBreath();
				addStatusValue(StatusEffects.Platoon,1,1);
			}
			else {
				phoenixPlatoonLustbang();
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
		
		public function PhoenixPlatoon() 
		{
			this.a = "the ";
			this.short = "phoenix platoon";
			this.imageName = "phoenixmob";
			this.long = "You are faced with a platoon of heavy infantry, all armed to the teeth and protected by chain vests and shields. They look like a cross between salamander and harpy, humanoid save for crimson wings, scaled feet, and long fiery tails. They stand in a tight-knit shield wall, each phoenix protecting herself and the warrior next to her with their tower-shield. Their scimitars cut great swaths through the room as they slowly advance upon you.";
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
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(283, 234, 255, 140);
			initWisLibSensCor(130, 181, 114, 50);
			this.weaponName = "spears";
			this.weaponVerb="stab";
			this.weaponAttack = 117;
			this.armorName = "armor";
			this.armorDef = 132;
			this.armorMDef = 30;
			this.bonusHP = 2000;
			this.bonusLust = 369;
			this.lust = 20;
			this.lustVuln = .15;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 74;
			this.gems = rand(35)+200;
			this.additionalXP = 250;
			this.horns.type = Horns.DRACONIC_X2;
			this.horns.count = 2;
			this.tailType = Tail.SALAMANDER;
			this.wings.type = Wings.FEATHERED_PHOENIX;
			this.drop = new WeightedDrop(consumables.NOCELIQ, 1);
			this.createPerk(PerkLib.EnemyLargeGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			checkMonster();
		}
	}
}