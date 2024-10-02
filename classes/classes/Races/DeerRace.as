package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class DeerRace extends Race{
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Human",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Human",
        /*Eyes*/		"Human",
        /*Face*/		"Human",
        /*Gills*/		"Human",
        /*Hair*/		"Human",
        /*Horns*/		"Human",
        /*LowerBody*/	"Human",
        /*RearBody*/	"Human",
        /*Skin*/		"Human",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Human",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Human"];

    public function DeerRace(id:int) {
		super("Deer", id, []);//RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	public override function setup():void {
		
		addScores()
				.earType(Ears.DEER, +1)
				.tailType(Tail.DEER, +1)
				.faceType(Face.DEER, +1)
				.armType(Arms.DEER, +1)
				.armType(Arms.REINDEER, +2)
				.armType(NOT(Arms.WENDIGO), 0, -5)
				.legType(LowerBody.CLOVEN_HOOFED, +1)
				.legType(LowerBody.CLOVEN_HOOFED_2, +2)
				.legType(NOT(LowerBody.WENDIGO), 0, -5)
				.hornTypeAndCount(Horns.ANTLERS, AT_LEAST(4), +1)
				.hornTypeAndCount(Horns.ANTLERS, AT_LEAST(14), +1)
				.hornTypeAndCount(Horns.ANTLERS, AT_LEAST(24), +1)
				.hornTypeAndCount(Horns.ANTLERS, AT_LEAST(34), +1)
				.skinCoatType(Skin.FUR, +1)
				.cockOrVaginaOfType(CockTypesEnum.HORSE, VaginaClass.EQUINE, +1);
		
		addBloodline(PerkLib.DeersDescendant, PerkLib.BloodlineDeer);
		
		buildTier(8, "deer")
				.namesMaleFemaleMorphTaur("deer-morph", "deer-girl", "deer-morph", "deer-taur")
				.buffs({
					"str.mult": +0.25,
					"tou.mult": +0.25,
					"spe.mult": +0.50,
					"int.mult": -0.20,
					"wis.mult": +0.40
				})
				.end();/*
		
		buildTier(12, "reindeer")
				.namesMaleFemaleMorphTaur("reindeer-morph", "reindeer-girl", "reindeer-morph", "reindeer-taur")
				.buffs({
					"str.mult": +0.25,
					"tou.mult": +0.25,
					"spe.mult": +0.50,
					"int.mult": -0.20,
					"wis.mult": +0.40
					//"sens": +85
				})
				.end();*/
	}
}
}
