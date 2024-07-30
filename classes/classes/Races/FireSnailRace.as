package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class FireSnailRace extends Race {
	public static const FireSnailEyeColors:/*String*/Array = ["red", "orange","yellow"];
	public static const FireSnailSkinColors:/*String*/Array = ["red", "orange"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Elf",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Elven",
        /*Eyes*/		"Elf",
        /*Face*/		"Elf",
        /*Gills*/		"None",
        /*Hair*/		"Elf",
        /*Horns*/		"Human",
        /*LowerBody*/	"Elf",
        /*RearBody*/	"Human",
        /*Skin*/		"Elf",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Elf",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Elf"];
	
	public function FireSnailRace(id:int) {
		super("Fire Snail", id, []);//RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.antennaeType(Antennae.FIRE_SNAIL, +1)
				.hairType(Hair.BURNING, +1)
				.eyeColor(ANY(FireSnailEyeColors), +1)
				.skinColor1(ANY(FireSnailSkinColors), +1)
				.plainSkinOfAdj("sticky glistering", +1)
				.customRequirement("","snail shell and no wings",
						function (body:BodyData):Boolean {
							return body.rearType == RearBody.SNAIL_SHELL && body.wingType == Wings.NONE;
						}, +5)
				.customRequirement("","fire snail lower body and no tail",
						function (body:BodyData):Boolean {
							return body.legType == LowerBody.FIRE_SNAIL && body.tailType == Tail.NONE;
						}, +3)
				.eyeType(Eyes.FIRE_SNAIL, +1)
				.faceType(Face.FIRE_SNAIL, +1);
		
		addMutation(IMutationsLib.BlazingHeartIM);
		
		buildTier(15, "fire snail")
				.buffs({
					"str.mult": +0.70,
					"tou.mult": +1.75,
					"spe.mult": -0.80,
					"lib.mult": +1.10,
					"sens": +50
				})
				.end();
	}
}
}
