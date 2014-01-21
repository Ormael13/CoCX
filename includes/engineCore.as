// // import flash.events.MouseEvent;
// 
// //const DOUBLE_ATTACK_STYLE:int = 867;
// //const SPELLS_CAST:int = 868;
// 
// //Fenoxo loves his temps
// var temp:int = 0;
// 
// //Used to set what each action buttons displays and does.
// var args:Array = new Array();
// var funcs:Array = new Array();
// 
// //Used for stat tracking to keep up/down arrows correct.
// var oldStats = {};
// model.oldStats = oldStats;
// oldStats.oldStr  = 0;
// oldStats.oldTou  = 0;
// oldStats.oldSpe  = 0;
// oldStats.oldInte = 0;
// oldStats.oldSens = 0;
// oldStats.oldLib  = 0;
// oldStats.oldCor  = 0;
// oldStats.oldHP   = 0;
// oldStats.oldLust = 0;
// 
// model.maxHP = maxHP;

public function maxHP():Number {
	return player.maxHP();
}

public function silly():Boolean {
	return flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] == 1;

}

public function clearList():void {
	list = [];
}
public var list:Array = [];
public function addToList(arg:*):void {
	list[list.length] = arg;
}
public function outputList():String {
	var stuff:String = "";
	for(var x:int = 0; x < list.length; x++) {
		stuff += list[x];
		if(list.length == 2 && x == 1) {
			stuff += " and ";
		}
		else if(x < list.length-2) {
			stuff += ", ";
		}
		else if(x < list.length-1) {
			stuff += ", and ";
		}
	}
	list = [];
	return stuff;        
}


public function HPChange(changeNum:Number, display:Boolean):void
{
	if(changeNum == 0) return;
	if(changeNum > 0) {
		//Increase by 20%!
		if(player.hasPerk("History: Healer") >= 0) changeNum *= 1.2;
		if(player.HP + int(changeNum) > maxHP()) {
			if(player.HP >= maxHP()) {
				if(display) outputText("You're as healthy as you can be.\n", false);
				return;
			}
			if(display) outputText("Your HP maxes out at " + maxHP() + ".\n", false);
			player.HP = maxHP();
		}
		else
		{
			if(display) outputText("You gain " + int(changeNum) + " HP.\n", false);
			player.HP += int(changeNum);
			mainView.statsView.showStatUp( 'hp' );
			// hpUp.visible = true;
		}
	}
	//Negative HP
	else
	{
		if(player.HP + changeNum <= 0) {
			if(display) outputText("You take " + int(changeNum*-1) + " damage, dropping your HP to 0.\n", false);
			player.HP = 0;
		}
		else {
			if(display) outputText("You take " + int(changeNum*-1) + " damage.\n", false);
			player.HP += changeNum;
		}
	}
	statScreenRefresh();
}
		
public function clone(source:Object):* {
	var copier:ByteArray = new ByteArray();
	copier.writeObject(source);
	copier.position = 0;
	return(copier.readObject());
}

public function speech(output:String, speaker:String):void {
	var speech:String = "";
	speech = speaker + " says, \"<i>" + output + "</i>\"\n";
	outputText(speech, false);
}


	
public function clearOutput():void {
	currentText = "";
	mainView.clearOutputText();
}

public function rawOutputText(output:String, purgeText:Boolean = false):void
{
	
	//OUTPUT!
	if(purgeText) {
		//if(!debug) mainText.htmlText = output;
		//trace("Purging and writing Text", output);
		clearOutput();
		currentText = output;
		mainView.setOutputText( output );
		// mainText.htmlText = output;
	}
	else
	{
		//trace("Adding Text");
		currentText += output;
		mainView.appendOutputText( output );
		// mainText.htmlText += output;
	}
	// trace(getCurrentStackTrace())
	// scrollBar.update();

}

public function outputText(output:String, 
						purgeText:Boolean = false, 
						parseAsMarkdown:Boolean = false):void
{
	// we have to purge the output text BEFORE calling parseText, because if there are scene commands in 
	// the parsed text, parseText() will write directly to the output


	// This is cleaup in case someone hits the Data or new-game button when the event-test window is shown. 
	// It's needed since those buttons are available even when in the event-tester
	mainView.hideTestInputPanel();

	if (purgeText)
	{
		clearOutput();
	}

	output = this.parser.recursiveParser(output, parseAsMarkdown);

	//OUTPUT!
	if(purgeText) {
		//if(!debug) mainText.htmlText = output;
		currentText = output;
	}
	else {
		currentText += output;
		//if(!debug) mainText.htmlText = currentText;
	}
	if(debug) 
	{
		mainView.setOutputText( currentText );
	}

}

public function flushOutputTextToGUI():void
{
	
	mainView.setOutputText( currentText );
}

public function perkLongDescription(perkName:String = ""):String {
	switch(perkName) {
		case "Pretend Strength Perk":
			return "Pretend I am telling you about how this works.";
		case "Resistance":
			return "You choose the 'Resistance' perk, reducing the rate at which your lust increases by 10%.";
		case "Arousing Aura":
			return "You choose the 'Arousing Aura' perk, causing you to radiate an aura of lust when your corruption is over 70.";
		case "Sadist":
			return "You choose the 'Sadist' perk, increasing damage by 20 percent but causing you to gain lust from dealing damage.";
		case "Masochist":
			return "You choose the 'Masochist' perk, reducing the damage you take but raising your lust each time!  This perk only functions while your libido is at or above 60!";
		case "Well Adjusted":
			return "You choose the 'Well Adjusted' perk, reducing the amount of lust you naturally gain over time while in this strange land!";
		case "Medicine":
			return "You choose the 'Medicine' perk, giving you a chance to remove debilitating poisons automatically!";
		case "Channeling":
			return "You choose the 'Channeling' perk, boosting the strength of your spellcasting!";
		case "Agility":
			return "You choose the 'Agility' perk, increasing the effectiveness of Light/Medium armors by a portion of your speed.";
		case "Speedy Recovery":
			return "You choose the 'Speedy Recovery' perk, boosting your fatigue recovery rate!";
		case "Regeneration 2":
			return "You choose the 'Regeneration 2' perk, giving an addition 2% of max HP per turn in combat and 4% of max HP per hour.";
		case "Fera's Boon - Seeder":
			return "Increases cum output by 1,000 mLs.";
		case "Fera's Boon - Wide Open":
			return "Keeps your pussy permanently gaped and increases pregnancy speed.";
		case "Fera's Boon - Milking Twat":
			return "Keeps your pussy from ever getting too loose and increases pregnancy speed.";
		case "Tank 2":
			return "You choose the 'Tank 2' perk, granting an extra maximum HP for each point of toughness.";
		case "Weapon Mastery":
			return "You choose the 'Weapon Mastery' perk, doubling the effectiveness of large weapons.";
		case "Thunderous Strikes":
			return "You choose the 'Thunderous Strikes' perk, increasing normal damage by 20% while your strength is over 80.";
		case "Acclimation":
			return "You choose the 'Acclimation' perk, making your body 15% more resistant to lust, up to a maximum of 75%.";
		case "Double Attack":
			return "You choose the 'Double Attack' perk.  This allows you to make two attacks so long as your strength is at 60 or below.  By default your effective strength will be reduced to 60 if it is too high when double attacking.  <b>You can enter the perks menu at any time to toggle options as to how you will use this perk.</b>";
		case "Mage":
			return "You choose the 'Mage' perk.  You are able to focus your magical abilities even more keenly, boosting your base spell effects by 50%.";
		case "Spellpower":
			return "You choose the 'Spellpower' perk.  Thanks to your sizeable intellect and willpower, you are able to more effectively use magic, boosting base spell effects by 50%.";
		case "Nymphomania":
			return "You've chosen the 'Nymphomania' perk.  Due to the incredible amount of corruption you've been exposed to, you've begun to live in a state of minor constant arousal.  Your minimum lust will be increased by as much as 30 (If you already have minimum lust, the increase is 10-15).";
		case "Precision":
			return "You've chosen the 'Precision' perk.  Thanks to your intelligence, you're now more adept at finding and striking an enemy's weak points, reducing their damage resistance from armor by 10.  If your intelligence ever drops below 25 you'll no longer be smart enough to benefit from this perk.";
		case "Seduction":
			return "You choose the 'Seduction' perk, upgrading the 'tease' attack with a more powerful damage and a higher chance of success.";
		case "Corrupted Libido":
			return "You choose the 'Corrupted Libido' perk.  As a result of your body's corruption, you've become a bit harder to turn on. (Lust gain reduced by 10%!)";
		case "Hot Blooded":
			return "You choose the 'Hot Blooded' perk.  As a result of your enhanced libido, your lust no longer drops below 20! (If you already have some minimum lust, it will be increased by 10)";
		case "Fertility+":
			return "You choose the 'Fertility+' perk, making it easier to get pregnant.  It also increases your cum volume by up to 50% (if appropriate)!";
		case "Magical Fertility":
			return "10% higher chance of pregnancy and increased pregnancy speed.";
		case "Magical Virility":
			return "200 mLs more cum per orgasm and enhanced virility.";
		case "Runner":
			return "You choose the 'Runner' perk, increasing your chances to escape from your foes when fleeing!";
		case "Evade":
			return "You choose the 'Evade' perk, allowing you to avoid enemy attacks more often!";
		case "Regeneration":
			return "You choose the 'Regeneration' perk, allowing you to heal 2% of max HP every hour and 1% of max HP every round of combat!";
		case "Iron Man":
			return "You choose the 'Iron Man' perk, reducing the fatigue cost of physical special attacks by 50%";
		case "Brawler":
			return "You choose the 'Brawler' perk, allowing you to make two unarmed attacks in a turn!";
		case "Tank":
			return "You choose the 'Tank' perk, giving you an additional 50 hp!";
		case "Strong Back 2: Strong Harder":
			return "You choose the 'Strong Back 2: Strong Harder' perk, enabling a fifth item slot.";
		case "Strong Back":
			return "You choose the 'Strong Back' perk, enabling a fourth item slot.";
		case "Tactician":
			return "You choose the 'Tactician' perk, increasing critical hit chance by up to 10% (Intelligence-based).";
		case "Archmage":
			return "You choose the 'Archmage' perk, increasing base spell strength by 50%.";
		case "Lunging Attacks":
			return "You choose the 'Lunging Attacks' perk, granting 50% armor penetration for standard attacks.";
		case "Lightning Strikes":
			return "You choose the 'Lightning Strikes' perk, increasing the attack damage for non-heavy weapons.</b>";
		case "Immovable Object":
			return "You choose the 'Immovable Object' perk, granting 20% physical damage reduction.</b>";
		case "Resolute":
			return "You choose the 'Resolute' perk, granting immunity to stuns and some statuses.</b>";
		case "Berzerker":
			return "You choose the 'Berzerker' perk, which unlocks the 'Berzerk' magical ability.  Berzerking increases attack and lust resistance but reduces physical defenses.";
		case "Brutal Blows":
			return "You choose the 'Brutal Blows' perk, which reduces enemy armor with each hit.";
		default:
			return "An error occurred when loading the long perk description.  Please post a bug report on the bug report forums at forum.fenoxo.com.";
	}
}
public function perkDescription(perkName:String = ""):String {
	switch(perkName) {
		case "History: Whore":
			return "Seductive experience causes your tease attacks to be 15% more effective.";
		case "History: Slut":
			return "Sexual experience has made you more able to handle large insertions and more resistant to stretching.";
		case "Pure and Loving":
			return "Your caring attitude towards love and romance makes you slightly more resistant to lust and corruption.";
		case "Sensual Lover":
			return "Your sensual attitude towards love and romance makes your tease ability slightly more effective.";
		case "One Track Mind":
			return "Your constant desire for sex causes your sexual organs to be able to take larger insertions and disgorge greater amounts of fluid.";
		case "Brawler":
			return "Brawling experience allows you to make two unarmed attacks in a turn.";
		case "Corrupted Nine-tails":
			return "The mystical energy of the nine-tails surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly after casting spells, but your method of attaining it has corrupted the transformation, preventing you from achieving true enlightenment.";
		case "Enlightened Nine-tails":
			return "The mystical energy of the nine-tails surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly after casting spells.";
		case "History: Alchemist":
			return "Alchemical experience makes items more reactive to your body.";
		case "History: Fighter":
			return "Past full of conflict increases physical damage dealt by 10%.";
		case "History: Healer":
			return "Healing experience increases HP gains by 20%.";
		case "History: Religious":
			return "Replaces masturbate with meditate when corruption less than or equal to 66.";
		case "History: Scholar":
			return "Time spent focusing your mind makes spellcasting 20% less fatiguing.";
		case "History: Smith":
			return "Knowledge of armor and fitting increases armor effectiveness by roughly 10%.";
		case "History: Slacker":
			return "Regenerate fatigue 20% faster.";
		case "Slime Core":
			return "Grants more control over your slimy body, allowing you to go twice as long without fluids.";
		case "Flexibility":
			return "Grants cat-like flexibility.  Useful for dodging and 'fun'.";
		case "Thick Skin":
			return "Toughens your dermis to provide 2 points of armor.";
		case "Bunny Eggs":
			return "Laying eggs has become a normal part of your bunny-body's routine.";
		case "Basilisk Womb":
			return "Enables your eggs to be properly fertilized into basilisks of both genders!";
		case "Oviposition":
			return "Causes you to regularly lay eggs when not otherwise pregnant.";
		case "Dragonfire":
			return "Allows access to a dragon breath attack.";
		case "Futa Form":
			return "Ensures that your body fits the Futa look (Tits DD+, Dick 8\"+, & Pussy).  Also keeps your lusts burning bright and improves the tease skill.";
		case "Futa Faculties":
			return "It's super hard to think about stuff that like, isn't working out or fucking!";
		case "Bulge Armor":
			return "Grants a 5 point damage bonus to dick-based tease attacks.";
		case "Slutty Seduction":
			return "Increases odds of successfully teasing and lust damage of successful teases by " + player.perkv1("Slutty Seduction") + " points.";
		case "Blood Mage":
			return "Spellcasting now consumes health instead of fatigue!";
		case "Purity Blessing":
			return "Reduces the rate at which your corruption, libido, and lust increase.";
		case "Wizard's Endurance":
			return "Reduces fatigue cost of spells by " + player.perkv1("Wizard's Endurance") + "%.";
		case "Wizard's Focus":
			return "Increases your spell effect modifier by " + player.perkv1("Wizard's Focus") * 100 + "%.";
		case "Strong":
			return "Gains strength 25% faster.";
		case "Tough":
			return "Gains toughness 25% faster.";
		case "Fast":
			return "Gains speed 25% faster.";
		case "Smart":
			return "Gains intelligence 25% faster.";
		case "Lusty":
			return "Gains lust 25% faster.";
		case "Sensitive":
			return "Gains sensitivity 25% faster.";
		case "Big Cock":
			return "Gains cock size 25% faster and with less limitations.";
		case "Messy Orgasms":
			return "Produces 50% more cum volume.";
		case "Big Tits":
			return "Makes your tits grow larger more easily.";
		case "Big Clit":
			return "Allows your clit to grow larger more easily and faster.";
		case "Fertile":
			return "Makes you 15% more likely to become pregnant.";
		case "Wet Pussy":
			return "Keeps your pussy wet and provides a bonus to capacity.";
		case "Marble Resistant":
			return "Provides resistance to the addictive effects of bottled LaBova milk.";
		case "Marble's Milk":
			return "Requires you to drink LaBova milk frequently or eventually die.  You cannot shake this addiction.";
		case "Minotaur Cum Addict":
			return "Causes you to crave minotaur cum frequently.  You cannot shake this addiction.";
		case "Misdirection":
			return "Grants additional evasion chances while wearing Raphael's red bodysuit.";
		case "Omnibus' Gift":
			return "Increases minimum lust but provides some lust resistance.";
		case "Pierced: Crimstone":
			return "Increases minimum lust by " + Math.round(player.perkv1("Pierced: Crimstone")) + ".";
		case "Pent Up":
			return "Increases minimum lust by " + Math.round(player.perkv1("Pent Up")) + " and makes you more vulnerable to seduction.";
		case "Midas Cock":
			return "Increases the gems awarded from victory in battle.";
		case "Phallic Potential":
			return "Increases the effects of penis-enlarging transformations.";
		case "Phallic Restraint":
			return "Reduces the effects of penis-enlarging transformations.";
		case "Lusty Regeneration":
			return "Regenerates 1% of HP per round in combat and 2% of HP per hour.";
		case "Pierced: Fertite":
			return "Increases cum production by " + Math.round(2*player.perkv1("Pierced: Fertite")) + "% and fertility by " + Math.round(player.perkv1("Pierced: Fertite")) + ".";
		case "Pierced: Furrite":
			return "Increases chances of encountering 'furry' foes.";
		case "Pierced: Lethite":
			return "Increases chances of encountering demonic foes.";
		case "Harpy Womb":
			return "Increases all laid eggs to large size so long as you have harpy legs and a harpy tail.";
		case "Hellfire":
			return "Grants a corrupted fire breath attack, like the hellhounds in the mountains.";
		case "Incorporeality":
			return "Allows you to fade into a ghost-like state and temporarily possess others.";
		case "Luststick Adapted":
			return "Grants immunity to the lust-increasing effects of lust-stick and allows its use.";
		case "Pilgrim's Bounty":
			return "Causes you to always cum as hard as if you had max lust.";
		case "Cornucopia":
			return "Vaginal and Anal capacities increased by 30.";
		case "Spider Ovipositor":
			return "Allows you to lay eggs through a special organ on your arachnid abdomen, though you need at least 10 eggs to lay.";
		case "Bee Ovipositor":
			return "Allows you to lay eggs through a special organ on your insect abdomen, though you need at least 10 eggs to lay.";
		case "Fera's Boon - Alpha":
			return "Increases the rate your cum builds up and cum production in general.";
		case "Fera's Boon - Breeding Bitch":
			return "Increases fertility and reduces the time it takes to birth young.";
		case "Marae's Gift - Stud":
			return "Increases your cum production and potency greatly.";
		case "Marae's Gift - Fertility":
			return "Greatly increases fertility and halves base pregnancy speed.";
		case "Marae's Gift - Profractory":
			return "Causes your cum to build up at 3x the normal rate.";
		case "Marae's Gift - Buttslut":
			return "Makes your anus provide lubrication when aroused.";
		case "Feeder":
			return "Lactation does not decrease and gives a compulsion to breastfeed others.";
		case "Fire Lord":
			return "Akbal's blessings grant the ability to breathe burning green flames.";
		case "Whispered":
			return "Akbal's blessings grant limited telepathy that can induce fear.";
		case "Bro Brains":
			return "Makes thou... thin... fuck, that shit's for nerds.";
		case "Bro Body":
			return "Grants an ubermasculine body that's sure to impress.";
		case "Bimbo Body":
			return "Gives the body of a bimbo.  Tits will never stay below a 'DD' cup, libido is raised, lust resistance is raised, and upgrades tease.";
		case "Bimbo Brains":
			return "Now that you've drank bimbo liquer, you'll never, like, have the attention span and intelligence you once did!  But it's okay, 'cause you get to be so horny an' stuff!";
		case "Brood Mother":
			return "Pregnancy moves twice as fast as a normal woman's.";
		case "Diapause":
			return "Pregnancy does not advance normally, but develops quickly after taking in fluids.";
		case "Elven Bounty":
			return "Increases fertility by " + player.perkv2("Elven Bounty") + "% and cum production by " + player.perkv1("Elven Bounty") + "mLs.";
		case "Androgyny":
			return "No gender limits on facial masculinity or femininity.";
		case "Pretend Strength Perk":
			return "Pretend I am telling you about how this works.";
		case "Resistance":
			return "Reduces lust gain by 10%.";
		case "Arousing Aura":
			return "Exude a lust-inducing aura (Req's corruption of 70 or more)";
		case "Sadist":
			return "Deal 20% more damage, but gain lust at the same time.";
		case "Masochist":
			return "Take 30% less physical damage but gain lust when damage.";
		case "Well Adjusted":
			return "You gain half as much lust as time passes in Mareth.";
		case "Medicine":
			return "Grants 15% chance per round of cleansing poisons/drugs from your body.";
		case "Channeling":
			return "Increases base spell strength by 50%.";
		case "Agility":
			return "Boosts armor points by a portion of your speed on light/medium armors.";
		case "Speedy Recovery":
			return "Regain fatigue 50% faster.";
		case "Regeneration 2":
			return "Gain 2% of max HP per round of combat and 4% of max HP per hour out of combat.";
		case "Fera's Boon - Seeder":
			return "Increases cum output by 1,000 mLs.";
		case "Fera's Boon - Wide Open":
			return "Keeps your pussy permanently gaped and increases pregnancy speed.";
		case "Fera's Boon - Milking Twat":
			return "Keeps your pussy from ever getting too loose and increases pregnancy speed.";
		case "Spellcasting Affinity":
			return "Reduces spell costs by " + player.perkv1("Spellcasting Affinity") + "%.";
		case "Tank 2":
			return "+1 extra HP per point of toughness.";
		case "Weapon Mastery":
			if(player.str > 60) return "Doubles damage bonus of weapons classified as 'Large'.";
			else return "<b>You aren't strong enough to benefit from this anymore.</b>";
		case "Thunderous Strikes":
			return "+20% 'Attack' damage while strength is at or above 80.";
		case "Acclimation":
			return "Reduces lust gain by 15%.";
		case "Double Attack":
			if(player.spe < 50) return "<b>You're too slow to double attack!</b>";
			else if(player.str < 61) return "Allows you to perform two melee attacks per round.";
			else return "<b>You are stronger than double attack allows.  Too choose between reduced strength double-attacks and a single strong attack, access \"Dbl Options\" in the perks menu.</b>";
		case "Mage":
			return "Increases base spell strength by 50%.";
		case "Spellpower":
			return "Increases base spell strength by 50%.";
		case "Nymphomania":
			return "Raises minimum lust by up to 30.";
		case "Precision":
			return "Reduces enemy armor by 10. (Req's 25+ Intelligence)";
		case "Seduction":
			return "Upgrades your tease attack, making it more effective.";
		case "Corrupted Libido":
			return "Reduces lust gain by 10%.";
		case "Hot Blooded":
			return "Raises minimum lust by up to 20.";
		case "Fertility+":
			return "Increases fertility rating by 15 and cum volume by up to 50%.";
		case "Magical Fertility":
			return "10% higher chance of pregnancy and increased pregnancy speed.";
		case "Magical Virility":
			return "200 mLs more cum per orgasm and enhanced virility.";
		case "Runner":
			return "Increases chances of escaping combat.";
		case "Evade":
			return "Increases chances of evading enemy attacks.";
		case "Regeneration":
			return "Regenerates 2% of max HP/hour and 1% of max HP/round.";
		case "Iron Man":
			return "Reduces the fatigue cost of physical specials by 50%.";
		case "Tank":
			return "Raises max HP by 50.";
		case "Strong Back 2: Strong Harder":
			return "Enables fifth item slot.";
		case "Strong Back":
			return "Enables fourth item slot.";
		case "Tactician":
			if(player.inte >= 50) return "Increases critical hit chance by up to 10% (Intelligence-based).";
			else return "<b>You are too dumb to gain benefit from this perk.</b>";
		case "Archmage":
			if(player.inte >= 75) return "Increases base spell strength by 50%.";
			else return "<b>You are too dumb to gain benefit from this perk.</b>";
		case "Lunging Attacks":
			if(player.spe >= 75) return "Grants 50% armor penetration for standard attacks.";
			else return "<b>You are too slow to benefit from this perk.</b>";
		case "Lightning Strikes":
			if(player.spe >= 60) return "Increases the attack damage for non-heavy weapons.</b>";
			else return "<b>You are too slow to benefit from this perk.</b>";
		case "Immovable Object":
			if(player.tou >= 75) return "Grants 20% physical damage reduction.</b>";
			else return "<b>You aren't tough enough to benefit from this anymore.</b>";
		case "Resolute":
			if(player.tou >= 75) return "Grants immunity to stuns and some statuses.</b>";
			else return "<b>You aren't tough enough to benefit from this anymore.</b>";
		case "Berzerker":
			if(player.str >= 75) return "Grants 'Berzerk' ability.";
			else return "<b>You aren't strong enough to benefit from this anymore.</b>";
		case "Brutal Blows":
			if(player.str >= 75) return "Reduces enemy armor with each hit.";
			else return "<b>You aren't strong enough to benefit from this anymore.</b>";
		default:
			var checkChildren:String;
			
			checkChildren = telAdre.umasShop.listPerkDescription(perkName);
			
			if (checkChildren != "")
			{
				return checkChildren;
			}
			else
			{			
				return "<u><i>This Perk does not have a stored description.  Please post a bug report on the bug report forums at forum.fenoxo.com.</i></u>";
			}
			
			break;
	}
}
public function displayPerks(e:MouseEvent = null):void {
	temp = 0;
	outputText("", true);
	while(temp < player.perks.length) {
		outputText("<b>" + player.perks[temp].perkName + "</b> - " + perkDescription(player.perks[temp].perkName) + "\n", false);
		temp++;
	}
	menu();
	if(player.perkPoints > 0) {
		outputText("\n<b>You have " + num2Text(player.perkPoints) + " perk point", false);
		if(player.perkPoints > 1) outputText("s", false);
		outputText(" to spend.</b>", false);
		addButton(1,"Perk Up",eventParser,116);
	}
	if(player.hasPerk("Double Attack") >= 0) {
		outputText("\n<b>You can adjust your double attack settings.</b>");
		addButton(2,"Dbl Options",doubleAttackOptions);
	}
	addButton(0,"Next",eventParser,1);
}

public function doubleAttackOptions():void {
	clearOutput();
	menu();
	if(flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0) {
		outputText("You will currently always double attack in combat.  If your strength exceeds sixty, your double-attacks will be done at sixty strength in order to double-attack.");
		outputText("\n\nYou can change it to double attack until sixty strength and then dynamicly switch to single attacks.");
		outputText("\nYou can change it to always single attack.");
		addButton(1,"Dynamic",doubleAttackDynamic);
		addButton(2,"Single",doubleAttackOff);
	}
	else if(flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 1) {
		outputText("You will currently double attack until your strength exceeds sixty, and then single attack.");
		outputText("\n\nYou can choose to force double attacks at reduced strength (when over sixty, it makes attacks at a strength of sixty.");
		outputText("\nYou can change it to always single attack.");
		addButton(0,"All Double",doubleAttackForce);
		addButton(2,"Single",doubleAttackOff);
	}
	else {
		outputText("You will always single attack your foes in combat.");
		outputText("\n\nYou can choose to force double attacks at reduced strength (when over sixty, it makes attacks at a strength of sixty.");
		outputText("\nYou can change it to double attack until sixty strength and then switch to single attacks.");
		addButton(0,"All Double",doubleAttackForce);
		addButton(1,"Dynamic",doubleAttackDynamic);
	}
	var e:MouseEvent;
	addButton(4,"Back",displayPerks,e);
}

public function doubleAttackForce():void {
	flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 0;
	doubleAttackOptions();
}
public function doubleAttackDynamic():void {
	flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 1;
	doubleAttackOptions();
}
public function doubleAttackOff():void {
	flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 2;
	doubleAttackOptions();
}

public function levelUpGo(e:MouseEvent = null):void {
	hideMenus();
	mainView.hideMenuButton( MainView.MENU_NEW_MAIN );
	//Level up
	if(player.XP >= (player.level) * 100) {
		player.level++;
		player.perkPoints++;
		outputText("<b>You are now level " + player.level + "!</b>\n\nYou may now apply +5 to one attribute.  Which will you choose?", true);
		player.XP -= (player.level-1) * 100;
		simpleChoices("Strength", 44, "Toughness", 45, "Speed", 47, "Intelligence", 46, "", 0);                
	}
	//Spend perk points
	else if(player.perkPoints > 0) {
		perkBuyMenu();
	}
	else {
		outputText("<b>ERROR.  LEVEL UP PUSHED WHEN PC CANNOT LEVEL OR GAIN PERKS.  PLEASE REPORT THE STEPS TO REPRODUCE THIS BUG TO FENOXO@GMAIL.COM OR THE FENOXO.COM BUG REPORT FORUM.</b>", true);
		doNext(1);
	}
	/*OLD LEVEL UP CODE
	player.level++;
	levelText2.visible = false;
	levelBG.visible = false;
	dataText.visible = false;
	dataBG.visible = false;
	perksText.visible = false;
	perksBG.visible = false;
	appearanceText.visible = false;
	appearanceBG.visible = false;
	statsBG.visible = false;
	statsText.visible = false;
	outputText("<b>You are now level " + player.level + "!</b>\n\nYou may now apply +5 to one attribute.  Which will you choose?", true);
	player.XP -= (player.level-1) * 100;
	simpleChoices("Strength", 44, "Toughness", 45, "Speed", 47, "Intelligence", 46, "", 0);
	*/
}

public function perkBuyMenu():void {
	outputText("", true);
	buildPerkList();
	if(perkList.length == 0) {
		outputText("<b>You do not qualify for any perks at present.  </b>In case you qualify for any in the future, you will keep your " + num2Text(player.perkPoints) + " perk point", false);
		if(player.perkPoints > 1) outputText("s", false);
		outputText(".", false);
		doNext(115);
		return;
	}
	if (testingBlockExiting){
		tempPerk = perkList[rand(perkList.length)].label;
		doNext(114);
	} else {
		outputText("Please select a perk from the drop-down list, then click 'Okay'.  You can press 'Skip' to save your perk point for later.\n\n", false);
		mainView.aCb.x = 210;
		mainView.aCb.y = 108;
		mainView.aCb.visible = true;
		mainView.hideMenuButton( MainView.MENU_NEW_MAIN );
		simpleChoices("Okay",0,"Skip",115,"",0,"",0,"",0);
	}
}
public function buildPerkList():void {
	perkList = [];
	//STRENGTH PERKS
	if(player.str >= 25) {
		perkList.push({label:"Strong Back"});
	}
	if(player.hasPerk("Strong Back") >= 0 && player.str >= 50) {
		perkList.push({label:"Strong Back 2: Strong Harder"});
	}
	//Tier 1 Strength Perks
	if(player.level >= 6) {
		//Thunderous Strikes - +20% basic attack damage while str > 80.
		if(player.str >= 80) {
			perkList.push({label:"Thunderous Strikes"});
		}
		//Weapon Mastery - Doubles weapon damage bonus of 'large' type weapons. (Minotaur Axe, M. Hammer, etc)
		if(player.str > 60) {
			perkList.push({label:"Weapon Mastery"});
		}
		if(player.str >= 75)
			perkList.push({label:"Brutal Blows"});
	}
	//Tier 2 Strength Perks
	if(player.level >= 12) {
		if(player.str >= 75)
			perkList.push({label:"Berzerker"});
	}
	//slot 2 - toughness perk 1
	if(player.hasPerk("Tank") < 0 && player.tou >= 25) {
		perkList.push({label:"Tank"});
	}
	//slot 2 - regeneration perk
	if(player.hasPerk("Tank") >= 0 && player.tou >= 50) {
		perkList.push({label:"Regeneration"});
	}
	//Tier 1 Toughness Perks
		if(player.level >= 6) {
		if(player.hasPerk("Tank") >= 0 && player.tou >= 60) {
			perkList.push({label:"Tank 2"});
		}
		if(player.hasPerk("Regeneration") >= 0 && player.tou >= 70) {
			perkList.push({label:"Regeneration 2"});
		}
		if(player.tou >= 75) {
			perkList.push({label:"Immovable Object"});
		}
	}
	//Tier 2 Toughness Perks
	if(player.level >= 12) {
		if(player.tou >= 75) {
			perkList.push({label:"Resolute"});
		}
		if(player.tou >= 60) {
			perkList.push({label:"Iron Man"});
		}
	}
	//slot 3 - speed perk
	if(player.spe >= 25) {
			perkList.push({label:"Evade"});
	}
	//slot 3 - run perk
	if(player.spe >= 25) {
			perkList.push({label:"Runner"});
	}
	//slot 3 - Double Attack perk
	if(player.hasPerk("Evade") >= 0 && player.hasPerk("Runner") >= 0 && player.spe >= 50) {
			perkList.push({label:"Double Attack"});
	}
	//Tier 1 Speed Perks
	if(player.level >= 6) {
		//Speedy Recovery - Regain Fatigue 50% faster speed.
		if(player.hasPerk("Evade") >= 0 && player.spe >= 60) {
			perkList.push({label:"Speedy Recovery"});
		}
		//Agility - A small portion of your speed is applied to your defense rating when wearing light armors.
		if(player.spe > 75 && player.hasPerk("Runner") >= 0 && (player.armorPerk == "Light" || player.armorPerk == "Medium")) {
			perkList.push({label:"Agility"});
		}
		if(player.spe >= 60) {
			perkList.push({label:"Lightning Strikes"});
		}
	}
	//Tier 2 Speed Perks
	if(player.level >= 12) {
		if(player.spe >= 75) {
			perkList.push({label:"Lunging Attacks"});
		}
	}
	//Slot 4 - precision - -10 enemy toughness for damage calc
	if(player.inte >= 25) {
			perkList.push({label:"Precision"});
	}
	//Spellpower - boosts spell power
	if(player.inte >= 50) {
			perkList.push({label:"Spellpower"});
	}
	if(player.hasPerk("Spellpower") >= 0 && player.inte >= 50) {
			perkList.push({label:"Mage"});
	}
	//Tier 1 Intelligence Perks
	if(player.level >= 6) {
		if(player.inte >= 50)
			perkList.push({label:"Tactician"});
		if(spellCount() > 0 && player.hasPerk("Spellpower") >= 0 && player.hasPerk("Mage") >= 0 && player.inte >= 60) {
			perkList.push({label:"Channeling"});
		}
		if(player.inte >= 60) {
			perkList.push({label:"Medicine"});
		}
	}
	//Tier 2 Intelligence perks
	if(player.level >= 12) {
		if(player.hasPerk("Mage") >= 0 && player.inte >= 75) {
			perkList.push({label:"Archmage"});
		}
	}
	//LIBIDO PERKZ
	//slot 5 - libido perks
	//Slot 5 - Fertile+ increases cum production and fertility (+15%)
	if(player.lib >= 25) {
			perkList.push({label:"Fertility+"});
	}
	//Slot 5 - minimum libido
	if(player.lib >= 50) {
			perkList.push({label:"Hot Blooded"});
	}
	//Tier 1 Libido Perks
	if(player.level >= 6) {
		//Slot 5 - minimum libido
		if(player.lib >= 60) {
			perkList.push({label:"Well Adjusted"});
		}
		//Slot 5 - minimum libido
		if(player.lib >= 60 && player.cor >= 50) {
			perkList.push({label:"Masochist"});
		}
	}
	//Corruption Perks - slot 7
	//Slot 7 - Corrupted Libido - lust raises 10% slower.
	if(player.cor >= 25) {
			perkList.push({label:"Corrupted Libido"});
	}
	//Slot 7 - Seduction (Must have seduced Jojo
	if(player.hasPerk("Seduction") < 0 && player.cor >= 50 && monk >= 5) {
			perkList.push({label:"Seduction"});
	}
	//Slot 7 - Nymphomania
	else if(player.hasPerk("Corrupted Libido") >= 0 && player.cor >= 75) {
			perkList.push({label:"Nymphomania"});
	}
	//Slot 7 - UNFINISHED :3
	if(minLust() >= 20 && player.hasPerk("Corrupted Libido") >= 0 && player.cor >= 50) {
			perkList.push({label:"Acclimation"});
	}
	//Tier 1 Corruption Perks - acclimation over-rides
	else if(player.level >= 6)
	{
		if(player.cor >= 60 && player.hasPerk("Corrupted Libido") >= 0) {
			perkList.push({label:"Sadist"});
		}
		if(player.hasPerk("Corrupted Libido") >= 0 && player.cor >= 70) {
			perkList.push({label:"Arousing Aura"});
		}
	}
	//Tier 1 Misc Perks
	if(player.level >= 6) {
		perkList.push({label:"Resistance"});
	}
	// FILTER PERKS
	perkList = perkList.filter(
			function(perk:*,idx:int,array:Array):Boolean{
				return player.hasPerk(perk.label) < 0;
			});
	mainView.aCb.dataProvider = new DataProvider(perkList); 
}

public function applyPerk(pName:String = ""):void {
	player.perkPoints--;
	//Apply perk here.
	outputText("<b>" + tempPerk + "</b> gained!", true);
	switch(tempPerk) {
		case "Strong Back 2: Strong Harder":
			player.createPerk("Strong Back 2: Strong Harder",0,0,0,0, "Enables fifth item slot.");
			player.itemSlot5.unlocked = true;
			break;
		case "Strong Back":
			player.createPerk("Strong Back",0,0,0,0, "Enables fourth item slot.");
			player.itemSlot4.unlocked = true;
			break;
		case "Tank":
			player.createPerk("Tank",0,0,0,0,"Raises max HP by 50.");
			break;
		case "Regeneration":
			player.createPerk("Regeneration",0,0,0,0,"Regenerates 2% of max HP/hour and 1% of max HP/round.");
			break;
		case "Iron Man":
			player.createPerk("Iron Man",0,0,0,0,"Now now, don't cheat.");
			break;
		case "Evade":
			player.createPerk("Evade",0,0,0,0,"Increases avoidance chances.");
			break;
		case "Runner":
			player.createPerk("Runner",0,0,0,0,"Increases chances of escaping combat.");
			break;
		case "Fertility+":
			player.createPerk("Fertility+",15,1.75,0,0,"Increases pregnancy chance by 15% and cum volume by up to 50%.");
			break;
		case "Hot Blooded":
			player.createPerk("Hot Blooded",20,0,0,0, "Raises minimum lust by up to 20.");
			break;
		case "Corrupted Libido":
			player.createPerk("Corrupted Libido",20,0,0,0, "Reduces lust gain by 10%.");
			break;
		case "Seduction":
			player.createPerk("Seduction",0,0,0,0,"Upgrades your tease attack, making it more effective.");
			break;
		case "Precision":
			player.createPerk("Precision",0,0,0,0,"Reduces enemy damage resistance by 10.");
			break;
		case "Nymphomania":
			player.createPerk("Nymphomania",0,0,0,0,"Raises minimum lust by up to 30.");
			break;
		case "Spellpower":
			player.createPerk("Spellpower",0,0,0,0,"Increases the effects of your spells by up to 50%.");
			break;
		case "Mage":
			player.createPerk("Mage",0,0,0,0,"Increases the strength of your spells even more than 'Spellpower', up to 100%.");
			break;
		case "Double Attack":
			player.createPerk("Double Attack",0,0,0,0,"Allows you to perform two melee attacks per round.");
			break;
		case "Acclimation":
			player.createPerk("Acclimation",0,0,0,0,"Reduces the rate at which your lust increases.");
			break;
		case "Thunderous Strikes":
			player.createPerk("Thunderous Strikes",0,0,0,0,"+20% 'Attack' damage while strength is at or above 80.");
			break;
		case "Weapon Mastery":
			player.createPerk("Weapon Mastery",0,0,0,0,"After getting so good at carrying large objects, you find large weapons much easier to handle (Double 'Large' weapon bonuses when equipped).");
			break;
		case "Tank 2":
			player.createPerk("Tank 2",0,0,0,0,"Your maximum HP is raised by an extra 1 point per point of toughness!");
			HPChange(player.tou, false);
			statScreenRefresh();
			break;
		case "Regeneration 2":
			player.createPerk("Regeneration 2",0,0,0,0,"You regenerate an additional 2% of max HP per round and heal faster out of combat (4% of max HP/hour)");
			break;
		case "Speedy Recovery":
			player.createPerk("Speedy Recovery",0,0,0,0,"Thanks to your impressive metabolism you regain fatigue 50% faster.");
			break;
		case "Agility":
			player.createPerk("Agility",0,0,0,0,"When wearing light or medium armor its effectiveness is increased by a portion of your speed.");
			break;
		case "Channeling":
			player.createPerk("Channeling",0,0,0,0,"You've gotten even better at spellcasting, gaining up to 50% more effectiveness!");
			break;
		case "Medicine":
			player.createPerk("Medicine",0,0,0,0,"You now have a 15% chance per round of cleansing poisons/drugs from your body.");
			break;
		case "Well Adjusted":
			player.createPerk("Well Adjusted",0,0,0,0,"You gain half as much lust as time passes in Mareth.");
			break;
		case "Masochist":
			player.createPerk("Masochist",0,0,0,0,"You have a masochism fetish and take 30 percent less damage, but your lust goes up when struck (Requires 60+ Libido).");
			break;
		case "Sadist":
			player.createPerk("Sadist",0,0,0,0,"You have a sadism fetish and strike harder, but become aroused by the act of dealing damage.");
			break;
		case "Arousing Aura":
			player.createPerk("Arousing Aura",0,0,0,0,"While your corruption is at or above 70, you exude an aura of lust.");
			break;
		case "Resistance":
			player.createPerk("Resistance",0,0,0,0,"You've become resistant to the myriad ways your lust can be increased.");
			break;
		case "Tactician":
			player.createPerk("Tactician",0,0,0,0,"");
			break;
		case "Archmage":
			player.createPerk("Archmage",0,0,0,0,"");
			break;
		case "Lunging Attacks":
			player.createPerk("Lunging Attacks",0,0,0,0,"");
			break;
		case "Lightning Strikes":
			player.createPerk("Lightning Strikes",0,0,0,0,"");
			break;
		case "Immovable Object":
			player.createPerk("Immovable Object",0,0,0,0,"");
			break;
		case "Resolute":
			player.createPerk("Resolute",0,0,0,0,"");
			break;
		case "Berzerker":
			player.createPerk("Berzerker",0,0,0,0,"");
			break;
		case "Brutal Blows":
			player.createPerk("Brutal Blows",0,0,0,0,"");
			break;
		default:
			outputText("\n\n<b>AN ERROR HAS OCCURRED: </b>Invalid tempPerk value!", false);
			player.perkPoints++;
			break;
	}
	doNext(1);
}

public function buttonText(buttonName:String):String {
	var matches :*,
		buttonIndex :int;

	if( buttonName is String ) {
		if( /^buttons\[[0-9]\]/.test( buttonName ) ) {
			matches = /^buttons\[([0-9])\]/.exec( buttonName );
			buttonIndex = parseInt( matches[ 1 ], 10 );
		}
		else if( /^b[0-9]Text$/.test( buttonName ) ) {
			matches = /^b([0-9])Text$/.exec( buttonName );
			buttonIndex = parseInt( matches[ 1 ], 10 );

			buttonIndex = buttonIndex === 0 ? 9 : buttonIndex - 1;
		}
	}

	return (mainView.getButtonText( buttonIndex ) || "NULL");
}


// Returns a string or undefined.
public function getButtonToolTipText( buttonText :String ) :String
{
	var toolTipText :String;

	buttonText = buttonText || '';

	//Perkzzz
	if(buttonText.indexOf("Strong Back") != -1) {
		toolTipText = "The Strong Back perk unlocks an additional inventory space, allowing you to carry more.";
	}
	if(buttonText.indexOf("StrongBack2") != -1) {
		toolTipText = "The Strong Back 2 perk unlocks a fifth inventory location, allowing you to carry as much as possible.";
	}
	if(buttonText.indexOf("T.Strikes") != -1) {
		toolTipText = "You've gotten so good at putting your sizable strength behind your attacks that you deal 20% more damage with standard attacks while strength is 80 or higher.";
	}
	if(buttonText.indexOf("W.Mastery") != -1) {
		toolTipText = "After getting so good at carrying large objects, you find large weapons much easier to handle (Double 'Large' weapon bonuses when equipped).";
	}
	if(buttonText.indexOf("Tank 2") != -1) {
		toolTipText = "Tank 2 raises your maximum HP by an additional 1 HP per point of toughness.";
	}
	if(buttonText.indexOf("Tank") != -1) {
		toolTipText = "The Tank perk adds an additional 50 HP to your maximum hitpoints, allowing you take more damage before losing a fight.";
	}
	if(buttonText.indexOf("Regenerate") != -1) {
		toolTipText = "The Regeneration perk makes your hit points come back faster, both in and out of combat.  In combat you gain 1 HP a round, outside of combat you'll get 2 HP an hour.";
	}
	if(buttonText.indexOf("Regen 2") != -1) {
		toolTipText = "The Regeneration 2 perk quadruples the effectiveness of your regeneration.";
	}
	if(buttonText.indexOf("Evade") != -1) {
		toolTipText = "The Evade perk gives you an additional 10% chance to avoid enemy attacks beyond the normal dodge chance.";
	}
	if(buttonText.indexOf("Agility") != -1) {
		toolTipText = "The agility perk allows you to increase your armor defense by a portion of your speed when wearing light or medium armor.";
	}
	if(buttonText.indexOf("S.Recovery") != -1) {
		toolTipText = "The speedy recovery perk increases the rate at which you regain fatigue.";
	}
	if(buttonText.indexOf("D.Attack") != -1) {
		toolTipText = "The Double Attack perk lets you take advantage of your incredible speed to attack twice in one round.  Requires high speed and strength at or below 60.";
	}
	if(buttonText.indexOf("Spellpower") != -1) {
		toolTipText = "The Spellpower perk increases the effects of your spells by up to 50% (dependant on the spell).";
	}
	if(buttonText.indexOf("Mage") != -1) {
		toolTipText = "The Mage perk increases the effects of your spells by up to 100% (dependant on the spell).";
	}
	if(buttonText.indexOf("Channeling") != -1) {
		toolTipText = "The channeling perk increases the spell bonus by up to an additional 50%.";
	}
	if(buttonText.indexOf("Medicine") != -1) {
		toolTipText = "The medicine perk gives you a 15% chance per round of removing all non-biological poisons in combat.";
	}
	if(buttonText.indexOf("Runner") != -1) {
		toolTipText = "The Runner perk increases your chances of escaping combat significantly, and may help with out of combat escapes as well.";
	}
	if(buttonText.indexOf("Fertility+") != -1) {
		toolTipText = "The Fertility+ perk increases your pregnancy chance by 15% and also increases any cum production by 50 percent!";
	}
	if(buttonText.indexOf("Hot Blooded") != -1) {
		toolTipText = "The Hot Blooded perk takes advantage of your enhanced libido, allowing your lust to never drop below 20.";
	}
	if(buttonText.indexOf("W.Adjusted") != -1) {
		toolTipText = "The Well Adjusted perk halves the lust you gain over time in Mareth.";
	}
	if(buttonText.indexOf("Masochist") != -1) {
		toolTipText = "The Masochism perk reduces damage taken by 30 percent but raises your lust from each hit.";
	}
	if(buttonText.indexOf("CorruptLibido") != -1) {
		toolTipText = "The Corrupted Libido perk lets you use your corruption to adapt to your heightened libido, making lust rise 10 percent slower.";
	}
	if(buttonText.indexOf("Seduction") != -1) {
		toolTipText = "The Seduction perk enhances your ability to tease and seduce, upgrading your tease attack significantly.";
	}
	if(buttonText.indexOf("Acclimation") != -1) {
		toolTipText = "The Acclimation perk allows your highly corrupted form to adapt to the constant lust it's subjected to, slowing additional lust gain.";
	}
	if(buttonText.indexOf("A. Aura") != -1) {
		toolTipText = "The Arousing Aura perk causes you to exude a lust-inducing aura whenever your corruption is 70 or above.";
	}
	if(buttonText.indexOf("Sadist") != -1) {
		toolTipText = "The Sadist perk increases the damage you do with some physical attacks by 20% but causes you to gain lust from it.";
	}
	if(buttonText.indexOf("Resistance") != -1) {
		toolTipText = "The Resistance perk gives you an additional reduction to lust gains.";
	}
	if(buttonText.indexOf("Precision") != -1) {
		toolTipText = "The Precision perk allows you to strike an enemy's weak points, reducing damage resistance by 10.  Requires you to keep intelligence above 25, or you'll lose the benefits of this perk.";
	}
	if(buttonText.indexOf("Nymphomania") != -1) {
		toolTipText = "The Nymphomania perk allows your corruption to have it's way with your lust, keeping you constantly aroused.  Your lust will never drop below 30 with this perk.";
	}
	//Items
    var itype:ItemType = ItemType.lookupItem(buttonText);
    if (itype != null) toolTipText = itype.description;
	if(buttonText.indexOf("Demon Whip") != -1) {
		toolTipText = "This coiled length of midnight-black leather practically exudes lust.  Though it looks like it could do a lot of damage, the feel of that slick leather impacting flesh is sure to inspire lust.";
	}
	if(buttonText == "GoblinAle") {
		toolTipText = "This sealed flagon of 'Goblin Ale' sloshes noisily with alcoholic brew.  Judging by the markings on the flagon, it's a VERY strong drink, and not to be trifled with.";
	}
	if(buttonText.indexOf("W. Staff") != -1) {
		toolTipText = "An oddly bent piece of solid wood favored by spell-casters.  It is said to be made of from one of Marae's roots and allow for easier magic use. (ATK: 3) (Cost: 350)";
	}
	if(buttonText.indexOf("L.Claymore") != -1) {
		toolTipText = "A massive sword that a very strong warrior might use. Requires 40 strength to use.  (ATK: 15) (Cost: 1000)";
	}
	if(buttonText.indexOf("Warhammer") != -1) {
		toolTipText = "A huge war-hammer made almost entirely of steel that only the strongest warriors could use.  Requires 80 strength to use.  Getting hit with this might stun the victim.  (ATK: 15) (Cost: 1600)";
	}
	if(buttonText.indexOf("Katana") != -1) {
		toolTipText = "A curved bladed weapon that cuts through flesh with the greatest of ease. (ATK: 10) (Cost: 500)";
	}
	if(buttonText.indexOf("Spear") != -1) {
		toolTipText = "A staff with a sharp blade at the tip designed to pierce through the toughest armor.  This would ignore most armors.  (ATK: 8) (Cost: 450)";
	}
	if(buttonText.indexOf("Whip") != -1) {
		toolTipText = "A coiled length of leather designed to lash your foes into submission.  There's a chance the bondage inclined might enjoy it! (ATK: 5) (Cost: 500)";
	}
	if(buttonText.indexOf("Tail Whip") != -1) {
		toolTipText = "Whip your foe with your tail to enrage them and lower their defense!";
	}
	if(buttonText.indexOf("S.Gauntlet") != -1) {
		toolTipText = "This single metal gauntlet has the knuckles tipped with metal spikes.  Though it lacks the damaging potential of other weapons, the sheer pain of its wounds has a chance of stunning your opponent. (ATK: 5) (Cost: 400)";
	}
	if(buttonText.indexOf("Vitality T.") != -1) {
		toolTipText = "This potent tea is supposedly good for the strengthening the body.";
	}
	if(buttonText.indexOf("Scholars T.") != -1) {
		toolTipText = "This powerful brew supposedly has mind-strengthening effects.";
	}
	if(buttonText.indexOf("Dual Belt") != -1) {
		toolTipText = "This is a strange masturbation device, meant to work every available avenue of stimulation.";
	}
	if(buttonText.indexOf("C. Pole") != -1) {
		toolTipText = "This 'centaur pole' as it's called appears to be a sex-toy designed for females of the equine persuasion.  Oddly, it's been sculpted to look like a giant imp, with an even bigger horse-cock.";
	}
	if(buttonText.indexOf("Fake Mare") != -1) {
		toolTipText = "This fake mare is made of metal and wood, but the anatomically correct vagina looks as soft and wet as any female centaur's.";
	}
	if(buttonText == "LustDraft") {
		toolTipText = "This vial of bright pink fluid bubbles constantly inside the glass, as if eager to escape.  It smells very sweet, and has \"Lust\" inscribed on the side of the vial.";
	}
	if(buttonText == "OviElixir") {
		toolTipText = "This hexagonal crystal bottle is filled with a strange green fluid.  A tag with a picture of an egg is tied to the neck of the bottle, indicating it is somehow connected to egg-laying.";
	}
	if(buttonText.indexOf("Cerulean P.") != -1) {
		toolTipText = "This is a mysterious bottle filled with a sky-blue liquid that sloshes gently inside.  Supposedly it will make you irresistible, though to what or who you cannot say.";
	}
	//Combat
	//COMBAT
	//combat
	//wombat
	if (buttonText == "Attack") {
		if (gameState != 1) toolTipText = "";
		else toolTipText = "Attempt to attack the enemy with your " + player.weaponName + ".  Damage done is determined by your strength and weapon.";
	}
	if(buttonText == "Kiss") {                        
		toolTipText = "Attempt to kiss your foe on the lips with drugged lipstick.  It has no effect on those without a penis.";
	}
	if(buttonText == "Tease") {
		if (gameState != 1) toolTipText = "";
		else toolTipText = "Attempt to make an enemy more aroused by striking a seductive pose and exposing parts of your body.";
	}
	if(buttonText == "Kick") {                        
		toolTipText = "Attempt to kick an enemy using your powerful lower body.";
	}
	if(buttonText == "Combo") {                        
		toolTipText = "Make a three-hit combo.  Each attack has an extra 33% chance to miss, unless the target is blind. (25 Fatigue)";
	}
	if(buttonText == "Vault") {                        
		toolTipText = "Make a vaulting attack for an extra 25% damage.  Automatically crits stunned foes.  (20 Fatigue)";
	}
	if(buttonText == "Sidewinder") {                        
		toolTipText = "An attack that hits for reduced damage but has a high chance of stunning. (10 Fatigue)";
	}
	if(buttonText == "Dirt Kick") {                        
		toolTipText = "Attempt to blind your foe with a spray of kicked dirt. (5 Fatigue)";
	}
	if(buttonText == "Metabolize") {                        
		toolTipText = "Convert 10% of your maximum HP into fatigue.";
	}
	if(buttonText == "SecondWind") {                        
		toolTipText = "Regain 50% of your HP, 50 fatigue, and reduce lust by 50 once per fight.";
	}
	if(buttonText.indexOf("AnemoneSting") != -1) {                        
		toolTipText = "Attempt to strike an opponent with the stinging tentacles growing from your scalp.  Reduces enemy speed and increases enemy lust.";
	}
	if(buttonText.indexOf("P. Specials") != -1) {                        
		toolTipText = "Physical special attack menu.";
	}
	if(buttonText.indexOf("M. Specials") != -1) {                        
		toolTipText = "Mental and supernatural special attack menu.";
	}
	if(buttonText == "Berzerk") {                        
		toolTipText = "Throw yourself into a rage!  Greatly increases the strength of your weapon and increases lust resistance, but your armor defense is reduced to zero!";
	}
	if(buttonText.indexOf("Possess") != -1) {                        
		toolTipText = "Attempt to temporarily possess a foe and force them to raise their own lusts.";
	}
	if(buttonText.indexOf("Constrict") != -1) {                        
		toolTipText = "Attempt to bind an enemy in your long snake-tail.";
	}
	if(buttonText.indexOf("Gore") != -1) {                        
		toolTipText = "Lower your head and charge your opponent, attempting to gore them on your horns.  This attack is stronger and easier to land with large horns.";
	}
	if(buttonText.indexOf("Fantasize") != -1) {                        
		toolTipText = "Fantasize about your opponent in a sexual way.  Its probably a pretty bad idea to do this unless you want to end up getting raped.";
	}
	if(buttonText.indexOf("Charge W.") != -1) {                        
		toolTipText = "The Charge Weapon spell will surround your weapon in electrical energy, causing it to do even more damage.  The effect lasts for the entire combat.  (Fatigue Cost: " + spellCost(15) + ")";
	}
	if(buttonText.indexOf("Blind") != -1) {                        
		toolTipText = "Blind is a fairly self-explanatory spell.  It will create a bright flash just in front of the victim's eyes, blinding them for a time.  However if they blink it will be wasted.  (Fatigue Cost: " + spellCost(20) + ")";
	}
	if(buttonText.indexOf("Whitefire") != -1) {                        
		toolTipText = "Whitefire is a potent fire based attack that will burn your foe with flickering white flames, ignoring their physical toughness and most armors.  (Fatigue Cost: " + spellCost(30) + ")";
	}
	if(buttonText.indexOf("Aroused") != -1) {
	}
	if(buttonText.indexOf("Arouse") != -1) {                        
		if (gameState != 1) toolTipText = "";
		else toolTipText = "The arouse spell draws on your own inner lust in order enflame the enemy's passions.  (Fatigue Cost: " + spellCost(15) + ")";
	}
	if(buttonText == "Heal") {                        
		toolTipText = "Heal will attempt to use black magic to close your wounds and restore your body, however like all black magic used on yourself, it has a chance of backfiring and greatly arousing you.  (Fatigue Cost: " + spellCost(20) + ")";
	}
	if(buttonText.indexOf("Might") != -1) {                        
		toolTipText = "The Might spell draws upon your lust and uses it to fuel a temporary increase in muscle size and power.  It does carry the risk of backfiring and raising lust, like all black magic used on oneself.  (Fatigue Cost: " + spellCost(25) + ")";
	}
	//Wait
	if(buttonText.indexOf("Wait") != -1 && gameState > 0) {                        
		toolTipText = "Take no action for this round.  Why would you do this.  This is a terrible idea.";
	}
	//Sting
	if(buttonText.indexOf("Sting") != -1) {                        
		toolTipText = "Attempt to use your venomous bee stinger on an enemy.  Be aware it takes quite a while for your venom to build up, so depending on your abdomen's refractory period, you may have to wait quite a while between stings.  Venom: " + Math.floor(player.tailVenom) + "/100";
	}
	//Web
	if(buttonText.indexOf("Web") != -1) {                        
		toolTipText = "Attempt to use your abdomen to spray sticky webs at an enemy and greatly slow them down.  Be aware it takes a while for your webbing to build up.  Web Amount: " + Math.floor(player.tailVenom) + "/100";
	}
	if(buttonText.indexOf("Infest") != -1) {
		toolTipText = "The infest attack allows you to cum at will, launching a stream of semen and worms at your opponent in order to infest them.  Unless your foe is very aroused they are likely to simply avoid it.  Only works on males or herms.";
	}
	if(buttonText.indexOf("Spells") != -1) {                        
		toolTipText = "Opens your spells menu, where you can cast any spells you have learned.  Beware, casting spells increases your fatigue, and if you become exhausted you will be easier to defeat.";
	}
	if(buttonText.indexOf("Defend") != -1) {                        
		toolTipText = "Selecting defend will reduce the damage you take by 66 percent, but will not affect any lust incurred by your enemy's actions.";
	}
	if(buttonText == "Run") {                        
		toolTipText = "Choosing to run will let you try to escape from your enemy. However, it will be hard to escape enemies that are faster than you and if you fail, your enemy will get a free attack.";
	}
	if(buttonText.indexOf("Inventory") != -1) {                
		toolTipText = "The inventory allows you to use an item.  Be careful as this leaves you open to a counterattack when in combat.";
	}
	if(buttonText.indexOf("AutoSav") != -1) {                
		toolTipText = "When autosave is on the game will automatically save your character each night at midnight to the last slot it was saved in.";
		if(buttonText.indexOf("ON") != -1) toolTipText += " Autosave is currently enabled.  Your game will be saved at midnight.";
		if(buttonText.indexOf("OFF") != -1) toolTipText += " Autosave is currently off.  Your game will NOT be saved.";
	}
	if(buttonText.indexOf("Retrieve") != -1) {                
		toolTipText = "Retrieve allows you to take an item from one of the reserve stacks in your camp's additional storage.";
	}
	if(buttonText.indexOf("Storage") != -1) {                
		toolTipText = "Storage will allow you to dump a stack of items from your inventory into your storage chest.";
	}
	if(buttonText.indexOf("Sand Facial") != -1) {                
		toolTipText = "The goblins promise this facial will give you a rough, handsome look thanks to their special, timeless sands.";
	}
	if(buttonText.indexOf("Mud Facial") != -1) {                
		toolTipText = "This facial is supposed to enhance the softness of your face and enhance its femininity greatly.";
	}
	//Masturbation Toys
	if(buttonText == "Masturbate") {
		toolTipText = "Selecting this option will attempt to manually masturbate in order to relieve your lust buildup.";
	}
	if(buttonText == "Meditate") {
		toolTipText = "Selecting this option will attempt to meditate in order to reduce lust and corruption.";
	}
	if(buttonText.indexOf("AN Stim-Belt") != -1) {
		toolTipText = "This is an all-natural self-stimulation belt.  The methods used to create such a pleasure device are unknown.  It seems to be organic in nature.";
	}
	if(buttonText.indexOf("Stim-Belt") != -1) {
		toolTipText = "This is a self-stimulation belt.  Commonly referred to as stim-belts, these are clockwork devices designed to pleasure the female anatomy.";
	}
	if(buttonText.indexOf("AN Onahole") != -1) {
		toolTipText = "An all-natural onahole, this device looks more like a bulbous creature than a sex-toy.  Never-the-less, the slick orifice it presents looks very inviting.";
	}
	if(buttonText.indexOf("D Onahole") != -1) {
		toolTipText = "This is a deluxe onahole, made of exceptional materials and with the finest craftsmanship in order to bring its user to the height of pleasure.";
	}
	if(buttonText.indexOf("Onahole") != -1) {
		toolTipText = "This is what is called an 'onahole'.  This device is a simple textured sleeve designed to fit around the male anatomy in a pleasurable way.";
	}
	if(buttonText == "Jojo") {
		if(monk >= 5) toolTipText = "Call your corrupted pet into camp in order to relieve your desires in a variety of sexual positions?  He's ever so willing after your last encounter with him.";
		else toolTipText = "Go find Jojo around the edges of your camp and meditate with him or talk about watch duty.";
	}
	if(buttonText == "Marble") {
		toolTipText = "Go to Marble the cowgirl for talk and companionship.";
	}
	//Books
	if(buttonText.indexOf("Dangerous Plants") != -1) {
		toolTipText = "This is a book titled 'Dangerous Plants'.  As explained by the title, this tome is filled with information on all manner of dangerous plants from this realm.";
	}
	if(buttonText.indexOf("Traveler's Guide") != -1) {
		toolTipText = "This traveler's guide is more of a pamphlet than an actual book, but it still contains some useful information on avoiding local pitfalls.";
	}
	if(buttonText.indexOf("Yoga Guide") != -1) {
		toolTipText = "This leather-bound book is titled 'Yoga for Non-Humanoids.' It contains numerous illustrations of centaurs, nagas and various other oddly-shaped beings in a variety of poses.";
	}
	if(buttonText.indexOf("Hentai Comic") != -1) {
		toolTipText = "This oddly drawn comic book is filled with images of fornication, sex, and overly large eyeballs.";
	}
	//CAMP STUFF
	if(buttonText.indexOf("Followers") != -1) {
		toolTipText = "Check up on any followers or companions who are joining you in or around your camp.  You'll probably just end up sleeping with them.";
	}
	//Marble
	if(buttonText.indexOf("Marble (Sex)") != -1) {
		toolTipText = "Get with marble for a quick cuddle and some sex.";
	}
	//Rathazul
	if(buttonText.indexOf("Rathazul") != -1) {
		toolTipText = "Visit with Rathazul to see what alchemical supplies and services he has available at the moment.";
	}
	//Title screen
	if(buttonText.indexOf("Toggle Debug") != -1) {                        
		toolTipText = "Turn on debug mode.  Debug mode is intended for testing purposes but can be thought of as a cheat mode.  Items are infinite and combat is easy to escape from.  Weirdness and bugs are to be expected.";
	}
	if(buttonText.indexOf("Credits") != -1) {                        
		toolTipText = "See a list of all the cool people who have contributed to content for this game!";
	}
	if(buttonText.indexOf("Instructions") != -1) {                        
		toolTipText = "How to play.  Starting tips.  And hotkeys for easy left-handed play...";
	}
	if(buttonText.indexOf("Settings") != -1) {                        
		toolTipText = "Configure game settings and enable cheats.";
	}
	if(buttonText.indexOf("ASPLODE") != -1) {                        
		toolTipText = "MAKE SHIT ASPLODE";
	}
	return toolTipText;
}


// Hah, finally a place where a dictionary is actually required!
import flash.utils.Dictionary;
private var funcLookups:Dictionary = null;


private function buildFuncLookupDict(object:*=null,prefix:String=""):void
{
	import flash.utils.*;
	trace("Building function <-> function name mapping table for "+((object==null)?"CoC.":prefix));
	// get all methods contained
	if (object == null) object = this;
	var typeDesc:XML = describeType(object);
	//trace("TypeDesc - ", typeDesc)

	for each (var node:XML in typeDesc..method) 
	{
		// return the method name if the thisObject of f (t) 
		// has a property by that name 
		// that is not null (null = doesn't exist) and 
		// is strictly equal to the function we search the name of
		//trace("this[node.@name] = ", this[node.@name], " node.@name = ", node.@name)
		if (object[node.@name] != null)
			this.funcLookups[object[node.@name]] = prefix+node.@name;
	}
	for each (node in typeDesc..variable)
	{
		if (node.@type.toString().indexOf("classes.Scenes.") == 0 ||
				node.metadata.@name.contains("Scene")){
			if (object[node.@name]!=null){
				buildFuncLookupDict(object[node.@name],node.@name+".");
			}
		}
	}
}

public function getFunctionName(f:Function):String
{
	// trace("Getting function name")
	// get the object that contains the function (this of f)
	//var t:Object = flash.sampler.getSavedThis(f); 
	if (this.funcLookups == null)
	{
		trace("Rebuilding lookup object");
		this.funcLookups = new Dictionary();
		this.buildFuncLookupDict();
	}


	if (f in this.funcLookups)
		return(this.funcLookups[f]);
	
	// if we arrive here, we haven't found anything... 
	// maybe the function is declared in the private namespace?
	return null;
}


private function logFunctionInfo(func:Function, arg:* = null):void
{
	var logStr:String = "";
	if (arg is Function)
	{
		logStr += "Calling = " + getFunctionName(func) + " Param = " +  getFunctionName(arg);
	}
	else
	{
		logStr += "Calling = " + getFunctionName(func) + " Param = " +  arg;
	}
	CoC_Settings.appendButtonEvent(logStr);
	trace(logStr)
}


// returns a function that takes no arguments, and executes function `func` with argument `arg`
public function createCallBackFunction(func:Function, arg:*):Function
{
	if (func == null) {
		CoC_Settings.error("createCallBackFunction(null," + arg + ")");
	}
	if( arg == -9000 || arg == null )
	{
		if (func == eventParser){
			CoC_Settings.error("createCallBackFunction(eventParser,"+arg+")");
		}
		return function ():*
		{ 
			if (CoC_Settings.haltOnErrors) 
				logFunctionInfo(func, arg);
			return func(); 
		};
	}
	else
	{
		return function ():*
		{ 
			if (CoC_Settings.haltOnErrors) 
				logFunctionInfo(func, arg);
			return func( arg ); 
		};
	}
}
public function createCallBackFunction2(func:Function,...args):Function
{
	if (func == null){
		CoC_Settings.error("createCallBackFunction(null,"+args+")");
	}
	return function():*
	{
		if (CoC_Settings.haltOnErrors) logFunctionInfo(func,args);
		return func.apply(null,args);
	}
}


public function addButton(pos:int, text:String = "", func1:Function = null, arg1:* = -9000):void {
	if (func1==null) return;
	var callback :Function,
	toolTipText :String;

	if(pos > 9) {
		trace("INVALID BUTTON");
		return;
	}

	callback = createCallBackFunction(func1, arg1);
	

	toolTipText = getButtonToolTipText( text );
	mainView.showBottomButton( pos, text, callback, toolTipText );
	mainView.setOutputText( currentText );
}

public function hasButton(arg:*):Boolean {
	if( arg is String )
		return mainView.hasButton( arg as String );
	else
		return false;
}

public function removeButton(arg:*):void {
	function _removeButtonAction( index :int ):void	// Uh... should this function be empty?
	{
		// funcs[ index ] = null;
		// args[ index ] = -9000;
	}

	var buttonToRemove:int = 0;
	if(arg is String) {
		buttonToRemove = mainView.indexOfButtonWithLabel( arg as String );
	}
	if(arg is Number) {
		if(arg < 0 || arg > 9) return;
		buttonToRemove = Math.round(arg);
	}
	
	// _removeButtonAction( buttonToRemove );
	mainView.hideBottomButton( buttonToRemove );
}

// AFICT, menu() isn't called with arguments ANYWHERE in the codebase.
// WHRYYYYYYY
public function menu(text1:String = "", func1:Function = null, arg1:Number = -9000, 
					text2:String = null, func2:Function = null, arg2:Number = -9000, 
					text3:String = null, func3:Function = null, arg3:Number = -9000, 
					text4:String = null, func4:Function = null, arg4:Number = -9000, 
					text5:String = null, func5:Function = null, arg5:Number = -9000, 
					text6:String = null, func6:Function = null, arg6:Number = -9000, 
					text7:String = null, func7:Function = null, arg7:Number = -9000, 
					text8:String = null, func8:Function = null, arg8:Number = -9000, 
					text9:String = null, func9:Function = null, arg9:Number = -9000, 
					text0:String = null, func0:Function = null, arg0:Number = -9000):void 
{
	
	function _conditionallyShowButton( index :int, label :String, func :Function, arg :Number ) :void
	{
		var callback :Function, toolTipText :String;

		

		
		if( func != null )
		{
			callback = createCallBackFunction(func1, arg1);

			toolTipText = getButtonToolTipText( label );
			// This is a kind of messy hack because I want to log the button events, so I can do better debugging.
			// therefore, we wrap the callback function in a shim function that does event-logging, and
			// *then* calls the relevant callback.

			
			mainView.showBottomButton( index, label, callback, toolTipText );
			
		}
		else
		{
			mainView.hideBottomButton( index );
		}
	}

	//Clear funcs & args
	// funcs = new Array();
	// args = new Array();
	
	_conditionallyShowButton( 0, text1, func1, arg1 );
	_conditionallyShowButton( 1, text2, func2, arg2 );
	_conditionallyShowButton( 2, text3, func3, arg3 );
	_conditionallyShowButton( 3, text4, func4, arg4 );
	_conditionallyShowButton( 4, text5, func5, arg5 );
	_conditionallyShowButton( 5, text6, func6, arg6 );
	_conditionallyShowButton( 6, text7, func7, arg7 );
	_conditionallyShowButton( 7, text8, func8, arg8 );
	_conditionallyShowButton( 8, text9, func9, arg9 );
	_conditionallyShowButton( 9, text0, func0, arg0 );

	mainView.setOutputText( currentText );
}


public function choices(text1:String, butt1:*, 
						text2:String, butt2:*, 
						text3:String, butt3:*, 
						text4:String, butt4:*, 
						text5:String, butt5:*, 
						text6:String, butt6:*, 
						text7:String, butt7:*, 
						text8:String, butt8:*, 
						text9:String, butt9:*, 
						text0:String, butt0:*):void 
{

	var callback :Function;
	var toolTipText :String;

	var textLabels :Array;
	var j :int;

	textLabels = [
		text1,
		text2,
		text3,
		text4,
		text5,
		text6,
		text7,
		text8,
		text9,
		text0
	];

	//Transfer event code to storage
	buttonEvents[0] = butt1;
	buttonEvents[1] = butt2;
	buttonEvents[2] = butt3;
	buttonEvents[3] = butt4;
	buttonEvents[4] = butt5;
	buttonEvents[5] = butt6;
	buttonEvents[6] = butt7;
	buttonEvents[7] = butt8;
	buttonEvents[8] = butt9;
	buttonEvents[9] = butt0;

	var tmpJ:int;

	// iterate over the button options, and only enable the ones which have a corresponding event number

	for (tmpJ = 0; tmpJ < 10; tmpJ += 1)
	{
		if(buttonEvents[tmpJ] == -9000 || buttonEvents[tmpJ] == 0 || buttonEvents[tmpJ] == null) {
			mainView.hideBottomButton( tmpJ );
		}
		else {
			if (buttonEvents[tmpJ] is Number) {
				callback = createCallBackFunction(eventParser, buttonEvents[tmpJ] );
			} else {
				callback = createCallBackFunction(buttonEvents[tmpJ], null);
			}
			toolTipText = getButtonToolTipText( textLabels[ tmpJ ] );

			mainView.showBottomButton( tmpJ, textLabels[ tmpJ ], callback, toolTipText );
		}

	}

	// funcs = new Array();
	// args = new Array();
	mainView.setOutputText( currentText );
}

/****
	This function is made for multipage menus of unpredictable length,
	say a collection of items or places or people that can change
	depending on certain events, past choices, the time of day, or whatever.

	This is not the best for general menu use.  Use choices() for that.

	This is a bit confusing, so here's usage instructions.
	Pay attention to all the braces.

	This is made to be used with an array that you create before calling it,
	so that you can push as many items on to that array as you like
	before passing that array off to this function.

	So you can do something like this:
		var itemsInStorage :Array = new Array();

		// The extra square braces are important.
		itemsInStorage.push( [ "Doohicky", useDoohickyFunc ] );
		itemsInStorage.push( [ "Whatsit", useWhatsitFunc ] );
		itemsInStorage.push( [ "BagOfDicks", eatBagOfDicks ] );
		...

		// see notes about cancelFunc
		multipageChoices( cancelFunc, itemsInStorage );

	cancelfunc is a function (A button event function, specifically)
	that exits the menu.  Provide this if you want a Back button to appear
	in the bottom right.

	If you do not need a cancel function, perhaps because some or all
	of the choices will exit the menu, then you can
	pass null or 0 for the cancelFunction.

		// This menu shows no Back button.
		multipageChoices( null, itemsInStorage );

	You can call it directly if you want, but that's ridiculous.
		multipageChoices( justGoToCamp, [
			[ "Do this", doThisEvent ],
			[ "Do that", doThatEvent ],
			[ "Do something", doSomethingEvent ],
			[ "Fap", goFapEvent ],
			[ "Rape Jojo", jojoRape ],
			// ... more items here...
			[ "What", goWhat ],
			[ "Margle", gurgleFluidsInMouthEvent ] // no comma on last item.
		]);
****/
public function multipageChoices( cancelFunction :*, menuItems :Array ) :void {
	const itemsPerPage :int = 8;

	var currentPageIndex :int;
	var pageCount :int;

	function getPageOfItems( pageIndex :int ) :Array {
		var startItemIndex:int = pageIndex * itemsPerPage;

		return menuItems.slice( startItemIndex, startItemIndex + itemsPerPage );
	}

	function flatten( pageItems :Array ) :Array {
		var i:int, l:int;
		var flattenedItems:Array = [];

		for( i = 0, l = pageItems.length; i < l; ++i ) {
			flattenedItems = flattenedItems.concat( pageItems[ i ] );
		}

		return flattenedItems;
	}

	function showNextPage() :void {
		showPage( (currentPageIndex + 1) % pageCount );
	}

	function showPage( pageIndex :int ) :void {
		var currentPageItems :Array; // holds the current page of items.

		if( pageIndex < 0 )
			pageIndex = 0;
		if( pageIndex >= pageCount )
			pageIndex = pageCount - 1;

		currentPageIndex = pageIndex;
		currentPageItems = getPageOfItems( pageIndex );

		// I did it this way so as to use only one actual menu setting function.
		// I figured it was safer until the menu functions stabilize.

		// insert page functions.
		// First pad out the items so it's always in a predictable state.
		while( currentPageItems.length < 8 ) {
			currentPageItems.push( [ "", 0 ] );
		}

		// Insert next button.
		currentPageItems.splice( 4, 0, [
			"See page " +
				String( ((currentPageIndex + 1) % pageCount) + 1 ) + // A compelling argument for 1-indexing?
				'/' +
				String( pageCount ),
			pageCount > 1 ? showNextPage : 0
			// "Next Page", pageCount > 1 ? showNextPage : 0
			]);

		// Cancel/Back button always appears in bottom right, like in the inventory.
		currentPageItems.push([
			"Back", cancelFunction || 0
			]);

		choices.apply( null, flatten( currentPageItems ) );
	}

	pageCount = Math.ceil( menuItems.length / itemsPerPage );

	if( typeof cancelFunction != 'function' )
		cancelFunction = 0;

	showPage( 0 );
}

// simpleChoices and doYesNo are convenience functions. They shouldn't re-implement code from choices()
public function simpleChoices(text1:String, butt1:*, 
						text2:String, butt2:*, 
						text3:String, butt3:*, 
						text4:String, butt4:*, 
						text5:String, butt5:*):void 
{

	//trace("SimpleChoices");
	choices(text1,butt1,
			text2,butt2,
			text3,butt3,
			text4,butt4,
			text5,butt5,
			"",0,
			"",0,
			"",0,
			"",0,
			"",0);
}

public function doYesNo(eventYes:*, eventNo:*):void {
	//Make buttons 1-2 visible and hide the rest.

	//trace("doYesNo");
	choices("Yes",eventYes,
			"No",eventNo,
			"",0,
			"",0,
			"",0,
			"",0,
			"",0,
			"",0,
			"",0,
			"",0);

}



public function doNext(eventNo:*):void {
	//Prevent new events in combat from automatically overwriting a game over. 
	if(mainView.getButtonText( 0 ).indexOf("Game Over") != -1) {
		trace("Do next setup cancelled by game over");
		return;
	}
	
	//trace("DoNext have item:", eventNo);
	choices("Next", eventNo, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0); 
}

public function doNextClear(eventNo:*):void 
{
	outputText("", true, true);
	//trace("DoNext Clearing display");
	//trace("DoNext have item:", eventNo);
	choices("Next", eventNo, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0);
}

public function invertGo():void{ 
	mainView.invert();
}

//Used to update the display of statistics
public function statScreenRefresh():void {
	mainView.statsView.show(); // show() method refreshes.
}

public function showStats():void {
	mainView.statsView.show();
}

public function hideStats():void {
	mainView.statsView.hide();
}

public function hideMenus():void {
	mainView.hideAllMenuButtons();
}

//Hide the up/down indicators
public function hideUpDown():void {
	mainView.statsView.hideUpDown();

	//Clear storage values so up/down arrows can be properly displayed
	oldStats.oldStr = 0;
	oldStats.oldTou = 0;
	oldStats.oldSpe = 0;
	oldStats.oldInte = 0;
	oldStats.oldLib = 0;
	oldStats.oldSens = 0;
	oldStats.oldLust = 0;
	oldStats.oldCor = 0;        
}

public function physicalCost(mod:Number):Number {
	var costPercent:Number = 100;
	if(player.hasPerk("Iron Man") >= 0) costPercent -= 50;
	mod *= costPercent/100;
	return mod;
}

public function spellCost(mod:Number):Number {
	//Addiditive mods
	var costPercent:Number = 100;
	if(player.hasPerk("Spellcasting Affinity") >= 0) costPercent -= player.perkv1("Spellcasting Affinity");
	if(player.hasPerk("Wizard's Endurance") >= 0) costPercent -= player.perkv1("Wizard's Endurance");
	
	//Limiting it and multiplicative mods
	if(player.hasPerk("Blood Mage") >= 0 && costPercent < 50) costPercent = 50;
	
	mod *= costPercent/100;
	
	if(player.hasPerk("History: Scholar") >= 0) {
		if(mod > 2) mod *= .8;
	}
	if(player.hasPerk("Blood Mage") >= 0 && mod < 5) mod = 5;
	else if(mod < 2) mod = 2;
	
	mod = Math.round(mod * 100)/100;
	return mod;
}

//Modify fatigue
//types:
//        0 - normal
//        1 - magic
public function fatigue(mod:Number,type:Number  = 0):void {
	//Spell reductions
	if(type == 1) {
		mod = spellCost(mod);
		
		//Blood mages use HP for spells
		if(player.hasPerk("Blood Mage") >= 0) {
			takeDamage(mod);
			statScreenRefresh();
			return;
		}                
	}
	//Physical special reductions
	if(type == 2) {
		mod = physicalCost(mod);
	}
	if(player.fatigue >= 100 && mod > 0) return;
	if(player.fatigue <= 0 && mod < 0) return;
	//Fatigue restoration buffs!
	if(mod < 0) {
		if(player.hasPerk("History: Slacker") >= 0) mod *= 1.2;
	}
	player.fatigue += mod;
	if(mod > 0) {
		mainView.statsView.showStatUp( 'fatigue' );
		// fatigueUp.visible = true;
		// fatigueDown.visible = false;
	}
	if(mod < 0) {
		mainView.statsView.showStatDown( 'fatigue' );
		// fatigueDown.visible = true;
		// fatigueUp.visible = false;
	}
	if(player.fatigue > 100) player.fatigue = 100;
	if(player.fatigue < 0) player.fatigue = 0;
	statScreenRefresh();
}
//function changeFatigue
public function changeFatigue(changeF:Number):void {
	fatigue(changeF);
}
public function minLust():Number {
	return player.minLust();
}

public function displayStats(e:MouseEvent = null):void
{
	spriteSelect(-1);
	outputText("", true);
	outputText("<b><u>Combat Stats</u></b>\n", false);
	if(player.hasKeyItem("Bow") >= 0) outputText("<b>Bow Skill: </b>" + Math.round(player.statusAffectv1("Kelt")) + "\n", false);
	outputText("<b>Lust Resistance: </b>" + (100-Math.round(lustPercent())) + "% (Higher is better.)\n", false);
	outputText("<b>Spell Effect Multiplier: </b>" + (100 * spellMod()) + "%\n");
	outputText("<b>Spell Cost: </b>" + spellCost(100) + "%\n");
	outputText("<b>Tease Skill Level (Out of 5): </b> " + player.teaseLevel + "\n", false);
	
	outputText("\n<b><u>Hidden Stats</u></b>\n", false);
	outputText("<b>Anal Capacity: </b>" + Math.round(player.analCapacity()) + "\n");
	outputText("<b>Anal Looseness: </b>" + Math.round(player.ass.analLooseness) + "\n");
	
	outputText("<b>Fertility (Base) Rating: </b>" + Math.round(player.fertility) + "\n", false);
	outputText("<b>Fertility (With Bonuses) Rating: </b>" + Math.round(player.totalFertility()) + "\n", false);
	if(player.hasStatusAffect("Feeder") >= 0) {
		outputText("<b>Hours Since Last Time Breastfed Someone: </b> " + player.statusAffectv2("Feeder"), false);
		if(player.statusAffectv2("Feeder") >= 72) outputText(" (Too long! Sensitivity Increasing!)", false);
		outputText("\n", false);
	}
	
	outputText("<b>Cum Production:</b> " + Math.round(player.cumQ()) + "mL\n", false);
	outputText("<b>Milk Production:</b> " + Math.round(player.lactationQ()) + "mL\n", false);
	//MARBLE
	if(player.statusAffectv3("Marble") > 0) {
		outputText("<b>Marble Milk Addiction: </b>", false);
		if(player.hasPerk("Marble Resistant") < 0 && player.hasPerk("Marble's Milk") < 0) outputText(Math.round(player.statusAffectv2("Marble")) + "%\n", false);
		else if(player.hasPerk("Marble Resistant") >= 0) outputText("0%\n", false);
		else outputText("100%\n", false);
	}
	//MINO!
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00340] > 0 || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 0 || player.hasPerk("Minotaur Cum Addict") >= 0) {
		if(player.hasPerk("Minotaur Cum Addict") < 0) outputText("<b>Minotaur Cum Addiction:</b> " + Math.round(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] * 10)/10 + "%\n", false);
		else outputText("<b>Minotaur Cum Addiction:</b> 100+%\n", false);
	}
	if(player.hasPerk("Spider Ovipositor") >= 0 || player.hasPerk("Bee Ovipositor") >= 0) outputText("<b>Ovipositor Total Egg Count: " + player.eggs() + "\nOvipositor Fertilized Egg Count: " + player.fertilizedEggs() + "</b>\n");
	outputText("<b>Pregnancy Speed Multiplier:</b> ", false);
	var preg:Number = 1;
	if(player.hasPerk("Diapause") >= 0) outputText("? (Variable due to Diapause)\n", false);
	else {
		if(player.hasPerk("Marae's Gift - Fertility") >= 0) preg++;
		if(player.hasPerk("Brood Mother") >= 0) preg++;
		if(player.hasPerk("Fera's Boon - Breeding Bitch") >= 0) preg++;
		if(player.hasPerk("Magical Fertility") >= 0) preg++;
		if(player.hasPerk("Fera's Boon - Wide Open") >= 0 || player.hasPerk("Fera's Boon - Milking Twat") >= 0) preg++;
		outputText(preg + "\n", false);
	}        
	if(player.hasStatusAffect("Slime Craving") >= 0) {
		if(player.statusAffectv1("Slime Craving") >= 18) outputText("<b>Slime Craving:  </b>Active! You are currently losing strength and speed.  You should find fluids.\n", false);
		else {
			if(player.hasPerk("Slime Core") >= 0) outputText("<b>Slime Stored:  </b>" + ((17 - player.statusAffectv1("Slime Craving")) * 2) + " hours until you start losing strength.\n", false);
			else outputText("<b>Slime Stored:  </b>" + (17 - player.statusAffectv1("Slime Craving")) + " hours until you start losing strength.\n", false);
		}
	}
	outputText("<b>Spells Cast: </b>" + flags[kFLAGS.SPELLS_CAST] + "\n");
	if(player.hasVagina()) outputText("<b>Vaginal Capacity: </b>" + Math.round(player.vaginalCapacity()) + "\n");
	if(player.hasVagina()) outputText("<b>Vaginal Looseness: </b>" + Math.round(player.looseness()) + "\n");
	
	outputText("<b><u>\nInterpersonal Stats</u></b>\n", false);
	if(flags[kFLAGS.ARIAN_PARK] > 0) outputText("<b>Arian's Health: </b>" + Math.round(arianScene.arianHealth()) + "\n");
	if(flags[kFLAGS.ARIAN_VIRGIN] > 0) outputText("<b>Arian Sex Counter: </b>" + Math.round(flags[kFLAGS.ARIAN_VIRGIN]) + "\n");
	if(bazaar.benoit.benoitAffection() > 0) outputText("<b>" + bazaar.benoit.benoitMF("Benoit","Benoite") + " Affection: </b>" + Math.round(bazaar.benoit.benoitAffection()) + "%\n");
	if(flags[kFLAGS.BENOIT_EGGS] > 0) outputText("<b>Benoit Eggs Laid: </b>" + flags[kFLAGS.BENOIT_EGGS] + "\n");
	if(flags[kFLAGS.BROOKE_MET] > 0) outputText("<b>Brooke Affection: </b>" + Math.round(telAdre.brooke.brookeAffection()) + "\n");
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00218]+flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00219]+flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00220] > 0) outputText("<b>Body Parts Taken By Ceraph: </b>" + (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00218]+flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00219]+flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00220]) + "\n", false);
	if(flags[kFLAGS.COTTON_KID_COUNT] > 0) outputText("<b>Children With Cotton: </b>" + flags[kFLAGS.COTTON_KID_COUNT] + "\n");
	if(flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] > 0) outputText("<b>Children With Edryn: </b>" + flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] + "\n", false);
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00251]+flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00252] > 0) outputText("<b>Children With Izma: </b>" + (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00251]+flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00252]) + "\n", false);
	if(flags[kFLAGS.MARBLE_KIDS] > 0) outputText("<b>Children With Marble:</b> " + flags[kFLAGS.MARBLE_KIDS] + "\n", false);
	if(flags[kFLAGS.ANT_KIDS] > 0) outputText("<b>Ant Children With Phylla:</b> " + flags[kFLAGS.ANT_KIDS] + "\n");
	if(flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] > 0) outputText("<b>Drider Children With Phylla:</b> " + flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] + "\n");
	if(flags[kFLAGS.SHEILA_JOEYS] > 0) outputText("<b>Children With Sheila (Joeys):</b> " + flags[kFLAGS.SHEILA_JOEYS] + "\n");
	if(flags[kFLAGS.SHEILA_IMPS] > 0) outputText("<b>Children With Sheila (Imps):</b> " + flags[kFLAGS.SHEILA_IMPS] + "\n");
	
	if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] > 0 || flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) 
	{        
		outputText("<b>Children With Sophie:</b> ");
		var sophie:int = 0;
		if(flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) sophie++;
		sophie += flags[kFLAGS.SOPHIE_ADULT_KID_COUNT];
		if(flags[kFLAGS.SOPHIE_CAMP_EGG_COUNTDOWN] > 0) sophie++;
		outputText(sophie + "\n");
	}
	if(player.statusAffectv2("Tamani") > 0) outputText("<b>Children With Tamani: </b>" + player.statusAffectv2("Tamani") + " (after all forms of natural selection)\n", false);
	if(urtaPregs.urtaKids() > 0) outputText("<b>Children With Urta: </b>" + urtaPregs.urtaKids() + "\n");
	if(flags[kFLAGS.SOPHIE_EGGS_LAID] > 0) outputText("<b>Eggs Fertilized For Sophie: </b>" + (flags[kFLAGS.SOPHIE_EGGS_LAID] + sophie) + "\n", false);
	if(emberScene.emberAffection() > 0) outputText("<b>Ember Affection:</b> " + Math.round(emberScene.emberAffection()) + "%\n");
	if(emberScene.emberChildren() > 0) {
		outputText("<b>Ember Offspring (Males): </b>" + flags[kFLAGS.EMBER_CHILDREN_MALES] + "\n");
		outputText("<b>Ember Offspring (Females): </b>" + flags[kFLAGS.EMBER_CHILDREN_FEMALES] + "\n");
		outputText("<b>Ember Offspring (Herms): </b>" + flags[kFLAGS.EMBER_CHILDREN_HERMS] + "\n");
	}
	if(flags[kFLAGS.EMBER_EGGS] > 0) outputText("<b>Ember Eggs Produced:</b> " + flags[kFLAGS.EMBER_EGGS] + "\n");
	if(helFollower.helAffection() > 0) outputText("<b>Helia Affection: </b>" + Math.round(helFollower.helAffection()) + "%\n");
	if(helFollower.helAffection() >= 100) outputText("<b>Helia Bonus Points: </b>" + Math.round(flags[kFLAGS.HEL_BONUS_POINTS]) + "\n");
	if(flags[kFLAGS.ISABELLA_AFFECTION] > 0) {
		outputText("<b>Isabella Affection:</b> ", false);
		if(!isabellaFollowerScene.isabellaFollower()) outputText(Math.round(flags[kFLAGS.ISABELLA_AFFECTION]) + "%\n", false);
		else outputText("100%\n", false);
	}
	if(flags[kFLAGS.ANEMONE_KID] > 0) {
		outputText("<b>Kid A's Confidence:</b> " + anemoneScene.kidAXP() + "%\n");
	}
	if(flags[kFLAGS.KIHA_AFFECTION_LEVEL] == 2) {
		if(kihaFollower.followerKiha()) outputText("<b>Kiha Affection:</b> " + 100 + "%\n", false);
		else outputText("<b>Kiha Affection:</b> " + Math.round(flags[kFLAGS.KIHA_AFFECTION]) + "%\n", false);
	}
	if(flags[kFLAGS.AMILY_MET] > 0) outputText("<b>Litters With Amily: </b>" + (flags[kFLAGS.AMILY_BIRTH_TOTAL]+ flags[kFLAGS.PC_TIMES_BIRTHED_AMILYKIDS]) + "\n", false);
	//Lottie stuff
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00281] > 0) {
		outputText("<b>Lottie's Encouragement: </b>" + telAdre.lottie.lottieMorale() + " (higher is better)\n", false);
		outputText("<b>Lottie's Figure: </b>" + telAdre.lottie.lottieTone() + " (higher is better)\n", false);
	}
	if(mountain.salon.lynnetteApproval() != 0) {
		outputText("<b>Lynnette's Approval: </b>" + mountain.salon.lynnetteApproval() + "\n");
		outputText("<b>Lynnette Children: </b>" + flags[kFLAGS.LYNNETTE_BABY_COUNT] + "\n");
	}
	//Mino sons
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] > 0) {
		outputText("<b>Number of Adult Minotaur Offspring: </b>" + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] + "\n", false);
	}
	if(flags[kFLAGS.OWCAS_ATTITUDE] > 0) outputText("<b>Owca's Attitude: </b>" + flags[kFLAGS.OWCAS_ATTITUDE] + "\n");
	if(flags[kFLAGS.SHEILA_XP] != 0) {
		outputText("<b>Sheila's Corruption: </b>" + sheilaScene.sheilaCorruption());
		if(sheilaScene.sheilaCorruption() > 100) outputText(" (Yes, it can go above 100)");
		outputText("\n");
	}
	if(player.hasStatusAffect("Kelt") >= 0 && flags[kFLAGS.KELT_BREAK_LEVEL] == 0) {
		if(player.statusAffectv2("Kelt") >= 130) outputText("<b>Submissiveness To Kelt:</b> " + 100 + "%\n", false);
		else outputText("<b>Submissiveness To Kelt:</b> " + Math.round(player.statusAffectv2("Kelt")/130*100) + "%\n", false);
	}
	if(telAdre.rubi.rubiAffection() > 0) outputText("<b>Rubi's Affection:</b> " + Math.round(telAdre.rubi.rubiAffection()) + "%\n");
	if(telAdre.rubi.rubiAffection() > 0) outputText("<b>Rubi's Orifice Capacity:</b> " + Math.round(telAdre.rubi.rubiCapacity()) + "%\n");
	
	if(flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] != 0) {
		if(urta.urtaLove()) outputText("<b>Urta Status: </b>Lover\n");
		else if(flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] == -1) outputText("<b>Urta Status: </b>Ashamed\n");
		else if(flags[kFLAGS.URTA_PC_AFFECTION_COUNTER] < 30) outputText("<b>Urta Status: </b>" + Math.round(flags[kFLAGS.URTA_PC_AFFECTION_COUNTER] * 3.3333) + "% Affection\n");
		else outputText("<b>Urta Status: </b>Ready To Confess Love\n");
	}
	
	outputText("\n<b><u>Ongoing Status Effects</u></b>\n", false);
	if(player.hasStatusAffect("heat") >= 0) outputText("Heat - " + Math.round(player.statusAffectv3("heat")) + " hours remaining.\n", false);
	if(player.hasStatusAffect("rut") >= 0) outputText("Rut - " + Math.round(player.statusAffectv3("rut")) + " hours remaining.\n", false);
	if(player.statusAffectv1("Luststick") > 0) outputText("Luststick - " + Math.round(player.statusAffectv1("Luststick")) + " hours remaining.\n", false);
	if(player.statusAffectv1("Black Cat Beer") > 0) outputText("Black Cat Beer - " + player.statusAffectv1("Black Cat Beer") + " hours remaining.  Lust resistance 20% lower, physical resistance 25% higher.\n");
	outputText("\n<b><u>Miscellaneous Stats</u></b>\n");
	outputText("<b>Eggs Traded For: </b>" + flags[kFLAGS.EGGS_BOUGHT] + "\n");
	doNext(1);
}

public function lustPercent():Number {
	var lust:Number = 100;
	//2.5% lust resistance per level - max 75.
	if(player.level < 21) lust -= (player.level - 1) * 3;
	else lust = 40;
	
	//++++++++++++++++++++++++++++++++++++++++++++++++++
	//ADDITIVE REDUCTIONS
	//THESE ARE FLAT BONUSES WITH LITTLE TO NO DOWNSIDE
	//TOTAL IS LIMITED TO 75%!
	//++++++++++++++++++++++++++++++++++++++++++++++++++
	//Corrupted Libido reduces lust gain by 10%!
	if(player.hasPerk("Corrupted Libido") >= 0) lust -= 10;
	//Acclimation reduces by 15%
	if(player.hasPerk("Acclimation") >= 0) lust -= 15;
	//Purity blessing reduces lust gain
	if(player.hasPerk("Purity Blessing") >= 0) lust -= 5;
	//Resistance = 10%
	if(player.hasPerk("Resistance") >= 0) lust -= 10;
	if (player.hasPerk(UmasShop.NEEDLEWORK_LUST_PERK_NAME) >= 0) lust -= UmasShop.NEEDLEWORK_LUST_LUST_RESIST;
	
	if(lust < 25) lust = 25;
	if(player.statusAffectv1("Black Cat Beer") > 0) {
		if(lust >= 80) lust = 100;
		else lust += 20;
	}
	lust += Math.round(player.perkv1("Pent Up")/2);
	//++++++++++++++++++++++++++++++++++++++++++++++++++
	//MULTIPLICATIVE REDUCTIONS
	//THESE PERKS ALSO RAISE MINIMUM LUST OR HAVE OTHER
	//DRAWBACKS TO JUSTIFY IT.
	//++++++++++++++++++++++++++++++++++++++++++++++++++
	//Bimbo body slows lust gains!
	if((player.hasStatusAffect("Bimbo Champagne") >= 0 || player.hasPerk("Bimbo Body") >= 0) && lust > 0) lust *= .75;
	if(player.hasPerk("Bro Body") >= 0 && lust > 0) lust *= .75;
	if(player.hasPerk("Futa Form") >= 0 && lust > 0) lust *= .75;
	//Omnibus' Gift reduces lust gain by 15%
	if(player.hasPerk("Omnibus' Gift") >= 0) lust *= .85;
	//Luststick reduces lust gain by 10% to match increased min lust
	if(player.hasPerk("Luststick Adapted") >= 0) lust *= 0.9;
	if(player.hasStatusAffect("Berzerking") >= 0) lust *= .6;
	if (player.hasPerk("Pure and Loving") >= 0) lust *= 0.95;
	
	// Lust mods from Uma's content -- Given the short duration and the gem cost, I think them being multiplicative is justified.
	// Changing them to an additive bonus should be pretty simple (check the static values in UmasShop.as)
	var statIndex:int = player.hasStatusAffect(UmasShop.MASSAGE_BONUS_NAME);
	if (statIndex >= 0)
	{
		if (player.statusAffects[statIndex].value1 == UmasShop.MASSAGE_RELIEF || player.statusAffects[statIndex].value1 == UmasShop.MASSAGE_LUST)
		{
			lust *= player.statusAffects[statIndex].value2;
		}
	}
	
	lust = Math.round(lust);
	return lust;
}

// returns OLD OP VAL
public function applyOperator(old:Number, op:String, val:Number):Number {
	switch(op) {
		case "=":
			return val;
		case "+":
			return old + val;
		case "-":
			return old - val;
		case "*":
			return old * val;
		case "/":
			return old / val;
		default:
			trace("applyOperator(" + old + ",'" + op + "'," + val + ") unknown op");
			return old;
	}
}

public function testDynStatsEvent():void {
	outputText("Old: "+player.str+" "+player.tou+" "+player.spe+" "+player.inte+" "+player.lib+" "+player.sens+" "+player.lust+"\n",true);
	dynStats("tou", 1, "spe+", 2, "int-", 3, "lib*", 2, "sen=", 25,"lust/",2);
	outputText("Mod: 0 1 +2 -3 *2 =25 /2\n");
	outputText("New: "+player.str+" "+player.tou+" "+player.spe+" "+player.inte+" "+player.lib+" "+player.sens+" "+player.lust+"\n");
	doNext(1);
}

//Modify stats
public function dynStats(... args):void
{
	// Check num of args, we should have a multiple of 2
	if ((args.length % 2) != 0)
	{
		trace("dynStats aborted. Keys->Arguments could not be matched");
		return;
	}
	
	var argNamesFull:Array 	= 	["strength", "toughness", "speed", "intellect", "libido", "sensitivity", "lust", "corruption", "resisted", "noBimbo"]; // In case somebody uses full arg names etc
	var argNamesShort:Array = 	["str", 	"tou", 	"spe", 	"int", 	"lib", 	"sen", 	"lus", 	"cor", 	"res", 	"bim"]; // Arg names
	var argVals:Array = 		[0, 		0,	 	0, 		0, 		0, 		0, 		0, 		0, 		true, 	false]; // Default arg values
	var argOps:Array = 			["+",	"+",    "+",    "+",    "+",    "+",    "+",    "+",    "=",    "="];   // Default operators
	
	for (var i:int = 0; i < args.length; i += 2)
	{
		if (typeof(args[i]) == "string")
		{
			// Make sure the next arg has the POSSIBILITY of being correct
			if ((typeof(args[i + 1]) != "number") && (typeof(args[i + 1]) != "boolean"))
			{
				trace("dynStats aborted. Next argument after argName is invalid! arg is type " + typeof(args[i + 1]));
				continue;
			}
			
			var argIndex:int = -1;
			
			// Figure out which array to search
			var argsi:String = (args[i] as String);
			if (argsi == "lust") argsi = "lus";
			if (argsi == "sens") argsi = "sen";
			if (argsi.length <= 4) // Short
			{
				argIndex = argNamesShort.indexOf(argsi.slice(0, 3));
				if (argsi.length == 4 && argIndex != -1) argOps[argIndex] = argsi.charAt(3);
			}
			else // Full
			{
				if ("+-*/=".indexOf(argsi.charAt(argsi.length - 1)) != -1) {
					argIndex = argNamesFull.indexOf(argsi.slice(0, argsi.length - 1));
					if (argIndex != -1) argOps[argIndex] = argsi.charAt(argsi.length - 1);
				} else {
					argIndex = argNamesFull.indexOf(argsi);
				}
			}
			
			if (argIndex == -1) // Shit fucked up, welp
			{
				trace("Couldn't find the arg name " + argsi + " in the index arrays. Welp!");
				continue;
			}
			else // Stuff the value into our "values" array
			{
				argVals[argIndex] = args[i + 1];
			}
		}
		else
		{
			trace("dynStats aborted. Expected a key and got SHIT");
			return;
		}
	}
	// Got this far, we have values to statsify
	var newStr:Number = applyOperator(player.str, argOps[0], argVals[0]);
	var newTou:Number = applyOperator(player.tou, argOps[1], argVals[1]);
	var newSpe:Number = applyOperator(player.spe, argOps[2], argVals[2]);
	var newInte:Number = applyOperator(player.inte, argOps[3], argVals[3]);
	var newLib:Number = applyOperator(player.lib, argOps[4], argVals[4]);
	var newSens:Number = applyOperator(player.sens, argOps[5], argVals[5]);
	var newLust:Number = applyOperator(player.lust, argOps[6], argVals[6]);
	var newCor:Number = applyOperator(player.cor, argOps[7], argVals[7]);
	// Because lots of checks and mods are made in the stats(), calculate deltas and pass them. However, this means that the '=' operator could be resisted
	// In future (as I believe) stats() should be replaced with dynStats(), and checks and mods should be made here
	stats(newStr - player.str,
		  newTou - player.tou,
		  newSpe - player.spe,
		  newInte - player.inte,
		  newLib - player.lib,
		  newSens - player.sens,
		  newLust - player.lust,
		  newCor - player.cor,
		  argVals[8],argVals[9]);
	
}

public function stats(stre:Number, toug:Number, spee:Number, intel:Number, libi:Number, sens:Number, lust2:Number, corr:Number, resisted:Boolean = true, noBimbo:Boolean = false):void
{
	//Easy mode cuts lust gains!
	if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1 && lust2 > 0 && resisted) lust2 /= 2;
	
	//Set original values to begin tracking for up/down values if
	//they aren't set yet.
	//These are reset when up/down arrows are hidden with 
	//hideUpDown();
	//Just check str because they are either all 0 or real values
	if(oldStats.oldStr == 0) {
		oldStats.oldStr = player.str;
		oldStats.oldTou = player.tou;
		oldStats.oldSpe = player.spe;
		oldStats.oldInte = player.inte;
		oldStats.oldLib = player.lib;
		oldStats.oldSens = player.sens;
		oldStats.oldLust = player.lust;
		oldStats.oldCor = player.cor;
	}
	//MOD CHANGES FOR PERKS
	//Bimbos learn slower
	if(!noBimbo)
	{
		if(player.hasPerk("Futa Faculties") >= 0 || player.hasPerk("Bimbo Brains") >= 0  || player.hasPerk("Bro Brains") >= 0) {
			if(intel > 0) intel /= 2;
			if(intel < 0) intel *= 2;
		}
		if(player.hasPerk("Futa Form") >= 0 || player.hasPerk("Bimbo Body") >= 0  || player.hasPerk("Bro Body") >= 0) {
			if(libi > 0) libi *= 2;
			if(libi < 0) libi /= 2;
		}
	}
	
	// Uma's Perkshit
	if (player.hasPerk(UmasShop.NEEDLEWORK_SPEED_PERK_NAME)>=0 && spee < 0) spee *= UmasShop.NEEDLEWORK_SPEED_SPEED_MULTI;
	if (player.hasPerk(UmasShop.NEEDLEWORK_LUST_PERK_NAME)>=0 && libi > 0) libi *= UmasShop.NEEDLEWORK_LUST_LIBSENSE_MULTI;
	if (player.hasPerk(UmasShop.NEEDLEWORK_LUST_PERK_NAME)>=0 && sens > 0) sens *= UmasShop.NEEDLEWORK_LUST_LIBSENSE_MULTI;
	
	//If orgasm, set hours since cum to 0.
	if(lust2 < 0) player.resetDickEjaculateTimer();
	//lust resistance
	if(lust2 > 0 && resisted) lust2 *= lustPercent()/100;
	if(libi > 0 && player.hasPerk("Purity Blessing") >= 0) libi *= 0.75;
	if(corr > 0 && player.hasPerk("Purity Blessing") >= 0) corr *= 0.5;
	if(corr > 0 && player.hasPerk("Pure and Loving") >= 0) corr *= 0.75;
	//Change original stats
	player.str+=stre;
	player.tou+=toug;
	player.spe+=spee;
	player.inte+=intel;
	player.lib+=libi;
	if(player.sens > 50 && sens > 0) sens/=2;
	if(player.sens > 75 && sens > 0) sens/=2;
	if(player.sens > 90 && sens > 0) sens/=2;
	if(player.sens > 50 && sens < 0) sens*=2;
	if(player.sens > 75 && sens < 0) sens*=2;
	if(player.sens > 90 && sens < 0) sens*=2;
	player.sens+=sens;
	player.lust+=lust2;
	player.cor+=corr;
	//Bonus gain for perks!
	if(player.hasPerk("Strong") >= 0 && stre >= 0) player.str+=stre*player.perks[player.hasPerk("Strong")].value1;
	if(player.hasPerk("Tough") >= 0 && toug >= 0) player.tou+=toug*player.perks[player.hasPerk("Tough")].value1;
	if(player.hasPerk("Fast") >= 0 && spee >= 0) player.spe+=spee*player.perks[player.hasPerk("Fast")].value1;
	if(player.hasPerk("Smart") >= 0 && intel >= 0) player.inte+=intel*player.perks[player.hasPerk("Smart")].value1;
	if(player.hasPerk("Lusty") >= 0 && libi >= 0) player.lib+=libi*player.perks[player.hasPerk("Lusty")].value1;
	if (player.hasPerk("Sensitive") >= 0 && sens >= 0) player.sens += sens * player.perks[player.hasPerk("Sensitive")].value1;

	// Uma's Str Cap from Perks
	if (player.hasPerk(UmasShop.NEEDLEWORK_SPEED_PERK_NAME) >= 0)
	{
		if (player.str > UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP)
		{
			player.str = UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP;
		}
	}
	if (player.hasPerk(UmasShop.NEEDLEWORK_DEFENSE_PERK_NAME) >= 0)
	{
		if (player.spe > UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP)
		{
			player.spe = UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP;
		}
	}
	
	//Keep stats in bounds
	if(player.cor < 0) player.cor = 0;
	if(player.cor > 100) player.cor= 100;
	if(player.str > 100) player.str = 100;
	if(player.str < 1) player.str = 1;
	if(player.tou > 100) player.tou = 100;
	if(player.tou < 1) player.tou = 1;
	if(player.spe > 100) player.spe = 100;
	if(player.spe < 1) player.spe = 1;
	if(player.inte > 100) player.inte= 100;
	if(player.inte < 1) player.inte = 1;
	if(player.lib > 100) player.lib = 100;
	//Minimum libido = 15.
	if(player.lib < 50 && player.armorName == "lusty maiden's armor") player.lib = 50;
	else if(player.lib < 15 && player.gender > 0) player.lib = 15;
	else if(player.lib < 10 && player.gender == 0) player.lib = 10;
	if (player.lib < minLust() * 2 / 3) player.lib = minLust() * 2 / 3;
	
	//Minimum sensitivity.
	if(player.sens > 100) player.sens = 100;
	if(player.sens < 10) player.sens = 10;
	
	//Add HP for toughness change.
	HPChange(toug*2, false);
	//Reduce hp if over max
	if(player.HP > maxHP()) player.HP = maxHP();
	
	//Combat bounds
	if(player.lust > 99) player.lust = 100;
	//if(player.lust < player.lib) {
	//        player.lust=player.lib;
	//
	//Update to minimum lust if lust falls below it.
	if(player.lust < minLust()) player.lust = minLust();
	//worms raise min lust!
	if(player.hasStatusAffect("infested") >= 0) {
		if(player.lust < 50) player.lust = 50;
	}
	if(player.lust > 100) player.lust = 100;
	if(player.lust < 0) player.lust = 0;

	//Refresh the stat pane with updated values
	mainView.statsView.showUpDown();
	statScreenRefresh();
}
public function range(min:Number, max:Number, round:Boolean = false):Number 
{
	var num:Number = (min + Math.random() * (max - min));

	if (round) return Math.round(num);
	return num;
}

public function cuntChangeOld(cIndex:Number, vIndex:Number, display:Boolean):void {
	//Virginity check
	if(player.vaginas[vIndex].virgin) {
		if(display) outputText("\nYour " + vaginaDescript(vIndex) + " loses it's virginity!", false);
		player.vaginas[vIndex].virgin = false;
	}        
	//If cock is bigger than unmodified vagina can hold - 100% stretch!
	if(player.vaginas[vIndex].capacity() <= monster.cocks[cIndex].cArea()) {
		if(player.vaginas[vIndex] < 5) {
			trace("CUNT STRETCHED: By cock larger than it's total capacity.");
			if(display) {
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_GAPING_WIDE) outputText("<b>Your " + vaginaDescript(0) + " is stretched even further, capable of taking even the largest of demons and beasts.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_GAPING) outputText("<b>Your " + vaginaDescript(0) + " painfully stretches, gaping wide-open.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_LOOSE) outputText("<b>Your " + vaginaDescript(0) + " is now very loose.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_NORMAL) outputText("<b>Your " + vaginaDescript(0) + " is now loose.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_TIGHT) outputText("<b>Your " + vaginaDescript(0) + " looses its virgin-like tightness.</b>  ", false);
			}
			player.vaginas[vIndex].vaginalLooseness++;
		}
	}
	//If cock is within 75% of max, streeeeetch 33% of the time
	if(player.vaginas[vIndex].capacity() * .75 <= monster.cocks[cIndex].cArea()) {
		if(player.vaginas[vIndex] < 5) {
			trace("CUNT STRETCHED: By cock @ 75% of capacity.");
			if(display) {
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_GAPING_WIDE) outputText("<b>Your " + vaginaDescript(0) + " is stretched even further, capable of taking even the largest of demons and beasts.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_GAPING) outputText("<b>Your " + vaginaDescript(0) + " painfully stretches, gaping wide-open.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_LOOSE) outputText("<b>Your " + vaginaDescript(0) + " is now very loose.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_NORMAL) outputText("<b>Your " + vaginaDescript(0) + " is now loose.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_TIGHT) outputText("<b>Your " + vaginaDescript(0) + " looses its virgin-like tightness.</b>  ", false);
			}
			player.vaginas[vIndex].vaginalLooseness++;
		}
	}
}

public function spriteSelect(choice:Number = 0):void {
	if (flags[kFLAGS.SHOW_SPRITES_FLAG] == 0)
	{
		mainView.selectSprite( choice );
	}
	else
	{
		if (choice >= 0)
		{
			trace ("hiding sprite because flags");
			mainView.selectSprite( -1 );
		}
	}
}