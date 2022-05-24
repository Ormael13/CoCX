package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;
import classes.internals.Utils;

public class UnicornkinRace extends Race{
	public static const BicornkinFurColors:/*String*/Array  = UnicornRace.BicornFurColors;
	public static const BicornkinHairColors:/*String*/Array = UnicornRace.BicornHairColors;
	public static const UnicornkinFurColors:/*String*/Array  = UnicornRace.UnicornFurColors;
	public static const UnicornkinHairColors:/*String*/Array = UnicornRace.UnicornHairColors;
	
	public function UnicornkinRace(id:int) {
		super("Unicornkin", id);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.HORSE, +2, -1000)
				.earType(Ears.HORSE, +1)
				.tailType(Tail.HORSE, +1)
				.legType(LowerBody.HOOFED, +1)
				.eyeType(Eyes.HUMAN, +1)
				.hornType(ANY(Horns.UNICORN, Horns.BICORN), 0, -1000)
				
				.wingType(NONE(Wings.FEATHERED_ALICORN,Wings.NIGHTMARE), 0, -1000)
				.noWings(+4)
				
				.skinCoatType(Skin.FUR, +1)
				.hasCockOfType(CockTypesEnum.HORSE, +1)
				.vaginaType(VaginaClass.EQUINE, +1)
				.hornTypeAndCount(Horns.UNICORN, LESS_THAN(6), +1, 0, "Unicornkin branch - size 1-5 unicorn horn")
				.hornTypeAndCount(Horns.UNICORN, AT_LEAST(6), +2, 0, "Unicornkin branch - size 6+ unicorn horn")
				.hornTypeAndCount(Horns.UNICORN, LESS_THAN(6), +1, 0, "Bicornkin branch - size 1-5 bicorn horns")
				.hornTypeAndCount(Horns.UNICORN, AT_LEAST(6), +2, 0, "Bicornkin branch - size 6+ bicorn horns");
		addConditionedScores(
				function(body:BodyData):Boolean {
					return body.hornType == Horns.UNICORN;
				}, "Unicornkin branch;")
				.customRequirement(
						"",
						"hair color: "+UnicornkinHairColors.join("/")+
						"; coat color: "+UnicornkinFurColors.join("/"),
						function (body:BodyData):Boolean {
							return Utils.InCollection(body.hairColor, UnicornkinHairColors) &&
									Utils.InCollection(body.skinCoatColor, UnicornkinFurColors)
						},
						+1)
				.eyeColor("blue", +1)
				.hasPerk(PerkLib.AvatorOfPurity, +1);
		addConditionedScores(
				function(body:BodyData):Boolean {
					return body.hornType == Horns.BICORN;
				}, "Bicornkin branch;")
				.customRequirement(
						"",
						"hair color: "+BicornkinHairColors.join("/")+
						"; coat color: "+BicornkinFurColors.join("/"),
						function (body:BodyData):Boolean {
							return Utils.InCollection(body.hairColor, BicornkinHairColors) &&
									Utils.InCollection(body.skinCoatColor, BicornkinFurColors)
						},
						+1)
				.eyeColor("red", +1)
				.hasPerk(PerkLib.AvatorOfCorruption, +1);
		
		addMutation(IMutationsLib.EclipticMindIM, +1);
		
		buildTier(12, "Unicornkin/Bicornkin")
				.customNamingFunction(function(body:BodyData):String {
					if (body.hornType == Horns.UNICORN) return "unicornkin";
					return "bicornkin";
				})
				.buffs({
					"tou.mult": +0.55,
					"spe.mult": +0.70,
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
