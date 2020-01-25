/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Ears;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.internals.*;

use namespace CoC;
	
	public class Sonya extends Monster
	{
		public var sonyaScene:SonyaFollower = new SonyaFollower();
	/*	
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.ETNA_FOLLOWER] >= 2) etnaScene.etnaRapeIntro2();
			else if (flags[kFLAGS.ETNA_AFFECTION] > 75) etnaScene.etnaReady2Come2Camp();
			else if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] < 1 && flags[kFLAGS.ETNA_AFFECTION] > 15) etnaScene.etnaRape3rdWin();
			else etnaScene.etnaRapeIntro();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2) etnaScene.etnaRapeYandere();
			etnaScene.etnaRapesPlayer();
		}
	*/	
		public function Sonya() 
		{
			if (game.flags[kFLAGS.SONYA_TALKED_ABOUT_HER] >= 1) {
				this.a = "";
				this.short = "Sonya";
				this.long = "Sonya is twelve feet tall easily been the tallest, most muscular and feral lacta bovina you have ever seen using twin heavy hammers.";
			}
			else {
				this.a = "the ";
				this.short = "glacial bull";
				this.long = "The glacial bull is twelve feet tall, much taller and muscular than any other bull you've seen before. Additionaly it seems to be heavy corrupted having much less human traits than other minotaurs you meet. Weirdly he seems to have his chest covered by piece of cloth too in addition to typicaly used by his brothers loincloth, but that not distracts you from the pair of large hammers it wields.";
			}
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,60,0,0,0);
			createBreastRow(Appearance.breastCupInverse("flat"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 144;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.skinTone = "light";
			this.hairColor = "red";
			this.hairLength = 1;
			initStrTouSpeInte(250, 200, 150, 180);
			initWisLibSensCor(180, 50, 50, 100);
			this.weaponName = "twin hammers";
			this.weaponVerb="smash";
			this.weaponAttack = 70;
			this.armorName = "thick fur";
			this.armorDef = 30;
			this.armorMDef = 0;
			this.bonusHP = 100;
			this.bonusLust = 30;
			this.lust = 30;
			this.lustVuln = .8;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 30;
			this.gems = 45 + rand(40);
			this.drop = new ChainedDrop().
				//	add(armors.S_SWMWR,1/12).
				//	add(consumables.L_DRAFT,1/4).
					add(consumables.LABOVA_,0.7);
			this.ears.type = Ears.COW;
			this.faceType = Face.COW_MINOTAUR;
			this.lowerBody = LowerBody.HOOFED;
			this.tailType = Tail.COW;
			this.tailRecharge = 0;
			//this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			//this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			//this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}