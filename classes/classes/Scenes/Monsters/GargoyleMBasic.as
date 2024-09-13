/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.internals.*;
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	
	public class GargoyleMBasic extends AbstractGargoyle
	{
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Provoke)) {
				var choiceP:Number = rand(3);
				if (choiceP == 0) GargoyleStoneClawAttack();
				if (choiceP == 1) {
					if (hasStatusEffect(StatusEffects.AbilityCooldown1)) GargoyleStoneClawAttack();
					else GargoyleTailSlamAttack();
				}
				if (choiceP == 2) {
					if (hasStatusEffect(StatusEffects.AbilityCooldown3)) GargoyleStoneClawAttack();
					else GargoyleWingBuffetAttack();
				}
			}
			else {
				if (this.HPRatio() < 0.9) {
					var choice:Number = rand(6);
					if (choice < 3) eAttack();
					if (choice == 3) GargoyleStoneClawAttack();
					if (choice == 4) {
						if (hasStatusEffect(StatusEffects.AbilityCooldown1)) GargoyleStoneClawAttack();
						else GargoyleTailSlamAttack();
					}
					if (choice == 5) {
						if (hasStatusEffect(StatusEffects.AbilityCooldown3)) GargoyleStoneClawAttack();
						else GargoyleWingBuffetAttack();
					}
				}
				else eAttack();
			}
		}
		
		public function GargoyleMBasic() 
		{
			this.a = "the ";
			this.short = "basic gargoyle";
			this.imageName = "basic gargoyle";
			this.long = "You're currently fighting basic gargoyle. It's ten feet tall with masculine frame with bat wings and mace-like tail, but without any sexual characteristics. It stone body is without any cracks and he's using stone claws to slash enemies.";
			this.createBreastRow(0, 1);
			initGenderless();
			this.tallness = 120;
			initStrTouSpeInte(150, 120, 90, 10);
			initWisLibSensCor(10, 10, 10, 0);
			this.tallness = 120;
			this.drop = new ChainedDrop()
					.add(useables.GOLCORE, 1/4);
			this.level = 24;
			this.bonusHP = 500;
			this.additionalXP = 500;
			this.lustVuln = 0.01;
			this.weaponName = "stone claws";
			this.weaponVerb = "claw-slash";
			this.weaponAttack = 75;
			this.armorName = "stone";
			this.armorDef = 75;
			this.armorMDef = 75;
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			checkMonster();
		}
	}
}