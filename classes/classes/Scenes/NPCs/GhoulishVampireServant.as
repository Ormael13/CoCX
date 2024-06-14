/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.StatusEffects;

	public class GhoulishVampireServant extends NPCAwareContent
	{
		
		public function GhoulishVampireServant() 
		{}

public function ghoulGender():Boolean {
	if (player.statusEffectv3(StatusEffects.Familiar) > 1) return false;
	else return true;//1 - female, 2 - herm, 3 - male
}

public function ghoulishVampireServantMain():void {
	clearOutput();
	outputText("You walk up to "+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" and address "+(ghoulGender()?"her":"him")+".\n\n");
	outputText("\"<i>Good "+(isNightTime?"evening":"day")+" "+player.mf("master","mistress")+" [name], is there anything you would have this lowly me do? I delight in servicing you "+player.mf("milord","milady")+".</i>\"\n\n");
	menu();
	addButton(0, "Appearance", ghoulishVampireServantMainAppearance);
	//1 - sex
	addButton(2, "Guard Camp", ghoulishVampireServantMainGuardCamp).hint("Set to 'defend / not defend' the camp.");
	if (player.statusEffectv3(StatusEffects.Familiar) < 3) addButtonIfTrue(3, "Turn Male", ghoulishVampireServantMainTurnMale, "Req. to have Incubus Draft.", player.hasItem(consumables.INCUBID, 1), "Feed your slave some incubi draft to alter her gender toward male. Midpoint at Hermaphrodite.");
	if (player.statusEffectv3(StatusEffects.Familiar) > 1) addButtonIfTrue(4, "Turn Female", ghoulishVampireServantMainTurnFemale, "Req. to have Succubus Milk.", player.hasItem(consumables.SUCMILK, 1), "Feed your slave some succubus milk to alter his gender toward female. Midpoint at Hermaphrodite.");
	if (player.hasPerk(PerkLib.BasicLeadership)) addButton(5, "Team", ghoulishVampireServantHenchmanOption);
	else addButtonDisabled(5, "Team", "You need to have at least Basic Leadership to form a team.");
	addButton(14, "Back", camp.campSlavesMenu);
}

public function ghoulishVampireServantMainAppearance():void {
	clearOutput();
	outputText("Your ghoulish servant currently has a ");
	if (player.statusEffectv3(StatusEffects.Familiar) == 1) outputText("gorgeous");
	if (player.statusEffectv3(StatusEffects.Familiar) == 2) outputText("pretty");
	if (player.statusEffectv3(StatusEffects.Familiar) == 3) outputText("handsome");
	outputText(" face with "+(ghoulGender()?"pouting lips":"square jawline")+". "+(ghoulGender()?"Her":"His")+(ghoulGender()?"":" cock is "+(player.statusEffectv3(StatusEffects.Familiar)>2?"15":"9")+" inch long and")+(player.statusEffectv3(StatusEffects.Familiar)==2?""+(ghoulGender()?"her":"his")+"":"")+(player.statusEffectv3(StatusEffects.Familiar)>2?"":" cunt")+" ");
	outputText("dripping eagerly in anticipation of the abuses you could subject "+(ghoulGender()?"her":"him")+" to. "+(ghoulGender()?"Her":"His")+" chest is "+(ghoulGender()?"E cup and very squeezable":""+(player.statusEffectv3(StatusEffects.Familiar)>2?"flat":"C cup")+"")+".");
	menu();
	addButton(14, "Back", ghoulishVampireServantMain);
}

public function ghoulishVampireServantMainGuardCamp():void {
	clearOutput();
	if (player.statusEffectv1(StatusEffects.Familiar) == 0) {
		outputText("You tell your ghoul to defend the camp.");
		outputText("\n\n"+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" nods and gets to work. If only all of your followers were so compliant.");
		player.addStatusValue(StatusEffects.Familiar, 1, 1);
	}
	//Guard Off
	else {
		outputText("You tell your ghoul to not defend the camp.");
		outputText("\n\n"+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" nods and stop work. If only all of your followers were so compliant.");
		player.addStatusValue(StatusEffects.Familiar, 1, -1);
	}
	menu();
	addButton(0, "Next", ghoulishVampireServantMain);
}

public function ghoulishVampireServantMainTurnMale():void {
	clearOutput();
	player.destroyItems(consumables.INCUBID, 1);
	if (player.statusEffectv3(StatusEffects.Familiar) == 2)	outputText("You hand over the draft to your slave who drinks it without delay. Your servant begins moaning as her pussy lips flesh merges together and vanishes entirely, her cock spewing a thick rope of cum as it grows several inches longer up to 15 inches. Her appearance shifts completely to male with a square jawline, handsome face and flat breast.\n\n");
	else outputText("You hand over the draft to your slave who drinks it without delay. Your servant begins moaning as the flesh between her legs mold itself bunching up into a brand new 9 inch cock fitted with balls to match. Her appearance shift slightly to become less feminine her breast dropping down to C cup.\n\n");
	player.addStatusValue(StatusEffects.Familiar, 3, 1);
	menu();
	addButton(14, "Back", ghoulishVampireServantMain);
}

public function ghoulishVampireServantMainTurnFemale():void {
	clearOutput();
	player.destroyItems(consumables.SUCMILK, 1);
	if (player.statusEffectv3(StatusEffects.Familiar) == 2)	outputText("You hand over the draft to your slave who drinks it without delay. Your servant begins moaning as her pussy drools beads of girlcum, her cock spewing a thick rope of cum as it vanishes along with her balls shrinking away to nothingness.. Her appearance shifts completely to female with a gorgeous face, pouting lips and squeezable E cup breast.\n\n");
	else outputText("You hand over the draft to your slave who drinks it without delay. Your servant begins moaning as the flesh between her legs mold itself bunching up into a brand new pussy, her cock spewing a thick rope of cum as it shrinks several inches down to 9 inches. Her appearance shifts slightly to become more feminine her breasts growing up to C cup.\n\n");
	player.addStatusValue(StatusEffects.Familiar, 3, -1);
	menu();
	addButton(14, "Back", ghoulishVampireServantMain);
}

public function ghoulishVampireServantHenchmanOption():void
{
	menu();
	if (flags[kFLAGS.PLAYER_COMPANION_1] == "") {
		if (flags[kFLAGS.PLAYER_COMPANION_2] == ""+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+"" || flags[kFLAGS.PLAYER_COMPANION_3] == ""+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+"") addButtonDisabled(0, "Team (1)", "You already have "+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" accompany you.");
		else addButton(0, "Team (1)", ghoulishVampireServantHenchmanOption2, 1).hint("Ask "+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" to join you in adventures outside camp.");
	}
	else {
		if (flags[kFLAGS.PLAYER_COMPANION_1] == ""+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+"") addButton(5, "Team (1)", ghoulishVampireServantHenchmanOption2, 21).hint("Ask "+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" to stay in camp.");
		else addButtonDisabled(5, "Team (1)", "You already have other henchman accompany you as first party member. Ask him/her to stay at camp before you talk with "+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" about accompaning you as first party member.");
	}
	if (player.hasPerk(PerkLib.IntermediateLeadership)) {
		if (flags[kFLAGS.PLAYER_COMPANION_2] == "") {
			if (flags[kFLAGS.PLAYER_COMPANION_1] == ""+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+"" || flags[kFLAGS.PLAYER_COMPANION_3] == ""+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+"") addButtonDisabled(1, "Team (2)", "You already have "+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" accompany you.");
			else addButton(1, "Team (2)", ghoulishVampireServantHenchmanOption2, 2).hint("Ask "+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" to join you in adventures outside camp.");
		}
		else {
			if (flags[kFLAGS.PLAYER_COMPANION_2] == ""+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+"") addButton(6, "Team (2)", ghoulishVampireServantHenchmanOption2, 22).hint("Ask "+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" to stay in camp.");
			else addButtonDisabled(6, "Team (2)", "You already have other henchman accompany you as second party member. Ask him/her to stay at camp before you talk with "+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" about accompaning you as second party member.");
		}
	}
	else {
		addButtonDisabled(1, "Team (2)", "Req. Intermediate Leadership.");
		addButtonDisabled(6, "Team (2)", "Req. Intermediate Leadership.");
	}
	addButton(14, "Back", ghoulishVampireServantMain);
}
public function ghoulishVampireServantHenchmanOption2(slot:Number = 1):void
{
	clearOutput();
	if (slot < 21) {
		outputText("The ghoul gives a toothy smile as you order "+(ghoulGender()?"her":"him")+" to follow you around into battle.\n\n");
		outputText("\"<i>As my "+player.mf("master","mistress")+" wishes, it will be a pleasure.</i>\"\n\n");
		outputText(flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" is now following you around.\n\n");
		var strGhoulishVampireServant:Number = 100;
		var meleeAtkGhoulishVampireServant:Number = 50;
		strGhoulishVampireServant *= (1 + (0.2 * player.newGamePlusMod()));
		strGhoulishVampireServant = Math.round(strGhoulishVampireServant);
		meleeAtkGhoulishVampireServant += (1 + (int)(meleeAtkGhoulishVampireServant / 5)) * player.newGamePlusMod();
		player.createStatusEffect(StatusEffects.CombatFollowerGVampServ, strGhoulishVampireServant, meleeAtkGhoulishVampireServant, 0, 0);
		if (slot == 2) flags[kFLAGS.PLAYER_COMPANION_2] = ""+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+"";
		if (slot == 1) flags[kFLAGS.PLAYER_COMPANION_1] = ""+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+"";
	}
	else {
		outputText(flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" is no longer following you around.\n\n");
		player.removeStatusEffect(StatusEffects.CombatFollowerGVampServ);
		if (slot == 22) flags[kFLAGS.PLAYER_COMPANION_2] = "";
		if (slot == 21) flags[kFLAGS.PLAYER_COMPANION_1] = "";
	}
	doNext(ghoulishVampireServantMain);
	cheatTime(1/12);
}
/*
public function ghoulishVampireServantMain():void {
	outputText("\"<i></i>\"\n\n");
	outputText("\"<i></i>\"\n\n");
}

public function ghoulishVampireServantMain():void {
	outputText("\"<i></i>\"\n\n");
}*/

	}
}