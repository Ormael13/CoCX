package classes.Scenes.Explore {
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Camp.CampStatsAndResources;
import classes.display.SpriteDb;
import classes.Scenes.SceneLib;

public class Lumi extends BaseContent {

    public var metal_pieces:Number = 0;
	
	public function Lumi() {
    }

    public function lumiEncounter():void {
        clearOutput();
        //1st time lumi meeting
        if (flags[kFLAGS.LUMI_MET] == 0) {
            //placeholder text for outside the cathedral
            outputText("You spot an anomaly in the barren wastes; a door that seems to be standing out in the middle of nowhere. Somehow, you figure that it must lead to some other part of the world, and the only reason it's here is because you can't get to where the door should be right now.\n\n");
            outputText("Do you open it?");
            doYesNo(lumiLabChoices, explorer.done);
        }
        else {
            //placeholder text for outside the cathedral
            outputText("You spot the door standing in the middle of nowhere again, and you guess that it will lead you back to Lumi's laboratory.  It swings open easily...");
            doNext(lumiLabChoices);
        }
//end of placeholder text
    }

    public function lumiLabChoices():void {
        spriteSelect(SpriteDb.s_lumi);
        clearOutput();
        //First time meeting
        if (flags[kFLAGS.LUMI_MET] == 0) {
            //Set Lumi met flag
            flags[kFLAGS.LUMI_MET]++;
            outputText("You open the door and carefully check inside for any enemies that may be trying to ambush you. The room seems to be some kind of alchemical lab, with shelves full of apparatuses all along the walls, a desk on one side of the room, and a long table across the room from you that is full of alchemical experiments in progress, many give off lots of smoke, and others are bottles of bubbling fluids.  A goblin wearing an apron and some kind of headband is sitting on a tall, wheeled stool; she is otherwise nude and seems to be watching at least 3 experiments right now. She suddenly turns around and looks straight in your direction.  It's hard to tell thanks to the dark goggles that hide her eyes from view, but you're fairly certain she's watching you.  After a few seconds she yells \"<i>Cuths-tohmer!</i>\" in a thick lisp. She looks harmless enough, so you step inside while she fiddles with her experiments, reducing the bubbling smoke.  She jumps down from her stool, tears off her apron, bounds over to the desk, and scrambles on top of it.\n\n");

            outputText("She's about 3 feet tall, with yellow-green skin, and wears her orange hair in a long ponytail that reaches to her knees.  Her breasts are about B cup, with average nipples that have been colored orange. All of her nails have been painted orange to match. She doesn't seem to ever stop moving, and while the majority of her face looks cute, it's a little hard to be sure while she's wearing those thick goggles.  The solid black lenses of her goggles make her look quite unsettling, stifling any appeal her form could inspire in you.\n\n");

            outputText("\"<i>Stho, what can Lumi, Gobin Aochomist Extwaordinaire, do fo you today?</i>\" asks the unusual goblin.\n\n");

            outputText("You explain that it's a little hard to understand her.  She sticks her tongue out at you, showing a VERY large stud in the middle of it, instantly explaining her lisp.  Rather than pushing the point, you ask her what she can do for you.  She pulls open a hatch on the top of the desk and pulls out a bottle of something and shakes it, \"<i>Lumi can sell you some of her finely cwafted poetions fo a good pwice, ore, if you've alweady got some nice poetions or reagents, Lumi can make them even bettar. But tha cost a whole lot. If you were one of dee Followers, den maybe Lumi could make a special deal wit you; but the boss don't want me playin wit outsiders. Wat will it be?</i>\"\n\n");
        }
        //Repeat Meetings
        else outputText("Once more, you step into Lumi's lab.  She's still working on her experiments. Before you even have a chance to call out to her, she has already pivoted to watch you.  In a flash her apron hits the floor and she is standing on her desk, asking,\"<i>Stho, what can Lumi the Aochomist Extwaordinaire do fo you today?</i>\"");
		menu();
		if (lumiEnhance0(true)) addButton(0, "Enhance", lumiEnhance0);
		if (lumiEnhance1(true)) addButton(1, "Enhance", lumiEnhance1);
		addButton(10, "Shop", lumiShop);
		if (player.hasStatusEffect(StatusEffects.LumiWorkshop)) {
			addButton(11, "Engineering", lumiEngineering);
			addButton(12, "Workshop", lumiWorkshop);
			if (player.statusEffectv2(StatusEffects.LumiWorkshop) < 1) addButton(13, "GoblinMech", lumiGarageRetry);
		}
		else addButton(12, "Garage", lumiGarage).hint("Click only if you're goblin (10+ in goblin score) with 500+ gems ;)");
		addButton(14, "Leave", explorer.done);
    }
	
    public function lumiEnhance0(justCheck:Boolean = false):Boolean {
        var improvables:Array = [
            [consumables.FOXBERY,consumables.VIXVIGR],
            [consumables.FOXJEWL,consumables.MYSTJWL],
            [consumables.GLDSEED,consumables.MAGSEED],
            [consumables.KANGAFT,consumables.MGHTYVG],
            [consumables.L_DRAFT,consumables.F_DRAFT],
            [consumables.LABOVA_,consumables.PROBOVA],
            [consumables.PIGTRUF,consumables.BOARTRU],
            [consumables.PURHONY,consumables.SPHONEY],
            [consumables.SDELITE,consumables.S_DREAM],
			[consumables.SNAKOIL,consumables.RESNOIL],
        ];
        if(justCheck){
            for each(var improvable:Array in improvables){
                if(player.hasItem(improvable[0])){return true;}
            }
            return false;
        }
        clearOutput();
        outputText("\"<i>Do you have 100 gems for de enhancement?</i>\" asks Lumi.\n\n");
        if (player.gems < 100) {
            outputText("You shake your head no, and Lumi gives you a disappointed look and says, \"<i>Den Lumi can do no enhancement for you. Anyfing else?</i>\"\n\n");
            //Return to main Lumi menu
            doNext(lumiLabChoices);
            return false;
        } else {
            outputText("You nod and Lumi gives an excited yell, \"<i>Yay! Lumi loves to do enhancement, what you want to be bettar?</i>\"\n\n");
            for(var i:int = 0; i<improvables.length;i++){
                if(player.hasItem(improvables[i][0])){
                    addButton(i,improvables[i][0].shortName,lumiEnhanceGo0,improvables[i][0],improvables[i][1]);
                } else {
                    addButtonDisabled(i,improvables[i][0].shortName);
                }
            }
            addButton(14, "Back", lumiLabChoices);
            return true;
        }
    }
    private function lumiEnhanceGo0(itype:ItemType,nextItem:ItemType):void{
        spriteSelect(SpriteDb.s_lumi);
        trace("LUMI ENHANCE");
        player.gems -= 100;
        statScreenRefresh();
        player.consumeItem(itype);
        clearOutput();
        outputText("Lumi grabs the item from you and runs over to her table, stopping for only a second to put her apron on.  ");
        //start list of possible enhancement texts
        if (itype == consumables.GLDSEED) outputText("She fiddles with it, coating it in exotic powders before she tosses the whole mess onto a hotplate.  It explodes, knocking the goblin flat on her ass.  She sits bolt upright and snatches up the now-glowing seed with a gloved hand.\n\n");
        else if (itype == consumables.FOXJEWL) outputText("Lumi stares wide-eyed into the fathoms of its depths.  She remains like that for several moments before you clear your throat, and then hurries off to work.  Flitting back and forth between the various beakers and test tubes that litter the workshop, she mixes chemicals seemingly at random, many of which bubble or explode rather violently.\n\nAfter several minutes of this, she pours all of the reagents into a large beaker over an open flame.  The contents boil up through the neck of the flask and drip slowly down the condenser.  A ponderously large drop of black liquid builds up at the tip of the condenser, wobbling precipitously for a moment before finally falling onto the jewel with a splash.\n\nThe jewel soaks up the black fluid like a sponge, veins of sickening purple spreading across the surface like a spider's web.  A few moments later, the jewel is entirely purple, the mystic flames inside glowing a bright violet.\n\nYou reach out hesitantly and place the mystically enhanced teardrop-shaped jewel into your pouch.\n\n");
        else if (itype == consumables.KANGAFT) outputText("She fiddles with it, coating it in exotic powders before she tosses the whole mess onto a hotplate.  It explodes, knocking the goblin flat on her ass.  She sits bolt upright and snatches up the now-glowing fruit with a gloved hand.\n\n");
        else {
	        switch (rand(3)) {
		        case 0:
			        outputText("She starts grabbing things from around the table, seemingly at random, and adds them to " + itype.longName + ".  To your alarm, there is soon a large cloud of smoke coming off it! There is a strong smell to the smoke and it makes it hard to breathe.  Lumi grabs a mask out of a drawer and puts it on, continuing with her work unperturbed.  She suddenly stops and you wonder if she is done, but she takes off her mask and inhales deeply of the smoke, then keels over!  As you go over to help her she suddenly stands up, waves away some of the smoke, and says, \"<i>All dun!</i>\"\n\n");
			        break;
		        case 1:
			        outputText("Taking hold of one of the bottles that were sitting where she put the tray, she seems to think for a moment before tossing the bottle into one of the corners of the room.  It shatters just behind the table, and a small puff of smoke goes up into the air.  You're a little nervous about that bottle, but before you have a chance to say anything, two more bottles fly off and join it; this time causing a small explosion. You ask her what she is thinking tossing those aside, and she simply responds, \"<i>Dey were in my way.</i>\"\n\n\"<i>What?!  So you just toss things that explode to the side?</i>\"\n\n<i>\"Don worry, I'll put counter agents in dere at de end of de day.  An I never throw stuff da'll do any damage.  Done!</i>\"\n\n");
			        break;
		        case 2:
			        outputText("She adds a few things to the tray before moving down the table.  She adds some reagents to a bubbling chemical reaction, and then adds some more ingredients to that.  You wonder why she just left " + itype.longName + " there to work on something else.  Then Lumi moves back across the table, past where " + itype.longName + " sits, to start adding things to something else.  Before you have a chance to complain, she moves back to " + itype.longName + " and continues.  You decide that it's probably best not to ask about her work ethic and just let her do her thing; she has more experience than you, after all.\n\nPOP! You look over in surprise as the first thing she worked on makes a small explosion.  POW! Now the second experiment has blown up!  You start to move in alarm, wondering if Lumi really knows what she's doing; just before " + itype.longName + " seems to explode with an incredible BOOM.  Lumi stops moving for a moment, looking straight ahead before saying, \"<i>Dat was a gud one, Lumi dun!</i>\"\n\n");
			        break;
	        }
        }
        inventory.takeItem(nextItem, lumiEnhance0, lumiLabChoices);
    }
	public function lumiEnhance1(justCheck:Boolean = false):Boolean {
        var improvables:Array = [
            [consumables.NUMBROX,consumables.NUMBCND],
            [consumables.GOB_ALE,consumables.GRE_BER],
            [consumables.REDVIAL,consumables.VAMPBLD],
            [consumables.C_VEMOM,consumables.P_VEMOM],
			[consumables.BLACKIN,consumables.ABYSSIN],
            [consumables.ECTOPLS,consumables.PROTPLS],
            [consumables.EYEDROP,consumables.ME_DROP],
        ];
        if(justCheck){
            for each(var improvable:Array in improvables){
                if(player.hasItem(improvable[0])){return true;}
            }
            return false;
        }
        clearOutput();
        outputText("\"<i>Do you have 100 gems for de enhancement?</i>\" asks Lumi.\n\n");
        if (player.gems < 100) {
            outputText("You shake your head no, and Lumi gives you a disappointed look and says, \"<i>Den Lumi can do no enhancement for you. Anyfing else?</i>\"\n\n");
            //Return to main Lumi menu
            doNext(lumiLabChoices);
            return false;
        } else {
            outputText("You nod and Lumi gives an excited yell, \"<i>Yay! Lumi loves to do enhancement, what you want to be bettar?</i>\"\n\n");
            for(var i:int = 0; i<improvables.length;i++){
                if(player.hasItem(improvables[i][0])){
                    addButton(i,improvables[i][0].shortName,lumiEnhanceGo1,improvables[i][0],improvables[i][1]);
                } else {
                    addButtonDisabled(i,improvables[i][0].shortName);
                }
            }
            addButton(14, "Back", lumiLabChoices);
            return true;
        }
    }
    private function lumiEnhanceGo1(itype:ItemType,nextItem:ItemType):void{
        spriteSelect(SpriteDb.s_lumi);
        trace("LUMI ENHANCE");
        player.gems -= 100;
        statScreenRefresh();
        player.consumeItem(itype);
        clearOutput();
        outputText("Lumi grabs the item from you and runs over to her table, stopping for only a second to put her apron on.  ");
        //start list of possible enhancement texts
        switch (rand(3)) {
			case 0:
				outputText("She starts grabbing things from around the table, seemingly at random, and adds them to " + itype.longName + ".  To your alarm, there is soon a large cloud of smoke coming off it! There is a strong smell to the smoke and it makes it hard to breathe.  Lumi grabs a mask out of a drawer and puts it on, continuing with her work unperturbed.  She suddenly stops and you wonder if she is done, but she takes off her mask and inhales deeply of the smoke, then keels over!  As you go over to help her she suddenly stands up, waves away some of the smoke, and says, \"<i>All dun!</i>\"\n\n");
				break;
			case 1:
			    outputText("Taking hold of one of the bottles that were sitting where she put the tray, she seems to think for a moment before tossing the bottle into one of the corners of the room.  It shatters just behind the table, and a small puff of smoke goes up into the air.  You're a little nervous about that bottle, but before you have a chance to say anything, two more bottles fly off and join it; this time causing a small explosion. You ask her what she is thinking tossing those aside, and she simply responds, \"<i>Dey were in my way.</i>\"\n\n\"<i>What?!  So you just toss things that explode to the side?</i>\"\n\n<i>\"Don worry, I'll put counter agents in dere at de end of de day.  An I never throw stuff da'll do any damage.  Done!</i>\"\n\n");
			    break;
			case 2:
			    outputText("She adds a few things to the tray before moving down the table.  She adds some reagents to a bubbling chemical reaction, and then adds some more ingredients to that.  You wonder why she just left " + itype.longName + " there to work on something else.  Then Lumi moves back across the table, past where " + itype.longName + " sits, to start adding things to something else.  Before you have a chance to complain, she moves back to " + itype.longName + " and continues.  You decide that it's probably best not to ask about her work ethic and just let her do her thing; she has more experience than you, after all.\n\nPOP! You look over in surprise as the first thing she worked on makes a small explosion.  POW! Now the second experiment has blown up!  You start to move in alarm, wondering if Lumi really knows what she's doing; just before " + itype.longName + " seems to explode with an incredible BOOM.  Lumi stops moving for a moment, looking straight ahead before saying, \"<i>Dat was a gud one, Lumi dun!</i>\"\n\n");
			    break;
        }
        inventory.takeItem(nextItem, lumiEnhance1, lumiLabChoices);
    }

    public function lumiShop():void {
        spriteSelect(SpriteDb.s_lumi);
        //Set item handling to lumi shop
        clearOutput();
        outputText("You ask Lumi if you can see her potions.  She smiles at you and pulls out several bottles from her desk and shows them to you.\n\n\"<i>Gawantied qwality, made by Lumi herself,</i>\" she says proudly.\n\n");
        outputText("Lust Draft - 15 gems\nGoblin Ale - 20 gems\nOviposition Elixir - 45 gems\nGoblin Technomancer clothes - 400 gems\nTechnomancer bra - 600 gems\nTechnomancer panties - 600 gems\n");
		menu();
		addButton(0, "Lust Draft", lumiLustDraftPitch);
		addButton(1, "Goblin Ale", lumiPitchGobboAle);
		addButton(2, "Ovi Elixir", lumiPitchOviElixer);
		addButton(5, "G.Tech.C.", lumiPitchGoblinTechnomancerClothes).hint("Goblin Technomancer Clothes");
		addButton(6, "Tech.Bra", lumiPitchTechnomancerBra).hint("Technomancer bra");
		addButton(7, "Tech.Pan", lumiPitchTechnomancerPanties).hint("Technomancer panties");
		addButton(10, "SellMats", lumiSell);
		addButton(14, "Leave", lumiLabChoices);
    }
//Lust Draft
    private function lumiLustDraftPitch():void {
        spriteSelect(SpriteDb.s_lumi);
        clearOutput();
        outputText("You point at the bottle filled with bubble-gum pink fluid.\n\n\"<i>De lust dwaft? Always a favowite, with it you nevar have to worwy about not bein weady for sexy time; one of my fiwst creations. 15 gems each.</i>\"\n\n");
        outputText("Will you buy the lust draft?");
        doYesNo(curry(lumiPurchase, consumables.L_DRAFT), lumiShop);
    }
//Goblin Ale
    private function lumiPitchGobboAle():void {
        spriteSelect(SpriteDb.s_lumi);
        clearOutput();
        outputText("You point at the flagon. \"<i>Oh? Oh thats Lumi's... actually no, dat tispsy stuff for 20 gems. You'll like if you want to be like Lumi. Do you like it?</i>\"\n\n");
        outputText("Will you buy the goblin ale?");
        doYesNo(curry(lumiPurchase, consumables.GOB_ALE), lumiShop);
    }
//Ovi Elixir
    private function lumiPitchOviElixer():void {
        spriteSelect(SpriteDb.s_lumi);
        clearOutput();
        outputText("You point at the curious hexagonal bottle. \"<i>De Oviposar Elixir? Made baithsed on da giant bee's special stuff dey give deir queen. It will help make de burfing go faster, an if you dwink it while you awen pweggy, iw will give you some eggs to burf later. More dwinks, eqwals more and biggar eggs. Lumi charges 45 gems for each dose.</i>\"\n\n");
        outputText("Will you buy the Ovi Elixir?");
        doYesNo(curry(lumiPurchase, consumables.OVIELIX), lumiShop);
    }
//Goblin Technomancer clothes
    private function lumiPitchGoblinTechnomancerClothes():void {
        spriteSelect(SpriteDb.s_lumi);
        clearOutput();
        outputText("Lumi nods at your pick. \"<i>Buyin dese? Smart move. Nevar ouant ta work ouit stuff dats gunna gat ruined if some oil drips on it. Dese are true mechanist clothes. Sturdy, durable and best ov all, adaptable ta any gadget ya may plug ta dem.</i>\"\n\n");
        outputText("Will you buy the Goblin Technomancer clothes? (for 400 gems)");
        doYesNo(curry(lumiPurchase, armors.GTECHC_), lumiShop);
    }
//Technomancer bra
    private function lumiPitchTechnomancerBra():void {
        spriteSelect(SpriteDb.s_lumi);
        clearOutput();
        outputText("Lumi nods at your pick. \"<i>Buyin dese? Smart move. Nevar ouant ta work ouit stuff dats gunna gat ruined if some oil drips on it. Dese are true mechanist clothes. Sturdy, durable and best ov all, adaptable ta any gadget ya may plug ta dem.</i>\"\n\n");
        outputText("Will you buy the Technomancer bra? (for 600 gems)");
        doYesNo(curry(lumiPurchase, undergarments.TECHBRA), lumiShop);
    }
//Technomancer panties
    private function lumiPitchTechnomancerPanties():void {
        spriteSelect(SpriteDb.s_lumi);
        clearOutput();
        outputText("Lumi nods at your pick. \"<i>Buyin dese? Smart move. Nevar ouant ta work ouit stuff dats gunna gat ruined if some oil drips on it. Dese are true mechanist clothes. Sturdy, durable and best ov all, adaptable ta any gadget ya may plug ta dem.</i>\"\n\n");
        outputText("Will you buy the Technomancer panties? (for 600 gems)");
        doYesNo(curry(lumiPurchase, undergarments.T_PANTY), lumiShop);
    }
    private function lumiPurchase(itype:ItemType):void {
        spriteSelect(SpriteDb.s_lumi);
        clearOutput();
        //After choosing, and PC has enough gems
        var cost:Number = 0;
        if (itype == consumables.OVIELIX)
            cost = 45;
        if (itype == consumables.GOB_ALE)
            cost = 20;
        if (itype == consumables.L_DRAFT)
            cost = 15;
        if (itype == armors.GTECHC_)
            cost = 400;
        if (itype == undergarments.TECHBRA)
            cost = 600;
        if (itype == undergarments.T_PANTY)
            cost = 600;
        if (player.gems >= cost) {
            outputText("You pay Lumi the gems, and she hands you " + itype.longName + " saying, \"<i>Here ya go!</i>\"\n\n");
            player.gems -= cost;
            statScreenRefresh();
            inventory.takeItem(itype, lumiShop, lumiLabChoices);
        }
        else {
            //After choosing, and PC doesn't have enough gems
            outputText("You go to pay Lumi the gems, but then you realize that you don't have enough. Lumi seems to know what happened and tells you \"<i>Ok, is dere somefing you want to buy that you can affowd?</i>\"\n\n");
            //Return to main Lumi menu
            doNext(lumiShop);
        }
    }
	
	public function lumiSell():void {
        spriteSelect(SpriteDb.s_lumi);
        //Set item handling to lumi shop
        clearOutput();
        outputText("\"<i>Aye "+player.mf("lad","lass")+" what ya got for trade today?</i>\"\n\n");
        menu();
		addButton(0, "Metal Plates", lumiSellMatsMetalPlates).hint("Sell Metal Plates.");
		addButton(14, "Leave", lumiShop);
    }
	public function lumiSellMatsMetalPlates():void {
        spriteSelect(SpriteDb.s_lumi);
        //Set item handling to lumi shop
        clearOutput();
        outputText("\"<i>Ya want to sell me this thing? Sure I will take it from you but only for 20 gem. I ain't running a pawn shop or charity booth here, this is a lab and I need parts and fundings. So in what quantity are we speaking?</i>\"\n\n");
        menu();
		if (CampStatsAndResources.MetalPieces >= 1) addButton(0, "Sell 1", lumiSellMatsMetalPlatesAmount, 1).hint("Sell 1 Metal Plate.");
		if (CampStatsAndResources.MetalPieces >= 5) addButton(1, "Sell 5", lumiSellMatsMetalPlatesAmount, 5).hint("Sell 5 Metal Plates.");
		if (CampStatsAndResources.MetalPieces >= 10) addButton(2, "Sell 10", lumiSellMatsMetalPlatesAmount, 10).hint("Sell 10 Metal Plates.");
		if (CampStatsAndResources.MetalPieces >= 50) addButton(3, "Sell 50", lumiSellMatsMetalPlatesAmount, 50).hint("Sell 50 Metal Plates.");
		addButton(14, "No", lumiSell);
    }
	private function lumiSellMatsMetalPlatesAmount(amount:int):void {
		metal_pieces = amount;
		clearOutput();
		var gems:Number = (metal_pieces * 20);
		if (player.hasPerk(PerkLib.Greedy)) gems *= 2;
		if (player.hasPerk(PerkLib.TravelingMerchantOutfit)) gems *= 2;
		player.gems += gems;
		if (player.hasPerk(PerkLib.Greedy) || player.hasPerk(PerkLib.TravelingMerchantOutfit)) outputText("Thanks to a little magic and a lot of hard bargaining you managed to sell your items for more than normal.\n\n");
		outputText("You shake hands with Lumi and trade off the parts.\n\n\"<i>Happy doing business with you… anything else or can I get back to work?</i>\"\n\n");
		CampStatsAndResources.MetalPieces -= metal_pieces;
		statScreenRefresh();
		doNext(lumiSellMatsMetalPlates);
	}
	private function lumiSellMatsMetalPlatesNo():void {
		clearOutput();
		outputText("You would rather think it through first. This here is prime quality material after all.\n\n\"<i>Hardly but if you wanna keep it and think it over then no skin off my back i'll obtain myself the thing the same way I do normally. So anything else you wanted [name]?</i>\"\n\n");
		doNext(lumiSellMatsMetalPlates);
	}
	
	public function lumiGarage():void {
		spriteSelect(SpriteDb.s_lumi);
        clearOutput();
        player.createStatusEffect(StatusEffects.LumiWorkshop,0,0,0,0);
		outputText("In the corner of Lumi’s weird shop, there is a large door to a room filled with similarly weird items, you ask Lumi about them.\n\n");
		outputText("\"<i>Oh ya lookin fer goblin tech? It's not fer sale but I sell pieces and tools fer engineers. Perhaps ya would be interested into a Cock axial resonator or a vibrafronics spinning battery?</i>\"\n\n");
		outputText("You didn’t understand half of what she said and admit as much.\n\n");
		outputText("\"<i>Ah, go fegures. True genius is dyin thase days. Sure, I make sex toys and poetions but I think the true arft still is in a functional goblin mech!</i>\"\n\n");
		outputText("A goblin mech?\n\n");
		outputText("\"<i>I often forget fome people especially non goblin don’t exactly know what a mech is…basically it’s a sort ov combat confraption a goblin can drive. I have an alpha version jast right dere");
		if (player.isGoblinoid(false)) {
			outputText("if you have da gems fer it.</i>\"\n\n");
			outputText("She points at what looks like a goblin sized seat mounted on a weird six legged contraption.\n\n");
			outputText("\"<i>It can ba customised in dozens of ways if yer smart enough and have da time fer it. Fer only 500 gem it’s yours... Interested?</i>\"\n\n");
			menu();
			addButton(1, "Yes", lumiGarageYes);
			addButton(3, "No", lumiGarageNo);
		}
		else {
			outputText("but there's no way I'd sell that ta a non goblin, who knows, ya common folks could hurt yeerself badly just tryin ta drive it.</i>\"\n\n");
		}
		//outputText("\n\n");
		//outputText("\"<i>Stho, what can Lumi the Aochomist Extwaordinaire do fo you today?</i>\"\n\n");
	}
	public function lumiGarageYes():void {
		if (player.gems >= 500) {
			player.gems -= 500;
			outputText("You hand over the gems to Lumi who nods.\n\n");
			outputText("\"<i>Good deal " + player.mf("stud", "girl") + " ya won’t regret it. In da events ya need bluefrints for new gadgets and upgrades I can sell ya a fopy of mines, fer a price. Speafing of which ya will need a proper workshap to craft. Ya are free ta use mine until you have somehow built yer own.</i>\"\n\n");
			player.addStatusValue(StatusEffects.LumiWorkshop,2,1);
			inventory.takeItem(vehicles.GOBMALP, explorer.done);
		}
		else {
			outputText("You would love to purchase the mech but you are somewhat low on gems.\n\n");
			outputText("\"<i>Well that’s a shame but nonetheless ya can always just come back lafer right?</i>\"\n\n");
			endEncounter();
		}
	}
	public function lumiGarageNo():void {
		outputText("You tell the goblin you will think it over and leave the shop.\n\n");
		endEncounter();
	}
	public function lumiGarageRetry():void {
		outputText("You inquire on the goblin mech.\n\n");
		outputText("\"<i>Oh ya came back on your decision? Sure I still have it in the backroom. 500 gems as before.</i>\"\n\n");
		menu();
		if (player.isGoblinoid()) addButton(1, "Yes", lumiGarageYes);
		else addButtonDisabled(1, "Yes", "You still not enough goblin to get this beauty. Money can't buy everything, ok?");
		addButton(3, "No", lumiGarageNo);
	}
	
	public function lumiEngineering():void {
		spriteSelect(SpriteDb.s_lumi);
        clearOutput();
        outputText("I will ask Lia to write smth for this section.\n\n");
		menu();
		addButton(0, "Metal pieces", lumiEngineeringBuyMetalPieces);
		if (player.hasKeyItem("Blueprint - Energy Core") < 0) addButton(1, "EnergyCore BP", curry(lumiEngineeringBuyBlueprintSharedPart, 50, "Energy Core")).hint("Energy Core BP - 50 gems");
		else addButtonDisabled(1, "EnergyCore BP", "Already having this blueprint.");
		if (player.hasKeyItem("Blueprint - Mechanism") < 0) addButton(2, "Mechanism BP", curry(lumiEngineeringBuyBlueprintSharedPart, 50, "Mechanism")).hint("Mechanism BP - 50 gems");
		else addButtonDisabled(2, "Mechanism BP", "Already having this blueprint.");
		if (player.hasKeyItem("Toolbelt") < 0 && player.hasKeyItem("Blueprint - Toolbelt") < 0) addButton(3, "Toolbelt", lumiEngineeringBuyBlueprintToolbelt).hint("Toolbelt BP - 100 gems");
		else addButtonDisabled(3, "Toolbelt", "Already having this blueprint.");
		if (player.hasKeyItem("Potent Drug injectors") < 0 && player.hasKeyItem("Blueprint - Potent Drug injectors") < 0) addButton(4, "Potent Drug injectors", lumiEngineeringBuyBlueprintPotentDrugInjectors).hint("Potent Drug injectors BP - 1000 gems");
		if (player.hasKeyItem("Improved Drug injectors") < 0 && player.hasKeyItem("Potent Drug injectors") < 0 && player.hasKeyItem("Blueprint - Improved Drug injectors") < 0) addButton(4, "Improved Drug injectors", lumiEngineeringBuyBlueprintImprovedDrugInjectors).hint("Improved Drug injectors BP - 500 gems");
		if (player.hasKeyItem("Drug injectors") < 0 && player.hasKeyItem("Improved Drug injectors") < 0 && player.hasKeyItem("Potent Drug injectors") < 0 && player.hasKeyItem("Blueprint - Drug injectors") < 0) addButton(4, "Drug injectors", lumiEngineeringBuyBlueprintDrugInjectors).hint("Drug injectors BP - 100 gems");
		if (player.hasKeyItem("Gun Scope with Aimbot") < 0 && player.hasKeyItem("Blueprint - Gun Scope with Aimbot") < 0) addButton(5, "Gun Scope with Aimbot", lumiEngineeringBuyBlueprintGunScopeWithAimbot).hint("Gun Scope with Aimbot BP - 1000 gems");
		if (player.hasKeyItem("Gun Scope with Aim tech") < 0 && player.hasKeyItem("Gun Scope with Aimbot") < 0 && player.hasKeyItem("Blueprint - Gun Scope with Aim tech") < 0) addButton(5, "Gun Scope with Aim tech", lumiEngineeringBuyBlueprintGunScopeWithAimTech).hint("Gun Scope with Aim tech BP - 500 gems");
		if (player.hasKeyItem("Gun Scope") < 0 && player.hasKeyItem("Gun Scope with Aim tech") < 0 && player.hasKeyItem("Gun Scope with Aimbot") < 0 && player.hasKeyItem("Blueprint - Gun Scope") < 0) addButton(5, "Gun Scope", lumiEngineeringBuyBlueprintGunScope).hint("Gun Scope BP - 100 gems");
		if (player.hasKeyItem("Blueprint - S.A Tech Goggle") < 0 && player.hasKeyItem("Blueprint - Scanner goggle") >= 0) addButton(6, "S.A Tech Goggles", lumiEngineeringBuyBlueprintSATechGoggle).hint("S.A Tech Goggles BP - 1000 gems");
		if (player.hasKeyItem("Blueprint - Scanner goggle") < 0 && player.hasKeyItem("Blueprint - Machinist Goggles") >= 0) addButton(6, "Scanner goggles", lumiEngineeringBuyBlueprintScannerGoggle).hint("Scanner goggles BP - 500 gems");
		if (player.hasKeyItem("Blueprint - Machinist Goggles") < 0) addButton(6, "Machinist Goggles", lumiEngineeringBuyBlueprintMachinistGoggles).hint("Machinist Goggles BP - 100 gems");
		if (player.hasKeyItem("Nitro Boots") < 0 && player.hasKeyItem("Blueprint - Nitro Boots") < 0) addButton(7, "Nitro Boots", lumiEngineeringBuyBlueprintNitroBoots).hint("Nitro Boots BP - 1000 gems");
		if (player.hasKeyItem("Rocket Boots") < 0 && player.hasKeyItem("Nitro Boots") < 0 && player.hasKeyItem("Blueprint - Rocket Boots") < 0) addButton(7, "Rocket Boots", lumiEngineeringBuyBlueprintRocketBoots).hint("Rocket Boots BP - 500 gems");
		if (player.hasKeyItem("Spring Boots") < 0 && player.hasKeyItem("Rocket Boots") < 0 && player.hasKeyItem("Nitro Boots") < 0 && player.hasKeyItem("Blueprint - Spring Boots") < 0) addButton(7, "Spring Boots", lumiEngineeringBuyBlueprintSpringBoots).hint("Spring Boots BP - 100 gems");
		if (player.hasKeyItem("M.G.S. bracer") < 0 && player.hasKeyItem("Blueprint - M.G.S. bracer") < 0) addButton(8, "M.G.S. bracer", lumiEngineeringBuyBlueprintMGSBracer).hint("M.G.S. bracer BP - 1000 gems");
		if (player.hasKeyItem("Powboy") < 0 && player.hasKeyItem("M.G.S. bracer") < 0 && player.hasKeyItem("Blueprint - Powboy") < 0) addButton(8, "Powboy", lumiEngineeringBuyBlueprintPowboy).hint("Powboy BP - 500 gems");
		if (player.hasKeyItem("Power bracer") < 0 && player.hasKeyItem("Powboy") < 0 && player.hasKeyItem("M.G.S. bracer") < 0 && player.hasKeyItem("Blueprint - Power bracer") < 0) addButton(8, "Power bracer", lumiEngineeringBuyBlueprintPowerBracer).hint("Power bracer BP - 100 gems");
		if (player.hasKeyItem("Blueprint - Ripper 2.0") < 0 && player.hasKeyItem("Blueprint - Ripper 1.0") >= 0) addButton(9, "Ripper 2.0", lumiEngineeringBuyBlueprintRipper2).hint("Ripper 2.0 BP - 1000 gems");
		if (player.hasKeyItem("Blueprint - Ripper 1.0") < 0 && player.hasKeyItem("Blueprint - Machined greatsword") >= 0) addButton(9, "Ripper 1.0", lumiEngineeringBuyBlueprintRipper1).hint("Ripper 1.0 BP - 500 gems");
		if (player.hasKeyItem("Blueprint - Machined greatsword") < 0) addButton(9, "Mach. greatsword", lumiEngineeringBuyBlueprintMachinedGreatsword).hint("Machined greatsword BP - 100 gems");
		if (player.hasKeyItem("Blueprint - Machined spear") < 0) addButton(10, "Mach. spear", lumiEngineeringBuyBlueprintMachinedSpear).hint("Machined spear BP - 100 gems");
		if (player.hasKeyItem("Toolbelt") >= 0) addButton(11, "Mech UPGR", lumiEngineeringMechUpgrades);
		else addButtonDisabled(11, "Mech UPGR", "You need to have Toolbelt to access this section of blueprints.");
		if (player.hasKeyItem("Mechanic's Wrench") < 0) {
			if (player.gems >= 50) addButton(12, "MechanicWrench", lumiEngineeringBuySet1).hint("50 gems");
			else addButtonDisabled(12, "MechanicWrench", "Not enough gems.");
		}
		else addButtonDisabled(12, "MechanicWrench", "Already having this.");
		if (player.hasKeyItem("Engineer's Toolbox") < 0) {
			if (player.gems >= 100) addButton(13, "EngineersToolbox", lumiEngineeringBuySet2).hint("100 gems");
			else addButtonDisabled(13, "EngineersToolbox", "Not enough gems.");
		}
		else addButtonDisabled(13, "Engineer'sToolbox", "Already having this.");
		addButton(14, "Back", lumiLabChoices);
	}
	public function lumiEngineeringMechUpgrades():void {
		menu();
		if (player.hasKeyItem("Upgraded Armor plating 6.0") < 0 && player.hasKeyItem("Blueprint - Upgraded Armor plating 6.0") < 0) addButton(0, "UpgrArmor 6.0", lumiEngineeringBuyBlueprintUpgradedArmorPlating6).hint("Upgraded Armor plating 6.0 BP - 2500 gems");
		if (player.hasKeyItem("Upgraded Armor plating 5.0") < 0 && player.hasKeyItem("Upgraded Armor plating 6.0") < 0 && player.hasKeyItem("Blueprint - Upgraded Armor plating 5.0") < 0) addButton(0, "UpgrArmor 5.0", lumiEngineeringBuyBlueprintUpgradedArmorPlating5).hint("Upgraded Armor plating 5.0 BP - 2000 gems");
		if (player.hasKeyItem("Upgraded Armor plating 4.0") < 0 && player.hasKeyItem("Upgraded Armor plating 5.0") < 0 && player.hasKeyItem("Upgraded Armor plating 6.0") < 0 && player.hasKeyItem("Blueprint - Upgraded Armor plating 4.0") < 0) addButton(0, "UpgrArmor 4.0", lumiEngineeringBuyBlueprintUpgradedArmorPlating4).hint("Upgraded Armor plating 4.0 BP - 1500 gems");
		if (player.hasKeyItem("Upgraded Armor plating 3.0") < 0 && player.hasKeyItem("Upgraded Armor plating 4.0") < 0 && player.hasKeyItem("Upgraded Armor plating 5.0") < 0 && player.hasKeyItem("Upgraded Armor plating 6.0") < 0 && player.hasKeyItem("Blueprint - Upgraded Armor plating 3.0") < 0) addButton(0, "UpgrArmor 3.0", lumiEngineeringBuyBlueprintUpgradedArmorPlating3).hint("Upgraded Armor plating 3.0 BP - 1000 gems");
		if (player.hasKeyItem("Upgraded Armor plating 2.0") < 0 && player.hasKeyItem("Upgraded Armor plating 3.0") < 0 && player.hasKeyItem("Upgraded Armor plating 4.0") < 0 && player.hasKeyItem("Upgraded Armor plating 5.0") < 0 && player.hasKeyItem("Upgraded Armor plating 6.0") < 0 && player.hasKeyItem("Blueprint - Upgraded Armor plating 2.0") < 0) addButton(0, "UpgrArmor 2.0", lumiEngineeringBuyBlueprintUpgradedArmorPlating2).hint("Upgraded Armor plating 2.0 BP - 500 gems");
		if (player.hasKeyItem("Upgraded Armor plating 1.0") < 0 && player.hasKeyItem("Upgraded Armor plating 2.0") < 0 && player.hasKeyItem("Upgraded Armor plating 3.0") < 0 && player.hasKeyItem("Upgraded Armor plating 4.0") < 0 && player.hasKeyItem("Upgraded Armor plating 5.0") < 0 && player.hasKeyItem("Upgraded Armor plating 6.0") < 0 && player.hasKeyItem("Blueprint - Upgraded Armor plating 1.0") < 0) addButton(0, "UpgrArmor 1.0", lumiEngineeringBuyBlueprintUpgradedArmorPlating1).hint("Upgraded Armor plating 1.0 BP - 100 gems");
		if (player.hasKeyItem("Taser with an overcharged battery") < 0 && player.hasKeyItem("Blueprint - Taser with an overcharged battery") < 0) addButton(1, "Taser O.B.", lumiEngineeringBuyBlueprintTaserOverchargeBattery).hint("Taser overcharge battery BP - 1000 gems");
		if (player.hasKeyItem("Taser") < 0 && player.hasKeyItem("Taser with an overcharged battery") < 0 && player.hasKeyItem("Blueprint - Taser") < 0) addButton(1, "Taser", lumiEngineeringBuyBlueprintTaser).hint("Taser BP - 500 gems");
		if (player.hasKeyItem("Safety bubble") < 0 && player.hasKeyItem("Blueprint - Safety bubble") < 0) addButton(2, "Safety bubble", lumiEngineeringBuyBlueprintSafetyBubble).hint("Safety bubble BP - 100 gems");
		if (player.hasKeyItem("Dynapunch Glove") < 0 && player.hasKeyItem("Blueprint - Dynapunch Glove") < 0) addButton(3, "Dynapunch G.", curry(lumiEngineeringBuyBlueprintSharedPart, 500, "Dynapunch Glove")).hint("Dynapunch Glove BP - 500 gems");
		if (player.hasKeyItem("Medical Dispenser 2.0") < 0 && player.hasKeyItem("Blueprint - Medical Dispenser 2.0") < 0) addButton(4, "Medical Dispenser 2.0", curry(lumiEngineeringBuyBlueprintSharedPart, 500, "Medical Dispenser 2.0")).hint("Medical Dispenser 2.0 BP - 500 gems");
		if (player.hasKeyItem("Stimpack Dispenser 1.0") < 0 && player.hasKeyItem("Medical Dispenser 2.0") < 0 && player.hasKeyItem("Blueprint - Stimpack Dispenser 1.0") < 0) addButton(4, "Stimpack Dispenser 1.0", curry(lumiEngineeringBuyBlueprintSharedPart, 100, "Stimpack Dispenser 1.0")).hint("Stimpack Dispenser 1.0 BP - 100 gems");
		if (player.hasKeyItem("Omni Missile") < 0 && player.hasKeyItem("Blueprint - Omni Missile") < 0) addButton(5, "Omni Missile", curry(lumiEngineeringBuyBlueprintSharedPart, 1000, "Omni Missile")).hint("Omni Missile BP - 1000 gems");
		if (player.hasKeyItem("Missile launcher") < 0 && player.hasKeyItem("Omni Missile") < 0 && player.hasKeyItem("Blueprint - Missile launcher") < 0) addButton(5, "Missile launcher", curry(lumiEngineeringBuyBlueprintSharedPart, 500, "Missile launcher")).hint("Missile launcher BP - 500 gems");
		if (player.hasKeyItem("Lustnade Launcher") < 0 && player.hasKeyItem("Blueprint - Lustnade Launcher") < 0) addButton(6, "Lustnade Launcher", curry(lumiEngineeringBuyBlueprintSharedPart, 1000, "Lustnade Launcher")).hint("Lustnade Launcher BP - 1000 gems");
		if (player.hasKeyItem("Aphrodigas Gun") < 0 && player.hasKeyItem("Lustnade Launcher") < 0 && player.hasKeyItem("Blueprint - Aphrodigas Gun") < 0) addButton(6, "Aphrodigas Gun", curry(lumiEngineeringBuyBlueprintSharedPart, 100, "Aphrodigas Gun")).hint("Aphrodigas Gun BP - 10 gems");
		if (player.hasKeyItem("Impregnator 1.0") < 0 && player.hasKeyItem("Blueprint - Impregnator 1.0") < 0) addButton(7, "Impregnator 1.0", curry(lumiEngineeringBuyBlueprintSharedPart, 100, "Impregnator 1.0")).hint("Impregnator 1.0 BP - 100 gems");
		if (player.hasKeyItem("SPMK1") < 0 && player.hasKeyItem("Impregnator 1.0") < 0 && player.hasKeyItem("Blueprint - SPMK1") < 0) addButton(7, "SPMK1", curry(lumiEngineeringBuyBlueprintSharedPart, 100, "SPMK1")).hint("SPMK1 BP - 100 gems");
		if (player.hasKeyItem("Cum Reservoir") < 0 && player.hasKeyItem("SPMK1") < 0 && player.hasKeyItem("Impregnator 1.0") < 0 && player.hasKeyItem("Blueprint - Cum Reservoir") < 0) addButton(7, "Cum Reservoir", curry(lumiEngineeringBuyBlueprintSharedPart, 100, "Cum Reservoir")).hint("Cum Reservoir BP - 100 gems");
		if (player.hasKeyItem("MK2 Jetpack") < 0 && player.hasKeyItem("Blueprint - MK2 Jetpack") < 0) addButton(8, "MK2 Jetpack", curry(lumiEngineeringBuyBlueprintSharedPart, 500, "MK2 Jetpack")).hint("MK2 Jetpack BP - 500 gems");
		if (player.hasKeyItem("Jetpack") < 0 && player.hasKeyItem("MK2 Jetpack") < 0 && player.hasKeyItem("Blueprint - Jetpack") < 0) addButton(8, "Jetpack", curry(lumiEngineeringBuyBlueprintSharedPart, 100, "Jetpack")).hint("Jetpack BP - 100 gems");
		if (player.hasKeyItem("Improved Artificial Intelligence MK4") < 0 && player.hasKeyItem("Blueprint - Improved Artificial Intelligence MK4") < 0) addButton(9, "Improved AI MK4", curry(lumiEngineeringBuyBlueprintSharedPart, 2000, "Improved Artificial Intelligence MK4")).hint("Improved Artificial Intelligence MK4 BP - 2000 gems");
		if (player.hasKeyItem("Improved Artificial Intelligence MK3") < 0 && player.hasKeyItem("Improved Artificial Intelligence MK4") < 0 && player.hasKeyItem("Blueprint - Improved Artificial Intelligence MK3") < 0) addButton(9, "Improved AI MK3", curry(lumiEngineeringBuyBlueprintSharedPart, 1500, "Improved Artificial Intelligence MK3")).hint("Improved Artificial Intelligence MK3 BP - 1500 gems");
		if (player.hasKeyItem("Improved Artificial Intelligence MK2") < 0 && player.hasKeyItem("Improved Artificial Intelligence MK3") < 0 && player.hasKeyItem("Improved Artificial Intelligence MK4") < 0 && player.hasKeyItem("Blueprint - Improved Artificial Intelligence MK2") < 0) addButton(9, "Improved AI MK2", curry(lumiEngineeringBuyBlueprintSharedPart, 1000, "Improved Artificial Intelligence MK2")).hint("Improved Artificial Intelligence MK2 BP - 1000 gems");
		if (player.hasKeyItem("Improved Artificial Intelligence") < 0 && player.hasKeyItem("Improved Artificial Intelligence MK2") < 0 && player.hasKeyItem("Improved Artificial Intelligence MK3") < 0 && player.hasKeyItem("Improved Artificial Intelligence MK4") < 0 && player.hasKeyItem("Blueprint - Improved Artificial Intelligence") < 0) addButton(9, "Improved AI", curry(lumiEngineeringBuyBlueprintSharedPart, 500, "Improved Artificial Intelligence")).hint("Improved Artificial Intelligence BP - 500 gems");
		if (player.hasKeyItem("Artificial Intelligence") < 0 && player.hasKeyItem("Improved Artificial Intelligence") < 0 && player.hasKeyItem("Improved Artificial Intelligence MK2") < 0 && player.hasKeyItem("Improved Artificial Intelligence MK3") < 0 && player.hasKeyItem("Improved Artificial Intelligence MK4") < 0 && player.hasKeyItem("Blueprint - Artificial Intelligence") < 0) addButton(9, "AI", curry(lumiEngineeringBuyBlueprintSharedPart, 500, "Artificial Intelligence")).hint("Artificial Intelligence BP - 500 gems");
		if (player.hasKeyItem("Hydraulics MK6") < 0 && player.hasKeyItem("Blueprint - Hydraulics MK6") < 0) addButton(10, "Hydraulics MK6", curry(lumiEngineeringBuyBlueprintSharedPart, 3000, "Hydraulics MK6")).hint("Hydraulics MK6 BP - 3000 gems");
		if (player.hasKeyItem("Hydraulics MK5") < 0 && player.hasKeyItem("Hydraulics MK6") < 0 && player.hasKeyItem("Blueprint - Hydraulics MK5") < 0) addButton(10, "Hydraulics MK5", curry(lumiEngineeringBuyBlueprintSharedPart, 2500, "Hydraulics MK5")).hint("Hydraulics MK5 BP - 2500 gems");
		if (player.hasKeyItem("Hydraulics MK4") < 0 && player.hasKeyItem("Hydraulics MK5") < 0 && player.hasKeyItem("Hydraulics MK6") < 0 && player.hasKeyItem("Blueprint - Hydraulics MK4") < 0) addButton(10, "Hydraulics MK4", curry(lumiEngineeringBuyBlueprintSharedPart, 2000, "Hydraulics MK4")).hint("Hydraulics MK4 BP - 2000 gems");
		if (player.hasKeyItem("Hydraulics MK3") < 0 && player.hasKeyItem("Hydraulics MK4") < 0 && player.hasKeyItem("Hydraulics MK5") < 0 && player.hasKeyItem("Hydraulics MK6") < 0 && player.hasKeyItem("Blueprint - Hydraulics MK3") < 0) addButton(10, "Hydraulics MK3", curry(lumiEngineeringBuyBlueprintSharedPart, 1500, "Hydraulics MK3")).hint("Hydraulics MK3 BP - 1500 gems");
		if (player.hasKeyItem("Hydraulics MK2") < 0 && player.hasKeyItem("Hydraulics MK3") < 0 && player.hasKeyItem("Hydraulics MK4") < 0 && player.hasKeyItem("Hydraulics MK5") < 0 && player.hasKeyItem("Hydraulics MK6") < 0 && player.hasKeyItem("Blueprint - Hydraulics MK2") < 0) addButton(10, "Hydraulics MK2", curry(lumiEngineeringBuyBlueprintSharedPart, 1000, "Hydraulics MK2")).hint("Hydraulics MK2 BP - 1000 gems");
		if (player.hasKeyItem("Hydraulics") < 0 && player.hasKeyItem("Hydraulics MK2") < 0 && player.hasKeyItem("Hydraulics MK3") < 0 && player.hasKeyItem("Hydraulics MK4") < 0 && player.hasKeyItem("Hydraulics MK5") < 0 && player.hasKeyItem("Hydraulics MK6") < 0 && player.hasKeyItem("Blueprint - Hydraulics") < 0) addButton(10, "Hydraulics", curry(lumiEngineeringBuyBlueprintSharedPart, 500, "Hydraulics")).hint("Hydraulics BP - 500 gems");
		if (player.hasKeyItem("Improved Ammo Chemistry MK6") < 0 && player.hasKeyItem("Blueprint - Improved Ammo Chemistry MK6") < 0) addButton(11, "Improved Ammo Chemistry MK6", curry(lumiEngineeringBuyBlueprintSharedPart, 9000, "Improved Ammo Chemistry MK6")).hint("Improved Ammo Chemistry MK6 BP - 9000 gems");
		if (player.hasKeyItem("Improved Ammo Chemistry MK5") < 0 && player.hasKeyItem("Improved Ammo Chemistry MK6") < 0 && player.hasKeyItem("Blueprint - Improved Ammo Chemistry MK5") < 0) addButton(11, "Improved Ammo Chemistry MK5", curry(lumiEngineeringBuyBlueprintSharedPart, 7500, "Improved Ammo Chemistry MK5")).hint("Improved Ammo Chemistry MK5 BP - 7500 gems");
		if (player.hasKeyItem("Improved Ammo Chemistry MK4") < 0 && player.hasKeyItem("Improved Ammo Chemistry MK5") < 0 && player.hasKeyItem("Improved Ammo Chemistry MK6") < 0 && player.hasKeyItem("Blueprint - Improved Ammo Chemistry MK4") < 0) addButton(11, "Improved Ammo Chemistry MK4", curry(lumiEngineeringBuyBlueprintSharedPart, 6000, "Improved Ammo Chemistry MK4")).hint("Improved Ammo Chemistry MK4 BP - 6000 gems");
		if (player.hasKeyItem("Improved Ammo Chemistry MK3") < 0 && player.hasKeyItem("Improved Ammo Chemistry MK4") < 0 && player.hasKeyItem("Improved Ammo Chemistry MK5") < 0 && player.hasKeyItem("Improved Ammo Chemistry MK6") < 0 && player.hasKeyItem("Blueprint - Improved Ammo Chemistry MK3") < 0) addButton(11, "Improved Ammo Chemistry MK3", curry(lumiEngineeringBuyBlueprintSharedPart, 4500, "Improved Ammo Chemistry MK3")).hint("Improved Ammo Chemistry MK3 BP - 4500 gems");
		if (player.hasKeyItem("Improved Ammo Chemistry MK2") < 0 && player.hasKeyItem("Improved Ammo Chemistry MK3") < 0 && player.hasKeyItem("Improved Ammo Chemistry MK4") < 0 && player.hasKeyItem("Improved Ammo Chemistry MK5") < 0 && player.hasKeyItem("Improved Ammo Chemistry MK6") < 0 && player.hasKeyItem("Blueprint - Improved Ammo Chemistry MK2") < 0) addButton(11, "Improved Ammo Chemistry MK2", curry(lumiEngineeringBuyBlueprintSharedPart, 3000, "Improved Ammo Chemistry MK2")).hint("Improved Ammo Chemistry MK2 BP - 3000 gems");
		if (player.hasKeyItem("Improved Ammo Chemistry") < 0 && player.hasKeyItem("Improved Ammo Chemistry MK2") < 0 && player.hasKeyItem("Improved Ammo Chemistry MK3") < 0 && player.hasKeyItem("Improved Ammo Chemistry MK4") < 0 && player.hasKeyItem("Improved Ammo Chemistry MK5") < 0 && player.hasKeyItem("Improved Ammo Chemistry MK6") < 0 && player.hasKeyItem("Blueprint - Improved Ammo Chemistry") < 0) addButton(11, "Improved Ammo Chemistry", curry(lumiEngineeringBuyBlueprintSharedPart, 1500, "Improved Ammo Chemistry")).hint("Improved Ammo Chemistry BP - 1500 gems");
		addButton(13, "-2-", lumiEngineeringMechUpgrades2);
		addButton(14, "Back", lumiEngineering);
	}
	public function lumiEngineeringMechUpgrades2():void {
		menu();
		if (player.hasKeyItem("Machine Gun MK6") < 0 && player.hasKeyItem("Blueprint - Machine Gun MK6") < 0) addButton(0, "Machine Gun MK6", lumiEngineeringBuyBlueprintMachineGunMK6).hint("Machine Gun MK6 BP - 5000 gems");
		if (player.hasKeyItem("Machine Gun MK5") < 0 && player.hasKeyItem("Machine Gun MK6") < 0 && player.hasKeyItem("Blueprint - Machine Gun MK5") < 0) addButton(0, "Machine Gun MK5", lumiEngineeringBuyBlueprintMachineGunMK5).hint("Machine Gun MK5 BP - 4000 gems");
		if (player.hasKeyItem("Machine Gun MK4") < 0 && player.hasKeyItem("Machine Gun MK5") < 0 && player.hasKeyItem("Machine Gun MK6") < 0 && player.hasKeyItem("Blueprint - Machine Gun MK4") < 0) addButton(0, "Machine Gun MK4", lumiEngineeringBuyBlueprintMachineGunMK4).hint("Machine Gun MK4 BP - 3000 gems");
		if (player.hasKeyItem("Machine Gun MK3") < 0 && player.hasKeyItem("Machine Gun MK4") < 0 && player.hasKeyItem("Machine Gun MK5") < 0 && player.hasKeyItem("Machine Gun MK6") < 0 && player.hasKeyItem("Blueprint - Machine Gun MK3") < 0) addButton(0, "Machine Gun MK3", lumiEngineeringBuyBlueprintMachineGunMK3).hint("Machine Gun MK3 BP - 2000 gems");
		if (player.hasKeyItem("Machine Gun MK2") < 0 && player.hasKeyItem("Machine Gun MK3") < 0 && player.hasKeyItem("Machine Gun MK4") < 0 && player.hasKeyItem("Machine Gun MK5") < 0 && player.hasKeyItem("Machine Gun MK6") < 0 && player.hasKeyItem("Blueprint - Machine Gun MK2") < 0) addButton(0, "Machine Gun MK2", lumiEngineeringBuyBlueprintMachineGunMK2).hint("Machine Gun MK2 BP - 1000 gems");
		if (player.hasKeyItem("Machine Gun MK1") < 0 && player.hasKeyItem("Machine Gun MK2") < 0 && player.hasKeyItem("Machine Gun MK3") < 0 && player.hasKeyItem("Machine Gun MK4") < 0 && player.hasKeyItem("Machine Gun MK5") < 0 && player.hasKeyItem("Machine Gun MK6") < 0 && player.hasKeyItem("Blueprint - Machine Gun MK1") < 0) addButton(0, "Machine Gun MK1", lumiEngineeringBuyBlueprintMachineGunMK1).hint("Machine Gun MK1 BP - 500 gems");
		if (player.hasKeyItem("Repeater Gun") < 0 && player.hasKeyItem("Machine Gun MK1") < 0 && player.hasKeyItem("Machine Gun MK2") < 0 && player.hasKeyItem("Machine Gun MK3") < 0 && player.hasKeyItem("Machine Gun MK4") < 0 && player.hasKeyItem("Machine Gun MK5") < 0 && player.hasKeyItem("Machine Gun MK6") < 0 && player.hasKeyItem("Blueprint - Repeater Gun") < 0) addButton(0, "Repeater Gun", lumiEngineeringBuyBlueprintRepeaterGun).hint("Repeater Gun BP - 100 gems");
		if (player.hasKeyItem("Whitefire Beam Cannon") < 0 && player.hasKeyItem("Blueprint - Whitefire Beam Cannon") < 0) addButton(1, "Whitefire B.C.", curry(lumiEngineeringBuyBlueprintSharedPart, 1000, "Whitefire Beam Cannon")).hint("Whitefire Beam Cannon BP - 1000 gems");
		if (player.hasKeyItem("Snowball Generator") < 0 && player.hasKeyItem("Blueprint - Snowball Generator") < 0) addButton(2, "Snowball G.", curry(lumiEngineeringBuyBlueprintSharedPart, 1000, "Snowball Generator")).hint("Snowball Generator BP - 1000 gems");
		if (player.hasKeyItem("Raijin blaster") < 0 && player.hasKeyItem("Blueprint - Raijin blaster") < 0 && player.hasKeyItem("Taser with an overcharged battery") >= 0) addButton(3, "Raijin blaster", curry(lumiEngineeringBuyBlueprintSharedPart, 1500, "Raijin blaster")).hint("Raijin blaster BP - 1500 gems");
		if (player.hasKeyItem("Gravity shots") < 0 && player.hasKeyItem("Blueprint - Gravity shots") < 0 && player.hasKeyItem("MK2 Jetpack") >= 0) addButton(4, "Gravity shots", curry(lumiEngineeringBuyBlueprintSharedPart, 1000, "Gravity shots")).hint("Gravity shots - 1000 gems");
		if (player.hasKeyItem("Auto turret MK6") < 0 && player.hasKeyItem("Blueprint - Auto turret MK6") < 0) addButton(5, "Auto turret MK6", curry(lumiEngineeringBuyBlueprintSharedPart, 3000, "Auto turret MK6")).hint("Auto turret MK6 BP - 3000 gems");
		if (player.hasKeyItem("Auto turret MK5") < 0 && player.hasKeyItem("Auto turret MK6") < 0 && player.hasKeyItem("Blueprint - Auto turret MK5") < 0) addButton(5, "Auto turret MK5", curry(lumiEngineeringBuyBlueprintSharedPart, 2500, "Auto turret MK5")).hint("Auto turret MK5 BP - 2500 gems");
		if (player.hasKeyItem("Auto turret MK4") < 0 && player.hasKeyItem("Auto turret MK5") < 0 && player.hasKeyItem("Auto turret MK6") < 0 && player.hasKeyItem("Blueprint - Auto turret MK4") < 0) addButton(5, "Auto turret MK4", curry(lumiEngineeringBuyBlueprintSharedPart, 2000, "Auto turret MK4")).hint("Auto turret MK4 BP - 2000 gems");
		if (player.hasKeyItem("Auto turret MK3") < 0 && player.hasKeyItem("Auto turret MK4") < 0 && player.hasKeyItem("Auto turret MK5") < 0 && player.hasKeyItem("Auto turret MK6") < 0 && player.hasKeyItem("Blueprint - Auto turret MK3") < 0) addButton(5, "Auto turret MK3", curry(lumiEngineeringBuyBlueprintSharedPart, 1500, "Auto turret MK3")).hint("Auto turret MK3 BP - 1500 gems");
		if (player.hasKeyItem("Auto turret MK2") < 0 && player.hasKeyItem("Auto turret MK3") < 0 && player.hasKeyItem("Auto turret MK4") < 0 && player.hasKeyItem("Auto turret MK5") < 0 && player.hasKeyItem("Auto turret MK6") < 0 && player.hasKeyItem("Blueprint - Auto turret MK2") < 0) addButton(5, "Auto turret MK2", curry(lumiEngineeringBuyBlueprintSharedPart, 1000, "Auto turret MK2")).hint("Auto turret MK2 BP - 1000 gems");
		if (player.hasKeyItem("Auto turret") < 0 && player.hasKeyItem("Auto turret MK2") < 0 && player.hasKeyItem("Auto turret MK3") < 0 && player.hasKeyItem("Auto turret MK4") < 0 && player.hasKeyItem("Auto turret MK5") < 0 && player.hasKeyItem("Auto turret MK6") < 0 && player.hasKeyItem("Blueprint - Auto turret") < 0) addButton(5, "Auto turret", curry(lumiEngineeringBuyBlueprintSharedPart, 500, "Auto turret")).hint("Auto turret BP - 500 gems");
		addButton(14, "Back", lumiEngineeringMechUpgrades);
	}
	public function lumiEngineeringBuyBlueprintToolbelt():void {
		clearOutput();
		if (player.gems >= 100) {
			player.gems -= 100;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Toolbelt!</b>");
			player.createKeyItem("Blueprint - Toolbelt", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintPotentDrugInjectors():void {
		clearOutput();
		if (player.gems >= 1000) {
			player.gems -= 1000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Potent Drug injectors!</b>");
			player.createKeyItem("Blueprint - Potent Drug injectors", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintImprovedDrugInjectors():void {
		clearOutput();
		if (player.gems >= 500) {
			player.gems -= 500;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Improved Drug injectors!</b>");
			player.createKeyItem("Blueprint - Improved Drug injectors", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintDrugInjectors():void {
		clearOutput();
		if (player.gems >= 100) {
			player.gems -= 100;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Drug injectors!</b>");
			player.createKeyItem("Blueprint - Drug injectors", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintGunScopeWithAimbot():void {
		clearOutput();
		if (player.gems >= 1000) {
			player.gems -= 1000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Gun Scope with Aimbot!</b>");
			player.createKeyItem("Blueprint - Gun Scope with Aimbot", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintGunScopeWithAimTech():void {
		clearOutput();
		if (player.gems >= 500) {
			player.gems -= 500;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Gun Scope with Aim tech!</b>");
			player.createKeyItem("Blueprint - Gun Scope with Aim tech", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintGunScope():void {
		clearOutput();
		if (player.gems >= 100) {
			player.gems -= 100;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Gun Scope!</b>");
			player.createKeyItem("Blueprint - Gun Scope", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintSATechGoggle():void {
		clearOutput();
		if (player.gems >= 1000) {
			player.gems -= 1000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - S.A Tech Goggle!</b>");
			player.createKeyItem("Blueprint - S.A Tech Goggle", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintScannerGoggle():void {
		clearOutput();
		if (player.gems >= 500) {
			player.gems -= 500;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Scanner goggle!</b>");
			player.createKeyItem("Blueprint - Scanner goggle", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintMachinistGoggles():void {
		clearOutput();
		if (player.gems >= 100) {
			player.gems -= 100;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Machinist Goggles!</b>");
			player.createKeyItem("Blueprint - Machinist Goggles", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintNitroBoots():void {
		clearOutput();
		if (player.gems >= 1000) {
			player.gems -= 1000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Nitro Boots!</b>");
			player.createKeyItem("Blueprint - Nitro Boots", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintRocketBoots():void {
		clearOutput();
		if (player.gems >= 500) {
			player.gems -= 500;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Rocket Boots!</b>");
			player.createKeyItem("Blueprint - Rocket Boots", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintSpringBoots():void {
		clearOutput();
		if (player.gems >= 100) {
			player.gems -= 100;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Spring Boots!</b>");
			player.createKeyItem("Blueprint - Spring Boots", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintMGSBracer():void {
		clearOutput();
		if (player.gems >= 1000) {
			player.gems -= 1000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - M.G.S. bracer!</b>");
			player.createKeyItem("Blueprint - M.G.S. bracer", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintPowboy():void {
		clearOutput();
		if (player.gems >= 500) {
			player.gems -= 500;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Powboy!</b>");
			player.createKeyItem("Blueprint - Powboy", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintPowerBracer():void {
		clearOutput();
		if (player.gems >= 100) {
			player.gems -= 100;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Power bracer!</b>");
			player.createKeyItem("Blueprint - Power bracer", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintRipper2():void {
		clearOutput();
		if (player.gems >= 1000) {
			player.gems -= 1000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Ripper 2.0!</b>");
			player.createKeyItem("Blueprint - Ripper 2.0", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintRipper1():void {
		clearOutput();
		if (player.gems >= 500) {
			player.gems -= 500;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Ripper 1.0!</b>");
			player.createKeyItem("Blueprint - Ripper 1.0", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintMachinedGreatsword():void {
		clearOutput();
		if (player.gems >= 100) {
			player.gems -= 100;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Machined greatsword!</b>");
			player.createKeyItem("Blueprint - Machined greatsword", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintMachinedSpear():void {
		clearOutput();
		if (player.gems >= 100) {
			player.gems -= 100;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Machined spear!</b>");
			player.createKeyItem("Blueprint - Machined spear", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintUpgradedArmorPlating6():void {
		clearOutput();
		if (player.gems >= 2500) {
			player.gems -= 2500;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Upgraded Armor plating 6.0!</b>");
			player.createKeyItem("Blueprint - Upgraded Armor plating 6.0", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintUpgradedArmorPlating5():void {
		clearOutput();
		if (player.gems >= 2000) {
			player.gems -= 2000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Upgraded Armor plating 5.0!</b>");
			player.createKeyItem("Blueprint - Upgraded Armor plating 5.0", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintUpgradedArmorPlating4():void {
		clearOutput();
		if (player.gems >= 1500) {
			player.gems -= 1500;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Upgraded Armor plating 4.0!</b>");
			player.createKeyItem("Blueprint - Upgraded Armor plating 4.0", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintUpgradedArmorPlating3():void {
		clearOutput();
		if (player.gems >= 1000) {
			player.gems -= 1000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Upgraded Armor plating 3.0!</b>");
			player.createKeyItem("Blueprint - Upgraded Armor plating 3.0", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintUpgradedArmorPlating2():void {
		clearOutput();
		if (player.gems >= 500) {
			player.gems -= 500;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Upgraded Armor plating 2.0!</b>");
			player.createKeyItem("Blueprint - Upgraded Armor plating 2.0", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintUpgradedArmorPlating1():void {
		clearOutput();
		if (player.gems >= 100) {
			player.gems -= 100;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Upgraded Armor plating 1.0!</b>");
			player.createKeyItem("Blueprint - Upgraded Armor plating 1.0", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintTaserOverchargeBattery():void {
		clearOutput();
		if (player.gems >= 1000) {
			player.gems -= 1000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Taser with an overcharged battery!</b>");
			player.createKeyItem("Blueprint - Taser with an overcharged battery", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintTaser():void {
		clearOutput();
		if (player.gems >= 500) {
			player.gems -= 500;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Taser!</b>");
			player.createKeyItem("Blueprint - Taser", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintSafetyBubble():void {
		clearOutput();
		if (player.gems >= 100) {
			player.gems -= 100;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Safety bubble!</b>");
			player.createKeyItem("Blueprint - Safety bubble", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintMachineGunMK6():void {
		clearOutput();
		if (player.gems >= 5000) {
			player.gems -= 5000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Machine Gun MK6!</b>");
			player.createKeyItem("Blueprint - Machine Gun MK6", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintMachineGunMK5():void {
		clearOutput();
		if (player.gems >= 4000) {
			player.gems -= 4000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Machine Gun MK5!</b>");
			player.createKeyItem("Blueprint - Machine Gun MK5", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintMachineGunMK4():void {
		clearOutput();
		if (player.gems >= 3000) {
			player.gems -= 3000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Machine Gun MK4!</b>");
			player.createKeyItem("Blueprint - Machine Gun MK4", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintMachineGunMK3():void {
		clearOutput();
		if (player.gems >= 2000) {
			player.gems -= 2000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Machine Gun MK3!</b>");
			player.createKeyItem("Blueprint - Machine Gun MK3", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintMachineGunMK2():void {
		clearOutput();
		if (player.gems >= 1000) {
			player.gems -= 1000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Machine Gun MK2!</b>");
			player.createKeyItem("Blueprint - Machine Gun MK2", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintMachineGunMK1():void {
		clearOutput();
		if (player.gems >= 500) {
			player.gems -= 500;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Machine Gun MK1!</b>");
			player.createKeyItem("Blueprint - Machine Gun MK1", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
		//curry(lumiEngineeringBuyBlueprintSharedPart, 50, "Mechanism")
	}
	public function lumiEngineeringBuyBlueprintRepeaterGun():void {
		clearOutput();
		if (player.gems >= 100) {
			player.gems -= 100;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Repeater Gun!</b>");
			player.createKeyItem("Blueprint - Repeater Gun", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
		//curry(lumiEngineeringBuyBlueprintSharedPart, 100, "Repeater Gun")
	}
	//
	public function lumiEngineeringBuyBlueprintSharedPart(cost:Number, itemName:String):void {
		clearOutput();
		if (player.gems >= cost) {
			player.gems -= cost;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - "+itemName+"!</b>");
			player.createKeyItem("Blueprint - "+itemName+"", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintNotEnoughGems():void {
		outputText("You would like to buy this item but you're short on gems...\n\n");
		outputText("\"<i>Forry friend but I don't give my fhings far free. Ya get the gems you need then come back here ta buy it.</i>\"\n\n");
		doNext(lumiEngineering);
	}
	public function lumiEngineeringBuyMetalPieces():void {
		clearOutput();
		outputText("\"<i>Metal plate ya say? Ya it'l only be 100 gems each hun.</i>\"\n\n");
		/*if (CampStatsAndResources.MaterialsStorageUpgrade >= 3) {
			outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WCAMP_CABIN_METAL_PIECES_RESOURCESOOD_RESOURCES] + "/600")
		}
		else if (CampStatsAndResources.MaterialsStorageUpgrade < 3) {*/
			outputText("Metal Pieces: " + CampStatsAndResources.MetalPieces + "/200");
		//}
		menu();
		if (player.gems >= 100) addButton(0, "Buy 1", lumiEngineeringBuyMetalPiecesAmount, 1);
		else addButtonDisabled(0, "Buy 1", "Not enough gems.");
		if (player.gems >= 500) addButton(1, "Buy 5", lumiEngineeringBuyMetalPiecesAmount, 5);
		else addButtonDisabled(1, "Buy 5", "Not enough gems.");
		if (player.gems >= 1000) addButton(2, "Buy 10", lumiEngineeringBuyMetalPiecesAmount, 10);
		else addButtonDisabled(2, "Buy 10", "Not enough gems.");
		if (player.gems >= 1500) addButton(3, "Buy 15", lumiEngineeringBuyMetalPiecesAmount, 15);
		else addButtonDisabled(3, "Buy 15", "Not enough gems.");
		if (player.gems >= 2000) addButton(4, "Buy 20", lumiEngineeringBuyMetalPiecesAmount, 20);
		else addButtonDisabled(4, "Buy 20", "Not enough gems.");
		addButton(14, "Back", lumiEngineering);
	}
	private function lumiEngineeringBuyMetalPiecesAmount(amount:int):void {
		metal_pieces = amount;
		clearOutput();
		player.gems -= (metal_pieces * 100);
		//flags[kFLAGS.ACHIEVEMENT_PROGRESS_IM_NO_LUMBERJACK] += metal_pieces;
		//if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_IM_NO_LUMBERJACK] >= 100) awardAchievement("I'm No Lumberjack", kACHIEVEMENTS.GENERAL_IM_NO_LUMBERJACK);
		CampStatsAndResources.MetalPieces += metal_pieces;
		outputText("Lumi get you a box of those from her backroom.\n\n\"<i>Ta craft stuff ya need metal fortunately fer you I got plenty of dese.</i>\"\n\n");
		/*if (CampStatsAndResources.MetalPieces > 600 && CampStatsAndResources.MaterialsStorageUpgrade >= 3) {
			outputText("Unfortunately, your metal pieces supply seem to be full. You inform her. She refunds you the gems.\n\n");
			player.gems += ((CampStatsAndResources.MetalPieces - 600) * 200);
			CampStatsAndResources.MetalPieces -= (CampStatsAndResources.MetalPieces - 600);
			outputText("Metal Pieces: " + CampStatsAndResources.MetalPieces + "/600");
		}
		else */if (CampStatsAndResources.MetalPieces > 200) {// && CampStatsAndResources.MaterialsStorageUpgrade < 3
			outputText("Unfortunately, your metal pieces supply seem to be full. You inform her. She refunds you the gems.\n\n");
			player.gems += ((CampStatsAndResources.MetalPieces - 200) * 100);
			CampStatsAndResources.MetalPieces -= (CampStatsAndResources.MetalPieces - 200);
			outputText("Metal Pieces: " + CampStatsAndResources.MetalPieces + "/200");
		}
		statScreenRefresh();
		doNext(lumiEngineeringBuyMetalPieces);
	}
	public function lumiEngineeringBuySet1():void {
		clearOutput();
		player.gems -= 50;
		outputText("Lumi shrugs.\n\n");
		outputText("\"<i>I'm surprised ya don'f gat one of dese already. Its used in next to everything in everyday goblin life. Y'all need one to craft anything of note.</i>\"\n\n");
		outputText("<b>Gained Key Item: Mechanic's Wrench!</b>");
		player.createKeyItem("Mechanic's Wrench", 0, 0, 0, 0);
		statScreenRefresh();
		doNext(lumiEngineering);
	}
	public function lumiEngineeringBuySet2():void {
		clearOutput();
		player.gems -= 100;
		outputText("Lumi shrugs.\n\n");
		outputText("\"<i>'m surprised ya don'f gat one of dese already. Yall need one to craft.</i>\"\n\n");
		outputText("<b>Gained Key Item: Engineer's Toolbox!</b>");
		player.createKeyItem("Engineer's Toolbox", 0, 0, 0, 0);
		statScreenRefresh();
		doNext(lumiEngineering);
	}
	
	public function lumiWorkshop():void {
		if (player.isGoblinoid(false)) {
			clearOutput();
			if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) {
				outputText("You reply that you're here to perform some tinkering of your own.\n\n");
				if (player.statusEffectv1(StatusEffects.PCDaughtersWorkshop) > 1) outputText("\"<i>Well sure Ma, we left your work desk untouched so anything you may have started is still there.</i>\"\n\n");
				else {
					outputText("\"<i>Just pick any work desk you want Mom, we’re all looking forward to see what ya'll create.</i>\"\n\n");
					player.addStatusValue(StatusEffects.PCDaughtersWorkshop, 1, 2);
				}
				outputText("You wave her a 'See you later' then move over to your table. Time to get to work.\n\n");
			}
			else {
				if (player.statusEffectv1(StatusEffects.LumiWorkshop) > 0) {
					outputText("\"<i>Well sure I laft yer worf desk untouched so anything ya may have started is ftill there.</i>\"\n\n");
					outputText("Lumi hands you a key and you use it to get inside the workshop.\n\n");
				}
				else {
					outputText("\"<i>Ga ahead then, jast don’t break anyfhing that is not yours. Ya may use da table in the left corner though obviously ya use yer own tools and materials, nof mines.</i>\"\n\n");
					outputText("Lumi hands you a key and you use it to get inside the workshop. It’s actually neat inside with ample space to craft. As told you find a work desk on the left which will likely be where you will make most of your contraptions. There is even the proper area to park your mech for upgrades.\n\n");
					player.addStatusValue(StatusEffects.LumiWorkshop,1,1);
				}
			}
			SceneLib.camp.campUpgrades.checkMaterials();
			outputText("Metal Pieces: " + CampStatsAndResources.MetalPieces + "/200" + "\n");
			outputText("Mechanisms: " + CampStatsAndResources.MechanismResc + "/200" + "\n");
			outputText("Energy Cores: " + CampStatsAndResources.EnergyCoreResc + "/200" + "\n");
			outputText("\nWhich blueprints will you work on today?\n\n");
			if (player.hasKeyItem("Blueprint - Potent Drug injectors") >= 0) outputText("Potent Drug injectors - Req. 100+ int, Improved Drug injectors, 3 metal pieces, 30 nails, 15 Lust Drafts.\n");
			if (player.hasKeyItem("Blueprint - Improved Drug injectors") >= 0) outputText("Improved Drug injectors - Req. 75+ int, Drug injectors, 2 metal pieces, 20 nails, 10 Lust Drafts.\n");
			if (player.hasKeyItem("Blueprint - Drug injectors") >= 0) outputText("Drug injectors - Req. 50+ int, Toolbelt, 1 metal piece, 10 nails, 5 Lust Drafts.\n");
			if (player.hasKeyItem("Blueprint - Gun Scope with Aimbot") >= 0) outputText("Gun Scope with Aimbot - Req. 100+ int, Toolbelt, 10 metal pieces, 500 nails, 1 energy core.\n");
			if (player.hasKeyItem("Blueprint - Gun Scope with Aim tech") >= 0) outputText("Gun Scope with Aim tech - Req. 75+ int, Gun Scope, 5 metal pieces, 300 nails.\n");
			if (player.hasKeyItem("Blueprint - Gun Scope") >= 0) outputText("Gun Scope - Req. 50+ int, Toolbelt, 1 metal piece, 100 nails.\n");
			if (player.hasKeyItem("Blueprint - Nitro Boots") >= 0) outputText("Nitro Boots - Req. 100+ int, Rocket Boots, 15 metal pieces, 300 nails, 3 mechanism, 5 firemander whiskey.\n");
			if (player.hasKeyItem("Blueprint - Rocket Boots") >= 0) outputText("Rocket Boots - Req. 75+ int, Spring Boots, 10 metal pieces, 200 nails, 1 firemander whiskey, 2 mechanism.\n");
			if (player.hasKeyItem("Blueprint - Spring Boots") >= 0) outputText("Spring Boots - Req. 50+ int, Toolbelt, 5 metal pieces, 100 nails, 1 mechanism.\n");
			if (player.hasKeyItem("Blueprint - M.G.S. bracer") >= 0) outputText("M.G.S. bracer - Req. 100+ int, Powboy, 10 metal pieces, 500 nails, 4 energy core.\n");
			if (player.hasKeyItem("Blueprint - Powboy") >= 0) outputText("Powboy - Req. 75+ int, Power bracer, 5 metal pieces, 200 nails, 1 energy core.\n");
			if (player.hasKeyItem("Blueprint - Power bracer") >= 0) outputText("Power bracer - Req. 50+ int, any Drug injector, 3 metal pieces, 100 nails, 1 energy core.\n");
			menu();
			if (player.hasKeyItem("Blueprint - Energy Core") >= 0 && CampStatsAndResources.MetalPieces >= 5 && player.hasItem(useables.GOLCORE, 4)) {
				if (CampStatsAndResources.EnergyCoreResc >= 200) addButtonDisabled(0, "Energy Core", "Your storage for energy cores is full.");
				else addButton(0, "Energy Core", lumiWorkshopEnergyCore).hint("Energy Core - A power source for devices. Necessary for advanced engineering - 4 golem cores, 5 metal piece, 4 hours of work.");
			}
			else addButtonDisabled(0, "Energy Core", "Req. 4 golem cores, 5 metal piece.");
			if (player.hasKeyItem("Blueprint - Mechanism") >= 0 && CampStatsAndResources.MetalPieces >= 5 && CampStatsAndResources.NailsResc >= 200) {
				if (CampStatsAndResources.MechanismResc >= 200) addButtonDisabled(1, "Mechanism", "Your storage for mechanisms is full.");
				else addButton(1, "Mechanism", lumiWorkshopMechanism).hint("Mechanism - A complex set of gear and gyro. Necessary for advanced engineering - 200 nails, 5 metal piece, 4 hours of work.");
			}
			else addButtonDisabled(1, "Mechanism", "Req. 200 nails, 5 metal piece.");
			if (player.hasKeyItem("Blueprint - Toolbelt") >= 0 && player.inte >= 25 && CampStatsAndResources.MetalPieces >= 1) addButton(2, "Toolbelt", lumiWorkshopToolbelt).hint("Toolbelt - A toolbelt to hang your various engineering tool such as arclight spanner and screwdrivers. To wear around the waist. Necessary for basic engineering - 25+ int, 1 metal piece, 4 hours of work.");
			else addButtonDisabled(2, "Toolbelt", "Req. 25+ Int, 1 metal piece.");
			if (player.hasKeyItem("Blueprint - Potent Drug injectors") >= 0 && player.inte >= 100 && player.hasKeyItem("Improved Drug injectors") >= 0 && CampStatsAndResources.MetalPieces >= 3 && CampStatsAndResources.NailsResc >= 30 && player.hasItem(consumables.L_DRAFT, 15)) addButton(3, "P.D.Injectors", lumiWorkshopPotentDrugInjectors).hint("Potent Drug injectors - Improve the toolbelt with an even better drug injector to wear around your waist. Makes you hornier and slutier at all time thanks to the chemicals but at the same time raise your sensitivity. This improved version is even more potent - 100+ int, Improved Drug injectors, 3 metal pieces, 30 nails, 15 Lust Drafts, 12 hours of work");
			if (player.hasKeyItem("Blueprint - Improved Drug injectors") >= 0 && player.hasKeyItem("Drug injectors") >= 0 && player.inte >= 75 && CampStatsAndResources.MetalPieces >= 2 && CampStatsAndResources.NailsResc >= 20 && player.hasItem(consumables.L_DRAFT, 10)) addButton(3, "I.D.Injectors", lumiWorkshopImprovedDrugInjectors).hint("Improved Drug injectors - Improve the toolbelt with a better drug injector to wear around your waist. Makes you hornier and slutier at all time thanks to the chemicals but at the same time raise your sensitivity. This improved version is more potent - 75+ int, Drug injectors, 2 metal pieces, 20 nails, 10 Lust Drafts, 8 hours of work");
			if (player.hasKeyItem("Blueprint - Drug injectors") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && CampStatsAndResources.MetalPieces >= 1 && CampStatsAndResources.NailsResc >= 10 && player.hasItem(consumables.L_DRAFT, 5)) addButton(3, "D,Injectors", lumiWorkshopDrugInjectors).hint("Drug injectors - Improve the toolbelt with a drug injector to wear around your waist. Makes you hornier and slutier at all time thanks to the chemicals but at the same time raise your sensitivity - 50+ int, Toolbelt, 1 metal piece, 10 nails, 5 Lust Drafts, 4 hours of work");
			if (player.hasKeyItem("Blueprint - Gun Scope with Aimbot") >= 0 && player.hasKeyItem("Gun Scope with Aim tech") >= 0 && player.inte >= 100 && CampStatsAndResources.MetalPieces >= 10 && CampStatsAndResources.NailsResc >= 500 && CampStatsAndResources.EnergyCoreResc >= 1) addButton(4, "G.S./w Aimbot", lumiWorkshopGunScopeWithAimbot).hint("Gun Scope with Aimbot - A scope to attach to your gun for improved lethality. Increase damage and accuracy by 40% - 100+ int, Toolbelt, 10 metal pieces, 500 nails, 1 energy core and 12 hour work");
			if (player.hasKeyItem("Blueprint - Gun Scope with Aim tech") >= 0 && player.hasKeyItem("Gun Scope") >= 0 && player.inte >= 75 && CampStatsAndResources.MetalPieces >= 5 && CampStatsAndResources.NailsResc >= 300) addButton(4, "G.S./w Aim tech", lumiWorkshopGunScopeWithAimTech).hint("Gun Scope with Aim tech - A scope to attach to your gun for improved lethality. Increase damage and accuracy by 30% - 75+ int, Gun Scope, 5 metal pieces, 300 nails, 8 hours of work");
			if (player.hasKeyItem("Blueprint - Gun Scope") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && CampStatsAndResources.MetalPieces >= 1 && CampStatsAndResources.NailsResc >= 100) addButton(4, "Gun Scope", lumiWorkshopGunScope).hint("Gun Scope - A scope to attach to your gun for improved lethality. Increase damage and accuracy by 20% - 50+ int, Toolbelt, 1 metal piece, 100 nails, 4 hours of work");
			if (player.hasKeyItem("Blueprint - Machinist Goggles") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && CampStatsAndResources.MetalPieces >= 1 && CampStatsAndResources.NailsResc >= 100) addButton(5, "Mach.Goggles", lumiWorkshopMachinistGoggles).hint("Machinist Goggles - A pair of ordinary machinist goggles. One of the basic tools of anyone working with engine. Helps prevent blindness - 50+ int, Toolbelt, 1 metal piece, 100 nails, 4 hours of work");
			else addButtonDisabled(5, "Mach.Goggles", "Req. 50+ int, Toolbelt, 1 metal piece, 100 nails.");
			if (player.hasKeyItem("Blueprint - Scanner goggle") >= 0 && player.inte >= 75 && CampStatsAndResources.MetalPieces >= 5 && CampStatsAndResources.NailsResc >= 200 && CampStatsAndResources.EnergyCoreResc >= 2 && player.hasItem(headjewelries.MACHGOG, 1)) addButton(6, "Scan.goggles", lumiWorkshopScannerGoggle).hint("Scanner goggle - This set of goggles naturally include a user interface and a scanner revealing information about your opponents - 75+ int, Machinist Goggles, 5 metal pieces, 200 nails, 2 energy core, 8 hours of work");
			else addButtonDisabled(6, "Scan.goggles", "Req. 75+ int, Machinist Goggles, 5 metal pieces, 200 nails, 2 energy core.");
			if (player.hasKeyItem("Blueprint - S.A Tech Goggle") >= 0 && player.inte >= 100 && CampStatsAndResources.MetalPieces >= 10 && CampStatsAndResources.NailsResc >= 300 && CampStatsAndResources.EnergyCoreResc >= 5 && player.hasItem(headjewelries.SCANGOG, 1)) addButton(7, "S.A.T.Goggles", lumiWorkshopSATechGoggle).hint("S.A Tech Goggles - Better than its previous iteration the Scanner goggles, the tech goggles actually also reveal opponent's flaws and weaknesses highlighting their vulnerability in red within the goggles' glass. The fact it also has a complete logbook and access to previous encounter information also helps catalogise foes weaknesses - 100+ int, Scanner goggles, 10 metal pieces, 300 nails, 5 energy core, 12 hours of work");
			else addButtonDisabled(7, "S.A.T.Goggles", "Req. 100+ int, Scanner goggles, 10 metal pieces, 300 nails, 5 energy core.");
			if (player.hasKeyItem("Blueprint - Nitro Boots") >= 0 && player.inte >= 100 && player.hasKeyItem("Rocket Boots") >= 0 && CampStatsAndResources.MetalPieces >= 15 && CampStatsAndResources.NailsResc >= 300 && CampStatsAndResources.MechanismResc >= 3 && player.hasItem(consumables.SALAMFW, 5)) addButton(8, "Nitro Boots", lumiWorkshopNitroBoots).hint("Nitro Boots - This device allows you to increase your movement speed with nitro rockets. Also can be used to kick people in the face leaving some serious burns and even setting people on fire - 100+ int, Rocket Boots, 15 metal pieces, 300 nails, 3 mechanism, 5 salamander firewaters, 12 hours of work");
			if (player.hasKeyItem("Blueprint - Rocket Boots") >= 0 && player.inte >= 75 && player.hasKeyItem("Spring Boots") >= 0 && CampStatsAndResources.MetalPieces >= 10 && CampStatsAndResources.NailsResc >= 200 && CampStatsAndResources.MechanismResc >= 2 && player.hasItem(consumables.SALAMFW, 1)) addButton(8, "Rocket Boots", lumiWorkshopRocketBoots).hint("Rocket Boots - This device allows you to increase your movement speed with rockets. Also can be used to kick people in the face - 75+ int, Spring Boots, 10 metal pieces, 200 nails, 1 salamander firewater, 2 mechanism, 8 hours of work");
			if (player.hasKeyItem("Blueprint - Spring Boots") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && CampStatsAndResources.MetalPieces >= 5 && CampStatsAndResources.NailsResc >= 100 && CampStatsAndResources.MechanismResc >= 1) addButton(8, "Spring Boots", lumiWorkshopSpringBoots).hint("Spring Boots - This device allows you to increase your movement speed with springs - 50+ int, Toolbelt, 5 metal pieces, 100 nails, 1 mechanism, 4 hours of work");
			if (player.hasKeyItem("Blueprint - M.G.S. bracer") >= 0 && player.inte >= 100 && player.hasKeyItem("Powboy") >= 0 && CampStatsAndResources.MetalPieces >= 10 && CampStatsAndResources.NailsResc >= 300 && CampStatsAndResources.EnergyCoreResc >= 4) addButton(9, "M.G.S. bracer", lumiWorkshopMGSBracer).hint("M.G.S. bracer - The Mega Goblin Super bracer increases your physical strength by injecting " + (silly() ? "nanomachine" : "drugs") + " whenever needed, which reacts in your goblin blood and may even repair damaged tissue. Furthermore it is equipped with a mighty energy shield that works as long as you are not using any armor. And lastly, it actually tells the hour of the day - 100+ int, Powboy, 10 metal pieces, 500 nails, 4 energy core, 12 hours of work");
			if (player.hasKeyItem("Blueprint - Powboy") >= 0 && player.inte >= 75 && player.hasKeyItem("Power bracer") >= 0 && CampStatsAndResources.MetalPieces >= 5 && CampStatsAndResources.NailsResc >= 200 && CampStatsAndResources.EnergyCoreResc >= 1) addButton(9, "Powboy", lumiWorkshopPowboy).hint("Powboy - This bracer increases your physical strength by injecting drugs which reacts in your goblin blood. Furthermore it is equipped with an energy shield that works as long as you are not using any armor. And lastly, it actually tells the hour of the day. Like all drugs, also increases sensitivity - 75+ int, Power bracer, 5 metal pieces, 200 nails, 1 energy core, 8 hours of work");
			if (player.hasKeyItem("Blueprint - Power bracer") >= 0 && (player.hasKeyItem("Drug injectors") >= 0 || player.hasKeyItem("Improved Drug injectors") >= 0 || player.hasKeyItem("Potent Drug injectors") >= 0) && player.inte >= 50 && CampStatsAndResources.MetalPieces >= 3 && CampStatsAndResources.NailsResc >= 100 && CampStatsAndResources.EnergyCoreResc >= 1) addButton(9, "Power bracer", lumiWorkshopPowerBracer).hint("Power bracer - This bracer increase your physical strength by injecting drugs which reacts with your blood. A physical strength version of the drug injector to cope with your natural handicaps. Like all drugs also increase sensitivity - 50+ int, any Drug injector, 3 metal pieces, 100 nails, 1 energy core, 4 hours of work");
			addButton(12, "Weapons", lumiWorkshopWeapons);
			if (player.vehiclesName == "Goblin Mech Alpha" || player.vehiclesName == "Goblin Mech Prime" || player.vehiclesName == "Giant Slayer Mech") addButton(13, "Mech UPGR", lumiWorkshopMechUpgrades);
			else addButtonDisabled(13, "Mech UPGR", "You need to have goblin mech currently used to craft upgrades for it.");
			if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) addButton(14, "Back", playerMenu);
			else addButton(14, "Back", lumiLabChoices);
		}
		else {
			spriteSelect(SpriteDb.s_lumi);
			clearOutput();
			outputText("Lumi answers by the negative when you ask for the key to the workshop.\n\n");
			outputText("\"<i>Engineering is a goblin craft [name]. Its made <b>by</b> goblins <b>fer</b> goblins. Ya want in my workshop? Ya will have to look the part. I don't want to be responsible for some big oaf blowing " + player.mf("him", "herself") + " up with [his] own explosives or shocking " + player.mf("him", "herself") + " to death with live wires.</i>\"\n\n");
			endEncounter();
		}
	}
	public function lumiWorkshopWeapons():void {
		clearOutput();
		SceneLib.camp.campUpgrades.checkMaterials();
		outputText("Metal Pieces: " + CampStatsAndResources.MetalPieces + "/200" + "\n");
		outputText("Mechanisms: " + CampStatsAndResources.MechanismResc + "/200" + "\n");
		outputText("Energy Cores: " + CampStatsAndResources.EnergyCoreResc + "/200" + "\n");
		outputText("\nWhich blueprints will you work on today?\n\n");
		menu();
		if (player.hasKeyItem("Blueprint - Machined greatsword") >= 0 && (player.hasKeyItem("Power bracer") >= 0 || player.hasKeyItem("Powboy") >= 0 || player.hasKeyItem("M.G.S. bracer") >= 0) && player.hasPerk(PerkLib.JobWarrior) && player.inte >= 50 && CampStatsAndResources.MetalPieces >= 3 && CampStatsAndResources.NailsResc >= 200 && CampStatsAndResources.EnergyCoreResc >= 1 && CampStatsAndResources.MechanismResc >= 2) addButton(0, "Mach. greatsword", lumiWorkshopMachineGreatsword).hint("Machine greatsword - This greatsword is half invention half weapon. Instead of a sharp straight blade the weapon sides is a set of metal tooth's that constantly move in order to properly saw through flesh and more solid mather, creating grievous wounds. Very good for cutting down trees too - 50+ int, Job: Warrior, any Power bracer, 3 metal pieces, 200 nails, 1 energy core, 2 mechanism, 12 hours of work");
		else addButtonDisabled(0, "Mach. greatsword", "Req. 50+ int, Job: Warrior, any Power bracer, 3 metal pieces, 200 nails, 1 energy core, 2 mechanism.");
		if (player.hasKeyItem("Blueprint - Machined spear") >= 0 && (player.hasKeyItem("Power bracer") >= 0 || player.hasKeyItem("Powboy") >= 0 || player.hasKeyItem("M.G.S. bracer") >= 0) && player.hasPerk(PerkLib.JobWarrior) && player.inte >= 50 && CampStatsAndResources.MetalPieces >= 3 && CampStatsAndResources.NailsResc >= 200 && CampStatsAndResources.EnergyCoreResc >= 1 && CampStatsAndResources.MechanismResc >= 2) addButton(1, "Mach. spear", lumiWorkshopMachineSpear).hint("Machine spear - This spear is half invention and half weapon. Instead of a standard run of the mill spearhead, the weapon tip is a massive screw that spins on itself continually to burrow into the opponent’s flesh. Any decisive hit you will land with this thing will possibly be fatal - 50+ int, Job: Warrior, any Power bracer, 3 metal pieces, 200 nails, 1 energy core, 2 mechanism, 12 hours of work");
		else addButtonDisabled(1, "Mach. spear", "Req. 50+ int, Job: Warrior, any Power bracer, 3 metal pieces, 200 nails, 1 energy core, 2 mechanism.");
		if (player.hasKeyItem("Blueprint - Ripper 1.0") >= 0 && player.inte >= 75 && CampStatsAndResources.MetalPieces >= 10 && CampStatsAndResources.NailsResc >= 500 && CampStatsAndResources.EnergyCoreResc >= 2 && CampStatsAndResources.MechanismResc >= 5 && player.hasItem(weapons.MACGRSW, 1)) addButton(5, "Ripper 1.0", lumiWorkshopRipper1).hint("Ripper 1.0 - Similar to the machined great sword this weapon is highly mechanical. Instead of a sharp straight blade the weapon sides is a set of sharp metal tooth's that constantly move in order to properly saw through flesh and more solid mather, creating grievous wounds. Very good for cutting down trees to - 75+ int, Machined greatsword, 10 metal pieces, 500 nails, 2 energy core, 5 mechanism, 12 hours of work");
		else addButtonDisabled(5, "Ripper 1.0", "Req. 75+ int, Machined greatsword, 10 metal pieces, 500 nails, 2 energy core, 5 mechanism.");
		if (player.hasKeyItem("Blueprint - Ripper 2.0") >= 0 && player.inte >= 100 && CampStatsAndResources.MetalPieces >= 30 && CampStatsAndResources.NailsResc >= 500 && CampStatsAndResources.EnergyCoreResc >= 5 && CampStatsAndResources.MechanismResc >= 10 && player.hasItem(weapons.RIPPER1, 1)) addButton(10, "Ripper 2.0", lumiWorkshopRipper2).hint("Ripper 2.0 - Similar to the machined great sword this weapon is highly mechanical. Instead of a sharp straight blade the weapon sides is a set of sharp metal tooth's that constantly move in order to properly saw through flesh and more solid mather, creating grievous wounds. The blades movement is so fast it creates heat along the length and thanks to a small system set the saw constantly aflame. Aside of cutting fleshy things in half it is very good for taking down trees - 100+ int, Ripper 1.0, 30 metal pieces, 500 nails, 5 energy core, 10 mechanism, 12 hours of work");
		else addButtonDisabled(10, "Ripper 2.0", "Req. 100+ int, Ripper 1.0, 30 metal pieces, 500 nails, 5 energy core, 10 mechanism.");
		addButton(14, "Back", lumiWorkshop);
	}
	public function lumiWorkshopMechUpgrades():void {
		clearOutput();
		SceneLib.camp.campUpgrades.checkMaterials();
		outputText("Metal Pieces: " + CampStatsAndResources.MetalPieces + "/200" + "\n");
		outputText("Mechanisms: " + CampStatsAndResources.MechanismResc + "/200" + "\n");
		outputText("Energy Cores: " + CampStatsAndResources.EnergyCoreResc + "/200" + "\n");
		outputText("\nWhich blueprints will you work on today?\n\n");
		if (player.hasKeyItem("Blueprint - Upgraded Armor plating 6.0") >= 0) outputText("Upgraded Armor plating 6.0 - Req. 175+ int, Upgraded Armor plating 5.0, 30 metal pieces, 700 nails.\n");
		if (player.hasKeyItem("Blueprint - Upgraded Armor plating 5.0") >= 0) outputText("Upgraded Armor plating 5.0 - Req. 150+ int, Upgraded Armor plating 4.0, 25 metal pieces, 600 nails.\n");
		if (player.hasKeyItem("Blueprint - Upgraded Armor plating 4.0") >= 0) outputText("Upgraded Armor plating 4.0 - Req. 125+ int, Upgraded Armor plating 3.0, 20 metal pieces, 500 nails.\n");
		if (player.hasKeyItem("Blueprint - Upgraded Armor plating 3.0") >= 0) outputText("Upgraded Armor plating 3.0 - Req. 100+ int, Upgraded Armor plating 2.0, 15 metal pieces, 400 nails.\n");
		if (player.hasKeyItem("Blueprint - Upgraded Armor plating 2.0") >= 0) outputText("Upgraded Armor plating 2.0 - Req. 75+ int, Upgraded Armor plating 1.0, 10 metal pieces, 300 nails.\n");
		if (player.hasKeyItem("Blueprint - Upgraded Armor plating 1.0") >= 0) outputText("Upgraded Armor plating 1.0 - Req. 50+ int, 5 metal pieces, 200 nails.\n");
		if (player.hasKeyItem("Blueprint - Taser with an overcharged battery") >= 0) outputText("Taser with an overcharged battery - Req. 100+ int, Tazer, 15 metal pieces, 500 nails, 2 mechanism, 5 energy core.\n");
		if (player.hasKeyItem("Blueprint - Taser") >= 0) outputText("Taser - Req. 75+ int, Toolbelt, 10 metal pieces, 300 nails, 1 mechanism, 1 energy core.\n");
		if (player.hasKeyItem("Blueprint - Safety bubble") >= 0) outputText("Safety bubble - Req. 1 metal pieces, 100 nails, 1 energy core.\n");
		if (player.hasKeyItem("Blueprint - Medical Dispenser 2.0") >= 0) outputText("Medical Dispenser 2.0 - Req. 100+ int, Stimpack Dispenser 1.0, 20 metal pieces, 500 nails, 5 healing pills, 5 energy cores.\n");
		if (player.hasKeyItem("Blueprint - Stimpack Dispenser 1.0") >= 0) outputText("Stimpack Dispenser 1.0 - Req. 50+ int, knowing Heal spell, Toolbelt, 10 metal pieces, 200 nails, 5 healing pills.\n");
		if (player.hasKeyItem("Blueprint - Omni Missile") >= 0) outputText("Omni Missile - Req. 100+ int, Missile launcher, 20 metal pieces, 500 nails, 10 mechanism.\n");
		if (player.hasKeyItem("Blueprint - Missile launcher") >= 0) outputText("Missile launcher - Req. 75+ int, Toolbelt, 10 metal pieces, 500 nails, 5 mechanisms.\n");
		if (player.hasKeyItem("Blueprint - Lustnade Launcher") >= 0) outputText("Lustnade Launcher - Req. 100+ int, Aphrodigas Gun, 20 metal pieces, 500 nails, 10 mechanism, 10 lust drafts.\n");
		if (player.hasKeyItem("Blueprint - Aphrodigas Gun") >= 0) outputText("Aphrodigas Gun - Req. 25+ int, Toolbelt, 2 metal pieces, 100 nails, 5 lust drafts.\n");
		if (player.hasKeyItem("Blueprint - Impregnator 1.0") >= 0) outputText("Impregnator 1.0 - Req. 100+ int, SPMK1, 5 metal pieces, 100 nails.\n");
		if (player.hasKeyItem("Blueprint - SPMK1") >= 0) outputText("SPMK1 - Req. 75+ int, Cum Reservoir, 1 metal piece.\n");
		if (player.hasKeyItem("Blueprint - Cum Reservoir") >= 0) outputText("Cum Reservoir - Req. 50+ int, Toolbelt, taken Cock Milker or Breast Pump from Factory, 5 metal pieces, 100 nails.\n");
		if (player.hasKeyItem("Blueprint - MK2 Jetpack") >= 0) outputText("MK2 Jetpack - Req. 100+ int, Jetpack, 10 metal pieces, 300 nails, 2 energy core.\n");
		if (player.hasKeyItem("Blueprint - Jetpack") >= 0) outputText("Jetpack - Req. 50+ int, Toolbelt, 3 metal pieces, 100 nails, 1 energy core.\n");
		if (player.hasKeyItem("Blueprint - Improved Artificial Intelligence MK4") >= 0) outputText("Improved Artificial Intelligence MK4 - Req. 200+ int, 10 energy cores, 10 volt topaz.\n");
		if (player.hasKeyItem("Blueprint - Improved Artificial Intelligence MK3") >= 0) outputText("Improved Artificial Intelligence MK3 - Req. 150+ int, 5 energy cores, 5 volt topaz.\n");
		if (player.hasKeyItem("Blueprint - Improved Artificial Intelligence MK2") >= 0) outputText("Improved Artificial Intelligence MK2 - Req. 100+ int, 5 energy cores.\n");
		if (player.hasKeyItem("Blueprint - Improved Artificial Intelligence") >= 0) outputText("Improved Artificial Intelligence - Req. 50+ int, 1 energy core.\n");
		if (player.hasKeyItem("Blueprint - Artificial Intelligence") >= 0) outputText("Artificial Intelligence - Req. 50+ int, 1 golem core.\n");
		if (player.hasKeyItem("Blueprint - Hydraulics MK6") >= 0) outputText("Hydraulics MK6 - Req. 300+ int, 50 metal pieces.\n");
		if (player.hasKeyItem("Blueprint - Hydraulics MK5") >= 0) outputText("Hydraulics MK5 - Req. 250+ int, 40 metal pieces.\n");
		if (player.hasKeyItem("Blueprint - Hydraulics MK4") >= 0) outputText("Hydraulics MK4 - Req. 200+ int, 30 metal pieces.\n");
		if (player.hasKeyItem("Blueprint - Hydraulics MK3") >= 0) outputText("Hydraulics MK3 - Req. 150+ int, 20 metal pieces.\n");
		if (player.hasKeyItem("Blueprint - Hydraulics MK2") >= 0) outputText("Hydraulics MK2 - Req. 100+ int, 10 metal pieces.\n");
		if (player.hasKeyItem("Blueprint - Hydraulics") >= 0) outputText("Hydraulics - Req. 50+ int, 5 metal pieces.\n");
		if (player.hasKeyItem("Blueprint - Improved Ammo Chemistry MK6") >= 0) outputText("Improved Ammo Chemistry MK6 - Req. 300+ int, 30 metal pieces, 10 salamander firewater, 10 methir crystals.\n");
		if (player.hasKeyItem("Blueprint - Improved Ammo Chemistry MK5") >= 0) outputText("Improved Ammo Chemistry MK5 - Req. 250+ int, 25 metal pieces, 10 salamander firewater, 5 methir crystals.\n");
		if (player.hasKeyItem("Blueprint - Improved Ammo Chemistry MK4") >= 0) outputText("Improved Ammo Chemistry MK4 - Req. 200+ int, 20 metal pieces, 5 salamander firewater.\n");
		if (player.hasKeyItem("Blueprint - Improved Ammo Chemistry MK3") >= 0) outputText("Improved Ammo Chemistry MK3 - Req. 150+ int, 15 metal pieces, 1 salamander firewater.\n");
		if (player.hasKeyItem("Blueprint - Improved Ammo Chemistry MK2") >= 0) outputText("Improved Ammo Chemistry MK2 - Req. 100+ int, 10 metal pieces.\n");
		if (player.hasKeyItem("Blueprint - Improved Ammo Chemistry") >= 0) outputText("Improved Ammo Chemistry - Req. 50+ int, 5 metal pieces.\n");
		menu();
		if (player.hasKeyItem("Blueprint - Upgraded Armor plating 6.0") >= 0 && player.hasKeyItem("Upgraded Armor plating 5.0") >= 0 && player.inte >= 175 && CampStatsAndResources.MetalPieces >= 30 && CampStatsAndResources.NailsResc >= 700) addButton(0, "UpgrArmor 6.0", lumiWorkshopUpgradedArmorPlating6).hint("Upgraded Armor plating 6.0 - +15 armor/magic resistance to the mech. +110% Health. - 175+ int, Upgraded Armor plating 5.0, 30 metal pieces, 700 nails and 12 hours of work");
		if (player.hasKeyItem("Blueprint - Upgraded Armor plating 5.0") >= 0 && player.hasKeyItem("Upgraded Armor plating 4.0") >= 0 && player.inte >= 150 && CampStatsAndResources.MetalPieces >= 25 && CampStatsAndResources.NailsResc >= 600) addButton(0, "UpgrArmor 5.0", lumiWorkshopUpgradedArmorPlating5).hint("Upgraded Armor plating 5.0 - +15 armor/magic resistance to the mech. +90% Health. - 150+ int, Upgraded Armor plating 4.0, 25 metal pieces, 600 nails and 12 hours of work");
		if (player.hasKeyItem("Blueprint - Upgraded Armor plating 4.0") >= 0 && player.hasKeyItem("Upgraded Armor plating 3.0") >= 0 && player.inte >= 125 && CampStatsAndResources.MetalPieces >= 20 && CampStatsAndResources.NailsResc >= 500) addButton(0, "UpgrArmor 4.0", lumiWorkshopUpgradedArmorPlating4).hint("Upgraded Armor plating 4.0 - +15 armor/magic resistance to the mech. +70% Health. - 125+ int, Upgraded Armor plating 3.0, 20 metal pieces, 500 nails and 8 hours of work");
		if (player.hasKeyItem("Blueprint - Upgraded Armor plating 3.0") >= 0 && player.hasKeyItem("Upgraded Armor plating 2.0") >= 0 && player.inte >= 100 && CampStatsAndResources.MetalPieces >= 15 && CampStatsAndResources.NailsResc >= 400) addButton(0, "UpgrArmor 3.0", lumiWorkshopUpgradedArmorPlating3).hint("Upgraded Armor plating 3.0 - +15 armor/magic resistance to the mech. +50% Health. - 100+ int, Upgraded Armor plating 2.0, 15 metal pieces, 400 nails and 8 hours of work");
		if (player.hasKeyItem("Blueprint - Upgraded Armor plating 2.0") >= 0 && player.hasKeyItem("Upgraded Armor plating 1.0") >= 0 && player.inte >= 75 && CampStatsAndResources.MetalPieces >= 10 && CampStatsAndResources.NailsResc >= 300) addButton(0, "UpgrArmor 2.0", lumiWorkshopUpgradedArmorPlating2).hint("Upgraded Armor plating 2.0 - +10 armor/magic resistance to the mech. +35% Health. - 75+ int, Upgraded Armor plating 1.0, 10 metal pieces, 300 nails and 4 hours of work");
		if (player.hasKeyItem("Blueprint - Upgraded Armor plating 1.0") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && CampStatsAndResources.MetalPieces >= 5 && CampStatsAndResources.NailsResc >= 200) addButton(0, "UpgrArmor 1.0", lumiWorkshopUpgradedArmorPlating1).hint("Upgraded Armor plating 1.0 - +5 armor/magic resistance to the mech. +20% Health. - 50+ int, Toolbelt, 5 metal pieces, 200 nails and 4 hours of work");
		if (player.hasKeyItem("Blueprint - Taser with an overcharged battery") >= 0 && player.hasKeyItem("Taser") >= 0 && player.inte >= 100 && CampStatsAndResources.MetalPieces >= 15 && CampStatsAndResources.NailsResc >= 500 && CampStatsAndResources.EnergyCoreResc >= 5 && CampStatsAndResources.MechanismResc >= 2) addButton(1, "Tazer O.B.", lumiWorkshopTaserOverchargeBattery).hint("Taser with an overcharged battery - Increases the Taser’s effectiveness and paralysis duration. - 100+ int, Tazer, 15 metal pieces, 500 nails, 2 mechanism, 5 energy core and 8 hours of work");
		if (player.hasKeyItem("Blueprint - Taser") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 75 && CampStatsAndResources.MetalPieces >= 10 && CampStatsAndResources.NailsResc >= 300 && CampStatsAndResources.EnergyCoreResc >= 1 && CampStatsAndResources.MechanismResc >= 1) addButton(1, "Tazer", lumiWorkshopTaser).hint("Tazer - Adds an Tazer option to your mech. - 75+ int, Toolbelt, 10 metal pieces, 300 nails, 1 mechanism, 1 energy core and 8 hours of work");
		if (player.hasKeyItem("Blueprint - Safety bubble") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && CampStatsAndResources.EnergyCoreResc >= 1 && CampStatsAndResources.MetalPieces >= 1 && CampStatsAndResources.NailsResc >= 100) addButton(2, "Safety bubble", lumiWorkshopSafetyBubble).hint("Safety bubble - Allows you to use the mech underwater. Too fragile for standard combat use but provide fresh air. - 1 metal pieces, 100 nails, 1 energy core and 4 hours of work.");
		if (player.hasKeyItem("Blueprint - Dynapunch Glove") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && CampStatsAndResources.MetalPieces >= 2 && CampStatsAndResources.NailsResc >= 100 && CampStatsAndResources.MechanismResc >= 1) addButton(3, "Dynapunch G.", lumiWorkshopDynapunchGlove).hint("Dynapunch Glove - Adds a punching option to your mech. - 50+ int, Toolbelt, 2 metal pieces, 100 nails, 1 mechanism and 4 hour work.");
		if (player.hasKeyItem("Blueprint - Medical Dispenser 2.0") >= 0 && player.hasKeyItem("Stimpack Dispenser 1.0") >= 0 && player.inte >= 100 && CampStatsAndResources.MetalPieces >= 20 && CampStatsAndResources.NailsResc >= 500 && CampStatsAndResources.EnergyCoreResc >= 5 && player.hasItem(consumables.H_PILL, 5)) addButton(4, "Medical Dispenser 2.0", lumiWorkshopMedicalDispenser2).hint("Medical Dispenser 2.0 - Healing for 10 turns 20% of Heal spell value rising lust by 0,5% each turn. - 100+ int, Stimpack Dispenser 1.0, 20 metal pieces, 500 nails, 5 healing pills, 5 energy cores and 12 hours of work");
		if (player.hasKeyItem("Blueprint - Stimpack Dispenser 1.0") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && CampStatsAndResources.MetalPieces >= 10 && CampStatsAndResources.NailsResc >= 200 && player.hasItem(consumables.H_PILL, 5) && player.hasStatusEffect(StatusEffects.KnowsHeal)) addButton(4, "Stimpack Dispenser 1.0", lumiWorkshopStimpackDispenser1).hint("Stimpack Dispenser 1.0 - Healing for 10 turns 10% of Heal spell value rising lust by 1% each turn. - 50+ int, knowing Heal spell, Toolbelt, 10 metal pieces, 200 nails, 5 healing pills and 4 hours of work");
		if (player.hasKeyItem("Blueprint - Omni Missile") >= 0 && player.hasKeyItem("Missile launcher") >= 0 && player.inte >= 100 && CampStatsAndResources.MetalPieces >= 20 && CampStatsAndResources.NailsResc >= 500 && CampStatsAndResources.MechanismResc >= 10) addButton(5, "Omni Missile", lumiWorkshopOmniMissile).hint("Omni Missile - Increases Missile launcher effectiveness vs groups. - 100+ int, Missile launcher, 20 metal pieces, 500 nails, 10 mechanism and 12 hours of work");
		if (player.hasKeyItem("Blueprint - Missile launcher") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 75 && CampStatsAndResources.MetalPieces >= 10 && CampStatsAndResources.NailsResc >= 500 && CampStatsAndResources.MechanismResc >= 5) addButton(5, "Missile launcher", lumiWorkshopMissileLauncher).hint("Missile launcher - Adds an Missile launcher option to your mech. - 75+ int, Toolbelt, 10 metal pieces, 500 nails, 5 mechanisms and 8 hours of work");
		if (player.hasKeyItem("Blueprint - Lustnade Launcher") >= 0 && player.hasKeyItem("Aphrodigas Gun") >= 0 && player.inte >= 100 && CampStatsAndResources.MetalPieces >= 20 && CampStatsAndResources.NailsResc >= 500 && player.hasItem(consumables.L_DRAFT, 10) && CampStatsAndResources.MechanismResc >= 10) addButton(6, "Lustnade Launcher", lumiWorkshopLustnadeLauncher).hint("Lustnade Launcher - Upgraded version of Aphrodigas Gun. - 100+ int, Aphrodigas Gun, 20 metal pieces, 500 nails, 10 mechanism, 10 lust drafts and 4 hours of work");
		if (player.hasKeyItem("Blueprint - Aphrodigas Gun") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 25 && CampStatsAndResources.MetalPieces >= 2 && CampStatsAndResources.NailsResc >= 100 && player.hasItem(consumables.L_DRAFT, 5)) addButton(6, "Aphrodigas Gun",lumiWorkshopAphrodigasGun).hint("Aphrodigas Gun - Adds an Aphrodigas Gun option to your mech. - 25+ int, Toolbelt, 2 metal pieces, 100 nails, 5 lust drafts and 4 hours of work");
		if (player.hasKeyItem("Blueprint - Impregnator 1.0") >= 0 && player.hasKeyItem("SPMK1") >= 0 && player.inte >= 100 && CampStatsAndResources.MetalPieces >= 5 && CampStatsAndResources.NailsResc >= 100) addButton(7, "Impregnator 1.0", lumiWorkshopImpregnator1).hint("Impregnator 1.0 - Allows you to store cum from defeated male opponents in the reservoir for future use. - 75+ int, Toolbelt, taken Cock Milker or Breast Pump from Factory, 5 metal pieces, 100 nails and 4 hours of work.");
		if (player.hasKeyItem("Blueprint - SPMK1") >= 0 && player.hasKeyItem("Cum Reservoir") >= 0 && player.inte >= 75 && CampStatsAndResources.MetalPieces >= 1) addButton(7, "SPMK1", lumiWorkshopSPMK1).hint("SPMK1 - Allows you to store cum from defeated male opponents in the reservoir for future use. - 75+ int, Toolbelt, taken Cock Milker or Breast Pump from Factory, 5 metal pieces, 100 nails and 4 hours of work.");
		if (player.hasKeyItem("Blueprint - Cum Reservoir") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && flags[kFLAGS.FACTORY_MILKER_BUILT] > 0 && CampStatsAndResources.MetalPieces >= 5 && CampStatsAndResources.NailsResc >= 100) addButton(7, "Cum Reservoir", lumiWorkshopCumReservoir).hint("Cum Reservoir - Allows you to store cum from defeated male opponents in the reservoir for future use. - 75+ int, Toolbelt, taken Cock Milker or Breast Pump from Factory, 5 metal pieces, 100 nails and 4 hours of work.");
		if (player.hasKeyItem("Blueprint - MK2 Jetpack") >= 0 && player.hasKeyItem("Jetpack") >= 0 && player.inte >= 100 && CampStatsAndResources.MetalPieces >= 10 && CampStatsAndResources.NailsResc >= 300 && CampStatsAndResources.EnergyCoreResc >= 2) addButton(8, "MK2 Jetpack", lumiWorkshopMK2Jetpack).hint("MK2 Jetpack - An improvement to the Jetpack, increasing your evasiveness by 25% while airborne. - 100+ int, Jetpack, 10 metal pieces, 300 nails, 2 energy cores and 8 hours of work");
		if (player.hasKeyItem("Blueprint - Jetpack") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && CampStatsAndResources.MetalPieces >= 3 && CampStatsAndResources.NailsResc >= 100 && CampStatsAndResources.EnergyCoreResc >= 1) addButton(8, "Jetpack", lumiWorkshopJetpack).hint("Jetpack - The mech can hover in the air and fly, allowing for flight in battle. - 50+ int, Toolbelt, 3 metal pieces, 100 nails, 1 energy core and 4 hours of work");
		if (player.hasKeyItem("Blueprint - Improved Artificial Intelligence MK4") >= 0 && player.hasKeyItem("Improved Artificial Intelligence MK3") >= 0 && player.inte >= 200 && CampStatsAndResources.EnergyCoreResc >= 10 && player.hasItem(consumables.VOLTTOP, 10)) addButton(9, "Improved AI MK4", lumiWorkshopImprovedArtificialIntelligenceMK4).hint("Improved Artificial Intelligence MK4 - The mech will randomly activate two of its weapon functions every round on its own. - 200+ int, 10 energy cores, 10 volt topaz and 12 hours of work.");
		if (player.hasKeyItem("Blueprint - Improved Artificial Intelligence MK3") >= 0 && player.hasKeyItem("Improved Artificial Intelligence MK2") >= 0 && player.inte >= 150 && CampStatsAndResources.EnergyCoreResc >= 5 && player.hasItem(consumables.VOLTTOP, 5)) addButton(9, "Improved AI MK3", lumiWorkshopImprovedArtificialIntelligenceMK3).hint("Improved Artificial Intelligence MK3 - The mech will randomly activate one of its weapon functions every round on its own at full power. - 150+ int, 5 energy cores, 5 volt topaz and 12 hours of work.");
		if (player.hasKeyItem("Blueprint - Improved Artificial Intelligence MK2") >= 0 && player.hasKeyItem("Improved Artificial Intelligence") >= 0 && player.inte >= 100 && CampStatsAndResources.EnergyCoreResc >= 5) addButton(9, "Improved AI MK2", lumiWorkshopImprovedArtificialIntelligenceMK2).hint("Improved Artificial Intelligence MK2 - The mech will randomly activate one of its weapon functions every round on its own at half power value. - 100+ int, 5 energy cores and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Improved Artificial Intelligence") >= 0 && player.hasKeyItem("Artificial Intelligence") >= 0 && player.inte >= 50 && CampStatsAndResources.EnergyCoreResc >= 1) addButton(9, "Improved AI", lumiWorkshopImprovedArtificialIntelligence).hint("Improved Artificial Intelligence - The mech can now use an auto turret. - 50+ int, 1 energy core and 4 hours of work.");
		if (player.hasKeyItem("Blueprint - Artificial Intelligence") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && player.hasItem(useables.GOLCORE, 1)) addButton(9, "AI", lumiWorkshopArtificialIntelligence).hint("Artificial Intelligence - Add an artificial intelligence to your mech which will greet you when you board. Aside from the friendliness of this new interface feature it cannot do much on its own yet. - 50+ int, Toolbelt, 1 golem core and 4 hours of work.");
		if (player.hasKeyItem("Blueprint - Hydraulics MK6") >= 0 && player.hasKeyItem("Hydraulics MK5") >= 0 && player.inte >= 300 && CampStatsAndResources.MetalPieces >= 50) addButton(10, "Hydraulics MK6", lumiWorkshopHydraulicsMK6).hint("Hydraulics MK6 - Mechs gain 150% of your intelligence modifier as a melee bonus. If wearing heavy/ayo armor, melee weapons gain half of this bonus. - 300+ int, 50 metal pieces and 12 hours of work.");
		if (player.hasKeyItem("Blueprint - Hydraulics MK5") >= 0 && player.hasKeyItem("Hydraulics MK4") >= 0 && player.inte >= 250 && CampStatsAndResources.MetalPieces >= 40) addButton(10, "Hydraulics MK5", lumiWorkshopHydraulicsMK5).hint("Hydraulics MK5 - Mechs gain 125% of your intelligence modifier as a melee bonus. If wearing heavy/ayo armor, melee weapons gain half of this bonus. - 250+ int, 40 metal pieces and 12 hours of work.");
		if (player.hasKeyItem("Blueprint - Hydraulics MK4") >= 0 && player.hasKeyItem("Hydraulics MK3") >= 0 && player.inte >= 200 && CampStatsAndResources.MetalPieces >= 30) addButton(10, "Hydraulics MK4", lumiWorkshopHydraulicsMK4).hint("Hydraulics MK4 - Mechs gain 100 of your intelligence modifier as a melee bonus. If wearing heavy/ayo armor, melee weapons gain half of this bonus. - 200+ int, 30 metal pieces and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Hydraulics MK3") >= 0 && player.hasKeyItem("Hydraulics MK2") >= 0 && player.inte >= 150 && CampStatsAndResources.MetalPieces >= 20) addButton(10, "Hydraulics MK3", lumiWorkshopHydraulicsMK3).hint("Hydraulics MK3 - Mechs gain 75% of your intelligence modifier as a melee bonus. If wearing heavy/ayo armor, melee weapons gain half of this bonus. - 150+ int, 20 metal pieces and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Hydraulics MK2") >= 0 && player.hasKeyItem("Hydraulics") >= 0 && player.inte >= 100 && CampStatsAndResources.MetalPieces >= 10) addButton(10, "Hydraulics MK2", lumiWorkshopHydraulicsMK2).hint("Hydraulics MK2 - Mechs gain 50% of your intelligence modifier as a melee bonus. If wearing heavy/ayo armor, melee weapons gain half of this bonus. - 100+ int, 10 metal pieces and 4 hours of work.");
		if (player.hasKeyItem("Blueprint - Hydraulics") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && CampStatsAndResources.MetalPieces >= 5) addButton(10, "Hydraulics", lumiWorkshopHydraulics).hint("Hydraulics - Mechs gain 25% of your intelligence modifier as a melee bonus. If wearing heavy/ayo armor, melee weapons gain half of this bonus. - 50+ int, Toolbelt, 5 metal pieces and 4 hours of work.");
		if (player.hasKeyItem("Blueprint - Improved Ammo Chemistry MK6") >= 0 && player.hasKeyItem("Improved Ammo Chemistry MK5") >= 0 && player.inte >= 300 && CampStatsAndResources.MetalPieces >= 30 && player.hasItem(consumables.SALAMFW, 10) && player.hasItem(consumables.METHIRC, 10)) addButton(11, "Improved Ammo Chemistry MK6", lumiWorkshopImprovedAmmoChemistryMK6).hint("Improved Ammo Chemistry MK6 - Add six extra attacks to the mech ranged weapon. Ammo now has an incendiary property dealing doubled damage as fire. Ammo now has a caustic property dealing tripled damage as acid. - 300+ int, 30 metal pieces, 10 salamander firewater, 10 methir crystals and 12 hours of work.");
		if (player.hasKeyItem("Blueprint - Improved Ammo Chemistry MK5") >= 0 && player.hasKeyItem("Improved Ammo Chemistry MK4") >= 0 && player.inte >= 250 && CampStatsAndResources.MetalPieces >= 25 && player.hasItem(consumables.SALAMFW, 10) && player.hasItem(consumables.METHIRC, 5)) addButton(11, "Improved Ammo Chemistry MK5", lumiWorkshopImprovedAmmoChemistryMK5).hint("Improved Ammo Chemistry MK5 - Add five extra attacks to the mech ranged weapon. Ammo now has an incendiary property dealing doubled damage as fire. Ammo now has a caustic property dealing tripled damage as acid. - 250+ int, 25 metal pieces, 10 salamander firewater, 5 methir crystals and 12 hours of work.");
		if (player.hasKeyItem("Blueprint - Improved Ammo Chemistry MK4") >= 0 && player.hasKeyItem("Improved Ammo Chemistry MK3") >= 0 && player.inte >= 200 && CampStatsAndResources.MetalPieces >= 20 && player.hasItem(consumables.SALAMFW, 5)) addButton(11, "Improved Ammo Chemistry MK4", lumiWorkshopImprovedAmmoChemistryMK4).hint("Improved Ammo Chemistry MK4 - Add four extra attacks to the mech ranged weapon. Ammo now has an incendiary property dealing doubled damage as fire. - 200+ int, 20 metal pieces, 5 salamander firewater and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Improved Ammo Chemistry MK3") >= 0 && player.hasKeyItem("Improved Ammo Chemistry MK2") >= 0 && player.inte >= 150 && CampStatsAndResources.MetalPieces >= 15 && player.hasItem(consumables.SALAMFW, 1)) addButton(11, "Improved Ammo Chemistry MK3", lumiWorkshopImprovedAmmoChemistryMK3).hint("Improved Ammo Chemistry MK3 - Add three extra attacks to the mech ranged weapon. Ammo now has an incendiary property dealing doubled damage as fire. - 150+ int, 15 metal pieces, 1 salamander firewater and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Improved Ammo Chemistry MK2") >= 0 && player.hasKeyItem("Improved Ammo Chemistry") >= 0 && player.inte >= 100 && CampStatsAndResources.MetalPieces >= 10) addButton(11, "Improved Ammo Chemistry MK2", lumiWorkshopImprovedAmmoChemistryMK2).hint("Improved Ammo Chemistry MK2 - Add two extra attacks to the mech ranged weapon. - 100+ int, 10 metal pieces and 4 hours of work.");
		if (player.hasKeyItem("Blueprint - Improved Ammo Chemistry") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && CampStatsAndResources.MetalPieces >= 5) addButton(11, "Improved Ammo Chemistry", lumiWorkshopImprovedAmmoChemistry).hint("Improved Ammo Chemistry - Add one extra attack to the mech ranged weapon. - 50+ int, Toolbelt, 5 metal pieces and 4 hours of work.");
		//12
		addButton(13, "-2-", lumiWorkshopMechUpgrades2);
		addButton(14, "Back", lumiWorkshop);
	}
	public function lumiWorkshopMechUpgrades2():void {
		clearOutput();
		SceneLib.camp.campUpgrades.checkMaterials();
		outputText("Metal Pieces: " + CampStatsAndResources.MetalPieces + "/200" + "\n");
		outputText("Mechanisms: " + CampStatsAndResources.MechanismResc + "/200" + "\n");
		outputText("Energy Cores: " + CampStatsAndResources.EnergyCoreResc + "/200" + "\n");
		outputText("\nWhich blueprints will you work on today?\n\n");
		if (player.hasKeyItem("Blueprint - Machine Gun MK6") >= 0) outputText("Machine Gun MK6 - Req. 200+ int, 25 metal pieces, 1000 nails, 20 mechanism.\n");
		if (player.hasKeyItem("Blueprint - Machine Gun MK5") >= 0) outputText("Machine Gun MK5 - Req. 175+ int, 20 metal pieces, 800 nails, 15 mechanism.\n");
		if (player.hasKeyItem("Blueprint - Machine Gun MK4") >= 0) outputText("Machine Gun MK4 - Req. 150+ int, 15 metal pieces, 700 nails, 10 mechanism.\n");
		if (player.hasKeyItem("Blueprint - Machine Gun MK3") >= 0) outputText("Machine Gun MK3 - Req. 125+ int, 15 metal pieces, 600 nails, 10 mechanism.\n");
		if (player.hasKeyItem("Blueprint - Machine Gun MK2") >= 0) outputText("Machine Gun MK2 - Req. 100+ int, 10 metal pieces, 500 nails, 5 mechanism.\n");
		if (player.hasKeyItem("Blueprint - Machine Gun MK1") >= 0) outputText("Machine Gun MK1 - Req. 75+ int, 10 metal pieces, 200 nails, 5 mechanism.\n");
		if (player.hasKeyItem("Blueprint - Repeater Gun") >= 0) outputText("Repeater Gun - Req. 50+ int, 2 metal pieces, 100 nails.\n");
		if (player.hasKeyItem("Blueprint - Whitefire Beam Cannon") >= 0) outputText("Whitefire Beam Cannon - Req. 75+ int, knowing Whitefire spell, 20 metal pieces, 500 nails, 5 energy core.\n");
		if (player.hasKeyItem("Blueprint - Snowball Generator") >= 0) outputText("Snowball Generator - Req. 75+ int, knowing Ice Spike spell, 20 metal pieces, 500 nails, 5 energy core.\n");
		if (player.hasKeyItem("Blueprint - Raijin blaster") >= 0) outputText("Raijin blaster - Req. 100+ int, knowing Lightning Bolt spell, 15 metal pieces, 500 nails, 2 mechanism, 5 energy core, 5 raiju plasma.\n");
		if (player.hasKeyItem("Blueprint - Gravity shots") >= 0) outputText("Gravity shots - Req. 100+ int, knowing Darkness Shard spell, 15 metal pieces, 500 nails, 2 mechanism, 5 energy core.\n");
		if (player.hasKeyItem("Blueprint - Auto turret MK6") >= 0) outputText("Auto turret MK6 - Req. 300+ int, 25 mechanism.\n");
		if (player.hasKeyItem("Blueprint - Auto turret MK5") >= 0) outputText("Auto turret MK5 - Req. 250+ int, 20 mechanism.\n");
		if (player.hasKeyItem("Blueprint - Auto turret MK4") >= 0) outputText("Auto turret MK4 - Req. 200+ int, 15 mechanism.\n");
		if (player.hasKeyItem("Blueprint - Auto turret MK3") >= 0) outputText("Auto turret MK3 - Req. 150+ int, 10 mechanism.\n");
		if (player.hasKeyItem("Blueprint - Auto turret MK2") >= 0) outputText("Auto turret MK2 - Req. 100+ int, 5 mechanism.\n");
		if (player.hasKeyItem("Blueprint - Auto turret") >= 0) outputText("Auto turret - Req. 50+ int, 1 mechanism.\n");
		menu();
		if (player.hasKeyItem("Blueprint - Machine Gun MK6") >= 0 && player.hasKeyItem("Machine Gun MK5") >= 0 && player.inte >= 200 && CampStatsAndResources.MetalPieces >= 25 && CampStatsAndResources.NailsResc >= 1000 && CampStatsAndResources.MechanismResc >= 20) addButton(0, "Machine Gun MK6", lumiWorkshopMachineGunMK6).hint("Machine Gun MK6 - Increase range attack by 200% if using a firearm. Change the firearm text to a goblin machine gun text. - 200+ int, Machine Gun MK5, 25 metal pieces, 1000 nails, 20 mechanism and 12 hours of work.");
		if (player.hasKeyItem("Blueprint - Machine Gun MK5") >= 0 && player.hasKeyItem("Machine Gun MK4") >= 0 && player.inte >= 175 && CampStatsAndResources.MetalPieces >= 20 && CampStatsAndResources.NailsResc >= 800 && CampStatsAndResources.MechanismResc >= 15) addButton(0, "Machine Gun MK5", lumiWorkshopMachineGunMK5).hint("Machine Gun MK5 - Increase range attack by 150% if using a firearm. Change the firearm text to a goblin machine gun text. - 175+ int, Machine Gun MK4, 20 metal pieces, 800 nails, 15 mechanism and 12 hours of work.");
		if (player.hasKeyItem("Blueprint - Machine Gun MK4") >= 0 && player.hasKeyItem("Machine Gun MK3") >= 0 && player.inte >= 150 && CampStatsAndResources.MetalPieces >= 15 && CampStatsAndResources.NailsResc >= 700 && CampStatsAndResources.MechanismResc >= 10) addButton(0, "Machine Gun MK4", lumiWorkshopMachineGunMK4).hint("Machine Gun MK4 - Increase range attack by 125% if using a firearm. Change the firearm text to a goblin machine gun text. - 150+ int, Machine Gun MK3, 15 metal pieces, 700 nails, 10 mechanism and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Machine Gun MK3") >= 0 && player.hasKeyItem("Machine Gun MK2") >= 0 && player.inte >= 125 && CampStatsAndResources.MetalPieces >= 15 && CampStatsAndResources.NailsResc >= 600 && CampStatsAndResources.MechanismResc >= 10) addButton(0, "Machine Gun MK3", lumiWorkshopMachineGunMK3).hint("Machine Gun MK3 - Increase range attack by 100% if using a firearm. Change the firearm text to a goblin machine gun text. - 125+ int, Machine Gun MK2, 15 metal pieces, 600 nails, 10 mechanism and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Machine Gun MK2") >= 0 && player.hasKeyItem("Machine Gun MK1") >= 0 && player.inte >= 100 && CampStatsAndResources.MetalPieces >= 10 && CampStatsAndResources.NailsResc >= 500 && CampStatsAndResources.MechanismResc >= 5) addButton(0, "Machine Gun MK2", lumiWorkshopMachineGunMK2).hint("Machine Gun MK2 - Increase range attack by 75% if using a firearm. Change the firearm text to a goblin machine gun text. - 100+ int, Machine Gun MK1, 10 metal pieces, 500 nails, 5 mechanism, and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Machine Gun MK1") >= 0 && player.hasKeyItem("Repeater Gun") >= 0 && player.inte >= 75 && CampStatsAndResources.MetalPieces >= 10 && CampStatsAndResources.NailsResc >= 200 && CampStatsAndResources.MechanismResc >= 5) addButton(0, "Machine Gun MK1", lumiWorkshopMachineGunMK1).hint("Machine Gun MK1 - Increase range attack by 50% if using a firearm. Change the firearm text to a goblin machine gun text. - 75+ int, Repeater Gun, 10 metal pieces, 200 nails, 5 mechanism and 4 hours of work.");
		if (player.hasKeyItem("Blueprint - Repeater Gun") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && CampStatsAndResources.MetalPieces >= 2 && CampStatsAndResources.NailsResc >= 100) addButton(0, "Repeater Gun", lumiWorkshopRepeaterGun).hint("Repeater Gun - Increase range attack by 25% if using a firearm. Change the firearm text to a goblin machine gun text. - 50+ int, Toolbelt, 2 metal pieces, 100 nails and 4 hour work.");
		if (player.hasKeyItem("Blueprint - Whitefire Beam Cannon") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 75 && CampStatsAndResources.MetalPieces >= 20 && CampStatsAndResources.NailsResc >= 500 && CampStatsAndResources.EnergyCoreResc >= 5 && player.hasStatusEffect(StatusEffects.KnowsWhitefire)) addButton(1, "Whitefire B.C.", lumiWorkshopWhitefireBeamCannon).hint("Whitefire Beam Cannon - Adds a whitefire beam cannon option to your mech. - 75+ int, knowing Whitefire spell, 20 metal pieces, 500 nails, 5 energy core and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Snowball Generator") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 75 && CampStatsAndResources.MetalPieces >= 20 && CampStatsAndResources.NailsResc >= 500 && CampStatsAndResources.EnergyCoreResc >= 5 && player.hasStatusEffect(StatusEffects.KnowsIceSpike)) addButton(2, "Snowball G.", lumiWorkshopSnowballGenerator).hint("Snowball Generator - Adds a snowball generator option to your mech. - 75+ int, knowing Ice Spike spell, 20 metal pieces, 500 nails, 5 energy core and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Raijin blaster") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 100 && CampStatsAndResources.MetalPieces >= 15 && CampStatsAndResources.NailsResc >= 500 && CampStatsAndResources.MechanismResc >= 2 && CampStatsAndResources.EnergyCoreResc >= 5 && player.hasItem(useables.RPLASMA, 5) && player.hasStatusEffect(StatusEffects.KnowsLightningBolt)) addButton(3, "Raijin blaster", lumiWorkshopRaijinBlaster).hint("Raijin blaster - Adds a Raijin blaster option to your mech. - 100+ int, knowing Darkness Shard spell, 15 metal pieces, 500 nails, 2 mechanism, 5 energy core, 5 raiju plasma and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Gravity shots") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 100 && CampStatsAndResources.MetalPieces >= 15 && CampStatsAndResources.NailsResc >= 500 && CampStatsAndResources.MechanismResc >= 2 && CampStatsAndResources.EnergyCoreResc >= 5 && player.hasStatusEffect(StatusEffects.KnowsDarknessShard)) addButton(4, "Gravity shots", lumiWorkshopGravityShots).hint("Gravity shots - A weapon developed using your research on the jetpack, the Gravity shot deals tremendous damage to grouped enemy and holds flying enemies in place. - 100+ int, knowing Darkness Shard spell, 15 metal pieces, 500 nails, 2 mechanism, 5 energy core and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Auto turret MK6") >= 0 && player.hasKeyItem("Auto turret MK5") >= 0 && player.inte >= 300 && CampStatsAndResources.MechanismResc >= 25) addButton(5, "Auto turret MK6", lumiWorkshopAutoTurretMK6).hint("Auto turret MK6 - Add six passive ranged attacks per round to your AI routine no matter your action choice. - 300+ int, Auto turret MK5, 25 mechanism and 12 hours of work.");
		if (player.hasKeyItem("Blueprint - Auto turret MK5") >= 0 && player.hasKeyItem("Auto turret MK4") >= 0 && player.inte >= 250 && CampStatsAndResources.MechanismResc >= 20) addButton(5, "Auto turret MK5", lumiWorkshopAutoTurretMK5).hint("Auto turret MK5 - Add five passive ranged attacks per round to your AI routine no matter your action choice. - 250+ int, Auto turret MK4, 20 mechanism and 12 hours of work.");
		if (player.hasKeyItem("Blueprint - Auto turret MK4") >= 0 && player.hasKeyItem("Auto turret MK3") >= 0 && player.inte >= 200 && CampStatsAndResources.MechanismResc >= 15) addButton(5, "Auto turret MK4", lumiWorkshopAutoTurretMK4).hint("Auto turret MK4 - Add four passive ranged attacks per round to your AI routine no matter your action choice. - 200+ int, Auto turret MK3, 15 mechanism and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Auto turret MK3") >= 0 && player.hasKeyItem("Auto turret MK2") >= 0 && player.inte >= 150 && CampStatsAndResources.MechanismResc >= 10) addButton(5, "Auto turret MK3", lumiWorkshopAutoTurretMK3).hint("Auto turret MK3 - Add three passive ranged attacks per round to your AI routine no matter your action choice. - 150+ int, Auto turret MK2, 10 mechanism and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Auto turret MK2") >= 0 && player.hasKeyItem("Auto turret") >= 0 && player.inte >= 100 && CampStatsAndResources.MechanismResc >= 5) addButton(5, "Auto turret MK2", lumiWorkshopAutoTurretMK2).hint("Auto turret MK2 - Add two passive ranged attacks per round to your AI routine no matter your action choice. - 100+ int, Auto turret, 5 mechanism and 4 hours of work.");
		if (player.hasKeyItem("Blueprint - Auto turret") >= 0 && (player.hasKeyItem("Artificial Intelligence") >= 0 || player.hasKeyItem("Improved Artificial Intelligence") >= 0 || player.hasKeyItem("Improved Artificial Intelligence MK2") >= 0 || player.hasKeyItem("Improved Artificial Intelligence MK3") >= 0 || player.hasKeyItem("Improved Artificial Intelligence MK4") >= 0) && player.inte >= 50 && CampStatsAndResources.MechanismResc >= 1) addButton(5, "Auto turret", lumiWorkshopAutoTurret).hint("Auto turret - Add passive ranged attack per round to your AI routine no matter your action choice. - 50+ int, Artificial Intelligence, 1 mechanism and 4 hours of work.");
		addButton(14, "Back", lumiWorkshopMechUpgrades);
	}
	public function lumiWorkshopEnergyCore():void {
		clearOutput();
		CampStatsAndResources.EnergyCoreResc += 1;
		CampStatsAndResources.MetalPieces -= 5;
		player.destroyItems(useables.GOLCORE, 4);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Energy Core is ready.\n\n");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) endEncounter();
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopMechanism():void {
		clearOutput();
		CampStatsAndResources.MechanismResc += 1;
		CampStatsAndResources.MetalPieces -= 5;
		CampStatsAndResources.NailsResc -= 200;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Mechanism is ready.\n\n");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) endEncounter();
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopToolbelt():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 1;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Toolbelt is ready.\n\n");
		player.createKeyItem("Toolbelt", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Toolbelt");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) endEncounter();
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopPotentDrugInjectors():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 3;
		CampStatsAndResources.NailsResc -= 30;
		player.destroyItems(consumables.L_DRAFT, 15);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "eight":"twelve")+" hours your brand new Potent Drug injectors is ready.\n\n");
		player.createKeyItem("Potent Drug injectors", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Potent Drug injectors");
		player.removeKeyItem("Improved Drug injectors");
		player.statStore.replaceBuffObject({'lib.mult':0.75,'sens':+15},'DrugInjector',{text:'Potent Drug injectors'})
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseEightHours);
		else doNext(camp.returnToCampUseTwelveHours);
	}
	public function lumiWorkshopImprovedDrugInjectors():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 2;
		CampStatsAndResources.NailsResc -= 20;
		player.destroyItems(consumables.L_DRAFT, 10);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Improved Drug injectors is ready.\n\n");
		player.createKeyItem("Improved Drug injectors", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Improved Drug injectors");
		player.removeKeyItem("Drug injectors");
		player.statStore.replaceBuffObject({'lib.mult':0.50,'sens':+10},'DrugInjector',{text:'Improved Drug injectors'})
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseFourHours);
		else doNext(camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopDrugInjectors():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 1;
		CampStatsAndResources.NailsResc -= 10;
		player.destroyItems(consumables.L_DRAFT, 5);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Drug injectors is ready.\n\n");
		player.createKeyItem("Drug injectors", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Drug injectors");
		player.statStore.replaceBuffObject({'lib.mult':0.25,'sens':+5},'DrugInjector',{text:'Drug injectors'})
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) endEncounter();
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopGunScopeWithAimbot():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 10;
		CampStatsAndResources.NailsResc -= 500;
		CampStatsAndResources.EnergyCoreResc -= 1;
		player.removeKeyItem("Gun Scope with Aim tech");
		lumiWorkshopSharedPart12Hours("Gun Scope with Aimbot");
	}
	public function lumiWorkshopGunScopeWithAimTech():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 5;
		CampStatsAndResources.NailsResc -= 300;
		player.removeKeyItem("Gun Scope");
		lumiWorkshopSharedPart8Hours("Gun Scope with Aim tech");
	}
	public function lumiWorkshopGunScope():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 1;
		CampStatsAndResources.NailsResc -= 100;
		lumiWorkshopSharedPart4Hours("Gun Scope");
	}
	public function lumiWorkshopSATechGoggle():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 10;
		CampStatsAndResources.NailsResc -= 300;
		CampStatsAndResources.EnergyCoreResc -= 5;
		player.destroyItems(headjewelries.SCANGOG, 1);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "eight":"twelve")+" hours your brand new S.A Tech Goggles is ready.\n\n");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) inventory.takeItem(headjewelries.SATGOG, camp.returnToCampUseEightHours);
		else inventory.takeItem(headjewelries.SATGOG, camp.returnToCampUseTwelveHours);
	}
	public function lumiWorkshopScannerGoggle():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 5;
		CampStatsAndResources.NailsResc -= 200;
		CampStatsAndResources.EnergyCoreResc -= 2;
		player.destroyItems(headjewelries.MACHGOG, 1);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand-new Scanner goggles is ready.\n\n");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) inventory.takeItem(headjewelries.SCANGOG, camp.returnToCampUseFourHours);
		else inventory.takeItem(headjewelries.SCANGOG, camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopMachinistGoggles():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 1;
		CampStatsAndResources.NailsResc -= 100;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Machinist Goggles is ready.\n\n");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) inventory.takeItem(headjewelries.MACHGOG, explorer.done);
		else inventory.takeItem(headjewelries.MACHGOG, camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopNitroBoots():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 15;
		CampStatsAndResources.NailsResc -= 300;
		CampStatsAndResources.MechanismResc -= 3;
		player.destroyItems(consumables.SALAMFW, 5);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "eight":"twelve")+" hours your brand new Nitro Boots is ready.\n\n");
		player.createKeyItem("Nitro Boots", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Nitro Boots");
		player.removeKeyItem("Rocket Boots");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseEightHours);
		else doNext(camp.returnToCampUseTwelveHours);
	}
	public function lumiWorkshopRocketBoots():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 10;
		CampStatsAndResources.NailsResc -= 200;
		CampStatsAndResources.MechanismResc -= 2;
		player.destroyItems(consumables.SALAMFW, 1);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Rocket Boots is ready.\n\n");
		player.createKeyItem("Rocket Boots", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Rocket Boots");
		player.removeKeyItem("Spring Boots");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseFourHours);
		else doNext(camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopSpringBoots():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 5;
		CampStatsAndResources.NailsResc -= 100;
		CampStatsAndResources.MechanismResc -= 1;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Spring Boots is ready.\n\n");
		player.createKeyItem("Spring Boots", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Spring Boots");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) endEncounter();
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopMGSBracer():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 10;
		CampStatsAndResources.NailsResc -= 500;
		CampStatsAndResources.EnergyCoreResc -= 4;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "eight":"twelve")+" hours your brand new M.G.S. bracer is ready.\n\n");
		player.createKeyItem("M.G.S. bracer", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - M.G.S. bracer");
		player.removeKeyItem("Powboy");
		player.statStore.replaceBuffObject({'str.mult':1,'sens':+15},'Power bracer',{text:'M.G.S. bracer'})
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseEightHours);
		else doNext(camp.returnToCampUseTwelveHours);
	}
	public function lumiWorkshopPowboy():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 5;
		CampStatsAndResources.NailsResc -= 200;
		CampStatsAndResources.EnergyCoreResc -= 1;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Powboy is ready.\n\n");
		player.createKeyItem("Powboy", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Powboy");
		player.removeKeyItem("Power bracer");
		player.statStore.replaceBuffObject({'str.mult':0.75,'sens':+10},'Power bracer',{text:'Powboy'})
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseFourHours);
		else doNext(camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopPowerBracer():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 3;
		CampStatsAndResources.NailsResc -= 100;
		CampStatsAndResources.EnergyCoreResc -= 1;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Power bracer is ready.\n\n");
		player.createKeyItem("Power bracer", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Power bracer");
		player.statStore.replaceBuffObject({'str.mult':0.5,'sens':+5},'Power bracer',{text:'Power bracer'})
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) endEncounter();
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopRipper2():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 30;
		CampStatsAndResources.NailsResc -= 500;
		CampStatsAndResources.EnergyCoreResc -= 5;
		CampStatsAndResources.MechanismResc -= 10;
		player.destroyItems(weapons.RIPPER1, 1);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "eight":"twelve")+" hours your brand new Ripper 2.0 is ready.\n\n");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) inventory.takeItem(weapons.RIPPER2, camp.returnToCampUseEightHours);
		else inventory.takeItem(weapons.RIPPER2, camp.returnToCampUseTwelveHours);
	}
	public function lumiWorkshopRipper1():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 10;
		CampStatsAndResources.NailsResc -= 500;
		CampStatsAndResources.EnergyCoreResc -= 2;
		CampStatsAndResources.MechanismResc -= 5;
		player.destroyItems(weapons.MACGRSW, 1);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Ripper 1.0 is ready.\n\n");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) inventory.takeItem(weapons.RIPPER1, camp.returnToCampUseFourHours);
		else inventory.takeItem(weapons.RIPPER1, camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopMachineGreatsword():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 3;
		CampStatsAndResources.NailsResc -= 200;
		CampStatsAndResources.EnergyCoreResc -= 1;
		CampStatsAndResources.MechanismResc -= 2;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Machine greatsword is ready.\n\n");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) inventory.takeItem(weapons.MACGRSW, explorer.done);
		else inventory.takeItem(weapons.MACGRSW, camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopMachineSpear():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 3;
		CampStatsAndResources.NailsResc -= 200;
		CampStatsAndResources.EnergyCoreResc -= 1;
		CampStatsAndResources.MechanismResc -= 2;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Machine spear is ready.\n\n");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) inventory.takeItem(weapons.MACSPEA, explorer.done);
		else inventory.takeItem(weapons.MACSPEA, camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopUpgradedArmorPlating6():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 30;
		CampStatsAndResources.NailsResc -= 700;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "eight":"twelve")+" hours your brand new Upgraded Armor plating 6.0 is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Upgraded Armor plating 6.0", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Upgraded Armor plating 6.0");
		player.removeKeyItem("Upgraded Armor plating 5.0");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseEightHours);
		else doNext(camp.returnToCampUseTwelveHours);
	}
	public function lumiWorkshopUpgradedArmorPlating5():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 25;
		CampStatsAndResources.NailsResc -= 600;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "eight":"twelve")+" hours your brand new Upgraded Armor plating 5.0 is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Upgraded Armor plating 5.0", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Upgraded Armor plating 5.0");
		player.removeKeyItem("Upgraded Armor plating 4.0");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseEightHours);
		else doNext(camp.returnToCampUseTwelveHours);
	}
	public function lumiWorkshopUpgradedArmorPlating4():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 20;
		CampStatsAndResources.NailsResc -= 500;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Upgraded Armor plating 4.0 is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Upgraded Armor plating 4.0", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Upgraded Armor plating 4.0");
		player.removeKeyItem("Upgraded Armor plating 3.0");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseFourHours);
		else doNext(camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopUpgradedArmorPlating3():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 15;
		CampStatsAndResources.NailsResc -= 400;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Upgraded Armor plating 3.0 is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Upgraded Armor plating 3.0", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Upgraded Armor plating 3.0");
		player.removeKeyItem("Upgraded Armor plating 2.0");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseFourHours);
		else doNext(camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopUpgradedArmorPlating2():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 10;
		CampStatsAndResources.NailsResc -= 300;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Upgraded Armor plating 2.0 is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Upgraded Armor plating 2.0", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Upgraded Armor plating 2.0");
		player.removeKeyItem("Upgraded Armor plating 1.0");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) endEncounter();
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopUpgradedArmorPlating1():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 5;
		CampStatsAndResources.NailsResc -= 200;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Upgraded Armor plating 1.0 is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Upgraded Armor plating 1.0", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Upgraded Armor plating 1.0");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) endEncounter();
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopTaserOverchargeBattery():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 15;
		CampStatsAndResources.NailsResc -= 500;
		CampStatsAndResources.EnergyCoreResc -= 5;
		CampStatsAndResources.MechanismResc -= 2;
		player.removeKeyItem("Taser");
		lumiWorkshopSharedPart4Hours("Taser with an overcharged battery");
	}
	public function lumiWorkshopTaser():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 10;
		CampStatsAndResources.NailsResc -= 300;
		CampStatsAndResources.EnergyCoreResc -= 1;
		CampStatsAndResources.MechanismResc -= 1;
		lumiWorkshopSharedPart4Hours("Taser");
	}
	public function lumiWorkshopSafetyBubble():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 1;
		CampStatsAndResources.NailsResc -= 100;
		CampStatsAndResources.EnergyCoreResc -= 1;
		lumiWorkshopSharedPart4Hours("Safety bubble");
	}
	public function lumiWorkshopImprovedArtificialIntelligenceMK4():void {
		clearOutput();
		CampStatsAndResources.EnergyCoreResc -= 10;
		player.destroyItems(consumables.VOLTTOP, 10);
		player.removeKeyItem("Improved Artificial Intelligence MK3");
		lumiWorkshopSharedPart12Hours("Improved Artificial Intelligence MK4");
	}
	public function lumiWorkshopImprovedArtificialIntelligenceMK3():void {
		clearOutput();
		CampStatsAndResources.EnergyCoreResc -= 5;
		player.destroyItems(consumables.VOLTTOP, 5);
		player.removeKeyItem("Improved Artificial Intelligence MK2");
		lumiWorkshopSharedPart12Hours("Improved Artificial Intelligence MK3");
	}
	public function lumiWorkshopImprovedArtificialIntelligenceMK2():void {
		clearOutput();
		CampStatsAndResources.EnergyCoreResc -= 5;
		player.removeKeyItem("Improved Artificial Intelligence");
		lumiWorkshopSharedPart8Hours("Improved Artificial Intelligence MK2");
	}
	public function lumiWorkshopImprovedArtificialIntelligence():void {
		clearOutput();
		CampStatsAndResources.EnergyCoreResc -= 1;
		player.removeKeyItem("Artificial Intelligence");
		lumiWorkshopSharedPart4Hours("Improved Artificial Intelligence");
	}
	public function lumiWorkshopArtificialIntelligence():void {
		clearOutput();
		player.destroyItems(useables.GOLCORE, 1);
		lumiWorkshopSharedPart4Hours("Artificial Intelligence");
	}
	public function lumiWorkshopHydraulicsMK6():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 50;
		player.removeKeyItem("Hydraulics MK5");
		lumiWorkshopSharedPart12Hours("Hydraulics MK6");
	}
	public function lumiWorkshopHydraulicsMK5():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 40;
		player.removeKeyItem("Hydraulics MK4");
		lumiWorkshopSharedPart12Hours("Hydraulics MK5");
	}
	public function lumiWorkshopHydraulicsMK4():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 30;
		player.removeKeyItem("Hydraulics MK3");
		lumiWorkshopSharedPart8Hours("Hydraulics MK4");
	}
	public function lumiWorkshopHydraulicsMK3():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 20;
		player.removeKeyItem("Hydraulics MK2");
		lumiWorkshopSharedPart8Hours("Hydraulics MK3");
	}
	public function lumiWorkshopHydraulicsMK2():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 10;
		player.removeKeyItem("Hydraulics");
		lumiWorkshopSharedPart4Hours("Hydraulics MK2");
	}
	public function lumiWorkshopHydraulics():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 5;
		lumiWorkshopSharedPart4Hours("Hydraulics");
	}
	public function lumiWorkshopImprovedAmmoChemistryMK6():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 30;
		player.destroyItems(consumables.SALAMFW, 10);
		player.destroyItems(consumables.METHIRC, 10);
		player.removeKeyItem("Improved Ammo Chemistry MK5");
		lumiWorkshopSharedPart4Hours("Improved Ammo Chemistry MK6");
	}
	public function lumiWorkshopImprovedAmmoChemistryMK5():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 25;
		player.destroyItems(consumables.SALAMFW, 10);
		player.destroyItems(consumables.METHIRC, 5);
		player.removeKeyItem("Improved Ammo Chemistry MK4");
		lumiWorkshopSharedPart4Hours("Improved Ammo Chemistry MK5");
	}
	public function lumiWorkshopImprovedAmmoChemistryMK4():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 20;
		player.destroyItems(consumables.SALAMFW, 5);
		player.removeKeyItem("Improved Ammo Chemistry MK3");
		lumiWorkshopSharedPart4Hours("Improved Ammo Chemistry MK4");
	}
	public function lumiWorkshopImprovedAmmoChemistryMK3():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 15;
		player.destroyItems(consumables.SALAMFW, 1);
		player.removeKeyItem("Improved Ammo Chemistry MK2");
		lumiWorkshopSharedPart4Hours("Improved Ammo Chemistry MK3");
	}
	public function lumiWorkshopImprovedAmmoChemistryMK2():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 10;
		player.removeKeyItem("Improved Ammo Chemistry");
		lumiWorkshopSharedPart4Hours("Improved Ammo Chemistry MK2");
	}
	public function lumiWorkshopImprovedAmmoChemistry():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 5;
		lumiWorkshopSharedPart4Hours("Improved Ammo Chemistry");
	}
	public function lumiWorkshopMachineGunMK6():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 25;
		CampStatsAndResources.NailsResc -= 1000;
		CampStatsAndResources.MechanismResc -= 20;
		player.removeKeyItem("Machine Gun MK5");
		lumiWorkshopSharedPart12Hours("Machine Gun MK6");
	}
	public function lumiWorkshopMachineGunMK5():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 20;
		CampStatsAndResources.NailsResc -= 800;
		CampStatsAndResources.MechanismResc -= 15;
		player.removeKeyItem("Machine Gun MK4");
		lumiWorkshopSharedPart12Hours("Machine Gun MK5");
	}
	public function lumiWorkshopMachineGunMK4():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 15;
		CampStatsAndResources.NailsResc -= 700;
		CampStatsAndResources.MechanismResc -= 10;
		player.removeKeyItem("Machine Gun MK3");
		lumiWorkshopSharedPart8Hours("Machine Gun MK4");
	}
	public function lumiWorkshopMachineGunMK3():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 15;
		CampStatsAndResources.NailsResc -= 600;
		CampStatsAndResources.MechanismResc -= 10;
		player.removeKeyItem("Machine Gun MK2");
		lumiWorkshopSharedPart8Hours("Machine Gun MK3");
	}
	public function lumiWorkshopMachineGunMK2():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 10;
		CampStatsAndResources.NailsResc -= 500;
		CampStatsAndResources.MechanismResc -= 5;
		player.removeKeyItem("Machine Gun MK1");
		lumiWorkshopSharedPart8Hours("Machine Gun MK2");
	}
	public function lumiWorkshopMachineGunMK1():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 10;
		CampStatsAndResources.NailsResc -= 200;
		CampStatsAndResources.MechanismResc -= 5;
		player.removeKeyItem("Repeater Gun");
		lumiWorkshopSharedPart4Hours("Machine Gun MK1");
	}
	public function lumiWorkshopRepeaterGun():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 2;
		CampStatsAndResources.NailsResc -= 100;
		lumiWorkshopSharedPart4Hours("Repeater Gun");
	}
	public function lumiWorkshopDynapunchGlove():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 2;
		CampStatsAndResources.NailsResc -= 100;
		CampStatsAndResources.MechanismResc -= 1;
		lumiWorkshopSharedPart4Hours("Dynapunch Glove");
	}
	public function lumiWorkshopWhitefireBeamCannon():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 20;
		CampStatsAndResources.NailsResc -= 500;
		CampStatsAndResources.EnergyCoreResc -= 5;
		lumiWorkshopSharedPart8Hours("Whitefire Beam Cannon");
	}
	public function lumiWorkshopSnowballGenerator():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 20;
		CampStatsAndResources.NailsResc -= 500;
		CampStatsAndResources.EnergyCoreResc -= 5;
		lumiWorkshopSharedPart8Hours("Snowball Generator");
	}
	public function lumiWorkshopRaijinBlaster():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 15;
		CampStatsAndResources.NailsResc -= 500;
		CampStatsAndResources.MechanismResc -= 2;
		CampStatsAndResources.EnergyCoreResc -= 5;
		player.destroyItems(useables.RPLASMA, 5);
		lumiWorkshopSharedPart8Hours("Raijin blaster");
	}
	public function lumiWorkshopGravityShots():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 15;
		CampStatsAndResources.NailsResc -= 500;
		CampStatsAndResources.MechanismResc -= 2;
		CampStatsAndResources.EnergyCoreResc -= 5;
		lumiWorkshopSharedPart8Hours("Gravity shots");
	}
	public function lumiWorkshopMedicalDispenser2():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 20;
		CampStatsAndResources.NailsResc -= 500;
		CampStatsAndResources.EnergyCoreResc -= 5;
		player.destroyItems(consumables.H_PILL, 5);
		player.removeKeyItem("Stimpack Dispenser 1.0");
		lumiWorkshopSharedPart12Hours("Medical Dispenser 2.0");
	}
	public function lumiWorkshopStimpackDispenser1():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 10;
		CampStatsAndResources.NailsResc -= 200;
		player.destroyItems(consumables.H_PILL, 5);
		lumiWorkshopSharedPart4Hours("Stimpack Dispenser 1.0");
	}
	public function lumiWorkshopOmniMissile():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 20;
		CampStatsAndResources.NailsResc -= 500;
		CampStatsAndResources.MechanismResc -= 10;
		player.removeKeyItem("Missile launcher");
		lumiWorkshopSharedPart12Hours("Omni Missile");
	}
	public function lumiWorkshopMissileLauncher():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 10;
		CampStatsAndResources.NailsResc -= 500;
		CampStatsAndResources.MechanismResc -= 5;
		lumiWorkshopSharedPart8Hours("Missile launcher");
	}
	public function lumiWorkshopLustnadeLauncher():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 20;
		CampStatsAndResources.NailsResc -= 500;
		CampStatsAndResources.MechanismResc -= 10;
		player.destroyItems(consumables.L_DRAFT, 10);
		player.removeKeyItem("Aphrodigas Gun");
		lumiWorkshopSharedPart4Hours("Lustnade Launcher");
	}
	public function lumiWorkshopAphrodigasGun():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 2;
		CampStatsAndResources.NailsResc -= 100;
		player.destroyItems(consumables.L_DRAFT, 5);
		lumiWorkshopSharedPart4Hours("Aphrodigas Gun");
	}
	public function lumiWorkshopImpregnator1():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 5;
		CampStatsAndResources.NailsResc -= 100;
		lumiWorkshopSharedPart4Hours("Impregnator 1.0");
	}
	public function lumiWorkshopSPMK1():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 1;
		lumiWorkshopSharedPart4Hours("SPMK1");
	}
	public function lumiWorkshopCumReservoir():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 5;
		CampStatsAndResources.NailsResc -= 100;
		lumiWorkshopSharedPart4Hours("Cum Reservoir");
	}
	public function lumiWorkshopMK2Jetpack():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 10;
		CampStatsAndResources.NailsResc -= 300;
		CampStatsAndResources.EnergyCoreResc -= 2;
		player.removeKeyItem("Jetpack");
		lumiWorkshopSharedPart8Hours("MK2 Jetpack");
	}
	public function lumiWorkshopJetpack():void {
		clearOutput();
		CampStatsAndResources.MetalPieces -= 3;
		CampStatsAndResources.NailsResc -= 100;
		CampStatsAndResources.EnergyCoreResc -= 1;
		lumiWorkshopSharedPart4Hours("Jetpack");
	}
	public function lumiWorkshopAutoTurretMK6():void {
		clearOutput();
		CampStatsAndResources.MechanismResc -= 25;
		player.removeKeyItem("Auto turret MK5");
		lumiWorkshopSharedPart12Hours("Auto turret MK6");
	}
	public function lumiWorkshopAutoTurretMK5():void {
		clearOutput();
		CampStatsAndResources.MechanismResc -= 20;
		player.removeKeyItem("Auto turret MK4");
		lumiWorkshopSharedPart12Hours("Auto turret MK5");
	}
	public function lumiWorkshopAutoTurretMK4():void {
		clearOutput();
		CampStatsAndResources.MechanismResc -= 15;
		player.removeKeyItem("Auto turret MK3");
		lumiWorkshopSharedPart8Hours("Auto turret MK4");
	}
	public function lumiWorkshopAutoTurretMK3():void {
		clearOutput();
		CampStatsAndResources.MechanismResc -= 10;
		player.removeKeyItem("Auto turret MK2");
		lumiWorkshopSharedPart8Hours("Auto turret MK3");
	}
	public function lumiWorkshopAutoTurretMK2():void {
		clearOutput();
		CampStatsAndResources.MechanismResc -= 5;
		player.removeKeyItem("Auto turret");
		lumiWorkshopSharedPart4Hours("Auto turret MK2");
	}
	public function lumiWorkshopAutoTurret():void {
		clearOutput();
		CampStatsAndResources.MechanismResc -= 1;
		lumiWorkshopSharedPart4Hours("Auto turret");
	}
	public function lumiWorkshopSharedPart4Hours(itemName:String):void {
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new "+itemName+" is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem(""+itemName+"", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - "+itemName+"");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) endEncounter();
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopSharedPart8Hours(itemName:String):void {
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new "+itemName+" is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem(""+itemName+"", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - "+itemName+"");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseFourHours);
		else doNext(camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopSharedPart12Hours(itemName:String):void {
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "eight":"twelve")+" hours your brand new "+itemName+" is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem(""+itemName+"", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - "+itemName+"");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseEightHours);
		else doNext(camp.returnToCampUseTwelveHours);
	}
}
}
//