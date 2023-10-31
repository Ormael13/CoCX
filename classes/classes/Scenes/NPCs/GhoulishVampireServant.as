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

private function ghoulGender():Boolean {
	if (player.statusEffectv3(StatusEffects.Familiar) > 1) return false;
	else return true;//1 - female, 2 - herm, 3 - male
}

public function ghoulishVampireServantMain():void {
	clearOutput();
	outputText("You walk up to "+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" and address "+(ghoulGender()?"her":"him")+".\n\n");
	outputText("\"<i>Good "+(isNightTime?"evening":"day")+" "+player.mf("master","mistress")+" [name], is there anything you would have this lowly me do? I delight in servicing you "+player.mf("milord","milady")+".</i>\"\n\n");
	outputText("Your ghoulish servant currently has a handsome/gorgeous/pretty face with "+(ghoulGender()?"pouting lips":"square jawline")+". "+(ghoulGender()?"Her":"His")+(ghoulGender()?"":" cock is "+(player.statusEffectv3(StatusEffects.Familiar)>2?"15":"9")+" inch long and")+(player.statusEffectv3(StatusEffects.Familiar)==2?""+(ghoulGender()?"her":"his")+"":"")+(player.statusEffectv3(StatusEffects.Familiar)>2?"":" cunt")+" ");
	outputText("dripping eagerly in anticipation of the abuses you could subject "+(ghoulGender()?"her":"him")+" to. "+(ghoulGender()?"Her":"His")+" chest is "+(ghoulGender()?"E cup and very squeezable":""+(player.statusEffectv3(StatusEffects.Familiar)>2?"flat":"C cup")+"")+".");
	menu();
	//addButton(0, "Appearance", GaliaCampMainMenuSlaveAppearance);
	addButton(14, "Back", camp.campSlavesMenu);
}/*
public function aaa():void {
	outputText("\"<i></i>\"\n\n");
}
public function aaa():void {
	outputText("\"<i></i>\"\n\n");
}
public function aaa():void {
	outputText("\"<i></i>\"\n\n");
}
public function aaa():void {
	outputText("\"<i></i>\"\n\n");
}
public function aaa():void {
	outputText("\"<i></i>\"\n\n");
}
public function aaa():void {
	outputText("\"<i></i>\"\n\n");
}*/

	}
}