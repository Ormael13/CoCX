package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class KrampusRace extends Race {
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
        
    public function KrampusRace(id:int) {
        super("Krampus", id, []);//RaceBody);
    }
    
    public override function setup():void {
        addScores()
				.faceType(ANY(Face.DEVIL_FANGS, Face.DRAGON_FANGS), +1)
				.hornType(Horns.GOAT, +1)
				.hornType(Horns.GOATQUAD, +2)
				.hornType(NONE(Horns.FROSTWYRM, Horns.DRACONIC_X2, Horns.DRACONIC_X4_12_INCH_LONG), 0, -3)
				.earType(Ears.GOAT, +1)
				.eyeType(Eyes.GOAT, +1)
				.tongueType(Tongue.DRACONIC, +1)
				.tongueType(NOT(Tongue.CAT), 0, -1000)
				.armType(Arms.FROSTWYRM, +1)
				.legType(LowerBody.KRAMPUS, +2, -5)
				.tailType(Tail.DRACONIC, +1)
				.tailType(NONE(Tail.FEY_DRACONIC, Tail.CAT), 0, -10)
				.wingType(Wings.DRACONIC_SMALL, +2)
				.wingType(Wings.DRACONIC_LARGE, +4)
				.wingType(Wings.DRACONIC_HUGE, +6)
				.wingType(NOT(Wings.FEY_DRAGON), 0, -10)
				.customRequirement("", "white secondary and black primary hair color",
						function (body:BodyData):Boolean {
							return body.hairColor2 == "white" &&
									body.hairColor1 == "black"
						}, +2)
				.cockOrVaginaOfType(CockTypesEnum.DEMON, VaginaClass.DRAGON, +2)
				.height(GREATER_THAN(96), +1)
				.hasPerk(PerkLib.DragonBlackIceBreath, +1);
		addScoresAfter(5)
				.hasPerk(PerkLib.Phylactery, +5)
                .hasPerk(PerkLib.GOBXChemical, -1000);
		
		addBloodline(PerkLib.DragonsDescendant,PerkLib.BloodlineDragon);
		addMutation(IMutationsLib.DrakeBloodIM);
		addMutation(IMutationsLib.DrakeLungsIM);
		addMutation(IMutationsLib.MightyLegsIM);

        buildTier(12, "krampus hatchling")
                .buffs({
					"str.mult": +0.90,
					"tou.mult": +0.60,
					"spe.mult": +0.10,
					"int.mult": +0.10,
					"wis.mult": +0.10,
					"lib.mult": +0.60,
					"sens": +60,
					"maxhp_mult": +0.05,
					"maxhp_base": +500,
					"maxlust_base": +100
                    })
                .end();

        buildTier(18, "krampus")
				.requirePerk(PerkLib.Phylactery)
                .buffs({
					"str.mult": +1.40,
					"tou.mult": +1.00,
					"spe.mult": +0.10,
					"int.mult": +0.10,
					"wis.mult": +0.10,
					"lib.mult": +0.70,
					"sens": +70,
					"maxhp_mult": +0.10,
					"maxhp_base": +1000,
					"maxlust_base": +200
                    })
                .end();

        buildTier(24, "elder krampus")
				.requirePreviousTier()
                .buffs({
					"str.mult": +1.90,
					"tou.mult": +1.40,
					"spe.mult": +0.10,
					"int.mult": +0.10,
					"wis.mult": +0.10,
					"lib.mult": +0.80,
					"sens": +80,
					"maxhp_mult": +0.15,
					"maxhp_base": +1500,
					"maxlust_base": +300
                    })
                .end();

        buildTier(32, "ancient krampus")
				.requirePreviousTier()
                .buffs({
					"str.mult": +2.40,
					"tou.mult": +1.80,
					"spe.mult": +0.10,
					"int.mult": +0.10,
					"wis.mult": +0.10,
					"lib.mult": +0.90,
					"sens": +90,
					"maxhp_mult": +0.20,
					"maxhp_base": +2000,
					"maxlust_base": +400
                    })
                .end();
    }
}
}