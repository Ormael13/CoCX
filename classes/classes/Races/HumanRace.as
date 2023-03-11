package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CoC;
import classes.CockTypesEnum;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Player;
import classes.Race;
import classes.VaginaClass;

public class HumanRace extends Race {
	public static const HumanSkinColors:/*String*/Array = ["tan", "olive", "dark", "light"];
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

	public function HumanRace(id:int) {
		super("Human", id, RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	override public function setup():void {
		addScores()
				.plainSkinOfAdj(NOT("slippery"), +1)
				.hairType(Hair.NORMAL, +1)
				.faceType(Face.HUMAN, +1)
				.eyeType(Eyes.HUMAN, +1)
				.earType(Ears.HUMAN, +1)
				.earType(NOT(Ears.ELVEN), 0, -7)
				.tongueType(Tongue.HUMAN, +1)
				.noGills(+1)
				.noAntennae(+1)
				.noHorns(+1)
				.noWings(+1)
				.noTail(+1)
				.armType(Arms.HUMAN, +1)
				.legType(LowerBody.HUMAN, +1)
				.noRearBody(+1)
				.skinBasePattern(Skin.PATTERN_NONE, +1)
				.cockOrVaginaOfType(CockTypesEnum.HUMAN, VaginaClass.HUMAN, +1)
				.customRequirement("", "normal skin and 1 breast row",
						function (body:BodyData):Boolean {
							return (body.player.breastRows.length == 1
									&& body.player.hasPlainSkinOnly()
									&& body.skinBaseAdj != "slippery")
						}, +1);
		addScoresAfter(17)
				.hasPerk(PerkLib.HumanSupremacyInitial, +2)
				.hasPerk(PerkLib.HumanSupremacyBasic, +2)
				.hasPerk(PerkLib.HumanSupremacyImproved, +2);
		
		addMutation(IMutationsLib.HumanAdrenalGlandsIM);
		addMutation(IMutationsLib.HumanFatIM);
		addMutation(IMutationsLib.HumanMusculatureIM);
		addMutation(IMutationsLib.HumanOvariesIM);
		addMutation(IMutationsLib.HumanParathyroidGlandIM);
		addMutation(IMutationsLib.HumanTesticlesIM);
		addMutation(IMutationsLib.HumanThyroidGlandIM);
		
		tiers.push(new HumanRaceTier(maxScore-9));
		
		debugForms = {
			"human": [
					game.transformations.SkinPlain,
					game.transformations.HairHuman,
					game.transformations.FaceHuman,
					game.transformations.EyesHuman,
					game.transformations.EarsHuman,
					game.transformations.TongueHuman,
					game.transformations.GillsNone,
					game.transformations.AntennaeNone,
					game.transformations.HornsNone,
					game.transformations.WingsNone,
					game.transformations.TailNone,
					game.transformations.ArmsHuman,
					game.transformations.LowerBodyHuman,
					game.transformations.RearBodyNone,
					game.transformations.SkinPatternNone,
					game.transformations.NipplesPerBreastOne,
					game.transformations.BreastRowsRemoveToOne
			]
		}
	}
	
	public static const maxScore:int = 17;
	
	override public function finalizeScore(body:BodyData, score:int, checkRP:Boolean = true, outputText:Function = null):int {
		var ics:Number = (body.player.internalChimeraScore() - body.player.internalHumanScore());
		if (ics < 0) ics = 0;
		if (ics > 0) {
			if (outputText != null) {
				outputText(ics == 1 ? "Mutation" : "Mutations", -ics);
			}
			score -= ics;
		}
		score = super.finalizeScore(body, score, checkRP, outputText);
		return score;
	}
	
	public static function xpBoostBase(player:Player):Number {
		var baseHumBoost1:Number = 1;
		if (player.level >= 6) baseHumBoost1 += 1;
		if (player.level >= 24) baseHumBoost1 += 1;
		if (player.level >= 42) baseHumBoost1 += 1;
		if (player.level >= 72) baseHumBoost1 += 1;
		if (player.level >= 102) baseHumBoost1 += 1;
		if (player.level >= 141) baseHumBoost1 += 1;
		if (player.level >= 180) baseHumBoost1 += 1;
		//if (level >= 274)
		return baseHumBoost1;
	}
	
	public static function xpBoostMultiplier(player:Player, humanScore:int):Number {
		var boost:Number = 10 + humanScore - maxScore;
		return boost > 0 ? boost : 0;
	}
	
	public static function xpBoost(player:Player, humanScore:int):Number {
		return xpBoostBase(player) * xpBoostMultiplier(player, humanScore);
	}
}
}

import classes.BodyData;
import classes.RaceTier;
import classes.Races;
import classes.Races.HumanRace;

class HumanRaceTier extends RaceTier {
	public function HumanRaceTier(minScore:int) {
		super(
				minScore,
				"human",
				function (body:BodyData):String {
					return "human"
				},
				1,
				{},
				[],
				[]
		);
	}
	
	override public function hasBuffs():Boolean {
		return true;
	}
	
	override public function describeBuffs(
			body:BodyData,
			separator:String         = ", ",
			withExtraBonuses:Boolean = true
	):String {
		if (!withExtraBonuses) return "";
		if (!body) return "Bonus EXP gains";
		var boost:Number = HumanRace.xpBoost(body.player, body.player.racialScore(Races.HUMAN));
		if (boost <= 0) return "";
		return "+" + boost + " bonus EXP gains";
	}
}
