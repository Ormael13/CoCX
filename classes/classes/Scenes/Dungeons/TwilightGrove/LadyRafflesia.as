/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.TwilightGrove 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class LadyRafflesia extends Monster
	{
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.twilightgrove.defeatLadyRafflesia();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.twilightgrove.defeatedByLadyRafflesia();
		}
		
		public function LadyRafflesia() 
		{
			this.a = " ";
			this.short = "Lady Rafflesia";
			this.long = "Sadly no description been provided beside name: Lady Rafflesia.";// You are fighting against an Alraune, an intelligent plant with the torso of a woman and the lower body of a giant flower. She seems really keen on raping you.
			this.bodyColor = "light green";
			this.hairColor = "dark green";
			initStrTouSpeInte(30, 420, 30, 180);
			initWisLibSensCor(180, 310, 150, 0);
			this.armorDef = 300;
			this.armorMDef = 60;
			this.bonusHP = 1000;
			this.bonusLust = 502;
			this.level = 42;
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
			this.imageName = "alraune";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_GAPING);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = rand(14) + 59;
			this.hips.type = Hips.RATING_CURVY + 3;
			this.butt.type = Butt.RATING_EXPANSIVE;
			this.lowerBody = LowerBody.PLANT_FLOWER;
			this.hairLength = 6;
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.weaponAttack = 1;
			this.armorName = "skin";
			this.lust = 20 + rand(40);
			this.lustVuln = 0.2;
			this.gems = rand(20) + 5;
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createStatusEffect(StatusEffects.AlrauneRunDisabled, 0, 0, 0, 0);
			createStatusEffect(StatusEffects.Level,6,0,0,0);
			checkMonster();
		}
		
	}

}