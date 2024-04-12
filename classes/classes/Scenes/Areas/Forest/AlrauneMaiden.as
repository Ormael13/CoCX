/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Forest
{
import classes.*;
import classes.Scenes.Holidays;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

public class AlrauneMaiden extends Alraune
	{
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) cleanupAfterCombat();
			else SceneLib.forest.alrauneScene.alrauneDeepwoodsWon();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) cleanupAfterCombat();
			else SceneLib.forest.alrauneScene.alrauneDeepwoodsLost();
		}
		
		public function AlrauneMaiden()
		{
			super();
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				this.a = "a ";
				this.short = "mist alraune";
				this.long = "You are fighting against a Mist Alraune Maiden, an intelligent plant with the torso of a woman and the lower body of a giant flower. Whole her body cover faint vein-like lines. She seems really keen on raping you.";
				this.bodyColor = "light green";
				this.hairColor = "light purple";
			}
			else if (Holidays.isHalloween()) {
				this.a = "";
				this.short = "Jack-O-Raune";
				this.long = "You are fighting against an Jack-O-Raune, an intelligent plant with the torso of a woman and the lower body of a giant pumpkin with snaking tentacle vines. She seems really keen on raping you.";
				this.bodyColor = "pale orange";
				this.hairColor = "green";
			}
			else {
				this.a = "an ";
				this.short = "alraune maiden";
				this.long = "You are fighting against an Alraune Maiden, an intelligent plant with the torso of a woman and the lower body of a giant flower. She seems really keen on raping you.";
				this.bodyColor = "light green";
				this.hairColor = "dark green";
			}
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				initStrTouSpeInte(17, 330, 17, 130);
				initWisLibSensCor(130, 220, 90, 0);
				this.armorDef = 115;
				this.armorMDef = 23;
				this.bonusHP = 700;
				this.bonusLust = 372;
				this.level = 62;
				this.drop = new WeightedDrop().
				add(useables.PCSHARD,10).
				add(consumables.RAUNENECT,4).
				addMany(1,consumables.MARAFRU,
						consumables.HEALHERB,
						consumables.MOONGRASS,
						consumables.SNAKEBANE,
						consumables.IRONWEED,
						consumables.BLADEFERN);
			}
			else {
				initStrTouSpeInte(15, 300, 15, 120);
				initWisLibSensCor(120, 200, 75, 0);
				this.armorDef = 100;
				this.armorMDef = 20;
				this.bonusHP = 500;
				this.bonusLust = 329;
				this.level = 54;
				this.drop = new WeightedDrop().
				add(consumables.RAUNENECT,7).
				addMany(1,consumables.MARAFRU,
						consumables.HEALHERB,
						consumables.HEALHERB,
						consumables.HEALHERB,
						consumables.MOONGRASS,
						consumables.SNAKEBANE,
						consumables.IRONWEED,
						consumables.BLADEFERN);
			}
			this.imageName = "alraune";
			this.gems = rand(35) + 25;
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
