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
				.skinMaterialColor(ANY(GargoyleSkinColors), +1)
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
		var strBuff:int=0,
			touBuff:int=0,
			speBuff:int=0,
			intBuff:int=0,
			wisBuff:int=0,
			libBuff:int=0,
			sensBuff:int=0;
		switch (Forgefather.material){
			case "stone":
				switch(Forgefather.refinement){
					case 1:
						strBuff += 50;
						touBuff += 50;
						speBuff += 50;
						intBuff += 50;
						wisBuff += 50;
						libBuff += 50;
						break;
					case 2:
						strBuff += 75;
						touBuff += 75;
						speBuff += 75;
						intBuff += 75;
						wisBuff += 75;
						libBuff += 75;
						break;
					case 3:
						strBuff += 100;
						touBuff += 100;
						speBuff += 100;
						intBuff += 100;
						wisBuff += 100;
						libBuff += 100;
						break;
				}
				break;
			case "alabaster":
				//Alabaster - Magic (Int+100%, +20% max mana, +15% spell dmg)
				switch(Forgefather.refinement){
					case 1:
						intBuff += 100;
						wisBuff += 50;
						strBuff -= 10;
						touBuff -= 10;
						break;
					case 2:
						intBuff += 150;
						wisBuff += 75;
						strBuff -= 15;
						touBuff -= 15;
						break;
					case 3:
						intBuff += 200;
						wisBuff += 100;
						strBuff -= 20;
						touBuff -= 20;
						break;
					case 4:
						intBuff += 200;
						wisBuff += 100;
						strBuff -= 20;
						touBuff -= 20;
						break;
					case 5:
						intBuff += 500;
						wisBuff += 250;
						strBuff -= 30;
						touBuff -= 30;
						break;
				}
				break;
			case "marble":
				switch(Forgefather.refinement){
					case 1:
						wisBuff += 100;
						strBuff += 50;
						intBuff -= 10;
						break;
					case 2:
						wisBuff += 150;
						strBuff += 75;
						intBuff -= 15;
						break;
					case 3:
						wisBuff += 200;
						strBuff += 100;
						intBuff -= 20;
						break;
					case 4:
						wisBuff += 200;
						strBuff += 100;
						intBuff -= 20;
						break;
					case 5:
						wisBuff += 500;
						strBuff += 200;
						intBuff -= 30;
						break;
				}
				break;
			case "granite":
				switch(Forgefather.refinement){
					case 1:
						touBuff += 100;
						strBuff += 50;
						intBuff -= 10;
						wisBuff -= 10;
						break;
					case 2:
						touBuff += 150;
						strBuff += 75;
						intBuff -= 15;
						wisBuff -= 15;
						break;
					case 3:
						touBuff += 200;
						strBuff += 100;
						intBuff -= 20;
						wisBuff -= 20;
						break;
					case 4:
						touBuff += 200;
						strBuff += 100;
						intBuff -= 20;
						wisBuff -= 20;
						break;
					case 5:
						touBuff += 500;
						strBuff += 250;
						intBuff -= 30;
						wisBuff -= 30;
						break;
				}
				break;
			case "ebony":
				switch(Forgefather.refinement){
					case 1:
						strBuff += 100;
						speBuff += 50;
						intBuff -= 10;
						wisBuff -= 10;
						break;
					case 2:
						strBuff += 150;
						speBuff += 75;
						intBuff -= 15;
						wisBuff -= 15;
						break;
					case 3:
						strBuff += 200;
						speBuff += 100;
						intBuff -= 20;
						wisBuff -= 20;
						break;
					case 4:
						strBuff += 200;
						speBuff += 100;
						intBuff -= 20;
						wisBuff -= 20;
						break;
					case 5:
						strBuff += 500;
						speBuff += 250;
						intBuff -= 30;
						wisBuff -= 30;
						break;
				}
				break;
			case "sandstone":
				switch(Forgefather.refinement){
					case 1:
						speBuff += 100;
						strBuff += 25;
						intBuff += 25;
						wisBuff -= 10;
						break;
					case 2:
						speBuff += 150;
						strBuff += 35;
						intBuff += 35;
						wisBuff -= 15;
						break;
					case 3:
						speBuff += 200;
						strBuff += 50;
						intBuff += 50;
						wisBuff -= 20;
						break;
					case 4:
						speBuff += 200;
						strBuff += 50;
						intBuff += 50;
						wisBuff -= 20;
						break;
					case 5:
						speBuff += 500;
						strBuff += 125;
						intBuff += 125;
						wisBuff -= 30;
						break;
				}
				break;
			
		}
		if (body.player.hasPerk(PerkLib.GargoylePure)) {
			wisBuff += 130;
			libBuff -= 20;
			sensBuff -= 10;
		}
		if (body.player.hasPerk(PerkLib.GargoyleCorrupted)) {
			wisBuff -= 20;
			libBuff += 140;
		}
		switch (Forgefather.channelInlay){
			case "emerald":
				if (Forgefather.refinement == 5) speBuff += 100;
				else speBuff += 50;
				break;
		}
		switch (Forgefather.gem){
			case "emerald":
				if (Forgefather.refinement == 5) speBuff += 50;
				else speBuff += 25;
				break;
		}
		return {
			"str.mult": strBuff/100,
			"tou.mult": touBuff/100,
			"spe.mult": speBuff/100,
			"int.mult": intBuff/100,
			"wis.mult": wisBuff/100,
			"lib.mult": libBuff/100,
			"sens": sensBuff
		}
	}
}
}
