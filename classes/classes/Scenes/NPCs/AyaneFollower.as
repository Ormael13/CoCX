/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.*;
import classes.Items.Useable;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;
import classes.Scenes.API.MultiBuy;

//AYANE_FOLLOWER:int                               			    = 2401;
//AYANE_CHILDREN_MALES:int                                  	= 2402;
//AYANE_CHILDREN_FEMALES:int                                   	= 2403;
//AYANE_CHILDREN_HERMS:int                                   	= 2404;
//AYANE_PREGNANCY_TYPE:int                                   	= 2626;
//AYANE_INCUBATION:int                                   		= 2627;

public class AyaneFollower extends NPCAwareContent implements TimeAwareInterface
	{
		public var pregnancy:PregnancyStore;
		public function AyaneFollower()
		{
			pregnancy = new PregnancyStore(kFLAGS.AYANE_PREGNANCY_TYPE, kFLAGS.AYANE_INCUBATION, 0, 0);
			pregnancy.addPregnancyEventSet(PregnancyStore.PREGNANCY_PLAYER, 310, 270, 200, 180, 100, 75, 48, 15);
												//Event: 0 (= not pregnant),  1,   2,   3,   4,   5,  6,  7,  8 (< 15)
			EventParser.timeAwareClassAdd(this);
		}

public function ayaneChildren():int {
	return (flags[kFLAGS.AYANE_CHILDREN_MALES] + flags[kFLAGS.AYANE_CHILDREN_FEMALES] + flags[kFLAGS.AYANE_CHILDREN_HERMS]);
}


//Time for fox time awareness
public function timeChange():Boolean
{
	var needNext:Boolean = false;
	pregnancy.pregnancyAdvance();
	if (pregnancy.isPregnant){
		if (ayanePregUpdate()) needNext = true;
		if (pregnancy.incubation == 0) {
			ayaneGivesBirth();
			pregnancy.knockUpForce(); //should clear pregnancy
			needNext = true;
		}
	}
	return needNext;
}
public function timeChangeLarge():Boolean {
	return false;
}

public function ayaneCampMenu():void
{
	spriteSelect(SpriteDb.s_ayane);
	clearOutput();
	outputText("\"<i>Anything I can do for you " + player.mf("lord", "lady") + " [name]?</i>\"");
	menu();
	addButton(0, "Appearance", ayaneAppearance).hint("Examine Ayane detailed appearance.");
	addButton(1, "Talk", ayaneTalkMenu).hint("Ask Ayane about something.");
	addButton(2, "Shop", ayaneShop).hint("Check Ayane shop.");
	addButton(3, "Sex", ayaneSexMenu).hint("Have some sex with Ayane.");
	addButton(4, "Spar", sparAyane).hint("Go to the woods and fight her!");
	if (player.hasPerk(PerkLib.BasicLeadership)) addButton(5, "Team", ayaneHenchmanOption);
	else addButtonDisabled(5, "Team", "You need to have at least Basic Leadership to form a team.");
	if (player.statStore.hasBuff("Weakened") || player.statStore.hasBuff("Drained") || player.statStore.hasBuff("Damaged"))
		addButtonIfTrue(6, "Cure C.", ayaneCuringCurse, "Ayane is not yet ready to cure your curses again.",
			flags[kFLAGS.AYANE_CURE_COOLDOWN] <= 0, "Cure curse effects.");
	else addButtonDisabled(6, "Cure C.", "You don't have any curses to cure.");
	if (BelisaFollower.BelisaQuestOn && !BelisaFollower.BelisaQuestComp) addButton(13, "ToothacheQ", BelisaAyaneTalk);
	addButton(14, "Back", camp.campFollowers);
}

public function ayaneAppearance():void
{
	clearOutput();
	outputText("Ayane the kitsune is a priestess of Taoth. Her silken, white hair flows around her head in a formal haircut tied in the back by a hairpin depicting a fox tied to a red ribbon, giving her a mystical look. Her yellow fox eyes, while beautiful, sparkle with the playful glint of a practiced prankster. She has a playful face with tan skin and a look made to seduce. ");
	outputText("Her wise fox ears seem to listen to everything you say and move depending on her mood. As your attendant she rarely leaves your side, always taking care of you.\n\n");
	outputText("Her arms and legs are covered in a set of mystical tattoos running seamlessly all over her tan skin. Around her neck is tied a black and yellow ribbon collar with the holy symbol of the fox god Taoth engraved inside. She currently wears a formal, white, shrine maiden kimono, trimmed with purple flower design.\n\n");
	outputText("From her perfectly shaped ass flow no fewer than six silky fox tails, moving enticingly to taunt or tease.\n\n");
	outputText("She has a pair of well-shaped D cup breasts and nice hips that look great under her clothes.\n\n");
	outputText("Ayane's pussy, well hidden under her kimono, seems to be always ready for sex, although she is too well-mannered to ask for it openly.");
	menu();
	addButton(14, "Back", ayaneCampMenu);
}

public function ayaneTalkMenu():void
{
	clearOutput();
	outputText("Ayane calmly prepares some tea as you sit to talk with her.");
	outputText("\"<i>Is there something on your mind [name]?</i>\"");
	menu();
	addButton(0, "Priestess", ayaneTalkPriestess);
	addButton(1, "Taoth", ayaneTalkTaoth);
	addButton(2, "Prayer", ayaneTalkPrayer);
	addButton(14, "Back", ayaneCampMenu);
}

public function ayaneTalkPriestess():void
{
	clearOutput();
	outputText("You would like to discuss various things with Ayane; starting with her role as priestess.\n\n");
	outputText("\"<i>My role? Um... Well, while most kitsune are satisfied enjoying a simple life, caught between a good prank and good lovemaking, one needs to remember to thank the one who made us who and what we are. Taoth, like any god, has worshipers; and by studying The Trickster's pranks and dogma, one can attain some form of personal enlightenment. Life is a farce, in and of itself; a game to be played to the bitter end, best to take it with a smile rather than tears.</i>\"\n\n");
	doNext(ayaneTalkMenu);
	advanceMinutes(15);
}

public function ayaneTalkTaoth():void
{
	clearOutput();
	outputText("You observe that Taoth seems to like jokes and pranks. Is there any particular reason for that?\n\n");
	outputText("Ayane ponders the meaning of your question for a moment and then shrugs helplessly. \"<i>To question a god’s motivations is like asking why the water flows downward or why the sun and the moon trade places. Taoth has always been the trickster in the pantheon. Each god has a role and Taoth role seems to be one of chaotic influences to counterbalance the other deities overly serious demeanor. People need his laughter even more in these dark times when all hope fades.</i>\"\n\n");
	outputText("So in theory the reason he's the prankster of the pantheon is because everyone else is way too serious?\n\n");
	outputText("Ayane nods at this statement. \"<i>Deities could do with smiling more or with knowing how to have a good time. Taoth is here to remind them and us that order cannot exist without chaos, otherwise the world would be a bleak place indeed.</i>\"\n\n");
	doNext(ayaneTalkMenu);
	advanceMinutes(15);
}

public function ayaneTalkPrayer():void
{
	clearOutput();
	outputText("So... how does one offer prayer to the Trickster god? Is Taoth even listening to them?\n\n");
	outputText("\"<i>Some say Taoth is long gone, murdered by the demons. Others, pretend he's still out there, preparing yet another prank with which he will reveal to us all that this was just a huge joke from the beginning. Despite this uncertainty, offering prayers to him does still yield results. Although whether the fox god is dead or not, is a mystery, even for us. Perhaps this is only an echo of his presence or perhaps he is still out there laughing at us. ");
	outputText("Regardless, common offerings to Taoth involve gems, he just can’t have enough money.</i>\"\n\n");
	if (flags[kFLAGS.URTA_QUEST_STATUS] == 1) {
		outputText("You are pretty sure the Prankster Fox god is alive, heck you " + player.mf("fathered", "mothered") + " his rebirth. You tell of Urta's story and how Taoth used her as a vessel for his resurrection.\n\n");
		outputText("\"<i>You're kidding... where did he go?</i>\"\n\n");
		outputText("You have no idea, but you are quite sure he’s out there, preparing yet another huge prank for the demons.\n\n");
	}
	doNext(ayaneTalkMenu);
	advanceMinutes(15);
}

public function ayaneShop():void {
	var atCamp:Boolean = (flags[kFLAGS.AYANE_FOLLOWER] == 2);
	clearOutput();
	if (atCamp){
		outputText("You tell Ayane you could use some items from her shop, and she displays her inventory for you to browse.\n\n");
	}
	else{
		outputText("Ayane gives you a mischievous grin as you approach the shrine's shop stall.\n\n");
		outputText("\"<i>You want to buy some nice clothes and gear to look the part and do better tricks? Sure, I’ve got a few useful items I can spare, for you that is. What do you need?</i>\"");
	}
	menu();
	addButton(0, armors.WKIMONO.shortName, sellItem, armors.WKIMONO);
	addButton(1, armors.RKIMONO.shortName, sellItem, armors.RKIMONO);
	addButton(2, armors.BKIMONO.shortName, sellItem, armors.BKIMONO);
	addButton(3, armors.PKIMONO.shortName, sellItem, armors.PKIMONO);
	addButton(4, armors.BLKIMONO.shortName, sellItem, armors.BLKIMONO);
	addButton(5, armors.ARCBANG.shortName, sellItem, armors.ARCBANG);
	addButton(7, shields.SPI_FOC.shortName, sellItem, shields.SPI_FOC);
	addButton(8, headjewelries.FOXHAIR.shortName, sellItem, headjewelries.FOXHAIR);
	addButton(9, consumables.FOXJEWL.shortName, sellItem, consumables.FOXJEWL);
	addButton(10, consumables.AGILI_E.shortName, sellItem, consumables.AGILI_E, 15);
	addButton(11, consumables.SMART_T.shortName, sellItem, consumables.SMART_T);
	addButton(12, consumables.VIXEN_T.shortName, sellItem, consumables.VIXEN_T);
	addButton(13, consumables.INCOINS.shortName, sellItem, consumables.INCOINS);
	if(atCamp){
		addButton(14, "Back", ayaneCampMenu);
	}
	else{
		addButton(14, "Back", SceneLib.kitsuneScene.kitsuneShrine);
	}
}

private function sellItem(item:Useable,cost:int = -1,buy:Boolean=false):void{
	var priceRate:Number = 1;
	if (cost > 0) {
		priceRate = item.value / cost;
	}
	var priceToShow:int = (cost > 0)? cost: item.value;

	var descString:String;
	switch(item){
		case armors.WKIMONO:
		case armors.RKIMONO:
		case armors.BLKIMONO:
		case armors.BKIMONO:
		case armors.PKIMONO:
			descString = "\"<i>To look the part, you will have to dress the part. This magical clothing is made for a kitsune, and to be honest I think <b>" + priceToShow.toString() + " gems</b> is somewhat cheap for an enchanted garment like this.</i>\"";
			break;
		case armors.ARCBANG:
			descString = "\"<i>To look the part, you will have to dress the part. This is magical clothing made for a kitsune, and to be honest I think <b>" + priceToShow.toString() + " gems</b> gems is somewhat cheap for it.</i>\"";
			break;
		case shields.SPI_FOC:
			descString = "\"<i>This little icon is a very powerful spellcasting tool. It helps empower a kitsune’s magic. I don't get the use of shields; it’s so pointless. I can sell you one for <b>" + priceToShow.toString() + " gems</b>.</i>\"";
			break;
		case headjewelries.FOXHAIR:
			descString = "\"<i>This might appear to be just an accessory, but I personally blessed it in the name of Taoth. Should you wear it, this hairpin is likely to improve your ability to focus soul magic. This item wasn’t easy to make, which is why I can’t sell it to you for less than <b>" + priceToShow.toString() + " gems</b>.</i>\"";
			break;
		case consumables.FOXJEWL:
			descString = "\"<i>Don’t worry, these jewels are not actually that precious. One could say it’s concentrated kitsune energy crystallized into a gem. It’s not much, but it will help you grow your powers. I can sell you one for <b>" + priceToShow.toString() + " gems</b>.</i>\"";
			break;
		case consumables.AGILI_E:
			descString = "\"<i>This elixir helps increase your natural speed. While you may think casting magical pranks is enough, it would be wise to actually work on your agility for a fast trick or a swift escape.</i>\"";
			break;
		case consumables.SMART_T:
			descString = "\"<i>Kitsune's wits are their primary weapon. Since you weren't born one of us, you will need to learn true trickery. Drinking this tea can help you sharpen your dull human wits. I think <b>" + priceToShow.toString() + " gems</b> is not too steep a price for the gift of intelligence.</i>\"";
			break;
		case consumables.VIXEN_T:
			descString = "\"<i>Honing your tongue and sexual knowledge is a valiant goal as a kitsune. We kitsune are naturally born with a talent for sex and innuendo, but since you weren't born as one of us, you will need this tea to master it. I think <b>" + priceToShow.toString() + " gems</b> is a good deal to learn how to truly be lascivious.</i>\"";
			break;
		case consumables.INCOINS:
			descString = "\"<i>These incenses are quite special. They will grant you visions if only for a moment while meditating. This should help you find the wisdom and insight you need.</i>\"";
			break;
	}
	
	var onBuyStr:String = "\n\nAfter you give Ayane gems she hands over to you purchased item.\n\n";
	
	MultiBuy.confirmBuyMulti(ayaneShop, "Ayane", priceRate, item, descString, onBuyStr, false);

	/*cost = (cost > 0)? cost:item.value;
	if (buy){
		if (player.gems < cost){
			clearOutput();
			outputText("\n\nAyane shakes her head, indicating you need " + String(cost - player.gems) + " more gems to purchase this item.");
			doNext(ayaneShop);
		}
		else {
			outputText("\n\nAfter you give Ayane gems she hands over to you purchased item.\n\n");
			player.gems -= cost;
			inventory.takeItem(item, ayaneShop);
			statScreenRefresh();
		}
	}
	else{
		clearOutput();
		menu();
		switch(item){
			case armors.WKIMONO:
			case armors.RKIMONO:
			case armors.BLKIMONO:
			case armors.BKIMONO:
			case armors.PKIMONO:
				outputText("\"<i>To look the part, you will have to dress the part. This magical clothing is made for a kitsune, and to be honest I think <b>" + cost.toString() + " gems</b> is somewhat cheap for an enchanted garment like this.</i>\"");
				break;
			case armors.ARCBANG:
				outputText("\"<i>To look the part, you will have to dress the part. This is magical clothing made for a kitsune, and to be honest I think <b>" + cost.toString() + " gems</b> gems is somewhat cheap for it.</i>\"");
				break;
			case shields.SPI_FOC:
				outputText("\"<i>This little icon is a very powerful spellcasting tool. It helps empower a kitsune’s magic. I don't get the use of shields; it’s so pointless. I can sell you one for <b>" + cost.toString() + " gems</b>.</i>\"");
				break;
			case headjewelries.FOXHAIR:
				outputText("\"<i>This might appear to be just an accessory, but I personally blessed it in the name of Taoth. Should you wear it, this hairpin is likely to improve your ability to focus soul magic. This item wasn’t easy to make, which is why I can’t sell it to you for less than <b>" + cost.toString() + " gems</b>.</i>\"");
				break;
			case consumables.FOXJEWL:
				outputText("\"<i>Don’t worry, these jewels are not actually that precious. One could say it’s concentrated kitsune energy crystallized into a gem. It’s not much, but it will help you grow your powers. I can sell you one for <b>" + cost.toString() + " gems</b>.</i>\"");
				break;
			case consumables.AGILI_E:
				outputText("\"<i>This elixir helps increase your natural speed. While you may think casting magical pranks is enough, it would be wise to actually work on your agility for a fast trick or a swift escape.</i>\"");
				break;
			case consumables.SMART_T:
				outputText("\"<i>Kitsune's wits are their primary weapon. Since you weren't born one of us, you will need to learn true trickery. Drinking this tea can help you sharpen your dull human wits. I think <b>" + cost.toString() + " gems</b> is not too steep a price for the gift of intelligence.</i>\"");
				break;
			case consumables.VIXEN_T:
				outputText("\"<i>Honing your tongue and sexual knowledge is a valiant goal as a kitsune. We kitsune are naturally born with a talent for sex and innuendo, but since you weren't born as one of us, you will need this tea to master it. I think <b>" + cost.toString() + " gems</b> is a good deal to learn how to truly be lascivious.</i>\"");
				break;
			case consumables.INCOINS:
				outputText("\"<i>These incenses are quite special. They will grant you visions if only for a moment while meditating. This should help you find the wisdom and insight you need.</i>\"");
				break;
		}
		outputText("\n\nDo you buy "+ item.longName+"?");
		addButton(0, "Yes", sellItem, item, cost, true);
		addButton(1, "No", ayaneShop); 
	}*/
}

public function ayaneSexMenu():void
{
	clearOutput();
	outputText("Ayane's ears perk up as you mention your interest. She takes on a seductive pose, setting up the mood.\n\n");
	outputText("\"<i>Oh?! I’m always game, what do you have in mind?</i>\"\n\n");
	menu();
	addButton(0, "Worship", ayaneWorship);
	addButton(1, "Anal", ayaneAnal).disableIf(!player.hasCock(), "Req. a cock!");
	addButton(2, "Tribadism", ayaneTribadism).disableIf(!player.hasVagina(), "Req. a vagina!");
}

public function ayaneWorship():void
{
	spriteSelect(SpriteDb.s_ayane_nude);
	clearOutput();
	outputText("You tell Ayane you could use some relief. She quickly takes the hint, helping you to remove any clothes you might be wearing and kneeling down, her face level with your hips as she whispers holy prayers.\n\n");
	menu();/*
	if (player.hasCock() && player.hasVagina()) addButton(0, "Herm Worship", ayaneHermWorship);
	else addButtonDisabled(0, "Herm Worship", "You need a cock and a vagina for this");*/
	if (player.hasCock()) addButton(0, "Cock Worship", ayaneCockWorship);
	else addButtonDisabled(0, "Cock Worship", "You need a cock for this");
	if (player.hasVagina()) addButton(1, "Vaginal Worship", ayaneVaginalWorship);
	else addButtonDisabled(1, "Vaginal Worship", "You need a vagina for this");
	if (!player.hasCock() && !player.hasVagina()) {
		outputText("You tell Ayane you could use some relief. She quickly takes the hint, helping you to remove any clothes you might be wearing and kneeling down, her face level with your hips before her face contorts in confusion, finding nothing attached to your crotch.");
		outputText("*Record scratch*\n\n");
		outputText("\"<i>Wait a minute, is this some cruel joke?</i>\" She looks at you with a puzzled expression while your gaze is fixed down at her. \"<i>Why...Why don't you have anything down here?</i>\"\n\n");
		outputText("You can feel her rising disapointment in her voice as she begins to back off, you don't even need to say anything about your genderless nature as she gets up and looks over you in barely veiled disgust.");
		outputText("\"<i>Next time you want to play a cruel joke on somebody, at least don't pick me!</i>\" She turns around and runs off, leaving you alone.\n\n");
		endEncounter();
	}
}

public function ayaneCockWorship():void
{
	clearOutput();
	outputText("Ayane starts by cupping your balls with her hand, caressing them and applying her flames; causing them to slowly churn with cum and grow bigger as her magic increases your potency. She methodically moves her fingers up your length, tracing invisible designs along the flesh of your erect shaft. A pearl of precum appears on your tip which she proceeds to immediately lick, eliciting a pleasured moan from you. She methodically coats your shaft in a thick coat of her own saliva as she pulls it all in, her throat massaging your tip. ");
	outputText("You are slightly disappointed when she pulls back, your length popping out of her mouth, but that is short-lived as the horny priestess proceeds to shed her own clothes, hugs you, and inserts your shaft inside her warm waiting folds. Unable to hold yourself still anymore, you proceed to stir up her pussy relentlessly, making Ayane moan prayers to Taoth as she’s fucked. Her walls feel like they were made for your dick, and as you would expect of a kitsune pussy, they hungrily milk you for your semen.\n\n");
	outputText("When you finally feel your balls emptying as you paint her vaginal canal white with your holy cum, something which seems to drive the lewd priestess over the edge as well. You sigh, relieved of your load, your balls slowly returning to their normal size. When you break the embrace you can’t help be smile in amusement as she tries to hold your cum inside of her.\n\n");
	outputText("\"<i>Is " + player.mf("milord", "milady") + " satisfied?</i>\"\n\n");
	outputText("You reply that Ayane is doing a wonderful job and that you are indeed quite satisfied by her worship. A few minutes later both of you start redressing, ready to continue on your journey.");
	player.sexReward("vaginalFluids","Dick");
	player.sexReward("saliva","Dick");
	if (!pregnancy.isPregnant) {
		if (debug) outputText("\n\n<b>DEBUG: Ayane pregcheck.</b>");
		doNext(breedayaneweneedallthefoxes);
	}
	else if (pregnancy.isPregnant) {
		if (debug) outputText("\n\n<b>DEBUG: Ayane impregnation check skipped.</b>");
		endEncounter();
	}
}
private function breedayaneweneedallthefoxes():void
{
	if (debug) outputText("\n\n<b>DEBUG: Begining ayane pregcheck.</b>\n\n")

	if (player.inRut) {
		player.removeStatusEffect(StatusEffects.Rut);
		dynStats("sen", -2);
		outputText("\n\nYou have a feeling that your recent fun with Ayane has caused her to become pregnant. You wonder if she will be able to produce a litter soon.\n\n");
		outputText("\n\nEven though you are not sure how long it will be before you have a daughter, you are sure that you will have one soon.\n\n");
		pregnancy.knockUp(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_AYANE); //Will always impregnate unless contraceptives are in use
		if (debug) outputText("\n\n<b>DEBUG: Ayane pregcheck returned good.</b>");
		trace("Ayane got PREGNANT!");
		endEncounter();
	}
	else if (rand(100) < Math.sqrt(player.cumQ())) {
		trace("Ayane got random chance PREGNANT!");
		if (debug) outputText("\n\n<b>DEBUG: Ayane chance pregcheck returned good.</b>");
		pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_AYANE); //Will always impregnate unless contraceptives are in use
		if (flags[kFLAGS.SCENEHUNTER_PRINT_CHECKS]) outputText("\n<b>Ayane is pregnant!</b>");
		endEncounter();
	}
	else {
		if (debug) outputText("\n\n<b>DEBUG: Ayane pregcheck returned as skipped.</b>");
		trace("Ayane pregcheck failed (not in heat and bad cum volume)");
		endEncounter();
	}
}

public function ayaneVaginalWorship():void
{
	clearOutput();
	outputText("Ayane starts by slowly teasing your entrance. You shiver in appreciation as she plays her fingers across your " + vaginaDescript() + ", carefully using small blue flames every now and then to puff up your pussy properly. You caress her hair as she proceeds to lick your lips, dipping her tongue inside and curling her tongue over your clit. Gasping, you let your tails flow over her body, the feeling of her skin on your fur erotically charged and exquisite. Your tails trace her numerous tattoos, while hers do your own. The sensations dance through your mind, rippling through ");
	outputText("your body, driving you both mad with pleasure as she continues to lick your pussy. Your nipples stiffen in arousal and you start to massage your breasts, making use of your own foxfire in order to create the most pleasurable sensations that those mystical, licking flames can offer. Ayane keeps wildly licking your pussy and both of you eventually fall down to the ground locking into a full sixty-nine as you search for the priestess' honeypot. Ayane moans, appreciative of your attention and for a few minutes the two of you focus purely on licking each other’s slick cunts.\n\n");
	outputText("You finally orgasm, baptizing your lovely attendant as she drinks from your constantly gushing cunt, making sure not to waste a single drop. Ayane cums not so long after, flooding your face with her juices.\n\n");
	outputText("\"<i>Is " + player.mf("milord", "milady") + " satisfied?</i>\"\n\n");
	outputText("You reply that Ayane is doing a wonderful job and that you are indeed quite satisfied by her worship. A few minutes later both of you start redressing, ready to continue on your journey.");
	player.sexReward("saliva","Vaginal");
	endEncounter();
}

public function ayaneAnal():void
{
	spriteSelect(SpriteDb.s_ayane_nude);
	clearOutput();
	outputText("Ayane's well shaped ass draws your attention today; the way she swings her tails around it is such a tease. You resolve to teach her what happens when one flaunts such a sweet backside around, telling the foxy girl to bend over and give you a good look at her backside. Ayane smiles, undresses, and bends over, giving you a full display before obscuring it again with a tail. You yank the thing away and align yourself as you proceed to insert your [cock] through her inviting pucker.\n\n");
	outputText("Ayane moans as you proceed to explore the depths of her ass, her tails moving wildly behind her as you pump in and out of the lusty shrine priestess.\n\n");
	outputText("\"<i>Oooh! Good lord Taoth grant me the aaahn...</i>\"\n\n");
	outputText("She’s way beyond the ability to voice her prayer coherently as you keep plowing her ass thoroughly. You grab two of her tails, playing with the fur and using them as handles as you pull in and out. Ayane doesn’t seem to mind it, her tight pucker, against all logic, reacts more like a pussy than a traditional anus, trying to milk you more the rougher you are with her.\n\n");
	outputText("\"<i>Ahhhhn " + player.mf("milord", "milady") + " fuck me harder, faster, let me bask in the glory of your proud hard tool!\"</i>\"\n\n");
	outputText("You sure feel like obliging her, increasing the pace as Ayane wails in pleasure. Your cock suddenly throbs and explodes in her ass with a creamy deluge. You slowly remove your cock from the abused kitsune's ass, cum drooling slowly from her hole.\n\n");
	outputText("\"<i>Ahh... So wonderful... To be filled with your seed is a blessing...</i>\"\n\n");
	outputText("You clean your cock on one of her silky white tails, making her gasp, as both of you slowly proceed to redress.");
	player.sexReward("Default","Default",true,false);
	endEncounter();
}

public function ayaneTribadism():void {
	clearOutput();
	outputText("You gently push Ayane to the ground making your plans clear as you open her kimono" + player.clothedOrNaked(" and remove your equipment", "") + ". Making love as much as it is a trivial affair for kitsunes is something you would like to do right.\n"
		+ "\n"
		+ "She laughs awkwardly, smirking deviously as you lean in, her deep yellow eyes mere inches from your own. You press your lips to hers, running your hand through her hair and stroking the sensitive backs of her ears with your fingertips while undressing her with your free hand. A moan rumbles up through her chest and into your lips, her cheeks burning a deep, flustered red as she begins to lean back, submitting to your passions.\n"
		+ "\n"
		+ "The heat of her loins radiates up into yours, elevating your passion to new heights as you pin the kitsune’s shoulders to the ground, sliding your hips to and fro across her pubic mound. As you grind your pelvis back and forth across hers, your petite bitch-pleasure-buzzer occasionally slips down into the cleft of her pussy, flicking across her own engorged pleasure bud and sending a buzzing wave of pleasure up your spine.\n"
		+ "\n"
		+ "Each time your tiny button passes across hers, you shudder with pleasure, but you soon realize that the position you have taken is... lacking. You simply aren’t optimally angled for the sort of nerve-shattering pleasure that you seek - this must be remedied.\n"
		+ "\n"
		+ "You quickly flip yourself around, sliding your hands up her luscious thighs and taking hold of her calves. She yelps in startled bemusement as you flip her hindquarters upward, bending her back over herself so that she is folded double in a lewd contortion, her genitals dripping sweet nectar onto her face.\n"
		+ "\n"
		+ "“Oh lady [name], what is it you are planning?...” she says, giggling as you position yourself over her, settling your spacious rump down on her splayed thighs, your fuck-hole meshing seamlessly with hers. When your slow, measured grinding resumes, you moan with approval, finding this new position to be much more satisfying.\n"
		+ "\n"
		+ "Each time you rock your hips forward, her swollen clitoris glides up between your lady lips, and each time you drop down, it meets yours with a fantastic flick. Your hands travel down to her expansive hind end, sinking your fingers deep into the soft, pliable flesh and pulling her hips flush against yours. It jiggles and wobbles like gelatin, ripples flowing through it each time you thrust your hips forward, delightfully distorting the design inscribed upon it. Continuing the slow, methodical grinding of your groin against hers, you knead her large ass like a mound of soft dough, squeezing and groping it lustfully while moaning in approval.\n"
		+ "\n"
		+ "“Mmn, that’s just perfect, [name]” she coos, pushing her flexible frame upward with her legs stretching to the ground near her shoulders, arms spread out for support.\n"
		+ "\n"
		+ "She matches your grinding thrusts with her own, her sextet of tails curving toward your body" + (player.isRace(Races.KITSUNE, 1, false) ? " and coiling together with your tails" : "") + " like a group of furred serpents. You both coil your tails to tease the other, tickling across your partner's body in slow and sensual curls, and then begin to drift southward, slithering your way around to your partner rear. The silky fur bristles along your bottom as her tails constrict around yours, and one of the bushy coils works its way down to your nethers, teasing the edges of your labia. The tip of her tail gently flicks across the upper surface of your demanding pleasure-buzzer, sending a shock of pleasure through you, but it doesn’t stop there - with the sound of a flint striking against steel, she conjures a blue flame at the end of her tail, and before you can protest, presses it firmly against the base of your womanhood.\n"
		+ "\n"
		+ "Dazzling tongues of mystical azure lick at your button, intensifying every sensation and magnifying your pleasure tenfold as a cool tingling begins to creep through your nerves. Well then, two can play at this game and you attack her clit with your own flames igniting her desire further. The two of you are beyond ready now.\n"
		+ "\n"
		+ "She joins you in a lewd chorus, thrusting herself up against you and grasping her own breasts excitedly, flicking her turgid nipples with her fingertips. You buck your hips back and forth strongly, gradually building momentum in pursuit of your ever-nearing climax. The steady 'schlick-schlick-schlick' sounds of lustful tribadism fill the forest, threads and beads of feminine juices connecting your fuck-hole to hers and smearing across each other’s groins messily.\n"
		+ "\n"
		+ "Like a coiling spring, a tension slowly culminates in your intermeshed netherparts, climbing steadily as a path of heat radiates through your womb. You lurch forward, a moan catching sideways in your throat as you feel a slender finger sliding up against your tight asshole, gently wriggling its way inside. The addition of this intruder has you near the limits of your endurance, trembling with restraint and digging your fingers deeper into the soft, voluptuous doughiness that is her breathtaking backside. Deciding to return her kindness, you circle her tensed pucker with a fingertip, plunging it in up to the knuckle. Her anal ring spreads around your finger without quarrel, the warmth of her rectum drawing the invasive digit inside invitingly. Ayane seems to enjoy this attention.\n"
		+ "\n"
		+ "“Ahhn...! Milady [name], please do not stop!!!!”\n"
		+ "\n"
		+ "Every muscle in your body resonates with passion as you lower your weight against her upthrust pelvis, running your hands down her rump to the small of her back. You instinctively grasp the base of her tails for support, struggling to maintain your balance as your pussy begins to convulse, a dribbling waterfall of feminine lubricant spilling from your loins and into hers. The entire salacious river flows down her front, soaking her through and through with a glistening patina, while her tails thrash wildly in your grip, the kitsune’s orgasm close at hand.\n"
		+ "\n"
		+ "The coiling spring snaps, your back arching reflexively as your orgasm proper begins to tear through you. The kitsune reaches her peak at the same time, her contorted body flexing awkwardly beneath you as she struggles to maintain balance in her twisted pose, fighting through the throes of pleasure. You hold onto her tightly, thrusting your hips forward as a slick jet of femcum sprays from your snatch, the musky feminine juices sliding down the curves of her backside.\n"
		+ "\n"
		+ "As your climax begins to ebb, you slump downward, sliding off of her in satisfaction and panting on the grass. You lie head to toe with her, legs spread apart, breathing in deeply in an attempt to catch your breath. Your eyes close, a contented sigh issuing from your lips as Ayane move to rest on your chest. The both of you wake up later and redress ready for adventuring.");
	player.sexReward("vaginalFluids", "Vaginal");
	endEncounter();
}

public function ayaneHenchmanOption():void
{
	menu();
	if (flags[kFLAGS.PLAYER_COMPANION_1] == "") {
		if (flags[kFLAGS.PLAYER_COMPANION_2] == "Ayane" || flags[kFLAGS.PLAYER_COMPANION_3] == "Ayane") addButtonDisabled(0, "Team (1)", "You already have Ayane accompany you.");
		else addButton(0, "Team (1)", ayaneHenchmanOption2, 1).hint("Ask Ayane to join you in adventures outside camp.");
	}
	else {
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "Ayane") addButton(5, "Team (1)", ayaneHenchmanOption2, 21).hint("Ask Ayane to stay in camp.");
		else addButtonDisabled(5, "Team (1)", "You already have other henchman accompany you as first party member. Ask him/her to stay at camp before you talk with Ayane about accompaning you as first party member.");
	}
	if (player.hasPerk(PerkLib.IntermediateLeadership)) {
		if (flags[kFLAGS.PLAYER_COMPANION_2] == "") {
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Ayane" || flags[kFLAGS.PLAYER_COMPANION_3] == "Ayane") addButtonDisabled(1, "Team (2)", "You already have Ayane accompany you.");
			else addButton(1, "Team (2)", ayaneHenchmanOption2, 2).hint("Ask Ayane to join you in adventures outside camp.");
		}
		else {
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Ayane") addButton(6, "Team (2)", ayaneHenchmanOption2, 22).hint("Ask Ayane to stay in camp.");
			else addButtonDisabled(6, "Team (2)", "You already have other henchman accompany you as second party member. Ask him/her to stay at camp before you talk with Ayane about accompaning you as second party member.");
		}
	}
	else {
		addButtonDisabled(1, "Team (2)", "Req. Intermediate Leadership.");
		addButtonDisabled(6, "Team (2)", "Req. Intermediate Leadership.");
	}
	addButton(14, "Back", ayaneCampMenu);
}
public function ayaneHenchmanOption2(slot:Number = 1):void
{
	clearOutput();
	if (slot < 21) {
		outputText("\"<i>On your call divine one.</i>\"\n\n");
		outputText("Ayane is now following you around.\n\n");
		var intAyane:Number = 220;
		var wisAyane:Number = 110;
		var spellsoulskillpowerAyane:Number = 1.5;/*
		if (flags[kFLAGS.AURORA_LVL] >= 1) {
			if (flags[kFLAGS.AURORA_LVL] == 2) {
				intAyane += 22;
				wisAyane += 11;
				spellsoulskillpowerAyane += 0.1;
			}
			if (flags[kFLAGS.AURORA_LVL] == 3) {
				intAyane += 22;
				wisAyane += 11;
				spellsoulskillpowerAyane += 0.1;
			}
			if (flags[kFLAGS.AURORA_LVL] >= 4) {
				intAyane += 66 + (22 * (5 - flags[kFLAGS.AURORA_LVL]));
				wisAyane += 33 + (11 * (5 - flags[kFLAGS.AURORA_LVL]));
				spellsoulskillpowerAyane += 0.3 + (0.1 * (5 - flags[kFLAGS.AURORA_LVL]));
			}
		}*/
		intAyane *= (1 + (0.2 * player.newGamePlusMod()));
		intAyane = Math.round(intAyane);
		wisAyane *= (1 + (0.2 * player.newGamePlusMod()));
		wisAyane = Math.round(wisAyane);
		spellsoulskillpowerAyane += (0.5 * player.newGamePlusMod());
		player.createStatusEffect(StatusEffects.CombatFollowerAyane, intAyane, wisAyane, spellsoulskillpowerAyane, 0);
		if (slot == 2) flags[kFLAGS.PLAYER_COMPANION_2] = "Ayane";
		if (slot == 1) flags[kFLAGS.PLAYER_COMPANION_1] = "Ayane";
	}
	else {
		outputText("Ayane is no longer following you around.\n\n");
		player.removeStatusEffect(StatusEffects.CombatFollowerAyane);
		if (slot == 22) flags[kFLAGS.PLAYER_COMPANION_2] = "";
		if (slot == 21) flags[kFLAGS.PLAYER_COMPANION_1] = "";
	}
	doNext(ayaneCampMenu);
	cheatTime(1/12);
}

public function ayaneCuringCurse():void {
	clearOutput();
	flags[kFLAGS.AYANE_CURE_COOLDOWN] = 24;
	outputText("You tell Ayane that you are in dire need of healing to lift the power of a curse and request that she use her magic on you at once.\n\n");
	outputText("\"<i>With due haste my " + player.mf("lord", "lady") + " I will alleviate your wounds and break some of the curses afflicting you.</i>\"\n\n");
	outputText("On this she lifts her staff and begins a ritual. A few seconds later you feel infinitely better as the kitsune shrine maiden curative magic does its work alleviating your wounds both physical and spiritual.\n\n");
	for each (var stat:String in ["str","spe","tou","int","wis","lib","sens"]) {
		player.removeCurse(stat, 15,1);
		player.removeCurse(stat, 10,2);
		player.removeCurse(stat, 5,3);
		if (stat != "sens") {
			player.removeCurse(stat+".mult", 0.15,1);
			player.removeCurse(stat+".mult", 0.10,2);
			player.removeCurse(stat+".mult", 0.05,3);
		}
	}
	endEncounter();
}

public function ayaneGivesBirth():void {
	var roll:int = rand(100); //Rolls for random child gender
	outputText("Ayane is waiting for you, sipping from a flask of water, her hugely rounded orb of a belly exposed to you, as if showing it off.  She winces and rubs her belly with a grimace as you approach, which prompts you to ask if she's been feeling all right.");
	outputText("\n\n\"<i>Just a little stomach pain,</i>\" she states, \"<i>I probably just pulled something.  This little one has been murder on my muscles.  I'll be fine, but can you get me more water?</i>\"  You nod, not entirely convinced, but you take her empty flask and go to fill it.");
	outputText("\n\nYou're only just returning with the flask when, with a sudden cry of pain from the kitsune, a gush of water spills forth from between Ayane's legs.  She looks down in a panic, nearly doubling over with her arms wrapped around her belly.  \"<i>Oh my god, the baby's coming!</i>\" she cries out, panic tinging her voice.");
	outputText("\n\nYou quickly move to support her, asking what you can do to help.");
	outputText("\n\n\"We need someplace quiet and private.  There's no time to go to the doctor's...</i>\"  Her breath is heavy now, but with measured gasps.");
	outputText("\n\nMind racing, you ask if she can make it to the stream.  You think you remember hearing something about it being easier to give birth in water or something.");
	outputText("\n\n\"<i>That's fine,</i>\" she responds quickly.  \"<i>I'll be fine, but I'll need to get there first.</i>\"");
	//(Depending on PC height:
	if(player.tallness < 60) outputText("She wraps an arm around your neck");
	else if(player.tallness < 70) outputText("She places a hand on your shoulder");
	else if(player.tallness < 86) outputText("She wraps an arm around your midsection");
	else outputText("She wraps an arm around your waist");
	outputText(" for stability as she waddles off in the direction of the stream.  You hasten along as quickly as you dare, doing your best to support your laboring lover.  The stream comes into sight with welcome quickness, and you gently help her into the water before pulling off her pants and tossing them onto the dirty shore with a wet <i>shlop</i>.  Positioning yourself behind her, where her huge belly won't obstruct you, you tell Ayane to get ready to push...");
	outputText("\n\nLong minutes pass; though Ayane is clearly in pain, you can't help but note that this birth is honestly progressing much faster and smoother than it would for a normal human, and try to bolster Ayane's spirits by telling her this.");
	outputText("\n\n\"<i>Hah~ This is,</i>\" she strains for a moment, \"<i>nothing.</i>\"  She looks up at you, clearly trying to gauge your reaction, and you can't help but notice that her expression has changed.  \"<i>I'm... I'm fine,</i>\" she says, \"<i>I'm just a little bit tired.  I'm going to be fine.</i>\"");
	outputText("\n\nAssuring her that she's doing fine, you take a breath and duck back down under the water to closely examine her.  Your eyes and fingers quickly confirm the speed of her progress, and you excitedly surface to tell her that you can see the head and ears; one or two more good pushes, and the baby will be out.  Seemingly strengthened by this, she nods, takes a few quick breaths and pushes as hard as she can.  The strain shows on her face, with her normal tan skin darkening momentarily.");
	outputText("\n\nYou plunge your hands into the water as Ayane lets out a strangled scream, muscles unclenching in the wake of her final push.  As you do so, you find Ayane's baby thrust fully from its former home in the kitsune's belly into your hands, and you hasten to pull it to the surface.  With a great splash, you bring the baby out of the water, which causes it to suck in its first breath and make its first cry.  You just stand there in the water, smiling stupidly at your newborn, holding it close to you.");
	outputText("\n\nAyane tries to peer backwards.  \"<i>Is everything all right? Is it OK?</i>\" she asks, concern in her voice.");
	outputText("\n\nEverything is just fine, you tell her, unable to look up.  The two of you are the parents of a new, healthy ");
	if (roll < 10) outputText("boy.");
	else if (roll < 70) outputText("girl.");
	else outputText("herm.");
	if (roll < 10) flags[kFLAGS.AYANE_CHILDREN_MALES]++;
	else if (roll < 70) flags[kFLAGS.AYANE_CHILDREN_FEMALES]++;
	else flags[kFLAGS.AYANE_CHILDREN_HERMS]++;
}
public function ayanePregUpdate():Boolean
{
	switch (pregnancy.eventTriggered()) {
		case 1: //
				outputText("\nAyane's belly seems to be swelling; it looks like your seed took after all.  The kitsune makes no obvious sign that she's noticed the weight she's putting on, and you don't think it would be wise to draw attention to it, even if it is \"<i>only</i>\" a pregnancy bulge.\n");
				return true;
		case 2: outputText("\nAyane's belly grows ever bigger, making her pregnancy noticeable.  Her swollen midriff suits her well; to be honest she looks pretty sexy like that.\n");
				dynStats("lus", (5 + player.lib / 20), "scale", false);
				return true;
		case 4: outputText("\nAyane's belly has grown quite a bit.  Anyone can tell she's pregnant with a single glance.  ");
				outputText("Ayane catches you looking and blushes <i>W-what is it?</i> You reply merely that she carries a baby bump very well; she looks good pregnant. \n<i>Oh, uh...  Thanks I guess?</i> she replies, looking away nervously.\n");
				return true;
		case 5:
				outputText("\nAyane is sitting down with a smile, rubbing her belly; you approach and ask if she's feeling well.\n\n\"<i>Yes, both of us are.  I can already feel our baby starting to move.  Do you want to feel it too?</i>\"  You respond that you do, and gently approach her, reaching out to stroke her gravid stomach, feeling the skin already stretched taut over her burgeoning womb.\n\nYou feel what seems to be a small kick under your hand.  A faint hint of paternal pride fills you, and you can't resist rubbing the spot where the baby kicked.  Ayane sighs and lets you rub her belly to your heart's content.  Unfortunately duty calls, so you bid Ayane farewell and return to your duties.\n");
				return true;
		case 6:
				outputText("\nAyane's been getting as moody as her belly is big lately.  She constantly grumbles at anyone and anything that may approach her, even harmless bugs.  You decide to watch your step around her - pregnant women were scary enough back in Ingnam,.\n\n\"<i>Something wrong!?</i>\" Ayane questions you, glaring at you.  Your point proven, you tell her it's nothing, you were merely thinking of your former home.\n\n\"<i>Well if you have enough time to be reminiscing your past, how about you get over here and give me a hand instead!?  You're responsible for this, after all.</i>\"\n\nYou hasten to help her with whatever minor tasks she thinks she needs you for, until she promptly dismisses you.\n");
				return true;
		case 7:
				outputText("\nAyane's been much less active nowadays, and a single look at her heavily pregnant belly lets you know why.  She is huge!  You're surprised she can even move about with a belly as big as that.  Upon closer inspection you're pretty sure you can see it squirm as the little fox rolls itself over inside her.\n\n\"<i>Hey, [name]. Fetch me some water will you?</i>\"\n\nYou decide to be generous and fetch it for her - you wouldn't be surprised if she's too heavy to get to the stream by herself.  You promptly return with a full skin and present it to her so that she can slake her thirst.\n\nAyane takes the skin off your hands and chugs it down unceremoniously, sighing in relief once she's done.  \"<i>Ahhh, that hit the spot, thanks.</i>\"  You check to see if there's anything else she needs, but when she confirms she's fine, you nod your head, sneak a quick caress of her swollen stomach, then leave her alone.\n");
				return true;
		case 8:
				outputText("You can see now just how much Ayane's belly has been stretched out by the baby in her womb. You have no doubt that she is due soon, taking in the sights of the heavily pregnant fox, her breasts having swelled recently with milk.\n\n\"<i>I'm gonna have to go get some rest, [name].\</i>\" she says, looking away from you.  You nod your head and leave her to her own devices.\n");
				return true;
	}
	return false; //If there's no update then return false so needNext is not set to true
}
private function BelisaAyaneTalk():void {
	clearOutput();
	outputText("You ask your resident priestess about curing cursed injuries. Immediately, Ayane springs up, eyes wide as she looks you up and down. \"<i>My " + player.mf("lord", "lady") + ", are you hurt?!</i>\" You hastily explain that it’s not for you, but rather, for a friend. Ayane listens as you describe Belisa’s predicament, and she shakes her head sadly. ");
	outputText("\"<i>I’m afraid I cannot help you. Curses tied to specific injuries are rather difficult to remove, and I sadly don’t have the ability to cure such maladies yet.</i>\" You thank Ayane for her assistance, and she shakes her head sadly. \"<i>I did nothing, [name].</i>\"\n\n");
	doNext(ayaneCampMenu);
	advanceMinutes(5);
}

//======================================================================================================
//Forest Kitsunes part 2
//======================================================================================================

public static function ayaName(known:String, unknown:String):String {
	return flags[kFLAGS.KITSUNE_SHRINE_UNLOCKED] ? known : unknown;
}

//Called from the deepwoods, player > 20 lvl, non-kitsune
//Called even after the initial meeting!
public function randomEncounter():void {
	clearOutput();
	outputText("As you explore deeper into the dense wood, you are abruptly aware that your surroundings have grown darker without warning. The back of your neck tingles lightly with a sense of foreboding, and you instinctively ready your [weapon], feeling uneasy. Wracked with paranoia, you find yourself swiveling to face every random noise, and you could swear you just heard a voice through the trees. There it was again! As the ghostly, feminine laughter fills your ears, you are positive that it can’t just be your imagination. You turn left, then right, trying to pinpoint its source, but it truly sounds as though it is all around you now.\n"
		+ "\n"
		+ "Catching a glimpse of motion out of the corner of your eye, you whip around to face it, but are surprised to see that the only thing there is a small, pale blue flame, flitting about idly. It dances around hypnotically, and as you stare into its ghostly light, you find your conscious mind growing hazy. Your concerns suddenly seem trivial, and you find yourself relaxing gradually as the ethereal wisp glides along your arms, leaving behind a cool tingle where it touches you.\n"
		+ "\n"
		+ "It seems to be beckoning you to follow it.");
	if (flags[kFLAGS.AYANE_FOUGHT]) {
		outputText("\n\nSeems like " + ayaName("Ayane", "the kitsune") + " is messing with you again. Will you follow the flame?");
		doYesNo(followFlame, explorer.done);
	} else doNext(followFlame);
}

public function followFlame():void {
	++flags[kFLAGS.AYANE_FOUGHT];
	spriteSelect(SpriteDb.s_ayane);
	clearOutput();
	outputText("You fellow it into complete darkness and eventually run into a wide area. This is getting creepier by the second. Just as you are about to run, fire lit everywhere around you into the form of pale ghostly flames, a mocking woman's voice commenting.\n"
		+ "\n"
		+ "“<i>You look supremely delicious, I guess I will help myself to a meal, it has been a while and my duty doesn't give me leeway to hunt all that often let alone far from my ward.</i>”\n"
		+ "\n"
		+ "You turn over to face " + ayaName("Ayane, turns out she’s away from the shrine today and was looking for someone to feed from, guess that is you", "a tan skinned woman in a white kimono which could almost pass for human if not for her fox-like pupils, animal ears and 7 swishing fox tails") + ". She’s pointing an exotic staff at you smirking mischievously before fading in the ambient darkness." + ayaName("\n\n“<i>Don’t take it personally outside, I’m just hungry and really need the meal. It would be best for you to simply lay down and let me feed.</i>”", ""));
	startCombat(new Ayane());
}

public function fightWin():void {
	clearOutput();
	outputText("You smirk in satisfaction as you finally hit [themonster] hard enough to force her to the ground. You grab her by the tail and force her to look at you. You’re going to do terrible things to her.\n"
		+ "\n"
		+ "“<i>Hey by the way why are you holding that so hard?</i>”\n"
		+ "\n"
		+ "You look behind you and notice the kitsune sitting on a nearby rock giving you a quizzical look. When you look back to what you catched you realise you’re only holding a wooden twig. Was she just playing with you this whole time?\n"
		+ "\n"
		+ "“<i>Hey, don’t hold it against me, but I have places to be, so see you later. " + ayaName("Ayane", "By the way, my name is Ayane and if you're ever interested I hold a shop at the kitsune shrine. Do pay me a visit, I could always trade you some services and wares. ") + "This said, you seriously should just let me win next time, it will be way more pleasant.</i>” \n"
		+ "\n"
		+ "She leaps back into the shadow with a final teasing laughter disappearing for now. On the ground you notice she left a beautiful jewel.\n");
	flags[kFLAGS.KITSUNE_SHRINE_UNLOCKED] = 1;
	cleanupAfterCombat();
}

public function fightLose():void {
	clearOutput();
	if (player.isGenderless()) {
		outputText("Bruh.");
		cleanupAfterCombat();
	} else sceneHunter.selectLossMenu([
			[0, "Dick", loseMale, "Req. a cock", player.hasCock()],
			[1, "Vagina", loseFemale, "Req. a vagina", player.hasVagina()],
		],
		"[Themonster] probably wouldn't mind letting you pick you how exactly to feed her... right?\n\n"
	);
}

public function loseMale():void {
	spriteSelect(SpriteDb.s_ayane_nude);
	clearOutput();
	outputText("“<i>Ah finally giving up?</i>” the kitsune says as she leans over your slumped form, grinning coyly. “<i>If you were going to give up so easily, you could have said so in the beginning and saved yourself the trouble! I was worried someone else would get to you first but it looks like I have you all to myself for a while.</i>” \n"
		+ "\n"
		+ "Before you can issue a protest she lifts you and rolls on your back.\n"
		+ "\n"
		+ "\"<i>Fighting for so long must've been making all that delicious soul force of yours slosh about." + (player.hasBalls() ? " I can practically hear the bubbling sound of the energy in churning your balls." : "") + " Don't worry I'm going to relieve you of most of it.</i>\" She licks her lips hungrily before unravelling her kimono as four of her tails wraps around your arms and limb to hold you in place. \n"
		+ "\n"
		+ "You try to break out of the kitsune embrace but she proves to be deceptively stronger than she looks or perhaps it's you that has become weaker. Just as you think you are finaly about to untie yourself her hands leaves a trail of blue flame of foxfire across your chest leaving you weak and gasping from the surprisingly pleasurable caress.\n"
		+ "\n"
		+ "Mocking your helplessness the vixen adds \"<i>Don't you worry, I am not leaving until I've had my fill. Just let me work my magic, it'll be fun for you and me.</i>\" before slowly mounting you're now erect [cock], already aroused by the abusive caresses. Her movement starts slow and methodical as her pussy wraps your member like a glove slowly edging you on with no chance for you to stop it. Mid-sex though the kitsune makes a devlish grin, she clearly has an idea and you're about to find out what it is.\n"
		+ "\n"
		+ "She begins rubbing both of her palm together forming what appears to be a passive amount of fire between them. Seeing this coming you struggle vainly as she brings them both right beneath your [cock]!\n"
		+ "\n");
	if (player.hasBalls()) outputText("The reaction is as extreme as it is pleasurable as the flames directly lick at your balls causing them to suddenly inflate like giant balloons, your eyes going white as you spontaneously cum enough shpongle to bathe both you and her in semen! You shoot jet after jet directly in the vixen pussy yet she never seems to inflate! Just where is all of your cum going. Just as your balls finally shrinks back to their normal size you mercifully begin to pass out from exhaustion.");
	else outputText("As if by magic the foxfire sends you directly to the next stage and you begin to spontaneously unload enough shpongle to bathe both you and her in semen! You shoot jet after jet directly in the vixen pussy yet she never seems to inflate! Just where is all of your cum going. Just as your cock finally calms down you mercifully begin to pass out from exhaustion.");
	outputText("\n\nThe last thing you see before blacking out is a pair of delightfully plump, round cheeks jiggling happily as the kitsune gathers her robes.")
	player.sexReward("no", "Dick");
	cleanupAfterCombat();
}

public function loseFemale():void {
	spriteSelect(SpriteDb.s_ayane_nude);
	clearOutput();
	outputText("“<i>Finished already?</i>” the kitsune says as she leans over your slumped form, grinning coyly. “<i>If you were going to give up so easily, you could have said so in the beginning and saved yourself the trouble!</i>”\n"
		+ "\n"
		+ "Her tittering laughter rings in your ears, broken momentarily as she grunts with the effort of rolling you onto your back.\n"
		+ "\n"
		+ "“<i>Hehe, time to claim my prize...</i>”\n"
		+ "\n"
		+ "Humming quietly, she carefully removes any equipment you may have, neatly arranging it into a pile and shoving it off to the side. Eying your nude form hungrily, she begins to slowly trail her hands down your [breasts], letting her fingertips cascade over every ridge and curve of your body while painting streaks of blue fire across your flesh. Her touch sends tingles up and down your spine, making you shiver and moan involuntarily. Slowly but surely her hands work their way down toward your loins, teasing around your ample thighs very gently, tickling the insides of your thighs before trailing up to your rapidly moistening cleft. Her fingers dance along the inside of your labia, circling the entrance and nearly - but never quite - pushing a fingertip inside, snickering in satisfaction as you release a small rush of fluids into her palm. She glides the tip of one of her tails across your throbbing button delicately, like a feather, flicking it up and down.\n"
		+ "\n"
		+ "The tip of her index finger presses into the end of your clitoris, leaving behind a tiny bead of fire that tingles incredibly as the azure tongues lick at your nethers. It doesn’t take but a few moments of this treatment before you are teetering on the edge, but the skillful seductress has other plans for you, and dials back the pleasure mere moments before your release.\n"
		+ "\n"
		+ "“<i>Oh no girl, the fun’s only just begun,</i>” she says with a mock chastising tone, smirking mischievously.\n"
		+ "\n"
		+ "She slides forward, daintily settling down on your hips and pinning you under the weight of her expansive behind. A pair of fluffy tails slides in between your legs, curling around them and spreading them up and apart, the remaining tails taking advantage of your helpless state and beginning to brush up and down the insides of your thighs, one tip sliding up and down the sensitive cleft of your vagina. Sliding her hands down her shoulders and over the jiggling mounds of her breasts, she hooks her fingers into her robes and drags them down so that her perky nipples are just barely contained. With an agonizing slowness, she strips out of her robes, watching you the entire time and laughing seductively at your reactions to her teasing display. With her clothes tossed aside and out of the way, you have a full view of her young, lithe body, flowing white locks cascading over her toned, voluptuous hourglass shape. Grinning coyly, she strikes an alluring pose and leers at you through half-lidded eyes, one corner of her mouth curled up in a mirthful smirk.\n"
		+ "\n"
		+ "“<i>Mm... getting all hot and bothered, girl?</i>” she says, almost in a whisper, her voice dripping with seduction.\n"
		+ "\n"
		+ "As she leans down to press her chest to yours, her tails continue to twist and slither over your groin, teasing and painting your slit with their mystical fire. She starts to gradually grind her hips forward and back on your leg, her cheeks quivering gently while she leans forward to caress your face, planting a small kiss just below your chin. Lush, full lips press against yours, carrying the sweet taste of wintergreen. Her fingers clasp against the back of your head with a surprisingly strong grip, and she releases a powerful moan into your lips, a tingling coolness spreading over your tongue before moving on to the rest of your body.\n"
		+ "\n"
		+ "Her magic flows through your body, permeating your extremities and filling you with a shivering, shuddering lust. You forget in short order that you are the unwilling participant in this conniving trickster’s game, rationality subverted by baser instincts. Pure molten desire rushes to your loins, and all you can think about is your own glorious release. Surely, it will come soon. Surely, she can’t tease you like this forever...\n"
		+ "\n"
		+ "Her tails spread the lips of your vagina as wide as they will stretch, a third gently drawing circles of flame around your clitoris while a fourth presses insistently against your entrance. The soft brush pushes forward to meet the resistance of your moist, pink flesh, teasing you with the promise of penetration, yet never quite finding its way inside.\n"
		+ "\n"
		+ "“<i>Oh, you poor thing,</i>” she croons, watching your face contort into a grimace of shameless desire. Why won’t she get on with it already!? She swats your hands away as you reach up to try to assert control of the situation, two tails curling forward to bind your wrists. “<i>That's naughty! You can look, but I’ll be the one who does the touching today.</i>”\n"
		+ "\n"
		+ "You struggle against her bushy coils, but to no avail. Staring into the golden pools of her eyes, it becomes abundantly clear that physical resistance is going to get you nowhere - her hypnotic sorcery has left your muscles sapped of strength, hanging uselessly in the grip of her tails. Her fingers slowly dance across your large love-pillows again, drawing intricate patterns of flame down your front as she giggles happily. Slowly, agonizingly, her tail lowers against your -pussy- again, spiralling and twisting at the entrance. The soft, luxurious fur feels incredible against your nether regions, excitement building as she comes ever closer to finally thrusting it in, circling just outside it for an unbearably long time.\n"
		+ "\n"
		+ "“<i>You want this, huh? Show me just how bad you want it, otherwise I will keep toying with you until you do.</i>” she teases, gently reaching back to press her fingertip to your pleasure-buzzer, rolling it back and forth between her thumb and forefinger. The tip of her tail slips ever so slightly into your needy hole, swiveling and swirling around the inside before withdrawing and leaving you desperately wanting.\n"
		+ "\n"
		+ "You groan and thrash to the best of your ability underneath her, trying in vain to raise your hips to meet her tail, which is hovering tortuously just out of reach. Slick juices dribble down your [legs] as she grinds herself across you, an intense heat radiating from between her legs and betraying her own desire.\n"
		+ "\n"
		+ "Your eyes roll skyward and you moan lewdly, squirming and thrashing beneath her and trying your hardest to overcome her hypnotic hold on you, that you might take control and grant yourself the release you so desperately need. Just as you are certain that you’ll go out of your mind, she leans forward, grabbing your shoulders and pulling you into a long, drawn-out kiss. The tail that has been constantly, teasingly strafing your entrance at last twists itself into position, and your vision explodes into a sea of colors as it thrusts inside, burying itself deep inside your [pussy] in one pass. Lying flat against your [breasts], the kitsune raises her jiggling ass into the air, putting most of her weight into the passionate lip-lock. A licentious schlick echoes through the air as the kitsune threads a second tail down through the loop of the first, plunging it into her own sopping pussy with a groan.\n"
		+ "\n"
		+ "Brushlike tails and soft fingertips caress every curve and ridge of your body with a tender passion, leaving trails of flame tingling in their wake. With each passing second, the tail in your vagina pumps more furiously, slinging droplets of your juices through the air and filling the forest with your scent.\n"
		+ "\n"
		+ "A sudden chill rushes up your spine as an intense tingling begins to emanate through you from the core, sending you into a convulsion of pleasure. In the seconds before your eyes roll back in ecstasy, you can see a faint light issuing from your abdomen as the kitsune’s tail sets you alight from within! Strength momentary surges back into your muscles, allowing you to grip the kitsune in an intense embrace, your fingertips digging into her bare back as your body is wracked with pleasure.\n"
		+ "\n"
		+ "Your reaction elicits an excited moan from the tricky fox woman, causing her to redouble the passionate thrusting of her tails. She breaks the kiss long enough to groan into your ear, a rush of fluids splashing from her slick cunt and dripping down onto yours.\n"
		+ "\n"
		+ "“<i>Almost, girl! Mn, just a bit, ah! More...</i>”\n"
		+ "\n"
		+ "Grinding her hips along your front shamelessly, she gropes at your shoulders and [breasts] while pounding your pussy and hers alike with her tails. Faster and faster the slickened coils drive into you, dazzling jets of flame dancing across your groin and sending jolts of pleasure through your body like lightning. The kitsune’s fingers grip your biceps almost painfully as she reaches her climax first, a torrential downpour of juices spraying out around her tail as it whips out of her with a flourish.\n"
		+ "\n"
		+ "Your cooter bears down on her tail tightly, squeezing and rippling around the soft fur. Powerful spasms of pleasure shudder through you as your orgasm comes into full effect. Her tail continues to thrust into you violently through your climax, prolonging it for several minutes, heedless of your desperate thrashing. At long last, it whips out of you, slinging your slick fluids into the air with a wet slap, and exhaustion begins to take pleasure’s place. You feel as though you haven’t slept in days, your eyelids growing heavy as the kitsune leans up, her lips touching the edge of your ear as she whispers a short incantation while stroking the side of your face.\n"
		+ "\n"
		+ "The last thing you see before blacking out is a pair of delightfully plump, round cheeks jiggling happily as the kitsune gathers her robes.");
	player.sexReward("no", "Vaginal");
	cleanupAfterCombat();
}

private function sparAyane():void {
	clearOutput();
	outputText("Well, being nice and helpful is really good, but you're really curious if your seven-tailed follower can defend herself. Winking, you offer her a quick sparring in the woods. No holding back or worshipping; just fighting until one falls! To your surprise, she doesn't object, instead smiling coyly and runs towards the dark forest after taking her magic staff first. Seems like the white-haired kitsune planned something already... You've got a fun fight ahead!");
	startCombat(new Ayane());
	monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
	monster.gems = 0;
}
	}
}
