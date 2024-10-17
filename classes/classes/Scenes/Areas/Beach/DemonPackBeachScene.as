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
	outputText("You wander in the beach for what seems like hours, sweating profusely in the sweltering heat. Eventually, you come across a small bay surrounded by scrappy trees and shrubs. It would be foolish not to take this opportunity to rest for a moment and paddle your [legs] in the cooling water, so you settle into what little shade you can find for a quick break.\n\n");
	outputText("After a while, as you sit in the sparse shade of a bush near the bay, you notice figures shimmering into view across the beach sands.  As you watch, the figures grow more defined and numerous until, at last, a group of vaguely humanoid shapes emerges from the heat haze.  As the figures draw closer, their details become clearer, and you begin to make out most of their features as they approach the edge of your small bay.\n\n");
	outputText("The group consists of roughly fifty tan-skinned demons, mostly humanoid in shape but with a wide variety of corruptions. You spot demonic high heels, twisting horns, and swinging cocks of all shapes and sizes. There’s even a shark head somewhere in the crowd. You notice a variety of breasts, from small ones to a pair so large they require a second person to carry them. Beneath them, you see a wide range of pussies, some dripping and others dry, occasionally paired with demonic dicks. The small group carry no weapons, and what little clothing they wear is well shredded, except for one hefty male wearing a cloak of what appears to be snakeskin draped across his broad shoulders. Judging by his clothing and the size of his equipment, you assume this male is the leader. He and the others seem to be in good spirits and appear relatively non-threatening—though you've learned not to trust appearances in this place, especially when something can carry its cock over its shoulder.\n\n");
	outputText("The demons don’t notice you until they are quite close, the glare of the sand making you hard to spot in the shade of your scrappy bush. They ignore you at first, focused on resting, but you can't stay hidden forever. A keen-eyed demon eventually spots you and lets out a cry of alarm, pointing you out to the others. More eyes than fifty heads should have are now pointed straight at you.\n\n<b>What do you do?</b>");
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
		outputText("You bolt from under your bush and scramble across the sand. Before long, the sound of pursuit fades, and when you glance back, you see the few demons that followed you returning to the bay.");
		endEncounter();
	}
	else {
		outputText("You scramble away from the demons, but it's too late. A swift demon with canine features tackles you to the ground. Luckily, he loses his grip as you tumble onto the sand, and you manage to slip free, stand up, and face the host of leering demons advancing toward you with malicious intent.");
		startCombat(new DemonPackBeach());
		doNext(playerMenu);
	}
}
	
	}

}
