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
import classes.internals.*;

	public class Galia extends Monster
	{
		
		public function Galia() 
		{
			if (flags[kFLAGS.GALIA_LVL_UP] < 1) {
				this.a = "the ";
				this.short = "imp";
			}
			if (flags[kFLAGS.GALIA_LVL_UP] >= 1) {
				this.a = "";
				this.short = "Galia";
			}
			if (flags[kFLAGS.GALIA_LVL_UP] < 1) {
				this.imageName = "imp";
				this.long = "An feral imp is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from his head, parted by two short curved horns.  His eyes are solid black, save for tiny red irises which glow with evil intent.  His skin is bright red, and unencumbered by clothing or armor, save for a small loincloth at his belt, and he's extremely well-muscled.  His feet are covered by tiny wooden sandals, and his hands tipped with sharp claws.  A pair of tiny but functional wings occasionally flap from his back.";
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
			if (flags[kFLAGS.GALIA_LVL_UP] == 1) {
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
			if (flags[kFLAGS.GALIA_LVL_UP] == 5) {//piewrsza speciajna ewolucja/mutacja
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
				this.long = "Galia is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from her head, parted by two short curved horns.  Her eyes are solid black, save for tiny red irises.  Her skin is bright red unencumbered by clothing or armor, save for a small loincloth at his belt and wrap around her flat chest. She's extremely well-muscled, her feet are covered by tiny wooden sandals, and her hands tipped with sharp claws.  A pair of tiny but functional wings occasionally flap from her back.";
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
				this.long = "Galia is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from her head, parted by two short curved horns.  Her eyes are solid black, save for tiny red irises.  Her skin is bright red unencumbered by clothing or armor, save for a small loincloth at his belt and wrap around her flat chest. She's extremely well-muscled, her feet are covered by tiny wooden sandals, and her hands tipped with sharp claws.  A pair of tiny but functional wings occasionally flap from her back.";
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
				this.long = "Galia is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from her head, parted by two short curved horns.  Her eyes are solid black, save for tiny red irises.  Her skin is bright red unencumbered by clothing or armor, save for a small loincloth at his belt and wrap around her flat chest. She's extremely well-muscled, her feet are covered by tiny wooden sandals, and her hands tipped with sharp claws.  A pair of tiny but functional wings occasionally flap from her back.";
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
				this.long = "Galia is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from her head, parted by two short curved horns.  Her eyes are solid black, save for tiny red irises.  Her skin is bright red unencumbered by clothing or armor, save for a small loincloth at his belt and wrap around her flat chest. She's extremely well-muscled, her feet are covered by tiny wooden sandals, and her hands tipped with sharp claws.  A pair of tiny but functional wings occasionally flap from her back.";
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