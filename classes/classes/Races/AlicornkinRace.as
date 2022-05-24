package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;
import classes.internals.Utils;

public class AlicornkinRace extends Race{
	public static const NightmarekinFurColors:/*String*/Array  = UnicornRace.BicornFurColors;
	public static const NightmarekinHairColors:/*String*/Array = UnicornRace.BicornHairColors;
	public static const AlicornkinFurColors:/*String*/Array  = UnicornRace.UnicornFurColors;
	public static const AlicornkinHairColors:/*String*/Array = UnicornRace.UnicornHairColors;
	
	public function AlicornkinRace(id:int) {
		super("Alicornkin", id);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.HORSE, +2, -1000)
				.earType(Ears.HORSE, +1)
				.tailType(Tail.HORSE, +1)
				.legType(LowerBody.HOOFED, +1)
				.eyeType(Eyes.HUMAN, +1)
				.hornType(ANY(Horns.UNICORN, Horns.BICORN), 0, -1000)
				
				.skinCoatType(Skin.FUR, +1)
				.hasCockOfType(CockTypesEnum.HORSE, +1)
				.vaginaType(VaginaClass.EQUINE, +1)
				.hornTypeAndCount(Horns.UNICORN, LESS_THAN(6), +1, 0, "Alicornkin branch - size 1-5 unicorn horn")
				.hornTypeAndCount(Horns.UNICORN, AT_LEAST(6), +2, 0, "Alicornkin branch - size 6+ unicorn horn")
				.hornTypeAndCount(Horns.UNICORN, LESS_THAN(6), +1, 0, "Nightmarekin branch - size 1-5 bicorn horns")
				.hornTypeAndCount(Horns.UNICORN, AT_LEAST(6), +2, 0, "Nightmarekin branch - size 6+ bicorn horns")
				.customRequirement("",
						"Wings match horns",
						function (body:BodyData):Boolean {
							if (body.hornType == Horns.UNICORN) return body.wingType == Wings.FEATHERED_ALICORN;
							if (body.hornType == Horns.BICORN) return body.wingType == Wings.NIGHTMARE;
							return true;
						}, 0, -1000);
		addConditionedScores(
				function(body:BodyData):Boolean {
					return body.hornType == Horns.UNICORN;
				}, "Alicornkin branch;")
				.wingType(Wings.FEATHERED_ALICORN, +4) // can't -1000 here because condition is &&'d with the horn type
				.customRequirement(
						"",
						"hair color: "+AlicornkinHairColors.join("/")+
						"; coat color: "+AlicornkinFurColors.join("/"),
						function (body:BodyData):Boolean {
							return Utils.InCollection(body.hairColor, AlicornkinHairColors) &&
									Utils.InCollection(body.skinCoatColor, AlicornkinFurColors)
						},
						+1)
				.eyeColor("blue", +1)
				.hasPerk(PerkLib.AvatorOfPurity, +1);
		addConditionedScores(
				function(body:BodyData):Boolean {
					return body.hornType == Horns.BICORN;
				}, "Nightmarekin branch;")
				.wingType(Wings.NIGHTMARE, +4) // can't -1000 here because condition is &&'d with the horn type
				.customRequirement(
						"",
						"hair color: "+NightmarekinHairColors.join("/")+
						"; coat color: "+NightmarekinFurColors.join("/"),
						function (body:BodyData):Boolean {
							return Utils.InCollection(body.hairColor, NightmarekinHairColors) &&
									Utils.InCollection(body.skinCoatColor, NightmarekinFurColors)
						},
						+1)
				.eyeColor("red", +1)
				.hasPerk(PerkLib.AvatorOfCorruption, +1);
		
		addMutation(IMutationsLib.EclipticMindIM, +1);
		
		buildTier(12, "Alicornkin/Nightmarekin")
				.customNamingFunction(function(body:BodyData):String {
					if (body.hornType == Horns.UNICORN) return "alicornkin";
					return "nightmarekin";
				})
				.buffs({
					"tou.mult": +0.45,
					"spe.mult": +0.60,
					"int.mult": +0.75
				})
				.withExtraBonuses([
						"Mana & SF recovery +5%",
						"Combat HP regen +150",
						"Regenerate Spell +200%"
				])
				.end();
	}
}
}
