/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.UniqueSexScenes;

public class TedScenes extends NPCAwareContent
	{
		
		public var uniquuuesexscene:UniqueSexScenes = new UniqueSexScenes();
		
		public function TedScenes() 
		{
		}
		
public function tedWrath(changes:Number = 0):Number {
	flags[kFLAGS.TED_WRATH] += changes;
	if (flags[kFLAGS.TED_WRATH] > 100) flags[kFLAGS.TED_WRATH] = 100;
	return flags[kFLAGS.TED_WRATH];
}
//0-15 wrath
public function defeatedTed():void {
	outputText(". Despite situation he start to muttering seemly to himself but with his voice volume it seems he want you to hear it.\n\n");
	outputText("\"<i>I lost? No...I just feel gratious today to not show this mortal my limitless divine powers and should...</i>\" he paused as if thinking over next words to say \"<i>make a grand strategical retreat for now.</i>\"\n\n");
	outputText("When you start to moving closer to him all of sudden he stands up and before you even react crushing some sort of talisman laughing loud. \"<i>I need to attend to other maters so I letting you off the hook today.</i>\" He utters when the brighting light blinds you for a long moment to let him make this 'grand stategical retreat'.");
	outputText("\"<i>Repent on your sins and worship me properly when we meet again or my bam hammer won't be so forgving then,</i>\" his last words echoes in room as your blindness receding. Seems he used some sort of teleport item to escape and it seems it may be not the last time you will meet this slight delusional dragon-boy.");
	flags[kFLAGS.TED_DEFEATS_COUNTER] = 1;
	flags[kFLAGS.HIDDEN_CAVE_BOSSES] = 1;
	flags[kFLAGS.TED_LVL_UP] = 1;
	cleanupAfterCombat();
	return;
}
public function lostToTed():void {
	clearOutput();
	outputText("After another swing of enemy hammer you loose consciousness.\n\n");
	outputText("<b>Few hours later...</b>\n\n");
	outputText("You wakes up with terrible headache just to find yourself tied up and guarded by... one of those loli bat golems you beaten. She slowly walk up to you smiling that due to her golem anture look very creepy and then she speaks, \"<i>Master after consideration evaluated you as not good material to his evergrowing army of worshipers. But....</i>\"");
	outputText(" her smile become more wider (or maybe one would say more creppy), \"<i>he need also some examples to show how ends up those that rejected his offer right away and forced him to send his faithfull minions to 'correct' those mortals. Of course there is always chance mortal can not survive 'corrections'...</i>\" ");
	outputText("And with that she close the distance divinding you both and without any more words start to pummel you that not stops even when you loose consciousness again. Only when she is sure that you not longer breathing she stopping.\n\n");
	outputText("\"<i>You're as reliable as always Aurora. If only other little sisters was as faithfull servants as you...</i>\".\n\n");
	EventParser.gameOver();
	removeButton(1);
}
public function introPostHiddenCave():void {
	clearOutput();
	if (flags[kFLAGS.TED_LVL_UP] == 1 && flags[kFLAGS.TED_DEFEATS_COUNTER] == 1) {
		outputText("During exploration of the area you suddenly hear someone voice coming from somewhere above you.\n\n");
		outputText("\"<i>Have you repented for your sins and are ready to worship me properly now?</i>\" Upon looking up you see somebody looking like dragon boy in green dragonscale armor holding oversized hammer. He seems a bit familiar, but you can't recall where you’ve seen him before.\n\n");
		outputText("\"<i>Accept your punishment Junior...</i>\"\n\n");
	}
	else {
		outputText("During exploration of the area you suddenly hear someone’s voice coming from somewhere above you.\n\n");
		outputText("\"<i>Repent sinner...</i>\" and you just dodge in time throws at you his hammer.\n\n");
	}
	startCombat(new Ted());
	doNext(playerMenu);
}
public function defeatedTedPostHiddenCave():void {
	if (flags[kFLAGS.TED_LVL_UP] >= 3) {
		outputText(".");
		outputText("\n\n\"<i>My Dao Heart is firm.</i>\" he recite before escaping with help of smokescreen.\n\n");//WIP post combat version
		menu();
		if (player.pcCanUseUniqueSexScene()) addButton(13, "U. Sex Scenes", uniquuuesexscene.pcUniqueSexScenesChoiceMenu).hint("Other non typical sex scenes.");
		addButton(14, "Leave", cleanupAfterCombat);
	}
	if (flags[kFLAGS.TED_LVL_UP] == 2) {
		outputText(".");
		outputText("\n\n\"<i>My Dao Heart is firm.</i>\" he recite before escaping with help of smokescreen.\n\n");//WIP post combat version
	}//w walce po której Ted awansuje do lvl 27 dać fragment gdzie on lub ktoś inny jak npc. jakiś loli bat golem co Ted ją znalazł do pomocy zdradza jego imie typu: mistrzu ted bla bla bla
	else if (flags[kFLAGS.TED_LVL_UP] == 1 && flags[kFLAGS.TED_DEFEATS_COUNTER] == 2) {
		outputText(". Expecting him to pull some weird move again you try to reach him but he's again faster. He throws something on the ground, causing a bright flash of light that blinds you temporarily. After you can see again, he's already gone, without even leaving any witty remarks during his escape.\n\n");
		levelingHimself();
	}
	else {
		outputText(". Despite situation he starts to talk.\n\n");
		outputText("\"<i>That shall not affect my Dao. My Dao is not bound by a mortal’s ignorance.</i>\" he seems to recite some poem, which makes you notice too late his right hand movement that cause all surrounding to slight flicker. Yes, your enemy has definitely managed to pull whatever trick he planned, as you now see four of five of them around you each doing the exact same movements of reaching into his pocket with his left hand to pull out two jades talismans.\n\n");
		outputText("\"<i>No!</i>\" for a split second the dragon-boy panics at seeing one of them fall to the ground with a loud clank. It definitely looks like he only planned for one of the talisman to be pulled out. After a moment of hesitation, he crushes the second one not paying any attention to the one he dropped.\n\n");
		outputText("\"<i>Ahhhh, maybe I was planning severing the karma with 'that', so you can have that trash talisman,</i>\" all five of them talk while vanishing in a bright flash of light.\n\n");
		outputText("Damn it, now you recall where you’ve seen him before. And you feel like it is déjà vu when he escapes, again, while leaving you with some cryptic words. After the light recedes you only see one talisman instead five laying on the ground. After a moment of consideration and a brief internal struggle later on whether to pick it up or not, you decide to take the jade talisman. ");
		outputText("Making sure it's nothing dangerous you take a closer look. Luckily for you, it does not seem to be like the jade talisman your enemy used, but rather it function seems to be to 'open' something. But no matter how much you think about it, nothing helps you figure out what it can open.\n\n");
		outputText("<b>Gained Key Item: Jade Talisman</b>\n\n");
		player.createKeyItem("Jade Talisman", 0, 0, 0, 0);
		flags[kFLAGS.TED_DEFEATS_COUNTER]++;
		tedWrath(10);
	}
	cleanupAfterCombat();
}
public function lostToTedPostHiddenCave():void {
	clearOutput();
	outputText("The "+(flags[kFLAGS.TED_LVL_UP] >= 3 ?"Ted":"dragon-boy")+" walks neither fast nor slow towards your prone body.\n\n");
	outputText("\"<i>You thought I wouldn't punish you for your sins? I will, if only so that you can finally see my perfect greatness!</i>\" He raises his hammer, seeming to hesitate for a moment. \"<i>Enjoy your bam, sinner!!!</i>\"\n\n");
	outputText("Last thing you remember before blanking out for several hours is the feeling of something being sealed away in your body.\n\n");
	if (player.statusEffectv1(StatusEffects.Bammed1) < 3 && player.statusEffectv2(StatusEffects.Bammed1) < 3 && player.statusEffectv1(StatusEffects.Bammed2) < 3 && player.statusEffectv2(StatusEffects.Bammed2) < 3) bammingPC();
	cleanupAfterCombat();
}
private function levelingHimself():void {
	flags[kFLAGS.TED_DEFEATS_COUNTER]++;
	if (flags[kFLAGS.TED_DEFEATS_COUNTER] == 3 && flags[kFLAGS.TED_LVL_UP] == 1) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 1, 18);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 18, 0, 0, 0);
		flags[kFLAGS.TED_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.TED_LVL_UP] = 2;
	}/*
	if (flags[kFLAGS.TED_DEFEATS_COUNTER] == 4 && flags[kFLAGS.TED_LVL_UP] == 2) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 1, 24);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 24, 0, 0, 0);
		flags[kFLAGS.TED_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.TED_LVL_UP] = 3;
	}
	if (flags[kFLAGS.TED_DEFEATS_COUNTER] == 5 && flags[kFLAGS.TED_LVL_UP] == 3) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 1, 30);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 30, 0, 0, 0);
		flags[kFLAGS.TED_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.TED_LVL_UP] = 4;
	}*/
	tedWrath(5);
}
private function bammingPC():void {
	//spells ??? i soulskills i tease ??? bammed
	if (rand(2) == 0 && (!player.hasStatusEffect(StatusEffects.Bammed2) || player.statusEffectv2(StatusEffects.Bammed2) < 3)) {//magic specials
		if (!player.hasStatusEffect(StatusEffects.Bammed2)) player.createStatusEffect(StatusEffects.Bammed2, 0, 0, 0, 0);
		if (player.statusEffectv2(StatusEffects.Bammed2) == 1) {
			if (player.statusEffectv2(StatusEffects.Bammed2) == 2) player.addStatusValue(StatusEffects.Bammed2, 2, 1);
			else {
				player.addStatusValue(StatusEffects.Bammed2, 2, 1);
				player.addStatusValue(StatusEffects.Bammed2, 4, 72);
			}
		}
		else {
			player.addStatusValue(StatusEffects.Bammed2, 2, 1);
			player.addStatusValue(StatusEffects.Bammed2, 4, 24);
		}
	}
	if (rand(2) == 0 && (!player.hasStatusEffect(StatusEffects.Bammed2) || player.statusEffectv1(StatusEffects.Bammed2) < 3)) {//physical specials
		if (!player.hasStatusEffect(StatusEffects.Bammed2)) player.createStatusEffect(StatusEffects.Bammed2, 0, 0, 0, 0);
		if (player.statusEffectv1(StatusEffects.Bammed2) == 1) {
			if (player.statusEffectv1(StatusEffects.Bammed2) == 2) player.addStatusValue(StatusEffects.Bammed2, 1, 1);
			else {
				player.addStatusValue(StatusEffects.Bammed2, 1, 1);
				player.addStatusValue(StatusEffects.Bammed2, 3, 72);
			}
		}
		else {
			player.addStatusValue(StatusEffects.Bammed2, 1, 1);
			player.addStatusValue(StatusEffects.Bammed2, 3, 24);
		}
	}
	if (rand(2) == 0 && (!player.hasStatusEffect(StatusEffects.Bammed1) || player.statusEffectv2(StatusEffects.Bammed1) < 3)) {//range attacks
		if (!player.hasStatusEffect(StatusEffects.Bammed1)) player.createStatusEffect(StatusEffects.Bammed1, 0, 0, 0, 0);
		if (player.statusEffectv2(StatusEffects.Bammed1) == 1) {
			if (player.statusEffectv2(StatusEffects.Bammed1) == 2) player.addStatusValue(StatusEffects.Bammed1, 2, 1);
			else {
				player.addStatusValue(StatusEffects.Bammed1, 2, 1);
				player.addStatusValue(StatusEffects.Bammed1, 4, 72);
			}
		}
		else {
			player.addStatusValue(StatusEffects.Bammed1, 2, 1);
			player.addStatusValue(StatusEffects.Bammed1, 4, 24);
		}
	}
	if (rand(2) == 0 && (!player.hasStatusEffect(StatusEffects.Bammed1) || player.statusEffectv1(StatusEffects.Bammed1) < 3)) {//melee attacks
		if (!player.hasStatusEffect(StatusEffects.Bammed1)) player.createStatusEffect(StatusEffects.Bammed1, 0, 0, 0, 0);
		if (player.statusEffectv1(StatusEffects.Bammed1) == 1) {
			if (player.statusEffectv1(StatusEffects.Bammed1) == 2) player.addStatusValue(StatusEffects.Bammed1, 1, 1);
			else {
				player.addStatusValue(StatusEffects.Bammed1, 1, 1);
				player.addStatusValue(StatusEffects.Bammed1, 3, 72);
			}
		}
		else {
			player.addStatusValue(StatusEffects.Bammed1, 1, 1);
			player.addStatusValue(StatusEffects.Bammed1, 3, 24);
		}
	}
}
	}
}