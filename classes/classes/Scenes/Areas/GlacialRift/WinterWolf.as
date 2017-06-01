/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.GlacialRift 
{
	import classes.*;
	import classes.internals.WeightedDrop;
	import classes.GlobalFlags.kFLAGS;
	
	public class WinterWolf extends Monster 
	{
		override public function defeated(hpVictory:Boolean):void
		{
			game.glacialRift.winterwolfScene.winAgainstWinterWolf();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.glacialRift.winterwolfScene.loseToWinterWolf();
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
			outputText("The wolf lunge, biting viciously at your leg.", false);
			var dmgtaken:Number = 0;
			var damage:Number = 0;
			if(!player.hasStatusEffect(StatusEffects.Frostbite)) {
				outputText(" You feel the cold enter your body and shake you to the very core weakening your resolve just as much as slowing down your movement.", false);
				if(player.str > 7) {
					player.str -= 6;
					showStatDown( 'str' );
					player.createStatusEffect(StatusEffects.Frostbite,6,0,0,0);
				}
				else {
					player.createStatusEffect(StatusEffects.Frostbite,0,0,0,0);
					damage += 20 + Math.round(rand(str / 4));
					player.takeDamage(damage);
					dmgtaken += damage;
				}
				damage += 20 + Math.round(rand(str / 4));
				player.takeDamage(damage);
				dmgtaken += damage;
				outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)", false);
			}
			else {
				outputText(" The coldness effects intensify as your movement slowing down even more.", false);
				if(player.str > 6) {
					player.str -= 5;
					showStatDown( 'str' );
					player.addStatusValue(StatusEffects.Frostbite,1,5);
				}
				else {
					damage += 20 + Math.round(rand(str / 4));
					player.takeDamage(damage);
					dmgtaken += damage;
				}
				damage += 20 + Math.round(rand(str / 4));
				player.takeDamage(damage);
				dmgtaken += damage;
				outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)", false);
			}
			combatRoundOver();
		}
		
		protected function wolfHold():void {
			outputText("The wolf suddenly grab you crushing you under its paw as it start tearing you apart with its maw.", false);
			player.createStatusEffect(StatusEffects.WolfHold,0,0,0,0); 
			if (player.findPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {
				player.takeDamage(8+rand(10));
			}
			combatRoundOver();
		}
		
		public function paw():void {
			outputText("The wolf smash you with its enormous paw you rail at the impact as it sends you flying across the field.", false);
			player.takeDamage(str);
			player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			createStatusEffect(StatusEffects.AbilityCooldown1, 3, 0, 0, 0);
			if (player.hasStatusEffect(StatusEffects.WolfHold)) player.removeStatusEffect(StatusEffects.WolfHold);
			combatRoundOver();
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
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = 10*12;
			this.hipRating = HIP_RATING_BOYISH;
			this.buttRating = BUTT_RATING_TIGHT;
			this.skin.growFur({color:"glacial white"});
			this.hairColor = "glacial white";
			this.hairLength = 8;
			initStrTouSpeInte(130, 160, 80, 90);
			initLibSensCor(20, 15, 75);
			this.weaponName = "paws";
			this.weaponVerb="paw-slash";
			this.weaponAttack = 37 + (8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "fur";
			this.armorDef = 27 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
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
			this.str += 39 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 48 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 24 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 27 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 5760;
			checkMonster();
		}
		
	}

}