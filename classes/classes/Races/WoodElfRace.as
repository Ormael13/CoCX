package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.MutationsLib;
import classes.PerkLib;
import classes.Race;

public class WoodElfRace extends Race{
	public function WoodElfRace(id:int) {
		super("Wood Elf", id);
		
		addScores()
				.hasPerk(PerkLib.BlessingOfTheAncestorTree, +4, -100)
				.earType(Ears.ELVEN, +1)
				.eyeType(Eyes.ELF, +1)
				.faceType(Face.ELF, +1)
				.tongueType(Tongue.ELF, +1)
				.armType(Arms.ELF, +1)
				.legType(LowerBody.ELF, +1)
				.hairType(Hair.SILKEN, +1)
				.noWings(+1)
				.hairColor("golden blonde", +1, -100)
				.eyeColor("light green",+1, -100)
				.skinBaseColor("light", +1)
				.customRequirement("skin","flawless skin",
						function (body:BodyData):Boolean {
							return body.player.skinType == Skin.PLAIN && body.skinBaseAdj == "flawless"
						}, +1)
				.tone(AT_MOST(60), +1)
				.thickness(AT_MOST(50), +1)
				.customRequirement("","small cock; or vagina and small tits",
						function (body:BodyData):Boolean {
							return body.hasCock && body.biggestCockSize < 6 ||
									body.hasVagina && body.biggestTitSize >= 3
						}, +1)
				.corruption(AT_LEAST(50), +1, -100)
				.hasPerk(PerkLib.FlawlessBody, +1)
				.hasPerk(PerkLib.ElvenSense, +1)
				.mutationPerks([
					MutationsLib.ElvishPeripheralNervSys,
					MutationsLib.ElvishPeripheralNervSysPrimitive,
					MutationsLib.ElvishPeripheralNervSysEvolved,
				], +3);
		
		addBloodline([PerkLib.ElfsDescendant,PerkLib.BloodlineElf]);
		
		buildTier(22, "wood elf little sister")
				.tauricName("wood elf-taur little sister")
				.buffs({
					"str.mult": -0.10,
					"tou.mult": -0.15,
					"spe.mult": +5.50,
					"int.mult": +4.95,
					"lib.mult": +4.55,
					"sens": +80,
					"maxmana_mult": +0.1
				})
				.end()
		buildTier(25, "wood elf young sister")
				.tauricName("wood elf-taur young sister")
				.buffs({
					"str.mult": -0.10,
					"tou.mult": -0.15,
					"spe.mult": +4.95,
					"int.mult": +4.45,
					"lib.mult": +4.15,
					"sens": +70,
					"maxmana_mult": +0.2
				})
				.end()
		buildTier(28, "wood elf sister")
				.tauricName("wood elf-taur sister")
				.buffs({
					"str.mult": -0.10,
					"tou.mult": -0.15,
					"spe.mult": +4.30,
					"int.mult": +4.05,
					"lib.mult": +3.75,
					"sens": +60,
					"maxmana_mult": +0.3
				})
				.end()
		buildTier(31, "wood elf elder sister")
				.tauricName("wood elf-taur elder sister")
				.buffs({
					"str.mult": -0.10,
					"tou.mult": -0.15,
					"spe.mult": +3.75,
					"int.mult": +3.55,
					"lib.mult": +3.35,
					"sens": +50,
					"maxmana_mult": +0.4
				})
				.end()
	}
}
}
