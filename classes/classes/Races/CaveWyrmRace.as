package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;
import classes.VaginaClass;

public class CaveWyrmRace extends Race {
	
	public function CaveWyrmRace(id:int) {
		super("Cave Wyrm", id);
	}
	
	public override function setup():void {
		addScores()
				.skinCoatType(Skin.SCALES, +1)
				.skinCoatTypeAndColor1(Skin.SCALES, "midnight black", +1)
				.skinColor1("grayish-blue", +1)
				.earType(Ears.CAVE_WYRM, +1)
				.eyeType(Eyes.CAVE_WYRM, +1)
				.eyeColor("neon blue", +1)
				.tongueType(Tongue.CAVE_WYRM, +1)
				.faceType(Face.SALAMANDER_FANGS, +1)
				.armType(Arms.CAVE_WYRM, +1)
				.legType(LowerBody.CAVE_WYRM, +1)
				.tailType(Tail.CAVE_WYRM, +1)
				.customRequirement("","glowing nipples or asshole",
						function (body:BodyData):Boolean {
							return body.player.hasStatusEffect(StatusEffects.GlowingNipples) || body.player.hasStatusEffect(StatusEffects.GlowingAsshole);
						}, +1)
				.cockOrVaginaOfType(CockTypesEnum.CAVE_WYRM, VaginaClass.CAVE_WYRM, +1)
				.hasPerk(PerkLib.AcidSpit, +1)
				.hasPerk(PerkLib.AzureflameBreath, +1);
		
		addMutation(IMutationsLib.CaveWyrmLungsIM);
		
		buildTier(10, "cave wyrm")
				.namesTauric("cave wyrm", "cave wyrm-taur")
				.buffs({
					"str.mult": +0.60,
					"tou.mult": +0.70,
					"wis.mult": -0.30,
					"lib.mult": +0.50
				})
				.end();
	}
}
}
