/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.GlacialRift 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

public class WinterWolf extends Monster
	{
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.glacialRift.winterwolfScene.winAgainstWinterWolf();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.glacialRift.winterwolfScene.loseToWinterWolf();
		}
		
		override protected function performCombatAction():void
		{
			var size:Number = 0;
			if (player.tallness >= 96) size += 2;
			else if (player.tallness >= 72) size += 3;
			else if (player.tallness < 72) size += 4;
			var choice:Number = rand(size);
			if (choice == 0) eAttack();
			if (choice == 1) frostbite();
			if (choice == 2) {
				if (!player.hasStatusEffect(StatusEffects.WolfHold) && rand(2) == 0) wolfHold();
				else frostbite();
			}
			if (choice == 3) {
				if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) paw();
				else frostbite();
			}
		}
		
		public function frostbite():void {
			outputText("The wolf lunge, biting viciously at your leg.");
			var dmgtaken:Number = 0;
			var damage:Number = 0;
			if(!player.hasStatusEffect(StatusEffects.Frostbite)) {
				outputText(" You feel the cold enter your body and shake you to the very core weakening your resolve just as much as slowing down your movement.");
				if(player.str > 7) {
					player.str -= 6;
					showStatDown( 'str' );
					player.createStatusEffect(StatusEffects.Frostbite,6,0,0,0);
				}
				else {
					player.createStatusEffect(StatusEffects.Frostbite,0,0,0,0);
					damage += 20 + Math.round(rand(str / 4));
					player.takeMagicDamage(damage);
					dmgtaken += damage;
				}
				damage += 20 + Math.round(rand(str / 4));
				player.takeMagicDamage(damage);
				dmgtaken += damage;
				outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
			}
			else {
				outputText(" The coldness effects intensify as your movement slowing down even more.");
				if(player.str > 6) {
					player.str -= 5;
					showStatDown( 'str' );
					player.addStatusValue(StatusEffects.Frostbite,1,5);
				}
				else {
					damage += 20 + Math.round(rand(str / 4));
					player.takeMagicDamage(damage);
					dmgtaken += damage;
				}
				damage += 20 + Math.round(rand(str / 4));
				player.takeMagicDamage(damage);
				dmgtaken += damage;
				outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
			}
		}
		
		protected function wolfHold():void {
			outputText("The wolf suddenly grab you crushing you under its paw as it start tearing you apart with its maw.");
			player.createStatusEffect(StatusEffects.WolfHold,0,0,0,0); 
			if (player.findPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {
				player.takePhysDamage(8+rand(10));
			}
		}
		
		public function paw():void {
			outputText("The wolf smash you with its enormous paw you rail at the impact as it sends you flying across the field.");
			player.takePhysDamage(str);
			player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			createStatusEffect(StatusEffects.AbilityCooldown1, 3, 0, 0, 0);
			if (player.hasStatusEffect(StatusEffects.WolfHold)) player.removeStatusEffect(StatusEffects.WolfHold);
		}
		
		public function WinterWolf() 
		{
			this.a = "the ";
			this.short = "winter wolf";
			this.imageName = "winter-wolf";
			this.long = "You're facing a wolf that can only be described as oversized. The beast bigger than a horse is easily 10 feet tall with a pelt about just as white as the landscape below it. A small blue mist trail regularly escape its mouth subjesting its bite might be way worse then it appear.";
			// this.plural = false;
			this.createCock(18, 3, CockTypesEnum.WOLF);
			this.balls = 2;
			this.ballSize = 2;
			this.cumMultiplier = 2;
			createBreastRow(Appearance.breastCupInverse("flat"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 10*12;
			this.hips.type = Hips.RATING_BOYISH;
			this.butt.type = Butt.RATING_TIGHT;
			this.skin.growFur({color:"glacial white"});
			this.hairColor = "glacial white";
			this.hairLength = 8;
			initStrTouSpeInte(130, 160, 80, 90);
			initWisLibSensCor(80, 20, 15, 75);
			this.weaponName = "paws";
			this.weaponVerb="paw-slash";
			this.weaponAttack = 37;
			this.armorName = "fur";
			this.armorDef = 27;
			this.bonusHP = 800;
			this.bonusLust = 10;
			this.lust = 10;
			this.lustVuln = 0.4;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 33;
			this.gems = 100 + rand(25);
			this.drop = new WeightedDrop()
					.add(consumables.CHILLYP, 1)
					.add(null, 2);
			this.createStatusEffect(StatusEffects.GenericRunDisabled, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.IceNature, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}