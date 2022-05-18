package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.PerkLib;
import classes.Race;
import classes.Scenes.NPCs.Forgefather;

public class GargoyleRace extends Race {
	public static const GargoyleHairColors:/*String*/Array = ["light gray", "quartz white", "gray", "dark gray", "black", "caramel"];
	public static const GargoyleSkinColors:/*String*/Array = ["light gray", "quartz white", "gray", "dark gray", "black", "caramel"];
	
	
	public function GargoyleRace(id:int) {
		super("Gargoyle", id);
	}
	
	public override function setup():void {
		
		addScores()
				.hairColor(ANY(GargoyleHairColors), +1)
				.skinBaseColor(ANY(GargoyleSkinColors), +1)
				.hairType(Hair.NORMAL, +1)
				.skinBaseType(Skin.STONE, +1)
				.hornType(Horns.GARGOYLE, +1)
				.eyeType(Eyes.GEMSTONES, +1)
				.earType(Ears.ELFIN, +1)
				.faceType(Face.DEVIL_FANGS, +1)
				.tongueType(Tongue.DEMONIC, +1)
				// custom name to avoid "gargoyle or gargoyle arms" phrase
				.armType(ANY(Arms.GARGOYLE,Arms.GARGOYLE_2), +1, 0, "gargoyle arms")
				.tailType(ANY(Tail.GARGOYLE, Tail.GARGOYLE_2), +1)
				.legType(ANY(LowerBody.GARGOYLE, LowerBody.GARGOYLE_2), +1)
				.wingType(ANY(Wings.GARGOYLE_LIKE_LARGE, Wings.FEATHERED_LARGE), +4)
				.noGills(+1)
				.noRearBody(+1)
				.noAntennae(+1)
				.hasAnyPerk([PerkLib.GargoylePure, PerkLib.GargoyleCorrupted], +1)
				.hasPerk(PerkLib.TransformationImmunity, +5);
		
		buildTier(22,"gargoyle")
				.customNamingFunction(
						function(body:BodyData):String {
							if (body.player.hasPerk(PerkLib.GargoylePure)) return "pure gargoyle";
							else if (body.player.hasPerk(PerkLib.GargoyleCorrupted))  return "corrupted gargoyle"
							else return "gargoyle" // to display the tier name in race db
						}
				)
				.withDynamicBuffs("Material-dependent bonuses", calcBuffs)
				.end();
	}
	
	private function calcBuffs(body:BodyData):Object {
		var maxStrCap2:int=0,
			maxTouCap2:int=0,
			maxSpeCap2:int=0,
			maxIntCap2:int=0,
			maxWisCap2:int=0,
			maxLibCap2:int=0,
			currentSen:int=0
		;
		switch (Forgefather.material){
			case "stone":
				switch(Forgefather.refinement){
					case 1:
						maxStrCap2 += 50;
						maxTouCap2 += 50;
						maxSpeCap2 += 50;
						maxIntCap2 += 50;
						maxWisCap2 += 50;
						maxLibCap2 += 50;
						break;
					case 2:
						maxStrCap2 += 75;
						maxTouCap2 += 75;
						maxSpeCap2 += 75;
						maxIntCap2 += 75;
						maxWisCap2 += 75;
						maxLibCap2 += 75;
						break;
					case 3:
						maxStrCap2 += 100;
						maxTouCap2 += 100;
						maxSpeCap2 += 100;
						maxIntCap2 += 100;
						maxWisCap2 += 100;
						maxLibCap2 += 100;
						break;
				}
				break;
			case "alabaster":
				//Alabaster - Magic (Int+100%, +20% max mana, +15% spell dmg)
				switch(Forgefather.refinement){
					case 1:
						maxIntCap2 += 100;
						maxWisCap2 += 50;
						maxStrCap2 -= 10;
						maxTouCap2 -= 10;
						break;
					case 2:
						maxIntCap2 += 150;
						maxWisCap2 += 75;
						maxStrCap2 -= 15;
						maxTouCap2 -= 15;
						break;
					case 3:
						maxIntCap2 += 200;
						maxWisCap2 += 100;
						maxStrCap2 -= 20;
						maxTouCap2 -= 20;
						break;
					case 4:
						maxIntCap2 += 200;
						maxWisCap2 += 100;
						maxStrCap2 -= 20;
						maxTouCap2 -= 20;
						break;
					case 5:
						maxIntCap2 += 500;
						maxWisCap2 += 250;
						maxStrCap2 -= 30;
						maxTouCap2 -= 30;
						break;
				}
				break;
			case "marble":
				switch(Forgefather.refinement){
					case 1:
						maxWisCap2 += 100;
						maxStrCap2 += 50;
						maxIntCap2 -= 10;
						break;
					case 2:
						maxWisCap2 += 150;
						maxStrCap2 += 75;
						maxIntCap2 -= 15;
						break;
					case 3:
						maxWisCap2 += 200;
						maxStrCap2 += 100;
						maxIntCap2 -= 20;
						break;
					case 4:
						maxWisCap2 += 200;
						maxStrCap2 += 100;
						maxIntCap2 -= 20;
						break;
					case 5:
						maxWisCap2 += 500;
						maxStrCap2 += 200;
						maxIntCap2 -= 30;
						break;
				}
				break;
			case "granite":
				switch(Forgefather.refinement){
					case 1:
						maxTouCap2 += 100;
						maxStrCap2 += 50;
						maxIntCap2 -= 10;
						maxWisCap2 -= 10;
						break;
					case 2:
						maxTouCap2 += 150;
						maxStrCap2 += 75;
						maxIntCap2 -= 15;
						maxWisCap2 -= 15;
						break;
					case 3:
						maxTouCap2 += 200;
						maxStrCap2 += 100;
						maxIntCap2 -= 20;
						maxWisCap2 -= 20;
						break;
					case 4:
						maxTouCap2 += 200;
						maxStrCap2 += 100;
						maxIntCap2 -= 20;
						maxWisCap2 -= 20;
						break;
					case 5:
						maxTouCap2 += 500;
						maxStrCap2 += 250;
						maxIntCap2 -= 30;
						maxWisCap2 -= 30;
						break;
				}
				break;
			case "ebony":
				switch(Forgefather.refinement){
					case 1:
						maxStrCap2 += 100;
						maxSpeCap2 += 50;
						maxIntCap2 -= 10;
						maxWisCap2 -= 10;
						break;
					case 2:
						maxStrCap2 += 150;
						maxSpeCap2 += 75;
						maxIntCap2 -= 15;
						maxWisCap2 -= 15;
						break;
					case 3:
						maxStrCap2 += 200;
						maxSpeCap2 += 100;
						maxIntCap2 -= 20;
						maxWisCap2 -= 20;
						break;
					case 4:
						maxStrCap2 += 200;
						maxSpeCap2 += 100;
						maxIntCap2 -= 20;
						maxWisCap2 -= 20;
						break;
					case 5:
						maxStrCap2 += 500;
						maxSpeCap2 += 250;
						maxIntCap2 -= 30;
						maxWisCap2 -= 30;
						break;
				}
				break;
			case "sandstone":
				switch(Forgefather.refinement){
					case 1:
						maxSpeCap2 += 100;
						maxStrCap2 += 25;
						maxIntCap2 += 25;
						maxWisCap2 -= 10;
						break;
					case 2:
						maxSpeCap2 += 150;
						maxStrCap2 += 35;
						maxIntCap2 += 35;
						maxWisCap2 -= 15;
						break;
					case 3:
						maxSpeCap2 += 200;
						maxStrCap2 += 50;
						maxIntCap2 += 50;
						maxWisCap2 -= 20;
						break;
					case 4:
						maxSpeCap2 += 200;
						maxStrCap2 += 50;
						maxIntCap2 += 50;
						maxWisCap2 -= 20;
						break;
					case 5:
						maxSpeCap2 += 500;
						maxStrCap2 += 125;
						maxIntCap2 += 125;
						maxWisCap2 -= 30;
						break;
				}
				break;
			
		}
		if (body.player.hasPerk(PerkLib.GargoylePure)) {
			maxWisCap2 += 130;
			maxLibCap2 -= 20;
			currentSen -= 10;
		}
		if (body.player.hasPerk(PerkLib.GargoyleCorrupted)) {
			maxWisCap2 -= 20;
			maxLibCap2 += 140;
		}
		switch (Forgefather.channelInlay){
			case "emerald":
				if (Forgefather.refinement == 5) maxSpeCap2 += 100;
				else maxSpeCap2 += 50;
				break;
		}
		switch (Forgefather.gem){
			case "emerald":
				if (Forgefather.refinement == 5) maxSpeCap2 += 50;
				else maxSpeCap2 += 25;
				break;
		}
		return {
			"str.mult": maxStrCap2/100,
			"tou.mult": maxTouCap2/100,
			"spe.mult": maxSpeCap2/100,
			"int.mult": maxIntCap2/100,
			"wis.mult": maxWisCap2/100,
			"lib.mult": maxLibCap2/100,
			"sens": currentSen
		}
	}
}
}
