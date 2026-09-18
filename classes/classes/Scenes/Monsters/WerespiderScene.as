/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
import classes.*;
import classes.BodyParts.*;
import classes.GlobalFlags.kFLAGS;
import classes.Races.WerespiderRace;
import classes.Scenes.SceneLib;

	public class WerespiderScene extends BaseContent
	{
		
		public function WerespiderScene() 
		{}

public function werespiderEncounter():void {
	clearOutput();
	outputText("As you walk through the tunnels, you spot something passing you on the walls in the corner of your vision... Something small. Then another... and another. Over next minute, both sides of the tunnel is infested with many tiny creatures... probably some sort of multilegged insects.\n\n");
	outputText("\"<i>Hello there.</i>\" A female voice calls to you, and as you turn around, you see a spider-like monster eyeing you with great interest... or perhaps she's just interested your neck. She seemingly wants something form you, and is willing to use force if needed.\n\n");
	startCombat(new Werespider());
}
public function lostToWerespider():void {
	clearOutput();
	//spriteSelect(SpriteDb.s_DarkElf);
	outputText("As you hit the ground, the werespider approaches you with a vicious smile.\n\n");
	if (player.isRaceCached(Races.WERESPIDER)) {
		outputText("\"<i>Another brood member? You should stay within your own territory!</i>\" she laughs before knocking you out without allowing you a chance to gather your thoughts.\n\n");
	}
	else {
		outputText("\"<i>It's your lucky night, snack. I would grant you a great boom as long you're worthy. But it could hurt a bit so...</i>\" she laughs before knocking you out without allowing you a chance to gather your thoughts.\n\n");
		if (!player.blockingBodyTransformations()) tfIntoWereSpider();
		else {
			outputText("Awakening ten minutes later, you feel totally drained... both metaphorically and physically.\n\n");
			player.fatigue = player.maxOverFatigue();
			player.HP = player.minHP() + 1;
		}
	}
	cleanupAfterCombat();
}
private function tfIntoWereSpider():void {
	clearOutput();
	outputText("You awaken ten minutes later and assess the damage. ");
	CoC.instance.transformations.TailSpider.applyEffect(false);
	CoC.instance.transformations.ArmsWerespider.applyEffect(false);
	CoC.instance.transformations.FaceWerespiderFangs.applyEffect(false);
	CoC.instance.transformations.LowerBodyWerespider.applyEffect(false);
	CoC.instance.transformations.EarsInsect.applyEffect(false);
	CoC.instance.transformations.EyesWerespider.applyEffect(false);
	CoC.instance.transformations.TongueHuman.applyEffect(false);
	CoC.instance.transformations.GillsNone.applyEffect(false);
	CoC.instance.transformations.WingsNone.applyEffect(false);
	CoC.instance.transformations.AntennaeNone.applyEffect(false);
	CoC.instance.transformations.HornsNone.applyEffect(false);
	CoC.instance.transformations.NipplesBlack.applyEffect();
	CoC.instance.transformations.HairHuman.applyEffect(false);
	if (player.hasCock() && player.normalCocks() < 1) {
		var selectedCockValue:int = -1;
		for (var indexI:int = 0; indexI < player.cocks.length; indexI++)
		{
			if (player.cocks[indexI].cockType != CockTypesEnum.HUMAN)
			{
				selectedCockValue = indexI;
				break;
			}
		}
		if (selectedCockValue != -1) {
			transformations.CockHuman(selectedCockValue).applyEffect(false);
			player.thickenCock(selectedCockValue, 2);
		}
	}
	var ngM:Number = (player.newGamePlusMod() + 1);
	var bonusStats:Number = 0;
	if (flags[kFLAGS.LUNA_MOON_CYCLE] == 3 || flags[kFLAGS.LUNA_MOON_CYCLE] == 5) bonusStats += 10;
	if (flags[kFLAGS.LUNA_MOON_CYCLE] == 2 || flags[kFLAGS.LUNA_MOON_CYCLE] == 6) bonusStats += 20;
	if (flags[kFLAGS.LUNA_MOON_CYCLE] == 1 || flags[kFLAGS.LUNA_MOON_CYCLE] == 7) bonusStats += 30;
	if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) bonusStats += 40;
	player.werebeastRacesPerkHousekeeping(4);
	if (!player.hasPerk(PerkLib.Araneathropy)) player.createPerk(PerkLib.Araneathropy,bonusStats,0,0,0);
	if (player.hasPerk(PerkLib.AraneathropyDormant)) player.removePerk(PerkLib.AraneathropyDormant);
	player.statStore.replaceBuffObject({ 'str.mult': bonusStats*0.05*ngM,'tou.mult': bonusStats*0.075*ngM,'spe.mult': bonusStats*0.075*ngM, 'minlustx': bonusStats * 0.005}, 'Araneathropy', { text: 'Araneathropy'});
	player.trainStat('str', +5, 100);
	player.trainStat('tou', +5, 100);
	player.trainStat('spe', +5, 100);
	player.trainStat('lib', +5, 100);
	player.dynStats("cor", 20);
	statScreenRefresh();
}
public function wonWithWerespider():void {
	clearOutput();//"+(wsG()?"his":"her")+"			"+(wsG()?"his":"her")+"
	//spriteSelect(SpriteDb.s_DarkElf);
	//outputText("\"<i></i>\"\n\n");
	if (player.hasPerk(PerkLib.HighStakesTamer)) {
		menu();
		addButton(3, "Tame It", SceneLib.campMakeWinions.tamingAttempt);
		addButton(4, "Next", wonWithWerespider2);
	}
	else wonWithWerespider2();
}
private function wonWithWerespider2():void {
	outputText("Seeing her impending defeat, your opponent's body breaks down, shattering into several tiny spiders before they scatter in all directions. Yet, in her retreat, she still dropped some loot for you to take, despite the inconvenience she offered.\n\n");
	cleanupAfterCombat();
}

	}

}