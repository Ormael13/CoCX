/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Beach 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
    import classes.display.SpriteDb;

	public class DemonPackBeachScene extends BaseContent
	{
		
		public function DemonPackBeachScene() 
		{
		}

public function demonspackEncounter():void {
	spriteSelect(SpriteDb.s_oasis_demons);
	clearOutput();
	outputText("You wander in the beach for what seems like hours, sweating profusely in the sweltering heat. Eventually you come across a small bay surrounded by scrappy trees and shrubs. It would be foolish not to take this opportunity to rest for a moment and paddle your [legs] in the cooling water, so you settle into what little shade you can find for a quick break.\n\n");
	outputText("After a while sitting in the sparse shade provided by one of the bushes around the bay you see figures shimmering into view across the beach sands.  As you watch the figures they grow more defined and more numerous until finally a group of vaguely humanoid shapes emerges from the heat haze.  The closer these figures become the more detail they take on, and as they near the edge of your small bay you are able to make out most of their features.\n\n");
	outputText("The group is composed of roughly fifty tan skinned demons, mostly humanoid in shape with many and varied corruptions across the group. You see demonic high heels, twisting horns and swinging cocks of all shapes and sizes. There even seems to be a shark head in there somewhere. You also make out plenty of breasts ranging from tiny ones to a pair that require a second person to carry them, and with those breasts a wide range of pussies, dripping and dry, sometimes nestled below some form of demonic dick. The small group carry no weapons and what little clothing they wear is well shredded, except for one hefty male wearing a cloak of what appears to be snakeskin across his broad shoulders. You assume from his clothing and the size of his equipment that this male is the leader. He, along with the others, is in good spirits and they all look fairly non-threatening, although you've learned not to trust anything that looks non-threatening in this place. Especially if it can carry its cock over its shoulder.\n\n");
	outputText("The demons don't notice you until they are quite close, the glare of the surrounding sand making you very difficult to see in the shade of your scrappy bush. They ignore you, intent on the rest here, but you can't stay hidden forever. A small keen eyed demon eventually spots you and lets out a  cry of alarm, pointing you out to the others. More eyes than fifty heads should really possess are now pointed straight at you.\n\n<b>What do you do?</b>");
	menu();
	addButton(0, "Fight", chooseToFight);
	addButton(1, "Leave", beachRunAway);
}

private function chooseToFight():void{
	startCombat(new DemonPackBeach());
	spriteSelect(SpriteDb.s_oasis_demons);
	playerMenu();
}

private function beachRunAway():void {
	clearOutput();
	spriteSelect(SpriteDb.s_oasis_demons);
	//Run away successfully if fast enough.  160 speed = autosuccess.
	if(player.spe > 30 && player.spe/2 > rand(80)) {
		outputText("You bolt out from under your bush and scramble away over the sand. Before long the swishing sounds of pursuit fade away and looking back you see the few demons with the gusto to follow you tramping back to the bay.");
		doNext(camp.returnToCampUseOneHour);
	}
	else {
		outputText("You scramble away from the demons, but are too late. A swift demon with canine features tackles you to the ground.  Luckily he loses his grip as you tumble onto the sand and you slither free, stand up and wheel to face the host of leering demons which begin to advance with malicious intent.");
		startCombat(new DemonPackBeach());
		doNext(playerMenu);
	}
}
		
	}

}