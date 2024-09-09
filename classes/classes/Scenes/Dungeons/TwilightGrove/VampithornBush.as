/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.TwilightGrove 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class VampithornBush extends Monster
	{
		public function Strangulate():void {
			outputText("A vine surges out of the bush and wraps around your neck, strangling you and silencing your spells!\n\n");
			player.createStatusEffect(StatusEffects.Strangulate,4,0,0,0);
		}
		
		public function Thorn():void {
			outputText("The bush throws its thorns at you like darts. You are covered with grievous wounds!\n\n");
			var dmg:Number = 0;
			dmg += this.str;
			dmg += eBaseStrengthDamage();
			dmg += this.weaponAttack;
			dmg = Math.round(dmg);
			player.takePhysDamage(dmg, true);
			player.takePhysDamage(dmg, true);
			player.takePhysDamage(dmg, true);
			if (!player.immuneToBleed() && !player.hasStatusEffect(StatusEffects.IzmaBleed)) player.createStatusEffect(StatusEffects.IzmaBleed,3,0,0,0);
		}
		
		override protected function performCombatAction():void
		{
			if (!player.hasStatusEffect(StatusEffects.Strangulate)) Strangulate();
			else Thorn();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.twilightgrove.defeatVampithornBush();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.twilightgrove.defeatedByVampithornBush();
		}
		
		public function VampithornBush() 
		{
			this.a = "the ";
			this.short = "Vampithorn bush";
			this.long = "Sadly no description been provided beside name: Vampithorn bush.";
			this.imageName = "tentaclebeast";
			initStrTouSpeInte(33, 318, 45, 45);
			initWisLibSensCor(40, 110, 20, 100);
			this.weaponAttack = 20;
			this.armorDef = 30;
			this.armorMDef = 30;
			this.bonusHP = 5000;
			this.bonusLust = 165;
			this.level = 35;
			this.gems = rand(25)+10;
			// this.plural = false;
			this.createBreastRow(0, 1);
			initGenderless();
			this.pronoun1 = "it";
			this.pronoun2 = "it";
			this.pronoun3 = "its";
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(9) + 70;
			this.hips.type = Hips.RATING_BOYISH;
			this.butt.type = Butt.RATING_BUTTLESS;
			this.skin.setBaseOnly({color:"green"});
			this.skinDesc = "bark";
			this.hairColor = "green";
			this.hairLength = 1;
			this.weaponName = "vine";
			this.weaponVerb="thorny tendril";
			this.armorName = "bark";
			this.lust = 10;
			this.lustVuln = 0.8;
			this.drop = new WeightedDrop().addMany(1,consumables.HEALHERB,
					consumables.HEALHERB,
					consumables.HEALHERB,
					consumables.MOONGRASS,
					consumables.SNAKEBANE,
					consumables.IRONWEED,
					consumables.BLADEFERN);
			this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 10, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 10, 0, 0, 0);
			this.createPerk(PerkLib.MonsterRegeneration, 10, 0, 0, 0);
			checkMonster();
		}
		
	}

}