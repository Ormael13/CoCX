package classes.Scenes.Explore {
import classes.*;
import classes.GlobalFlags.kFLAGS;

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
            doYesNo(lumiLabChoices, camp.returnToCampUseOneHour);
        }
        else {
            //placeholder text for outside the cathedral
            outputText("You spot the door standing in the middle of nowhere again, and you guess that it will lead you back to Lumi's laboratory.  It swings open easily...");
            doNext(lumiLabChoices);
        }
//end of placeholder text
    }

    public function lumiLabChoices():void {
        spriteSelect(37);
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
		if (lumiEnhance(true)) addButton(0, "Enhance", lumiEnhance);
		addButton(1, "Shop", lumiShop);
		if (player.hasStatusEffect(StatusEffects.LumiWorkshop)) {
			addButton(2, "Engineering", lumiEngineering);
			addButton(3, "Workshop", lumiWorkshop);
			if (player.statusEffectv2(StatusEffects.LumiWorkshop) < 1) addButton(5, "GoblinMech", lumiGarageRetry);
		}
		else addButton(3, "Garage", lumiGarage).hint("Click only if you're goblin (10+ in goblin score) with 500+ gems ;)");
		addButton(4, "Leave", camp.returnToCampUseOneHour);
        /*var enhance:Function = null;
        if (lumiEnhance(true))
            enhance = lumiEnhance;*/
    }
	
    public function lumiEnhance(justCheck:Boolean = false):Boolean {
        var improvables:Array = [
            [consumables.FOXBERY,consumables.VIXVIGR],
            [consumables.FOXJEWL,consumables.MYSTJWL],
            [consumables.GLDSEED,consumables.MAGSEED],
            [consumables.KANGAFT,consumables.MGHTYVG],
            [consumables.L_DRAFT,consumables.F_DRAFT],
            [consumables.LABOVA_,consumables.PROBOVA],
            //[consumables.OVIELIX,consumables.OVIMAX_],
            [consumables.SDELITE,consumables.S_DREAM],
            [consumables.PIGTRUF,consumables.BOARTRU],
            [consumables.PURHONY,consumables.SPHONEY],
            [consumables.REDVIAL,consumables.VAMPBLD],
            [consumables.ECTOPLS,consumables.PROTPLS]
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
                    addButton(i,improvables[i][0].shortName,lumiEnhanceGo,improvables[i][0],improvables[i][1]);
                } else {
                    addButtonDisabled(i,improvables[i][0].shortName);
                }
            }
            addButton(14, "Back", lumiLabChoices);
            return true;
        }
    }
    private function lumiEnhanceGo(itype:ItemType,nextItem:ItemType):void{
        spriteSelect(37);
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
        inventory.takeItem(nextItem, lumiEnhance, lumiLabChoices);
    }

    public function lumiShop():void {
        spriteSelect(37);
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
		addButton(14, "Leave", lumiLabChoices);
    }
//Lust Draft
    private function lumiLustDraftPitch():void {
        spriteSelect(37);
        clearOutput();
        outputText("You point at the bottle filled with bubble-gum pink fluid.\n\n\"<i>De lust dwaft? Always a favowite, with it you nevar have to worwy about not bein weady for sexy time; one of my fiwst creations. 15 gems each.</i>\"\n\n");
        outputText("Will you buy the lust draft?");
        doYesNo(curry(lumiPurchase, consumables.L_DRAFT), lumiShop);
    }
//Goblin Ale
    private function lumiPitchGobboAle():void {
        spriteSelect(37);
        clearOutput();
        outputText("You point at the flagon. \"<i>Oh? Oh thats Lumi's... actually no, dat tispsy stuff for 20 gems. You'll like if you want to be like Lumi. Do you like it?</i>\"\n\n");
        outputText("Will you buy the goblin ale?");
        doYesNo(curry(lumiPurchase, consumables.GOB_ALE), lumiShop);
    }
//Ovi Elixir
    private function lumiPitchOviElixer():void {
        spriteSelect(37);
        clearOutput();
        outputText("You point at the curious hexagonal bottle. \"<i>De Oviposar Elixir? Made baithsed on da giant bee's special stuff dey give deir queen. It will help make de burfing go faster, an if you dwink it while you awen pweggy, iw will give you some eggs to burf later. More dwinks, eqwals more and biggar eggs. Lumi charges 45 gems for each dose.</i>\"\n\n");
        outputText("Will you buy the Ovi Elixir?");
        doYesNo(curry(lumiPurchase, consumables.OVIELIX), lumiShop);
    }
//Goblin Technomancer clothes
    private function lumiPitchGoblinTechnomancerClothes():void {
        spriteSelect(37);
        clearOutput();
        outputText("Lumi nods at your pick. \"<i>Buyin dese? Smart move. Nevar ouant ta work ouit stuff dats gunna gat ruined if some oil drips on it. Dese are true mechanist clothes. Sturdy, durable and best ov all, adaptable ta any gadget ya may plug ta dem.</i>\"\n\n");
        outputText("Will you buy the Goblin Technomancer clothes? (for 400 gems)");
        doYesNo(curry(lumiPurchase, armors.GTECHC_), lumiShop);
    }
//Technomancer bra
    private function lumiPitchTechnomancerBra():void {
        spriteSelect(37);
        clearOutput();
        outputText("Lumi nods at your pick. \"<i>Buyin dese? Smart move. Nevar ouant ta work ouit stuff dats gunna gat ruined if some oil drips on it. Dese are true mechanist clothes. Sturdy, durable and best ov all, adaptable ta any gadget ya may plug ta dem.</i>\"\n\n");
        outputText("Will you buy the Technomancer bra? (for 600 gems)");
        doYesNo(curry(lumiPurchase, undergarments.TECHBRA), lumiShop);
    }
//Technomancer panties
    private function lumiPitchTechnomancerPanties():void {
        spriteSelect(37);
        clearOutput();
        outputText("Lumi nods at your pick. \"<i>Buyin dese? Smart move. Nevar ouant ta work ouit stuff dats gunna gat ruined if some oil drips on it. Dese are true mechanist clothes. Sturdy, durable and best ov all, adaptable ta any gadget ya may plug ta dem.</i>\"\n\n");
        outputText("Will you buy the Technomancer panties? (for 600 gems)");
        doYesNo(curry(lumiPurchase, undergarments.T_PANTY), lumiShop);
    }
    private function lumiPurchase(itype:ItemType):void {
        spriteSelect(37);
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
	
	public function lumiGarage():void {
		spriteSelect(37);
        clearOutput();
        player.createStatusEffect(StatusEffects.LumiWorkshop,0,0,0,0);
		outputText("In the corner of Lumi’s weird shop, there is a large door to a room filled with similarly weird items, you ask Lumi about them.\n\n");
		outputText("\"<i>Oh ya lookin fer goblin tech? It's not fer sale but I sell pieces and tools fer engineers. Perhaps ya would be interested into a Cock axial resonator or a vibrafronics spinning battery?</i>\"\n\n");
		outputText("You didn’t understand half of what she said and admit as much.\n\n");
		outputText("\"<i>Ah, go fegures. True genius is dyin thase days. Sure, I make sex toys and poetions but I think the true arft still is in a functional goblin mech!</i>\"\n\n");
		outputText("A goblin mech?\n\n");
		outputText("\"<i>I often forget fome people especially non goblin don’t exactly know what a mech is…basically it’s a sort ov combat confraption a goblin can drive. I have an alpha version jast right dere");
		if (player.goblinScore() >= 10) {
			outputText("if you have da gems fer it.</i>\"\n\n");
			outputText("She points at what looks like a goblin sized seat mounted on a weird six legged contraption.\n\n");
			outputText("\"<i>It can ba customised in dozens of ways if yer smart enough and have da time fer it. Fer only 500 gem it’s yours... Interested?</i>\"\n\n");
			menu();
			addButton(1, "Yes", lumiGarageYes);
			addButton(3, "No", lumiGarageNo);
			return;
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
			inventory.takeItem(vehicles.GOBMALP, camp.returnToCampUseOneHour);
		}
		else {
			outputText("You would love to purchase the mech but you are somewhat low on gems.\n\n");
			outputText("\"<i>Well that’s a shame but nonetheless ya can always just come back lafer right?</i>\"\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
	}
	public function lumiGarageNo():void {
		outputText("You tell the goblin you will think it over and leave the shop.\n\n");
		doNext(camp.returnToCampUseOneHour);
	}
	public function lumiGarageRetry():void {
		outputText("You inquire on the goblin mech.\n\n");
		outputText("\"<i>Oh ya came back on your decision? Sure I still have it in the backroom. 500 gems as before.</i>\"\n\n");
		menu();
		if (player.goblinScore() >= 10) addButton(1, "Yes", lumiGarageYes);
		else addButtonDisabled(1, "Yes", "You still not enough goblin to get this beauty. Money can't buy everything, ok?");
		addButton(3, "No", lumiGarageNo);
	}
	
	public function lumiEngineering():void {
		spriteSelect(37);
        clearOutput();
        outputText("I will ask Lia to write smth for this section.\n\n");
		menu();
		addButton(0, "Metal pieces", lumiEngineeringBuyMetalPieces);
		if (player.hasKeyItem("Blueprint - Energy Core") < 0) addButton(1, "EnergyCore BP", lumiEngineeringBuyBlueprintEnergyCore).hint("Energy Core BP - 50 gems");
		else addButtonDisabled(1, "EnergyCore BP", "Already having this blueprint.");
		if (player.hasKeyItem("Blueprint - Mechanism") < 0) addButton(2, "Mechanism BP", lumiEngineeringBuyBlueprintMechanism).hint("Mechanism BP - 50 gems");
		else addButtonDisabled(2, "Mechanism BP", "Already having this blueprint.");
		if (player.hasKeyItem("Toolbelt") < 0 && player.hasKeyItem("Blueprint - Toolbelt") < 0) addButton(3, "Toolbelt", lumiEngineeringBuyBlueprintToolbelt).hint("Toolbelt BP - 100 gems");
		else addButtonDisabled(3, "Toolbelt", "Already having this blueprint.");
		if (player.hasKeyItem("Potent Drug injectors") < 0 && player.hasKeyItem("Blueprint - Potent Drug injectors") < 0) addButton(4, "Potent Drug injectors", lumiEngineeringBuyBlueprintPotentDrugInjectors).hint("Potent Drug injectors BP - 1000 gems");
		if (player.hasKeyItem("Improved Drug injectors") < 0 && player.hasKeyItem("Potent Drug injectors") < 0 && player.hasKeyItem("Blueprint - Improved Drug injectors") < 0) addButton(4, "Improved Drug injectors", lumiEngineeringBuyBlueprintImprovedDrugInjectors).hint("Improved Drug injectors BP - 500 gems");
		if (player.hasKeyItem("Drug injectors") < 0 && player.hasKeyItem("Improved Drug injectors") < 0 && player.hasKeyItem("Potent Drug injectors") < 0 && player.hasKeyItem("Blueprint - Drug injectors") < 0) addButton(4, "Drug injectors", lumiEngineeringBuyBlueprintDrugInjectors).hint("Drug injectors BP - 100 gems");
		if (player.hasKeyItem("Gun Scope with Aimbot") < 0 && player.hasKeyItem("Blueprint - Gun Scope with Aimbot") < 0) addButton(5, "Gun Scope with Aimbot", lumiEngineeringBuyBlueprintGunScopeWithAimbot).hint("Gun Scope with Aimbot BP - 1000 gems");
		if (player.hasKeyItem("Gun Scope with Aim tech") < 0 && player.hasKeyItem("Gun Scope with Aimbot") < 0 && player.hasKeyItem("Blueprint - Gun Scope with Aim tech") < 0) addButton(5, "Gun Scope with Aim tech", lumiEngineeringBuyBlueprintGunScopeWithAimTech).hint("Gun Scope with Aim tech BP - 500 gems");
		if (player.hasKeyItem("Gun Scope") < 0 && player.hasKeyItem("Gun Scope with Aim tech") < 0 && player.hasKeyItem("Gun Scope with Aimbot") < 0 && player.hasKeyItem("Blueprint - Gun Scope") < 0) addButton(5, "Gun Scope", lumiEngineeringBuyBlueprintGunScope).hint("Gun Scope BP - 100 gems");
		if (player.hasKeyItem("Blueprint - S.A Tech Goggle") < 0 && player.hasKeyItem("Blueprint - Scanner goggle") >= 0) addButton(6, "S.A Tech Goggle", lumiEngineeringBuyBlueprintSATechGoggle).hint("S.A Tech Goggle BP - 1000 gems");
		if (player.hasKeyItem("Blueprint - Scanner goggle") < 0 && player.hasKeyItem("Blueprint - Machinist Goggles") >= 0) addButton(6, "Scanner goggle", lumiEngineeringBuyBlueprintScannerGoggle).hint("Scanner goggle BP - 500 gems");
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
		if (player.hasKeyItem("Upgraded Armor plating 3.0") < 0 && player.hasKeyItem("Blueprint - Upgraded Armor plating 3.0") < 0) addButton(0, "UpgrArmor 3.0", lumiEngineeringBuyBlueprintUpgradedArmorPlating3).hint("Upgraded Armor plating 3.0 BP - 1000 gems");
		if (player.hasKeyItem("Upgraded Armor plating 2.0") < 0 && player.hasKeyItem("Upgraded Armor plating 3.0") < 0 && player.hasKeyItem("Blueprint - Upgraded Armor plating 2.0") < 0) addButton(0, "UpgrArmor 2.0", lumiEngineeringBuyBlueprintUpgradedArmorPlating2).hint("Upgraded Armor plating 2.0 BP - 500 gems");
		if (player.hasKeyItem("Upgraded Armor plating 1.0") < 0 && player.hasKeyItem("Upgraded Armor plating 2.0") < 0 && player.hasKeyItem("Upgraded Armor plating 3.0") < 0 && player.hasKeyItem("Blueprint - Upgraded Armor plating 1.0") < 0) addButton(0, "UpgrArmor 1.0", lumiEngineeringBuyBlueprintUpgradedArmorPlating1).hint("Upgraded Armor plating 1.0 BP - 100 gems");
		if (player.hasKeyItem("Taser with an overcharged battery") < 0 && player.hasKeyItem("Blueprint - Taser with an overcharged battery") < 0) addButton(1, "Taser O.B.", lumiEngineeringBuyBlueprintTaserOverchargeBattery).hint("Taser overcharge battery BP - 1000 gems");
		if (player.hasKeyItem("Taser") < 0 && player.hasKeyItem("Taser with an overcharged battery") < 0 && player.hasKeyItem("Blueprint - Taser") < 0) addButton(1, "Taser", lumiEngineeringBuyBlueprintTaser).hint("Taser BP - 500 gems");
		if (player.hasKeyItem("Safety bubble") < 0 && player.hasKeyItem("Blueprint - Safety bubble") < 0) addButton(2, "Safety bubble", lumiEngineeringBuyBlueprintSafetyBubble).hint("Safety bubble BP - 100 gems");
		if (player.hasKeyItem("Machine Gun MK3") < 0 && player.hasKeyItem("Blueprint - Machine Gun MK3") < 0) addButton(3, "Machine Gun MK3", lumiEngineeringBuyBlueprintMachineGunMK3).hint("Machine Gun MK3 BP - 2000 gems");
		if (player.hasKeyItem("Machine Gun MK2") < 0 && player.hasKeyItem("Machine Gun MK3") < 0 && player.hasKeyItem("Blueprint - Machine Gun MK2") < 0) addButton(3, "Machine Gun MK2", lumiEngineeringBuyBlueprintMachineGunMK2).hint("Machine Gun MK2 BP - 1000 gems");
		if (player.hasKeyItem("Machine Gun MK1") < 0 && player.hasKeyItem("Machine Gun MK2") < 0 && player.hasKeyItem("Machine Gun MK3") < 0 && player.hasKeyItem("Blueprint - Machine Gun MK1") < 0) addButton(3, "Machine Gun MK1", lumiEngineeringBuyBlueprintMachineGunMK1).hint("Machine Gun MK1 BP - 500 gems");
		if (player.hasKeyItem("Repeater Gun") < 0 && player.hasKeyItem("Machine Gun MK1") < 0 && player.hasKeyItem("Machine Gun MK2") < 0 && player.hasKeyItem("Machine Gun MK3") < 0 && player.hasKeyItem("Blueprint - Repeater Gun") < 0) addButton(3, "Repeater Gun", lumiEngineeringBuyBlueprintRepeaterGun).hint("Repeater Gun BP - 100 gems");
		if (player.hasKeyItem("Dynapunch Glove") < 0 && player.hasKeyItem("Blueprint - Dynapunch Glove") < 0) addButton(4, "Dynapunch G.", lumiEngineeringBuyBlueprintDynapunchGlove).hint("Dynapunch Glove BP - 500 gems");
		if (player.hasKeyItem("Whitefire Beam Cannon") < 0 && player.hasKeyItem("Blueprint - Whitefire Beam Cannon") < 0) addButton(5, "Whitefire B.C.", lumiEngineeringBuyBlueprintWhitefireBeamCannon).hint("Whitefire Beam Cannon BP - 1000 gems");
		if (player.hasKeyItem("Snowball Generator") < 0 && player.hasKeyItem("Blueprint - Snowball Generator") < 0) addButton(6, "Snowball G.", lumiEngineeringBuyBlueprintSnowballGenerator).hint("Snowball Generator BP - 1000 gems");
		if (player.hasKeyItem("Raijin blaster") < 0 && player.hasKeyItem("Blueprint - Raijin blaster") < 0 && player.hasKeyItem("Taser with an overcharged battery") >= 0) addButton(7, "Raijin blaster", lumiEngineeringBuyBlueprintRaijinBlaster).hint("Raijin blaster BP - 1500 gems");
		if (player.hasKeyItem("Gravity shots") < 0 && player.hasKeyItem("Blueprint - Gravity shots") < 0 && player.hasKeyItem("MK2 Jetpack") >= 0) addButton(8, "Gravity shots", lumiEngineeringBuyBlueprintGravityShots).hint("Gravity shots - 1000 gems");
		if (player.hasKeyItem("Medical Dispenser 2.0") < 0 && player.hasKeyItem("Blueprint - Medical Dispenser 2.0") < 0) addButton(9, "Medical Dispenser 2.0", lumiEngineeringBuyBlueprintMedicalDispenser2).hint("Medical Dispenser 2.0 BP - 500 gems");
		if (player.hasKeyItem("Stimpack Dispenser 1.0") < 0 && player.hasKeyItem("Medical Dispenser 2.0") < 0 && player.hasKeyItem("Blueprint - Stimpack Dispenser 1.0") < 0) addButton(9, "Stimpack Dispenser 1.0", lumiEngineeringBuyBlueprintStimpackDispenser1).hint("Stimpack Dispenser 1.0 BP - 100 gems");
		if (player.hasKeyItem("Omni Missile") < 0 && player.hasKeyItem("Blueprint - Omni Missile") < 0) addButton(10, "Omni Missile", lumiEngineeringBuyBlueprintOmniMissile).hint("Omni Missile BP - 1000 gems");
		if (player.hasKeyItem("Missile launcher") < 0 && player.hasKeyItem("Omni Missile") < 0 && player.hasKeyItem("Blueprint - Missile launcher") < 0) addButton(10, "Missile launcher", lumiEngineeringBuyBlueprintMissileLauncher).hint("Missile launcher BP - 500 gems");
		if (player.hasKeyItem("Lustnade Launcher") < 0 && player.hasKeyItem("Blueprint - Lustnade Launcher") < 0) addButton(11, "Lustnade Launcher", lumiEngineeringBuyBlueprintLustnadeLauncher).hint("Lustnade Launcher BP - 1000 gems");
		if (player.hasKeyItem("Aphrodigas Gun") < 0 && player.hasKeyItem("Lustnade Launcher") < 0 && player.hasKeyItem("Blueprint - Aphrodigas Gun") < 0) addButton(11, "Aphrodigas Gun", lumiEngineeringBuyBlueprintAphrodigasGun).hint("Aphrodigas Gun BP - 10 gems");
		if (player.hasKeyItem("Impregnator 1.0") < 0 && player.hasKeyItem("Blueprint - Impregnator 1.0") < 0) addButton(12, "Impregnator 1.0", lumiEngineeringBuyBlueprintImpregnator1).hint("Impregnator 1.0 BP - 100 gems");
		if (player.hasKeyItem("SPMK1") < 0 && player.hasKeyItem("Impregnator 1.0") < 0 && player.hasKeyItem("Blueprint - SPMK1") < 0) addButton(12, "SPMK1", lumiEngineeringBuyBlueprintSPMK1).hint("SPMK1 BP - 100 gems");
		if (player.hasKeyItem("Cum Reservoir") < 0 && player.hasKeyItem("SPMK1") < 0 && player.hasKeyItem("Impregnator 1.0") < 0 && player.hasKeyItem("Blueprint - Cum Reservoir") < 0) addButton(12, "Cum Reservoir", lumiEngineeringBuyBlueprintCumReservoir).hint("Cum Reservoir BP - 100 gems");
		if (player.hasKeyItem("MK2 Jetpack") < 0 && player.hasKeyItem("Blueprint - MK2 Jetpack") < 0) addButton(13, "MK2 Jetpack", lumiEngineeringBuyBlueprintMK2Jetpack).hint("MK2 Jetpack BP - 500 gems");
		if (player.hasKeyItem("Jetpack") < 0 && player.hasKeyItem("MK2 Jetpack") < 0 && player.hasKeyItem("Blueprint - Jetpack") < 0) addButton(13, "Jetpack", lumiEngineeringBuyBlueprintJetpack).hint("Jetpack BP - 100 gems");
		addButton(14, "Back", lumiEngineering);
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
	}
	public function lumiEngineeringBuyBlueprintDynapunchGlove():void {
		clearOutput();
		if (player.gems >= 500) {
			player.gems -= 500;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Dynapunch Glove!</b>");
			player.createKeyItem("Blueprint - Dynapunch Glove", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintWhitefireBeamCannon():void {
		clearOutput();
		if (player.gems >= 1000) {
			player.gems -= 1000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Whitefire Beam Cannon!</b>");
			player.createKeyItem("Blueprint - Whitefire Beam Cannon", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintSnowballGenerator():void {
		clearOutput();
		if (player.gems >= 1000) {
			player.gems -= 1000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Snowball Generator!</b>");
			player.createKeyItem("Blueprint - Snowball Generator", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintRaijinBlaster():void {
		clearOutput();
		if (player.gems >= 1500) {
			player.gems -= 1500;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Raijin blaster!</b>");
			player.createKeyItem("Blueprint - Raijin blaster", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintGravityShots():void {
		clearOutput();
		if (player.gems >= 1000) {
			player.gems -= 1000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Gravity shots!</b>");
			player.createKeyItem("Blueprint - Gravity shots", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintMedicalDispenser2():void {
		clearOutput();
		if (player.gems >= 500) {
			player.gems -= 500;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Medical Dispenser 2.0!</b>");
			player.createKeyItem("Blueprint - Medical Dispenser 2.0", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintStimpackDispenser1():void {
		clearOutput();
		if (player.gems >= 100) {
			player.gems -= 100;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Stimpack Dispenser 1.0!</b>");
			player.createKeyItem("Blueprint - Stimpack Dispenser 1.0", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintMissileLauncher():void {
		clearOutput();
		if (player.gems >= 500) {
			player.gems -= 500;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Missile launcher!</b>");
			player.createKeyItem("Blueprint - Missile launcher", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintOmniMissile():void {
		clearOutput();
		if (player.gems >= 1000) {
			player.gems -= 1000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Omni Missile!</b>");
			player.createKeyItem("Blueprint - Omni Missile", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintAphrodigasGun():void {
		clearOutput();
		if (player.gems >= 100) {
			player.gems -= 100;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Aphrodigas Gun!</b>");
			player.createKeyItem("Blueprint - Aphrodigas Gun", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintLustnadeLauncher():void {
		clearOutput();
		if (player.gems >= 1000) {
			player.gems -= 1000;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Lustnade Launcher!</b>");
			player.createKeyItem("Blueprint - Lustnade Launcher", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintCumReservoir():void {
		clearOutput();
		if (player.gems >= 100) {
			player.gems -= 100;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Cum Reservoir!</b>");
			player.createKeyItem("Blueprint - Cum Reservoir", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintSPMK1():void {
		clearOutput();
		if (player.gems >= 100) {
			player.gems -= 100;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - SPMK1!</b>");
			player.createKeyItem("Blueprint - SPMK1", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintImpregnator1():void {
		clearOutput();
		if (player.gems >= 100) {
			player.gems -= 100;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Impregnator 1.0!</b>");
			player.createKeyItem("Blueprint - Impregnator 1.0", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintJetpack():void {
		clearOutput();
		if (player.gems >= 500) {
			player.gems -= 500;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Jetpack!</b>");
			player.createKeyItem("Blueprint - Jetpack", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintMK2Jetpack():void {
		clearOutput();
		if (player.gems >= 100) {
			player.gems -= 100;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - MK2 Jetpack!</b>");
			player.createKeyItem("Blueprint - MK2 Jetpack", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}/*
	public function lumiEngineeringBuyBlueprintToolbelt():void {
		clearOutput();
		if (player.gems >= 50) {
			player.gems -= 100;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Toolbelt!</b>");
			player.createKeyItem("Blueprint - Toolbelt", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}*/
	public function lumiEngineeringBuyBlueprintEnergyCore():void {
		clearOutput();
		if (player.gems >= 50) {
			player.gems -= 50;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Energy Core!</b>");
			player.createKeyItem("Blueprint - Energy Core", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(lumiEngineering);
		}
		else lumiEngineeringBuyBlueprintNotEnoughGems();
	}
	public function lumiEngineeringBuyBlueprintMechanism():void {
		clearOutput();
		if (player.gems >= 50) {
			player.gems -= 50;
			outputText("Lumi seals the blueprint in a tube and displays it on the counter.\n\n");
			outputText("\"<i>Greaf far you that ya starting a new project. Ya tell me the result in a few days gotcha?</i>\"\n\n");
			outputText("<b>Gained Key Item: Blueprint - Mechanism!</b>");
			player.createKeyItem("Blueprint - Mechanism", 0, 0, 0, 0);
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
		outputText("\"<i>Metal plate ya say? Ya it'l only be 200 gems each hun.</i>\"\n\n");
		/*if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) {
			outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WCAMP_CABIN_METAL_PIECES_RESOURCESOOD_RESOURCES] + "/600")
		}
		else if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 3) {*/
			outputText("Metal Pieces: " + flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] + "/200");
		//}
		menu();
		if (player.gems >= 200) addButton(0, "Buy 1", lumiEngineeringBuyMetalPiecesAmount, 1);
		else addButtonDisabled(0, "Buy 1", "Not enough gems.");
		if (player.gems >= 1000) addButton(1, "Buy 5", lumiEngineeringBuyMetalPiecesAmount, 5);
		else addButtonDisabled(1, "Buy 5", "Not enough gems.");
		if (player.gems >= 2000) addButton(2, "Buy 10", lumiEngineeringBuyMetalPiecesAmount, 10);
		else addButtonDisabled(2, "Buy 10", "Not enough gems.");
		if (player.gems >= 3000) addButton(3, "Buy 15", lumiEngineeringBuyMetalPiecesAmount, 15);
		else addButtonDisabled(3, "Buy 15", "Not enough gems.");
		if (player.gems >= 4000) addButton(4, "Buy 20", lumiEngineeringBuyMetalPiecesAmount, 20);
		else addButtonDisabled(4, "Buy 20", "Not enough gems.");
		addButton(14, "Back", lumiEngineering);
	}	
	private function lumiEngineeringBuyMetalPiecesAmount(amount:int):void {
		metal_pieces = amount;
		clearOutput();
		player.gems -= (metal_pieces * 200);
		//flags[kFLAGS.ACHIEVEMENT_PROGRESS_IM_NO_LUMBERJACK] += metal_pieces;
		//if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_IM_NO_LUMBERJACK] >= 100) awardAchievement("I'm No Lumberjack", kACHIEVEMENTS.GENERAL_IM_NO_LUMBERJACK);
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] += metal_pieces;
		outputText("Lumi get you a box of those from her backroom.\n\n\"<i>Ta craft stuff ya need metal fortunately fer you I got plenty of dese.</i>\"\n\n");
		/*if (flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] > 600 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) {
			outputText("Unfortunately, your metal pieces supply seem to be full. You inform her. She refunds you the gems.\n\n");
			player.gems += ((flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] - 600) * 200);
			flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= (flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] - 600);
			outputText("Metal Pieces: " + flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] + "/600");
		}
		else */if (flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] > 200) {// && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 3
			outputText("Unfortunately, your metal pieces supply seem to be full. You inform her. She refunds you the gems.\n\n");
			player.gems += ((flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] - 200) * 200);
			flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= (flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] - 200);
			outputText("Metal Pieces: " + flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] + "/200");
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
		if (player.goblinScore() >= 10) {
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
			outputText("Which blueprints will you work on today?\n\n");
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
			if (player.hasKeyItem("Blueprint - Energy Core") >= 0 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 5 && player.hasItem(useables.GOLCORE, 3)) addButton(0, "Energy Core", lumiWorkshopEnergyCore).hint("Energy Core - A power source for devices. Necessary for advanced engineering - 3 golem cores, 5 metal piece, 4 hours of work.");
			else addButtonDisabled(0, "Energy Core", "Req. 3 golem cores, 5 metal piece.");
			if (player.hasKeyItem("Blueprint - Mechanism") >= 0 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 5 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 200) addButton(1, "Mechanism", lumiWorkshopMechanism).hint("Mechanism - A complex set of gear and gyro. Necessary for advanced engineering - 200 nails, 5 metal piece, 4 hours of work.");
			else addButtonDisabled(1, "Mechanism", "Req. 200 nails, 5 metal piece.");
			if (player.hasKeyItem("Blueprint - Toolbelt") >= 0 && player.inte >= 25 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 1) addButton(2, "Toolbelt", lumiWorkshopToolbelt).hint("Toolbelt - A toolbelt to hang your various engineering tool such as arclight spanner and screwdrivers. To wear around the waist. Necessary for basic engineering - 25+ int, 1 metal piece, 4 hours of work.");
			else addButtonDisabled(2, "Toolbelt", "Req. 25+ Int, 1 metal piece.");
			if (player.hasKeyItem("Blueprint - Potent Drug injectors") >= 0 && player.inte >= 100 && player.hasKeyItem("Improved Drug injectors") >= 0 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 3 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 30 && player.hasItem(consumables.L_DRAFT, 15)) addButton(3, "P.D.Injectors", lumiWorkshopPotentDrugInjectors).hint("Potent Drug injectors - Improve the toolbelt with an even better drug injector to wear around your waist. Makes you hornier and slutier at all time thanks to the chemicals but at the same time raise your sensitivity. This improved version is even more potent - 100+ int, Improved Drug injectors, 3 metal pieces, 30 nails, 15 Lust Drafts, 12 hours of work");
			if (player.hasKeyItem("Blueprint - Improved Drug injectors") >= 0 && player.hasKeyItem("Drug injectors") >= 0 && player.inte >= 75 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 2 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 20 && player.hasItem(consumables.L_DRAFT, 10)) addButton(3, "I.D.Injectors", lumiWorkshopImprovedDrugInjectors).hint("Improved Drug injectors - Improve the toolbelt with a better drug injector to wear around your waist. Makes you hornier and slutier at all time thanks to the chemicals but at the same time raise your sensitivity. This improved version is more potent - 75+ int, Drug injectors, 2 metal pieces, 20 nails, 10 Lust Drafts, 8 hours of work");
			if (player.hasKeyItem("Blueprint - Drug injectors") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 1 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 10 && player.hasItem(consumables.L_DRAFT, 5)) addButton(3, "D,Injectors", lumiWorkshopDrugInjectors).hint("Drug injectors - Improve the toolbelt with a drug injector to wear around your waist. Makes you hornier and slutier at all time thanks to the chemicals but at the same time raise your sensitivity - 50+ int, Toolbelt, 1 metal piece, 10 nails, 5 Lust Drafts, 4 hours of work");
			if (player.hasKeyItem("Blueprint - Gun Scope with Aimbot") >= 0 && player.hasKeyItem("Gun Scope with Aim tech") >= 0 && player.inte >= 100 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 10 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 500 && player.hasItem(useables.ENECORE, 1)) addButton(4, "G.S./w Aimbot", lumiWorkshopGunScopeWithAimbot).hint("Gun Scope with Aimbot - A scope to attach to your gun for improved lethality. Increase damage and accuracy by 40% - 100+ int, Toolbelt, 10 metal pieces, 500 nails, 1 energy core and 12 hour work");
			if (player.hasKeyItem("Blueprint - Gun Scope with Aim tech") >= 0 && player.hasKeyItem("Gun Scope") >= 0 && player.inte >= 75 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 5 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 300) addButton(4, "G.S./w Aim tech", lumiWorkshopGunScopeWithAimTech).hint("Gun Scope with Aim tech - A scope to attach to your gun for improved lethality. Increase damage and accuracy by 30% - 75+ int, Gun Scope, 5 metal pieces, 300 nails, 8 hours of work");
			if (player.hasKeyItem("Blueprint - Gun Scope") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 1 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 100) addButton(4, "Gun Scope", lumiWorkshopGunScope).hint("Gun Scope - A scope to attach to your gun for improved lethality. Increase damage and accuracy by 20% - 50+ int, Toolbelt, 1 metal piece, 100 nails, 4 hours of work");
			if (player.hasKeyItem("Blueprint - Machinist Goggles") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 1 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 100) addButton(5, "Mach.Goggles", lumiWorkshopMachinistGoggles).hint("Machinist Goggles - A pair of ordinary machinist google. One of the basic tools of anyone working with engine. Helps prevent blindness - 50+ int, Toolbelt, 1 metal piece, 100 nails, 4 hours of work");
			else addButtonDisabled(5, "Mach.Goggles", "Req. 50+ int, Toolbelt, 1 metal piece, 100 nails.");
			if (player.hasKeyItem("Blueprint - Scanner goggle") >= 0 && player.inte >= 75 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 5 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 200 && player.hasItem(useables.ENECORE, 2) && player.hasItem(headjewelries.MACHGOG, 1)) addButton(6, "Scan.goggle", lumiWorkshopScannerGoggle).hint("Scanner goggle - This set of google naturally include a user interface and a scanner revealing information about your opponents - 75+ int, Machinist Goggles, 5 metal pieces, 200 nails, 2 energy core, 8 hours of work");
			else addButtonDisabled(6, "Scan.goggle", "Req. 75+ int, Machinist Goggles, 5 metal pieces, 200 nails, 2 energy core.");
			if (player.hasKeyItem("Blueprint - S.A Tech Goggle") >= 0 && player.inte >= 100 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 10 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 300 && player.hasItem(useables.ENECORE, 5) && player.hasItem(headjewelries.SCANGOG, 1)) addButton(7, "S.A.T.Goggle", lumiWorkshopSATechGoggle).hint("S.A Tech Goggle - Better than its previous iteration the Scanner google, the tech google actually also reveal opponent's flaws and weaknesses highlighting their vulnerability in red within the google glass. The fact it also has a complete logbook and access to previous encounter informations also helps catalogise foes weaknesses - 100+ int, Scanner goggle, 10 metal pieces, 300 nails, 5 energy core, 12 hours of work");
			else addButtonDisabled(7, "S.A.T.Goggle", "Req. 100+ int, Scanner goggle, 10 metal pieces, 300 nails, 5 energy core.");
			if (player.hasKeyItem("Blueprint - Nitro Boots") >= 0 && player.inte >= 100 && player.hasKeyItem("Rocket Boots") >= 0 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 15 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 300 && player.hasItem(useables.MECHANI, 3) && player.hasItem(consumables.SALAMFW, 5)) addButton(8, "Nitro Boots", lumiWorkshopNitroBoots).hint("Nitro Boots - This device allows you to increase your movement speed with nitro rockets. Also can be used to kick people in the face leaving some serious burns and even setting people on fire - 100+ int, Rocket Boots, 15 metal pieces, 300 nails, 3 mechanism, 5 salamander firewaters, 12 hours of work");
			if (player.hasKeyItem("Blueprint - Rocket Boots") >= 0 && player.inte >= 75 && player.hasKeyItem("Spring Boots") >= 0 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 10 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 200 && player.hasItem(useables.MECHANI, 2) && player.hasItem(consumables.SALAMFW, 1)) addButton(8, "Rocket Boots", lumiWorkshopRocketBoots).hint("Rocket Boots - This device allows you to increase your movement speed with rockets. Also can be used to kick people in the face - 75+ int, Spring Boots, 10 metal pieces, 200 nails, 1 salamander firewater, 2 mechanism, 8 hours of work");
			if (player.hasKeyItem("Blueprint - Spring Boots") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 5 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 100 && player.hasItem(useables.MECHANI, 1)) addButton(8, "Spring Boots", lumiWorkshopSpringBoots).hint("Spring Boots - This device allows you to increase your movement speed with springs - 50+ int, Toolbelt, 5 metal pieces, 100 nails, 1 mechanism, 4 hours of work");
			if (player.hasKeyItem("Blueprint - M.G.S. bracer") >= 0 && player.inte >= 100 && player.hasKeyItem("Powboy") >= 0 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 10 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 300 && player.hasItem(useables.ENECORE, 4)) addButton(9, "M.G.S. bracer", lumiWorkshopMGSBracer).hint("M.G.S. bracer - The Mega Goblin Super bracer increases your physical strength by injecting " + (silly() ? "nanomachine" : "drugs") + " whenever needed, which reacts in your goblin blood and may even repair damaged tissue. Furthermore it is equipped with a mighty energy shield that works as long as you are not using any armor. And lastly, it actually tells the hour of the day - 100+ int, Powboy, 10 metal pieces, 500 nails, 4 energy core, 12 hours of work");
			if (player.hasKeyItem("Blueprint - Powboy") >= 0 && player.inte >= 75 && player.hasKeyItem("Power bracer") >= 0 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 5 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 200 && player.hasItem(useables.ENECORE, 1)) addButton(9, "Powboy", lumiWorkshopPowboy).hint("Powboy - This bracer increase your physical strength by injecting drugs which reacts with your goblin blood. Furthermore it is equipped with an energy shield that work so long as you are not using armors. At last it actually tells the hour of the day. Like all drugs also increase sensitivity - 75+ int, Power bracer, 5 metal pieces, 200 nails, 1 energy core, 8 hours of work");
			if (player.hasKeyItem("Blueprint - Power bracer") >= 0 && (player.hasKeyItem("Drug injectors") >= 0 || player.hasKeyItem("Improved Drug injectors") >= 0 || player.hasKeyItem("Potent Drug injectors") >= 0) && player.inte >= 50 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 3 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 100 && player.hasItem(useables.ENECORE, 1)) addButton(9, "Power bracer", lumiWorkshopPowerBracer).hint("Power bracer - This bracer increase your physical strength by injecting drugs which reacts with your blood. A physical strength version of the drug injector to cope with your natural handicaps. Like all drugs also increase sensitivity - 50+ int, any Drug injector, 3 metal pieces, 100 nails, 1 energy core, 4 hours of work");
			if (player.hasKeyItem("Blueprint - Machined greatsword") >= 0 && (player.hasKeyItem("Power bracer") >= 0 || player.hasKeyItem("Powboy") >= 0 || player.hasKeyItem("M.G.S. bracer") >= 0) && player.hasPerk(PerkLib.JobWarrior) && player.inte >= 50 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 3 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 200 && player.hasItem(useables.ENECORE, 1) && player.hasItem(useables.MECHANI, 2)) addButton(10, "Mach. greatsword", lumiWorkshopMachinedGreatsword).hint("Machined greatsword - This greatsword is half invention half weapon. Instead of a sharp straight blade the weapon sides is a set of metal tooth's that constantly move in order to properly saw through flesh and more solid mather, creating grievous wounds. Very good for cutting down trees too - 50+ int, Job: Warrior, any Power bracer, 3 metal pieces, 200 nails, 1 energy core, 2 mechanism, 12 hours of work");
			else addButtonDisabled(10, "Mach. greatsword", "Req. 50+ int, Job: Warrior, any Power bracer, 3 metal pieces, 200 nails, 1 energy core, 2 mechanism.");
			if (player.hasKeyItem("Blueprint - Ripper 1.0") >= 0 && player.inte >= 75 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 10 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 500 && player.hasItem(useables.ENECORE, 2) && player.hasItem(useables.MECHANI, 5) && player.hasItem(weapons.MACGRSW, 1)) addButton(11, "Ripper 1.0", lumiWorkshopRipper1).hint("Ripper 1.0 - Similar to the machined great sword this weapon is highly mechanical. Instead of a sharp straight blade the weapon sides is a set of sharp metal tooth's that constantly move in order to properly saw through flesh and more solid mather, creating grievous wounds. Very good for cutting down trees to - 75+ int, Machined greatsword, 10 metal pieces, 500 nails, 2 energy core, 5 mechanism, 12 hours of work");
			else addButtonDisabled(11, "Ripper 1.0", "Req. 75+ int, Machined greatsword, 10 metal pieces, 500 nails, 2 energy core, 5 mechanism.");
			if (player.hasKeyItem("Blueprint - Ripper 2.0") >= 0 && player.inte >= 100 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 30 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 500 && player.hasItem(useables.ENECORE, 5) && player.hasItem(useables.MECHANI, 10) && player.hasItem(weapons.RIPPER1, 1)) addButton(12, "Ripper 2.0", lumiWorkshopRipper2).hint("Ripper 2.0 - Similar to the machined great sword this weapon is highly mechanical. Instead of a sharp straight blade the weapon sides is a set of sharp metal tooth's that constantly move in order to properly saw through flesh and more solid mather, creating grievous wounds. The blades movement is so fast it creates heat along the length and thanks to a small system set the saw constantly aflame. Aside of cutting fleshy things in half it is very good for taking down trees - 100+ int, Ripper 1.0, 30 metal pieces, 500 nails, 5 energy core, 10 mechanism, 12 hours of work");
			else addButtonDisabled(12, "Ripper 2.0", "Req. 100+ int, Ripper 1.0, 30 metal pieces, 500 nails, 5 energy core, 10 mechanism.");
			if (player.vehiclesName == "Goblin Mech Alpha" || player.vehiclesName == "Goblin Mech Prime") addButton(13, "Mech UPGR", lumiWorkshopMechUpgrades);
			else addButtonDisabled(13, "Mech UPGR", "You need to have goblin mech currently used to craft upgrades for it.");
			if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) addButton(14, "Back", playerMenu);
			else addButton(14, "Leave", camp.returnToCampUseOneHour);
		}
		else {
			spriteSelect(37);
			clearOutput();
			outputText("Lumi answers by the negative when you ask for the key to the workshop.\n\n");
			outputText("\"<i>Engineering is a goblin craft [name]. Its made <b>by</b> goblins <b>fer</b> goblins. Ya want in my workshop? Ya will have to look the part. I don't want to be responsible for some big oaf blowing " + player.mf("him", "herself") + " up with " + player.mf("his", "her") + " own explosives or shocking " + player.mf("him", "herself") + " to death with live wires.</i>\"\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
	}
	public function lumiWorkshopMechUpgrades():void {
		if (player.hasKeyItem("Blueprint - Upgraded Armor plating 3.0") >= 0) outputText("Upgraded Armor plating 3.0 - Req. 100+ int, Upgraded Armor plating 2.0, 20 metal pieces, 500 nails.\n");
		if (player.hasKeyItem("Blueprint - Upgraded Armor plating 2.0") >= 0) outputText("Upgraded Armor plating 2.0 - Req. 75+ int, Upgraded Armor plating 1.0, 10 metal pieces, 300 nails.\n");
		if (player.hasKeyItem("Blueprint - Upgraded Armor plating 1.0") >= 0) outputText("Upgraded Armor plating 1.0 - Req. 50+ int, 5 metal pieces, 200 nails.\n");
		if (player.hasKeyItem("Blueprint - Taser with an overcharged battery") >= 0) outputText("Taser with an overcharged battery - Req. 100+ int, Tazer, 15 metal pieces, 500 nails, 2 mechanism, 5 energy core.\n");
		if (player.hasKeyItem("Blueprint - Taser") >= 0) outputText("Taser - Req. 75+ int, Toolbelt, 10 metal pieces, 300 nails, 1 mechanism, 1 energy core.\n");
		if (player.hasKeyItem("Blueprint - Safety bubble") >= 0) outputText("Safety bubble - Req. 1 metal pieces, 100 nails, 1 energy core.\n");
		if (player.hasKeyItem("Blueprint - Machine Gun MK3") >= 0) outputText("Machine Gun MK3 - Req. 125+ int, 15 metal pieces, 500 nails, 10 mechanism.\n");
		if (player.hasKeyItem("Blueprint - Machine Gun MK2") >= 0) outputText("Machine Gun MK2 - Req. 100+ int, 10 metal pieces, 500 nails, 5 mechanism.\n");
		if (player.hasKeyItem("Blueprint - Machine Gun MK1") >= 0) outputText("Machine Gun MK1 - Req. 75+ int, 10 metal pieces, 200 nails, 5 mechanism.\n");
		if (player.hasKeyItem("Blueprint - Repeater Gun") >= 0) outputText("Repeater Gun - Req. 50+ int, 2 metal pieces, 100 nails.\n");
		if (player.hasKeyItem("Blueprint - Dynapunch Glove") >= 0) outputText("Dynapunch Glove - Req. 50+ int, 2 metal pieces, 100 nails, 1 mechanism.\n");
		if (player.hasKeyItem("Blueprint - Whitefire Beam Cannon") >= 0) outputText("Whitefire Beam Cannon - Req. 75+ int, knowing Whitefire spell, 20 metal pieces, 500 nails, 5 energy core.\n");
		if (player.hasKeyItem("Blueprint - Snowball Generator") >= 0) outputText("Snowball Generator - Req. 75+ int, knowing Ice Spike spell, 20 metal pieces, 500 nails, 5 energy core.\n");
		if (player.hasKeyItem("Blueprint - Raijin blaster") >= 0) outputText("Raijin blaster - Req. 100+ int, knowing Lightning Bolt spell, 15 metal pieces, 500 nails, 2 mechanism, 5 energy core, 5 raiju plasma.\n");
		if (player.hasKeyItem("Blueprint - Gravity shots") >= 0) outputText("Gravity shots - Req. 100+ int, knowing Darkness Shard spell, 15 metal pieces, 500 nails, 2 mechanism, 5 energy core.\n");
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
		menu();
		if (player.hasKeyItem("Blueprint - Upgraded Armor plating 3.0") >= 0 && player.hasKeyItem("Upgraded Armor plating 2.0") >= 0 && player.inte >= 100 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 20 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 500) addButton(0, "UpgrArmor 3.0", lumiWorkshopUpgradedArmorPlating3).hint("Upgraded Armor plating 3.0 - +15 armor/magic resistance to the mech. +50% Health. - 100+ int, Upgraded Armor plating 2.0, 20 metal pieces, 500 nails and 12 hours of work");
		if (player.hasKeyItem("Blueprint - Upgraded Armor plating 2.0") >= 0 && player.hasKeyItem("Upgraded Armor plating 1.0") >= 0 && player.inte >= 75 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 10 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 300) addButton(0, "UpgrArmor 2.0", lumiWorkshopUpgradedArmorPlating2).hint("Upgraded Armor plating 2.0 - +10 armor/magic resistance to the mech. +35% Health. - 75+ int, Upgraded Armor plating 1.0, 10 metal pieces, 300 nails and 8 hours of work");
		if (player.hasKeyItem("Blueprint - Upgraded Armor plating 1.0") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 5 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 200) addButton(0, "UpgrArmor 1.0", lumiWorkshopUpgradedArmorPlating1).hint("Upgraded Armor plating 1.0 - +5 armor/magic resistance to the mech. +20% Health. - 50+ int, Toolbelt, 5 metal pieces, 200 nails and 4 hours of work");
		if (player.hasKeyItem("Blueprint - Taser with an overcharged battery") >= 0 && player.hasKeyItem("Taser") >= 0 && player.inte >= 100 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 15 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 500 && player.hasItem(useables.ENECORE, 5) && player.hasItem(useables.MECHANI, 2)) addButton(1, "Tazer O.B.", lumiWorkshopTaserOverchargeBattery).hint("Taser with an overcharged battery - Increases the Taser’s effectiveness and paralysis duration. - 100+ int, Tazer, 15 metal pieces, 500 nails, 2 mechanism, 5 energy core and 8 hours of work");
		if (player.hasKeyItem("Blueprint - Taser") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 75 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 10 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 300 && player.hasItem(useables.ENECORE, 1) && player.hasItem(useables.MECHANI, 1)) addButton(1, "Tazer", lumiWorkshopTaser).hint("Tazer - Adds an Tazer option to your mech. - 75+ int, Toolbelt, 10 metal pieces, 300 nails, 1 mechanism, 1 energy core and 8 hours of work");
		if (player.hasKeyItem("Blueprint - Safety bubble") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.hasItem(useables.ENECORE, 1) && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 1 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 100) addButton(2, "Safety bubble", lumiWorkshopSafetyBubble).hint("Safety bubble - Allows you to use the mech underwater. Too fragile for standard combat use but provide fresh air. - 1 metal pieces, 100 nails, 1 energy core and 4 hours of work.");
		if (player.hasKeyItem("Blueprint - Machine Gun MK3") >= 0 && player.hasKeyItem("Machine Gun MK2") >= 0 && player.inte >= 125 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 15 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 500 && player.hasItem(useables.MECHANI, 10)) addButton(3, "Machine Gun MK3", lumiWorkshopMachineGunMK3).hint("Machine Gun MK3 - Increase range attack by 80% if using a firearm. Change the firearm text to a goblin machine gun text. - 125+ int, 15 metal pieces, 500 nails, 10 mechanism and 12 hours of work.");
		if (player.hasKeyItem("Blueprint - Machine Gun MK2") >= 0 && player.hasKeyItem("Machine Gun MK1") >= 0 && player.inte >= 100 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 10 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 500 && player.hasItem(useables.MECHANI, 5)) addButton(3, "Machine Gun MK2", lumiWorkshopMachineGunMK2).hint("Machine Gun MK2 - Increase range attack by 60% if using a firearm. Change the firearm text to a goblin machine gun text. - 100+ int, 10 metal pieces, 500 nails, 5 mechanism, and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Machine Gun MK1") >= 0 && player.hasKeyItem("Repeater Gun") >= 0 && player.inte >= 75 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 10 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 200 && player.hasItem(useables.MECHANI, 5)) addButton(3, "Machine Gun MK1", lumiWorkshopMachineGunMK1).hint("Machine Gun MK1 - Increase range attack by 40% if using a firearm. Change the firearm text to a goblin machine gun text. - 75+ int, 10 metal pieces, 200 nails, 5 mechanism and 4 hours of work.");
		if (player.hasKeyItem("Blueprint - Repeater Gun") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 2 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 100) addButton(3, "Repeater Gun", lumiWorkshopRepeaterGun).hint("Repeater Gun - Increase range attack by 20% if using a firearm. Change the firearm text to a goblin machine gun text. - 50+ int, 2 metal pieces, 100 nails and 4 hour work.");
		if (player.hasKeyItem("Blueprint - Dynapunch Glove") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 2 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 100 && player.hasItem(useables.MECHANI, 1)) addButton(4, "Dynapunch G.", lumiWorkshopDynapunchGlove).hint("Dynapunch Glove - Adds a punching option to your mech. - 50+ int, 2 metal pieces, 100 nails, 1 mechanism and 4 hour work.");
		if (player.hasKeyItem("Blueprint - Whitefire Beam Cannon") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 75 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 20 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 500 && player.hasItem(useables.ENECORE, 5) && player.hasStatusEffect(StatusEffects.KnowsWhitefire)) addButton(5, "Whitefire B.C.", lumiWorkshopWhitefireBeamCannon).hint("Whitefire Beam Cannon - Adds a whitefire beam cannon option to your mech. - 75+ int, knowing Whitefire spell, 20 metal pieces, 500 nails, 5 energy core and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Snowball Generator") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 75 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 20 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 500 && player.hasItem(useables.ENECORE, 5) && player.hasStatusEffect(StatusEffects.KnowsIceSpike)) addButton(6, "Snowball G.", lumiWorkshopSnowballGenerator).hint("Snowball Generator - Adds a snowball generator option to your mech. - 75+ int, knowing Ice Spike spell, 20 metal pieces, 500 nails, 5 energy core and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Raijin blaster") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 100 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 15 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 500 && player.hasItem(useables.MECHANI, 2) && player.hasItem(useables.ENECORE, 5) && player.hasItem(useables.RPLASMA, 5) && player.hasStatusEffect(StatusEffects.KnowsLightningBolt)) addButton(7, "Raijin blaster", lumiWorkshopRaijinBlaster).hint("Raijin blaster - Adds a Raijin blaster option to your mech. - 100+ int, knowing Darkness Shard spell, 15 metal pieces, 500 nails, 2 mechanism, 5 energy core, 5 raiju plasma and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Gravity shots") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 100 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 15 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 500 && player.hasItem(useables.MECHANI, 2) && player.hasItem(useables.ENECORE, 5) && player.hasStatusEffect(StatusEffects.KnowsDarknessShard)) addButton(8, "Gravity shots", lumiWorkshopGravityShots).hint("Gravity shots - Adds a Gravity shots option to your mech. - 100+ int, knowing Darkness Shard spell, 15 metal pieces, 500 nails, 2 mechanism, 5 energy core and 8 hours of work.");
		if (player.hasKeyItem("Blueprint - Medical Dispenser 2.0") >= 0 && player.hasKeyItem("Stimpack Dispenser 1.0") >= 0 && player.inte >= 100 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 20 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 500 && player.hasItem(useables.ENECORE, 5) && player.hasItem(consumables.H_PILL, 5)) addButton(9, "Medical Dispenser 2.0", lumiWorkshopMedicalDispenser2).hint("Medical Dispenser 2.0 - Healing for 10 turns 20% of Heal spell value rising lust by 0,5% each turn. - 100+ int, Stimpack Dispenser 1.0, 20 metal pieces, 500 nails, 5 healing pills, 5 energy cores and 12 hours of work");
		if (player.hasKeyItem("Blueprint - Stimpack Dispenser 1.0") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 10 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 200 && player.hasItem(consumables.H_PILL, 5) && player.hasStatusEffect(StatusEffects.KnowsHeal)) addButton(9, "Stimpack Dispenser 1.0", lumiWorkshopStimpackDispenser1).hint("Stimpack Dispenser 1.0 - Healing for 10 turns 10% of Heal spell value rising lust by 1% each turn. - 50+ int, knowing Heal spell, Toolbelt, 10 metal pieces, 200 nails, 5 healing pills and 4 hours of work");
		if (player.hasKeyItem("Blueprint - Omni Missile") >= 0 && player.hasKeyItem("Missile launcher") >= 0 && player.inte >= 100 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 20 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 500 && player.hasItem(useables.MECHANI, 10)) addButton(10, "Omni Missile", lumiWorkshopOmniMissile).hint("Omni Missile - Increases Missile launcher effectiveness vs groups. - 100+ int, Missile launcher, 20 metal pieces, 500 nails, 10 mechanism and 12 hours of work");
		if (player.hasKeyItem("Blueprint - Missile launcher") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 75 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 10 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 500 && player.hasItem(useables.MECHANI, 5)) addButton(10, "Missile launcher", lumiWorkshopMissileLauncher).hint("Missile launcher - Adds an Missile launcher option to your mech. - 75+ int, Toolbelt, 10 metal pieces, 500 nails, 5 mechanisms and 8 hours of work");
		if (player.hasKeyItem("Blueprint - Lustnade Launcher") >= 0 && player.hasKeyItem("Aphrodigas Gun") >= 0 && player.inte >= 100 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 20 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 500 && player.hasItem(consumables.L_DRAFT, 10) && player.hasItem(useables.MECHANI, 10)) addButton(11, "Lustnade Launcher", lumiWorkshopLustnadeLauncher).hint("Lustnade Launcher - Upgraded version of Aphrodigas Gun. - 100+ int, Aphrodigas Gun, 20 metal pieces, 500 nails, 10 mechanism, 10 lust drafts and 4 hours of work");
		if (player.hasKeyItem("Blueprint - Aphrodigas Gun") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 25 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 2 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 100 && player.hasItem(consumables.L_DRAFT, 5)) addButton(11, "Aphrodigas Gun",lumiWorkshopAphrodigasGun).hint("Aphrodigas Gun - Adds an Aphrodigas Gun option to your mech. - 25+ int, Toolbelt, 2 metal pieces, 100 nails, 5 lust drafts and 4 hours of work");
		if (player.hasKeyItem("Blueprint - Impregnator 1.0") >= 0 && player.hasKeyItem("SPMK1") >= 0 && player.inte >= 100 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 5 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 100) addButton(12, "Impregnator 1.0", lumiWorkshopImpregnator1).hint("Impregnator 1.0 - Allows you to store cum from defeated male opponents in the reservoir for future use. - 75+ int, Toolbelt, taken Cock Milker or Breast Pump from Factory, 5 metal pieces, 100 nails and 4 hours of work.");
		if (player.hasKeyItem("Blueprint - SPMK1") >= 0 && player.hasKeyItem("Cum Reservoir") >= 0 && player.inte >= 75 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 1) addButton(12, "SPMK1", lumiWorkshopSPMK1).hint("SPMK1 - Allows you to store cum from defeated male opponents in the reservoir for future use. - 75+ int, Toolbelt, taken Cock Milker or Breast Pump from Factory, 5 metal pieces, 100 nails and 4 hours of work.");
		if (player.hasKeyItem("Blueprint - Cum Reservoir") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && flags[kFLAGS.FACTORY_MILKER_BUILT] > 0 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 5 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 100) addButton(12, "Cum Reservoir", lumiWorkshopCumReservoir).hint("Cum Reservoir - Allows you to store cum from defeated male opponents in the reservoir for future use. - 75+ int, Toolbelt, taken Cock Milker or Breast Pump from Factory, 5 metal pieces, 100 nails and 4 hours of work.");
		if (player.hasKeyItem("Blueprint - MK2 Jetpack") >= 0 && player.hasKeyItem("Jetpack") >= 0 && player.inte >= 100 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 10 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 300 && player.hasItem(useables.ENECORE, 2)) addButton(13, "MK2 Jetpack", lumiWorkshopMK2Jetpack).hint("MK2 Jetpack - An improvement to the Jetpack, increasing your evasiveness by 25% while airborne. - 100+ int, Jetpack, 10 metal pieces, 300 nails, 2 energy cores and 8 hours of work");
		if (player.hasKeyItem("Blueprint - Jetpack") >= 0 && player.hasKeyItem("Toolbelt") >= 0 && player.inte >= 50 && flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] >= 3 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 100 && player.hasItem(useables.ENECORE, 1)) addButton(13, "Jetpack", lumiWorkshopJetpack).hint("Jetpack - The mech can hover in the air and fly, allowing for flight in battle. - 50+ int, Toolbelt, 3 metal pieces, 100 nails, 1 energy core and 4 hours of work");
		addButton(14, "Back", lumiWorkshop);
	}
	public function lumiWorkshopEnergyCore():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 5;
		player.destroyItems(useables.GOLCORE, 3);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Energy Core is ready.\n\n");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) inventory.takeItem(useables.ENECORE, camp.returnToCampUseOneHour);
		else inventory.takeItem(useables.ENECORE, camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopMechanism():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 5;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 200;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Mechanism is ready.\n\n");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) inventory.takeItem(useables.MECHANI, camp.returnToCampUseOneHour);
		else inventory.takeItem(useables.MECHANI, camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopToolbelt():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 1;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Toolbelt is ready.\n\n");
		player.createKeyItem("Toolbelt", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Toolbelt");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopPotentDrugInjectors():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 3;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 30;
		player.destroyItems(consumables.L_DRAFT, 15);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "eight":"twelve")+" hours your brand new Potent Drug injectors is ready.\n\n");
		player.createKeyItem("Potent Drug injectors", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Potent Drug injectors");
		player.removeKeyItem("Improved Drug injectors");
		player.lib += 25;
		player.sens += 5;
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseEightHours);
		else doNext(camp.returnToCampUseTwelveHours);
	}
	public function lumiWorkshopImprovedDrugInjectors():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 2;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 20;
		player.destroyItems(consumables.L_DRAFT, 10);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Improved Drug injectors is ready.\n\n");
		player.createKeyItem("Improved Drug injectors", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Improved Drug injectors");
		player.removeKeyItem("Drug injectors");
		player.lib += 25;
		player.sens += 5;
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseFourHours);
		else doNext(camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopDrugInjectors():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 1;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 10;
		player.destroyItems(consumables.L_DRAFT, 5);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Drug injectors is ready.\n\n");
		player.createKeyItem("Drug injectors", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Drug injectors");
		player.lib += 25;
		player.sens += 5;
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopGunScopeWithAimbot():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 10;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 500;
		player.destroyItems(useables.ENECORE, 1);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "eight":"twelve")+" hours your brand new Gun Scope with Aimbot is ready.\n\n");
		player.createKeyItem("Gun Scope with Aimbot", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Gun Scope with Aimbot");
		player.removeKeyItem("Gun Scope with Aim tech");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseEightHours);
		else doNext(camp.returnToCampUseTwelveHours);
	}
	public function lumiWorkshopGunScopeWithAimTech():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 5;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 300;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Gun Scope with Aim tech is ready.\n\n");
		player.createKeyItem("Gun Scope with Aim tech", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Gun Scope with Aim tech");
		player.removeKeyItem("Gun Scope");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseFourHours);
		else doNext(camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopGunScope():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 1;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 100;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Gun Scope is ready.\n\n");
		player.createKeyItem("Gun Scope", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Gun Scope");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopSATechGoggle():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 10;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 500;
		player.destroyItems(useables.ENECORE, 5);
		player.destroyItems(headjewelries.SCANGOG, 1);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "eight":"twelve")+" hours your brand new S.A Tech Goggle is ready.\n\n");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) inventory.takeItem(headjewelries.SATGOG, camp.returnToCampUseEightHours);
		else inventory.takeItem(headjewelries.SATGOG, camp.returnToCampUseTwelveHours);
	}
	public function lumiWorkshopScannerGoggle():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 5;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 200;
		player.destroyItems(useables.ENECORE, 2);
		player.destroyItems(headjewelries.MACHGOG, 1);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Scanner goggle is ready.\n\n");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) inventory.takeItem(headjewelries.SCANGOG, camp.returnToCampUseFourHours);
		else inventory.takeItem(headjewelries.SCANGOG, camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopMachinistGoggles():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 1;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 100;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Machinist Goggles is ready.\n\n");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) inventory.takeItem(headjewelries.MACHGOG, camp.returnToCampUseOneHour);
		else inventory.takeItem(headjewelries.MACHGOG, camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopNitroBoots():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 15;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 300;
		player.destroyItems(useables.MECHANI, 3);
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
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 10;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 200;
		player.destroyItems(useables.MECHANI, 2);
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
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 5;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 100;
		player.destroyItems(useables.MECHANI, 1);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Spring Boots is ready.\n\n");
		player.createKeyItem("Spring Boots", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Spring Boots");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopMGSBracer():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 10;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 500;
		player.destroyItems(useables.ENECORE, 4);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "eight":"twelve")+" hours your brand new M.G.S. bracer is ready.\n\n");
		player.createKeyItem("M.G.S. bracer", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - M.G.S. bracer");
		player.removeKeyItem("Powboy");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseEightHours);
		else doNext(camp.returnToCampUseTwelveHours);
	}
	public function lumiWorkshopPowboy():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 5;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 200;
		player.destroyItems(useables.ENECORE, 1);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Powboy is ready.\n\n");
		player.createKeyItem("Powboy", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Powboy");
		player.removeKeyItem("Power bracer");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseFourHours);
		else doNext(camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopPowerBracer():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 3;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 100;
		player.destroyItems(useables.ENECORE, 1);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Power bracer is ready.\n\n");
		player.createKeyItem("Power bracer", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Power bracer");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopRipper2():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 30;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 500;
		player.destroyItems(useables.ENECORE, 5);
		player.destroyItems(useables.MECHANI, 10);
		player.destroyItems(weapons.RIPPER1, 1);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "eight":"twelve")+" hours your brand new Ripper 2.0 is ready.\n\n");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) inventory.takeItem(weapons.RIPPER2, camp.returnToCampUseEightHours);
		else inventory.takeItem(weapons.RIPPER2, camp.returnToCampUseTwelveHours);
	}
	public function lumiWorkshopRipper1():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 10;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 500;
		player.destroyItems(useables.ENECORE, 2);
		player.destroyItems(useables.MECHANI, 5);
		player.destroyItems(weapons.MACGRSW, 1);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Ripper 1.0 is ready.\n\n");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) inventory.takeItem(weapons.RIPPER1, camp.returnToCampUseFourHours);
		else inventory.takeItem(weapons.RIPPER1, camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopMachinedGreatsword():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 2;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 200;
		player.destroyItems(useables.ENECORE, 1);
		player.destroyItems(useables.MECHANI, 2);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Machined greatsword is ready.\n\n");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) inventory.takeItem(weapons.MACGRSW, camp.returnToCampUseOneHour);
		else inventory.takeItem(weapons.MACGRSW, camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopUpgradedArmorPlating3():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 20;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 500;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "eight":"twelve")+" hours your brand new Upgraded Armor plating 3.0 is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Upgraded Armor plating 3.0", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Upgraded Armor plating 3.0");
		player.removeKeyItem("Upgraded Armor plating 2.0");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseEightHours);
		else doNext(camp.returnToCampUseTwelveHours);
	}
	public function lumiWorkshopUpgradedArmorPlating2():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 10;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 300;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Upgraded Armor plating 2.0 is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Upgraded Armor plating 2.0", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Upgraded Armor plating 2.0");
		player.removeKeyItem("Upgraded Armor plating 1.0");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseFourHours);
		else doNext(camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopUpgradedArmorPlating1():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 5;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 200;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Upgraded Armor plating 1.0 is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Upgraded Armor plating 1.0", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Upgraded Armor plating 1.0");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopTaserOverchargeBattery():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 15;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 500;
		player.destroyItems(useables.ENECORE, 5);
		player.destroyItems(useables.MECHANI, 2);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Taser with an overcharged battery is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Taser with an overcharged battery", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Taser with an overcharged battery");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopTaser():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 10;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 300;
		player.destroyItems(useables.ENECORE, 1);
		player.destroyItems(useables.MECHANI, 1);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Taser is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Taser", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Taser");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopSafetyBubble():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 1;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 100;
		player.destroyItems(useables.ENECORE, 1);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Safety bubble is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Safety bubble", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Safety bubble");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopMachineGunMK3():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 15;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 500;
		player.destroyItems(useables.MECHANI, 10);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "eight":"twelve")+" hours your brand new Machine Gun MK3 is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Machine Gun MK3", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Machine Gun MK3");
		player.removeKeyItem("Machine Gun MK2");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseEightHours);
		else doNext(camp.returnToCampUseTwelveHours);
	}
	public function lumiWorkshopMachineGunMK2():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 10;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 500;
		player.destroyItems(useables.MECHANI, 5);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Machine Gun MK2 is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Machine Gun MK2", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Machine Gun MK2");
		player.removeKeyItem("Machine Gun MK1");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseFourHours);
		else doNext(camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopMachineGunMK1():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 10;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 200;
		player.destroyItems(useables.MECHANI, 5);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Machine Gun MK1 is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Machine Gun MK1", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Machine Gun MK1");
		player.removeKeyItem("Repeater Gun");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopRepeaterGun():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 2;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 100;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Repeater Gun is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Repeater Gun", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Repeater Gun");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopDynapunchGlove():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 2;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 100;
		player.destroyItems(useables.MECHANI, 1);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Dynapunch Glove is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Dynapunch Glove", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Dynapunch Glove");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopWhitefireBeamCannon():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 20;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 500;
		player.destroyItems(useables.ENECORE, 5);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Whitefire Beam Cannon is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Whitefire Beam Cannon", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Whitefire Beam Cannon");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseFourHours);
		else doNext(camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopSnowballGenerator():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 20;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 500;
		player.destroyItems(useables.ENECORE, 5);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Snowball Generator is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Snowball Generator", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Snowball Generator");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseFourHours);
		else doNext(camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopRaijinBlaster():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 15;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 500;
		player.destroyItems(useables.MECHANI, 2);
		player.destroyItems(useables.ENECORE, 5);
		player.destroyItems(useables.RPLASMA, 5);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Raijin blaster is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Raijin blaster", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Raijin blaster");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseFourHours);
		else doNext(camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopGravityShots():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 15;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 500;
		player.destroyItems(useables.MECHANI, 2);
		player.destroyItems(useables.ENECORE, 5);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Gravity shots is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Gravity shots", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Gravity shots");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseFourHours);
		else doNext(camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopMedicalDispenser2():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 20;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 500;
		player.destroyItems(consumables.H_PILL, 5);
		player.destroyItems(useables.ENECORE, 5);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "eight":"twelve")+" hours your brand new Medical Dispenser 2.0 is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Medical Dispenser 2.0", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Medical Dispenser 2.0");
		player.removeKeyItem("Stimpack Dispenser 1.0");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseEightHours);
		else doNext(camp.returnToCampUseTwelveHours);
	}
	public function lumiWorkshopStimpackDispenser1():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 10;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 200;
		player.destroyItems(consumables.H_PILL, 5);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Stimpack Dispenser 1.0 is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Stimpack Dispenser 1.0", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Stimpack Dispenser 1.0");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopOmniMissile():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 20;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 500;
		player.destroyItems(useables.MECHANI, 10);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "eight":"twelve")+" hours your brand new Omni Missile is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Omni Missile", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Omni Missile");
		player.removeKeyItem("Missile launcher");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseEightHours);
		else doNext(camp.returnToCampUseTwelveHours);
	}
	public function lumiWorkshopMissileLauncher():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 10;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 500;
		player.destroyItems(useables.MECHANI, 5);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new Missile launcher is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Missile launcher", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Missile launcher");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseFourHours);
		else doNext(camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopLustnadeLauncher():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 20;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 500;
		player.destroyItems(consumables.L_DRAFT, 10);
		player.destroyItems(useables.MECHANI, 10);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Lustnade Launcher is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Lustnade Launcher", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Lustnade Launcher");
		player.removeKeyItem("Aphrodigas Gun");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopAphrodigasGun():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 2;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 100;
		player.destroyItems(consumables.L_DRAFT, 5);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Aphrodigas Gun is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Aphrodigas Gun", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Aphrodigas Gun");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopImpregnator1():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 5;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 100;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Impregnator 1.0 is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Impregnator 1.0", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Impregnator 1.0");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopSPMK1():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 1;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new SPMK1 is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("SPMK1", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - SPMK1");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopCumReservoir():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 5;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 100;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Cum Reservoir is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Cum Reservoir", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Cum Reservoir");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshopMK2Jetpack():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 10;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 300;
		player.destroyItems(useables.ENECORE, 2);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "four":"eight")+" hours your brand new MK2 Jetpack is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("MK2 Jetpack", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - MK2 Jetpack");
		player.removeKeyItem("Jetpack");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseFourHours);
		else doNext(camp.returnToCampUseEightHours);
	}
	public function lumiWorkshopJetpack():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 3;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 100;
		player.destroyItems(useables.ENECORE, 1);
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Jetpack is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Jetpack", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Jetpack");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}/*
	public function lumiWorkshop0():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 1;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Toolbelt is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Toolbelt", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Toolbelt");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshop0():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 1;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Toolbelt is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Toolbelt", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Toolbelt");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshop0():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 1;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Toolbelt is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Toolbelt", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Toolbelt");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}
	public function lumiWorkshop0():void {
		clearOutput();
		flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 1;
		outputText("You get to work spending the necessary time to craft your newest toy. After "+(player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop) ? "an hour":"four hours")+" your brand new Toolbelt is ready and installed up your " + player.vehiclesName + ".\n\n");
		player.createKeyItem("Toolbelt", 0, 0, 0, 0);
		player.removeKeyItem("Blueprint - Toolbelt");
		statScreenRefresh();
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) doNext(camp.returnToCampUseOneHour);
		else doNext(camp.returnToCampUseFourHours);
	}*/
}
}