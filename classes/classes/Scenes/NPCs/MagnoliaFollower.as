/**
 * ...
 * @author Ya Boi Guzma
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.display.SpriteDb;
	
	public class MagnoliaFollower extends NPCAwareContent
	{
		
		public function MagnoliaFollower() 
		{}

public function treeMenu():void {
	clearOutput();
	if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 0 && player.hasKeyItem("Mysterious Seed") >= 0) {
		outputText("You find a spacious place in camp before digging a big enough hole in the barren ground. You fish out the seed you bought from Giacomo then drop it in the hole, covering it with dirt. You fetch a bucket of water to give it a healthy drink. Now that it's planted, all there's left to do is wait and see what will sprout from the seed.");
		player.removeKeyItem("Mysterious Seed");
		flags[kFLAGS.CHRISTMAS_TREE_LEVEL] = 1;
		doNext(inventory.inventoryMenu);
	}
	else if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 2) {
		outputText("At the corner of camp where you planted a seed, sapling has grown. It has dozens of branches and bright green leaves.\n\n");
		menu();
		if (player.fatigue + 50 < player.maxFatigue()) addButton(1, "Water It", waterIt);
		if (player.HP > 150 && player.soulforce>= 50 && player.findPerk(PerkLib.SoulApprentice) >= 0) addButton(2, "Use SFIB", useSouforceInfusedBlood);
		addButton(14, "Back", inventory.inventoryMenu);
	}
	else if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 3) {
		outputText("At the corner of camp, the tree like sapling has grown bigger having grown more branches and leaves.\n\n");
		menu();
		if (player.fatigue + 50 < player.maxFatigue()) addButton(1, "Water It", waterIt);
		if (player.HP > 150 && player.soulforce>= 50 && player.findPerk(PerkLib.SoulApprentice) >= 0) addButton(2, "Use SFIB", useSouforceInfusedBlood);
		addButton(14, "Back", inventory.inventoryMenu);
	}
	else if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 4) {
		outputText("At the corner of camp, a small tree has grown. The bright green leaves gently sway with the blowing wind.\n\n");
		menu();
		if (player.fatigue + 50 < player.maxFatigue()) addButton(1, "Water It", waterIt);
		if (player.HP > 150 && player.soulforce>= 50 && player.findPerk(PerkLib.SoulApprentice) >= 0) addButton(2, "Use SFIB", useSouforceInfusedBlood);
		addButton(14, "Back", inventory.inventoryMenu);
	}
	else if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] >= 5 && flags[kFLAGS.CHRISTMAS_TREE_LEVEL] < 8) {
		if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 6 && player.hasKeyItem("Decorations") >= 0) {
			outputText("You bring the package of holiday decorations over to your newly grown tree. You feel it could be 'dressed' for the season too. You open the package then begin the long process of hanging ornaments on the branches and lining it with lights and garland.");
			if (camp.hasCompanions()) outputText(" Some of the camp residents come over to see what you're doing.");
			if (player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_BIMBO_STATE] < 3) outputText("\"<i>Oh? Are you decorating the tree? I would like to assist too if you don't mind.</i>\" Says Jojo.\n\n");
			if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) outputText("\"<i>[name] there's no way you're decorating that alone. Let me lend a hand.</i>\" Comments Amily.\n\n");
			if (flags[kFLAGS.ETNA_FOLLOWER] > 0 && !player.hasStatusEffect(StatusEffects.EtnaOff)) outputText("\"<i>Oooo, that looks like fun! Maybe I can fly up and decorate the harder to reach areas.</i>\" Etna suggests.\n\n");
			if (DivaScene.instance.isCompanion()) outputText("\"<i>Tis the season already? I suppose I could lend my services.</i>\" Diva speaks with overdramatic voice.\n\n");
			if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) outputText("\"<i>You're decorating the tree? Can I help too?</i>\" Asks Izma.\n\n");
			if (flags[kFLAGS.LUNA_FOLLOWER] >= 4 && !player.hasStatusEffect(StatusEffects.LunaOff)) outputText("\"<i>Oh, is it time to decorate the tree? I will gladly lend my hand if you need it "+player.mf("Master","Mistress")+".</i>\" Asks Luna.\n\n");
			if (emberScene.followerEmber()) outputText("\"<i>I still don't see the point in putting those on a tree…</i>\" Ember questions.\n\n");
			if (player.hasStatusEffect(StatusEffects.CampMarble) && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) outputText("\"<i>I can't remember the last time I did something like this. Let me help too!</i>\" Marble says.\n\n");
			if (arianScene.arianFollower()) outputText("\"<i>What's this [name]? You're putting ornaments on the tree?</i>\" Arian asks, puzzled.\n\n");
			if (followerKiha()) outputText("\"<i>Geez can you go any slower [name]? Bet I can get this done faster than you can blink!</i>\" Kiha boasts.\n\n");
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 5) outputText("\"<i>So this is what you've been up to. Well, I can't deny that this looks interesting. Let me help too.</i>\" Chi Chi offers.\n\n");
			if (flags[kFLAGS.SAMIRAH_FOLLOWER] > 9) outputText("\"<i>Oh? I've never since something like this before. Is it normal to put decorations on a tree like this?</i>\" Samirah asks while looking at the tree.\n\n");
			outputText("It takes a few hours but soon the tree is finally fully decorated from top to bottom. You step back, admiring your hard work. The now decorated tree somehow adds a little more color to camp, making it another fine addition. The way the ornaments and garland shimmer in the light really brings out the beauty and joy of the season.");
			player.removeKeyItem("Decorations");
			flags[kFLAGS.CHRISTMAS_TREE_LEVEL] = 7;
			doNext(camp.returnToCampUseFourHours);
		}
		else {
			outputText("At the corner of camp sits a rather large tree. It's leafy canopy sways with the wind and the thick trunk is covered in sturdy bark."+(flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 7 ? " The tree is covered in colorful ornaments and lights for the season.":"")+"\n\n");
			menu();
			addButton(14, "Back", inventory.inventoryMenu);
		}
	}
	else if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 8) {
		outputText("\n\n");
	}
}

public function plantGrowsToLevel2():void {
	clearOutput();
	flags[kFLAGS.CHRISTMAS_TREE_LEVEL] = 3;
	flags[kFLAGS.CHRISTMAS_TREE_GROWTH_COUNTER] = 0;
	outputText("The sound of creaking, snapping vines draws your attention to the corner of your camp, where the small plant had grown.  You rush in that direction without delay, wondering what the commotion is. The noises die down before you can round the last large stone in the intervening distance. You come around the obstruction at top speed, skidding to a stop at the view before you.\n\n");
	outputText("Where once there was a small, tree-like sapling, there is now a decent sized tree. The familiar leaves are still there now in even greater numbers. Your plant is growing surprisingly well. Perhaps all the attention you've been giving it is helping it grow stronger.");
	doNext(playerMenu);
}
public function plantGrowsToLevel3():void {
	clearOutput();
	flags[kFLAGS.CHRISTMAS_TREE_LEVEL] = 4;
	flags[kFLAGS.CHRISTMAS_TREE_GROWTH_COUNTER] = 0;
	outputText("Again, you hear odd noises coming from a corner of your camp, the corner where you let that shrubbery grow.  The gardening and using Soulforce infused blood probably only helped it to grow faster.  The distinct sound of wood bowing and creaking under new weight catches your ears, and well before you can get to the plant, you can see a leafy canopy stretching towards the sky. It's grown into a small tree, with bark, leaves, and everything!\n\n");
	outputText("It has rough, thick bark covering the truck. The leaves are a healthy vibrant green. You're utterly shocked by how well your plant has done so far. You can't help but feel proud of your hard work.");
	doNext(playerMenu);
}
public function plantGrowsToLevel4():void {
	clearOutput();
	flags[kFLAGS.CHRISTMAS_TREE_LEVEL] = 5;
	flags[kFLAGS.CHRISTMAS_TREE_GROWTH_COUNTER] = 0;
	outputText("Once more, you hear strange noises coming from the corner of camp where you left your quickly sprouting tree. Wondering if it grew again, you quickly make your way over to the scene. As you approach, you're left awestruck by just how quickly your plant grew. It is almost as tall as a house by this point. Trees back home would take decades to even reach such heights. The healthy lush, vibrant, green leaves gently sway with the breeze. The trunk is thick and covered in sturdy bark.\n\n");
	outputText("Warmth builds up in your chest as you gaze upon the tree. The plant somehow took root in such barren soil and grew into something magnificent. So quickly on top of that too.");
	if (camp.companionsCount() > 0) {
		outputText("The other camp residents come over to see what's going on as well, surprised to see the large tree in camp.\n\n");
		if (player.hasStatusEffect(StatusEffects.CampRathazul)) outputText("\"<i>Gods [name]... Did you do this? I'm surprised something can even grow here. Especially so fast and so large.</i>\"\n\n");
		outputText("You explain that the seed you bought grew into the tree before them. While you didn't expect it to grow at first, you still dedicated yourself to taking care of it and stuck to it. In a way, you're glad you did. The pat the trunk of the tree looking up at it with pride. Another wonderful addition to your camp anyone would appreciate.\n\n");
	}
	doNext(playerMenu);
}
private function waterIt():void {
	clearOutput();
	outputText("For a moment you think what to do with this ");
	if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 4) outputText("tree");
	else outputText("plant");
	outputText(". Maybe bring some water from near the stream to water it? Or is this realm causing them to not need it? After a moment of hesitation, you go to the stream looking for some way to bring water. A few runs later you finished watering it and feeling tired, spend some time resting.");
	fatigue(50);
	if(flags[kFLAGS.CHRISTMAS_TREE_GROWTH_COUNTER] < 1000) flags[kFLAGS.CHRISTMAS_TREE_GROWTH_COUNTER]++;
	doNext(camp.returnToCampUseOneHour);
}
private function useSouforceInfusedBlood():void {
	clearOutput();
	outputText("For a moment you think what to do with this ");
	if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 4) outputText("tree");
	else outputText("plant");
	outputText(". Bringing water is fine but it seems the plant is growing too slowly. What else could make it grow faster? While thinking you casually remember about something you started to develop: Soulforce. After visiting the river village you’ve seen that it can even enhance natural healing. So maybe if you could use it now it could provide better nourishment for this ");
	if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 4) outputText("tree");
	else outputText("plant");
	outputText(" than mere water. For a moment you ponder if it is actually a good idea to spray it with your own blood. Probably that it would also give it some of your Soulforce. Preparing mentally to do that as you focus on infusing a tiny bit of your soulforce into your blood, you cut your hand and drip a little bit of your blood at the ");
	if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 4) outputText("tree");
	else outputText("plant");
	outputText(". It seems to greedily absorb the liquid for a moment, turning slightly crimson in the place where blood made contact with it, while you go to patch your hand. Better hope the blood scent doesn’t attract something to the camp.");
	player.HP -= 150;
	player.soulforce -= 50;
	if(flags[kFLAGS.CHRISTMAS_TREE_GROWTH_COUNTER] < 1000) flags[kFLAGS.CHRISTMAS_TREE_GROWTH_COUNTER] += 4;
	doNext(camp.returnToCampUseOneHour);
}




	}
}