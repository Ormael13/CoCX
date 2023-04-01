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

public class DarkElfSlaver extends DarkElfScout
	{
		override public function DarkElfBowShooting():void
		{
			var Acc:Number = 0;
			Acc += (this.spe - player.spe);
			if (Acc < 0) Acc = 0;
			outputText("The black skinned elf aims her bow at you, drawing several arrows and starts shooting.\n\n");
			PoisonedBowShoot();
			if (rand(100) < (90 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (80 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (70 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
		}
		
		public function DarkElfSlaver()
		{
			this.a = "the ";
			this.short = "dark elf slaver";
			this.imageName = "dark elf";
			this.long = "This lightly armored woman is a Dark elf. She's slender and elegant, with dark skin and long pointed ears. The look in her eyes, a mixture of bloodlust and greed, give her intentions away...as does her equipment. Ropes, poisoned arrows, she's come to the surface to capture slaves. You can hear faint voices from somewhere nearby. Has she already captured people today?";
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
			initStrTouSpeInte(60, 80, 140, 70);
			initWisLibSensCor(70, 60, 70, 85);
			this.weaponName = "dagger";
			this.weaponVerb= "stab";
			this.weaponAttack = 5;
			this.weaponRangeName = "elven bow";
			this.weaponRangeVerb= "shoot";
			this.weaponRangeAttack = 24;
			this.armorName = "elven armor";
			this.armorDef = 8;
			this.armorMDef = 8;
			this.bonusLust = 159;
			this.lustVuln = .7;
			this.lust = 50;
			this.level = 29;
			this.gems = rand(10) + 15;
			this.drop = new WeightedDrop().
					add(weaponsrange.BOWLIGH,1).
					add(consumables.ELFEARS,4);
			this.abilities = [
				{ call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{ call: DarkElfBowShooting, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_WEAPON]},
				{ call: AnkleShot, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_WEAPON], condition: !player.hasStatusEffect(StatusEffects.Sealed2)},
				{ call: WingClip, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_WEAPON], condition: player.isFlying(), weight: Infinity}
			]
			checkMonster();
		}
		
	}

}
