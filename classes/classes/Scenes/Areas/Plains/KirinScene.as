package classes.Scenes.Areas.Plains
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;

public class KirinScene extends BaseContent
	{

		public function KirinScene()
		{
		}

public function kirinEncounter():void {
	//spriteSelect(SpriteDb.s_naga);
	//Create status if needed
	var string:String = "";
	var pRaiju_Check:Boolean = player.isRace(Races.RAIJU, 1, false);
	var pThunderbird_Check:Boolean = player.isRace(Races.THUNDERBIRD, 1, false);
	var pKirin_Check:Boolean = player.isRace(Races.KIRIN, 1, false);
	
	string += "While wandering through the plains, you hear a sound, not unlike rolling thunder in the distance. As you investigate, you run into a curious sight. A centaur with white and black striped fur is busy violently ramming her hindquarters into a somewhat helpless satyr.\n\n";
	// Balls gurgling noise
	string += "While her top half looks like that of a human woman with a massive pair of tits and a long spiraling horn, her lower half has a large horse cunt resting right above a massive pair of balls, which you have no doubt it conceals the sight of something else of equine proportion as it audibly gurgling and clenching, dumping its equally large payload, bloating the poor satyr's belly.\n\n";
	
	if (pRaiju_Check || pThunderbird_Check || pKirin_Check){
		string += "She notices you before sighing. \"<i>Well would you look at this, a "; 
		string += (pRaiju_Check?"raiju":(pThunderbird_Check?"thunderbird":(pKirin_Check?"kirin":""))) + "";
		// nother kirin is little repetitive considering kirin was used earlier
		string += ", I see you've wandered pretty far from your territory just to discharge" + (pKirin_Check?", fellow kin":"") + ". Sorry, I already claimed his ass for my plug, but if you want his mouth, feel free to use it.</i>\"\n\n";
		string += "Will you take on her offer?\n\n";
		outputText(string);
		menu();
		// addButtonDisabled
		if(player.hasCock() || player.hasVagina()){
			addButton(1, "Discharge", kirin_FriendlyDischarge);
		}
		else{
			addButtonDisabled(1, "Discharge", "WHY THE HELL YOU HAVE THIS DISABLED IN A FUCKING SEX GAME");
		}
		addButton(3, "Leave", kirin_FriendlyLeave);
	}
	else{
		// massive is starting to get little repetitive, 
		string += "Your fears are proven right when, as she notices you, she licks her lips and suddenly moves to the side, unplugging a torso-length, bluish horsecock from the butt of the satyr as he bleats in confusion, followed by downpour of neon-blue fluid from his abused hole and a growing ankle-deep puddle while his body still twitching from voltage overload.\n\n";
		string += "\"<i>Don't hold it against me, I NEED to fuck, and your outlet looks a thousand times more comfortable for my plug then that of goatman over there…, nothing personnal.</i>\", her still-jutting cock casually belches loads enough to fill a pint as if to prove her point.\n\n";
		string += "Without further warning, she charges you down as the ambient sound of statics builds up around her.\n\n";
		// PS: ,as she teleports behind you
		// Encounter start
		// https://docs.google.com/document/d/1AuhfqxKJFdl3S8WS2Op59YFMXGYbDpWKrzS-Ag9Ub7Q
		// Some """improvisation""" of my own
		outputText(string);
		startCombat(new Kirin());
	}
}

// Whatever you are smoking lia
public function kirinElectraEncounter():void {
	//spriteSelect(SpriteDb.s_naga);
	//Create status if needed
	var string:String = "";
	
	string += "As you explore the plains you hear thundering sounds in the distance, though you can vaguely distinguish the noise originates from multiple sources.\n\n<b>You had a hunch that it is very unlikely that you will gain much of it.</b>\n\nStill, will you <b>risk</b> investigate?";

	outputText(string);
	menu();
	addButton(1, "Yes", whateverTheFuckIsThis);
	addButton(2, "No", yesPleaseDo);
}

private function whateverTheFuckIsThis():void{
	var meetElectra:Boolean = (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1);
	var string:String = "As you go forward, you spot what appears to be a Kirin galloping in your direction. Fully aware that getting caught in the middle of the plain by her will inevitably result in a fight of \"not to get impaled by a torso-length horse cock\", you attempt to run away but spot another moving storm in the distance. It's "+(meetElectra?"Electra":"a god damned raiju")+" and she's heading straight toward you!";

	clearOutput();

	if(player.inte100>=75&&flags[kFLAGS.MET_BUNBUN] > 0){
		string += "\n\nThere's no time to run! If you don't do something real fast, you will end up broken in more ways than one! Out of desperation, you hide into a hole and kick out a very confused herm bunny girl."
	
		string += "\n\n\"Ugh hey what the hell are you doing!?!\""
		
		string += "\n\nShe doesn't get to follow up on her sentence screaming a terrified \"NOOOOOOOOOOOOOO!!!!\" aAs the thunderous duo collide right onto her. You make yourself scarce while the pair thoroughly rapes the bunny above, hoping not to draw attention. For a full hour, you listen to the sound of moanings, electric shocks and ass slapping, worrying that you could be next. Only when you're sure they left do you leave the burrow to look around. Unsurprisingly, the bunny now drooling vacantly, still eye crossed from the pleasure overload, her abused mouth and pussy dripping abundant amount of plasma. Praying that there is no last damage done, you head back to camp vowing to be more careful from now on while exploring."
	}
	else{
		var playerVagina:Boolean = player.hasVagina();

		var pRaiju_Check:Boolean = player.isRace(Races.RAIJU, 1, false);
		var pThunderbird_Check:Boolean = player.isRace(Races.THUNDERBIRD, 1, false);
		var pKirin_Check:Boolean = player.isRace(Races.KIRIN, 1, false);

		string += "\n\nwith nowhere to run, you end up caught between them both. Fighting one of them is one thing but both at the same time is whole another level. A few electroshocks later, you're on the ground, still spazzing. You wish you'd lose consciousness right about now to avoid what is about to come as you spot their lust crazed faces above you. You beg them to spare you, but as expected they are deaf to your plea.";
	
		string += "\n\nWhile "+(meetElectra?"Electra":"the raiju")+" sits on your mouth, shutting down your protests, the centauress spreads your legs wide as her torso-crushing electro horse cock seeks out your "+(playerVagina?"[pussy]":"[ass]")+", forcing inches after inches into your still twitching hole."
	
		string += "\n\nThe moment the centauress bottoms up, you lose all motion control as your electrified body begins to shake violently. Your eyes roll as your tongue begins flicking nonstop on its own, causing the pleasured Raiju to moan, unloading her own discharge directly into your head. As voltage runs back and forth in your body, you feel yourself breaking coherent thoughts becoming muddled as every nerve and neuron is set alight only short of turning you into a vegetable. You’re barely aware of your "+(playerVagina?"womb":"belly")+" filling up as the Kirin unloads rope after rope of cum into you, and it takes you several minutes for your brain to catch up to the fact that you are no longer being fucked… just how long have you been laying down like this dripping plasma into the grass and spasming?";
	
		string += "\n\nYou leave for...uh what was it? You head to your camp with a giddy smile and somewhat vacant stare.";

		if (!pRaiju_Check && !pThunderbird_Check && !pKirin_Check){
			player.addCurse("int", player.inte * 0.9, 2);
		}
	}
	outputText(string);
	endEncounter();
	explorer.stopExploring();
	doNext(camp.returnToCampUseEightHours);
}

private function yesPleaseDo():void{
	var string:String = "\n\nYou think it'd be best to leave and head back to camp.";
	outputText(string);
	endEncounter();
}

private function kirin_FriendlyDischarge():void{
	clearOutput();
	var string:String = "";
	var pGear:Boolean = player.armorDescript() == "gear";
	
	var cumVolume:Number = player.cumQ();
	var milkVolume:Number = player.lactationQ();
	
	var pCannon:Boolean = player.perkv1(IMutationsLib.MinotaurTesticlesIM) >= 1 && cumVolume > 0;
	var pMilk:Boolean = player.perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 1 && milkVolume > 0;
	
	string += "You gleefully accept the Kirin’s offer and"+(pGear ? " undress" : "")+" as you move in front of the bleating satyr.\n\n";
	string += "Deaf to any potential protest, you ";
	
	if(player.hasCock()){
		string += "force your " + player.cockDescript() + " into the satyr’s mouth and begin spitroasting the goat as you unload your lewd voltage directly into his brain. Thrusting with abandon, you enjoy the feeling of the twitching satyr tongue against your member. Sometimes, the kirin’s voltages shoot just far enough to reach your dick, causing you to moan inwith renewed arousal together with her as you push each other toward new heights of pleasure.\n\nSomehow, perhaps due to the connection, you achieve orgasm at the same time as the Kirin, ";
		// Cum. Cum everywhere. - Shirane/NUZ
		// YOU HAVE MASSIVE BALLS THAT MUST MEANS YOU HAVE MASSIVE CUM, CLENCH AND SPURT UNTIL ITS FLOODED
		var milkString:String = "";
		
		if(pMilk){
			milkString += "You came hard enough that";
			if(milkVolume<2000){
				milkString += " your tits squirt out some plasma of their own, further contributing onto the mess.\n\n";
			}
			else if(milkVolume<4000){
				milkString += " your tits squirt out jets and jets of plasma, further contributing onto the mess.\n\n";
			}
			else if(milkVolume<6000){
				milkString += " geysers of plasma spewing out of your tits, further contributing onto the mess with their sweet-scented produce.\n\n";
			}
			else{
				milkString += " small rivers of plasma come forth from your tits, further contributing onto the mess with their sweet-scented produce, you'd lamented a little as you lactate enough to feed a village for a lifetime if not for how pleasurable it is.\n\n";
			}
		}
		
		if(cumVolume < 2000){
			string += "though your orgasm lasted way shorter compare to kirin's as she continue to unload ropes after ropes of neon blue fluid for a minute after you unplug, rapidly bloating satyr body.\n\n";
		}
		else if(cumVolume < 4000){
			string += "unloading ropes after ropes of neon blue fluid and rapidly bloating satyr body rapidly bloating satyr's belly.\n\n"
		}
		// Plasma cannon variant
		else if (cumVolume < 10000){
			string += "unloading ropes after ropes of neon blue fluid and rapidly bloating satyr body, ";
			
			if(cumVolume<6000){
				string += "though its mostly hers as you can feel the pressure pushing against your cock, forcing you to unplug. The fluid quickly pooling out of satyr's gaping mouth as his bloated belly ran out of room to spare.\n\n";
			}
			else if(cumVolume<8000){
				string += "kirin gasps and unplug as your load begin to overpower hers, ";
				string += (pCannon ? "spurt after spurts of the mixed fluid come out ":"copious amount of fluid drool out ");
				string += "of satyr's other end.\n\n";
				string += milkString;
			}
			else {
				string += "kirin gasps and unplug as your load quickly overpower hers, ";
				string += (pCannon ? "so much that it jets all the way out of satyr's backdoor, drenching kirin's hindquarter":"waterfall of fluid pour out of satyr's backdoor");
				string += " and forming a sizable puddle beneath.\n\n";
				string += milkString;
			}
		}
		else if(cumVolume<20000){
			string += "kirin gasps eye widen as your load instantly filled the satyr to brim and ";
			string += (pCannon? "actually blasted kirin out of satyr by the force of your orgasm alone.":"pushes you both inches away from the satyr and forced to unplug by the pressure of the combined payload.");
			string += " But that's only the beginning as you continue to spew ropes for a minute even after kirin's substantial orgasm subsided, drenching everyone in vicinity under a vicious layer of your emission.\n\n";
			
			string += milkString;
			string += "You sigh and return to camp, leaving an ankle-deep puddles behind and your \"victims\" utterly caked.\n\n";
		}
		else{
			string += "kirin shocked in mix of terror and arousal as your load instantly filled and inflate the satyr and her balls alike to the size of a beachball, and drenching them both under piles of fluid with mere leakage of your load. However, that's merely a fraction of your orgasm as you really erupted,";
			string += (pCannon?" blasting kirin feets away":" expelling you and kirin");
			string += " with the sheer force of your orgasm alone, your firehose of a cock continues to flex pillar after pillars worth of plasma utterly drowned out Kirin's pathetic orgasm in comparison, and everyone and everything in vicinity and feets away.\n\n";
			
			string += milkString;
			string += "By the time you finished, you look around and find yourself stood within an inches-deep pool of your creation and everything in sight so utterly drenched, it'd probably scare off gnolls and satyrs for days to come, unaware of what kind of monstrosity has passed by that could create this much.\n\nAfter spending some time looking around, you managed to dig out your latest victims buried under your prodigious production quickly enough, with both of them unconscious, understandably so, before returning to camp.\n\n";
		}
	}
	else{
		string += "force your already engorgeding lips into the satyr’s mouth, using his rapidly twitching tongue as a means to unload your lust. Sometimes, the kirin’s voltages shoot just far enough to reach your pussy, causing you to moan in renewed arousal together with her as you push each other toward new heights of pleasure. Somehow, perhaps due to the connection, you achieve orgasm at the same time as the Kirin, your pussy gushing into the satyr’s face as she unloads ropes after ropes of plasma into the rapidly bloating satyr body.";
	
		if(pMilk){
			string += " You came hard enough that";
			if(milkVolume<2000){
				string += " your tits squirt out some plasma of their own, some of it ended up dripping on the satyr as he twitches a little in response.\n\n";
			}
			else if(milkVolume<4000){
				string += " your tits squirt out jets and jets of plasma, you get up and shove one of your nipples into satyr's mouth in time before they tapped out as he shudders in response.\n\n";
			}
			else if(milkVolume<6000){
				string += " geysers of plasma spewing out of your tits, you get up and shove one of your nipples into satyr's mouth in time before they tapped out as he shudders throughout your feeding session. You ended up bloating his belly even further and some of it inevitably spilled back as his belly ran out of room.\n\n";
			}
			else{
				string += " small rivers of plasma come forth from your tits, you lament a little as you lactate enough to feed a village for a lifetime. Luckily, right now there is a mouth to feed, shoving one of your nipples into the satyr's mouth as he shudders from the voltage and gargles from the size of your lactation. Case in point, as you wash over his body with it from your spare tit, how nice of you! You utterly bloat his belly and system with plasma, and the flow is so strong that it doesn't spill back but comes forth from his butt! You continue until he and the surroundings are utterly drenched by your sweet-scented produce.\n\n";
			}
		}
		
		string += "With your voltage fully discharged, you finally unplug highly satisfied and clap hands with the kirin as the both of you parts away.";
	}
	
	outputText(string);
	endEncounter();
}

private function kirin_FriendlyLeave():void{
	outputText("Not in the mood to rape the satyr, you decline and bid the Kirin goodbye for now as you head back to camp.");
	endEncounter();
}

public function kirinWon():void{
	var string:String = "";
	var playerPants:String = player.lowerGarmentName;
	var playerVagina:Boolean = player.hasVagina();
	// Is there even light bulb in universe
	// "Before you can protest, you feel the thing breaking past your -Armorname-" sounds like penis penetrated through the armor literally
	//
	// Weaponized Giant Penis when
	string += "You drop to the ground, unable to fight further as the kirin closes the distance. You take in the sight of her muscular front legs stepping in front of you and merely catch a glimpse of her massive, bluish equine cock glowing like a light bulb as it drools a trail of neon blue fluid behind. Before you can protest, you feel the thing" 
			+ (playerPants == "nothing"?"":"breaking past your " + playerPants + " and") 
			+ " pass right through your " + (playerVagina?"cunt lips as it seeks out your pussy":"butt cheeks as it seeks out your ass hole") + ". The kirin lightning rod finds purchase and rushes through, delivering a discharge that reaches all the way to your brain, you almost blacked out as pleasure overloads your senses and sending your body to spasm with each thrust.\n\nShock after shock, and just when you thought that she is never going to stop fucking you, she finally unloads. A cock that is almost as thick as a ball of fist, somehow felt even thicker inside you as what must be an enormous volume of gunk rushing through her cock, and finally, reaches your " + (playerVagina ? "womb" :"bowel") + " in a nigh constant stream, bloating your belly until you look like 3 or 4 months into pregnancy as her girth utterly plugged your hole for any reasonable leakage.\n\nFinally finished unloading, kirin leaves you paralysed on the ground and gallops away with a sigh of relief. It isn't long before gnoll and other less morally clean denizen walked by and abuses your body for sexual relief, and many hours later you finally managed to stand up and walk back to your camp.";

	clearOutput();
	outputText(string);
	player.orgasm();
	doNext(cleanupAfterCombat);
}

public function kirinLost():void{
	var string:String = "";
	// Little silly innit
	string += "For a moment, you consider the foolish idea of relieving yourself with her before you are reminded by the ambient static sound, that any contact with her will probably end with you turned into a paralyzed mess at the mercy of her still dripping horsecock. You head back to camp leaving the sexually frustrated Kirin be." ;
	outputText(string);
	doNext(cleanupAfterCombat);
}
	// Class terminator
	}
// Package terminator
}
