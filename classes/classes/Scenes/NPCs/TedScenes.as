/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.kFLAGS;

public class TedScenes extends NPCAwareContent
	{
		
		
		public function TedScenes()
		{
		}

		public function canEncounterTed():Boolean {
			return flags[kFLAGS.TED_LVL_UP] >= 1 && flags[kFLAGS.TED_LVL_UP] < 2 && !player.hasStatusEffect(StatusEffects.TedOff) && player.statusEffectv1(StatusEffects.CampSparingNpcsTimers4) < 1;
		}

public function tedWrath(changes:Number = 0):Number {
	flags[kFLAGS.TED_WRATH] += changes;
	if (flags[kFLAGS.TED_WRATH] > 100) flags[kFLAGS.TED_WRATH] = 100;
	return flags[kFLAGS.TED_WRATH];
}
//0-15 wrath
public function defeatedTed():void {
	outputText(". Despite the situation, he starts muttering, seemingly to himself, but with his voice loud enough that it seems he wants you to hear it.\n\n");
	outputText("\"<i>I lost? No... I just feel gracious today, choosing not to show this mortal my limitless divine powers, and should...</i>\" He pauses, as if thinking over his next words, \"<i>make a grand strategic retreat for now.</i>\"\n\n");
	outputText("When you start moving closer to him, he suddenly stands up, and before you can react, he crushes some sort of talisman, laughing loudly. \"<i>I have other matters to attend to, so I’ll let you off the hook today.</i>\" he utters, as a bright light blinds you for a long moment, allowing him to make his 'grand strategic retreat.'");
	outputText("\"<i>Repent for your sins and worship me properly when we meet again, or my ban hammer won’t be so forgiving next time,</i>\" his last words echo through the room as your blindness recedes. It seems he used some sort of teleportation item to escape, and this may not be the last time you encounter this slightly delusional dragon-boy.");
	flags[kFLAGS.TED_DEFEATS_COUNTER] = 1;
	flags[kFLAGS.HIDDEN_CAVE_BOSSES] = 1;
	flags[kFLAGS.TED_LVL_UP] = 1;
	cleanupAfterCombat();
	return;
}
public function lostToTed():void {
	clearOutput();
	outputText("After another swing of the enemy's hammer, you lose consciousness.\n\n");
	outputText("<b>A few hours later...</b>\n\n");
	outputText("You wake up with a terrible headache, only to find yourself tied up and guarded by... one of those loli bat golems you had beaten earlier. She slowly walks up to you, smiling in a way that, due to her golem nature, looks very creepy. Then she speaks, \"<i>Master, after careful consideration, has evaluated you as not suitable material for his ever-growing army of worshipers. But...</i>\"");
	outputText(" Her smile grows wider (or perhaps one would say more creepy), \"<i>he also needs some examples to show how those who reject his offer end up, especially when they force him to send his faithful minions to 'correct' them. Of course, there is always a chance a mortal may not survive the 'corrections'...</i>\" ");
	outputText("With that, she closes the distance between you both and, without another word, begins to pummel you. She doesn’t stop, even when you lose consciousness again. Only when she is sure you are no longer breathing does she stop.\n\n");
	outputText("\"<i>You're as reliable as always, Aurora. If only the other little sisters were as faithful servants as you...</i>\".\n\n");
	EventParser.gameOver();
	removeButton(1);
}
public function introPostHiddenCave():void {
	clearOutput();
	if (flags[kFLAGS.TED_LVL_UP] == 1 && flags[kFLAGS.TED_DEFEATS_COUNTER] == 1) {
		outputText("While exploring the area, you suddenly hear someone's voice coming from somewhere above you.\n\n");
		outputText("\"<i>Have you repented for your sins and are ready to worship me properly now?</i>\" Upon looking up, you see someone who looks like a dragon boy in green dragonscale armor holding an oversized hammer. He seems a bit familiar, but you can't recall where you’ve seen him before.\n\n");
		outputText("\"<i>Accept your punishment, Junior!</i>\"\n\n");
	}
	else {
		outputText("While exploring the area, you suddenly hear someone’s voice coming from somewhere above you.\n\n");
		outputText("\"<i>Repent, sinner...</i>\" and you just manage to dodge as he throws his hammer at you.\n\n");
	}
	startCombat(new Ted());
}

public function defeatedTedPostHiddenCave():void {
	if (flags[kFLAGS.TED_LVL_UP] >= 3) {
		outputText(".");
		outputText("\n\n\"<i>My Dao Heart is firm.</i>\" he recite before escaping with the help of a smokescreen.\n\n");//WIP post combat version
	}
	else if (flags[kFLAGS.TED_LVL_UP] == 2) {
		outputText(".");
		outputText("\n\n\"<i>My Dao Heart is firm.</i>\" he recite before escaping with the help of a smokescreen.\n\n");//WIP post combat version
	}//w walce po której Ted awansuje do lvl 27 dać fragment gdzie on lub ktoś inny jak npc. jakiś loli bat golem co Ted ją znalazł do pomocy zdradza jego imie typu: mistrzu ted bla bla bla
	else if (flags[kFLAGS.TED_LVL_UP] == 1 && flags[kFLAGS.TED_DEFEATS_COUNTER] == 2) {
		outputText(". Expecting him to pull some strange move again, you try to reach him, but once again, he’s faster. He throws something on the ground, causing a bright flash of light that temporarily blinds you. By the time your vision clears, he's already gone, without even leaving any witty remarks during his escape.\n\n");
		levelingHimself();
	}
	else {
		outputText(". Despite the situation, he starts to speak.\n\n");
		outputText("\"<i>This defeat shall not affect my Dao heart. I am not bound by a mortal’s ignorance.</i>\" He seems to be reciting some poem, which makes you notice too late the movement of his right hand, causing the surroundings to flicker slightly. Yes, your enemy has definitely managed to pull off whatever trick he planned, as you now see four or five of him around you, each doing the exact same movement—reaching into his pocket with his left hand to pull out two jade talismans.\n\n");
		outputText("\"<i>No!</i>\" for a split second the dragon-boy panics at seeing one of them fall to the ground with a loud clank. It definitely looks like he only planned for one of the talisman to be pulled out. After a moment of hesitation, he crushes the second one not paying any attention to the one he dropped.\n\n");
		outputText("\"<i>Ahhhh, maybe I was planning on severing the karma with 'that', so you can have that trash talisman,</i>\" all five of them say as they vanish in a bright flash of light.\n\n");
		outputText("Damn it, now you recall where you’ve seen him before. It feels like déjà vu as he escapes again, leaving you with more cryptic words. After the light recedes, you only see one talisman instead of five lying on the ground. After a moment of consideration and a brief internal struggle over whether to pick it up or not, you decide to take the jade talisman. ");
		outputText("Making sure it's nothing dangerous, you take a closer look. Luckily for you, it does not seem to be like the jade talisman your enemy used, but rather its function seems to be to 'open' something. But no matter how much you think about it, nothing helps you figure out what it can open.\n\n");
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
	outputText("\"<i>You thought I wouldn't punish you for your sins? I will, if only so that you can finally see my perfect greatness!</i>\" He raises his hammer, hesitating for a moment. \"<i>Enjoy your bam, sinner!!!</i>\"\n\n");
	outputText("The last thing you remember before blacking out for several hours is the feeling of something being sealed away inside your body.\n\n");
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
