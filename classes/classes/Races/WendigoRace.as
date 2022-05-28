package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class WendigoRace extends Race {
	public function WendigoRace(id:int) {
		super("Wendigo", id);
	}
	
	public override function setup():void {
		
		addScores()
				.hairColor("silver-white", +1)
				.skinCoatColor("snow white", +1)
				.eyeType(Eyes.DEAD, +1)
				.eyeColor("spectral blue", +1)
				.tongueType(Tongue.RAVENOUS_TONGUE, +1)
				.hornTypeAndCount(Horns.ANTLERS, AT_LEAST(4), +2)
				.earType(Ears.DEER, +1)
				.tailType(Tail.WENDIGO,+1)
				.legType(LowerBody.WENDIGO, +1)
				.armType(Arms.WENDIGO, +1)
				.faceType(ANY(Face.DEER, Face.ANIMAL_TOOTHS), +1)
				.rearType(RearBody.FUR_COAT, +2)
				.wingType(Wings.LEVITATION, +3)
				.skinType(ANY(Skin.PLAIN,Skin.FUR), +1)
				.cockOrVaginaOfType(CockTypesEnum.HORSE, VaginaClass.EQUINE, +1)
				.customRequirement("","big E-cup if has vagina, flat chest otherwise",
						function (body:BodyData):Boolean {
							return body.hasVagina && body.biggestTitSize >= 8 || !body.hasVagina && body.biggestTitSize == 0
						}, +1)
				.hasPerk(PerkLib.EndlessHunger, +1);
		
		buildTier(10, "wendigo")
				.buffs({
					"str.mult": +0.70,
					"tou.mult": +0.70,
					"int.mult": +0.60,
					"wis.mult": +0.50,
					"lib.mult": +0.50,
					"sens": +50
				})
				.end();
		
		buildTier(25, "great wendigo")
				.buffs({
					"str.mult": +0.70,
					"tou.mult": +0.70,
					"spe.mult": +0.60,
					"wis.mult": +0.50,
					"lib.mult": +0.50,
					"sens": +50
				})
				.end();
	}
}
}
