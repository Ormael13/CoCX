/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs
{
	import classes.*;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Hips;
	import classes.GlobalFlags.kFLAGS;
	import classes.internals.*;
	
	public class Jeniffer extends Monster
	{
		public function Specials2():void {
			outputText("The golem's visage twists into a grimace of irritation, and it swings its hand at you in a vicious backhand.");
			var damage:Number = Math.round(((str + weaponAttack) * 3) - rand(player.tou+player.armorDef));
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise swing!");
			else
			{
				outputText(" It hits you square in the chest. ");
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		public function Specials1():void {
			//Determine if dodged!
			if (player.getEvasionRoll()) {
				outputText("J1c tries to clinch you, but you use your speed to keep just out of reach.\n");
				return;
			}
			var damage:Number = Math.round((str + weaponAttack) - rand(player.tou+player.armorDef));
			if (damage < 0) damage = 0;
			outputText("J1c ducks and jinks, working to close quarters, and clinches you. Unable to get your weapon into play, you can only ");
			if (player.armorDef >= 10 || damage == 0) {
				//(armor-dependent Health damage, fullplate, chain, scale, and bee chitin armor are unaffected, has a chance to inflict 'Bleed' damage which removes 4-10% of health for the next three turns if successful)
				outputText("writhe as she painfully drags the sharp end of the metal shards on her golem forearm down your back");
				if (!player.immuneToBleed()) player.createStatusEffect(StatusEffects.IzmaBleed,3,0,0,0);
			}
			else outputText("laugh as her blades scape uselessly at your armor-clad back");
			outputText(" before breaking her embrace and leaping away. ");
			player.takePhysDamage(damage, true);
		}
		
		override protected function performCombatAction():void {
			if (flags[kFLAGS.JENIFFER_LVL_UP] >= 1 && flags[kFLAGS.JENIFFER_LVL_UP] < 4) {
				var choice1:Number = rand(2);
				if (choice1 == 0) eAttack();
				if (choice1 == 1) {
					if (!player.hasStatusEffect(StatusEffects.IzmaBleed) && rand(2) == 0) Specials1();
					else eAttack();
				}
			}
			if (flags[kFLAGS.JENIFFER_LVL_UP] < 1) {
				var choice0:Number = rand(2);
				if (choice0 == 0) eAttack();
				if (choice0 == 1) {
					if (!player.hasStatusEffect(StatusEffects.IzmaBleed) && rand(2) == 0) Specials1();
					else eAttack();
				}
			}
		}
		
		public function Jeniffer()
		{
			this.a = "the ";
			if (flags[kFLAGS.JENIFFER_LVL_UP] < 1) {
				this.short = "J1c golem";
				this.imageName = "J1Golem";
				this.long = "You're currently fighting a golemancer controling personaly created golem called J1c. It's six feet tall with general shape of a female but lacking any fine details. It stone body is covered with thin soulmetal plates in many placed and from it looks like using spike covered fists to smash enemies. Only goblin's head isn't protected showing her green skin, pointed ears, and purple hair.";
				createBreastRow(Appearance.breastCupInverse("A"));
				this.tallness = 72;
				initStrTouSpeInte(60, 80, 40, 100);
				initWisLibSensCor(100, 90, 50, 0);
				this.weaponName = "spiked fists";
				this.weaponVerb = "smash";
				this.weaponAttack = 18;
				this.armorName = "stone covered by thin soulmetal plating";
				this.armorDef = 50;
				this.armorMDef = 50;
				this.bonusHP = 100;
				this.bonusLust = 35;
				this.lustVuln = .2;
				this.level = 15;
			}
			if (flags[kFLAGS.JENIFFER_LVL_UP] == 1) {
				this.short = "J2a golem";
				this.long = "You're currently fighting a golemancer controling personaly created golem called J2a. It's twelve feet tall with general shape of a female but lacking any fine details. It stone body is covered with soulmetal plates in many placed and it looks like using lance to stab enemies.  Only goblin's head isn't protected showing her green skin, pointed ears, and purple hair.";
				this.tallness = 144;
				initStrTouSpeInte(100, 120, 80, 100);
				initWisLibSensCor(100, 100, 60, 0);
				this.weaponAttack = 36;
				this.armorDef = 100;
				this.armorMDef = 100;
				this.bonusHP = 200;
				this.bonusLust = 56;
				this.level = 21;
			}
			if (flags[kFLAGS.JENIFFER_LVL_UP] == 2) {
				this.short = "J2b golem";
				this.imageName = "J2Golem";
				this.long = "You're currently fighting a golemancer controling personaly created golem called J2a. It's fourteen feet tall with general shape of a female but lacking any fine details. It stone body is covered with soulmetal plates in many placed and it looks like using lance to stab enemies.  Only goblin's head isn't protected showing her green skin, pointed ears, and purple hair.";
				this.tallness = 168;
				initStrTouSpeInte(120, 140, 100, 100);
				initWisLibSensCor(100, 110, 70, 0);
				this.weaponAttack = 44;
				this.armorDef = 125;
				this.armorMDef = 125;
				this.bonusHP = 200;
				this.bonusLust = 56;
				this.level = 27;
			}
			if (flags[kFLAGS.JENIFFER_LVL_UP] == 3) {
				this.short = "J2c golem";
				this.imageName = "J2Golem";
				this.long = "You're currently fighting a golemancer controling personaly created golem called J2a. It's sixteen feet tall with general shape of a female but lacking any fine details. It stone body is covered with soulmetal plates in many placed and it looks like using lance to stab enemies.  Only goblin's head isn't protected showing her green skin, pointed ears, and purple hair.";
				this.tallness = 192;
				initStrTouSpeInte(140, 160, 120, 100);
				initWisLibSensCor(100, 120, 80, 0);
				this.weaponAttack = 52;
				this.armorDef = 150;
				this.armorMDef = 150;
				this.bonusHP = 200;
				this.bonusLust = 56;
				this.level = 33;
			}
			if (flags[kFLAGS.JENIFFER_LVL_UP] >= 1 && flags[kFLAGS.JENIFFER_LVL_UP] < 4) {
				this.imageName = "J2Golem";
				createBreastRow(Appearance.breastCupInverse("B"));
				this.weaponName = "lance";
				this.weaponVerb = "piercing stab";
				this.armorName = "magically enhanced stone covered by soulmetal plating";
				this.lustVuln = .15;
			}
			if (flags[kFLAGS.JENIFFER_LVL_UP] >= 4 && flags[kFLAGS.JENIFFER_LVL_UP] < 7) {//lub później niż 7 upgrade
				this.imageName = "J3Golem";
				createBreastRow(Appearance.breastCupInverse("C"));
				this.weaponName = "lance";
				this.weaponVerb = "piercing stab";
				this.armorName = "(cos zamiast kamieni) covered by (soulmetal plating)";//coś lepszego od zwykłych soulmetal plates
				this.lustVuln = .1;
			}
			if (flags[kFLAGS.JENIFFER_LVL_UP] >= 7 && flags[kFLAGS.JENIFFER_LVL_UP] < 11) {
				this.imageName = "J4Golem";
				createBreastRow(Appearance.breastCupInverse("D"));
				this.weaponName = "lance";
				this.weaponVerb = "piercing stab";
				this.armorName = "magically enhanced (cos zamiast kamieni) covered by (soulmetal plating)";
				this.lustVuln = .05;
			}
			this.plural = false;//J3 - thirty, J4 - ninety
			this.createVagina(false, VaginaClass.WETNESS_DRY, VaginaClass.LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,10,0,0,0);
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.hips.type = Hips.RATING_BOYISH;
			this.butt.type = Butt.RATING_BUTTLESS;
			this.bodyColor = "dark green";
			this.hairColor = "purple";
			this.hairLength = 4;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
			if (flags[kFLAGS.JENIFFER_LVL_UP] >= 1 && flags[kFLAGS.JENIFFER_LVL_UP] < 4) this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			if (flags[kFLAGS.JENIFFER_LVL_UP] >= 1) {
				this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
				//this.createPerk(PerkLib., 0, 0, 0, 0);
			}
			if (flags[kFLAGS.JENIFFER_LVL_UP] >= 2) {
				this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
				//this.createPerk(PerkLib., 0, 0, 0, 0);
			}
			if (flags[kFLAGS.JENIFFER_LVL_UP] >= 3) {
				this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
				//this.createPerk(PerkLib., 0, 0, 0, 0);
			}
			checkMonster();
		}
	}
}
