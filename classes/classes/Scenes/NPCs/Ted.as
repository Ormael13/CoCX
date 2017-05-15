/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	use namespace kGAMECLASS;
	
	public class Ted extends Monster
	{
		
		
		override public function defeated(hpVictory:Boolean):void//jak PC wygra
		{
			outputText("\n\nA dragon-boy fall on his knees ");
			if (this.HP < 1)outputText("beaten up");
			else outputText("too horny to fight back");
			outputText(". All of sudden he starting to muttering.\n\n");
			outputText("\"<i>I lost? No...I just feel gratious today to not show this mortal my dvine powers and should make a grand strategical retreat for now.</i>\"\n\n");
			outputText("When you comming little closer to try understand what he muttering he suddenly standing up and crushing some sort of talisman laughing loud. \"<i>I need to attend to other maters so I letting you off the hook today. Repent on your sins and worship me properly when we meet again or this time my bam hammer won't be so forgving.</i>\"");
			outputText(" And before you react he already vanished after brighting light blinded you for a moment.");
			player.orgasm();
			cleanupAfterCombat();
			return;
		}
	/*	
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void//jak PC przegra - jakiś fajny bad end zrobić ^^
		{
			if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2) etnaScene.etnaRapeYandere();
			etnaScene.etnaRapesPlayer();
		}
	*/	
		public function Ted() 
		{
			this.a = "the ";
			this.short = "mysterious dragon-boy";
			this.imageName = "mysterious dragon-boy";
			this.long = "Before you stands a dragon-boy.  Though he stands only six and half feet tall, he is covered in lean muscle and moves with grace no lesser than most skilled balet dancers.  He wears armor made of green dragon scales and fight using an oversized hammer that got inscribed on it words 'bam' and 'hammer'. Thou to be truth to be said word 'bam' looks like it was orginaly word 'ban'.";
			// this.plural = false;
			this.createCock(5,1);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 1;
			this.hoursSinceCum = 100;
			createBreastRow(0);
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = 78;
			this.hipRating = HIP_RATING_SLENDER;
			this.buttRating = BUTT_RATING_TIGHT;
			this.skin.setBaseOnly({color:"white"});
			this.skinDesc = "skin";
			this.hairColor = "brown";
			this.hairLength = 2;
			initStrTouSpeInte(30, 50, 50, 30);
			initLibSensCor(20, 40, 50);
			this.weaponName = "bam hammer";
			this.weaponVerb="bam";
			this.weaponAttack = 8 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "dragonscales armor";
			this.armorDef = 5 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.lust = 15;
			this.lustVuln = .9;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 9;
			this.gems = rand(10) + 5;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.LizanRegeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.LizanMarrow, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.str += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 360;
			checkMonster();
		}
		
	}

}