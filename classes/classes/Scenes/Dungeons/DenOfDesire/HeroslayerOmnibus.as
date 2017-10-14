/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.DenOfDesire 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	public class HeroslayerOmnibus extends Monster
	{
		
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.dungeons.denofdesire.defeatedHeroslayerOmnibus();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.dungeons.denofdesire.defeatedByHeroslayerOmnibus();
		}
		
		public function HeroslayerOmnibus() 
		{
			this.a = "the";
			this.short = "hero slayer omnibus";
			this.imageName = "hero slayer omnibus";
			this.long = "This omnibus has lustrous black skin and a pair of goat like horns sitting like a crown above her fiery red hair. While you don't know her name you're pretty sure she defeated " + flags[kFLAGS.GAR_NAME] + "’s former master and that she's a serious threat. She wields a flaming whip and seems to hold a purple fireball in her other hand. Her very presence is intoxicating, saturating the very air with lust.";
			// this.plural = false;
			this.createCock(10,2,CockTypesEnum.DEMON);
			this.createVagina(false, VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 20, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,15,0,0,0);
			this.tallness = 5*12+6;
			this.hipRating = HIP_RATING_CURVY;
			this.buttRating = BUTT_RATING_NOTICEABLE;
			this.lowerBody = LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS;
			this.skinTone = "black";
			this.hairColor = "red";
			this.hairLength = 20;
			initStrTouSpeInte(104, 100, 90, 150);
			initLibSensCor(120, 50, 100);
			this.weaponName = "flaming whip";
			this.weaponVerb="flame-whip";
			this.weaponAttack = 20 + (5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "demon-skin";
			this.armorDef = 10 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 200;
			this.bonusLust = 40;
			this.lust = 50;
			this.lustVuln = 0.75;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 30;
			this.gems = rand(5) + 38;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.str += 31 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 30 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 27 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 45 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 36 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 6760;
			checkMonster();
		}
	}
}