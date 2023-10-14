/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
import classes.*;

	public class WerespiderScene extends BaseContent
	{
		
		public function WerespiderScene() 
		{}

public function werespiderEncounter():void {
	clearOutput();
	outputText("\n\n");
	outputText("\"<i></i>\"\n\n");
	outputText("\n\n");
	startCombat(new Werespider());
}
private function tfIntoWereSpider():void {
	clearOutput();
	outputText("\n\n");/*
	player.lowerBody = LowerBody.WOLF;
	if (player.legCount != 2) player.legCount = 2;
	player.tailType = Tail.WOLF;
	if (player.tailCount != 1) player.tailCount = 1;
	player.rearBody.type = RearBody.WOLF_COLLAR;
	player.arms.type = Arms.WOLF;
	CoC.instance.transformations.FaceWolfFangs.applyEffect(false);
	player.ears.type = Ears.WOLF;
	player.eyes.type = Eyes.FERAL;
	player.tongue.type = Tongue.DOG;
	player.wings.type = Wings.NONE;
	player.antennae.type = Antennae.NONE;
	player.horns.type = Horns.NONE;
	CoC.instance.transformations.SkinFur(Skin.COVERAGE_LOW).applyEffect(false);
	if (player.hasCock() && player.wolfCocks() < 1) {
		var selectedCockValue:int = -1;
		for (var indexI:int = 0; indexI < player.cocks.length; indexI++)
		{
			if (player.cocks[indexI].cockType != CockTypesEnum.WOLF)
			{
				selectedCockValue = indexI;
				break;
			}
		}
		if (selectedCockValue != -1) {
			transformations.CockWolf(selectedCockValue).applyEffect(false);
			player.thickenCock(selectedCockValue, 2);
		}
	}
	var ngM:Number = (player.newGamePlusMod() + 1);
	var bonusStats:Number = 0;
	if (flags[kFLAGS.LUNA_MOON_CYCLE] == 3 || flags[kFLAGS.LUNA_MOON_CYCLE] == 5) bonusStats += 10;
	if (flags[kFLAGS.LUNA_MOON_CYCLE] == 2 || flags[kFLAGS.LUNA_MOON_CYCLE] == 6) bonusStats += 20;
	if (flags[kFLAGS.LUNA_MOON_CYCLE] == 1 || flags[kFLAGS.LUNA_MOON_CYCLE] == 7) bonusStats += 30;
	if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) bonusStats += 40;
	if (player.hasPerk(PerkLib.Vulpesthropy)) {
		player.createPerk(PerkLib.VulpesthropyDormant,0,0,0,0);
		player.removePerk(PerkLib.Vulpesthropy);
	}
	if (!player.hasPerk(PerkLib.Lycanthropy)) player.createPerk(PerkLib.Lycanthropy,bonusStats,0,0,0);
	if (player.hasPerk(PerkLib.LycanthropyDormant)) player.removePerk(PerkLib.LycanthropyDormant);
	player.statStore.replaceBuffObject({ 'str.mult': bonusStats*0.1*ngM,'tou.mult': bonusStats*0.06*ngM,'spe.mult': bonusStats*0.04*ngM, 'minlustx': bonusStats * 0.01}, 'Lycanthropy', { text: 'Lycanthropy'});
	player.trainStat('str', +5, 100);
	player.trainStat('tou', +5, 100);
	player.trainStat('spe', +5, 100);
	player.trainStat('lib', +5, 100);
	player.dynStats("cor", 20);
	statScreenRefresh();*/
}

	}

}