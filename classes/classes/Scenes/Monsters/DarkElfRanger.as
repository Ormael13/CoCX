/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Monsters
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.internals.*;

public class DarkElfRanger extends DarkElfs
	{
		override public function DarkElfBowShooting():void
		{
			var Acc:Number = 0;
			Acc += (this.spe - player.spe);
			if (Acc < 0) Acc = 0;
			outputText("The black skinned elf aims her bow at you, drawing several arrows and firing with expert precision.\n\n");
			PoisonedBowShoot();
			if (rand(100) < (90 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (80 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (70 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (60 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
		}
		
		public function DarkElfRanger()
		{
			this.a = "the ";
			this.short = "dark elf ranger";
			this.imageName = "dark elf";
			this.long = "This woman is a Dark elf. She's slender and elegant, with dark skin and long pointed ears. The look in her eyes, a mixture of bloodlust and greed, give her intentions away...as does her equipment. Ropes, poisoned arrows, she's come to the surface to capture slaves.";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_MOIST;
			this.tallness = 72;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.lowerBody = LowerBody.ELF;
			this.bodyColor = "dark";
			this.hairColor = "silver";
			this.hairLength = 13;
			initStrTouSpeInte(90, 130, 190, 100);
			initWisLibSensCor(100, 70, 80, 90);
			this.weaponName = "dagger";
			this.weaponVerb= "stab";
			this.weaponAttack = 5;
			this.weaponRangeName = "elven bow";
			this.weaponRangeVerb= "shoot";
			this.weaponRangeAttack = 30;
			this.armorName = "elven armor";
			this.armorDef = 12;
			this.armorMDef = 12;
			this.bonusLust = 197;
			this.lustVuln = .7;
			this.lust = 50;
			this.level = 47;
			this.gems = rand(10) + 20;
			this.drop = new WeightedDrop().
					add(weaponsrange.BOWLIGH,1).
					add(consumables.ELFEARS,4);
			this.abilities = [
				{ call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{ call: DarkElfBowShooting, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_WEAPON]},
				{ call: AnkleShot, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_WEAPON], condition: function():Boolean{return!player.hasStatusEffect(StatusEffects.Sealed2)}},
				{ call: WingClip, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_WEAPON], condition: function():Boolean{return player.isFlying()}, weight: Infinity}
			];
			checkMonster();
		}
	}
}
