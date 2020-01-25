/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class Galia extends Monster
	{
		public function clawAttack():void {
			outputText("" + this.capitalA + this.short + " charges at you with his claws ready! ");
			if (player.getEvasionRoll()) {
				outputText("You manage to avoid his claws thanks to your reaction!");
				return;
			}
			else {
				outputText("" + this.capitalA + this.short + " manages to swipe you!  You let out a cry in pain. ");
				var damage:int = rand(50) + str + weaponAttack;
				if (damage < 20) damage = 20;
				player.takePhysDamage(damage, true);
			}
		}

		public function doubleAttack():void {
			outputText("" + this.capitalA + this.short + " charges at you with his claws ready and sword raised! ");
			if (player.getEvasionRoll()) {
				outputText("You manage to dodge his deadly attack!");
				return;
			}
			else {
				outputText("" + this.capitalA + this.short + " manages to slash you with his sword and his deadly claws!");
				var damage:int = rand(50) + str + weaponAttack;
				if (damage < 20) damage = 20; //Min-cap damage.
				if (damage >= 50) {
					outputText("You let out a cry in pain and you swear you could see your wounds bleeding. ");
					player.createStatusEffect(StatusEffects.IzmaBleed, 2, 0, 0, 0);
				}
				else {
					outputText("Thankfully the wounds aren't that serious. ");
				}
				player.takePhysDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			this.wrath += 100;
			var choice1:Number = rand(4);
			if (choice1 < 2) eAttack();
			if (choice1 == 2) clawAttack();
			if (choice1 == 3) doubleAttack();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			cleanupAfterCombat();
			if (flags[kFLAGS.GALIA_LVL_UP] >= 1) {
			//if (player.hasStatusEffect(StatusEffects.CampSparingDinah)) {
				//player.removeStatusEffect(StatusEffects.CampSparingDinah);
				SceneLib.galiaFollower.GaliaLostSparring();
			}
			else SceneLib.impScene.impVictory2();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.GALIA_LVL_UP] >= 1) {
			//if (player.hasStatusEffect(StatusEffects.CampSparingDinah)) {
				//player.removeStatusEffect(StatusEffects.CampSparingDinah);
				SceneLib.galiaFollower.GaliaWonSparring();
			}
			else {
				outputText("Last thing you remember before black out is imp smashing you on the head with it sandal.");
				cleanupAfterCombat();
			}
		}
		
		public function Galia() 
		{
			if (flags[kFLAGS.GALIA_LVL_UP] < 1) {
				this.a = "the ";
				this.short = "imp";
				this.imageName = "imp";
				this.long = "An feral imp is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from his head, parted by two short curved horns.  His eyes are solid black, save for tiny red irises which glow with evil intent.  His skin is bright red, and unencumbered by clothing or armor, save for a small loincloth at his belt, and he's extremely well-muscled.  His feet are covered by tiny wooden sandals, and his hands tipped with sharp claws.  A pair of tiny but functional wings occasionally flap from his back.";
			}
			if (flags[kFLAGS.GALIA_LVL_UP] >= 1) {
				this.a = "";
				this.short = "Galia";
			}
			if (flags[kFLAGS.GALIA_LVL_UP] < 2) {
				initStrTouSpeInte(35, 5, 5, 5);
				initWisLibSensCor(5, 5, 5, 100);
				this.weaponAttack = 2;
				this.armorDef = 1;
				this.armorMDef = 0;
				this.bonusWrath = 50;
				this.bonusLust = 30;
				this.lust = 40;
				this.level = 1;
				this.gems = rand(5) + 5;
			}
			if (flags[kFLAGS.GALIA_LVL_UP] == 2) {
				initStrTouSpeInte(35, 5, 5, 5);
				initWisLibSensCor(5, 5, 5, 100);
				this.weaponAttack = 2;
				this.armorDef = 1;
				this.armorMDef = 0;
				this.bonusHP = 50;
				this.bonusWrath = 50;
				this.bonusLust = 30;
				this.lust = 40;
				this.level = 7;
				this.gems = rand(5) + 5;
			}
			if (flags[kFLAGS.GALIA_LVL_UP] == 3) {
				initStrTouSpeInte(35, 5, 5, 5);
				initWisLibSensCor(5, 5, 5, 100);
				this.weaponAttack = 2;
				this.armorDef = 1;
				this.armorMDef = 0;
				this.bonusHP = 50;
				this.bonusWrath = 50;
				this.bonusLust = 30;
				this.lust = 40;
				this.level = 13;
				this.gems = rand(5) + 5;
			}
			if (flags[kFLAGS.GALIA_LVL_UP] == 4) {
				initStrTouSpeInte(35, 5, 5, 5);
				initWisLibSensCor(5, 5, 5, 100);
				this.weaponAttack = 2;
				this.armorDef = 1;
				this.armorMDef = 0;
				this.bonusHP = 50;
				this.bonusWrath = 50;
				this.bonusLust = 30;
				this.lust = 40;
				this.level = 19;
				this.gems = rand(5) + 5;
			}
			if (flags[kFLAGS.GALIA_LVL_UP] == 5) {//pierwsza specialna ewolucja/mutacja
				initStrTouSpeInte(35, 5, 5, 5);
				initWisLibSensCor(5, 5, 5, 100);
				this.weaponAttack = 2;
				this.armorDef = 1;
				this.armorMDef = 0;
				this.bonusHP = 50;
				this.bonusWrath = 50;
				this.bonusLust = 30;
				this.lust = 40;
				this.level = 25;
				this.gems = rand(5) + 5;
			}
			if (flags[kFLAGS.GALIA_LVL_UP] < 5) {
				this.imageName = "imp";
				this.long = "Galia is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from her head, parted by two short curved horns.  Her eyes are solid black, save for tiny red irises.  Her skin is bright red unencumbered by clothing or armor, save for a small loincloth at her belt and wrap around her flat chest. She's extremely well-muscled, her feet are covered by tiny wooden sandals, and her hands tipped with sharp claws.  A pair of tiny but functional wings occasionally flap from her back.";
				createBreastRow(0);
				this.hips.type = Hips.RATING_BOYISH;
				this.butt.type = Butt.RATING_TIGHT;
				this.createVagina(true, VaginaClass.WETNESS_DRY, VaginaClass.LOOSENESS_TIGHT);
				this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
				this.ass.analWetness = AssClass.WETNESS_NORMAL;
				this.hairLength = 5;
				this.tallness = 26;
				this.weaponName = "claws";
				this.weaponVerb = "claw-slash";
				this.armorName = "leathery skin";
			}
			if (flags[kFLAGS.GALIA_LVL_UP] >= 5 && flags[kFLAGS.GALIA_LVL_UP] < 7) {
				this.imageName = "imp";
				this.long = "Galia is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from her head, parted by two short curved horns.  Her eyes are solid black, save for tiny red irises.  Her skin is bright red unencumbered by clothing or armor, save for a small loincloth at her belt and wrap around her flat chest. She's extremely well-muscled, her feet are covered by tiny wooden sandals, and her hands tipped with sharp claws.  A pair of tiny but functional wings occasionally flap from her back.";
				createBreastRow(Appearance.breastCupInverse("A"));
				this.hips.type = Hips.RATING_AMPLE + 2;//zmniejszyć
				this.butt.type = Butt.RATING_LARGE;//zmniejszyć
				this.createVagina(true, VaginaClass.WETNESS_DRY, VaginaClass.LOOSENESS_TIGHT);
				this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
				this.ass.analWetness = AssClass.WETNESS_NORMAL;
				this.hairLength = 5;
				this.tallness = 26;
				this.lustVuln = .1;
				this.weaponName = "claws";
				this.weaponVerb = "claw-slash";
				this.armorName = "leathery skin";
			}
			if (flags[kFLAGS.GALIA_LVL_UP] >= 7 && flags[kFLAGS.GALIA_LVL_UP] < 9) {
				this.imageName = "imp";
				this.long = "Galia is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from her head, parted by two short curved horns.  Her eyes are solid black, save for tiny red irises.  Her skin is bright red unencumbered by clothing or armor, save for a small loincloth at her belt and wrap around her flat chest. She's extremely well-muscled, her feet are covered by tiny wooden sandals, and her hands tipped with sharp claws.  A pair of tiny but functional wings occasionally flap from her back.";
				createBreastRow(Appearance.breastCupInverse("B"));//zwiekszyć?
				this.hips.type = Hips.RATING_AMPLE + 2;//zmniejszyć?
				this.butt.type = Butt.RATING_LARGE;//zmniejszyć?
				this.createVagina(false, VaginaClass.WETNESS_DRY, VaginaClass.LOOSENESS_TIGHT);
				this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
				this.ass.analWetness = AssClass.WETNESS_NORMAL;
				this.hairLength = 5;
				this.tallness = 26;
				this.lustVuln = .1;
				this.weaponName = "claws";
				this.weaponVerb = "claw-slash";
				this.armorName = "leathery skin";
			}
			if (flags[kFLAGS.GALIA_LVL_UP] >= 9) {
				this.imageName = "imp";
				this.long = "Galia is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from her head, parted by two short curved horns.  Her eyes are solid black, save for tiny red irises.  Her skin is bright red unencumbered by clothing or armor, save for a small loincloth at her belt and wrap around her flat chest. She's extremely well-muscled, her feet are covered by tiny wooden sandals, and her hands tipped with sharp claws.  A pair of tiny but functional wings occasionally flap from her back.";
				createBreastRow(Appearance.breastCupInverse("C"));//zwiekszyć?
				this.hips.type = Hips.RATING_AMPLE + 2;//zmniejszyć?
				this.butt.type = Butt.RATING_LARGE;//zmniejszyć?
				this.createVagina(false, VaginaClass.WETNESS_DRY, VaginaClass.LOOSENESS_TIGHT);
				this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
				this.ass.analWetness = AssClass.WETNESS_NORMAL;
				this.hairLength = 5;
				this.tallness = 26;
				this.lustVuln = .1;
				this.weaponName = "claws";
				this.weaponVerb = "claw-slash";
				this.armorName = "leathery skin";
			}
			this.skinTone = "red";
			this.hairColor = "black";
			this.plural = false;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.drop = NO_DROP;
			if (flags[kFLAGS.GALIA_LVL_UP] < 5) this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyFeralType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}