/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Explore 
{
import classes.*;
import classes.GlobalFlags.*;
import classes.Scenes.Areas.Forest.Alraune;
import classes.Scenes.Holidays;
import classes.internals.ChainedDrop;

	public class SeabedAlrauneBoss extends Alraune
	{
		override protected function performCombatAction():void
		{
			if (player.statusEffectv1(StatusEffects.HeroBane) < 5) player.addStatusValue(StatusEffects.HeroBane, 1, 5);
			if (hasStatusEffect(StatusEffects.Level)) {
				if (!hasStatusEffect(StatusEffects.Stunned) && player.hasStatusEffect(StatusEffects.CastedSpell)) alrauneStrangulate();
				else {
					if (Holidays.isHalloween()) {
						var choice1:Number = rand(3);
						if (choice1 == 0) alrauneTeaseAttack();
						if (choice1 == 1) {
							if (!hasStatusEffect(StatusEffects.LustAura)) alraunePollenCloud();
							else alrauneTeaseAttack();
						}
						if (choice1 == 2) alrauneHaloweenSpecial();
					}
					else {
						var choice2:Number = rand(2);
						if (choice2 == 0) alrauneTeaseAttack();
						if (choice2 == 1) {
							if (!hasStatusEffect(StatusEffects.LustAura)) alraunePollenCloud();
							else alrauneTeaseAttack();
						}
					}
				}
				if (!hasStatusEffect(StatusEffects.Climbed)) {
					outputText("\n\nMeanwhile the vines keep pulling you toward the pitcher.");
					trapLevel(-1);
				}
				else removeStatusEffect(StatusEffects.Climbed);
			}
			else super.performCombatAction();
		}
		
		public function SeabedAlrauneBoss() 
		{
			super();
			if (Holidays.isHalloween()) {
				this.short = "Jack-O-Raune";
				this.long = "You are fighting against a Jack-O-Raune, an intelligent plant with the torso of a woman and the lower body of a giant pumpkin with snaking tentacle vines. She seems really keen on raping you.";
				this.skinTone = "pale orange";
				this.hairColor = "dark green";
			}
			else {
				this.short = "aquatic alraune";
				this.long = "You are fighting against an Aquatic Alraune, an intelligent plant with the torso of a woman and the lower body of a giant flower. She's huge and seems really keen on raping you.";
				this.skinTone = "light green";
				this.hairColor = "dark green";
			}
			initStrTouSpeInte(540, 1240, 820, 560);
			initWisLibSensCor(560, 720, 500, 50);
			this.tallness = rand(11) + 110;
			this.armorDef = 90;
			this.armorMDef = 9;
			this.bonusHP = 200;
			this.bonusLust = 1355;
			this.level = 135;
			this.gems = rand(25) + 15;
			this.drop = new ChainedDrop().add(consumables.MARAFRU, 1 / 6);
				//	.add(consumables.W__BOOK, 1 / 4)
				//	.add(consumables.BEEHONY, 1 / 2)
				//	.elseDrop(useables.B_CHITN);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.MonsterRegeneration, 2, 0, 0, 0);
			this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			checkMonster();
		}
	}
}