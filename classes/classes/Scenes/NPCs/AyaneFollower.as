/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Useable;
import classes.display.SpriteDb;

public class AyaneFollower extends NPCAwareContent
	{
		
		public function AyaneFollower() 
		{}

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
	outputText("Ayane's pussy, well hidden under her kimono, seems to be always ready for sex, although she is too well mannered to ask for it openly.");
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
	cheatTime(1/4);
}

public function ayaneTalkTaoth():void
{
	clearOutput();
	outputText("You observe that Taoth seems to like jokes and pranks. Is there any particular reason for that?\n\n");
	outputText("Ayane ponders the meaning of your question for a moment and then shrugs helplessly. \"<i>To question a god’s motivations is like asking why the water flows downward or why the sun and the moon trade places. Taoth has always been the trickster in the pantheon. Each god has a role and Taoth role seems to be one of chaotic influences to counterbalance the other deities overly serious demeanor. People need his laughter even more in these dark times when all hope fades.</i>\"\n\n");
	outputText("So in theory the reason he's the prankster of the pantheon is because everyone else is way too serious?\n\n");
	outputText("Ayane nods at this statement. \"<i>Deities could do with smiling more or with knowing how to have a good time. Taoth is here to remind them and us that order cannot exist without chaos, otherwise the world would be a bleak place indeed.</i>\"\n\n");
	doNext(ayaneTalkMenu);
	cheatTime(1/4);
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
	cheatTime(1/4);
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
			addButton(14, "Leave", camp.returnToCampUseOneHour);
		}
	}
	private function sellItem(item:Useable,cost:int = -1,buy:Boolean=false):void{
		cost = (cost > 0)? cost:item.value;
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
		}
}

public function ayaneSexMenu():void
{
	clearOutput();
	outputText("Ayane's ears perk up as you mention your interest. She takes on a seductive pose, setting up the mood.\n\n");
	outputText("\"<i>Oh?! I’m always game, what do you have in mind?</i>\"\n\n");
	menu();
	addButton(0, "Worship", ayaneWorship);
	if (player.hasCock()) addButton(1, "Anal", ayaneAnal);
}

public function ayaneWorship():void
{
	spriteSelect(SpriteDb.s_ayane_nude);
	clearOutput();
	outputText("You tell Ayane you could use some relief. She quickly takes the hint, helping you to remove any clothes you might be wearing and kneeling down, her face level with your hips as she whispers holy prayers.\n\n");
	if (player.hasCock()) {
		outputText("Ayane starts by cupping your balls with her hand, caressing them and applying her flames; causing them to slowly churn with cum and grow bigger as her magic increases your potency. She methodically moves her fingers up your length, tracing invisible designs along the flesh of your erect shaft. A pearl of precum appears on your tip which she proceeds to immediately lick, eliciting a pleasured moan from you. She methodically coats your shaft in a thick coat of her own saliva as she pulls it all in, her throat massaging your tip. ");
		outputText("You are slightly disappointed when she pulls back, your length popping out of her mouth, but that is short lived as the horny priestess proceeds to shed her own clothes, hugs you, and inserts your shaft inside her warm waiting folds. Unable to hold yourself still anymore, you proceed to stir up her pussy relentlessly, making Ayane moan prayers to Taoth as she’s fucked. Her walls feel like they were made for your dick, and as you would expect of a kitsune pussy, they hungrily milk you for your semen.\n\n");
		outputText("When you finally feel your balls emptying as you paint her vaginal canal white with your holy cum, something which seems to drive the lewd priestess over the edge as well. You sigh, relieved of your load, your balls slowly returning to their normal size. When you break the embrace you can’t help be smile in amusement as she tries to hold your cum inside of her.\n\n");
	}
	else {
		outputText("Ayane starts by slowly teasing your entrance. You shiver in appreciation as she plays her fingers across your " + vaginaDescript() + ", carefully using small blue flames every now and then to puff up your pussy properly. You caress her hair as she proceeds to lick your lips, dipping her tongue inside and curling her tongue over your clit. Gasping, you let your tails flow over her body, the feeling of her skin on your fur erotically charged and exquisite. Your tails trace her numerous tattoos, while hers do your own. The sensations dance through your mind, rippling through ");
		outputText("your body, driving you both mad with pleasure as she continues to lick your pussy. Your nipples stiffen in arousal and you start to massage your breasts, making use of your own foxfire in order to create the most pleasurable sensations that those mystical, licking flames can offer. Ayane keeps wildly licking your pussy and the both of you eventually fall down to the ground locking into a full sixty-nine as you search for the priestess' honeypot. Ayane moans, appreciative of your attention and for a few minutes the two of you focus purely on licking each other’s slick cunts.\n\n");
		outputText("You finally orgasm, baptizing your lovely attendant as she drinks from your constantly gushing cunt, making sure not to waste a single drop. Ayane cums not so long after, flooding your face with her juices.\n\n");
		
	}
	outputText("\"<i>Is " + player.mf("milord", "milady") + " satisfied?</i>\"\n\n");
	outputText("You reply that Ayane is doing a wonderful job and that you are indeed quite satisfied by her worship. A few minutes later the both of you start redressing, ready to continue on your journey.");
	player.sexReward("saliva");
	doNext(camp.returnToCampUseOneHour);
}

public function ayaneAnal():void
{
	spriteSelect(SpriteDb.s_ayane_nude);
	clearOutput();
	outputText("Ayane's well shaped ass draws your attention today; the way she swings her tails around it is such a tease. You resolve to teach her what happens when one flaunts such a sweet backside around, telling the foxy girl to bend over and give you a good look at her backside. Ayane smiles, undresses, and bends over, giving you a full display before obscuring it again with a tail. You yank the thing away and align yourself as you proceed to insert your [cock] through her inviting pucker.\n\n");
	outputText("Ayane moans as you proceed to explore the depths of her ass, her tails moving wildly behind her as you pump in and out of the lusty shrine priestess.\n\n");
	outputText("\"<i>Oooh! Good lord Taoth grant me the aaahn...</i>\"\n\n");
	outputText("She’s way beyond the ability to voice her prayer coherently as you keep plowing her ass thoroughly. You grab two of her tails, playing with the fur and using them as handles as you pull in and out. Ayane doesn’t seem to mind it, her tight pucker, against all logic, reacts more like a pussy than a traditional anus, trying to milk you more the rougher you are with her.\n\n");
	outputText("\"<i>Ahhhhn " + player.mf("milord", "milady") + " fuck me harder, faster, let me bask in the glory of your proud hard tool!”</i>\"\n\n");
	outputText("You sure feel like obliging her, increasing the pace as Ayane wails in pleasure. Your cock suddenly throbs and explodes in her ass with a creamy deluge. You slowly remove your cock from the abused kitsune's ass, cum drooling slowly from her hole.\n\n");
	outputText("\"<i>Ahh... So wonderful... To be filled with your seed is a blessing...</i>\"\n\n");
	outputText("You clean your cock on one of her silky white tails, making her gasp, as the both of you slowly proceed to redress.");
	player.sexReward("Default","Default",true,false);
	doNext(camp.returnToCampUseOneHour);
}

	}

}