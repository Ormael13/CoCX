

// Perk management functions.
// Used to be a part of doEvent.as

// EventNumbers that correspond to per-add calls.
// Used to determine if pickPerks need to be called on event {n}
// if (perkEventNums.indexOf(eventNo) > 0)
public var perkEventNums:Array = [53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 72, 73, 75, 76, 77, 78, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110];

public function pickPerks(eventNo:*):void
{
	
	//Strong Back Chosen (25 Str perk)
	if(eventNo == 53) {
		if(player.hasPerk("Strong Back") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Strong Back",0,0,0,0,"Enables fourth item slot.");
		outputText("You choose the 'Strong Back' perk, enabling a fourth item slot.", true);
		player.itemSlot4.unlocked = true;
		doNext(1);
		return;
	}
	//Perk Strong Back 2 Chosen (50 Str Perk)
	if(eventNo == 54) {
		if(player.hasPerk("Strong Back 2: Strong Harder") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Strong Back 2: Strong Harder",0,0,0,0, "Enables fifth item slot.");
		outputText("You choose the 'Strong Back 2: Strong Harder' perk, enabling a fifth item slot.", true);
		player.itemSlot5.unlocked = true;
		doNext(1);
		return;
	}
	//Perk Tank Chosen
	if(eventNo == 55) {
		if(player.hasPerk("Tank") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Tank",0,0,0,0,"Raises max HP by 50.");
		outputText("You choose the 'Tank' perk, giving you an additional 50 hp!", true);
		doNext(1);
		dynStats("cor", 0);
		return;
	}
	//Perk Regeneration
	if(eventNo == 56) {
		if(player.hasPerk("Regeneration") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Regeneration",0,0,0,0,"Regenerates 2 HP/hour and 1 HP/round.");
		outputText("You choose the 'Regeneration' perk, allowing you to heal 2 HP every hour and 1 HP every round of combat!", true);
		doNext(1);
		return;
	}
	//Perk Evade CHosen
	if(eventNo == 57) {
		if(player.hasPerk("Evade") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Evade",0,0,0,0,"Increases avoidance chances.");
		outputText("You choose the 'Evade' perk, allowing you to avoid enemy attacks more often!", true);
		doNext(1);
		return;
	}
	//Perk Runner Chosen
	if(eventNo == 58) {
		if(player.hasPerk("Runner") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Runner",0,0,0,0,"Increases chances of escaping combat.");
		outputText("You choose the 'Runner' perk, allowing you to run away much faster!", true);
		doNext(1);
		return;
	}		
	//Fertility Perk Chosen
	if(eventNo == 59) {
		if(player.hasPerk("Fertility+") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Fertility+",15,1.75,0,0,"Increases pregnancy chance by 15% and cum volume by up to 50%.");
		outputText("You choose the 'Fertility+' perk, making it easier to get pregnant by 15% and increase your cum volume by up to 50%(if appropriate)!", true);
		doNext(1);
	}
	//Hot Blooded Perk Chosen
	if(eventNo == 60) {
		if(player.hasPerk("Hot Blooded") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Hot Blooded",20,0,0,0, "Raises minimum lust by up to 20.");
		outputText("You choose the 'Hot Blooded' perk.  As a result of your enhanced libido, your lust no longer drops below 20!", true);
		doNext(1);
		return;
	}
	//Corrupted Libido Perk Chosen
	if(eventNo == 61) {
		if(player.hasPerk("Corrupted Libido") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Corrupted Libido",20,0,0,0, "Reduces lust gain by 10%.");
		outputText("You choose the 'Corrupted Libido' perk.  As a result of your body's corruption, you've become a bit harder to turn on. (Lust gain reduced by 10%!)", true);
		doNext(1);
		return;
	}
	//Seduction perk Chosen
	if(eventNo == 62) {
		if(player.hasPerk("Seduction") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Seduction",0,0,0,0,"Upgrades your tease attack, making it more effective.");
		outputText("You choose the 'Seduction' perk, replacing the 'tease' attack with a more powerful 'seduction' variant.", true);
		doNext(1);
		return;
	}

	//Precision perk Chosen
	if(eventNo == 72) {
		if(player.hasPerk("Precision") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Precision",0,0,0,0,"Reduces enemy damage resistance by 10.");
		outputText("You've chosen the 'Precision' perk.  Thanks to your intelligence, you're now more adept at finding and striking an enemy's weak points, reducing their damage resistance by 10.  If your intelligence ever drops below 25 you'll no longer be smart enough to benefit from this perk.", true);
		doNext(1);
		return;
	}
	//Nymphomania Chosen
	if(eventNo == 73) {
		if(player.hasPerk("Nymphomania") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Nymphomania",0,0,0,0,"Raises minimum lust by up to 30.");
		outputText("You've chosen the 'Nymphomania' perk.  Due to the incredible amount of corruption you've been exposed to, you've begun to live in a state of minor constant arousal.  Your lust will never drop below 30.", true);
		doNext(1);
		return;
	}
	//Spellpower Chosen
	if(eventNo == 75) {
		if(player.hasPerk("Spellpower") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Spellpower",0,0,0,0,"Increases the effects of your spells by up to 50%.");
		outputText("You've chosen the 'Spellpower' perk.  Thanks to your sizeable intellect and willpower, you are able to more effectively use magic.", true);
		doNext(1);
		return;
	}
	//Mage Chosen
	if(eventNo == 76) {
		if(player.hasPerk("Mage") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Mage",0,0,0,0,"Increases the strength of your spells even more than 'Spellpower', up to 100%.");
		outputText("Thanks in part to your incredible willpower and intellect, you are able to focus your magical abilities even more keenly, boosting your spells effects by up to 100%.", true);
		doNext(1);
		return;
	}
	if(eventNo == 77) {
		if(player.hasPerk("Double Attack") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Double Attack",0,0,0,0,"Allows you to perform two melee attacks per round.");
		outputText("Thanks to your incredible speed, you can land two regular attacks in one round!", true);
		doNext(1);
		return;
	}
	if(eventNo == 78) {
		if(player.hasPerk("Acclimation") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Acclimation",0,0,0,0,"Reduces the rate at which your lust increases.");
		outputText("Your body is now more acclimated to its heightened lusts!", true);
		doNext(1);
	}

	//Perk: Thunderous Strikes
	if(eventNo == 98) {
		if(player.hasPerk("Thunderous Strikes") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Thunderous Strikes",0,0,0,0,"+20% 'Attack' damage while strength is at or above 80.");
		outputText("You choose the 'Thunderous Strikes' perk, increasing normal damage by 20% while your strength is over 80.", true);
		doNext(1);
		return;
	}
	//Perk: "Weapon Mastery"
	if(eventNo == 99) {
		if(player.hasPerk("Weapon Mastery") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Weapon Mastery",0,0,0,0,"After getting so good at carrying large objects, you find large weapons much easier to handle (Double 'Large' weapon bonuses when equipped).");
		outputText("You choose the 'Weapon Mastery' perk, doubling the effectiveness of large weapons.", true);
		doNext(1);
		return;
	}
	//Perk: Tank 2
	if(eventNo == 100) {
		if(player.hasPerk("Tank 2") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Tank 2",0,0,0,0,"Your maximum HP is raised by an extra 1 point per point of toughness!");
		outputText("You choose the 'Tank 2' perk, granting an extra maximum HP for each point of toughness.", true);
		statScreenRefresh();
		HPChange(player.tou, false);
		doNext(1);
		return;
	}
	//Perk: Regeneration 2
	if(eventNo == 101) {
		if(player.hasPerk("Regeneration 2") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Regeneration 2",0,0,0,0,"You regenerate an additional 3HP per round and heal faster out of combat");
		outputText("You choose the 'Regeneration 2' perk, quadrupling the effectiveness of your regeneration abilities.", true);
		doNext(1);
		return;
	}
	//Speedy Recovery
	if(eventNo == 102) {
		if(player.hasPerk("Speedy Recovery") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Speedy Recovery",0,0,0,0,"Thanks to your impressive metabolism you regain fatigue 50% faster.");
		outputText("You choose the 'Speedy Recovery' perk, boosting your fatigue recovery rate!", true);
		doNext(1);
		return;
	}
	//Perk: Agility
	if(eventNo == 103) {
		if(player.hasPerk("Agility") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Agility",0,0,0,0,"When wearing light or medium armor its effectiveness is increased by a portion of your speed.");
		outputText("You choose the 'Agility' perk, increasing the effectiveness of Light/Medium armors by a portion of your speed.", true);
		doNext(1);
		return;
	}
	//Channeling
	if(eventNo == 104) {
		if(player.hasPerk("Channeling") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Channeling",0,0,0,0,"You've gotten even better at spellcasting, gaining up to 50% more effectiveness!");
		outputText("You choose the 'Channeling' perk, boosting the strength of your spellcasting!", true);
		doNext(1);
		return;
	}
	//Medicine
	if(eventNo == 105) {
		if(player.hasPerk("Medicine") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Medicine",0,0,0,0,"You now have a 15% chance per round of cleansing poisons/drugs from your body.");
		outputText("You choose the 'Medicine' perk, giving you a chance to remove debilitating poisons automatically!", true);
		doNext(1);
		return;
	}
	//Well Adjusted
	if(eventNo == 106) {
		if(player.hasPerk("Well Adjusted") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Well Adjusted",0,0,0,0,"You gain half as much lust as time passes in Mareth.");
		outputText("You choose the 'Well Adjusted' perk, reducing the amount of lust you naturally gain over time while in this strange land!", true);
		doNext(1);
		return;
	}
	//Masochism
	if(eventNo == 107) {
		if(player.hasPerk("Masochist") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Masochist",0,0,0,0,"You have a masochism fetish and take 30 percent less damage, but you're lust goes up when struck (Requires 60+ Libido).");
		outputText("You choose the 'Masochist' perk, reducing the damage you take but raising your lust each time!  This perk only functions while your libido is at or above 60!", true);
		doNext(1);
		return;
	}
	//Sadism
	if(eventNo == 108) {
		if(player.hasPerk("Sadist") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Sadist",0,0,0,0,"You have a sadism fetish and strike harder, but become aroused by the act of dealing damage.");
		outputText("You choose the 'Sadist' perk, increasing damage by 20 percent but causing you to gain lust from dealing damage.", true);
		doNext(1);
		return;
	}
	//Arousing Aura
	if(eventNo == 109) {
		if(player.hasPerk("Arousing Aura") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Arousing Aura",0,0,0,0,"While your corruption is at or above 70, you exude an aura of lust.");
		outputText("You choose the 'Arousing Aura' perk, causing you to radiate an aura of lust when your corruption is over 70.", true);
		doNext(1);
		return;
	}
	//Resistance
	if(eventNo == 110) {
		if(player.hasPerk("Resistance") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Resistance",0,0,0,0,"You've become resistant to the myriad ways your lust can be increased.");
		outputText("You choose the 'Resistance' perk, reducing the rate at which your lust increases by 10%.", true);
		doNext(1);
	}
}