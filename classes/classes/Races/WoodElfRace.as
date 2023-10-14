package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class WoodElfRace extends Race{
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

	public function WoodElfRace(id:int) {
		super("Wood Elf", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.earType(Ears.ELVEN, +1)
				.eyeType(Eyes.ELF, +1)
				.faceType(Face.ELF, +1)
				.tongueType(Tongue.ELF, +1)
				.armType(Arms.ELF, +1)
				.legType(LowerBody.ELF, +1)
				.hairType(Hair.SILKEN, +1)
				.noWings(+1)
				.hairColor1("golden blonde", +1, -1000)
				.eyeColor("light green",+1, -1000)
				.skinColor1("light", +1)
				.customRequirement("skin","flawless skin",
						function (body:BodyData):Boolean {
							return body.player.skinType == Skin.PLAIN && body.skinBaseAdj == "flawless"
						}, +1)
				.tone(AT_MOST(60), +1)
				.thickness(AT_MOST(50), +1)
				.customRequirement("","small cock; or vagina and big tits",
						function (body:BodyData):Boolean {
							return body.hasCock && body.biggestCockSize < 6 ||
									body.hasVagina && body.biggestTitSize >= 3
						}, +1)
				.corruption(AT_LEAST(50), +1, -1000)
				.hasPerk(PerkLib.FlawlessBody, +1)
				.hasPerk(PerkLib.ElvenSense, +1)
				.hasPerk(PerkLib.NaturalSpellcasting, +1)
				.hasPerk(PerkLib.BlessingOfTheAncestorTree, +4, -1000);
		
		addBloodline(PerkLib.ElfsDescendant,PerkLib.BloodlineElf);
		addMutation(IMutationsLib.ElvishPeripheralNervSysIM, +3);
		
		buildTier(22, "wood elf little sister")
				.namesTauric("wood elf little sister", "wood elf-taur little sister")
				.buffs({
					"str.mult": -0.10,
					"tou.mult": -0.15,
					"spe.mult": +3.75,
					"int.mult": +3.55,
					"lib.mult": +3.35,
					"sens": +50,
					"maxmana_mult": +0.1
				})
				.end()
		buildTier(25, "wood elf young sister")
				.namesTauric("wood elf young sister", "wood elf-taur little sister")
				.buffs({
					"str.mult": -0.10,
					"tou.mult": -0.15,
					"spe.mult": +4.30,
					"int.mult": +4.05,
					"lib.mult": +3.75,
					"sens": +60,
					"maxmana_mult": +0.2
				})
				.end()
		buildTier(28, "wood elf sister")
				.namesTauric("wood elf sister", "wood elf-taur sister")
				.buffs({
					"str.mult": -0.10,
					"tou.mult": -0.15,
					"spe.mult": +4.95,
					"int.mult": +4.45,
					"lib.mult": +4.15,
					"sens": +70,
					"maxmana_mult": +0.3
				})
				.end()
		buildTier(31, "wood elf elder sister")
				.namesTauric("wood elf elder sister", "wood elf-taur elder sister")
				.buffs({
					"str.mult": -0.10,
					"tou.mult": -0.15,
					"spe.mult": +5.50,
					"int.mult": +4.95,
					"lib.mult": +4.55,
					"sens": +80,
					"maxmana_mult": +0.4
				})
				.end()
	}
}
}
