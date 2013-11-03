
function inCombat():Boolean {
	if(gameState == 1 || gameState == 2) return true;
	return false;
}
function baseXP():Number {
	var xp:Number = 0;
	var lev:Number = Math.round(monster.level);
	switch(lev) {
		case 1:
			xp = 10;
			break;
		case 2:
			xp = 20;
			break;
		case 3:
			xp = 30;
			break;
		case 4:
			xp = 40;
			break;
		case 5:
			xp = 50;
			break;
		case 6:
			xp = 55;
			break;
		case 7:
			xp = 60;
			break;
		case 8:
			xp = 66;
			break;
		case 9:
			xp = 75;
			break;
		case 10:
			xp = 83;
			break;
		case 11:
			xp = 85;
			break;
		case 12:
			xp = 92;
			break;
		case 13:
			xp = 100;
			break;
		case 14:
			xp = 107;
			break;
		case 15:
			xp = 115;
			break;
		case 16:
			xp = 118;
			break;
		case 17:
			xp = 121;
			break;
		case 18:
			xp = 128;
			break;
		case 19:
			xp = 135;
			break;
		case 20:
			xp = 145;
			break;
		default:
			xp = 200;
			break;
	}
	return xp;
}
function bonusXP():Number {
	var xp:Number = 0;
	var lev:Number = Math.round(monster.level);
	switch(lev) {
		case 1:
			xp = 10;
			break;
		case 2:
			xp = 20;
			break;
		case 3:
			xp = 30;
			break;
		case 4:
			xp = 40;
			break;
		case 5:
			xp = 50;
			break;
		case 6:
			xp = 55;
			break;
		case 7:
			xp = 58;
			break;
		case 8:
			xp = 66;
			break;
		case 9:
			xp = 75;
			break;
		case 10:
			xp = 83;
			break;
		case 11:
			xp = 85;
			break;
		case 12:
			xp = 85;
			break;
		case 13:
			xp = 86;
			break;
		case 14:
			xp = 92;
			break;
		case 15:
			xp = 94;
			break;
		case 16:
			xp = 96;
			break;
		case 17:
			xp = 98;
			break;
		case 18:
			xp = 99;
			break;
		case 19:
			xp = 101;
			break;
		case 20:
			xp = 107;
			break;
		default:
			xp = 130;
			break;
	}
	return rand(xp);
}
function totalXP():Number {
	//Nerf xp gains by 20% per level over.
	var difference:Number = player.level - monster.level;
	//No bonuses for underlevel!
	if(difference < 0) difference = 0;
	//No craziness for crazy over-level!
	if(difference > 6) difference = 6;
	//First two levels make no difference
	if(difference <= 2) difference = 0;
	else difference -= 2;
	//convert into something we can multiply by
	difference = (5 - difference) * 20 / 100;
	//Super high level folks only get 1 xp!
	if(player.level - monster.level > 10) return 1;	
	
	return Math.round((baseXP() + bonusXP()) * difference);
}


//5000 6999
function doCombat(eventNum:Number)
{
	var temp2:Number = 0;
	var temp3:Number = 0;
	var temp4:Number = 0;
	var temp5:Number = 0;
	var tempText:String = "";
	var tempText2:String = "";
	var tempText3:String = "";
	var tempText4:String = "";
	var tempText5:String = "";
	var attacks:Number = 5012;
	var pSpecials:int = 5161;
	
	if(eventNum == 5000) {
		flags[IN_COMBAT_USE_PLAYER_WAITED_FLAG] = 0;
		dataBG.visible = false;
		dataText.visible = false;
		appearanceText.visible = false;
		appearanceBG.visible = false;
		perksBG.visible = false;
		perksText.visible = false;
		b1Text.visible = true;
		gButtons[0].visible = true;
		b1Text.htmlText = "Attack";
		var waitT:String = "Wait";
		if(monster.hasStatusAffect("level") >= 0) waitT = "Climb";
		outputText("", true);
		hideUpDown();
		//Update Combat Statuses
		if(menuLoc != 3 && menuLoc != 1) combatStatusesUpdate();
		//Enemy name, description, and status
		display();
		statScreenRefresh();
		menuLoc = 0;
		if(combatRoundOver()) return;
		temp2 = 5002;
		if(player.hasStatusAffect("Throat Punch") >= 0) temp2 = 0;
		if(player.hasStatusAffect("Web-Silence") >= 0) temp2 = 0;
		if(player.hasStatusAffect("GooArmorSilence") >= 0) temp2 = 0;
		
		if(player.hasStatusAffect("Attack Disabled") >= 0) {
			outputText("\n<b>Chained up as you are, you can't manage any real physical attacks!</b>");
			attacks = 0;
		}
		if(player.hasStatusAffect("Physical Disabled") >= 0) {
			outputText("<b>  Even physical special attacks are out of the question.</b>");
			pSpecials = 0;
		}
		else if(player.hasStatusAffect("Isabella Stunned") >= 0) {
			outputText("\n<b>You're too stunned to attack!</b>  All you can do is wait and try to recover!", false);
			simpleChoices("Recover",5071,"",0,"",0,"",0,"",0);
		}
		else if(player.hasStatusAffect("Stunned") >= 0) {
			outputText("\n<b>You're too stunned to attack!</b>  All you can do is wait and try to recover!", false);
			simpleChoices("Recover",5071,"",0,"",0,"",0,"",0);
		}
		else if(player.hasStatusAffect("Whispered") >= 0) {
			outputText("\n<b>Your mind is too addled to focus on combat!</b>  All you can do is try and recover!");
			simpleChoices("Recover",5071,"",0,"",0,"",0,"",0);
		}
		else if(player.hasStatusAffect("Confusion") >= 0) {
			outputText("\nYou're too confused about who you are to try to attack!");
			simpleChoices("Recover",5071,"",0,"",0,"",0,"",0);
		}
		else {
			if(player.hasStatusAffect("HarpyBind") >= 0 || player.hasStatusAffect("GooBind") >= 0 || player.hasStatusAffect("TentacleBind") >= 0 || player.hasStatusAffect("Naga Bind") >= 0 || monster.hasStatusAffect("QueenBind") >= 0 || monster.hasStatusAffect("PCTailTangle") >= 0) {
				choices("Struggle", 5077,"",0,"",0,"",0,"",0,"Wait",5071,"",0,"",0,"",0,"",0);
			} else if(player.hasStatusAffect("Holli Constrict") >= 0) {
				choices("Struggle", 5077,"",0,"",0,"",0,"",0,"Wait",5071,"",0,"",0,"",0,"",0);
			} else if(monster.hasStatusAffect("Constricted") >= 0) {
				simpleChoices("Squeeze", 5119,"Tease",5120,"",0,"",0,"Release",5121);
			} else if(player.hasStatusAffect("Bound") >= 0) {
				simpleChoices("Struggle",ceraphBindingStruggle,"Wait",ceraphBoundWait,"",0,"",0,"",0);
			} else if(player.hasStatusAffect("GooArmorBind") >= 0) {
				choices("Struggle", 5077,"",0,"",0,"",0,"",0,"Wait",5071,"",0,"",0,"",0,"",0);
			} else if(monster.hasStatusAffect("Minotaur Entangled") >= 0) {
				outputText("\n<b>You're bound up in the minotaur lord's chains!  All you can do is try to struggle free!</b>");
				choices("Struggle", 5077,"",0,"",0,"",0,"",0,"Wait",5071,"",0,"",0,"",0,"",0);
			} else if(player.hasStatusAffect("UBERWEB") >= 0) {
				choices("Struggle", 5077, tempText, 0, "Spells", 0, "Items", 0, "Run", 0, "P. Specials",0,"M. Specials",5160,"Wait",0,"Fantasize",0,"",0);				
			}
			//REGULAR MENU
			else {
				//Tease text changes based on perks!
				tempText="Tease";
				choices("Attack", attacks, tempText, 5005, "Spells", temp2, "Items", 1000, "Run", 5003, "P. Specials",pSpecials,"M. Specials",5160,waitT,5071,"Fantasize",5086,"",0);
			}
		}
	}
	//Special Menu
	if(eventNum == 5001) {
		menuLoc = 3;
		//Reset holding variables for special attacks
		temp = 0;
		temp2 = 0;
		temp3 = 0;
		temp4 = 0;
		temp5 = 0;
		var temp6:Number = 0;
		var temp7:Number = 0;
		var temp8:Number = 0;
		var button3Text:String = "Constrict";
		var button1Text:String = "Bite";
		//Sting attack if bee butt
		var buttText:String = "Sting";
		if(player.tailType == 6) temp = 5037;
		if(player.tailType == 5) {
			temp = 5156;
			buttText = "Web";
		}
		if(player.tailType == 15 || player.tailType == 7 || player.tailType == 9 || player.tailType == 14 || player.tailType == 12) {
			temp = 5165;
			buttText = "Tail Whip";
		}
		//Gore if mino horns
		if(player.hornType == 2 && player.horns >= 6) temp2 = 5038;
		//Infest if infested
		if(player.hasStatusAffect("infested") >= 0 && player.hasCock()) {
			if(player.statusAffects[player.hasStatusAffect("infested")].value1 == 5) {
				temp3 = 5060;
			}
		}
		//Bow attack
		if(player.hasKeyItem("Bow") >= 0) {
			temp4 = 5079;
		}
		//Bitez
		if(player.faceType == 4) temp5 = 5102;
		if(player.faceType == 5) temp5 = 5117;
		if(player.faceType == 10) temp5 = 5157;
		//Kiss supercedes bite.
		if(player.hasStatusAffect("Lust Stick Applied") >= 0) {
			temp5 = 5158;
			button1Text = "Kiss";
		}
		//Constrict
		if(player.lowerBody == 3) temp6 = 5118;
		//Kick attackuuuu
		else if(player.lowerBody == 4 || player.lowerBody == 1 || player.lowerBody == 12 || player.lowerBody == 14) {
			temp6 = 5150;
			button3Text = "Kick";
		}
		//Akbal shit
		//fireballlz
		var fireballs:int = 0;
		if(player.hasPerk("Fire Lord") >= 0) {
			fireballs++;
			temp7 = 5123;
		}
		if(player.hasPerk("Hellfire") >= 0) {
			fireballs++;
			temp7 = 5143;
		}
		if(player.hasPerk("Dragonfire") >= 0) {
			fireballs++;
			temp7 = 5164;
		}
		if(fireballs > 1) temp7 = 5144;
		if(player.hasPerk("Whispered") >= 0) temp8 = 5124;
		choices(button1Text,temp5,"Bow",temp4,button3Text,temp6,"Firebreath",temp7,"Gore",temp2,"Infest", temp3,buttText,temp, tempText, 5005, "Whisper",temp8,"Back",5000);
	}
	//Magic Menu
	if(eventNum == 5002) {
		menuLoc = 3;
		magicMenu();
		menuLoc = 3;
	}
	//Run AWAY
	if(eventNum == 5003) {
		runAway();		
	}
	//Defend
	if(eventNum == 5004) {
		
	}
	//Tease - fail, or 5-20 enemy lust.
	if(eventNum == 5005) {
		if(monster.lustVuln == 0) {
			outputText("You try to tease " + monster.a + monster.short + " with your body, but it doesn't have any effect on " + monster.pronoun2 + ".\n\n", true);
			enemyAI();
			return;
		}
		//Worms are immune!
		if(monster.short == "worms") {
			outputText("Thinking to take advantage of its humanoid form, you wave your cock and slap your ass in a rather lewd manner. However, the creature fails to react to your suggestive actions.\n\n", true);
			enemyAI();
			return;
		}
		tease();
		if(!combatRoundOver()) enemyAI();
		return;
	}
	//Initiate Grapple 
	if(eventNum == 5006) {
		
	}
	//combat is over. Clear shit out and go to main
	if(eventNum == 5007) {
		if(gameState == 1 || gameState == 2) {
			//clear status
			clearStatuses(false);
			//Clear itemswapping in case it hung somehow
			itemSwapping = false;
			//Player won
			if(monster.HP < 1 || monster.lust > 99) {
				if(monster.gems == 1) outputText("\n\nYou snag a single gem and " + monster.XP + " XP as you walk away from your victory.", false);
				if(monster.gems > 1) outputText("\n\nYou grab " + monster.gems + " gems and " + monster.XP + " XP from your victory.", false);
				if(monster.gems == 0) outputText("\n\nYou gain " + monster.XP + " XP from the battle.", false);
				gameState = 0;
				if(!inDungeon) doNext(13);
				else doNext(1);
				if(player.hasPerk("Midas Cock") >= 0) {
					if(monster.gems >= 50) monster.gems++;
					if(monster.gems >= 20) monster.gems++;
					monster.gems += 2;
				}
				player.gems += monster.gems;
				player.XP += monster.XP;
				dropItem(monster.short);
				return;
			}
			//Player lost
			else {
				if(monster.statusAffectv1("sparring") == 2) {
					outputText("The cow-girl has defeated you in a practice fight!", true);
					outputText("\n\nYou have to lean on Isabella's shoulder while the two of your hike back to camp.  She clearly won.", false);
					gameState = 0;
					player.HP = 1;
					statScreenRefresh();
					doNext(13);
					return;
				}
				//Next button is handled within the minerva loss function
				if(monster.hasStatusAffect("Peach Loot Loss") >= 0) {
					gameState = 0;
					player.HP = 1;
					statScreenRefresh();
					return;
				}
				if(monster.short == "Ember") {
					gameState = 0;
					player.HP = 1;
					statScreenRefresh();
					doNext(13);
					return;
				}
				temp = rand(10) + 1 + Math.round(monster.level/2);
				if(!inDungeon) {
					if(player.gems == 1) outputText("\n\nYou'll probably come to your senses in eight hours or so, missing your only gem.", false);
					if(player.gems > 1) outputText("\n\nYou'll probably come to your senses in eight hours or so, missing " + temp + " gems.", false);
				}
				else {
					temp += 20 + monster.level*2;
					outputText("\n\nSomehow you came out of that alive, but after checking your gem pouch, you realize you're missing " + num2Text(temp) + ".");
				}
				if(temp > player.gems) temp = player.gems;
				player.gems -= temp;
				gameState = 0;
				//BUNUS XPZ
				if(flags[UNKNOWN_FLAG_NUMBER_00089] > 0) {
					player.XP += flags[UNKNOWN_FLAG_NUMBER_00089];
					outputText("  Somehow you managed to gain " + flags[UNKNOWN_FLAG_NUMBER_00089] + " XP from the situation.", false);
					flags[UNKNOWN_FLAG_NUMBER_00089] = 0;
				}
				//Bonus lewts
				if(flags[UNKNOWN_FLAG_NUMBER_00234] != "") {
					outputText("  Somehow you came away from the encounter with " + itemLongName(flags[UNKNOWN_FLAG_NUMBER_00234]) + ".\n\n", false);
					shortName = flags[UNKNOWN_FLAG_NUMBER_00234];
					menuLoc = 18;
					takeItem();
				}
				else doNext(16);
			}
		}
		//Not actually in combat
		else doNext(13);
	}
	//HP Victory
	if(eventNum == 5008) {
		if(monster.skinTone == "helspawn") {
			beatUpYourDaughter();
			return;
		}
		if(monster.short == "Holli") {
			defeatHolli();
			return;
		}
		if(monster.short == "Sheila") {
			if(flags[SHEILA_DEMON] == 1) beatUpDemonSheila();
			else sheilaGotWhomped();
			return;
		}
		if(monster.short == "Sand Mother") {
			defeatTheSandMother();
			return;
		}
		if(monster.short == "Cum Witch") {
			cumWitchDefeated();
			return;
		}
		if(monster.short == "sand witches") {
			yoYouBeatUpSomeSandWitchesYOUMONSTER();
			return;
		}
		if(monster.short == "imp lord") {
			defeatImpLord();
			return;
		}
		if(monster.short == "Minerva") {
			beatUpDatSharpie();
			return;
		}
		if(monster.short == "Kelt") {
			if(flags[KELT_BREAK_LEVEL] == 1) defeatKellyNDBREAKHIM();
			else breakingKeltNumeroThree();
			return;
		}
		if(monster.short == "Sirius, a naga hypnotist") {
			urtaBeatsUpSiriusRadio();
			return;
		}
		if(monster.short == "kitsune") {
			defeatTheKitsunes();
			return;
		}
		if(monster.short == "satyr") {
			defeatASatyr();
			return;
		}
		if(monster.short == "sandtrap" || monster.short == "sand tarp") {
			pcBeatsATrap();
			return;
		}
		if(monster.short == "chameleon girl") {
			defeatChameleonGirl();
			return;
		}
		if(monster.short == "Ember") {
			beatEmberSpar();
			//loseToEmberSpar()
			return;
		}
		if(monster.short == "farmers") {
			beatUpOwca();
			//loseToOwca()
			return;
		}
		if(monster.short == "lusty demons") {
			defeetVapulasHorde();
			//loseOrSubmitToVapula();
			return;
		}
		if(monster.short == "Harpy Queen") {
			harpyQueenDefeatedByPC();
			return;
		}
		if(monster.short == "phoenix platoon") {
			phoenixPlatoonLosesToPC();
			return;
		}
		if(monster.short == "Brigid the Jailer") {
			pcDefeatsBrigid();
			return;
		}
		if(monster.short == "harpy horde") {
			pcDefeatsHarpyHorde();
			return;
		}
		if(monster.short == "Goo Armor") {
			//gooArmorBeatsUpPC();
			if(monster.hasStatusAffect("spar") >= 0) pcWinsValeriaSpar();
			else beatUpGooArmor();
			return;
		}
		if(monster.short == "mob of spiders-morphs") {
			beatSpiderMob();
			return;
		}
		if(monster.short == "Hel" || monster.short == "salamander") {
			if(monster.hasStatusAffect("sparring") >= 0) PCBeatsUpSalamanderSparring();
			else beatUpHel();
			return;
		}
		if(monster.short == "goo-girl") {
			beatUpGoo();
			return;
		}
		if(monster.short == "plain girl") {
			defeatDannyPhantom();
			return;
		}
		if(monster.short == "Kiha") {
			if(monster.hasStatusAffect("spiderfight") >= 0) 
				playerBeatsUpKihaPreSpiderFight();
			else if(monster.hasStatusAffect("domfight") >= 0)
				pcWinsDomFight();
			else if(monster.hasStatusAffect("spar") >= 0)
				winSparWithKiha();
			else kihaVictoryIntroduction();
			return;
		}
		if(monster.short == "minotaur gang" || monster.short == "minotaur tribe") {
			victoryMinotaurGang();
			return;
		}
		if(monster.short == "corrupted drider") {
			defeatDriderIntro();
			return;
		}
		if(monster.short == "basilisk") {
			defeatBasilisk();
			return;
		}
		if(monster.short == "Isabella") {
			defeatIsabella();
			return;
		}
		if(monster.short == "female spider-morph") {
			defeatASpiderBitch();
			return;
		}
		if(monster.short == "male spider-morph") {
			defeatSpiderBoy();
			return;
		}
		if(monster.short == "Izma") {
			defeatIzma();
			return;
		}
		if(monster.short == "Amily") {
			conquerThatMouseBitch();
			return;
		}
		if(monster.short == "gnoll spear-thrower") {
			hyenaVictory();
			return;
		}
		if(monster.short == "gnoll") {
			if(monster.hasStatusAffect("PhyllaFight") >= 0) {
				monster.removeStatusAffect("PhyllaFight");
				phyllaPCBeatsGnoll();
				return;
			}
			defeatHyena();
			return;
		}
		if(monster.short == "Zetaz") {
			defeatZetaz();
			return;
		}
		if(monster.short == "Vala") {
			fightValaVictory();
			return;
		}
		if(monster.short == "anemone") {
			defeatAnemone();
			return;
		}
		if(monster.short == "imp" && monster.hasStatusAffect("Kitsune Fight") >= 0) {
			winKitsuneImpFight();
			return;
		}
		if(monster.short == "imp horde") {
			impGangVICTORY();
			return;
		}
		if(monster.short == "pod") {
			encapsulationVictory();
			return;
		}
		if(monster.short == "Tamani's daughters") {
			combatWinAgainstDaughters();
			return;
		}
		if(monster.short == "harpy") {
			harpyVictoryuuuuu();
			return;
		}
		if(monster.short == "Sophie") {
			if(monster.hasStatusAffect("bimboBrawl") >= 0)
				beatUpDebimboSophie();
			else 
				sophieLostCombat();
			return;
		}
		if(monster.short == "Ceraph") {
			winRapeChoices();
			return;
		}
		if(monster.short == "Jojo") {
			if(player.lust > 33 && player.gender > 0) {
				outputText("You smile in satisfaction as " + monster.a + monster.short + " collapses, unable to continue fighting.  Sadly you realize your own needs have not been met.  Of course, you could always rape the poor thing...\n\nDo you rape him?", true);
				doYesNo(5022, 5007);
				return;
			}
			else 
			{
				gameState = 0;
				outputText("You defeat " + monster.a + monster.short + ".", true);
				if(monster.gems == 1) outputText("\nYou find a single gem on the unconscious mouse and pocket it.", false);
				if(monster.gems > 1) outputText("\nYou find " + monster.gems + " gems on the unconscious mouse and pocket them.", false);
				outputText("\n\nYou gain " + monster.XP + " xp!\n\n", false);
				player.XP += monster.XP;
				player.gems += monster.gems;
				clearStatuses(false);
				dropItem(monster.short);
				if(menuLoc == 0) doNext(13);
				return;
			}
		}
		if(monster.short == "Akbal") {
			victoryChoices();
			return;
		}
		if(monster.short == "shark-girl") {
			sharkWinChoices();
			return
		}
		if(monster.short == "naga") {
			nagaRapeChoice();
			return;
		}
		if(monster.short == "Marble") {
			eventParser(5094);
			return;
		}
		if(monster.short == "Tamani") {
			outputText("Tamani is defeated!", true);
			if(player.lust >= 33 && player.totalCocks() > 0) {
				outputText("  You could fuck her, but if that's the case why did you bother fighting her?\n\nWhat do you do to her?", false);
				temp = 0;
				temp2 = 0;
				if(player.hasCock() && player.cockThatFits(monster.analCapacity()) >= 0) temp = 3360;
				//NOT PREGGERS
				if(player.statusAffectv1("Tamani") <= -500 && player.canOvipositSpider()) {
					temp2 = 3837;
				}
				simpleChoices("Fuck",tamaniSexWon,"Buttfuck",temp,"",0,"Lay Eggs",temp2,"Leave",5007);
			}
			else eventParser(5007);			
			return;
		}
		if(monster.short == "goblin") {
			gobboRapeIntro();
			return;
		}
		if(monster.short == "goblin broodmother") {
			clearOutput();
			outputText("The goblin broodmother is defeated!  You find a bottle of succubi milk on her.  That stuff is banned in Tel'Adre - and for good reason, but it might come in handy.  You pocket the foul fluid for now.");
			outputText("  You could use her for a quick, willing fuck to sate your lusts before continuing on.  Do you?");
			menu();
			addButton(0,"Fuck",	winFuckAGoblinBroodmotherAsUrta);
			addButton(4,"Leave",nagaPleaseNagaStoleMyDick);
			return;
		}
		if(monster.short == "milky succubus") {
			urtaBeatsUpCowcubi();
			return;
		}
		if(monster.short == "minotaur lord") {
			clearOutput();
			outputText("The minotaur lord is defeated!  ");
			outputText("  You could use him for a quick fuck to sate your lusts before continuing on.  Do you?");
			menu();
			addButton(0,"Fuck",	winRapeAMinoLordAsUrta);
			addButton(4,"Leave",beatMinoLordOnToSuccubi);
			return;
		}
		if(monster.short == "alpha gnoll") {
			clearOutput();
			outputText("The gnoll alpha is defeated!  You could use her for a quick, willing fuck to sate your lusts before continuing on.  Hell, you could even dose her up with that succubi milk you took from the goblin first - it might make her even hotter.  Do you?");
			menu();
			addButton(0,"Fuck",	winRapeHyenaPrincess);
			addButton(1,"Succ Milk", useSuccubiMilkOnGnollPrincesses);
			addButton(4,"Leave",urtaNightSleep);
			return;
		}
		if(monster.short == "fetish zealot") {
			zealotDefeated();
			return;
		}
		if(monster.short == "tentacle beast") {
			outputText("The creature lets out an ear-piercing screech as it collapses upon itself. Its green coloring quickly fades to brown as the life drains from it, leaving you victorious.", true);
			if(monster.hasStatusAffect("PhyllaFight") >= 0) {
				monster.removeStatusAffect("PhyllaFight");
				phyllaTentacleDefeat();
				return;
			}
			else {
				eventParser(5007);
				return;
			}
		}
		if(monster.short == "demons") {
			outputText("You strike out and the last of the demons tumbles to the ground with a thud. You stand there for a second surrounded by dead or unconscious demons feeling like a god of battle. Then you realize that if a god of battle does exist he lives on a demonic plane like this, so to avoid insulting him you take your hands off your hips and your " + player.legs() + " off the head of the demon leader before you start to search the bodies.", true);
			stats(0,0,0,0,0,0,1,0);
			if(monster.hasStatusAffect("phyllafight") >= 0) {
				doNext(consolePhylla);
				return;
			}
			eventParser(5007);
			return;
		}
		if(monster.short == "hellhound") {
			outputText("The hellhound's flames dim and the heads let out a whine before the creature slumps down, defeated and nearly unconscious.", true);
			//Rape if not naga, turned on, and girl that can fit!
			if(player.hasVagina() && player.lust >= 33 && !player.isNaga()) {
				outputText("  You find yourself musing that you could probably take advantage of the poor 'doggy'.  Do you fuck it?", false);
				simpleChoices("Fuck it",hellHoundPropahRape,"",0,"",0,"",0,"Leave",5007);
				return;
			}
			eventParser(5007);
			return;
		}
		if(monster.short == "infested hellhound") {
			outputText("The hellhound's flames dim and the heads let out a whine before the creature slumps down, defeated, unconscious, and yet still drooling worms.", true);
			eventParser(5007);
			return;
		}
		if(monster.short == "bee-girl") {
			if(player.gender > 0) {
				outputText("You smile in satisfaction as the " + monster.short + " collapses, unable to continue fighting.  The sweet scent oozing from between her legs is too much to bear, arousing you painfully, and you see an easy way to relieve it..\n\nWhat do you do to her?", true);
				player.lust = 98;
				stats(0,0,0,0,0,0,1,0);
				temp2 = 0;
				temp3 = 0;
				if(player.hasStatusAffect("Feeder") >= 0) temp3 = 2484;
				if(player.hasKeyItem("Deluxe Dildo") >= 0) temp2 = 2263;
				simpleChoices("Rape",2059,"Dildo Rape",temp2,"",0,"B. Feed",temp3,"Leave",5007);
				return;
			}
			//Genderless can still breastfeed
			else if(player.hasStatusAffect("Feeder") >= 0) {
				outputText("You smile in satisfaction as the " + monster.short + " collapses, unable to continue fighting.  The sweet scent oozing from between her legs is too much to bear, arousing you painfully.\n\nWhat do you do?", true);
				simpleChoices("B. Feed", 2484,"",0,"",0,"",0,"Leave",5007);
				return;
			}
		}
		//Succubus
		if(monster.short == "secretarial succubus" && player.gender > 0) {
			outputText("You smile in satisfaction as the " + monster.short + " collapses, unable to continue fighting.  Now would be the perfect opportunity to taste the fruits of her sex-ready form...\n\nDo you rape her?", true);
			stats(0,0,0,0,0,0,1,0);
			temp2 = 0;
			if(player.hasKeyItem("Deluxe Dildo") >= 0) temp2 = 2266;
			simpleChoices("Yes",11023,"Dildo Rape",temp2,"",0,"",0,"No",5007)
			return;
		}
		if(monster.short == "Omnibus Overseer") {
			omnibusVictoryEvent();
			return;
		}
		if(monster.short == "incubus mechanic") {
			if(player.gender == 0) {
				outputText("You smile in satisfaction as the " + monster.short + " collapses, unable to continue fighting.  Now would be the perfect opportunity to test his demonic tool...\n\nHow do you want to handle him?", true);
				simpleChoices("Anally",11063,"Orally",11039,"",0,"",0,"Leave",5007);
			}
			else {
				outputText("You smile in satisfaction as the " + monster.short + " collapses, unable to continue fighting.  Now would be the perfect opportunity to put his tool to use...\n\nWhat do you do, rape him, service him, or let him take you anally?", true);
				stats(0,0,0,0,0,0,1,0);
				simpleChoices("Rape",11064,"Service Him",11039,"Anal",11063,"Nothing",5007,"",0);
			}
			return;
		}
		//SLIIIIME
		if(monster.short == "green slime") {
			outputText("You smile in satisfaction as the " + monster.short + " collapses, unable to continue fighting.", true);
			//Boobfeed.
			if(player.hasStatusAffect("Feeder") >= 0) {
				//Eligable to rape
				if(player.lust >= 33 && player.gender > 0) {
					outputText("\n\nYou're horny enough to try and rape it, though you'd rather see how much milk you can squirt into it.  What do you do?", false);
					simpleChoices("B.Feed",2480,"Rape",5041,"",0,"",0,"Leave",5007);
				}
				//Rapes not on the table.
				else {
					outputText("\n\nYour nipples ache with the desire to forcibly breastfeed the gelatinous beast.  Do you?", false);
					doYesNo(rapeOozeWithMilk,5007);					
				}
			}
			//Not a breastfeeder
			else if(player.lust >= 33 && player.gender > 0) {
				outputText("  Sadly you realize your own needs have not been met.  Of course, you could always play with the poor thing... Do you rape it?", false);
				doYesNo(5041, 5007);
			}
			else eventParser(5007);
			return;
		}
		//Cultist
		if(monster.short == "fetish cultist") {
			temp2 = 0.
			if(player.hasStatusAffect("Feeder") >= 0) temp2 = 2485
			outputText("Hurt too much to continue controlling her powers, the cultist collapses helplessly.", true);
			if(player.lust >= 33 && player.gender > 0) {
				outputText("  You realize she'd make a perfect receptacle for your lusts.  Do you have your way with her?", false);
				//doYesNo(5065, 5007);
				simpleChoices("Sex",5065,"",0,"",0,"B. Feed",temp2,"Leave",5007);
			}
			else {
				if(temp2 > 0) {
					outputText("  She looks like she might take some of your milk if you offered it to her.  What do you do?", false);
					simpleChoices("B. Feed",temp2,"",0,"",0,"",0,"Leave",5007);
				}
				else eventParser(5007);
			}
			return;
		}
		if(monster.short == "minotaur") {
			if(monster.hasStatusAffect("PhyllaFight") >= 0) {
				monster.removeStatusAffect("PhyllaFight");
				outputText("You defeat a minotaur!  ", true);
				phyllaBeatAMino();
				return;
			}
			minoVictoryRapeChoices();
			return;
		}
		if(monster.short == "sand witch" && player.lust >= 33) {
			beatSandwitch();
			return;
		}
		gameState = 0;
		outputText("You defeat " + monster.a + monster.short + ".\n", true);
		if(monster.gems == 1) outputText("\nYou find a single gem on your defeated foe's unconscious body and pocket it.", false);
		if(monster.gems > 1) outputText("\nYou find " + monster.gems + " gems on your defeated foe's unconscious body and pocket them.", false);
		outputText("\n\nYou gain " + monster.XP + " xp!", false);
		player.XP += monster.XP;
		player.gems += monster.gems;
		clearStatuses(false);
		dropItem(monster.short);
		if(menuLoc == 0) doNext(13);
		return;
	}
	//Lust Victory
	if(eventNum == 5009) {
		if(monster.skinTone == "helspawn") {
			beatUpYourDaughter();
			return;
		}
		if(monster.short == "Holli") {
			defeatHolli();
			return;
		}
		if(monster.short == "Sheila") {
			if(flags[SHEILA_DEMON] == 1) beatUpDemonSheila();
			else sheilaGotWhomped();
			return;
		}
		if(monster.short == "Sand Mother") {
			defeatTheSandMother();
			return;
		}
		if(monster.short == "Cum Witch") {
			cumWitchDefeated();
			return;
		}
		if(monster.short == "sand witches") {
			yoYouBeatUpSomeSandWitchesYOUMONSTER();
			return;
		}
		if(monster.short == "imp lord") {
			defeatImpLord();
			return;
		}
		if(monster.short == "Minerva") {
			beatUpDatSharpie();
			return;
		}
		if(monster.short == "Kelt") {
			if(flags[KELT_BREAK_LEVEL] == 1) defeatKellyNDBREAKHIM();
			else breakingKeltNumeroThree();
			return;
		}
		if(monster.short == "Sirius, a naga hypnotist") {
			urtaBeatsUpSiriusRadio();
			return;
		}
		if(monster.short == "kitsune") {
			defeatTheKitsunes();
			return;
		}
		if(monster.short == "sandtrap" || monster.short == "sand tarp") {
			pcBeatsATrap();
			return;
		}
		if(monster.short == "satyr") {
			defeatASatyr();
			return;
		}
		if(monster.short == "chameleon girl") {
			defeatChameleonGirl();
			return;
		}
		if(monster.short == "Ember") {
			beatEmberSpar();
			//loseToEmberSpar()
			return;
		}
		if(monster.short == "farmers") {
			beatUpOwca();
			//loseToOwca()
			return;
		}
		if(monster.short == "lusty demons") {
			defeetVapulasHorde();
			//loseOrSubmitToVapula();
			return;
		}
		if(monster.short == "Harpy Queen") {
			harpyQueenDefeatedByPC();
			return;
		}
		if(monster.short == "phoenix platoon") {
			phoenixPlatoonLosesToPC();
			return;
		}
		if(monster.short == "Brigid the Jailer") {
			pcDefeatsBrigid();
			return;
		}
		if(monster.short == "harpy horde") {
			pcDefeatsHarpyHorde();
			return;
		}
		if(monster.short == "mob of spiders-morphs") {
			beatSpiderMob();
			return;
		}
		if(monster.short == "Goo Armor") {
			//gooArmorBeatsUpPC();
			if(monster.hasStatusAffect("spar") >= 0) pcWinsValeriaSpar();
			else beatUpGooArmor();
			return;
		}
		if(monster.short == "Hel" || monster.short == "salamander") {
			if(monster.hasStatusAffect("sparring") >= 0) PCBeatsUpSalamanderSparring();
			else beatUpHel();
			return;
		}
		if(monster.short == "goo-girl") {
			beatUpGoo();
			return;
		}
		if(monster.short == "plain girl") {
			defeatDannyPhantom();
			return;
		}
		if(monster.short == "Kiha") {
			if(monster.hasStatusAffect("spiderfight") >= 0) 
				playerBeatsUpKihaPreSpiderFight();
			else if(monster.hasStatusAffect("domfight") >= 0)
				pcWinsDomFight();
			else if(monster.hasStatusAffect("spar") >= 0)
				winSparWithKiha();
			else kihaVictoryIntroduction();
			return;
		}
		if(monster.short == "minotaur gang" || monster.short == "minotaur tribe") {
			victoryMinotaurGang();
			return;
		}
		if(monster.short == "corrupted drider") {
			defeatDriderIntro();
			return;
		}
		if(monster.short == "basilisk") {
			defeatBasilisk();
			return;
		}
		if(monster.short == "female spider-morph") {
			defeatASpiderBitch();
			return;
		}
		if(monster.short == "male spider-morph") {
			defeatSpiderBoy();
			return;
		}
		if(monster.short == "Isabella") {
			defeatIsabella();
			return;
		}
		if(monster.short == "Izma") {
			defeatIzma();
			return;
		}
		if(monster.short == "gnoll spear-thrower") {
			hyenaVictory();
			return;
		}
		if(monster.short == "Amily") {
			conquerThatMouseBitch();
			return;
		}
		if(monster.short == "gnoll") {
			if(monster.hasStatusAffect("PhyllaFight") >= 0) {
				monster.removeStatusAffect("PhyllaFight");
				phyllaPCBeatsGnoll();
				return;
			}
			defeatHyena();
			return;
		}
		if(monster.short == "Zetaz") {
			defeatZetaz();
			return;
		}
		if(monster.short == "Vala") {
			fightValaVictory();
			return;
		}
		if(monster.short == "anemone") {
			defeatAnemone();
			return;
		}
		if(monster.short == "imp horde") {
			impGangVICTORY();
			return;
		}
		if(monster.short == "Tamani's daughters") {
			combatWinAgainstDaughters();
			return;
		}
		if(monster.short == "Sophie") {
			if(monster.hasStatusAffect("bimboBrawl") >= 0)
				beatUpDebimboSophie();
			else 
				sophieLostCombat();
			return;
		}
		if(monster.short == "harpy") {
			harpyVictoryuuuuu();
			return;
		}
		if(monster.short == "Ceraph") {
			winRapeChoices();
			return;
		}
		if(monster.short == "imp") {
			if(monster.hasStatusAffect("Kitsune Fight") >= 0) {
				winKitsuneImpFight();
				return;
			}
			impVictory();
			return;
		}
		if(monster.short == "Akbal") {
			victoryChoices();
			return;
		}
		if(monster.short == "fetish zealot") {
			zealotDefeated();
			return;
		}
		if(monster.short == "Tamani") {
			outputText("Tamani gives up on defeating you and starts masturbating!", true);
			if(player.lust >= 33 && player.totalCocks() > 0) {
				outputText("  You could fuck her, but if that's the case why did you bother fighting her?\n\nWhat do you do to her?", false);
				temp = 0;
				temp2 = 0;
				if(player.hasCock() && player.cockThatFits(monster.analCapacity()) >= 0) temp = 3360;
				//NOT PREGGERS
				if(player.statusAffectv1("Tamani") <= -500 && player.canOvipositSpider()) {
					temp2 = 3837;
				}
				simpleChoices("Fuck",tamaniSexWon,"Buttfuck",temp,"",0,"Lay Eggs",temp2,"Leave",5007);
			}
			else eventParser(5007);			
			return;
		}
		if(monster.short == "shark-girl") {
			sharkWinChoices();
			return
		}
		if(monster.short == "naga") {
			nagaRapeChoice();
			return;
		}
		if(monster.short == "Marble") {
			eventParser(5094);
			return;
		}
		if(monster.short == "goblin") {
			gobboRapeIntro();
			return;
		}
		if(monster.short == "goblin broodmother") {
			clearOutput();
			outputText("The goblin broodmother is defeated!  You find a bottle of succubi milk on her.  That stuff is banned in Tel'Adre - and for good reason, but it might come in handy.  You pocket the foul fluid for now.");
			outputText("  You could use her for a quick, willing fuck to sate your lusts before continuing on.  Do you?");
			menu();
			addButton(0,"Fuck",	winFuckAGoblinBroodmotherAsUrta);
			addButton(4,"Leave",nagaPleaseNagaStoleMyDick);
			return;
		}
		if(monster.short == "milky succubus") {
			urtaBeatsUpCowcubi();
			return;
		}
		if(monster.short == "minotaur lord") {
			clearOutput();
			outputText("The minotaur lord is defeated!  ");
			outputText("  You could use him for a quick fuck to sate your lusts before continuing on.  Do you?");
			menu();
			addButton(0,"Fuck",	winRapeAMinoLordAsUrta);
			addButton(4,"Leave",beatMinoLordOnToSuccubi);
			return;
		}
		if(monster.short == "alpha gnoll") {
			clearOutput();
			outputText("The gnoll alpha is defeated!  You could use her for a quick, willing fuck to sate your lusts before continuing on.  Hell, you could even dose her up with that succubi milk you took from the goblin first - it might make her even hotter.  Do you?");
			menu();
			addButton(0,"Fuck",	winRapeHyenaPrincess);
			addButton(1,"Succ Milk", useSuccubiMilkOnGnollPrincesses);
			addButton(4,"Leave",urtaNightSleep);
			return;
		}
		if(monster.short == "tentacle beast") {
			outputText("The tentacle beast's mass begins quivering and sighing, the tentacles wrapping around each other and feverishly caressing each other.  It seems the beast has given up on fighting.", false);
			if(monster.hasStatusAffect("PhyllaFight") >= 0) {
				monster.removeStatusAffect("PhyllaFight");
				phyllaTentacleDefeat();
				return;
			}
			if(player.gender > 0) {
				outputText("  Perhaps you could use it to sate yourself?", true);
				doYesNo(5078,5007);
			}
			else eventParser(5007);
			return;
		}
		if(monster.short == "Omnibus Overseer") {
			omnibusVictoryEvent();
			return;
		}
		if(monster.short == "hellhound") {
			temp2 = 0;
			outputText("Unable to bear hurting you anymore, the hellhound's flames dim as he stops his attack. The two heads look at you, whining plaintively.  The hellhound slowly pads over to you and nudges its noses at your crotch.  It seems he wishes to pleasure you.\n\n", true);
			if(player.gender > 0 && player.lust >= 33) {
				outputText("You realize your desires aren't quite sated.  You could let it please you", false);
				//Rape if not naga, turned on, and girl that can fit!
				if(player.hasVagina() && player.lust >= 33 && !player.isNaga()) {
					outputText(" or make it fuck you", false);
					temp2 = 2746;
				}
				outputText(".  What do you do?", false);
				simpleChoices("Lick",5068,"Fuck",temp2,"",0,"",0,"Leave",5007);
			}
			else {
				outputText("You turn away, not really turned on enough to be interested in such an offer.", false);
				eventParser(5007);
			}
			return;
		}
		if(monster.short == "infested hellhound") {
			outputText("Unable to bear its unnatural arousal, the infested hellhound's flames dim as he stops his attack. The two heads look at you, whining plaintively.  The hellhound slowly pads over to you and nudges its noses at your crotch.  It seems he wishes to pleasure you.\n\n", true);
			if(player.gender > 0 && player.lust >= 33) {
				outputText("You realize your desires aren't quite sated.  You could let it please you.  Do you?", false);
				simpleChoices("Fuck it",5068,"",0,"",0,"",0,"Leave",5007);
			}
			else {
				outputText("You turn away, not really turned on enough to be interested in such an offer from such a beast.", false);
				eventParser(5007);
			}
			return;
		}
		if(monster.short == "demons") {
			outputText("The demons stop attacking, and reach out to touch your body. Some are already masturbating like it's the only thing in the world and you know that right now, if you wanted to, you could make each and every one of them fuck you.");
			if(monster.hasStatusAffect("phyllafight") >= 0) {
				doNext(consolePhylla);
				return;
			}
			outputText("  Do you rape them?", true);
			doYesNo(5045, 5007);
			return;
		}
		if(monster.short == "Jojo" && player.lust >= 33 && player.gender > 0) {
			outputText("You smile in satisfaction as " + monster.a + monster.short + " collapses and begins masturbating feverishly.  Sadly you realize your own needs have not been met.  Of course, you could always rape the poor thing...\n\nDo you rape him?", true);
			doYesNo(5022, 5007);
			return;
		}
		if(monster.short == "minotaur") {
			if(monster.hasStatusAffect("PhyllaFight") >= 0) {
				monster.removeStatusAffect("PhyllaFight");
				outputText("You defeat a minotaur!  ", true);
				phyllaBeatAMino();
				return;
			}
			minoVictoryRapeChoices();
			return;
		}
		if(monster.short == "bee-girl" && player.lust >= 33 && player.gender > 0) {
			if(player.gender > 0) {
				outputText("You smile in satisfaction as the " + monster.short + " spreads her legs and starts frigging her honey-soaked cunt.  The sweet scent oozing from between her legs is too much to bear, arousing you painfully, and you see an easy way to relieve it..\n\nWhat do you do to her?", true);
				player.lust = 98;
				stats(0,0,0,0,0,0,1,0);
				temp2 = 0;
				temp3 = 0;
				if(player.hasStatusAffect("Feeder") >= 0) temp3 = 2484;
				if(player.hasKeyItem("Deluxe Dildo") >= 0) temp2 = 2263;
				simpleChoices("Rape",2059,"Dildo Rape",temp2,"",0,"B. Feed",temp3,"Leave",5007);
				return;
			}
			//Genderless can still breastfeed
			else if(player.hasStatusAffect("Feeder") >= 0) {
				outputText("You smile in satisfaction as the " + monster.short + " spreads her legs and starts frigging her honey-soaked cunt.  The sweet scent oozing from between her legs is too much to bear, arousing you painfully.\n\nWhat do you do?", true);
				simpleChoices("B. Feed", 2484,"",0,"",0,"",0,"Leave",5007);
				return;
			}
		}
		//Succubus
		if(monster.short == "secretarial succubus" && player.lust >= 33 && player.gender > 0) {
			outputText("You smile in satisfaction as the " + monster.short + " gives up on fighting you and starts masturbating, begging for you to fuck her.  Now would be the perfect opportunity to taste the fruits of her sex-ready form...\n\nDo you fuck her?", true);
			stats(0,0,0,0,0,0,1,0);
			temp2 = 0;
			if(player.hasKeyItem("Deluxe Dildo") >= 0) temp2 = 2266;
			simpleChoices("Yes",11023,"Dildo Rape",temp2,"",0,"",0,"No",5007)
			return;
		}
		//Incubus
		if(monster.short == "incubus mechanic") {
			temp2 = 0;
			if(player.gender == 0) {
				outputText("You smile in satisfaction as the " + monster.short + " collapses, masturbating happily.  Now would be the perfect opportunity to test his demonic tool...\n\nHow do you want to handle him?", true);
				simpleChoices("Anally",11063,"Orally",11039,"",0,"",0,"Leave",5007);
			}
			else {
				if(player.hasVagina() && player.biggestTitSize() >= 4 && player.armorName == "lusty maiden's armor") temp2 = 3988;
				outputText("You smile in satisfaction as the " + monster.short + " collapses, masturbating happily.  Now would be the perfect opportunity to put his tool to use...\n\nWhat do you do?", true);
				stats(0,0,0,0,0,0,1,0);
				simpleChoices("Rape",11064,"Service Him",11039,"Anal",11063,"B.Titfuck",temp2,"Nothing",5007);
			}
			return;
		}
		//SLIIIIME
		if(monster.short == "green slime") {
			outputText("You smile in satisfaction as the " + monster.short + " collapses, unable to continue fighting.", true);
			//Boobfeed.
			if(player.hasStatusAffect("Feeder") >= 0) {
				//Eligable to rape
				if(player.lust >= 33 && player.gender > 0) {
					outputText("\n\nYou're horny enough to try and rape it, though you'd rather see how much milk you can squirt into it.  What do you do?", false);
					simpleChoices("B.Feed",2480,"Rape",5041,"",0,"",0,"Leave",5007);
				}
				//Rapes not on the table.
				else {
					outputText("\n\nYour nipples ache with the desire to forcibly breastfeed the gelatinous beast.  Do you?", false);
					doYesNo(rapeOozeWithMilk,5007);					
				}
			}
			//Not a breastfeeder
			else if(player.lust >= 33 && player.gender > 0) {
				outputText("  Sadly you realize your own needs have not been met.  Of course, you could always play with the poor thing... Do you rape it?", false);
				doYesNo(5041, 5007);
			}
			else eventParser(5007);
			return;
		}
		//Cultist
		if(monster.short == "fetish cultist") {
			temp2 = 0.
			if(player.hasStatusAffect("Feeder") >= 0) temp2 = 2485
			outputText("Overwhelmed by her lusts, the cultist loses the ability to control herself and collapses.", true);
			if(player.lust >= 33 && player.gender > 0) {
				outputText("  You realize she'd make a perfect receptacle for your own lust.  Do you sate yourself?", false);
				//doYesNo(5065, 5007);
				simpleChoices("Rape",5065,"",0,"",0,"B. Feed",temp2,"Leave",5007);
			}
			else {
				if(temp2 > 0) {
					outputText("  She looks like she might take some of your milk if you offered it to her.  What do you do?", false);
					simpleChoices("B. Feed",temp2,"",0,"",0,"",0,"Leave",5007);
				}
				else eventParser(5007);
			}
			return;
		}
		if(monster.short == "sand witch" && player.lust >= 33) {
			beatSandwitch();
			return;
		}
		outputText("You smile as " + monster.a + monster.short + " collapses and begins masturbating feverishly.", true);
		if(monster.gems == 1) outputText("\nYou find a single gem near your fallen foe and pocket it.", false);
		if(monster.gems > 1) outputText("\nYou find " + monster.gems + " gems near your fallen foe and pocket them.", false);
		outputText("\n\nYou gain " + monster.XP + " xp!", false);
		player.XP += monster.XP;
		player.gems += monster.gems;
		clearStatuses(false);
		dropItem(monster.short);
		gameState = 0;
		trace("combat over: menuloc: " + menuLoc);
		if(menuLoc == 0 || menuLoc == 3) doNext(13);
		return;

	}
	//HP Loss
	if(eventNum == 5010) {
		if(monster.skinTone == "helspawn") {
			loseSparringToDaughter();
			return;
		}
		if(monster.short == "Holli") {
			enjoyYourBadEndBIYAAAATCH();
			return;
		}
		if(monster.short == "Sheila") {
			if(flags[SHEILA_DEMON] == 1) loseToSheila();
			else getBeatUpBySheila();
			return;
		}
		if(monster.short == "Sand Mother") {
			loseToTheSandMother();
			return;
		}
		if(monster.short == "Cum Witch") {
			defeatedByCumWitch();
			return;
		}
		if(monster.short == "sand witches") {
			loseToSammitchMob();
			return;
		}
		if(monster.short == "imp lord") {
			loseToAnImpLord();
			return;
		}
		if(monster.short == "Minerva") {
			loseToMinerva();
			return;
		}
		if(monster.short == "Kelt") {
			keltFucksShitUp();
			return;
		}
		if(monster.short == "Sirius, a naga hypnotist") {
			urtaLosesToSirriusSnakeRadio();
			return;
		}
		if(monster.short == "kitsune") {
			loseToKitsunes();
			return;
		}
		if(monster.short == "satyr") {
			loseToSatyr();
			return;
		}
		if(monster.short == "sandtrap" || monster.short == "sand tarp") {
			sandtrapmentLoss(true);
			return;
		}
		if(monster.short == "chameleon girl") {
			loseToChameleonGirl();
			return;
		}
		if(monster.short == "Ember") {
			//beatEmberSpar();
			loseToEmberSpar()
			return;
		}
		if(monster.short == "farmers") {
			loseToOwca()
			return;
		}
		if(monster.short == "lusty demons") {
			//defeetVapulasHorde();
			loseOrSubmitToVapula();
			return;
		}
		if(monster.short == "Harpy Queen") {
			harpyQueenBeatsUpPCBadEnd();
			return;
		}
		if(monster.short == "phoenix platoon") {
			phoenixPlatoonMurdersPC();
			return;
		}
		if(monster.short == "Brigid the Jailer") {
			pcDefeatedByBrigid();
			return;
		}
		if(monster.short == "harpy horde") {
			pcLosesToHarpyHorde();
			return;
		}
		if(monster.short == "mob of spiders-morphs") {
			loseToSpiderMob();
			return;
		}
		if(monster.short == "Goo Armor") {
			//gooArmorBeatsUpPC();
			if(monster.hasStatusAffect("spar") >= 0) pcWinsValeriaSparDefeat();
			else gooArmorBeatsUpPC();
			return;
		}
		if(monster.short == "Hel" || monster.short == "salamander") {
			if(monster.hasStatusAffect("sparring") >= 0) loseToSparringHeliaLikeAButtRapedChump();
			else loseToSalamander();
			return;
		}
		if(monster.short == "goo-girl") {
			getBeatByGooGirl();
			return;
		}
		if(monster.short == "plain girl") {
			loseToShouldra();
			return;
		}
		if(monster.short == "Kiha") {
			if(monster.hasStatusAffect("spiderfight") >= 0)
				loseKihaPreSpiderFight();
			else if(monster.hasStatusAffect("domfight") >= 0)
				pcLosesDomFight();
			else if(monster.hasStatusAffect("spar") >= 0)
				sparWithFriendlyKihaLose();
			else kihaLossIntro();
			return;
		}
		if(monster.short == "minotaur gang" || monster.short == "minotaur tribe") {
			minotaurDeFeet();
			return;
		}
		if(monster.short == "corrupted drider") {
			loseToDrider();
			return;
		}
		if(monster.short == "basilisk") {
			loseToBasilisk();
			return;
		}
		if(monster.short == "female spider-morph") {
			loseToFemaleSpiderMorph();
			return;
		}
		if(monster.short == "male spider-morph") {
			loseToMaleSpiderMorph();
			return;
		}
		if(monster.short == "Isabella") {
			isabellaDefeats();
			return;
		}
		if(monster.short == "Izma") {
			IzmaWins();
			return;
		}
		if(monster.short == "gnoll spear-thrower") {
			hyenaSpearLossAnal();
			return;
		}
		if(monster.short == "gnoll") {
			if(monster.hasStatusAffect("PhyllaFight") >= 0) {
				monster.removeStatusAffect("PhyllaFight");
				phyllaGnollBeatsPC();
				return;
			}
			getRapedByGnoll();
			return;
		}
		if(monster.short == "Zetaz") {
			loseToZetaz();
			return;
		}
		if(monster.short == "Vala") {
			loseToVala();
			return;
		}
		if(monster.short == "anemone") {
			loseToAnemone();
			return;
		}
		if(monster.short == "imp horde") {
			loseToImpMob();
			return;
		}
		if(monster.short == "Tamani's daughters") {
			loseToDaughters();
			return;
		}
		if(monster.short == "Sophie") {
			if(monster.hasStatusAffect("bimboBrawl") >= 0)
				debimboSophieBeatsYouUp();
			else 
				sophieWonCombat();
			return;
		}
		if(monster.short == "harpy") {
			harpyLossU();
			return;
		}
		if(monster.short == "Ceraph") {
			loseFUCKME();
			return;
		}
		if(monster.short == "worms") {
			outputText("Overcome by your wounds, you sink to your knees as the colony of worms swarms all over your body...\n\n", true);
			infest1();
			return;
		}
		if(monster.short == "Akbal") {
			loseToAckballllllz();
			return;
		}
		if(monster.short == "shark-girl") {
			sharkLossRape();
			return
		}
		if(monster.short == "Marble") {
			eventParser(5095);
			return;
		}
		if(monster.short == "Tamani") {
			if(player.totalCocks() > 0) {
				if(rand(2) == 0) tamaniSexLost();
				else tamaniSexLetHer();
			}
			else {
				outputText("Tamani sighs as you begin to lose conscious, \"<i>You dummy, why'd you get rid of the fun parts?</i>\"", true);
				eventParser(5007);
			}
			return;
		}
		if(monster.short == "naga") {
			nagaFUCKSJOOOOOO();
			return;
		}
		if(monster.short == "tentacle beast") {
			outputText("Overcome by your wounds, you turn to make a last desperate attempt to run...\n\n", false);
			if(monster.hasStatusAffect("PhyllaFight") >= 0) {
				monster.removeStatusAffect("PhyllaFight");
				outputText("...and make it into the nearby tunnel.  ");
				phyllaTentaclePCLoss();
				return;
			}
			eventParser(5074);
			return;
		}
		if(monster.short == "fetish zealot") {
			zealotLossRape();
			return;
		}
		if(monster.short == "imp") {
			if(monster.hasStatusAffect("Kitsune Fight") >= 0) {
				loseKitsuneImpFight();
				return;
			}
			eventParser(5017);
			return;
		}
		if(monster.short == "demons") {
			if(player.gender == 0) {
				outputText("You collapse before the demons, who laugh at your utter lack of male or female endowments, beating you until you pass out.", true);
				eventParser(5007);
				return;
			}
			outputText("The demons finally beat you down and you collapse onto the sand of the oasis. Almost immediately you feel demonic hands pressing and probing your prone form. You hear the leader of the group say something in a strange tongue but you have a feeling you know what it means. The demons dive onto your inert body with intent and begin to press themselves against you...", true);
			doNext(5048);
			return;
		}
		if(monster.short == "minotaur") {
			if(monster.hasStatusAffect("PhyllaFight") >= 0) {
				monster.removeStatusAffect("PhyllaFight");
				phyllaPCLostToMino();
				return;
			}
			eventParser(5031);
			return;
		}
		if(monster.short == "goblin") {
			if(player.gender == 0) {
				outputText("You collapse in front of the goblin, too wounded to fight.  She giggles and takes out a tube of lipstick smearing it whorishly on your face.  You pass into unconsciousness immediately.  It must have been drugged.", false);
				eventParser(5007);
				return;
			}
			eventParser(5089);
			return;
		}
		if(monster.short == "goblin broodmother") {
			urtaLosesToGoblin();
			return;
		}
		if(monster.short == "milky succubus") {
			urtaLosesToCowCubi();
			return;
		}
		if(monster.short == "minotaur lord") {
			if(player.lust > 99) urtaSubmitsToMinotaurBadEnd();
			else urtaLosesToMinotaurRoughVersion();
			return;
		}
		if(monster.short == "alpha gnoll") {
			loseToGnollPrincessAndGetGangBanged();
			return;
		}
		if(monster.short == "Jojo") {
			eventParser(5024);
			return;
		}
		if(monster.short == "bee-girl") {
			eventParser(2058);
			return;
		}
		if(monster.short == "secretarial succubus") {
			eventParser(11024);
			return;
		}
		if(monster.short == "incubus mechanic") {
			eventParser(11038);
			return;
		}
		if(monster.short == "Omnibus Overseer") {
			eventParser(11046);
			return;
		}
		if(monster.short == "green slime") {
			eventParser(5042);
			return;
		}
		if(monster.short == "hellhound") {
			eventParser(5069);
			return;
		}
		if(monster.short == "infested hellhound") {
			infestedHellhoundLossRape();
			return;
		}
		gameState = 0;
		player.HP = 1;
		clearStatuses(false);
		outputText("Your wounds are too great to bear, and you fall unconscious.", true);
		temp = rand(10) + 1;
		if(temp > player.gems) temp = player.gems;
		outputText("\n\nYou'll probably wake up in eight hours or so, missing " + temp + " gems.", false);
		player.gems -= temp;
		doNext(16);
	}
	//Lust Loss
	if(eventNum == 5011) {
		if(monster.skinTone == "helspawn") {
			loseSparringToDaughter();
			return;
		}
		if(monster.short == "Holli") {
			enjoyYourBadEndBIYAAAATCH();
			return;
		}
		if(monster.short == "Sheila") {
			if(flags[SHEILA_DEMON] == 1) loseToSheila();
			else getBeatUpBySheila();
			return;
		}
		if(monster.short == "Sand Mother") {
			loseToTheSandMother();
			return;
		}
		if(monster.short == "Cum Witch") {
			defeatedByCumWitch();
			return;
		}
		if(monster.short == "sand witches") {
			loseToSammitchMob();
			return;
		}
		if(monster.short == "imp lord") {
			loseToAnImpLord();
			return;
		}
		if(monster.short == "Minerva") {
			loseToMinerva();
			return;
		}
		if(monster.short == "Kelt") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nKelt recoils for a moment before assuming a look of superiority...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			keltFucksShitUp();
			return;
		}
		if(monster.short == "goblin broodmother") {
			urtaLosesToGoblin();
			return;
		}
		if(monster.short == "milky succubus") {
			urtaLosesToCowCubi();
			return;
		}
		if(monster.short == "minotaur lord") {
			if(player.lust > 99) urtaSubmitsToMinotaurBadEnd();
			else urtaLosesToMinotaurRoughVersion();
			return;
		}
		if(monster.short == "alpha gnoll") {
			loseToGnollPrincessAndGetGangBanged();
			return;
		}
		if(monster.short == "Sirius, a naga hypnotist") {
			urtaLosesToSirriusSnakeRadio();
			return;
		}
		if(monster.short == "kitsune") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nThe kitsune recoils before running off, no longer interested in you...");
				//eventParser(5007) to end or 5011 to move on.
				eventParser(5007);
				return;
			}
			loseToKitsunes();
			return;
		}
		if(monster.short == "satyr") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nThe satyr laughs heartily at your eagerness...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			loseToSatyr();
			return;
		}
		if(monster.short == "sandtrap" || monster.short == "sand tarp") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nThe sand trap seems bemused by the insects your body houses...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			sandtrapmentLoss(true);
			return;
		}
		if(monster.short == "chameleon girl") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nThe chameleon girl recoils.  \"<i>Ew, gross!</i>\" she screetches as she runs away, leaving you to recover from your defeat alone.");
				//eventParser(5007) to end or 5011 to move on.
				eventParser(5007);
				return;
			}
			loseToChameleonGirl();
			return;
		}
		if(monster.short == "Ember") {
			//beatEmberSpar();
			loseToEmberSpar()
			return;
		}
		if(monster.short == "farmers") {
			loseToOwca()
			return;
		}
		if(monster.short == "lusty demons") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nThe demons smile to one at another as they watch your display, then close in...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			//defeetVapulasHorde();
			loseOrSubmitToVapula();
			return;
		}
		if(monster.short == "Harpy Queen") {
			harpyQueenBeatsUpPCBadEnd();
			return;
		}
		if(monster.short == "phoenix platoon") {
			phoenixPlatoonMurdersPC();
			return;
		}
		if(monster.short == "Brigid the Jailer") {
			pcDefeatedByBrigid();
			return;
		}
		if(monster.short == "harpy horde") {
			pcLosesToHarpyHorde();
			return;
		}
		if(monster.short == "mob of spiders-morphs") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nThe spiders smile to one at another as they watch your display, then close in...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			loseToSpiderMob();
			return;
		}
		if(monster.short == "Goo Armor") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nThe armored goo sighs while you exhaust yourself...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			//gooArmorBeatsUpPC();
			if(monster.hasStatusAffect("spar") >= 0) pcWinsValeriaSparDefeat();
			else gooArmorBeatsUpPC();
			return;
		}
		if(monster.short == "Hel" || monster.short == "salamander") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nHelia waits it out in stoic silence...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			if(monster.hasStatusAffect("sparring") >= 0) loseToSparringHeliaLikeAButtRapedChump();
			else loseToSalamander();
			return;
		}
		if(monster.short == "goo-girl") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nThe goo-girl seems confused but doesn't mind.");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			getBeatByGooGirl();
			return;
		}
		if(monster.short == "plain girl") {
			loseToShouldra();
			return;
		}
		if(monster.short == "Kiha") {
			if(monster.hasStatusAffect("spiderfight") >= 0)
				loseKihaPreSpiderFight();
			else if(monster.hasStatusAffect("domfight") >= 0)
				pcLosesDomFight();
			else if(monster.hasStatusAffect("spar") >= 0)
				sparWithFriendlyKihaLose();
			else {
				if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
					flags[CAME_WORMS_AFTER_COMBAT] = 1;
					infestOrgasm();
					//Mob reaction
					outputText("\n\nKiha seems visibly disturbed by your infection, enough that she turns to leave.");
					//eventParser(5007) to end or 5011 to move on.
					doNext(5011);
					return;
				}
				kihaLossIntro();
			}
			return;
		}
		if(monster.short == "minotaur gang" || monster.short == "minotaur tribe") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nThe minutaurs share a laugh while you cum, but their throbbing erections don't subside in the slightest.");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			minotaurDeFeet();
			return;
		}
		if(monster.short == "corrupted drider") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nThe drider licks her lips in anticipation...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			loseToDrider();
			return;
		}
		if(monster.short == "basilisk") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nThe basilisk smirks, but waits for you to finish...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			loseToBasilisk();
			return;
		}
		if(monster.short == "male spider-morph") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nThe spider flashes a predatory grin while he waits it out...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			loseToMaleSpiderMorph();
			return;
		}
		if(monster.short == "female spider-morph") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nThe spider flashes a predatory grin while she waits it out...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			loseToFemaleSpiderMorph();
			return;
		}
		if(monster.short == "Isabella") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\n\"<i>Ick,</i>\" Isabella tuts as she turns to leave...");
				//eventParser(5007) to end or 5011 to move on.
				eventParser(5007);
				return;
			}
			isabellaDefeats();
			return;
		}
		if(monster.short == "Izma") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\n\"<i>Gross!</i>\" Izma cries as she backs away, leaving you to recover alone.");
				//eventParser(5007) to end or 5011 to move on.
				eventParser(5007);
				return;
			}
			IzmaWins();
			return;
		}
		if(monster.short == "gnoll spear-thrower") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nYour foe doesn't seem put off enough to leave...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			hyenaSpearLossAnal();
			return;
		}
		if(monster.short == "gnoll") {
			if(monster.hasStatusAffect("PhyllaFight") >= 0) {
				monster.removeStatusAffect("PhyllaFight");
				phyllaGnollBeatsPC();
				return;
			}
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nYour foe doesn't seem put off enough to leave...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			getRapedByGnoll();
			return;
		}
		if(monster.short == "Zetaz") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nYour foe doesn't seem put off enough to care...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			loseToZetaz();
			return;
		}
		if(monster.short == "Vala") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nYour foe doesn't seem put off enough to leave...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			loseToVala();
			return;
		}
		if(monster.short == "anemone") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nYour foe doesn't seem to mind at all...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			loseToAnemone();
			return;
		}
		if(monster.short == "imp horde") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nYour foes don't seem put off enough to leave...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			loseToImpMob();
			return;
		}
		if(monster.short == "Tamani's daughters") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nYour foes seem visibly disgusted and leave, telling you to, \"<i>quit being so fucking gross...</i>\"");
				//eventParser(5007) to end or 5011 to move on.
				eventParser(5007);
				return;
			}
			loseToDaughters();
			return;
		}
		if(monster.short == "Sophie") {
			if(monster.hasStatusAffect("bimboBrawl") >= 0)
				debimboSophieBeatsYouUp();
			else { 
				if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
					flags[CAME_WORMS_AFTER_COMBAT] = 1;
					infestOrgasm();
					//Mob reaction
					outputText("\n\nYour foe seems disgusted by the display and leaves you to recover alone...");
					//eventParser(5007) to end or 5011 to move on.
					eventParser(5007);
					return;
				}
				sophieWonCombat();
			}
			return;
		}
		if(monster.short == "harpy") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nYour foe doesn't seem disgusted enough to leave...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			harpyLossU();
			return;
		}
		if(monster.short == "Ceraph") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nYour foe doesn't seem disgusted enough to leave...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			loseFUCKME();
			return;
		}
		if(monster.short == "imp") {
			if(monster.hasStatusAffect("Kitsune Fight") >= 0) {
				loseKitsuneImpFight();
				return;
			}
			if(player.hasStatusAffect("infested") >= 0) {
				infestOrgasm();
				outputText("\n\nThe imp grins at your already corrupted state...", false);
				stats(0,0,0,0,0,0,-100,0);
				player.lust = 100;
				doNext(5017);
				return;
			}
			eventParser(5017);
			return;
		}
		if(monster.short == "Akbal") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nYour foe doesn't seem disgusted enough to leave...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			loseToAckballllllz();
			return;
		}
		if(monster.short == "fetish zealot") {
			if(player.hasStatusAffect("infested") >= 0) {
				infestOrgasm();
				outputText("\n\nThe fetish cultist ignores the perverse display and continues on as if nothing had happened...", false);
				stats(0,0,0,0,0,0,-100,0);
				doNext(5106);
				return;
			}
			zealotLossRape();
			return;
		}
		if(monster.short == "shark-girl") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nYour foe doesn't seem disgusted enough to leave...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			sharkLossRape();
			return
		}
		if(monster.short == "Tamani") {
			if(player.totalCocks() > 0) {
				//hypnoslut loss scene
				if(flags[UNKNOWN_FLAG_NUMBER_00056] > 19 && rand(2) == 0) {
					getRapedByTamaniYouHypnoSlut();
					return;
				}
				if(rand(2) == 0) tamaniSexLost();
				else tamaniSexLetHer();
			}
			else {
				outputText("You give into your lusts and masturbate, but Tamani doesn't seem to care.  She kicks and punches you over and over, screaming, \"<i>You dummy, why'd you get rid of the fun parts?</i>\"", true);
				takeDamage(10000);
				eventParser(5007);
			}
			return;
		}
		if(monster.short == "Marble") {
			eventParser(5095);
			return;
		}
		if(monster.short == "naga") {
			if(player.hasStatusAffect("infested") >= 0) {
				infestOrgasm();
				outputText("\n\nThe naga's eyes go wide and she turns to leave, no longer interested in you.", false);
				stats(0,0,0,0,0,0,-100,0);
				doNext(5007);
				return;
			}
			nagaFUCKSJOOOOOO();
			return;
		}
		if(monster.short == "goblin") {
			if(player.gender == 0) {
				outputText("You collapse in front of the goblin, too wounded to fight.  She giggles and takes out a tube of lipstick smearing it whorishly on your face.  You pass into unconsciousness immediately.  It must have been drugged.", false);
				eventParser(5007);
				return;
			}
			if(player.hasStatusAffect("infested") >= 0) {
				infestOrgasm();
				outputText("\n\nThe goblin's eyes go wide and she turns to leave, no longer interested in you.", false);
				stats(0,0,0,0,0,0,-100,0);
				doNext(5007);
				return;
			}
			eventParser(5089);
			return;
		}
		if(monster.short == "hellhound") {
			if(player.hasStatusAffect("infested") >= 0) {
				infestOrgasm();
				outputText("\n\nThe hellhound snorts and leaves you to your fate.", false);
				stats(0,0,0,0,0,0,-100,0);
				doNext(5007);
				return;
			}
			eventParser(5069);
			return;
		}
		if(monster.short == "infested hellhound") {
			if(player.hasStatusAffect("infested") >= 0) {
				infestOrgasm();
				outputText("\n\nThe infested hellhound's heads both grin happily as it advances towards you...", false);
				stats(0,0,0,0,0,0,-100,0);
				doNext(5108);
				return;
			}
			eventParser(5108);
			return;
		}
		if(monster.short == "tentacle beast") {
			outputText("You give up on fighting, too aroused to resist any longer.  Shrugging, you walk into the writhing mass...\n\n", false);
			if(monster.hasStatusAffect("PhyllaFight") >= 0) {
				monster.removeStatusAffect("PhyllaFight");
				outputText("...but an insistent voice rouses you from your stupor.  You manage to run into a nearby tunnel.  ");
				phyllaTentaclePCLoss();
				return;
			}
			doNext(5074);
			return;
		}
		if(monster.short == "secretarial succubus") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nYour foe doesn't seem to care...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			eventParser(11024);
			return;
		}
		if(monster.short == "incubus mechanic") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nYour foe doesn't seem to care...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			eventParser(11038);
			return;
		}
		if(monster.short == "Omnibus Overseer") {
			if(player.hasStatusAffect("infested") >= 0 && flags[CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[CAME_WORMS_AFTER_COMBAT] = 1;
				infestOrgasm();
				//Mob reaction
				outputText("\n\nYour foe doesn't seem to care...");
				//eventParser(5007) to end or 5011 to move on.
				doNext(5011);
				return;
			}
			eventParser(11046);
			return;
		}
		if(monster.short == "worms") {
			outputText("Overcome by your lust, you sink to your knees as the colony of worms swarms all over your body...\n\n", true);
			infest1();
			return;
		}
		if(monster.short == "sand witch") {
			if(player.hasStatusAffect("infested") >= 0) {
				infestOrgasm();
				outputText("\n\nThe witch blanches and backs away, leaving you to your fate.", false);
				stats(0,0,0,0,0,0,-100,0);
				eventParser(5007);
				return;
			}
			sandwitchRape();
			return;
		}
		if(monster.short == "demons") {
			if(player.gender == 0) {
				outputText("You offer yourself to the demons, who promptly begin laughing at your lack of endowments.  They fall on you as one, beating you into unconsciousness.", true);
				eventParser(5007);
				return;
			}
			outputText("You struggle to keep your mind on the fight and fail to do so. ", true);
			if(player.hasStatusAffect("infested") >= 0) {
				infestOrgasm();
				stats(0,0,0,0,0,0,-100,0);
				outputText("\n\nThe demons joke and smile, obviously unconcerned with your state.\n\n", false);
			}
			if(player.cocks.length > 0) {
				if(player.cockTotal() > 1) outputText("Each of y", false);
				else outputText("Y", false);
				outputText("our " + multiCockDescriptLight() + " throbs ", false);
				if(player.hasVagina()) outputText(" and your ", false);
			}
			if(player.vaginas.length > 0) {
				if(!player.hasCock()) outputText("Your ", false);
				outputText(vaginaDescript(0) + " burns ", false);
			}
			outputText("with arousal.  You make a grab for the nearest demon and catch a handful of jiggly breast. You try desperately to use your other arm to pull her closer to slake your thirst but you both go tumbling to the ground. The demonic leader laughs out loud and the rest of the tribe falls on you, grabbing for anything it can find.", false);
			doNext(5048);
			return;
		}
		//FETISH CULTIST
		if(monster.short == "fetish cultist") {
			outputText("", true);
			if(player.hasStatusAffect("infested") >= 0) {
				infestOrgasm();
				outputText("\n\nThe cultist giggles as she watches you struggling.\n\n", false);
				stats(0,0,0,0,0,0,-100,0);
				//Go on with rape
			}
			cultistRapesYou();
			return;
		}
		if(monster.short == "minotaur") {
			if(monster.hasStatusAffect("PhyllaFight") >= 0) {
				monster.removeStatusAffect("PhyllaFight");
				phyllaPCLostToMino();
				return;
			}
			if(player.hasStatusAffect("infested") >= 0) {
				infestOrgasm();
				stats(0,0,0,0,0,0,-100,0);
				outputText("\n\nThe minotaur picks you up and forcibly tosses you from his cave, grunting in displeasure.", false);
				eventParser(5007);
				return;
			}
			eventParser(5031);
			return;
		}
		if(monster.short == "Jojo") {
			eventParser(5024);
			return;
		}
		if(monster.short == "bee-girl") {
			if(player.hasStatusAffect("infested") >= 0) {
				infestOrgasm();
				stats(0,0,0,0,0,0,-100,0);
				outputText("\n\nThe bee-girl goes white and backs away with a disgusted look on her face.\n\n", false);
				eventParser(5007);
				return;
			}
			eventParser(2058);
			return;
		}
		if(monster.short == "green slime") {
			if(player.hasStatusAffect("infested") >= 0) {
				infestOrgasm();
				stats(0,0,0,0,0,0,-100,0);
				outputText("\n\nThe slime doesn't even seem to notice.\n\n", false);
				doNext(5042);
				return;
			}
			eventParser(5042);
			return;
		}
		gameState = 0;
		clearStatuses(false);
		outputText("Your desire reaches uncontrollable levels, and you begin openly masturbating.\n\nThe lust and pleasure cause you to black out for hours on end.", true);
		temp = rand(10) + 1;
		if(temp > player.gems) temp = player.gems;
		outputText("\n\nYou'll probably come to your senses in eight hours or so, missing " + temp + " gems.", false);
		player.lust = 0;
		player.gems -= temp;
		doNext(16);
	}
	//Attack
	if(eventNum == 5012) {
		outputText("", true);
		attack();
	}
	//FUCK
	if(eventNum == 5013) {
		
	}
	//Oral
	if(eventNum == 5014) {
		
	}
	//Handjob
	if(eventNum == 5015) {
		
	}
	//Run from Grapple
	if(eventNum == 5016) {
		
	}
	//Lost to imp, get raaaaeeeped
	if(eventNum == 5017) {
		impRapesYou();
	}
	//You win via lust.  RAEEEEEP IMP
	if(eventNum == 5018) {
		rapeImpWithDick();
	}
	//Imp lust magic lust attack
	if(eventNum == 5019) {
		outputText("You see " + monster.a + monster.short + " make sudden arcane gestures at you!\n\n", false);
		stats(0,0,0,0,0,0,player.lib/10+player.cor/10+10,0);
		if(player.lust < 30) outputText("You feel strangely warm.  ", false);
		if(player.lust >= 30 && player.lust < 60) outputText("Blood rushes to your groin as a surge of arousal hits you, making your knees weak.  ", false);
		if(player.lust >= 60) outputText("Images of yourself fellating and fucking the imp assault your mind, unnaturally arousing you.  ", false);
		if(player.cocks.length > 0) {
			if(player.lust >= 60 && player.cocks.length > 0) outputText("You feel your " + multiCockDescriptLight() + " dribble pre-cum.", false);
			if(player.lust >= 30 && player.lust < 60 && player.cocks.length == 1) outputText("Your " + cockDescript(0) + " hardens, distracting you further.", false);
			if(player.lust >= 30 && player.lust < 60 && player.cocks.length > 1) outputText("Your " + multiCockDescriptLight() + " harden uncomfortably.", false);
			if(player.hasVagina()) outputText("  ", false);
		}
		if(player.vaginas.length > 0) {
			if(player.lust >= 60 && player.vaginas[0].vaginalWetness == 1 && player.vaginas.length == 1) outputText("Your " + allVaginaDescript() + " dampens perceptibly.", false);
			if(player.lust >= 60 && player.vaginas[0].vaginalWetness == 1 && player.vaginas.length > 1) outputText("Your " + allVaginaDescript() + " dampen perceptibly.", false);
			if(player.lust >= 60 && player.vaginas[0].vaginalWetness == 2 && player.vaginas.length > 0) outputText("Your crotch becomes sticky with girl-lust.", false);
			if(player.lust >= 60 && player.vaginas[0].vaginalWetness == 3 && player.vaginas.length == 1) outputText("Your " + allVaginaDescript() + " becomes sloppy and wet.", false);
			if(player.lust >= 60 && player.vaginas[0].vaginalWetness == 3 && player.vaginas.length > 1) outputText("Your " + allVaginaDescript() + " become sloppy and wet.", false);
			if(player.lust >= 60 && player.vaginas[0].vaginalWetness == 4 && player.vaginas.length > 0) outputText("Thick runners of girl-lube stream down the insides of your thighs.", false);
			if(player.lust >= 60 && player.vaginas[0].vaginalWetness == 5 && player.vaginas.length == 1) outputText("Your " + allVaginaDescript() + " instantly soaks your groin.", false);
			if(player.lust >= 60 && player.vaginas[0].vaginalWetness == 5 && player.vaginas.length > 1) outputText("Your " + allVaginaDescript() + " instantly soak your groin.", false);
		}
		outputText("\n", false);
		if(player.lust > 99) doNext(5011)
		else doNext(1);
	}
	//Sand which lust magic attack
	if(eventNum == 5020) {
		outputText("The sand witch points at you, drawing a circle in the air and mouthing strange words.\n\n", false);
		if(player.hasStatusAffect("Stone Lust") >= 0) {
			outputText("The orb inside you grows warm, almost hot, suffusing your body with heat and arousal.  ", false);
			stats(0, 0, 0, 0, 0, 0, 8 + int(player.sens)/10, 0);
		}
		else {
			outputText("You feel the sands shift by your " + player.feet() + ", and look down to see something slip out of the sands and into your clothes!  It feels incredibly smooth and circular as it glides upward along your " + player.leg() + ", its progress unaffected by your frantic effort to dislodge it.  ", false);
			if(player.vaginas.length > 0) outputText("It glides up your thighs to the entrance of your sex, and its intentions dawn on you!\n\nToo late! You reach to stop it, but it pushes against your lips and slips inside your " + vaginaDescript(0) + " in an instant.  You groan in frustration as it begins pulsing and vibrating, sometimes even seeming to change size.", false);
			else outputText("It glides up your thighs, curving around your buttocks, and its intentions dawn on you.\n\nYou desperately grab for it, but are too late!  It pushes firmly against your rectum and slips inside instantaneously.  You groan in frustration as it begins pulsing and vibrating, sometimes even seeming to change size.", false);
			player.createStatusAffect("Stone Lust", 0, 0, 0, 0);
			stats(0, 0, 0, 0, 0, 0, 4 + int(player.sens)/10, 0);
		}
		doNext(1);
	}
	//Jojo Special - Self-Corruption
	if(eventNum == 5021) {
		if(monk == 2) {
			outputText("Jojo looks lost in thought for a moment, and fails to attack.  ", false);
			monster.lust += 4;
		}
		if(monk == 3) {
			outputText("Jojo blushes as he fights you, distracted by a stray thought.  You think you see a bulge in the loose cloth of his pants.  ", false);
			monster.lust += 8;
		}
		if(monk == 4) {
			outputText("Jojo stumbles, shakes his head, and pulls one of his hands away from the stiff tent in his pants.  ", false);
			monster.lust += 10;
		}
		if(monk == 5) {
			outputText("Jojo frantically jerks his " + eCockDescript(0) + ", stroking the " + eCockDescript(0) + " as it leaks pre-cum at the sight of you.  ", false);
			monster.lust += 15;
		}
		if(monster.lust > 50 && monster.lust < 60) outputText("The mouse's skin remains flushed with the beginnings of arousal.  ", false);
		if(monster.lust >= 60 && monster.lust < 70) outputText("The mouse's eyes constantly dart over your most sexual parts, betraying his lust.  ", false);
		if(monster.lust >= 70 && monster.lust < 85) outputText("The mouse is having trouble moving due to the rigid protrusion from his groin.  ", false);
		if(monster.lust >= 85) outputText("The mouse is panting and softly whining, each movement seeming to make his bulge more pronounced.  You don't think he can hold out much longer.  ", false);
		if(monster.lust >= 100) doNext(5009);
		else doNext(1);
	}
	//Jojo loses via lust
	if(eventNum == 5022) {
		outputText("  You disrobe and prepare to ", false);
		if(monk == 5) outputText("fuck your violent little slut senseless.  ", false);
		else outputText("teach the uppity monk a lesson...\n\n", false);
		doNext(5023);
	}
	//Monk RAEP
	if(eventNum == 5023) {
		jojoRape();
		eventParser(5007);
	}
	//Lose to Jojo
	if(eventNum == 5024) {
		if(monk == 2 || monk == 3)
		{
			outputText("Jojo glares down at you, and begins praying, slowly laying prayer papers all over your battered form.  You feel rage that quickly dissipates, replaced with a calm sense of peace.  You quickly lose consciousness, but are happy he defeated you.\n\nWhen you wake, you discover a note:\n\"<i>The fighting allowed me to exorcise most of your inner demons.  A part of me wanted to seek revenge for what you had done to me, but I know it was the taint on your soul that was responsible.  If we meet again I would be happy to meditate with you.\n\n          -Jojo.</i>\"", true);
			stats(0,0,0,0,-10,0,-100,-15);
			if(player.lib < 10) {
				player.lib = 0;
				stats(0,0,0,0,15,0,0,0);
			}
			if(player.cockTotal() == 1) player.lib = 15;
			if(player.vaginas.length == 1) player.lib += 10;
			if(player.cockTotal() > 1) player.lib +=5;
			if(player.horseCocks() > 0) player.lib += 3;
			if(player.dogCocks() > 0) player.lib += 2;
			if(player.biggestLactation() >= 1) player.lib += 2;
			monk = 0;
		}
		else {
			outputText("Jojo grins wickedly as he senses your defeat, " + eCockDescript(0) + " throbbing hard.  ", true);
			if(player.lust >= 100) {
				if(player.gender == 1) {
					outputText("Too aroused to think, you just bend over, displaying your bum and letting your " + multiCockDescriptLight() + " dangle freely.  The mouse doesn't hesitate, and he thrusts his " + eCockDescript(0) + " with painful force.  You stagger from the size and struggle to stay conscious as he fucks you like a mad beast, hammering your ass with incredible force.  ", false);
					if(player.cockTotal() == 1) outputText("Pre and cum drip from your " + cockDescript(0) + ", forced out of your prostate by the rough beating it's taking.  You feel a flash of warm wetness inside you, and realize Jojo is cumming.  A sense of relief washes over you as the last burst of cum squirts out from your cheeks, only to be replaced with a dawning sense of horror as he continues fucking you harder than ever.\n\nYou black out after a few dozen of his orgasms and one or two of your own, your gut painfully distended with semen.", false);
					if(player.cockTotal() > 1) outputText("Pre and cum drip from your " + cockDescript(0) + "s, forced out of your prostate by the rough beating it's taking.  You feel a flash of warm wetness inside you, and realize Jojo is cumming.  A sense of relief washes over you as the last burst of cum squirts out from your cheeks, only to be replaced with a dawning sense of horror as he continues fucking you harder than ever.\n\nYou black out after a few dozen of his orgasms and one or two of your own, your gut painfully distended with semen.", false);
					buttChange(monster.cockArea(0), true);
				}
				if(player.gender >=  2) {
					outputText("Too aroused to think, you bend over, displaying your bum and " + vaginaDescript(0) + " to Jojo as open targets.  The mouse obliges, plunging himself into you, hard.  He fucks you with abandon, pounding your wanton little pussy with no regard for your pleasure.  Despite yourself, you enjoy the rough treatment.  A spasm of warmth erupts inside you as Jojo cums.  You worry he might stop, but as the mouse's orgasm ends he resumes fucking with even greater energy. You cum powerfully, his jizz seeping down your thighs as you begin lose track of yourself.  ", false);
					if(player.cockTotal() > 1) outputText("Your " + cockDescript(0) + " splatters the ground with cum repeatedly, until both your genders are raw and sore.  ", false);
					else outputText("Your " + vaginaDescript(0) + " cums on him many more times it until it is sore and tender, dripping with spunk.  ", false);
					outputText("You black out as Jojo cums AGAIN, forcing a river of spunk from your already over-filled uterus.", false);
					cuntChange(monster.cocks[0].cockThickness, true);
					//Preggers chance!
					player.knockUp(4,432,101);
				}
				if(player.gender == 0) {
					outputText("Too aroused to think, you just bend over, displaying your bum and wiggling enticingly.  The mouse doesn't hesitate, and he thrusts his " + eCockDescript(0) + " with painful force.  You stagger from the size and struggle to stay conscious as he fucks you like a mad beast, hammering your ass with incredible force.  ", false);
					outputText("You feel a flash of warm wetness inside you, and realize Jojo is cumming.  A sense of relief washes over you as the last burst of cum squirts out from your cheeks, only to be replaced with a dawning sense of horror as he continues fucking you harder than ever.\n\nYou black out after a few dozen of his orgasms and one or two of your own, your gut painfully distended with semen.", false);
				}
				slimeFeed();
				hideUpDown();
				stats(0,0,0,0,0,0,-100,1);
				statScreenRefresh();
			}
			//HP Defeat
			else {
				outputText("You black out from the pain of your injuries.\n\n", false);
				statScreenRefresh();
			}
		}		
		eventParser(5007);
	}
	//Sand witch bad end
	//GAME OVERS
	if(eventNum == 5025) {
		outputText("<b>GAME OVER</b>", true);
		if(flags[EASY_MODE_ENABLE_FLAG] == 1 || debug) simpleChoices("Game Over", 9999, "",0,"NewGamePlus",10035,"",0,"CHEAT", 1);
		else simpleChoices("Game Over", 9999, "Blah", 0, "NewGamePlus",10035, "BLAH", 0, "LULZ", 0);
		dataBG.visible = true;
		dataText.visible = true;
		appearanceText.visible = false;
		appearanceBG.visible = false;
		levelText2.visible = false;
		levelBG.visible = false;
		perksText.visible = false;
		perksBG.visible = false;
		gameState = 0;
		inDungeon = false;
	}
	//Soft Game Over - for when you want to leave the text on-screen
	if(eventNum == 5035) {
		outputText("\n\n<b>GAME OVER</b>", false);
		if(flags[EASY_MODE_ENABLE_FLAG] == 1 || debug) simpleChoices("Game Over", 9999, "",0,"NewGamePlus",10035,"",0,"Debug Cheat", 1);
		else simpleChoices("Game Over", 9999, "Blah", 0, "NewGamePlus", 10035, "BLAH", 0, "LULZ", 0);
		dataBG.visible = true;
		dataText.visible = true;
		appearanceText.visible = false;
		appearanceBG.visible = false;
		levelText2.visible = false;
		levelBG.visible = false;
		perksText.visible = false;
		perksBG.visible = false;
		gameState = 0;
		inDungeon = false;
	}
	//Sand which(lol) end Pt 1
	if(eventNum == 5026)
	{
		outputText("You awaken in a candlelit stone shrine of some sort, resting naked and facedown on some warm, comfortable body pillows. Remembering your fight against the witch, you hurriedly try to get up, only to gasp with surprise when a painful weight pulls on your chest. Glancing down to find the source of the weight, you blink with shock, then fight rising panic – the \"pillows\" that you are lying on are your own breasts, swollen to such a size that you cannot possibly lift them!\n\n", true);
		outputText("\"<i>Hello, my beautiful pet,</i>\" says a familiar voice. Looking to your front – and trying not to notice the vast expanse of cleavage that dominates the lower half of your vision – you see the Sand Witch sitting, nude, in a large granite basin set into the floor just in front of you. She smirks when she sees how your eyes avoid resting on your obscenely massive bust.\n\n", false);
		outputText("\"<i>What's wrong? Don't you like them?</i>\" The witch leans toward you and roughly tugs on one huge nipple, causing you to yelp with surprise and pleasure. \"<i>I'm afraid that's too bad. You offered yourself to me, and now you are mine, all mine, forever.</i>\" She slowly rubs her hands over your colossal bosom, crooning with approval as you squirm and bite your lip. \"<i>Mmm, yes... first, you will give me a bath.</i>\"\n\nYou hardly have time to wonder what she means before a familiar, hugely intense pressure builds in your chest...", false);
		doNext(5027);
	}
	//Sand which(lol) end Pt 2
	if(eventNum == 5027) {
		outputText("With an audible gurgling noise, your breasts begin to fill with prodigious quantities of milk. Your eyes widen in amazement when you feel your tits swelling, filling, pumping up to their limits. It feels shockingly pleasurable and somehow almost right, like you were meant to have these shamefully huge, milk-filled titties. As you watch the soft flesh stretch taut, your breasts fatten into a very round shape beneath you, and the pleasurable sensation becomes a painful feeling of urgency.\n\n", true);
		outputText("For a moment nothing happens, and you are surprised that your nipples are not leaking milk. The Sand Witch smiles at you, leaning to rest her arms and chin on your overstressed tits, and speaks: \"<i>Ask to be milked, slave.</i>\" Appalled, you shake your head, then grit your teeth and moan as you realize that the pressure in your chest is still building up, becoming unbearably painful. The witch patiently repeats herself, staring directly into your eyes, and you are struck by the awful knowledge that you are likely to be trapped here forever.", false);
		doNext(5028);
	}
	//Sand witch bad-end Pt3
	if(eventNum == 5028) {
		outputText("Something breaks within your soul, accompanied by a strangled sob. Tears of humiliation trickle down your face as you part your quivering lips. \"<i>Please milk me, Mistress. Your slave needs to be milked.</i>\"\n\n", false);
		if(player.hasPerk("Marble's Milk") >= 0) {
			outputText("No sooner have you spoken before a torrent of milk spurts from each of your nipples, but the effect isn't as pleasurable as it used to be; in fact you're starting to feel very weak.  The Sand Witch looks at you in confusion as the stream of milk from your massive breasts quickly slows and your breasts start to shrivel up.\n\n", false);
			outputText("Trying to figure out why you feel so incredibly weak, you think back on what might have caused this.  When was the last time you had some of Marble's milk?  Feeling your body start to wither away, the realization hits you.  You chuckle softly at your captor as the world starts to go dark; looks like you'll be the one to have the last laugh...\n\n", false);
			outputText("The last thing you hear is the Sand Witch screaming \"<i>What the hell is going on?  I ALWAYS get what I want!</i>\"", false);
		}
		else {
			outputText("No sooner have you spoken than a huge torrent of milk spurts from each of your nipples. Between the sudden alleviation of your pain and the sensitivity of your nipples, you orgasm almost instantly with a huge groan of relief. When you can focus your eyes again, you see that the Sand Witch... your new Mistress... is bathing languidly in the basin, relaxing in a pool of your fresh breastmilk.\n\n", false);
			outputText("The dusky-skinned witch catches your eye and smiles, this time more warmly than before. \"<i>See? You'll enjoy yourself more if you obey your Mistress. After all, I <b>ALWAYS</b> get what I want...</i>\"\n\nAs much as you hate to admit it, you realize that she's right. You're trapped here on top of your bloated bust, at the mercy of this perverse spellcaster. She has all the time in the world to train you, and between the pain of overfilled breasts and the orgasmic joy of being drained, it won't take her long to turn you into a perfectly obedient, even eager, milk-slave...", false);
		}
		doNext(5025);
	}
	//Mino special pheromone attack.
	if(eventNum == 5029) {
		minoPheromones();
	}
	//Rape minotaur
	if(eventNum == 5030) {
		//minoRape();
		eventParser(5007);
	}
	//Get raped by minotaur 
	if(eventNum == 5031) {
		getRapedByMinotaur();
	}

	//Sand witch gets raped
	if(eventNum == 5032) {
		sandwitchRaped();
	}
	//Bewbage rape
	if(eventNum == 5033) {
		sandwitchBewbs();
	}
	//Fucky rape
	if(eventNum == 5034) {
		sandwitchSex();
	}
	//Bee Sting Attack
	if(eventNum == 5036) {
		//Blind dodge change
		if(monster.hasStatusAffect("Blind") >= 0) {
			outputText(monster.capitalA + monster.short + " completely misses you with a blind sting!!", false);
			combatRoundOver();
			return;
		}
		//Determine if dodged!
		if(player.spe - monster.spe > 0 && int(Math.random()*(((player.spe-monster.spe)/4)+80)) > 80) {
			if(player.spe - monster.spe < 8) outputText("You narrowly avoid " + monster.a + monster.short + "'s stinger!", false);
			if(player.spe - monster.spe >= 8 && player.spe-monster.spe < 20) outputText("You dodge " + monster.a + monster.short + "'s stinger with superior quickness!", false);
			if(player.spe - monster.spe >= 20) outputText("You deftly avoid " + monster.a + monster.short + "'s slow attempts to sting you.", false);
			combatRoundOver();
			return;
		}
		//determine if avoided with armor.
		if(player.armorDef >= 10 && rand(4) > 0) {
			outputText("Despite her best efforts, " + monster.a + monster.short + "'s sting attack can't penetrate your armor.", false);
			combatRoundOver();
			return;
		}
		//Sting successful!  Paralize or lust?
		//Lust 50% of the time
		if(rand(2) == 0) {
			outputText("Searing pain lances through you as " + monster.a + monster.short + " manages to sting you!  You stagger back a step and nearly trip, flushing hotly.  ", false);
			outputText("Oh no!  You've been injected with some kind of aphrodisiac.  You've got to keep focused, you can't think about... fucking... ", false);
			if(player.gender == 1) outputText("or dripping honey-slicked cunts beckoning you. ", false);
			if(player.gender == 2) outputText("planting your aching sex over her face while you lick her sweet honeypot. ", false);
			if(player.gender == 3) outputText("or cocks, tits, and puffy nipples. ", false);
			stats(0,0,0,0,0,0,25,0);
			if(player.lust > 60) {
				outputText(" You shake your head and struggle to stay focused,", false);
				if(player.gender == 1 || player.gender == 3) outputText(" but it's difficult with the sensitive bulge in your groin.", false);
				if(player.gender == 2) outputText(" but can't ignore the soaking wetness in your groin.", false);
				if(player.sens > 50) outputText("  The sensitive nubs of your nipples rub tightly under your " + player.armorName + ".", false);
			}
			else outputText(" You shake your head and clear the thoughts from your head, focusing on the task at hand.", false);
			if(player.hasStatusAffect("lust venom") < 0) player.createStatusAffect("lust venom", 0, 0, 0, 0);
		}
		//Paralise the other 50%!
		else {
			outputText("Searing pain lances through you as " + monster.a + monster.short + " manages to sting you!  You stagger back a step and nearly trip, finding it hard to move yourself.", false);
			//v1 - strenght penalty, v2 speed penalty
			if(player.hasStatusAffect("paralyze venom") >= 0) {
				temp = player.hasStatusAffect("paralyze venom");
				player.statusAffects[temp].value1 += 2.9;
				player.statusAffects[temp].value2 += 2.9;
				stats(-3,0,-3,0,0,0,0,0);
				outputText("  It's getting much harder to move, you're not sure how many more stings like that you can take!", false);
			}
			else {
				player.createStatusAffect("paralyze venom", 2, 2, 0, 0);
				stats(-2,0,-2,0,0,0,0,0);
				outputText("  You've fallen prey to paralyzation venom!  Better end this quick!", false);
			}
		}
		if(player.lust >= 100) doNext(5011);
		else doNext(5000);
	}
	//Player sting attack
	if(eventNum == 5037) {
		//Keep logic sane if this attack brings victory
		menuLoc = 0;
		if(player.tailVenom < 33) {
			outputText("You do not have enough venom to sting right now!", true);
			doNext(5161);
			return;
		}
		//Worms are immune!
		if(monster.short == "worms") {
			outputText("Taking advantage of your new natural weapons, you quickly thrust your stinger at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving you to stab only at air.\n\n", true);
			enemyAI();
			return;
		}
		playerStinger();
	}
	//Gore attack
	if(eventNum == 5038) {
		//Keep logic sane if this attack brings victory
		menuLoc = 0;
		if(monster.short == "worms") {
			outputText("Taking advantage of your new natural weapons, you quickly charge at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving your horns to stab only at air.\n\n", true);
			enemyAI();
			return;
		}
		goreAttack();
	}
	//Green Slime Lust attack!
	if(eventNum == 5039) {
		outputText("The creature surges forward slowly with a swing that you easily manage to avoid.  You notice traces of green liquid spurt from the creature as it does, forming a thin mist that makes your skin tingle with excitement when you inhale it.", false);
		stats(0,0,0,0,0,0,player.lib/10 + 8,0);
		doNext(1);
	}
	//Green Slime Lust lossssss!
	if(eventNum == 5040) {
		outputText("The creature collapses backwards as its cohesion begins to give out, and the faint outline of eyes and a mouth form on its face.  Its chest heaves as if it were gasping, and the bolt upright erection it sports visibly quivers and pulses before relaxing slightly.", false);
		monster.lust -= 13;
		doNext(1);
	}
	//Victory Sex (Slime)
	if(eventNum == 5041) {
		//Service for lower corruption
		if(player.cor <= 33) {
			outputText("", true);
			if(player.lust < 60) serviceLowCorruption();
			else serviceLowCorruptionHighLust();
		}
		//higher corruption raaaaeeeep
		else
		{
			outputText("", true);
			//male or futa
			if(player.gender == 1 || (player.gender == 3 && rand(2) == 0)) maleRapesOoze();
			//female or futa
			else if(player.gender > 0) femaleRapesOoze();
		}
		eventParser(5007);
		return;
	}
	//Losing Sex (Slime)
	if(eventNum == 5042) {
		outputText("", true);
		doNext(1);
		if(player.gender == 2 || (player.gender == 3 && rand(2) == 0)) {
			temp = rand(3);
			if(temp == 0) oozeRapesYouVaginally();
			if(temp == 1) oozeRapesYouOrally();
			if(temp == 2) oozeButtRapesYou();
		}
		//Everybody else
		else {
			temp = rand(2);
			if(temp == 0) oozeRapesYouOrally();
			if(temp == 1) oozeButtRapesYou();
		}
		eventParser(5007);
		return;
	}
	//Demon pack attack
	if(eventNum == 5043) {
		//return to combat menu when finished
		//Determine if dodged!
		if(player.spe - monster.spe > 0 && int(Math.random()*(((player.spe-monster.spe)/4)+80)) > 80) {
			outputText("You duck, weave, and dodge.  Despite their best efforts, the throng of demons only hit the air and each other.", false);
			combatRoundOver();
			return;
		}
		//Determine if evaded
		if(player.hasPerk("Evade") >= 0 && rand(100) < 10) {
			outputText("Using your skills at evading attacks, you anticipate and sidestep " + monster.a + monster.short + "' attacks.", false);
			combatRoundOver();
			return;
		}
		//("Misdirection"
		if(player.hasPerk("Misdirection") >= 0 && rand(100) < 15 && player.armorName == "red, high-society bodysuit") {
			outputText("Using Raphael's teachings, you anticipate and sidestep " + monster.a + monster.short + "' attacks.", false);
			combatRoundOver();
			return;
		}
		//Determine if cat'ed
		if(player.hasPerk("Flexibility") >= 0 && rand(100) < 6) {
			outputText("With your incredible flexibility, you squeeze out of the way of " + monster.a + monster.short + "' attacks.", false);
			combatRoundOver();
			return;
		}
		//Determine damage - str modified by enemy toughness!
		temp = int((monster.str + monster.weaponAttack) - rand(player.tou) - player.armorDef);
		if(temp > 0) temp = takeDamage(temp);
		if(temp <= 0) {
			temp = 0;
			if(!monster.plural) outputText("You deflect and block every " + monster.weaponVerb + " " + monster.a + monster.short + " throw at you.", false);
			else outputText("You deflect " + monster.a + monster.short + " " + monster.weaponVerb + ".");
		}
		if(temp > 0 && temp < 6) {
			outputText("You are struck a glancing blow by " + monster.a + monster.short + "! (" + temp + ")", false);
		}
		if(temp > 5 && temp < 11) {
			outputText(monster.capitalA + monster.short + " wound you! (" + temp + ")", false);
		}
		if(temp > 10 && temp < 21) {
			outputText(monster.capitalA + monster.short + " stagger you with the force of " + monster.pronoun3 + " " + monster.weaponVerb + "s! (" + temp + ")", false);
		}
		if(temp > 20) {
			outputText(monster.capitalA + monster.short + " <b>mutilates</b> you with powerful fists and " + monster.weaponVerb + "s! (" + temp + ")", false);
		}
		statScreenRefresh();
		outputText("\n", false);
		combatRoundOver();
		return;
	}
	//Demonic lust attack!
	if(eventNum == 5044) {
		if(player.lust < 35) outputText("The demons press in close against you and although they fail to hit you with an attack, the sensation of their skin rubbing against yours feels highly erotic.", false);
		if(player.lust >= 35 && player.lust < 65) {
			outputText("The push of the demons' sweaty, seductive bodies sliding over yours is deliciously arousing and you feel your ", false);
			if(player.cocks.length > 0) outputText(multiCockDescriptLight() + " hardening ", false);
			else if(player.vaginas.length > 0) outputText(vaginaDescript(0) + " get wetter ", false);
			outputText("in response to all the friction.", false);
		}
		if(player.lust >= 65) {
			outputText("As the demons mill around you, their bodies rub constantly over yours, and it becomes harder and harder to keep your thoughts on the fight or resist reaching out to touch a well lubricated cock or pussy as it slips past.  You keep subconsciously moving your ", false);
			if(player.gender == 1) outputText(multiCockDescriptLight() + " towards the	nearest inviting demonic hole.", false);
			if(player.gender == 2) outputText(vaginaDescript(0) + " towards the nearest swinging cock.", false);
			if(player.gender == 3) outputText("aching cock and thirsty pussy towards the nearest thing willing to fuck it.", false);
			if(player.gender == 0) outputText("groin, before remember there is nothing there to caress.", false);
		}
		stats(0,0,0,0,0,0,10+player.sens/10,0);
		combatRoundOver();
	}
	//Raise demons lust to 100 & fuck them
	if(eventNum == 5045) {
		outputText("You open your arms and step into the throng of eager demons. They jump eagerly to touch you, becoming more and more lust-frenzied every second. You take the nearest demon and throw it to the ground and without a moment's thought the rest of the group leap to join you in a thoughtless madness of lust...", true);
		doNext(5048);
	}
	//Chat with demon group
	if(eventNum == 5046) {
		oasisTalk();
	}
	//start combat
	if(eventNum == 5047) {
		startCombat(7);
		eventParser(1);
		spriteSelect(46);
	}
	//Demonic orgy sex start
	if(eventNum == 5048) {
		oasisSexing();
		return;
	}
	//Try to run after talking
	if(eventNum == 5049) {
		oasisTalkDecline();
	}
	//Accept orgy
	if(eventNum == 5050) {
		oasisTalkAccept();
	}
	//Run
	if(eventNum == 5051) {
		oasisRunAway();
	}
	//Encounte worms
	if(eventNum == 5052) {
		if(player.hasStatusAffect("metWorms") >= 0) {
			if(player.gender == 1 || player.gender == 3) wormsMale();
			else wormsFemale();
		}
		else wormsFirstTime();
	}
	//Run from worms
	if(eventNum == 5053) {
		wormsRun();
	}
	//Worm physical attack
	if(eventNum == 5054) {
		wormAttack();
	}
	//Worms entice attack!
	if(eventNum == 5055) {
		wormsEntice();
	}
	//confront worm combat
	if(eventNum == 5056) {
		outputText("You turn to confront the worms and combat begins!", true);
		startCombat(8);
	}
	//Do nothing
	if(eventNum == 5057) {
		outputText("You do nothing, allowing the worms to enter combat range!", true);
		startCombat(8);
	}
	//worm toggle on
	if(eventNum == 5058) {
		wormsOn();
		outputText("You actually think it's kind of a hot idea, and wonder if such creatures actually exist in this land as you make your way back to camp.", true);
		doNext(13);
	}
	//worm toggle off
	if(eventNum == 5059) {
		outputText("You shudder in revulsion and figure the sign to be the result of someone's perverted fantasy.", true);
		wormsOff();
		doNext(13);
	}
	//InfestAttack
	if(eventNum == 5060) {
		//Keep logic sane if this attack brings victory
		menuLoc = 0;
		playerInfest();
	}
	//Set worms to 'who cares'
	if(eventNum == 5061) {
		outputText("You shrug and keep walking, not sure how you feel about the strange sign.", true);
		player.createStatusAffect("wormsOn",0,0,0,0);
		player.createStatusAffect("wormsHalf",0,0,0,0);
		doNext(13);
	}
	//Cultist Attack 1
	if(eventNum == 5062) {
		cultistRaisePlayerLust();
	}
	//Cultist Attack 2
	if(eventNum == 5063) {
		cultistLustTransfer();
	}
	//GET RAEPED BY CULTIST
	if(eventNum == 5064) {
		outputText("", true);
		cultistRapesYou();
	}
	//RAEP CULTIST
	if(eventNum == 5065) {
		outputText("", true);
		playerRapesCultist();
	}
	//Doggie Firebreath
	if(eventNum == 5066) {
		hellhoundFire();
	}
	//Hellhound Speed
	if(eventNum == 5067) {
		hellhoundScent();
	}
	//Hellhound gets raped
	if(eventNum == 5068) {
		hellHoundGetsRaped();
	}
	//Hellhound rapes player
	if(eventNum == 5069) {
		hellhoundRapesPlayer();
	}
	//Cultist bad end pt2
	if(eventNum == 5070) {
		cultistBadEnd2();
	}
	//Wait
	if(eventNum == 5071) {
		//Gain fatigue if not fighting sand tarps
		if(monster.hasStatusAffect("level") < 0) fatigue(-5);
		flags[IN_COMBAT_USE_PLAYER_WAITED_FLAG] = 1;
		if(monster.hasStatusAffect("PCTailTangle") >= 0) {
			kitsuneWait();
			return;
		}
		else if(monster.hasStatusAffect("level") >= 0) {
			sandTrapWait();
			return;
		}
		else if(monster.hasStatusAffect("Minotaur Entangled") >= 0) {
			clearOutput();
			outputText("You sigh and relax in the chains, eying the well-endowed minotaur as you await whatever rough treatment he desires to give.  His musky, utterly male scent wafts your way on the wind, and you feel droplets of your lust dripping down your thighs.  You lick your lips as you watch the pre-cum drip from his balls, eager to get down there and worship them.  Why did you ever try to struggle against this fate?\n\n");
			stats(0,0,0,0,0,0,30+rand(5),0,false);
			enemyAI();
			return;
		}
		else if(player.hasStatusAffect("Whispered") >= 0) {
			clearOutput();
			outputText("You shake off the mental compulsions and ready yourself to fight!\n\n");
			player.removeStatusAffect("Whispered");
			enemyAI();
			return;
		}
		else if(player.hasStatusAffect("HarpyBind") >= 0) {
			clearOutput();
			temp = 80 + rand(40);
			temp = takeDamage(temp);
			outputText("The brood continues to hammer away at your defenseless self. (" + temp + ")");
			combatRoundOver();
			return;
		}
		else if(monster.hasStatusAffect("QueenBind") >= 0) {
			ropeStruggles(true);
			return;
		}
		else if(player.hasStatusAffect("GooBind") >= 0) {
			outputText("You writhe uselessly, trapped inside the goo girl's warm, seething body. Darkness creeps at the edge of your vision as you are lulled into surrendering by the rippling vibrations of the girl's pulsing body around yours.", true);
			temp = takeDamage(.35 * maxHP());
			outputText(" (" + temp + ")", false);
			combatRoundOver();
			return;
		}
		else if(player.hasStatusAffect("GooArmorBind") >= 0) {
			clearOutput();
			outputText("Suddenly, the goo-girl leaks half-way out of her heavy armor and lunges at you. You attempt to dodge her attack, but she doesn't try and hit you - instead, she wraps around you, pinning your arms to your chest. More and more goo latches onto you - you'll have to fight to get out of this.");
			player.addStatusValue("GooArmorBind",1,1);
			if(player.statusAffectv1("GooArmorBind") >= 5) {
				if(monster.hasStatusAffect("spar") >= 0) pcWinsValeriaSparDefeat();
				else gooArmorBeatsUpPC();
				return;
			}
			combatRoundOver();
			return;
		}
		else if(player.hasStatusAffect("Naga Bind") >= 0) {
			outputText("The naga's grip on you tightens as you relax into the stimulating pressure.", true);
			stats(0,0,0,0,0,0,player.sens/5+5,0);
			takeDamage(5+rand(5));
			combatRoundOver();
			return;
		} else if(player.hasStatusAffect("Holli Constrict") >= 0) {
			waitForHolliConstrict(true);
			return;
		}
		else if(player.hasStatusAffect("TentacleBind") >= 0) {
			if(player.cocks.length > 0) outputText("The creature continues spiraling around your cock, sending shivers up and down your body. You must escape or this creature will overwhelm you!", true);
			else if(player.hasVagina()) outputText("The creature continues sucking your clit and now has latched two more suckers on your nipples, amplifying your growing lust. You must escape or you will become a mere toy to this thing!", true);
			else outputText("The creature continues probing at your asshole and has now latched " + num2Text(player.totalNipples()) + " more suckers onto your nipples, amplifying your growing lust.  You must escape or you will become a mere toy to this thing!", true);
			stats(0,0,0,0,0,0,(8+player.sens/10),0);
			combatRoundOver();
			return;
		}
		else if(player.hasStatusAffect("Isabella Stunned") >= 0) {
			player.removeStatusAffect("Isabella Stunned");
			outputText("You wobble about for some time but manage to recover. Isabella capitalizes on your wasted time to act again.\n\n", true);
		}
		else if(player.hasStatusAffect("Stunned") >= 0) {
			player.removeStatusAffect("Stunned");
			outputText("You wobble about, stunned for a moment.  After shaking your head, you clear the stars from your vision, but by then you've squandered your chance to act.\n\n", true);
		}
		else if(player.hasStatusAffect("Confusion") >= 0) {
			player.removeStatusAffect("Confusion");
			outputText("You shake your head and file your memories in the past, where they belong.  It's time to fight!\n\n", true);
		}
		else outputText("You decide not to take any action this round.\n\n", true);
		enemyAI();
		return;
	}
	//Tentacle physical attack
	if(eventNum == 5072) {
		tentaclePhysicalAttack();
		return;
	}
	//Tentacle entwine attack
	if(eventNum == 5073) {
		tentacleEntwine();
		return;
	}
	//Tentacle rapes you
	if(eventNum == 5074) {
		outputText("", true);
		tentacleLossRape();
		return;
	}
	//Tentacle Bad End
	if(eventNum == 5075) {
		futaTentacleBadEnd();
		return;
	}
	//Tentacle Bad End2
	if(eventNum == 5076) {
		futaTentacleEpilogue();
		return;
	}
	//Tentacle Struggle
	if(eventNum == 5077) {
		if(monster.hasStatusAffect("Minotaur Entangled") >= 0) {
			clearOutput();
			if(player.str/9 + rand(20) + 1 >= 15) {
				outputText("Utilizing every ounce of your strength and cunning, you squirm wildly, shrugging through weak spots in the chain's grip to free yourself!  Success!");
				monster.removeStatusAffect("Minotaur Entangled");
				outputText("\n\n\"<i>No!  You fool!  You let her get away!  Hurry up and finish her up!  I need my serving!</i>\"  The succubus spits out angrily.\n\n");
				combatRoundOver();
			}
			//Struggle Free Fail*
			else {
				outputText("You wiggle and struggle with all your might, but the chains remain stubbornly tight, binding you in place.  Damnit!  You can't lose like this!\n\n");
				enemyAI();
			}
			return;
		}
		if(monster.hasStatusAffect("PCTailTangle") >= 0) {
			kitsuneStruggle();
			return;
		} else if(player.hasStatusAffect("Holli Constrict") >= 0) {
			struggleOutOfHolli();
			return;
		}
		else if(monster.hasStatusAffect("QueenBind") >= 0) {
			ropeStruggles();
			return;
		}
		else if(player.hasStatusAffect("GooBind") >= 0) {
			//[Struggle](successful) : 
			if(rand(3) == 0 || rand(80) < player.str) {
				outputText("You claw your fingers wildly within the slime and manage to brush against her heart-shaped nucleus. The girl silently gasps and loses cohesion, allowing you to pull yourself free while she attempts to solidify.", true);
				player.removeStatusAffect("GooBind");
			}
			//Failed struggle
			else {
				outputText("You writhe uselessly, trapped inside the goo girl's warm, seething body. Darkness creeps at the edge of your vision as you are lulled into surrendering by the rippling vibrations of the girl's pulsing body around yours.", true);
				temp = takeDamage(.15 * maxHP());
				outputText(" (" + temp + ")", false);
			}
			combatRoundOver();
			return;
		}
		else if(player.hasStatusAffect("HarpyBind") >= 0) {
			harpyHordeGangBangStruggle();
			return;
		}
		else if(player.hasStatusAffect("GooArmorBind") >= 0) {
			struggleAtGooBind();
			return;
		}
		else if(player.hasStatusAffect("UBERWEB") >= 0) {
			outputText("You claw your way out of the webbing while Kiha does her best to handle the spiders single-handedly!\n\n", true);
			player.removeStatusAffect("UBERWEB");
			enemyAI();
			return;
		}
		else if(player.hasStatusAffect("Naga Bind") >= 0) {
			if(rand(3) == 0 || rand(80) < player.str/1.5) {
				outputText("You wriggle and squirm violently, tearing yourself out from within the naga's coils.", true);
				player.removeStatusAffect("Naga Bind");
			}
			else {
				outputText("The naga's grip on you tightens as you struggle to break free from the stimulating pressure.", true);
				stats(0,0,0,0,0,0,player.sens/10+2,0);
				takeDamage(7+rand(5));
			}
			combatRoundOver();
			return;
		}
		else {
			outputText("You struggle with all of your might to free yourself from the tentacles before the creature can fulfill whatever unholy desire it has for you.\n", true);
			//33% chance to break free + up to 50% chance for strength
			if(rand(3) == 0 || rand(80) < player.str/2) {
				outputText("As the creature attempts to adjust your position in its grip, you free one of your " + player.legs() + " and hit the beast in its beak, causing it to let out an inhuman cry and drop you to the ground smartly.\n\n", false);
				player.removeStatusAffect("TentacleBind");
				monster.createStatusAffect("TentacleCoolDown",3,0,0,0);
			}
			//Fail to break free
			else {
				outputText("Despite trying to escape, the creature only tightens its grip, making it difficult to breathe.\n\n", false);
				takeDamage(5);
				if(player.cocks.length > 0) outputText("The creature continues spiraling around your cock, sending shivers up and down your body. You must escape or this creature will overwhelm you!", false);
				else if(player.hasVagina()) outputText("The creature continues sucking your clit and now has latched two more suckers on your nipples, amplifying your growing lust. You must escape or you will become a mere toy to this thing!", true);			
				else outputText("The creature continues probing at your asshole and has now latched " + num2Text(player.totalNipples()) + " more suckers onto your nipples, amplifying your growing lust.  You must escape or you will become a mere toy to this thing!", true);
				stats(0,0,0,0,0,0,(3+player.sens/10+player.lib/20),0);
				combatRoundOver();
				return;
			}
		}
		enemyAI();
	}
	//Tentacle gets raped
	if(eventNum == 5078) {
		tentacleVictoryRape();
		return;
	}
	//Fire bow - Requires 25 fatigue
	if(eventNum == 5079) {
		if(player.fatigue + physicalCost(25) > 100) {
			outputText("You're too fatigued to fire the bow!", true);
			doNext(5000);
			return;
		}
		if(monster.hasStatusAffect("Bow Disabled") >= 0) {
			outputText("You can't use your bow right now!", true);
			doNext(5000);
			return;
		}
		fatigue(25,2);
		menuLoc = 0;
		//Amily!
		if(monster.hasStatusAffect("Concentration") >= 0) {
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n", true);
			enemyAI();
			return;
		}
		outputText("", true);
		//Keep logic sane if this attack brings victory
		menuLoc = 0;
		//Prep messages vary by skill. 
		if(player.statusAffectv1("Kelt") < 30) {
			outputText("Fumbling a bit, you nock an arrow and fire!\n", false);
		}
		else if(player.statusAffectv1("Kelt") < 50) {
			outputText("You pull an arrow and fire it at " + monster.a + monster.short + "!\n", false);
		}
		else if(player.statusAffectv1("Kelt") < 80) {
			outputText("With one smooth motion you draw, nock, and fire your deadly arrow at your opponent!\n", false);
		}
		else if(player.statusAffectv1("Kelt") <= 99) {
			outputText("In the blink of an eye you draw and fire your bow directly at " + monster.a + monster.short + ".\n", false);
		}
		else {
			outputText("You casually fire an arrow at " + monster.a + monster.short + " with supreme skill.\n", false);
			//Keep it from going over 100
			player.changeStatusValue("Kelt",1,100);
		}
		if(monster.hasStatusAffect("sandstorm") >= 0 && rand(10) > 1) {
			outputText("Your shot is blown off target by the tornado of sand and wind.  Damn!\n\n");
			enemyAI();
			return;
		}
		//[Bow Response] 
		if(monster.short == "Isabella") {
			if(monster.hasStatusAffect("Blind") >= 0) outputText("Isabella hears the shot and turns her shield towards it, completely blocking it with her wall of steel.\n\n", false);
			else outputText("You arrow thunks into Isabella's shield, completely blocked by the wall of steel.\n\n", false);
			outputText("\"<i>You remind me of ze horse-people.  They cannot deal vith mein shield either!</i>\" cheers Isabella.\n\n", false);
			enemyAI();
			return;
		}
		//worms are immune
		if(monster.short == "worms") {
			outputText("The arrow slips between the worms, sticking into the ground.\n\n", true);
			enemyAI();
			return;
		}
		//Vala miss chance!
		if(monster.short == "Vala" && rand(10) < 7) {
			outputText("Vala flaps her wings and twists her body. Between the sudden gust of wind and her shifting of position, the arrow goes wide.\n\n", false);
			enemyAI();
			return;
		}
		//Blind miss chance
		if(player.hasStatusAffect("Blind") >= 0) {
			outputText("The arrow hits something, but blind as you are, you don't have a chance in hell of hitting anything with a bow.\n\n", false);
			enemyAI();
			return;
		}
		//Miss chance 10% based on speed + 10% based on int + 20% based on skill
		if(monster.short != "pod" && player.spe/10 + player.inte/10 + player.statusAffectv1("Kelt")/5 + 60 <  rand(101)) 
		{
			outputText("The arrow goes wide, disappearing behind your foe.\n\n", false);
			enemyAI();
			return;
		}
		//Hit!  Damage calc! 20 + 
		var damage:Number = 0;
		damage = int((20 + player.str/3 + player.statusAffectv1("Kelt")/1.2) + player.spe/3 - rand(monster.tou) - monster.armorDef);
		if(damage < 0) damage = 0;
		if(damage == 0) {
			if(monster.inte > 0) outputText(monster.capitalA + monster.short + " shrugs as the arrow bounces off them harmlessly.\n\n", false);
			else outputText("The arrow bounces harmlessly off " + monster.a + monster.short + ".\n\n", false);
			enemyAI();
			return;
		}
		if(monster.short == "pod") outputText("The arrow lodges deep into the pod's fleshy wall", false);
		else if(monster.plural) outputText(monster.capitalA + monster.short + " look down at the arrow that now protrudes from one of " + monster.pronoun3 + " bodies", false);
		else outputText(monster.capitalA + monster.short + " looks down at the arrow that now protrudes from " + monster.pronoun3 + " body", false);
		if(player.hasPerk("History: Fighter") >= 0) damage *= 1.1;
		damage = doDamage(damage);
		monster.lust -= 20;
		if(monster.lust < 0) monster.lust = 0;
		if(monster.HP <= 0) {
			if(monster.short == "pod") outputText(". (" + String(damage) + ")\n\n", false);
			else if(monster.plural) outputText(" and stagger, collapsing onto each other from the wounds you've inflicted on " + monster.pronoun2 + ".  (" + String(damage) + ")\n\n", false);
			else outputText(" and staggers, collapsing from the wounds you've inflicted on " + monster.pronoun2 + ".  (" + String(damage) + ")\n\n", false);
			doNext(5008);
			return;
		}
		else outputText(".  It's clearly very painful. (" + String(damage) + ")\n\n", false);
		enemyAI();
		return;
	}
	if(eventNum == 5080) {
		doNext(5000);
		spellArouse();
		return;
	}
	if(eventNum == 5081) {
		doNext(5000);
		spellHeal();
		return;
	}
	if(eventNum == 5082) {
		doNext(5000);
		spellMight();
		return;
	}
	if(eventNum == 5083) {
		doNext(5000);
		spellChargeWeapon();
		return;
	}
	if(eventNum == 5084) {
		doNext(5000);
		spellBlind();
		return;
	}
	if(eventNum == 5085) {
		doNext(5000);
		spellWhitefire();
		return;
	}
	if(eventNum == 5086) {
		doNext(5000);
		fantasize();
		return;
	}
	if(eventNum == 5087) {
		goblinDrugAttack();
		return;
	}
	if(eventNum == 5088) {
		goblinTeaseAttack();
		return;
	}
	if(eventNum == 5089) {
		goblinRapesPlayer();
		return;
	}
	if(eventNum == 5090) {
		gobboGetsRapedMaleFits();
		return;
	}
	if(eventNum == 5091) {
		gobboGetsRapedFem();
		return;
	}
	if(eventNum == 5092) {
		marbleSpecialAttackOne();
		return;
	}
	if(eventNum == 5093) {
		marbleSpecialAttackTwo();
		return;
	}
	if(eventNum == 5094) {
		marbleFightWin();
		return;
	}
	if(eventNum == 5095) {
		marbleFightLose();
		return;
	}
	//Gobbobuttsecks
	if(eventNum == 5096) {
		gobboButtSecks();
		return;
	}
	//Shark special attack
	if(eventNum == 5097) {
		sharkTease();
		return;
	}
	//Shark bad end
	if(eventNum == 5098) {
		sharkBadEnd();
		return;
	}
	//Shark bad end2
	if(eventNum == 5099) {
		sharkBadEnd2();
		return;
	}
	//Shark rape with dick
	if(eventNum == 5100) {
		sharkgirlDickFuck();
		return;
	}
	//Shark 69
	if(eventNum == 5101) {
		sharkgirlSixtyNine();
		return;
	}
	//bite attack
	if(eventNum == 5102) {
		bite();
		return;
	}
	//zealot attack1
	if(eventNum == 5103) {
		zealotSpecial1();
		return;
	}
	//zealot attack2
	if(eventNum == 5104) {
		zealotSpecial2();
		return;
	}
	//zealot gets raped
	if(eventNum == 5105) {
		zealotWinRape();
		return;
	}
	//zealot rapes
	if(eventNum == 5106) {
		zealotLossRape();
		return;
	}
	//Hellhound attack
	if(eventNum == 5107) {
		hellHoundWormCannon();
		return;
	}
	//Infested Hellhound Loss rape
	if(eventNum == 5108) {
		infestedHellhoundLossRape();
		return;
	}
	if(eventNum == 5109) {
		nagaPoisonBiteAttack();
		return;
	}
	if(eventNum == 5110) {
		nagaConstrict();
		return;
	}
	if(eventNum == 5111) {
		nagaTailWhip();
		return;
	}
	if(eventNum == 5112) {
		nagaRapeChoice();
		return;
	}
	if(eventNum == 5113) {
		nagaVictoryMale();
		return;
	}
	if(eventNum == 5114) {
		nagaVictoryFemale();
		return;
	}
	if(eventNum == 5115) {
		nagaVictoryGenderless();
		return;
	}
	if(eventNum == 5116) {
		nagaFUCKSJOOOOOO();
		return;
	}
	if(eventNum == 5117) {
		nagaBiteAttack();
		return;
	}
	if(eventNum == 5118) {
		nagaPlayerConstrict();
		return;
	}
	if(eventNum == 5119) {
		naggaSqueeze();
		return;
	}
	if(eventNum == 5120) {
		naggaTease();
		return;
	}
	if(eventNum == 5121) {
		nagaLeggoMyEggo();
		return;
	}
	if(eventNum == 5122) {
		gooNagaRape();
		return;
	}
	if(eventNum == 5123) {
		fireballuuuuu();
		return;
	}
	if(eventNum == 5124) {
		superWhisperAttack();
		return;
	}
	if(eventNum == 5125) {
		akbalLustAttack();
		return;
	}
	if(eventNum == 5126) {
		akbalSpecial();
		return;
	}
	if(eventNum == 5127) {
		akbalHeal();
		return;
	}
	if(eventNum == 5128) {
		victoryChoices();
		return;
	}
	if(eventNum == 5129) {
		rapeAkbal();
		return;
	}
	if(eventNum == 5130) {
		loseToAckballllllz();
		return;
	}
	if(eventNum == 5131) {
		minoGetsTitFucked();
		return;
	}
	if(eventNum == 5132) {
		takeMinoCumDirectly();
		return;
	}
	if(eventNum == 5133) {
		ceraphSpecial1();
		return;
	}
	if(eventNum == 5134) {
		ceraphSpecial2();
		return;
	}
	if(eventNum == 5135) {
		ceraphSpecial3();
		return;
	}
	if(eventNum == 5136) {
		harpyUberCharge();
		return;
	}
	if(eventNum == 5137) {
		harpyTease();
		return;
	}
	if(eventNum == 5138) {
		sophieKissAttack();
		return;
	}
	if(eventNum == 5139) {
		sophieHarpyBoatsPC();
		return;
	}
	if(eventNum == 5140) {
		sophieCompulsionAttack();
		return;
	}
	if(eventNum == 5141) {
		talonsSophie();
		return;
	}
	if(eventNum == 5142) {
		batterAttackSophie();
		return;
	}
	if(eventNum == 5143) {
		hellFire();
		return;
	}
	if(eventNum == 5144) {
		outputText("Which of your special fire-breath attacks would you like to use?", true);
		simpleChoices("Akbal's",5123,"Hellfire",5143,"Dragonfire",5164,"",0,"Back",1);
		return;
	}
	if(eventNum == 5145) {
		hyenaArousalAttack();
		return;
	}
	if(eventNum == 5146) {
		hyenaSnapKicku();
		return;
	}
	if(eventNum == 5147) {
		hyenaJavelinAttack();
		return;
	}
	if(eventNum == 5148) {
		hyenaVictoryRapeFellatio();
		return;
	}
	if(eventNum == 5149) {
		victoryRapeHyenaCunnilingus();
		return;
	}
	if(eventNum == 5150) {
		kick();
		return;
	}
	if(eventNum == 5151) {
		rapeMinotaurTentacles();
		return;
	}
	if(eventNum == 5152) {
		minoUrethralPen();
		return;
	}
	if(eventNum == 5153) {
		bumRapeaMinotaur();
		return;
	}
	if(eventNum == 5154) {
		girlRapeAMinotaur();
		return;
	}
	if(eventNum == 5155) {
		minotaurGetsRapedByHerms();
		return;
	}
	if(eventNum == 5156) {
		PCWebAttack();
		return;
	}
	if(eventNum == 5157) {
		spiderBiteAttack();
		return;
	}
	if(eventNum == 5158) {
		kissAttack();
		return;
	}
	if(eventNum == 5159) {
		possess();
		return;
	}
	if(eventNum == 5160) {
		magicalSpecials();
		return;
	}
	if(eventNum == 5161) {
		physicalSpecials();		
		return;
	}
	if(eventNum == 5162) {
		anemoneSting();
		return;
	}
	if(eventNum == 5163) {
		berzerk();
		return;
	}
	if(eventNum == 5164) {
		dragonBreath();
		return;
	}
	if(eventNum == 5165) {
		tailWhipAttack();
		return;
	}
}
//Fantasize
function fantasize():void {
	var temp2:Number = 0;
	outputText("", true);
	if(player.armorName == "goo armor") {
		outputText("As you fantasize, you feel Valeria rubbing her gooey body all across your sensitive skin");
		if(player.gender > 0) outputText(" and genitals");
		outputText(", arousing you even further.\n");
		temp2 = 25 + rand(player.lib/8+player.cor/8)
	}	
	else if(player.balls > 0 && player.ballSize >= 10 && rand(2) == 0) {
		outputText("You daydream about fucking " + monster.a + monster.short + ", feeling your balls swell with seed as you prepare to fuck " + monster.pronoun2 + " full of cum.\n", false);
		temp2 = 5 + rand(player.lib/8+player.cor/8)
		outputText("You aren't sure if it's just the fantasy, but your " + ballsDescriptLight() + " do feel fuller than before...\n", false);
		player.hoursSinceCum += 50;
	}
	else if(player.biggestTitSize() >= 6 && rand(2) == 0) {
		outputText("You fantasize about grabbing " + monster.a + monster.short + " and shoving " + monster.pronoun2 + " in between your jiggling mammaries, nearly suffocating " + monster.pronoun2 + " as you have your way.\n", false);
		temp2 = 5 + rand(player.lib/8+player.cor/8)
	}
	else if(player.biggestLactation() >= 6 && rand(2) == 0) {
		outputText("You fantasize about grabbing " + monster.a + monster.short + " and forcing " + monster.pronoun2 + " against a " + nippleDescript(0) + ", and feeling your milk let down.  The desire to forcefeed SOMETHING makes your nipples hard and moist with milk.\n", false);
		temp2 = 5 + rand(player.lib/8+player.cor/8)
	}
	else {
		outputText("You fill your mind with perverted thoughts about " + monster.a + monster.short + ", picturing " + monster.pronoun2 + " in all kinds of perverse situations with you.\n", true);	
		temp2 = 10+rand(player.lib/5+player.cor/8);		
	}
	if(temp2 >= 20) outputText("The fantasy is so vivid and pleasurable you wish it was happening now.  You wonder if " + monster.a + monster.short + " can tell what you were thinking.\n\n", false);
	else outputText("\n", false);
	stats(0,0,0,0,0,0,temp2,0,false);
	if(player.lust > 99) {
		if(monster.short == "pod") {
			outputText("<b>You nearly orgasm, but the terror of the situation reasserts itself, muting your body's need for release.  If you don't escape soon, you have no doubt you'll be too fucked up to ever try again!</b>\n\n", false);
			player.lust = 99;
			stats(0,0,0,0,0,0,-25,0);
		}
		else {
			doNext(5011);
			return;
		}
	}
	enemyAI();	
}
//Mouf Attack
// (Similar to the bow attack, high damage but it raises your fatigue).
function bite():void {
	if(player.fatigue + physicalCost(25) > 100) {
		outputText("You're too fatigued to use your shark-like jaws!", true);
		doNext(5000);
		return;
	}
	//Worms are special
	if(monster.short == "worms") {
		outputText("There is no way those are going anywhere near your mouth!\n\n", true);
		doNext(5000);
		return;
	}
	fatigue(25,2);
	//Amily!
	if(monster.hasStatusAffect("Concentration") >= 0) {
		outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n", true);
		enemyAI();
		return;
	}
	outputText("You open your mouth wide, your shark teeth extending out. Snarling with hunger, you lunge at your opponent, set to bite right into them!  ", true);
	if(player.hasStatusAffect("Blind") >= 0) outputText("In hindsight, trying to bite someone while blind was probably a bad idea... ", false);
	var damage:Number = 0;
	//Determine if dodged!
	if((player.hasStatusAffect("Blind") >= 0 && rand(3) != 0) || (monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80)) {
		if(monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!", false);
		if(monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!", false);
		if(monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.", false);
		outputText("\n\n", false);
		enemyAI();
		return;
	}
	//Determine damage - str modified by enemy toughness!
	damage = int((player.str + 45) - rand(monster.tou) - monster.armorDef);
	
	//Deal damage and update based on perks
	if(damage > 0) {
		if(player.hasPerk("History: Fighter") >= 0) damage *= 1.1;
		damage = doDamage(damage);
	}
	
	if(damage <= 0) {
		damage = 0;
		outputText("Your bite is deflected or blocked by " + monster.a + monster.short + ".", false);
	}
	if(damage > 0 && damage < 10) {
		outputText("You bite doesn't do much damage to " + monster.a + monster.short + "! (" + damage + ")", false);
	}
	if(damage >= 10 && damage < 20) {
		outputText("You seriously wound " + monster.a + monster.short + " with your bite! (" + damage + ")", false);
	}
	if(damage >= 20 && damage < 30) {
		outputText("Your bite staggers " + monster.a + monster.short + " with its force. (" + damage + ")", false);
	}
	if(damage >= 30) {
		outputText("Your powerful bite <b>mutilates</b> " + monster.a + monster.short + "! (" + damage + ")", false);
	}
	outputText("\n\n", false);
	//Kick back to main if no damage occured!
	if(monster.HP > 0 && monster.lust < 100) {
		enemyAI();
	}
	else {
		if(monster.HP <= 0) doNext(5008);
		else doNext(5009);
	}
}

function fatigueRecovery():void {
	fatigue(-1);
	if(player.hasPerk("Enlightened Nine-tails") >= 0 || player.hasPerk("Corrupted Nine-tails") >= 0) fatigue(-(1+rand(3)));
}


//ATTACK
function attack():void {
	if(player.hasStatusAffect("FirstAttack") < 0) {
		outputText("", true);
		fatigueRecovery();
	}
	if(player.hasStatusAffect("Sealed") >= 0 && player.statusAffectv2("Sealed") == 0) {
		outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  The kitsune's seals have made normal attack impossible!  Maybe you could try something else?\n\n", false);
		enemyAI();
		return;
	}
	if(flags[PC_FETISH] >= 3 && !isUrta()) {
		outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  Ceraph's piercings have made normal attack impossible!  Maybe you could try something else?\n\n", false);
		enemyAI();
		return;
	}
	//Amily!
	if(monster.hasStatusAffect("Concentration") >= 0) {
		outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n", true);
		enemyAI();
		return;
	}
	if(monster.hasStatusAffect("level") >= 0 && player.hasStatusAffect("FirstAttack") < 0) {
		outputText("It's all or nothing!  With a bellowing cry you charge down the treacherous slope and smite the sandtrap as hard as you can!  ");
		trapLevel(-4);
	}
	if(player.hasPerk("Double Attack") >= 0 && player.spe >= 50 && flags[DOUBLE_ATTACK_STYLE] < 2) {
		if(player.hasStatusAffect("FirstAttack") >= 0) player.removeStatusAffect("FirstAttack");
		else {
			//Always!
			if(flags[DOUBLE_ATTACK_STYLE] == 0) player.createStatusAffect("FirstAttack",0,0,0,0);
			//Alternate!
			else if(player.str < 61 && flags[DOUBLE_ATTACK_STYLE] == 1) player.createStatusAffect("FirstAttack",0,0,0,0);
		}
	}
	else if(player.hasPerk("Brawler") >= 0 && player.weaponName == "fists") {
		if(player.hasStatusAffect("FirstAttack") >= 0) {
			player.removeStatusAffect("FirstAttack");
		}
		else {
			player.createStatusAffect("FirstAttack",0,0,0,0);
			outputText("Utilizing your skills as a bareknuckle brawler, you make two attacks!\n");
		}
	}
	//Blind
	if(player.hasStatusAffect("Blind") >= 0) {
		outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ", false);
	}
	if(monster.short == "basilisk") {
		//basilisk counter attack (block attack, significant speed loss): 
		if(player.inte/5 + rand(20) < 25) {
			outputText("Holding the basilisk in your peripheral vision, you charge forward to strike it.  Before the moment of impact, the reptile shifts its posture, dodging and flowing backward skillfully with your movements, trying to make eye contact with you. You find yourself staring directly into the basilisk's face!  Quickly you snap your eyes shut and recoil backwards, swinging madly at the lizard to force it back, but the damage has been done; you can see the terrible grey eyes behind your closed lids, and you feel a great weight settle on your bones as it becomes harder to move.", false);
			basiliskSpeed(20);
			player.removeStatusAffect("FirstAttack");
			combatRoundOver();
			return;
		}
		//Counter attack fails: (random chance if PC int > 50 spd > 60; PC takes small physical damage but no block or spd penalty)
		else {
			outputText("Holding the basilisk in your peripheral vision, you charge forward to strike it.  Before the moment of impact, the reptile shifts its posture, dodging and flowing backward skillfully with your movements, trying to make eye contact with you. You twist unexpectedly, bringing your " + player.weaponName + " up at an oblique angle; the basilisk doesn't anticipate this attack!  ", false);
		}
	}
	//Worms are special
	if(monster.short == "worms") {
		//50% chance of hit (int boost)
		if(rand(100) + player.inte/3 >= 50) {
			temp = int(player.str/5 - rand(5));
			if(temp == 0) temp = 1;
			outputText("You strike at the amalgamation, crushing countless worms into goo, dealing " + temp + " damage.\n\n", false);
			monster.HP -= temp;
			if(monster.HP <= 0) {
				doNext(5008);
				return;
			}
		}
		//Fail
		else {
			outputText("You attempt to crush the worms with your reprisal, only to have the collective move its individual members, creating a void at the point of impact, leaving you to attack only empty air.\n\n", false);
		}
		if(player.hasStatusAffect("FirstAttack") >= 0) {
			attack();
			return;
		}
		enemyAI();
		return;
	}
	
	var damage:Number = 0;
	//Determine if dodged!
	if((player.hasStatusAffect("Blind") >= 0 && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80)) {
		//Akbal dodges special education
		if(monster.short == "Akbal") outputText("Akbal moves like lightning, weaving in and out of your furious strikes with the speed and grace befitting his jaguar body.\n", false);
		else if(monster.short == "plain girl") outputText("You wait patiently for your opponent to drop her guard. She ducks in and throws a right cross, which you roll away from before smacking your " + player.weaponName + " against her side. Astonishingly, the attack appears to phase right through her, not affecting her in the slightest. You glance down to your " + player.weaponName + " as if betrayed.\n", false);
		else if(monster.short == "kitsune") {
			//Player Miss:
			outputText("You swing your [weapon] ferociously, confident that you can strike a crushing blow.  To your surprise, you stumble awkwardly as the attack passes straight through her - a mirage!  You curse as you hear a giggle behind you, turning to face her once again.\n\n");
		}
		else {		
			if(monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!", false);
			if(monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!", false);
			if(monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.", false);
			outputText("\n", false);
			if(player.hasStatusAffect("FirstAttack") >= 0) {
				attack();
				return;
			}
			else outputText("\n", false);
		}
		enemyAI();
		return;
	}
	//{BLOCKED ATTACK:}
	if(monster.hasStatusAffect("Earthshield") >= 0 && rand(4) == 0) {
		outputText("Your strike is deflected by the wall of sand, dirt, and rock!  Damn!\n");
		if(player.hasStatusAffect("FirstAttack") >= 0) {
			attack();
			return;
		}
		else outputText("\n", false);
		enemyAI();
		return;
	}
	//Determine damage
	/*Determine damage - str modified by enemy toughness!
	if(player.hasPerk("Double Attack") >= 0 && player.str <= 60) {
		if(player.weaponName == "deadly spear") damage = int((player.str + player.weaponAttack) - Math.random()*(monster.tou));
		else if(player.weaponName == "jeweled rapier") damage = int((player.str + player.weaponAttack) - Math.random()*(monster.tou));
		else if(player.weaponName == "katana") damage = int((player.str + player.weaponAttack) - Math.random()*(monster.tou + monster.armorDef - 5));
		else damage = int((player.str + player.weaponAttack) - Math.random()*(monster.tou + monster.armorDef));
	}*/
	//BASIC DAMAGE STUFF
	//Double Attack Hybrid Reductions
	if(player.hasPerk("Double Attack") >= 0 && player.spe >= 50 && player.str > 61 && flags[DOUBLE_ATTACK_STYLE] == 0) {
		damage = 60.5;
	}
	else damage = player.str;
	//Weapon addition!
	damage += player.weaponAttack;
	//Bonus sand trap damage!
	if(monster.hasStatusAffect("level") >= 0) damage = Math.round(damage * 1.75);
	//Determine if critical hit!
	var crit:Boolean = false;
	if(rand(100) <= 4 || (player.hasPerk("Tactician") >= 0 && player.inte >= 50 && (player.inte - 50)/5 > rand(100))) {
		crit = true;
		damage *= 1.75;
	}
	//Start figuring enemy damage resistance
	var reduction:Number = rand(monster.tou);
	//Add in enemy armor if needed
	if(player.weaponName != "jeweled rapier" && player.weaponName != "deadly spear") {
		reduction += monster.armorDef;
		//Remove half armor for lunging strikes
		if(player.hasPerk("Lunging Attacks") >= 0) 
			reduction -= monster.armorDef/2;
	}
	//Take 5 off enemy armor for katana
	if(player.weaponName == "katana") {
		//Knock off 5
		if(monster.armorDef >= 5) reduction -= 5;
		//Less than 5 armor?  TAKE IT ALL!
		else reduction -= monster.armorDef;
	}
	//Apply AND DONE!
	damage -= reduction;
	//Damage post processing!
	//Thunderous Strikes
	if(player.hasPerk("Thunderous Strikes") >= 0 && player.str >= 80) 
		damage *= 1.2;
	//One final round
	damage = Math.round(damage);
	
	//ANEMONE SHIT
	if(monster.short == "anemone") {
		//hit successful:
		//special event, block (no more than 10-20% of turns, also fails if PC has >75 corruption):
		if(rand(10) <= 1) {
			outputText("Seeing your " + player.weaponName + " raised, the anemone looks down at the water, angles her eyes up at you, and puts out a trembling lip.  ", false);
			if(player.cor < 75) {
				outputText("You stare into her hangdog expression and lose most of the killing intensity you had summoned up for your attack, stopping a few feet short of hitting her.\n", false);
				damage = 0;
				//Kick back to main if no damage occured!
				if(monster.HP > 0 && monster.lust < 100) {
					if(player.hasStatusAffect("FirstAttack") >= 0) {
						attack();
						return;
					}
					enemyAI();
				}
				else {
					if(monster.HP <= 0) doNext(5008);
					else doNext(5009);
				}
				return;
			}
			else outputText("Though you lose a bit of steam to the display, the drive for dominance still motivates you to follow through on your swing.", false);
		}
	}
	if(damage > 0) {
		if(player.hasPerk("History: Fighter") >= 0) damage *= 1.1;
		damage = doDamage(damage);
	}
	if(damage <= 0) {
		damage = 0;
		outputText("Your attacks are deflected or blocked by " + monster.a + monster.short + ".", false);
	}
	else {
		outputText("You hit " + monster.a + monster.short + "! (" + damage + ")", false);
		if(crit) outputText(" <b>*CRIT*</b>");
	}
	if(player.hasPerk("Brutal Blows") >= 0 && player.str > 75) {
		if(monster.armorDef > 0) outputText("\nYour hits are so brutal that you damage " + monster.a + monster.short + "'s defenses!");
		if(monster.armorDef - 10 > 0) monster.armorDef -= 10;
		else monster.armorDef = 0;
	}
	if(damage > 0) {
		//Lust raised by anemone contact!
		if(monster.short == "anemone") {
			outputText("\nThough you managed to hit the anemone, several of the tentacles surrounding her body sent home jolts of venom when your swing brushed past them.", false);
			//(gain lust, temp lose str/spd)
			applyVenom((1+rand(2)));
		}
		//Lust raising weapon bonuses
		if(monster.lustVuln > 0) {
			if(player.weaponPerk == "Aphrodisiac Weapon") {
				monster.lust += monster.lustVuln * (5 + player.cor/10);
				outputText("\n" + monster.capitalA + monster.short + " shivers as your weapon's 'poison' goes to work.", false);
			}
			if(player.weaponName == "coiled whip" && rand(2) == 0) {
				monster.lust += monster.lustVuln * (5 + player.cor/12);			
				if(!monster.plural) outputText("\n" + monster.capitalA + monster.short + " shivers and gets turned on from the whipping.", false);
				else outputText("\n" + monster.capitalA + monster.short + " shiver and get turned on from the whipping.", false);
			}
			if(player.weaponName == "succubi whip") {
				monster.lust += monster.lustVuln * (20 + player.cor/15);
				if(player.cor < 90) stats(0,0,0,0,0,0,0,.3);
				if(!monster.plural) outputText("\n" + monster.capitalA + monster.short + " shivers and moans involuntarily from the whip's touches.", false);
				else outputText("\n" + monster.capitalA + monster.short + " shiver and moan involuntarily from the whip's touches.", false);
				if(rand(2) == 0) {
					outputText("  You get a sexual thrill from it.", false);
					stats(0,0,0,0,0,0,1,0);
				}
			}
		}
		//Weapon Procs!
		if(player.weaponName == "huge warhammer" || player.weaponName == "spiked gauntlet" || player.weaponName == "hooked gauntlets") {
			//10% chance
			if(rand(10) == 0 && monster.hasPerk("Resolute") < 0) {
				outputText("\n" + monster.capitalA + monster.short + " reels from the brutal blow, stunned.", false);
				monster.createStatusAffect("Stunned",0,0,0,0);
			}
			//50% Bleed chance
			if(player.weaponName == "hooked gauntlets" && rand(2) == 0 && monster.armorDef < 10 && monster.hasStatusAffect("Izma Bleed") < 0) {
				monster.createStatusAffect("Izma Bleed",3,0,0,0);
				if(monster.plural) outputText("\n" + monster.capitalA + monster.short + " bleed profusely from the many, bloody gashes your hooked gauntlets leave behind.", false);
				else outputText("\n" + monster.capitalA + monster.short + " bleeds profusely from the many bloody gashes your hooked gauntlets leave behind.", false);
			}
		}
		
	}
	outputText("\n", false);
	//Kick back to main if no damage occured!
	if(monster.HP >= 1 && monster.lust <= 99) {
		if(player.hasStatusAffect("FirstAttack") >= 0) {
			attack();
			return;
		}
		outputText("\n", false);
		enemyAI();
	}
	else {
		if(monster.HP <= 0) doNext(5008);
		else doNext(5009);
	}
}
//Gore Attack - uses 15 fatigue!
function goreAttack():void {
	if(player.fatigue + physicalCost(15) > 100) {
		outputText("You're too fatigued to use a charge attack!", true);
		doNext(5000);
		return;
	}
	fatigue(15,2);
	outputText("", true);
	menuLoc = 0;
	var damage:Number = 0;
	//Amily!
	if(monster.hasStatusAffect("Concentration") >= 0) {
		outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n", true);
		enemyAI();
		return;
	}
	//Bigger horns = better success chance.
	//Small horns - 60% hit
	if(player.horns >= 6 && player.horns < 12) {
		temp = 60;
	}
	//bigger horns - 75% hit
	if(player.horns >= 12 && player.horns < 20) {
		temp = 75;
	}
	//huge horns - 90% hit
	if(player.horns >= 20) {
		temp = 80;
	}
	//Vala dodgy bitch!
	if(monster.short == "Vala") {
		temp = 20;
	}
	//Account for monster speed - up to -50%.
	temp -= monster.spe/2;
	//Account for player speed - up to +50%
	temp += player.spe/2;
	//Hit & calculation
	if(temp >= rand(100)) {
		var horns:Number = player.horns;
		if(player.horns > 40) player.horns = 40;
		//normal
		if(rand(4) > 0) {
			outputText("You lower your head and charge, skewering " + monster.a + monster.short + " on one of your bullhorns!  ", false);
			//As normal attack + horn length bonus
			damage = int(player.str + horns * 2 - rand(monster.tou) - monster.armorDef);
		}
		//CRIT
		else {
			//doubles horn bonus damage
			damage = int(player.str + horns * 4 - rand(monster.tou) - monster.armorDef);
			outputText("You lower your head and charge, slamming into " + monster.a + monster.short + " and burying both your horns into " + monster.pronoun2 + "!  ", false);
		}
		//Bonus damage for rut!
		if(player.hasStatusAffect("rut") >= 0 && monster.cockTotal() > 0) {
			outputText("The fury of your rut lent you strength, increasing the damage!  ", false);
			damage += 5;
		}
		//Bonus per level damage
		damage += player.level * 2;
		//Reduced by armor
		damage -= monster.armorDef;
		if(damage < 0) damage = 5;
		//CAP 'DAT SHIT
		if(damage > player.level * 10 + 100) damage = player.level * 10 + 100;
		if(damage > 0) {
			if(player.hasPerk("History: Fighter") >= 0) damage *= 1.1;
			damage = doDamage(damage);
		}
		//Different horn damage messages
		if(damage < 20) outputText("You pull yourself free, dealing " + damage + " damage.", false);
		if(damage >= 20 && damage < 40) outputText("You struggle to pull your horns free, dealing " + damage + " damage.", false);
		if(damage >= 40) outputText("With great difficulty you rip your horns free, dealing " + damage + " damage.", false);
	}
	//Miss
	else {
		//Special vala changes
		if(monster.short == "Vala") {
			outputText("You lower your head and charge Vala, but she just flutters up higher, grabs hold of your horns as you close the distance, and smears her juicy, fragrant cunt against your nose.  The sensual smell and her excited moans stun you for a second, allowing her to continue to use you as a masturbation aid, but she quickly tires of such foreplay and flutters back with a wink.\n\n", false);
			stats(0,0,0,0,0,0,5,0);
		}
		else outputText("You lower your head and charge " + monster.a + monster.short + ", only to be sidestepped at the last moment!", false);
	}
	//New line before monster attack
	outputText("\n\n", false);
	//Victory ORRRRR enemy turn.
	if(monster.HP > 0 && monster.lust < 100) enemyAI();
	else {
		if(monster.HP <= 0) doNext(5008);
		if(monster.lust >= 100) doNext(5009);
	}
}
//Player sting attack
function playerStinger():void {
	menuLoc = 0;
	//Clear Text
	outputText("", true);
	//Determine if dodged!
	//Amily!
	if(monster.hasStatusAffect("Concentration") >= 0) {
		outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n", true);
		enemyAI();
		return;
	}
	if(monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80) {
		if(monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your stinger!\n\n", false);
		if(monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your stinger with superior quickness!\n\n", false);
		if(monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attempts to sting " + monster.pronoun2 + ".\n\n", false);
		enemyAI();
		return;
	}
	//determine if avoided with armor.
	if(monster.armorDef - player.level >= 10 && rand(4) > 0) {
		outputText("Despite your best efforts, your sting attack can't penetrate " +  monster.a + monster.short + "'s defenses.\n\n", false);
		enemyAI();
		return;
	}
	//Sting successful!
	outputText("Searing pain lances through " + monster.a + monster.short + " as you manage to sting " + monster.pronoun2 + "!  ", false);
	if(monster.plural) outputText("You watch as " + monster.pronoun1 + " stagger back a step and nearly trip, flushing hotly.", false);
	else outputText("You watch as " + monster.pronoun1 + " staggers back a step and nearly trips, flushing hotly.", false);
	//Tabulate damage!
	var damage:Number = 35 + rand(player.lib/10);
	//Level adds more damage up to a point (level 20)
	if(player.level < 10) damage += player.level * 3;
	else if(player.level < 20) damage += 30 + (player.level-10) * 2;
	else damage += 50;
	monster.lust += monster.lustVuln * damage;
	if(monster.hasStatusAffect("lust venom") < 0) monster.createStatusAffect("lust venom", 0, 0, 0, 0);
	/* IT used to paralyze 50% of the time, this is no longer the case!
	Paralise the other 50%!
	else {
		outputText("Searing pain lances through " + monster.a + monster.short + " as you manage to sting " + monster.pronoun2 + "!  ", false);
		if(monster.short == "demons") outputText("You watch as " + monster.pronoun1 + " stagger back a step and nearly trip, finding it hard to move as " + monster.pronoun1 + " are afflicted with your paralytic venom.  ", false);
		else outputText("You watch as " + monster.pronoun1 + " staggers back a step and nearly trips, finding it hard to move as " + monster.pronoun1 + " is afflicted with your paralytic venom.  ", false);
		if(monster.short == "demons") outputText("It appears that " + monster.a + monster.short + " are weaker and slower.", false);
		else outputText("It appears that " + monster.a + monster.short + " is weaker and slower.", false);
		monster.str -= (5+rand(player.lib/5))
		monster.spe -= (5+rand(player.lib/5))
		if(monster.str < 1) monster.str = 1;
		if(monster.spe < 1) monster.spe = 1;
	}*/
	//New line before monster attack
	outputText("\n\n", false);
	//Use tail mp
	player.tailVenom -= 25;
	//Kick back to main if no damage occured!
	if(monster.HP > 0 && monster.lust < 100) enemyAI();
	else doNext(5009);
}
function combatMiss():Boolean {
	if(player.spe - monster.spe > 0 && int(Math.random()*(((player.spe-monster.spe)/4)+80)) > 80) return true;
	return false;
}
function combatEvade():Boolean {
	if(monster.short != "Kiha" && player.hasPerk("Evade") >= 0 && rand(100) < 10) return true;
	return false;
}
function combatFlexibility():Boolean {
	if(player.hasPerk("Flexibility") >= 0 && rand(100) < 6) return true;
	return false;
}
function combatMisdirect():Boolean {
	if(player.hasPerk("Misdirection") >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") 
		return true;
	return false;
}


function eAttack():void {
	//Gnolls do their own shit
	if(monster.short == "gnoll spear-thrower" || monster.short == "alpha gnoll") {
		hyenaPhysicalAttack();
		return;
	}
	//Ackbal does his own thing!
	if(monster.short == "Akbal") {
		akabalAttack();
		return;
	}
	if(monster.short == "gnoll") {
		gnollAttackText();
		return;
	}
	if(monster.short == "anemone")  outputText("Giggling playfully, the anemone launches several tentacles at you.  Most are aimed for your crotch, but a few attempt to caress your chest and face.\n", false);
	if(monster.short == "Izma") outputText("Izma slides up to you, throws a feint, and then launches a rain of jabs at you!\n", false);
	if(monster.short == "Sirius, a naga hypnotist") outputText("Sirius readies his hands, undulating his body erratically with quick motions in order to catch you off-guard and strike at you.\n");
	var damage:Number = 0;
	//Blind dodge change
	if(monster.short != "Kiha" && monster.hasStatusAffect("Blind") >= 0 && rand(3) < 2) {
		if(monster.weaponVerb == "tongue-slap") outputText(monster.capitalA + monster.short + " completely misses you with a thrust from her tongue!\n", false);
		else outputText(monster.capitalA + monster.short + " completely misses you with a blind attack!\n", false);
		//See below, removes the attack count once it hits rock bottom.
		if(monster.statusAffectv1("attacks") == 0) monster.removeStatusAffect("attacks");
		//Count down 1 attack then recursively call the function, chipping away at it.
		if(monster.statusAffectv1("attacks") - 1 >= 0) {
			monster.addStatusValue("attacks",1,-1);
			eAttack();
		}
		if(!combatRoundOver()) doNext(1);
		return;
	}
	//Determine if dodged!
	if(player.spe - monster.spe > 0 && int(Math.random()*(((player.spe-monster.spe)/4)+80)) > 80) {
		//Harpies have own text
		if(monster.short == "harpy") outputText("With another deranged cry the harpy dives at you, swinging her razor-sharp talons through the air with the grace of a ballerina. Your quick reflexes allow you to dodge every vicious slash she makes at you.\n", false);
		else if(monster.short == "chameleon girl") outputText("The chameleon girl whips her head and sends her tongue flying at you, but you hop to the side and manage to avoid it.  The pink blur flies back into her mouth as quickly as it came at you, and she looks more than a bit angry that she didn't find her target.\n");
		else if(monster.short == "Sirius, a naga hypnotist") outputText("With your trained eyes, you see through his feints and effectively block his first swipe, then quickly twist your body to kick him away.  He clutches his belly where you kicked him, but recovers quickly, eyes fixated on yours.\n");
		else if(player.spe - monster.spe < 8) outputText("You narrowly avoid " + monster.a + monster.short + "'s " + monster.weaponVerb + "!\n", false);
		else if(player.spe - monster.spe >= 8 && player.spe-monster.spe < 20) outputText("You dodge " + monster.a + monster.short + "'s " + monster.weaponVerb + " with superior quickness!\n", false);
		else if(player.spe - monster.spe >= 20) {
			outputText("You deftly avoid " + monster.a + monster.short);
			if(monster.plural) outputText("'");
			else outputText("'s");
			outputText(" slow " + monster.weaponVerb + ".\n", false);
		}
		//See below, removes the attack count once it hits rock bottom.
		if(monster.statusAffectv1("attacks") == 0) monster.removeStatusAffect("attacks");
		//Count down 1 attack then recursively call the function, chipping away at it.
		if(monster.statusAffectv1("attacks") - 1 >= 0) {
			monster.addStatusValue("attacks",1,-1);
			eAttack();
		}
		if(!combatRoundOver()) doNext(1);
		return;
	}
	//Determine if evaded
	if(monster.short != "Kiha" && player.hasPerk("Evade") >= 0 && rand(100) < 10) {
		outputText("Using your skills at evading attacks, you anticipate and sidestep " + monster.a + monster.short + "'");
		if(!monster.plural) outputText("s");
		outputText(" attack.\n", false);
		//See below, removes the attack count once it hits rock bottom.
		if(monster.statusAffectv1("attacks") == 0) monster.removeStatusAffect("attacks");
		//Count down 1 attack then recursively call the function, chipping away at it.
		if(monster.statusAffectv1("attacks") - 1 >= 0) {
			monster.addStatusValue("attacks",1,-1);
			eAttack();
		}
		if(!combatRoundOver()) doNext(1);
		return;
	}
	//("Misdirection"
	if(player.hasPerk("Misdirection") >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
		outputText("Using Raphael's teachings, you anticipate and sidestep " + monster.a + monster.short + "' attacks.\n", false);
		//See below, removes the attack count once it hits rock bottom.
		if(monster.statusAffectv1("attacks") == 0) monster.removeStatusAffect("attacks");
		//Count down 1 attack then recursively call the function, chipping away at it.
		if(monster.statusAffectv1("attacks") - 1 >= 0) {
			monster.addStatusValue("attacks",1,-1);
			eAttack();
		}
		if(!combatRoundOver()) doNext(1);
		return;
	}
	//Determine if cat'ed
	if(player.hasPerk("Flexibility") >= 0 && rand(100) < 6) {
		outputText("With your incredible flexibility, you squeeze out of the way of " + monster.a + monster.short + "", false);
		if(monster.plural) outputText("' attacks.\n", false);
		else outputText("'s attack.\n", false);
		//See below, removes the attack count once it hits rock bottom.
		if(monster.statusAffectv1("attacks") == 0) monster.removeStatusAffect("attacks");
		//Count down 1 attack then recursively call the function, chipping away at it.
		if(monster.statusAffectv1("attacks") - 1 >= 0) {
			monster.addStatusValue("attacks",1,-1);
			eAttack();
		}
		if(!combatRoundOver()) doNext(1);
		return;
	}
	//Determine damage - str modified by enemy toughness!
	damage = int((monster.str + monster.weaponAttack) - rand(player.tou) - player.armorDef);
	if(damage > 0 && monster.short != "anemone") damage = takeDamage(damage);
	if(damage <= 0) {
		damage = 0;
		//hapies have their own shit
		if(monster.short == "harpy") outputText("The harpy dives at you with her foot-talons, but you deflect the attack, grasp onto her leg, and swing her through the air, tossing her away from you before she has a chance to right herself.", false);
		//Due to toughness or amor...
		else if(monster.short == "chameleon girl") outputText("The Chameleon Girl lashes out with her tongue, but you deflect the sticky projectile off your arm, successfully defending against it.  She doesn't look happy about it when she slurps the muscle back into her mouth.");
		else if(rand(player.armorDef + player.tou) < player.armorDef) outputText("You absorb and deflect every " + monster.weaponVerb + " with your " + player.armorName + ".", false);
		else {
			if(monster.plural) outputText("You deflect and block every " + monster.weaponVerb + " " + monster.a + monster.short + " throw at you.", false);
			else outputText("You deflect and block every " + monster.weaponVerb + " " + monster.a + monster.short + " throws at you.", false);
		}
	}
	//harpies r special
	else if(monster.short == "harpy") outputText("The harpy surges forward, bringing her razor-sharp claws down on you, tearing at all the exposed flesh she can reach! (" + damage + ")", false);
	else if(monster.short == "anemone") {
		damage = 0;
		outputText("You jink and dodge valiantly but the tentacles are too numerous and coming from too many directions.  A few get past your guard and caress your skin, leaving a tingling, warm sensation that arouses you further.", false); 
		//(plus lust, temp minus spd/str) 
		applyVenom(rand(4 + player.sens/20) + 1);
	}
	//Chameleon
	else if(monster.short == "chameleon girl") outputText("The chameleon whips her head forward and sends her tongue flying at you.  It catches you in the gut, the incredible force behind it staggering you.  The pink blur flies back into her mouth as quickly as it came at you, and she laughs mockingly as you recover your footing. (" + damage + ")");
	else if(monster.short == "Sirius, a naga hypnotist") outputText("You misjudge his pattern and wind up getting slashed by a series of swipes from his sharpened nails.  He distances himself from you in order to avoid retaliation and glares at you with his piercing yellow eyes, a hint of a smile on his face. (" + damage + ")");
	//everyone else
	else if(damage < 6) outputText("You are struck a glancing blow by " + monster.a + monster.short + "! (" + damage + ")", false);
	else if(damage < 11) {
		outputText(monster.capitalA + monster.short + " wound");
		if(!monster.plural) outputText("s");
		outputText(" you! (" + damage + ")", false);
	}
	else if(damage < 21) {
		outputText(monster.capitalA + monster.short + " stagger");
		if(!monster.plural) outputText("s");
		outputText(" you with the force of " + monster.pronoun3 + " " + monster.weaponVerb + "! (" + damage + ")", false);
	}
	else if(damage > 20) {
		outputText(monster.capitalA + monster.short + " <b>mutilate", false);
		if(!monster.plural || monster.short == "harpy horde") outputText("s", false);
		outputText("</b> you with " + monster.pronoun3 + " powerful " + monster.weaponVerb + "! (" + damage + ")", false);
	}
	if(damage > 0) {
		if(monster.short == "fetish zealot") {
			outputText("\nYou notice that some kind of unnatural heat is flowing into your body from the wound", false);
			if(player.inte > 50) outputText(", was there some kind of aphrodisiac on the knife?", false);
			else outputText(".", false);
			stats(0,0,0,0,0,0,(player.lib/20 + 5),0);
		}
		if(monster.lustVuln > 0 && player.armorName == "barely-decent bondage straps") {
			if(!monster.plural) outputText("\n" + monster.capitalA + monster.short + " brushes against your exposed skin and jerks back in surprise, coloring slightly from seeing so much of you revealed.", false);
			else outputText("\n" + monster.capitalA + monster.short + " brush against your exposed skin and jerk back in surprise, coloring slightly from seeing so much of you revealed.", false);
			monster.lust += 5 * monster.lustVuln;
		}
	}
	if(monster.short == "Kiha") {
		damage = 15+rand(6);
		damage = takeDamage(damage);
		outputText("\nAn afterwash of flames trails behind her blow, immolating you! (" + damage + ")", false);
	}
	statScreenRefresh();
	outputText("\n", false);
	//See below, removes the attack count once it hits rock bottom.
	if(monster.statusAffectv1("attacks") == 0) monster.removeStatusAffect("attacks");
	//Count down 1 attack then recursively call the function, chipping away at it.
	if(monster.statusAffectv1("attacks") - 1 >= 0) {
		monster.addStatusValue("attacks",1,-1);
		eAttack();
	}
	if(!combatRoundOver()) doNext(1);
}

//DEAL DAMAGE
function doDamage(damage:Number):Number {
	if(player.hasPerk("Sadist") >= 0) {
		damage *= 1.2;
		stats(0,0,0,0,0,0,3,0);
	}
	if(monster.HP - damage <= 0) {
		if(monster.hasPerk("Last Strike") >= 0) doNext(monster.perks[monster.hasPerk("Last Strike")].value1);
		else doNext(5008);
	}
	damage = Math.round(damage);
	
	if(damage < 0) damage = 1;
	monster.HP -= damage;
	//Isabella gets mad
	if(monster.short == "Isabella") {
		flags[ISABELLA_AFFECTION]--;
		//Keep in bounds
		if(flags[ISABELLA_AFFECTION] < 0) flags[ISABELLA_AFFECTION] = 0;
	}
	//Interrupt gigaflare if necessary.
	if(monster.hasStatusAffect("Gigafire") >= 0) monster.addStatusValue("Gigafire",1,damage);
	//Keep shit in bounds.
	if(monster.HP < 0) monster.HP = 0;
	return damage;
}
function takeDamage(damage:Number, noMod:Boolean = false):Number {
	//EZ MOAD half damage
	if(flags[EASY_MODE_ENABLE_FLAG] == 1) damage /= 2;
	if(player.hasStatusAffect("Shielding") >= 0) {
		damage -= 30;
		if(damage < 1) damage = 1;
	}
	//Black cat beer = 25% reduction!
	if(player.statusAffectv1("Black Cat Beer") >= 0)
		damage = Math.round(damage * .75);

	//Take damage you masochist!
	if(player.hasPerk("Masochist") >= 0 && player.lib >= 60 && !noMod) {
		damage = Math.round(damage * .7);
		stats(0,0,0,0,0,0,2,0);
		//Dont let it round too far down!
		if(damage < 1) damage = 1;
	}
	if(player.hasPerk("Immovable Object") >= 0 && player.tou >= 75 && !noMod) {
		damage = Math.round(damage * .8);
		if(damage < 1) damage = 1;
	}
	//Prevent negatives
	if(player.HP - damage < 1) {
		player.HP = 0;
		hpDown.visible = true;
		if(gameState == 1 || gameState == 2) doNext(5010);
		//Round
		damage = Math.round(damage);
		if(damage < 1) damage = 1;
		return damage;
	}
	//Round
	damage = Math.round(damage);
	if(damage < 1) damage = 1;
	//Else deduct.
	else player.HP-=damage;
	if(flags[MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
		stats(0,0,0,0,0,0,int(damage/2),0);
	}
	hpDown.visible = true;
	return damage;
}
//ENEMYAI!
function enemyAI():void {
	if(monster.skinTone == "helspawn") {
		helSpawnAI();
		return;
	}
	if(monster.short == "Zetaz") {
		zetazAI();
		return;
	}
	if(monster.short == "minotaur gang" || monster.short == "minotaur tribe") {
		minoGangAI();
		return;
	}
	if(monster.hasStatusAffect("Stunned") >= 0) {
		if(monster.plural) outputText("Your foes are too dazed from your last hit to strike back!", false);
		else outputText("Your foe is too dazed from your last hit to strike back!", false);
		if(monster.statusAffectv1("Stunned") <= 0) monster.removeStatusAffect("Stunned");
		else monster.addStatusValue("Stunned",1,-1);
		combatRoundOver();
		return;
	}
	if(monster.hasStatusAffect("Fear") >= 0) {
		if(monster.short == "Kiha") {
			monster.removeStatusAffect("Fear");
			outputText("Kiha shudders for a moment, then looks your way with a clear head.  \"<i>Fear was the first thing the demons taught us to overcome.  Do you think it would stay my blade?</i>\"\n", false);
			kihaAI();
			return;
		}
		if(monster.statusAffectv1("Fear") == 0) {
			if(monster.plural) {
				monster.removeStatusAffect("Fear");
				outputText("Your foes shake free of their fear and ready themselves for battle.", false);				
			}
			else {
				monster.removeStatusAffect("Fear");
				outputText("Your foe shakes free of its fear and readies itself for battle.", false);
			}
		}
		else {
			monster.addStatusValue("Fear",1,-1);
			if(monster.plural) outputText(monster.capitalA + monster.short + " are too busy shivering with fear to fight.", false);
			else outputText(monster.capitalA + monster.short + " is too busy shivering with fear to fight.", false);
		}
		combatRoundOver();
		return;
	}
	var select:Number=1;
	var rando:Number=1;
	//Exgartuan gets to do stuff!
	if(player.hasStatusAffect("Exgartuan") >= 0 && player.statusAffectv2("Exgartuan") == 0 && rand(3) == 0) {
		if(exgartuanCombatUpdate()) outputText("\n\n", false);
	}
	if(monster.hasStatusAffect("Constricted") >= 0) {
		//Enemy struggles - 
		outputText("Your prey pushes at your tail, twisting and writhing in an effort to escape from your tail's tight bonds.", false);
		if(monster.statusAffectv1("Constricted") <= 0) {
			outputText("  " + monster.capitalA + monster.short + " proves to be too much for your tail to handle, breaking free of your tightly bound coils.", false);
			monster.removeStatusAffect("Constricted");
		}
		monster.addStatusValue("Constricted",1,-1);
		combatRoundOver();
		return;
	}
	//If grappling...
	if(gameState == 2) {
		//temperment - used for determining grapple behaviors
		//0 - avoid grapples/break grapple
		//1 - lust determines > 50 grapple
		//2 - random
		//3 - love grapples
//		if(monster.temperment == 0) eGrappleRetreat();
		if(monster.temperment == 1) {
//			if(monster.lust < 50) eGrappleRetreat();
			doNext(3);
			return;
		}
		outputText("Lust Placeholder!!", false);
		doNext(3);	
		return;
	}
	if(monster.short == "Holli") {
		holliAI();
		return;
	}
	if(monster.short == "Sheila") {
		sheilaAI();
		return;
	}
	if(monster.short == "imp lord") {
		impLordAI();
		return;
	}
	if(monster.short == "Cum Witch") {
		cumWitchAI();
		return;
	}
	if(monster.short == "Sand Mother") {
		sandWitchMotherAI();
		return;
	}
	if(monster.short == "sand witches") {
		sandWitchMobAI();
		return;
	}
	if(monster.short == "Minerva") {
		minervaAI();
		return;
	}
	if(monster.short == "Kelt") {
		kellyAI();
		return;
	}
	if(monster.short == "minotaur lord") {
		fidoAI();
		return;
	}
	if(monster.short == "kitsune") {
		kitsuneAI();
		return;
	}
	if(monster.short == "chameleon girl") {
		chameleonAI();
		return;
	}
	if(monster.short == "Sirius, a naga hypnotist") {
		nagaSiriusRadioAI();
		return;
	}
	if(monster.short == "milky succubus") {
		milkSuccubusAI();
		return;
	}
	if(monster.short == "Ember") {
		emberAI();
		return;
	}
	if(monster.short == "satyr") {
		satyrAI();
		return;
	}
	if(monster.short == "lusty demons") {
		vapulaAI();
		return;
	}
	if(monster.short == "farmers") {
		farmersAI();
		return;
	}
	if(monster.short == "Harpy Queen") {
		harpyQueenAI();
		return;
	}
	if(monster.short == "phoenix platoon") {
		phoenixPlatoonAI();
		return;
	}
	if(monster.short == "Brigid the Jailer") {
		BrigidAI();
		return;
	}
	if(monster.short == "mob of spiders-morphs") {
		spiderHordeAI();
		return;
	}
	if(monster.short == "harpy horde") {
		harpyHordeAI();
		return;
	}
	if(monster.short == "Goo Armor") {
		gooArmorAI();
		return;
	}
	if(monster.short == "salamander" || monster.short == "Hel") {
		helAI();
		return;
	}
	if(monster.short == "goo-girl") {
		gooAI();
		return;
	}
	if(monster.short == "plain girl") {
		shouldraAI();
		return;
	}
	if(monster.short == "Kiha") {
		kihaAI();
		return;
	}
	if(monster.short == "basilisk") {
		basiliskAI();
		return;
	}
	if(monster.short == "corrupted drider") {
		driderAI();
		return;
	}
	if(monster.short == "Izma") {
		IzmaAI();
		return;
	}
	if(monster.short == "female spider-morph" || monster.short == "male spider-morph") {
		spiderAI();
		return;
	}
	if(monster.short == "Isabella") {
		isabellaAI();
		return;
	}
	if(monster.short == "amily") {
		amilyAI();
		return;
	}
	if(monster.short == "gnoll" || monster.short == "alpha gnoll") {
		gnollAI();
		return;
	}
	if(monster.short == "Vala") {
		valaAI();
		return;
	}
	if(monster.short == "imp horde") {
		impGangAI();
		return;
	}
	if(monster.short == "pod") {
		encapsulationPodAI();
		return;
	}
	//Sophie has special AI in harpySophie.as
	if(monster.short == "Sophie") {
		sophieAI();
		return;
	}
	//Harpies have special AI in harpy.as
	if(monster.short == "harpy") {
		harpyAI();
		return;
	}
	//Ceraph has special AI in ceraph.as
	if(monster.short == "Ceraph") {
		ceraphAI();
		return;
	}
	//Tamani's Daughters have special AI in tamanisDaughters.as
	if(monster.short == "Tamani's daughters") {
		tamanisDaughtersAI();
		return;
	}
	//Demon pack has different AI
	if(monster.short == "demons") {
		rando = rand(2);
		if(rando == 0) eventParser(monster.special1);
		if(rando == 1) eventParser(monster.special2);
		return;		
	}
	//Worms have different AI
	if(monster.short == "worms") {
		rando = rand(2);
		if(rando == 0) eventParser(monster.special1);
		if(rando == 1) eventParser(monster.special2);
		return;		
	}
	//tentacle beasts have special AI
	if(monster.short == "tentacle beast") {
		rando = rand(2);
		if(rando == 0 || monster.hasStatusAffect("TentacleCoolDown") >= 0) eventParser(monster.special1);
		else eventParser(monster.special2);
		return;
	}
	if(monster.hasStatusAffect("level") >= 0) {
		sandTrapAI();
		return;
	}
	if(monster.special1 > 0) select++;
	if(monster.special2 > 0) select++;
	if(monster.special3 > 0) select++;
	rando = int(Math.random()*select);
	//Cultist does not do physical attacks. 
	if(monster.short == "fetish cultist") rando = 1 + rand(2);
	if(rando == 0) eAttack();
	if(rando == 1) eventParser(monster.special1);
	if(rando == 2) eventParser(monster.special2);
	if(rando == 3) eventParser(monster.special3);
}
//Clear statuses
function clearStatuses(visibility:Boolean):void {
	while(player.hasStatusAffect("Web") >= 0) {
		player.spe += player.statusAffectv1("Web");
		speUp.visible = true;
		speDown.visible = false;
		player.removeStatusAffect("Web");
	}
	if(player.hasStatusAffect("Shielding") >= 0) player.removeStatusAffect("Shielding");
	if(player.hasStatusAffect("Holli Constrict") >= 0) player.removeStatusAffect("Holli Constrict");
	if(player.hasStatusAffect("lust stones") >= 0) player.removeStatusAffect("lust stones");
	if(monster.hasStatusAffect("sandstorm") >= 0) monster.removeStatusAffect("sandstorm");
	if(player.hasStatusAffect("Sealed") >= 0) {
		player.removeStatusAffect("Sealed");
	}
	if(player.hasStatusAffect("Berzerking") >= 0) {
		player.removeStatusAffect("Berzerking");
		applyArmorStats(player.armorName, false);
		player.weaponAttack = fixedDamage(player.weaponName);
	}
	if(monster.hasStatusAffect("Tail Whip") >= 0) {
		monster.removeStatusAffect("Tail Whip");
		applyArmorStats(player.armorName, false);
	}
	if(player.hasStatusAffect("UBERWEB") >= 0) player.removeStatusAffect("UBERWEB");
	if(player.hasStatusAffect("Drider Kiss") >= 0) player.removeStatusAffect("Drider Kiss");
	if(player.hasStatusAffect("Web-Silence") >= 0) player.removeStatusAffect("Web-Silence");
	if(player.hasStatusAffect("GooArmorSilence") >= 0) player.removeStatusAffect("GooArmorSilence");
	if(player.hasStatusAffect("Bound") >= 0) player.removeStatusAffect("Bound");
	if(player.hasStatusAffect("GooArmorBind") >= 0) player.removeStatusAffect("GooArmorBind");
	if(player.hasStatusAffect("Whispered") >= 0) player.removeStatusAffect("Whispered");
	if(player.hasStatusAffect("Akbal Speed") >= 0) {
		stats(0,0,player.statusAffectv1("Akbal Speed") * -1,0,0,0,0,0);
		player.removeStatusAffect("Akbal Speed");
	}		
	if(player.hasStatusAffect("Amily Venom") >= 0) {
		stats(player.statusAffectv1("Amily Venom"),0,player.statusAffectv2("Amily Venom"),0,0,0,0,0);
		player.removeStatusAffect("Amily Venom");
	}
	while(player.hasStatusAffect("Blind") >= 0) {
		player.removeStatusAffect("Blind");
	}
	if(player.hasStatusAffect("Sheila Oil") >= 0) {
		player.removeStatusAffect("Sheila Oil");
	}
	if(monster.hasStatusAffect("Twu Wuv") >= 0) {
		player.inte += monster.statusAffectv1("Twu Wuv");
		statScreenRefresh();
		inteDown.visible = false;
		inteUp.visible = true;		
	}
	if(player.hasStatusAffect("Naga Venom") >= 0) {
		player.spe += player.statusAffectv1("Naga Venom");
		speUp.visible = true;
		speDown.visible = false;
		//stats(0,0,player.statusAffectv1("Naga Venom"),0,0,0,0,0);
		player.removeStatusAffect("Naga Venom");
	}
	if(player.hasStatusAffect("TentacleBind") >= 0) player.removeStatusAffect("TentacleBind");
	if(player.hasStatusAffect("Naga Bind") >= 0) player.removeStatusAffect("Naga Bind");
	if(player.hasStatusAffect("Stone Lust") >= 0) {
		player.removeStatusAffect("Stone Lust");
	}
	player.removeStatusAffect("FirstAttack");
	if(player.hasStatusAffect("Temporary Heat") >= 0) player.removeStatusAffect("Temporary Heat");
	if(player.hasStatusAffect("NoFlee") >= 0) player.removeStatusAffect("NoFlee");
	if(player.hasStatusAffect("Poison") >= 0) player.removeStatusAffect("Poison");
	if(player.hasStatusAffect("Isabella Stunned") >= 0) player.removeStatusAffect("Isabella Stunned");
	if(player.hasStatusAffect("Stunned") >= 0) player.removeStatusAffect("Stunned");
	if(player.hasStatusAffect("Confusion") >= 0) player.removeStatusAffect("Confusion");
	if(player.hasStatusAffect("Throat Punch") >= 0) player.removeStatusAffect("Throat Punch");
	if(player.hasStatusAffect("Kiss of Death") >= 0) player.removeStatusAffect("Kiss of Death");
	if(player.hasStatusAffect("Acid Slap") >= 0) player.removeStatusAffect("Acid Slap");
	if(player.hasStatusAffect("GooBind") >= 0) player.removeStatusAffect("GooBind");
	if(player.hasStatusAffect("HarpyBind") >= 0) player.removeStatusAffect("HarpyBind");
	if(player.hasStatusAffect("Called Shot") >= 0) {
		player.spe += player.statusAffectv1("Called Shot");
		speDown.visible = false;
		speUp.visible = true;
		player.removeStatusAffect("Called Shot");
	}
	if(player.hasStatusAffect("DemonSeed") >= 0) {
		player.removeStatusAffect("DemonSeed");
	}
	if(player.hasStatusAffect("paralyze venom") >= 0) {
		player.str += player.statusAffects[player.hasStatusAffect("paralyze venom")].value1
		player.spe += player.statusAffects[player.hasStatusAffect("paralyze venom")].value2
		player.removeStatusAffect("paralyze venom");
	}
	if(player.hasStatusAffect("lust venom") >= 0) {
		player.removeStatusAffect("lust venom");
	}
	if(player.hasStatusAffect("infestAttempted") >= 0) {
		player.removeStatusAffect("infestAttempted");
	}
	if(player.hasStatusAffect("Might") >= 0) {
		stats(-player.statusAffectv1("Might"),-player.statusAffectv2("Might"),0,0,0,0,0,0);
		player.removeStatusAffect("Might");
	}
	if(player.hasStatusAffect("Charge Weapon") >= 0) {
		player.weaponAttack -= player.statusAffectv1("Charge Weapon");
		player.removeStatusAffect("Charge Weapon");
	}
	if(player.hasStatusAffect("Disarmed") >= 0) {
		player.removeStatusAffect("Disarmed");
		if(player.weaponName == "fists") {
			player.weaponName = flags[UNKNOWN_FLAG_NUMBER_00268];
			player.weaponAttack = fixedDamage(flags[UNKNOWN_FLAG_NUMBER_00268]);
		}
		else {
			flags[UNKNOWN_FLAG_NUMBER_00234] = lootWeaponName(flags[UNKNOWN_FLAG_NUMBER_00268]);
		}
	}
	if(player.hasStatusAffect("Anemone Venom") >= 0) {
		player.str += player.statusAffectv1("Anemone Venom");
		player.spe += player.statusAffectv2("Anemone Venom");
		//Make sure nothing got out of bounds
		stats(0,0,0,0,0,0,0,0);
		speUp.visible = true;
		strUp.visible = true;
		player.removeStatusAffect("Anemone Venom");
	}
	if(player.hasStatusAffect("Gnoll Spear") >= 0) {
		player.spe += player.statusAffectv1("Gnoll Spear");
		//Make sure nothing got out of bounds
		stats(0,0,0,0,0,0,0,0);
		speUp.visible = true;
		speDown.visible = false;
		player.removeStatusAffect("Gnoll Spear");
	}
	if(player.hasStatusAffect("Basilisk Compulsion") >= 0) player.removeStatusAffect("Basilisk Compulsion");
	if(player.hasStatusAffect("BasiliskSlow") >= 0) {
		player.spe += player.statusAffectv1("BasiliskSlow");
		speUp.visible = true;
		speDown.visible = false;
		player.removeStatusAffect("BasiliskSlow");
	}
	while(player.hasStatusAffect("Izma Bleed") >= 0) player.removeStatusAffect("Izma Bleed");
}
//Update combat status effects
function combatStatusesUpdate():void {
	//old outfit used for fetish cultists
	var oldOutfit:String = "";
	var changed:Boolean = false;
	//Reset menuloc
	menuLoc = 0;
	hideUpDown();
	if(player.hasStatusAffect("Sealed") >= 0) {
		//Countdown and remove as necessary
		if(player.statusAffectv1("Sealed") > 0) {
			player.addStatusValue("Sealed",1,-1);
			if(player.statusAffectv1("Sealed") <= 0) player.removeStatusAffect("Sealed");
			else outputText("<b>One of your combat abilities is currently sealed by magic!</b>\n\n");
		}
	}
	if(monster.hasStatusAffect("Milky Urta") >= 0) {
		milkyUrtaTic();
	}
	
	//Countdown
	if(monster.hasStatusAffect("TentacleCoolDown") >= 0) {
		monster.statusAffects[monster.hasStatusAffect("TentacleCoolDown")].value1--;
		if(monster.statusAffects[monster.hasStatusAffect("TentacleCoolDown")].value1 == 0) {
			monster.removeStatusAffect("TentacleCoolDown");
		}
	}
	if(monster.hasStatusAffect("Coon Whip") >= 0) {
		if(monster.statusAffectv2("Coon Whip") <= 0) {
			monster.armorDef += monster.statusAffectv1("Coon Whip");
			outputText("<b>Tail whip wears off!</b>\n\n");
			monster.removeStatusAffect("Coon Whip");
		}
		else {
			monster.addStatusValue("Coon Whip",2,-1);
			outputText("<b>Tail whip is currently reducing your foe");
			if(monster.plural) outputText("s'");
			else outputText("'s");
			outputText(" armor by " + monster.statusAffectv1("Coon Whip") + ".</b>\n\n")
		}
	}
	if(monster.hasStatusAffect("Blind") >= 0) {
		monster.addStatusValue("Blind",1,-1);
		if(monster.statusAffectv1("Blind") <= 0) {
			outputText("<b>" + monster.capitalA + monster.short + " is no longer blind!</b>\n\n", false);
			monster.removeStatusAffect("Blind");
		}
		else outputText("<b>" + monster.capitalA + monster.short + " is currently blind!</b>\n\n", false);
	}
	if(monster.hasStatusAffect("Earthshield") >= 0) {
		outputText("<b>" + monster.capitalA + monster.short + " is protected by a shield of rocks!</b>\n\n");
	}
	if(monster.hasStatusAffect("sandstorm") >= 0) {
		//Blinded: 
		if(player.hasStatusAffect("Blind") >= 0) {
			outputText("<b>You blink the sand from your eyes, but you're sure that more will get you if you don't end it soon!</b>\n\n");
			player.removeStatusAffect("Blind");
		}
		else {
			if(monster.statusAffectv1("sandstorm") == 0 || monster.statusAffectv1("sandstorm") % 4 == 0) {
				player.createStatusAffect("Blind",0,0,0,0);
				outputText("<b>The sand is in your eyes!  You're blinded this turn!</b>\n\n");
			}
			else {
				outputText("<b>The grainy mess cuts at any exposed flesh and gets into every crack and crevice of your armor.");
				temp = 1 + rand(2);
				temp = takeDamage(temp);
				outputText(" (" + temp + ")");
				outputText("</b>\n\n");
			}
		}
		monster.addStatusValue("sandstorm",1,1);
	}
	if(monster.hasStatusAffect("Stunned") >= 0) {
		outputText("<b>" + monster.capitalA + monster.short + " is still stunned!</b>\n\n", false);
	}
	if(monster.hasStatusAffect("Shell") >= 0) {
		if(monster.statusAffectv1("Shell") >= 0) {
			outputText("<b>A wall of many hues shimmers around " + monster.a + monster.short + ".</b>\n\n");
			monster.addStatusValue("Shell",1,-1);
		}
		else {
			outputText("<b>The magical barrier " + monster.a + monster.short + " erected fades away to nothing at last.</b>\n\n");
			monster.removeStatusAffect("Shell");
		}
	}
	//[Silence warning] 
	if(player.hasStatusAffect("Throat Punch") >= 0) {
		player.addStatusValue("Throat Punch",1,-1);
		if(player.statusAffectv1("Throat Punch") >= 0) outputText("Thanks to Isabella's wind-pipe crushing hit, you're having trouble breathing and are <b>unable to cast spells as a consequence.</b>\n\n", false);
		else {
			outputText("Your wind-pipe recovers from Isabella's brutal hit.  You'll be able to focus to cast spells again!\n\n", false);
			player.removeStatusAffect("Throat Punch");
		}
	}
	if(player.hasStatusAffect("GooArmorSilence") >= 0) {
		if(player.statusAffectv1("GooArmorSilence") >= 2 || rand(20) + 1 + player.str/10 >= 15) {
			//if passing str check, output at beginning of turn
			outputText("<b>The sticky slop covering your mouth pulls away reluctantly, taking more force than you would expect, but you've managed to free your mouth enough to speak!</b>\n\n");
			player.removeStatusAffect("GooArmorSilence");
		}
		else {
			outputText("<b>Your mouth is obstructed by sticky goo!  You are silenced!</b>\n\n", false);
			player.addStatusValue("GooArmorSilence",1,1);
		}
	}
	if(player.hasStatusAffect("lust stones") >= 0) {
		//[When witches activate the stones for goo bodies]
		if(player.isGoo()) {
			outputText("<b>The stones start vibrating again, making your liquid body ripple with pleasure.  The witches snicker at the odd sight you are right now.\n\n</b>");
		}
		//[When witches activate the stones for solid bodies]
		else {
			outputText("<b>The smooth stones start vibrating again, sending another wave of teasing bliss throughout your body.  The witches snicker at you as you try to withstand stand their attack.\n\n</b>");
		}
		stats(0,0,0,0,0,0,player.statusAffectv1("lust stones") + 4,0);
	}
	if(player.hasStatusAffect("Web-Silence") >= 0) {
		if(player.statusAffectv1("Web-Silence") >= 2 || rand(20) + 1 + player.str/10 >= 15) {
			outputText("You rip off the webbing that covers your mouth with a cry of pain, finally able to breathe normally again!  Now you can cast spells!\n\n", false);
			player.removeStatusAffect("Web-Silence");
		}
		else {
			outputText("<b>Your mouth and nose are obstructed by sticky webbing, making it difficult to breathe and impossible to focus on casting spells.  You try to pull it off, but it just won't work!</b>\n\n", false);
			player.addStatusValue("Web-Silence",1,1);
		}
	}		
	if(monster.hasStatusAffect("Izma Bleed") >= 0) {
		//Countdown to heal
		monster.addStatusValue("Izma Bleed",1,-1);
		//Heal wounds
		if(monster.statusAffectv1("Izma Bleed") <= 0) {
			outputText("The wounds you left on " + monster.a + monster.short + " stop bleeding so profusely.\n\n", false);
			monster.removeStatusAffect("Izma Bleed");
		}
		//Deal damage if still wounded.
		else {
			var store:Number = eMaxHP() * (3 + rand(4))/100;
			store = doDamage(store);
			if(monster.plural) outputText(monster.capitalA + monster.short + " bleed profusely from the jagged wounds your weapon left behind. (" + store + ")\n\n", false);
			else outputText(monster.capitalA + monster.short + " bleeds profusely from the jagged wounds your weapon left behind. (" + store + ")\n\n", false);
		}
	}
	if(monster.hasStatusAffect("Timer") >= 0) {
		if(monster.statusAffectv1("Timer") <= 0)
			monster.removeStatusAffect("Timer");
		monster.addStatusValue("Timer",1,-1);
	}
	if(monster.hasStatusAffect("Lust Stick") >= 0) {
		//LoT Effect Messages:
		switch(monster.statusAffectv1("Lust Stick")) {
			//First:
			case 1:
				if(monster.plural) outputText("One of " + monster.a + monster.short + " pants and crosses " + monster.mf("his","her") + " eyes for a moment.  " + monster.mf("His","Her") + " dick flexes and bulges, twitching as " + monster.mf("he","she") + " loses himself in a lipstick-fueled fantasy.  When " + monster.mf("he","she") + " recovers, you lick your lips and watch " + monster.mf("his","her") + " blush spread.\n\n", false);
				else outputText(monster.capitalA + monster.short + " pants and crosses " + monster.pronoun3 + " eyes for a moment.  " + monster.mf("His","Her") + " dick flexes and bulges, twitching as " + monster.pronoun1 + " loses himself in a lipstick-fueled fantasy.  When " + monster.pronoun1 + " recovers, you lick your lips and watch " + monster.mf("his","her") + " blush spread.\n\n", false);
				break;
			//Second:
			case 2:
				if(monster.plural) outputText(monster.capitalA + monster.short + " moan out loud, " + monster.pronoun3 + " dicks leaking and dribbling while " + monster.pronoun1 + " struggle not to touch it.\n\n", false);
				else outputText(monster.capitalA + monster.short + " moans out loud, " + monster.pronoun3 + " dick leaking and dribbling while " + monster.pronoun1 + " struggles not to touch it.\n\n", false);
				break;
			//Third:
			case 3:
				if(monster.plural) outputText(monster.capitalA + monster.short + " pump " + monster.pronoun3 + " hips futilely, air-humping non-existent partners.  Clearly your lipstick is getting to " + monster.pronoun2 + ".\n\n", false);
				else outputText(monster.capitalA + monster.short + " pumps " + monster.pronoun3 + " hips futilely, air-humping a non-existent partner.  Clearly your lipstick is getting to " + monster.pronoun2 + ".\n\n", false);
				break;
			//Fourth:
			case 4:
				if(monster.plural) outputText(monster.capitalA + monster.short + " close " + monster.pronoun2 + " eyes and grunt, " + monster.pronoun3 + " cocks twitching, bouncing, and leaking pre-cum.\n\n", false);
				else outputText(monster.capitalA + monster.short + " closes " + monster.pronoun2 + " eyes and grunts, " + monster.pronoun3 + " cock twitching, bouncing, and leaking pre-cum.\n\n", false);
				break;
			//Fifth and repeat:
			default:
				if(monster.plural) outputText("Drops of pre-cum roll steadily out of their dicks.  It's a marvel " + monster.pronoun1 + " haven't given in to " + monster.pronoun3 + " lusts yet.\n\n", false);
				else outputText("Drops of pre-cum roll steadily out of " + monster.a + monster.short + "'s dick.  It's a marvel " + monster.pronoun1 + " hasn't given in to " + monster.pronoun3 + " lust yet.\n\n", false);
				break;
		}
		monster.addStatusValue("Lust Stick",1,1);
		//Damage = 5 + bonus score minus
		//Reduced by lust vuln of course
		monster.lust += Math.round(monster.lustVuln * (5 + monster.statusAffectv2("Lust Stick")));
	}
	if(monster.hasStatusAffect("PCTailTangle") >= 0) {
		//when Entwined
		outputText("You are bound tightly in the kitsune's tails.  <b>The only thing you can do is try to struggle free!</b>\n\n");
		outputText("Stimulated by the coils of fur, you find yourself growing more and more aroused...\n\n");
		stats(0,0,0,0,0,0,5+player.sens/10,0);
	}
	if(player.hasStatusAffect("Holli Constrict") >= 0) {
		outputText("<b>You're tangled up in Holli's verdant limbs!  All you can do is try to struggle free...</b>\n\n");
	}
	if(player.hasStatusAffect("UBERWEB") >= 0)
		outputText("<b>You're pinned under a pile of webbing!  You should probably struggle out of it and get back in the fight!</b>\n\n", false);
	if(player.hasStatusAffect("Blind") >= 0 && monster.hasStatusAffect("sandstorm") < 0) {
		if(player.hasStatusAffect("Sheila Oil") >= 0) {
			if(player.statusAffectv1("Blind") <= 0) {
				outputText("<b>You finish wiping the demon's tainted oils away from your eyes; though the smell lingers, you can at least see.  Sheila actually seems happy to once again be under your gaze.</b>\n\n", false);
				player.removeStatusAffect("Blind");
			}
			else {
				outputText("<b>You scrub at the oily secretion with the back of your hand and wipe some of it away, but only smear the remainder out more thinly.  You can hear the demon giggling at your discomfort.</b>\n\n", false);
				player.addStatusValue("Blind",1,-1);
			}
		}
		else {
			//Remove blind if countdown to 0
			if(player.statusAffectv1("Blind") == 0) {
				player.removeStatusAffect("Blind");
				//Alert PC that blind is gone if no more stacks are there.
				if(player.hasStatusAffect("Blind") < 0) {
					outputText("<b>Your eyes have cleared and you are no longer blind!</b>\n\n", false);
				}
				else outputText("<b>You are blind, and many physical attacks will miss much more often.</b>\n\n", false);
			}
			else {
				player.addStatusValue("Blind",1,-1);
				outputText("<b>You are blind, and many physical attacks will miss much more often.</b>\n\n", false);
			}
		}
	}
	//Basilisk compulsion
	if(player.hasStatusAffect("Basilisk Compulsion") >= 0) {
		basiliskSpeed(15);
		//Continuing effect text: 
		outputText("<b>You still feel the spell of those grey eyes, making your movements slow and difficult, the remembered words tempting you to look into its eyes again. You need to finish this fight as fast as your heavy limbs will allow.</b>\n\n", false);
	}
	if(player.hasStatusAffect("Izma Bleed") >= 0) {
		if(player.statusAffectv1("Izma Bleed") <= 0) {
			player.removeStatusAffect("Izma Bleed");
			outputText("<b>You sigh with relief; your bleeding has slowed considerably.</b>\n\n", false);
		}
		//Bleed effect:
		else {
			var bleed:Number = (2 + rand(4))/100;
			bleed *= player.HP;
			bleed = takeDamage(bleed);
			outputText("<b>You gasp and wince in pain, feeling fresh blood pump from your wounds. (" + bleed + ")</b>\n\n", false);
		}
	}
	if(player.hasStatusAffect("Acid Slap") >= 0) {
		var slap:Number = 3 + (maxHP() * 0.02);
		outputText("<b>Your muscles twitch in agony as the acid keeps burning you. (" + slap + ")</b>\n\n", false);
	}
	if(player.hasPerk("Arousing Aura") >= 0 && monster.lustVuln > 0 && player.cor >= 70) {
		if(monster.lust < 50) outputText("Your aura seeps into " + monster.a + monster.short + " but does not have any visible effects just yet.\n\n", false);
		else if(monster.lust < 60) {
			if(!monster.plural) outputText(monster.capitalA + monster.short + " starts to squirm a little from your unholy presence.\n\n", false);
			else outputText(monster.capitalA + monster.short + " start to squirm a little from your unholy presence.\n\n", false);
		}
		else if(monster.lust < 75) outputText("Your arousing aura seems to be visibly affecting " + monster.a + monster.short + ", making " + monster.pronoun2 + " squirm uncomfortably.\n\n", false);
		else if(monster.lust < 85) {
			if(!monster.plural) outputText(monster.capitalA + monster.short + "'s skin colors red as " + monster.pronoun1 + " inadvertantly basks in your presence.\n\n", false);
			else outputText(monster.capitalA + monster.short + "' skin colors red as " + monster.pronoun1 + " inadvertantly bask in your presence.\n\n", false);
		}
		else {
			if(!monster.plural) outputText("The effects of your aura are quite pronounced on " + monster.a + monster.short + " as " + monster.pronoun1 + " begins to shake and steal glances at your body.\n\n", false);
			else outputText("The effects of your aura are quite pronounced on " + monster.a + monster.short + " as " + monster.pronoun1 + " begin to shake and steal glances at your body.\n\n", false);
		}
		monster.lust += monster.lustVuln * (2 + rand(4));
	}
	if(player.hasStatusAffect("Bound") >= 0 && flags[PC_FETISH] >= 2) {
		outputText("The feel of tight leather completely immobilizing you turns you on more and more.  Would it be so bad to just wait and let her play with you like this?\n\n", false);
		stats(0,0,0,0,0,0,3,0);
	}
	if(monster.hasStatusAffect("QueenBind") >= 0) {
		outputText("You're utterly restrained by the Harpy Queen's magical ropes!\n\n");
		if(flags[PC_FETISH] >= 2) stats(0,0,0,0,0,0,3,0);
	}
	if(player.hasStatusAffect("GooArmorBind") >= 0) {
		if(flags[PC_FETISH] >= 2) {
			outputText("The feel of the all-encapsulating goo immobilizing your helpless body turns you on more and more.  Maybe you should just wait for it to completely immobilize you, have you at its mercy.\n\n");
			stats(0,0,0,0,0,0,3,0);
		}
		else outputText("You're utterly immobilized by the goo flowing around you.  You'll have to struggle free!\n\n");
	}
	if(player.hasStatusAffect("HarpyBind") >= 0) {
		if(flags[PC_FETISH] >= 2) {
			outputText("The harpies are holding you down and restraining you, making the struggle all the sweeter!\n\n");
			stats(0,0,0,0,0,0,3,0);
		}
		else outputText("You're restrained by the harpies so that they can beat on you with impunity.  You'll need to struggle to break free!\n\n");
	}
	if(player.hasStatusAffect("Naga Bind") >= 0 && flags[PC_FETISH] >= 2) {
		outputText("Coiled tightly by the naga and utterly immobilized, you can't help but become aroused thanks to your bondage fetish.\n\n", false);
		stats(0,0,0,0,0,0,5,0);
	}
	if(player.hasStatusAffect("TentacleBind") >= 0) {
		outputText("You are firmly trapped in the tentacle's coils.  <b>The only thing you can try to do is struggle free!</b>\n\n", false);
		if(flags[PC_FETISH] >= 2) {
			outputText("Wrapped tightly in the tentacles, you find it hard to resist becoming more and more aroused...\n\n", false);
			stats(0,0,0,0,0,0,3,0);
		}
	}
	if(player.hasStatusAffect("Drider Kiss") >= 0) {
		//(VENOM OVER TIME: WEAK)
		if(player.statusAffectv1("Drider Kiss") == 0) {
			outputText("Your heart hammers a little faster as a vision of the drider's nude, exotic body on top of you assails you.  It'll only get worse if she kisses you again...\n\n", false);
			stats(0,0,0,0,0,0,8,0);
		}
		//(VENOM OVER TIME: MEDIUM)
		else if(player.statusAffectv1("Drider Kiss") == 1) {
			outputText("You shudder and moan, nearly touching yourself as your ", false);
			if(player.gender > 0) outputText("loins tingle and leak, hungry for the drider's every touch.", false);
			else outputText("asshole tingles and twitches, aching to be penetrated.", false);
			outputText("  Gods, her venom is getting you so hot.  You've got to end this quickly!\n\n", false);
			stats(0,0,0,0,0,0,15,0);
		}
		//(VENOM OVER TIME: MAX)
		else {
			outputText("You have to keep pulling your hands away from your crotch - it's too tempting to masturbate here on the spot and beg the drider for more of her sloppy kisses.  Every second that passes, your arousal grows higher.  If you don't end this fast, you don't think you'll be able to resist much longer.  You're too turned on... too horny... too weak-willed to resist much longer...\n\n", false);
			stats(0,0,0,0,0,0,25,0);
		}
	}
	//Harpy lip gloss
	if(player.hasCock() && player.hasStatusAffect("Luststick") >= 0 && (monster.short == "harpy" || monster.short == "Sophie")) {
		//Chance to cleanse!
		if(player.hasPerk("Medicine") >= 0 && rand(100) <= 14) {
			outputText("You manage to cleanse the harpy lip-gloss from your system with your knowledge of medicine!\n\n", false);
			player.removeStatusAffect("Luststick");
		}		
		else if(rand(5) == 0) {
			if(rand(2) == 0) outputText("A fantasy springs up from nowhere, dominating your thoughts for a few moments.  In it, you're lying down in a soft nest.  Gold-rimmed lips are noisily slurping around your " + cockDescript(0) + ", smearing it with her messy aphrodisiac until you're completely coated in it.  She looks up at you knowingly as the two of you get ready to breed the night away...\n\n", false);		
			else outputText("An idle daydream flutters into your mind.  In it, you're fucking a harpy's asshole, clutching tightly to her wide, feathery flanks as the tight ring of her pucker massages your " + cockDescript(0) + ".  She moans and turns around to kiss you on the lips, ensuring your hardness.  Before long her feverish grunts of pleasure intensify, and you feel the egg she's birthing squeezing against you through her internal walls...\n\n", false);
			stats(0,0,0,0,0,0,20,0);
		}
	}
	if(player.hasStatusAffect("Stone Lust") >= 0) {
		if(player.vaginas.length > 0) {
			if(player.lust < 40) outputText("You squirm as the smooth stone orb vibrates within you.\n\n", false);
			if(player.lust >= 40 && player.lust < 70) outputText("You involuntarily clench around the magical stone in your twat, in response to the constant erotic vibrations.\n\n", false);
			if(player.lust >= 70 && player.lust < 85) outputText("You stagger in surprise as a particularly pleasant burst of vibrations erupt from the smooth stone sphere in your " + vaginaDescript(0) + ".\n\n", false);
			if(player.lust >= 85) outputText("The magical orb inside of you is making it VERY difficult to keep your focus on combat, white-hot lust suffusing your body with each new motion.\n\n", false);
		}
		else {
			outputText("The orb continues vibrating in your ass, doing its best to arouse you.\n\n", false);
		}
		stats(0, 0, 0, 0, 0, 0, 7 + int(player.sens)/10, 0);
	}
	if(monster.short == "secretarial succubus" || monster.short == "milky succubus") {
		if(player.lust < 45) outputText("There is something in the air around your opponent that makes you feel warm.\n\n", false);
		if(player.lust >= 45 && player.lust < 70) outputText("You aren't sure why but you have difficulty keeping your eyes off your opponent's lewd form.\n\n", false);
		if(player.lust >= 70 && player.lust < 90) outputText("You blush when you catch yourself staring at your foe's rack, watching it wobble with every step she takes.\n\n", false);
		if(player.lust >= 90) outputText("You have trouble keeping your greedy hands away from your groin.  It would be so easy to just lay down and masturbate to the sight of your curvy enemy.  The succubus looks at you with a sexy, knowing expression.\n\n", false);
		stats(0,0,0,0,0,0,1+rand(8),0);
	}
	//[LUST GAINED PER ROUND] - Omnibus
	if(monster.hasStatusAffect("Lust Aura") >= 0) {
		if(player.lust < 33) outputText("Your groin tingles warmly.  The demon's aura is starting to get to you.\n\n", false);
 		if(player.lust >= 33 && player.lust < 66) outputText("You blush as the demon's aura seeps into you, arousing you more and more.\n\n", false); 
  		if(player.lust >= 66) {
			outputText("You flush bright red with desire as the lust in the air worms its way inside you.  ", false);
			temp = rand(4);
			if(temp == 0) outputText("You have a hard time not dropping to your knees to service her right now.\n\n", false);
			if(temp == 2) outputText("The urge to bury your face in her breasts and suckle her pink nipples nearly overwhelms you.\n\n", false);
			if(temp == 1) outputText("You swoon and lick your lips, tasting the scent of the demon's pussy in the air.\n\n", false);
			if(temp == 3) outputText("She winks at you and licks her lips, and you can't help but imagine her tongue sliding all over your body.  You regain composure moments before throwing yourself at her.  That was close.\n\n", false);
		}
		stats(0,0,0,0,0,0,(3 + int(player.lib/20 + player.cor/30)),0);
	}
	if(player.hasStatusAffect("Kiss of Death") >= 0) {
		//Effect 
		outputText("Your lips burn with an unexpected flash of heat.  They sting and burn with unholy energies as a puff of ectoplasmic gas escapes your lips.  That puff must be a part of your soul!  It darts through the air to the succubus, who slurps it down like a delicious snack.  You feel feverishly hot and exhausted....\n\n", false);
		stats(0,0,0,0,0,0,5,0);
		takeDamage(15);		
	}
	if(player.hasStatusAffect("DemonSeed") >= 0) {
		outputText("You feel something shift inside you, making you feel warm.  Finding the desire to fight this... hunk gets harder and harder.\n\n", false);
		stats(0,0,0,0,0,0,(player.statusAffects[player.hasStatusAffect("DemonSeed")].value1 + int(player.sens/30) + int(player.lib/30) + int(player.cor/30)),0);
	}
	if(player.hasStatusAffect("heat") >= 0 && player.vaginas.length > 0 && monster.totalCocks() > 0) {
		stats(0,0,0,0,0,0,(rand(player.lib/5) + 3 + rand(5)), 0);
		outputText("Your " + vaginaDescript(0) + " clenches with an instinctual desire to be touched and filled.  ", false);
		outputText("If you don't end this quickly you'll give in to your heat.\n\n", false);
	}
	if(player.hasStatusAffect("rut") >= 0 && player.totalCocks() > 0 && monster.hasVagina()) {
		stats(0,0,0,0,0,0,(rand(player.lib/5) + 3 + rand(5)), 0);
		if(player.totalCocks() > 1) outputText("Each of y", false);
		else outputText("Y", false);
		if(monster.plural) outputText("our " + multiCockDescriptLight() + " dribbles pre-cum as you think about plowing " + monster.a + monster.short + " right here and now, fucking " + monster.pronoun3 + " " + eVaginaDescript(0) + "s until they're totally fertilized and pregnant.\n\n", false);
		else outputText("our " + multiCockDescriptLight() + " dribbles pre-cum as you think about plowing " + monster.a + monster.short + " right here and now, fucking " + monster.pronoun3 + " " + eVaginaDescript(0) + " until it's totally fertilized and pregnant.\n\n", false);
	}
	if(player.hasStatusAffect("Naga Venom") >= 0) {
		//Chance to cleanse!
		if(player.hasPerk("Medicine") >= 0 && rand(100) <= 14) {
			outputText("You manage to cleanse the naga venom from your system with your knowledge of medicine!\n\n", false);
			player.spe += player.statusAffectv1("Naga Venom");
			speUp.visible = true;
			speDown.visible = false;
			player.removeStatusAffect("Naga Venom");
		}
		else if(player.spe > 3) {
			player.addStatusValue("Naga Venom",1,2);
			//stats(0,0,-2,0,0,0,0,0);
			player.spe -= 2;
		}
		else takeDamage(5);
		outputText("You wince in pain and try to collect yourself, the naga's venom still plaguing you.\n\n", false);
		takeDamage(2);
	}
	else if(player.hasStatusAffect("Temporary Heat") >= 0) {
		//Chance to cleanse!
		if(player.hasPerk("Medicine") >= 0 && rand(100) <= 14) {
			outputText("You manage to cleanse the heat and rut drug from your system with your knowledge of medicine!\n\n", false);
			player.removeStatusAffect("Temporary Heat");
		}
		else {
			stats(0,0,0,0,0,0,(player.lib/12 + 5 + rand(5)), 0);
			if(player.hasVagina()) {
				outputText("Your " + vaginaDescript(0) + " clenches with an instinctual desire to be touched and filled.  ", false);
			}
			else if(player.totalCocks() > 0) {
				outputText("Your " + cockDescript(0) + " pulses and twitches, overwhelmed with the desire to breed.  ", false);			
			}
			if(player.gender == 0) {
				outputText("You feel a tingle in your " + assholeDescript() + ", and the need to touch and fill it nearly overwhelms you.  ", false);
			}
			outputText("If you don't finish this soon you'll give in to this potent drug!\n\n", false);
		}
	}
	//Poison
	if(player.hasStatusAffect("Poison") >= 0) {
		//Chance to cleanse!
		if(player.hasPerk("Medicine") >= 0 && rand(100) <= 14) {
			outputText("You manage to cleanse the poison from your system with your knowledge of medicine!\n\n", false);
			player.removeStatusAffect("Poison");
		}
		else {
			outputText("The poison continues to work on your body, wracking you with pain!\n\n", false);
			takeDamage(8+rand(maxHP()/20));
		}
	}
	//Bondage straps + bondage fetish
	if(flags[PC_FETISH] >= 2 && player.armorName == "barely-decent bondage straps") {
		outputText("The feeling of the tight, leather straps holding tightly to your body while exposing so much of it turns you on a little bit more.\n\n", false);
		stats(0,0,0,0,0,0,2,0);
	}
	//Fetish Zealot Update!
	if(monster.short == "fetish zealot") {
		oldOutfit = monster.armorName;
		temp = rand(5);
		//Religious outfit!
		if(temp == 0 && monster.armorName != "religious clothes") {
			monster.long = "The zealot is clad in a bizarre set of religious robes.  They are similar to what you've seen on other religious leaders from home, but none that included the large slit at the front that lets his above average sized human dick stick out of the front.";
			monster.armorName = "religious clothes";
			changed = true;
		}
		//Pirate Outfit
		if(temp == 1 && monster.armorName != "pirate clothes") {
			monster.armorName = "pirate clothes";
			monster.long = "You are faced with one of the strangest things you have ever seen in your life.  A stereotypical pirate, who has not replaced his hand with a hook, but rather a collection of sex toys.  You can see at least two dildos, a fleshlight, and numerous other toys that you're incapable of recognizing.";
			changed = true;
		}
		//Military Uniform
		if(temp == 2 && monster.armorName != "military clothes") {
			monster.long = "In front of you is someone wearing a green military uniform.  They obviously aren't in any military you've ever heard of, as on his shoulder he has emblazoned <i>FF Army Sex Instructor</i>.  It seems you are his latest recruit...";
			monster.armorName = "military clothes";
			changed = true;
		}
		//Leather fetish shiiiiite
		if(temp == 3 && monster.armorName != "leather clothes") {
			monster.long = "The Zealot has taken on an appearance that seems more suitable for the level of perversion he exudes.  He is wearing a full-body suit of leather, with a cock case over his crotch; you can clearly see a large zipper on it.  The zipper handle is far bigger than you think is absolutely necessary.";
			monster.armorName = "leather clothes";
			changed = true;
		}
		//Student
		if(temp == 4 && monster.armorName != "student's clothes") {
			monster.long = "The Zealot seems to have taken on the appearance of a young adult wearing a student uniform of sorts; of course, this isn't any less perverted than any of the other costumes this man wears.  This one includes a number of loose straps that you're certain would cause large sections of his clothes to fall off if somebody pulled on them.";
			monster.armorName = "student's clothes";
			changed = true;
		}
		//Talk abouts it mang!
		if(changed) outputText("The fetish zealot's clothing shifts and twists, until he is wearing " + monster.armorName + ".\n\n", false);
		monster.lust += monster.lustVuln * 5;
	}
	//Fetish Cultist Update
	if(monster.short == "fetish cultist") {
		oldOutfit = monster.armorName;
		temp = rand(5);
		//Religious outfit!
		if(temp == 0 && monster.armorName != "pervy nun's clothing") {
			monster.long = "The woman across from you has her eyes closed, her hands joined, and seems to be chanting under her breath.  She is wearing a religious robe that closely hugs her curvacious shape. There is a specially-placed opening over her pussy lips.";
			monster.armorName = "pervy nun's clothing";
			changed = true;
		}
		//Noble outfit
		if(temp == 1 && monster.armorName != "noble's clothing") {
			monster.armorName = "noble's clothing";
				monster.long = "She's wearing a skimpy noble's dress, which lets you get a good look at her well-filled bra through an over-generous cleavage. Her skirt is so short that you clearly see her pussy lips.  She smiles at you in a rather cute way.  She looks like she's coming out of a painting, executed by a rather depraved and lust-filled artist.";
			changed = true;
		}
		//Swim outfit
		if(temp == 2 && monster.armorName != "swimsuit") {
			monster.long = "She's currently wearing a swimsuit that's apparently much too small for her, because it stretches across every curve and clearly outlines them for you to see.  Her sizable breasts look like they could burst through the fabric at any moment.  You can even see her erect nipples and her puffy lower lips.";
			monster.armorName = "swimsuit";
			changed = true;
		}
		//Pervy Teacher
		if(temp == 3 && monster.armorName != "teacher's outfit") {
			monster.long = "She's now wearing a teacher's outfit, complete with glasses, make-up, her black hair in a tight bun, and a serious-looking outfit... with no back side at all.  She turns to the side to give you a good look at her rear, smiling mischievously.";
			monster.armorName = "teacher's outfit";
			changed = true;
		}
		//Naughty Nurse
		if(temp == 4 && monster.armorName != "naughty nurse's uniform") {
			monster.long = "The woman is wearing heavy make-up and a whorish nurse's suit, seemingly in white latex with two openings at her breasts and a large one on her crotch and inner thighs. It lets her blood-gorged pussy lips hang freely, which she displays proudly.";
			monster.armorName = "naughty nurse's uniform";
			changed = true;
		}
		//Talk abouts it mang!
		if(changed) outputText("The fetish cultist's clothing shifts and twists, taking on the appearance of a " + monster.armorName + ".\n\n", false);
		monster.lust += monster.lustVuln * 3;
	}
	regeneration(true);
	if(player.lust >= 100) doNext(5011);
	if(player.HP <= 0) doNext(5010);
}

function regeneration(combat:Boolean = true):void {
	var healingPercent:int = 0;
	if(combat) {
		//Regeneration
		healingPercent = 0;
		if(player.hasPerk("Regeneration") >= 0) healingPercent += 1;
		if(player.hasPerk("Regeneration 2") >= 0) healingPercent += 2;
		if(player.armorName == "skimpy nurse's outfit") healingPercent += 2;
		if(player.armorName == "goo armor") healingPercent += 2;
		if(player.hasPerk("Lusty Regeneration") >= 0) healingPercent += 1;
		if(healingPercent > 5) healingPercent = 5;
		HPChange(Math.round(maxHP() * healingPercent / 100), false);
	}
	else {
		//Regeneration
		healingPercent = 0;
		if(player.hasPerk("Regeneration") >= 0) healingPercent += 2;
		if(player.hasPerk("Regeneration 2") >= 0) healingPercent += 4;
		if(player.armorName == "skimpy nurse's outfit") healingPercent += 2;
		if(player.armorName == "goo armor") healingPercent += 3;
		if(player.hasPerk("Lusty Regeneration") >= 0) healingPercent += 2;
		if(healingPercent > 10) healingPercent = 10;
		HPChange(Math.round(maxHP() * healingPercent / 100), false);
	}
}
function startCombat(monsterNum:Number):void {
	dataBG.visible = false;
	dataText.visible = false;
	appearanceText.visible = false;
	appearanceBG.visible = false;
	levelText2.visible = false;
	levelBG.visible = false;
	perksText.visible = false;
	perksBG.visible = false;
	//Flag the game as being "in combat"
	gameState = 1;
	//Clear arrays in preparation
	monster.removeStatuses();
	monster.removePerks();
	monster.removeCock(0, monster.cocks.length);
	monster.removeVagina(0, monster.vaginas.length);
	monster.removeBreastRow(0, monster.breastRows.length);
	monster.bonusHP = 0;
	//Clear lustvuln since it isnt set on many monsters
	monster.lustVuln = 1;
	//clear nipples pierced - only used on drider
	if(monster.nipplesPierced > 0) monster.nipplesPierced = 0;
	//load enemy based on number.
	//LOAD IMP
	if(monsterNum == 1) {
		monster.short="imp";
		monster.imageName="imp";
		monster.plural = false;
		monster.long = "An imp is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from his head, parted by two short curved horns.  His eyes are solid black, save for tiny red irises which glow with evil intent.  His skin is bright red, and unencumbered by clothing or armor, save for a small loincloth at his belt.  His feet are covered by tiny wooden sandals, and his hands tipped with sharp claws.  A pair of tiny but functional wings occasionally flap from his back.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 1;
		monster.special1 = 5019;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "he";
		monster.pronoun2 = "him";
		monster.pronoun3 = "his";
		
		//Clothing/Armor
		monster.armorName = "leathery skin";
		monster.weaponName = "claws";
		monster.weaponVerb = "claw-slash";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 20;
		monster.tou = 10;
		monster.spe = 25;
		monster.inte = 12;
		monster.lib = 45;
		monster.sens = 45;
		monster.cor = 100;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.HP = monster.tou * 2 + 50;
		monster.lust = 40;
		
		//Level Stats
		monster.level = 1;
		monster.XP = totalXP();
		monster.gems = rand(5) + 5;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = rand(24) + 25;
		monster.hairColor = "black";
		monster.hairLength = 5;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "red";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.wingDesc = "small";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 5;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 0;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 2;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 0;
		monster.breastRows[0].nipplesPerBreast = 0;
		monster.createCock();
		monster.cocks[0].cockLength = rand(2) + 11;
		monster.cocks[0].cockThickness = 2.5;
		monster.cocks[0].cockType = CockTypesEnum.HUMAN;
		monster.balls = 2;
		monster.cumMultiplier = 3;
		monster.ballSize = 1;
		monster.hoursSinceCum = 20;
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 1;
		doNext(1);
	}
	//LOAD Sand witch
	if(monsterNum == 2) {
		monster.short="sand witch";
		monster.imageName="sandwitch";
		monster.plural = false;
		monster.long = "A sand witch appears to be totally human, an oddity in this strange land.  She has dirty blonde hair and a very tanned complexion, choosing to cover most of her body with robes of the same color as the desert sands, making her impossible to spot from afar.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 1;
		monster.special1 = 5020;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "robes";
		monster.weaponName = "kick";
		monster.weaponVerb = "kick";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 25;
		monster.tou = 25;
		monster.spe = 35;
		monster.inte = 45;
		monster.lib = 55;
		monster.sens = 40;
		monster.cor = 30;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 20;
		monster.HP = eMaxHP();
		monster.lust = 30;
		
		//Level Stats
		monster.level = 3;
		monster.XP = totalXP();
		monster.gems = rand(15) + 5;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = rand(12) + 55;
		monster.hairColor = "sandy-blonde";
		monster.hairLength = 15;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "bronzed";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.wingDesc = "";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 10;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 5;
		monster.breastRows[0].nipplesPerBreast = 1;
		monster.createBreastRow();
		monster.breastRows[1].breastRating = 5;
		monster.breastRows[1].nipplesPerBreast = 1;
		monster.createVagina();
		monster.vaginas[0].vaginalWetness = 2;
		monster.vaginas[0].vaginalLooseness = 2;
		monster.vaginas[0].virgin = false;
		monster.cumMultiplier = 3;
		monster.hoursSinceCum = 20;
		monster.ass.analLooseness = 1;
		monster.ass.analWetness = 1;
		doNext(1);
	}
	//LOAD JOJO
	if(monsterNum == 3) {
		monster.short="Jojo";
		monster.imageName="Jojo";
		monster.plural = false;
		monster.long = "Jojo is an anthropomorphic mouse with immaculate white fur.  Though he stands only four feet tall, he is covered in lean muscle and moves with incredible speed.  He wears loose white clothes wrapped in prayer beads and tattered prayer papers.";
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 1;
		monster.special1 = 5021;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "he";
		monster.pronoun2 = "him";
		monster.pronoun3 = "his";
		
		//Clothing/Armor
		monster.armorName = "robes";
		monster.weaponName = "paw";
		monster.weaponVerb = "punch";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 35;
		monster.tou = 40;
		monster.spe = 65;
		monster.inte = 55;
		monster.lib = 15;
		monster.sens = 40;
		monster.cor = 0;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.HP = eMaxHP();
		monster.lust = 15;
		monster.lustVuln = .9;
		
		//Level Stats
		monster.level = 4;
		monster.XP = totalXP();
		monster.gems = rand(5) + 2;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = 61;
		monster.hairColor = "white";
		monster.hairLength = 2;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 1;
		monster.skinTone = "white";
		monster.skinDesc = "fur";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.wingDesc = "";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 2;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 2;
		//Create jojo sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 0;
		monster.breastRows[0].nipplesPerBreast = 1;
		monster.createCock();
		monster.cocks[0].cockLength = 7.5;
		monster.cocks[0].cockThickness = 1.8;
		monster.cumMultiplier = 1;
		monster.hoursSinceCum = 1000;
		monster.ass.analLooseness = 1;
		monster.ass.analWetness = 1;
		//Variations based on jojo's corruption.
		if(monk == 3) {
			monster.lust += 30;
			monster.cocks[0].cockThickness += .2;
			monster.cocks[0].cockLength += 1.5;
			if(player.gender == 1 || player.gender == 3) monster.ass.analLooseness = 2;
		}
		if(monk == 4) {
			monster.lust += 40;
			monster.cocks[0].cockThickness += .5;
			monster.cocks[0].cockLength += 3.5;
			if(player.gender == 1 || player.gender == 3) monster.ass.analLooseness = 3;
		}
		if(monk == 5) {
			monster.lust += 50;
			monster.cocks[0].cockThickness += 1;
			monster.cocks[0].cockLength += 5.5;
			monster.str -= 20;
			monster.tou += 30;
			monster.HP += 60;
			if(player.gender == 1 || player.gender == 3) monster.ass.analLooseness = 4;
			monster.long = "Jojo is an anthropomorphic mouse with immaculate white fur.  Though he stands only four feet tall, he is covered in lean muscle and moves with incredible speed.  He's naked, with a large tainted throbbing member bouncing at attention.  A fuzzy sack with painfully large looking balls dangles between his legs.";
		}
		doNext(1);
	}
	if(monsterNum == 4) {
		monster.short="minotaur";
		monster.imageName="minotaur";
		monster.plural = false;
		monster.long = "An angry-looking minotaur looms over you.  Covered in shaggy " + monster.hairColor + " fur, the beast is an imposing sight.  Wearing little but an obviously distended loincloth, he is clearly already plotting his method of punishment.  Like most minotaurs he has hooves, a cow-like tail and face, prominent horns, and impressive musculature.  <b>This minotaur seems to have found a deadly looking axe somewhere!</b>";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 1;
		monster.special1 = 5029;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "he";
		monster.pronoun2 = "him";
		monster.pronoun3 = "his";
		
		//Clothing/Armor
		monster.armorName = "thick fur";
		monster.weaponName = "axe";
		monster.weaponVerb = "cleave";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 75;
		monster.tou = 60;
		monster.spe = 30;
		monster.inte = 20;
		monster.lib = 40;
		monster.sens = 15;
		monster.cor = 35;
		monster.fatigue = 0;
		
		//Most times they dont have an axe
		if(rand(3) > 0) {
			monster.weaponName = "fist";
			monster.weaponVerb = "punch";
			monster.long = "An angry-looking minotaur looms over you.  Covered in shaggy brown fur, the beast is an imposing sight.  Wearing little but an obviously distended loincloth, he is clearly already plotting his method of punishment.  Like most minotaurs, he has hooves, a cow-like tail and face, prominent horns, and impressive musculature.";
			monster.str -= 25;
			monster.lustVuln = 0.87;
		}
		else monster.lustVuln = 0.84;
		//Combat Stats
		monster.HP = eMaxHP();
		
		
		
		//Level Stats
		monster.level = 6;
		monster.XP = totalXP();
		if(monster.weaponName == "fist") monster.level = 5;
		monster.gems = rand(5) + 5;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = rand(37) + 84;
		//randomly assign hair color
		if(rand(2) == 0) monster.hairColor = "black";
		else monster.hairColor = "brown";
		monster.hairLength = 3;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 1;
		monster.skinTone = "red";
		monster.skinDesc = "shaggy fur";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		//3 - cowface
		monster.faceType = 3;
		monster.horns = 2;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 1;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		//7 - cow!
		monster.tailType = 7;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 4;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 5;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 0;
		monster.breastRows[0].nipplesPerBreast = 1;
		monster.createCock();
		monster.cocks[0].cockLength = rand(13) + 24;
		monster.cocks[0].cockThickness = 2 + rand(3);
		monster.cocks[0].cockType = CockTypesEnum.HORSE;
		monster.balls = 2;
		monster.cumMultiplier = 1.5;
		monster.ballSize = 2 + rand(13);
		monster.hoursSinceCum = player.ballSize * 10;
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 1;
		monster.createStatusAffect("Bonus aCapacity",30,0,0,0);
		monster.lib += monster.ballSize * 2;
		monster.lust += monster.ballSize * 3;
		monster.sens += monster.ballSize * 2;
		//Extra ball description!
		if(monster.ballSize > 4) monster.long += "  Barely visible below the tattered shreds of loincloth are " + eBallsDescript() + ", swollen with the minotaur's long pent-up need.";
		monster.lust = 20 + rand(monster.ballSize*2);
		doNext(1);
	}
	//Fertile-Caste Bee
	if(monsterNum == 5) {
		monster.short="bee-girl";
		monster.imageName="bee-girl";
		monster.plural = false;
		monster.long = "A bee-girl buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, black chitin on her arms and legs that looks like shiny gloves and boots, sizable breasts, and a swollen abdomen tipped with a gleaming stinger.";
		monster.a ="a ";
		monster.capitalA ="A ";
		monster.temperment = 3;
		monster.special1 = 5036;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "chitin";
		monster.weaponName = "chitin-plated fist";
		monster.weaponVerb = "armored punch";
		monster.armorDef = 9;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 30;
		monster.tou = 30;
		monster.spe = 30;
		monster.inte = 20;
		monster.lib = 60;
		monster.sens = 55;
		monster.lust = 20 + rand(40);
		monster.cor = 0;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 0;
		monster.HP = eMaxHP();
		monster.lustVuln = 0.9;
		
		//Level Stats
		monster.level = 4;
		monster.XP = totalXP();
		monster.gems = rand(15) + 1;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = rand(14) + 59;
		//randomly assign hair color
		if(rand(2) == 0) monster.hairColor = "black";
		else monster.hairColor = "black and yellow";
		monster.hairLength = 6;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "yellow";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		//3 - cowface
		monster.faceType = 3;
		monster.antennae = 2;
		monster.horns = 0;
		monster.wingDesc = "insect-like wings";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 1;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		//7 - cow!
		monster.tailType = 6;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 100;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 13;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 13;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 5;
		monster.breastRows[0].nipplesPerBreast = 1;
		monster.createVagina();
		monster.vaginas[0].virgin = false;
		monster.vaginas[0].vaginalWetness = 5;
		monster.vaginas[0].vaginalLooseness = 3;
		monster.cumMultiplier = 1.5;
		monster.hoursSinceCum = 10 + rand(100);
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 1;
		doNext(1);
	}
	//Green Slime
	if(monsterNum == 6) {
		monster.short="green slime";
		monster.imageName="GreenSlime";
		monster.plural = false;
		monster.long = "The green slime has a normally featureless face that sits on top of wide shoulders that sprout into thick, strong arms.  Its torso fades into an indistinct column that melds into the lump of ooze on the ground that serves as a makeshift form of locomotion.";
		monster.a ="a ";
		monster.capitalA ="A ";
		monster.temperment = 3;
		monster.special1 = 5040;
		monster.special2 = 5039;
		monster.special3 = 5039;
		monster.pronoun1 = "it";
		monster.pronoun2 = "it";
		monster.pronoun3 = "its";
		
		//Clothing/Armor
		monster.armorName = "gelatinous skin";
		monster.weaponName = "hands";
		monster.weaponVerb = "slap";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 25;
		monster.tou = 20;
		monster.spe = 10;
		monster.inte = 5;
		monster.lib = 50;
		monster.sens = 60;
		monster.cor = 20;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 30;
		monster.HP = eMaxHP();
		monster.lust = 30;
		
		//Level Stats
		monster.level = 2;
		monster.XP = totalXP();
		monster.gems = rand(5)+1;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = rand(8) + 80;
		monster.hairColor = "green";
		monster.hairLength = 0;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "green";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 6;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create imp sex attributes
		monster.createCock();
		monster.cocks[0].cockLength = 18;
		monster.cocks[0].cockThickness = 2;
		monster.cocks[0].cockType = CockTypesEnum.HUMAN;
		monster.balls = 0;
		monster.cumMultiplier = 3;
		monster.ballSize = 1;
		monster.hoursSinceCum = 20;
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 5;
		doNext(1);
	}
	//LOAD DEMON PACK
	if(monsterNum == 7) {
		monster.short="demons";
		monster.imageName="DemonMob";
		monster.plural = true;
		monster.long = "The group is composed of roughly twenty tan-skinned demons, mostly humanoid in shape with many and varied corruptions across the mob. You see demonic high heels, twisting horns and swinging cocks of all shapes and sizes. There even seems to be a bull head in there somewhere. You also make out plenty of breasts ranging from tiny ones to a pair that requires a second person to carry them, and with those breasts a wide range of pussies, dripping and dry, sometimes nestled below some form of demonic dick.  The small tribe carries no weapons and what little clothing they wear is well-shredded, except for one hefty male wearing a cloak of what appears to be snakeskin across his broad shoulders.";
		if(silly()) monster.long += "  You spot an odd patch that reads, \"<i>41st Engineer Company: Vaginal Clearance</i>\" on his shoulder.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 5043;
		//Lust attack
		monster.special2 = 5044;
		monster.special3 = 0;
		monster.pronoun1 = "they";
		monster.pronoun2 = "them";
		monster.pronoun3 = "their";
		
		//Clothing/Armor
		monster.armorName = "demonic skin";
		monster.weaponName = "claws";
		monster.weaponVerb = "claw";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 80;
		monster.tou = 10;
		monster.spe = 10;
		monster.inte = 5;
		monster.lib = 50;
		monster.sens = 60;
		monster.cor = 20;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 200;
		monster.HP = eMaxHP();
		monster.lust = 30;
		
		//Level Stats
		monster.level = 6;
		monster.XP = totalXP();
		monster.gems = rand(25)+10;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 3;
		monster.tallness = rand(8) + 70;
		monster.hairColor = "black";
		monster.hairLength = 15;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "red";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 10;
		monster.hornType = 1;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 3;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 8;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create imp sex attributes
		monster.createCock();
		monster.cocks[0].cockLength = 18;
		monster.cocks[0].cockThickness = 2;
		monster.cocks[0].cockType = CockTypesEnum.HUMAN;
		monster.createCock();
		monster.cocks[1].cockLength = 18;
		monster.cocks[1].cockThickness = 2;
		monster.cocks[1].cockType = CockTypesEnum.HUMAN;
		monster.createVagina();
		monster.vaginas[0].virgin = false;
		monster.vaginas[0].vaginalWetness = 3;
		monster.vaginas[0].vaginalLooseness = 2;
		monster.balls = 0;
		monster.cumMultiplier = 3;
		monster.ballSize = 1;
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 5;
		doNext(1);
	}
	//LOAD WORM COLONY
	if(monsterNum == 8) {
		monster.short="worms";
		monster.imageName="worms";
		monster.plural = true;
		monster.long = "Before you stands the horrid mass of worms. It has shifted itself and now takes the shape of a humanoid composed completely of the worms in the colony. Its vaguely human shape lumbers towards you in a clearly aggressive manner.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 5054;
		//Lust attack
		monster.special2 = 5055;
		monster.special3 = 0;
		monster.pronoun1 = "they";
		monster.pronoun2 = "them";
		monster.pronoun3 = "their";
		
		//Clothing/Armor
		monster.armorName = "skin";
		monster.weaponName = "worm";
		monster.weaponVerb = "slap";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 35;
		monster.tou = 5;
		monster.spe = 10;
		monster.inte = 1;
		monster.lib = 90;
		monster.sens = 60;
		monster.cor = 90;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.HP = 40;
		monster.lust = 30;
		monster.lustVuln = 0;
		
		//Level Stats
		monster.level = 3;
		monster.XP = totalXP();
		monster.gems = 0;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = 1;
		monster.hairColor = "none";
		monster.hairLength = 0;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "white";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 2;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 0;
		//Create imp sex attributes
		monster.balls = 0;
		monster.cumMultiplier = 3;
		monster.ballSize = 0;
		monster.ass.analLooseness = 0;
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD FETISH CULTIST
	if(monsterNum == 9) {
		monster.short="fetish cultist";
		monster.imageName="FetishCultist";
		monster.plural = false;
		monster.long = "The woman across from you has her eyes closed, her hands joined, and seems to be chanting under her breath. She is wearing a religious outfit that closely hugs her curvacious shape, with a skirt so short that you can clearly see her pussy's lips.\n\nShe has clealy lost her grasp on sanity, and filled the void with pure perversion.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 5062;
		//Lust attack
		monster.special2 = 5063;
		monster.special3 = 5062;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "fetishy outfit";
		monster.weaponName = "whip";
		monster.weaponVerb = "whip-crack";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 35;
		monster.tou = 25;
		monster.spe = 30;
		monster.inte = 1;
		monster.lib = 75;
		monster.sens = 80;
		monster.cor = 90;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.HP = eMaxHP();
		monster.lust = 25;
		
		//Level Stats
		monster.level = 2;
		monster.XP = totalXP();
		monster.gems = 5+rand(10);
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = 67;
		monster.hairColor = "black";
		monster.hairLength = 15;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "pale";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 6;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create imp sex attributes
		monster.balls = 0;
		monster.createVagina();
		monster.vaginas[0].vaginalLooseness = 3;
		monster.vaginas[0].virgin = false;
		monster.vaginas[0].vaginalWetness = 2;
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 5;
		monster.cumMultiplier = 3;
		monster.ballSize = 0;
		monster.ass.analLooseness = 2;
		monster.ass.analWetness = 1;
		doNext(1);
	}
	//LOAD HELLHOUND
	if(monsterNum == 10) {
		monster.short="hellhound";
		monster.imageName="hellhound";
		monster.plural = false;
		monster.long = "It looks like a large demon on all fours with two heads placed side-by-side. The heads are shaped almost like human heads, but they have dog ears on the top and have a long dog snout coming out where their mouths and noses would be.  Its eyes and mouth are filled with flames and its hind legs capped with dog paws, but its front ones almost look like human hands.  Its limbs end in large, menacing claws. A thick layer of dark fur covers his entire body like armor.  Both heads look at you hungrily as the hellhound circles around you. You get the feeling that reasoning with this beast will be impossible.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 5066;
		//Lust attack
		monster.special2 = 5067;
		monster.special3 = 0;
		monster.pronoun1 = "he";
		monster.pronoun2 = "him";
		monster.pronoun3 = "his";
		
		//Clothing/Armor
		monster.armorName = "thick fur";
		monster.weaponName = "claws";
		monster.weaponVerb = "claw";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 10;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		
		//Primary stats
		monster.str = 55;
		monster.tou = 60;
		monster.spe = 40;
		monster.inte = 1;
		monster.lib = 95;
		monster.sens = 20;
		monster.cor = 100;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.HP = eMaxHP();
		monster.lust = 25;
		
		//Level Stats
		monster.level = 5;
		monster.XP = totalXP();
		monster.gems = 10+rand(10);
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = 47;
		monster.hairColor = "red";
		monster.hairLength = 3;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "black";
		monster.skinDesc = "fur";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 2;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 4;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 5;
		//Create imp sex attributes
		monster.balls = 2;
		monster.ballSize = 4;
		monster.createCock();
		monster.createCock();
		monster.cocks[0].cockLength = 8;
		monster.cocks[1].cockLength = 8;
		monster.cocks[0].cockThickness = 2;
		monster.cocks[1].cockThickness = 2;
		monster.cumMultiplier = 5;
		monster.ass.analLooseness = 2;
		monster.ass.analWetness = 1;
		doNext(1);
	}
	//LOAD SUCCUBUS
	if(monsterNum == 11) {
		plotFight = true;
		player.createStatusAffect("FactorySuccubusDefeated",0,0,0,0);
		monster.short="secretarial succubus";
		monster.imageName="SecretarialSuccubus";
		monster.plural = false;
		monster.long = "The succubus across from you balances gracefully on her spiked heels, twirling and moving unpredictably.  Sexy dark stockings hug every curve of her perfectly shaped flesh until they disappear into her tiny miniskirt.  Her impressive breasts wobble delightfully as she moves, despite the inadequate efforts of her straining vest.  A pair of foot-long horns curve up from her otherwise perfect face and forehead, wreathed in lustrous blonde hair.  The very air around her is filled with an unidentifiable fragrance that makes you tingle and shiver.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 11020;
		//Lust attack
		monster.special2 = 11021;
		monster.special3 = 11022;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "demonic skin";
		monster.weaponName = "claws";
		monster.weaponVerb = "slap";
		monster.armorDef = 4;
		monster.armorPerk = "";
		monster.weaponAttack = 10;
		monster.weaponPerk = "";
		monster.weaponValue = 150;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 50;
		monster.tou = 40;
		monster.spe = 75;
		monster.inte = 35;
		monster.lib = 80;
		monster.sens = 70;
		monster.cor = 80;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 100;
		monster.HP = eMaxHP();
		
		monster.lust = 30;
		
		//Level Stats
		monster.level = 7;
		monster.XP = totalXP() + 50;
		monster.gems = rand(25)+10;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = rand(9) + 60;
		monster.hairColor = "blond";
		monster.hairLength = 13;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "blue";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 12;
		monster.hornType = 0;
		monster.wingDesc = "tiny hidden";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 5;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 3;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 10;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 9;
		//Create succubus sex attributes
		monster.createStatusAffect("Bonus vCapacity",30,0,0,0);
		monster.createVagina();
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 5;
		monster.vaginas[0].vaginalWetness = 5;
		monster.vaginas[0].vaginalLooseness = 1;
		monster.vaginas[0].virgin = false;
		monster.balls = 0;
		monster.cumMultiplier = 3;
		monster.ballSize = 0;
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 5;
		doNext(1);
	}
	//LOAD INCUBUS
	if(monsterNum == 12) {
		plotFight = true;
		player.createStatusAffect("FactoryIncubusDefeated",0,0,0,0);
		monster.short="incubus mechanic";
		monster.imageName="IncubusMechanic";
		monster.plural = false;
		monster.long = "The demon before you is clad only in cut-off denim overalls.  Covered in stains of oil and other strange fluids, they appear to be in pretty rough shape.  There is a large hole ripped in the crotch, allowing the demon's foot-long member to hang free.  His skin is light purple and perfect, contrasting with the slovenly appearance of his clothing.  His face is rugged and handsome, topped with a simple black ponytail and two large horns that sprout from his forehead like twisted tree-trunks.  He wears a narrow goatee on his chin that is kept skillfully braided.  A cocky smile always seems to grace his features, giving him an air of supreme confidence.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 11035;
		//Lust attack
		monster.special2 = 11036;
		monster.special3 = 0;
		monster.pronoun1 = "he";
		monster.pronoun2 = "him";
		monster.pronoun3 = "his";
		
		//Clothing/Armor
		monster.armorName = "demonic skin";
		monster.weaponName = "claws";
		monster.weaponVerb = "claw";
		monster.armorDef = 10;
		monster.armorPerk = "";
		monster.weaponAttack = 10;
		monster.weaponPerk = "";
		monster.weaponValue = 150;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 65;
		monster.tou = 40;
		monster.spe = 45;
		monster.inte = 85;
		monster.lib = 80;
		monster.sens = 70;
		monster.cor = 80;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 150;
		monster.HP = eMaxHP();
		monster.lustVuln = .5;
		monster.lust = 50;
		
		//Level Stats
		monster.level = 8;
		monster.XP = totalXP();
		monster.gems = rand(25)+10;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = rand(9) + 70;
		monster.hairColor = "black";
		monster.hairLength = 12;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "light purple";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 14;
		monster.hornType = 0;
		monster.wingDesc = "tiny hidden";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 6;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 3;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 6;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 2;
		//Create succubus sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 0;
		monster.balls = 2;
		monster.cumMultiplier = 3;
		monster.createCock();
		monster.cocks[0].cockLength = 12;
		monster.cocks[0].cockThickness = 1.75;
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 5;
		doNext(1);
	}
	//LOAD OMNIBUS
	if(monsterNum == 13) {
		plotFight = true;
		player.createStatusAffect("FactoryOmnibusDefeated",0,0,0,0);
		monster.short="Omnibus Overseer";
		monster.imageName="OmnibusOverseer";
		monster.plural = false;
		monster.long = "The 'woman' before you is clothed only in a single strip of fabric that wraps around her bountiful chest.  She has striking red eyes that contrast visibly with her blue skin and dark make-up.  Shiny black gloss encapsulates her kissable bubbly black lips.  Her most striking feature is her crotch, which appears neither male nor female.  She has a puffy wet vulva, but a cock-shaped protrusion sprouts from where a clit should be.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 11043;
		//Lust attack
		monster.special2 = 11044;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "demonic skin";
		monster.weaponName = "claws";
		monster.weaponVerb = "claw";
		monster.armorDef = 15;
		monster.armorPerk = "";
		monster.weaponAttack = 10;
		monster.weaponPerk = "";
		monster.weaponValue = 150;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 65;
		monster.tou = 45;
		monster.spe = 45;
		monster.inte = 85;
		monster.lib = 80;
		monster.sens = 70;
		monster.cor = 80;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 200;
		monster.HP = eMaxHP();
		
		monster.lust = 20;
		monster.lustVuln = 0.75;
		
		//Level Stats
		monster.level = 8;
		monster.XP = totalXP();
		monster.gems = rand(25)+10;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = rand(9) + 70;
		monster.hairColor = "purple";
		monster.hairLength = 42;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "light purple";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 18;
		monster.hornType = 0;
		monster.wingDesc = "tiny hidden";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 5;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 3;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 8;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 2;
		//Create succubus sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 0;
		monster.createVagina();
		monster.vaginas[0].vaginalWetness = 4;
		monster.vaginas[0].vaginalLooseness = 1;
		monster.vaginas[0].virgin = false;
		monster.cumMultiplier = 3;
		monster.createCock();
		monster.cocks[0].cockLength = 10;
		monster.cocks[0].cockThickness = 1.5;
		monster.ass.analLooseness = 1;
		monster.ass.analWetness = 35;
		doNext(1);
	}
	//LOAD Tentacle beast
	if(monsterNum == 14) {
		monster.short="tentacle beast";
		monster.imageName="TentacleBeast";
		monster.plural = false;
		monster.long = "You see the massive, shambling form of the tentacle beast before you.  Appearing as a large shrub, it shifts its bulbous mass and reveals a collection of thorny tendrils and cephalopodic limbs.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 5072;
		//Lust attack
		monster.special2 = 5073;
		monster.special3 = 5072;
		monster.pronoun1 = "it";
		monster.pronoun2 = "it";
		monster.pronoun3 = "its";
		
		//Clothing/Armor
		monster.armorName = "rubbery skin";
		monster.weaponName = "whip-tendril";
		monster.weaponVerb = "thorny tendril";
		monster.armorDef = 1;
		monster.armorPerk = "";
		monster.weaponAttack = 1;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 58;
		monster.tou = 25;
		monster.spe = 45;
		monster.inte = 45;
		monster.lib = 90;
		monster.sens = 20;
		monster.cor = 100;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 350;
		monster.HP = eMaxHP();
		monster.lustVuln = 0.8;
		
		monster.lust = 10;
		
		//Level Stats
		monster.level = 6;
		monster.XP = totalXP();
		monster.gems = rand(15)+5;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 0;
		monster.tallness = rand(9) + 70;
		monster.hairColor = "green";
		monster.hairLength = 1;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "green";
		monster.skinDesc = "bark";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 3;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 0;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 0;
		//Create succubus sex attributes
		monster.cumMultiplier = 3;
		monster.createCock();
		monster.cocks[0].cockLength = 40;
		monster.cocks[0].cockThickness = 1.5;
		monster.createCock();
		monster.cocks[1].cockLength = 60;
		monster.cocks[1].cockThickness = 1.5;
		monster.createCock();
		monster.cocks[2].cockLength = 50;
		monster.cocks[2].cockThickness = 1.5;
		monster.createCock();
		monster.cocks[3].cockLength = 20;
		monster.cocks[3].cockThickness = 1.5;
		monster.ass.analLooseness = 1;
		monster.ass.analWetness = 35;
		doNext(1);
	}
	//LOAD GOBLIN
	if(monsterNum == 15) {
		monster.short="goblin";
		monster.imageName="goblin";
		monster.plural = false;
		monster.long = "The goblin before you is a typical example of her species, with dark green skin, pointed ears, and purple hair that would look more at home on a punk-rocker.  She's only about three feet tall, but makes up for it with her curvy body, sporting hips and breasts that would entice any of the men in your village were she full-size.  There isn't a single scrap of clothing on her, just lewd leather straps and a few clinking pouches.  She does sport quite a lot of piercings – the most noticeable being large studs hanging from her purple nipples.  Her eyes are fiery red, and practically glow with lust.  This one isn't going to be satisfied until she has her way with you.  It shouldn't be too hard to subdue such a little creature, right?";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 2;
		//Regular attack
		monster.special1 = 5087;
		//Lust attack
		monster.special2 = 5088;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "leather straps";
		monster.weaponName = "fists";
		monster.weaponVerb = "tiny punch";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 12;
		monster.tou = 13;
		monster.spe = 35;
		monster.inte = 42;
		monster.lib = 45;
		monster.sens = 45;
		monster.cor = 60;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 0;
		monster.HP = eMaxHP();
		
		monster.lust = 50;
		
		//Level Stats
		monster.level = 1;
		monster.XP = totalXP();
		monster.gems = rand(5) + 5;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = 35 + rand(4);
		monster.hairColor = "purple";
		monster.hairLength = 4;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "dark green";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 8;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 7;
		monster.createVagina();
		monster.createStatusAffect("Bonus vCapacity",40,0,0,0);
		monster.vaginas[0].vaginalWetness = 4;
		monster.vaginas[0].vaginalLooseness = 1;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 1;
		monster.createStatusAffect("Bonus aCapacity",30,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//MARBLE BAAAATTTLE
	if(monsterNum == 16) {
		plotFight = true;
		monster.short="Marble";
		monster.imageName="Marble";
		monster.plural = false;
		monster.long = "Before you stands a female humanoid with numerous cow features, such as medium-sized cow horns, cow ears, and a cow tail.  She is very well endowed, with wide hips and a wide ass.  She stands over 6 feet tall.  She is using a large two handed hammer with practiced ease, making it clear she is much stronger then she may appear to be.";
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 2;
		//Regular attack
		monster.special1 = 5092;
		//Lust attack
		monster.special2 = 5093;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "tough hide";
		monster.weaponName = "large hammer";
		monster.weaponVerb = "hammer-blow";
		monster.armorDef = 5;
		monster.armorPerk = "";
		monster.weaponAttack = 10;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 75;
		monster.tou = 70;
		monster.spe = 35;
		monster.inte = 40;
		monster.lib = 25;
		monster.sens = 45;
		monster.cor = 40;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 0;
		monster.HP = eMaxHP();
		
		monster.lust = 0;
		
		//Level Stats
		monster.level = 7;
		monster.XP = totalXP();
		monster.gems = rand(5) + 25;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = 76;
		monster.hairColor = "brown";
		monster.hairLength = 13;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "pale";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 4;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 4;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 10;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 11;
		monster.createVagina();
		monster.vaginas[0].vaginalWetness = 1;
		monster.vaginas[0].vaginalLooseness = 1;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 0;
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD TAMANI
	if(monsterNum == 17) {
		monster.short="Tamani";
		monster.imageName="Tamani";
		monster.plural = false;
		monster.long = "She keeps her arms folded across her " + tamaniChest() + " and glares at you.  The little thing is only about four feet tall, with pink and black dyed hair cut into a cute little 'do.  The greenish-gray skin of her breasts bulges out around her arms, supported by a few leather straps, amplifying her cleavage.  Her cunt lips are pierced multiple times, inflamed, and slightly parted.  There really isn't any clothing on her to hide them, just more of the ever-present straps wrapping around her thighs.";
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 2;
		//Regular attack
		monster.special1 = 5087;
		//Lust attack
		monster.special2 = 5088;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "leather straps";
		monster.weaponName = "fists";
		monster.weaponVerb = "tiny punch";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 32;
		monster.tou = 43;
		monster.spe = 55;
		monster.inte = 62;
		monster.lib = 65;
		monster.sens = 65;
		monster.cor = 50;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 40;
		monster.HP = eMaxHP();
		monster.lustVuln = 0.9;
		
		monster.lust = 40;
		
		//Level Stats
		monster.level = 4;
		monster.XP = totalXP();
		monster.gems = rand(25) + 5;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = 40;
		monster.hairColor = "pink and black";
		monster.hairLength = 16;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "greenish gray";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 8;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 7;
		monster.createVagina();
		monster.createStatusAffect("Bonus vCapacity",55,0,0,0);
		monster.vaginas[0].vaginalWetness = 4;
		monster.vaginas[0].vaginalLooseness = 1;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 1;
		monster.createStatusAffect("Bonus aCapacity",40,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD SHARK GIRL
	if(monsterNum == 18) {
		monster.short="shark-girl";
		monster.imageName="shark-girl";
		monster.plural = false;
		monster.long = "The shark girl stands just over 5'5\", with grey skin shimmering from water droplets catching the sunlight and slender muscles built for swimming.  Her shoulder-length silver hair brushes past her pretty face and her eyes are a striking shade of red. She has rows of intimidating sharp teeth glinting in the light. A fish-like tail protrudes from her backside, wrapping around her toned legs at every opportunity. She's wearing a rather skimpy black bikini, strings done in such a way that they move around her fin; though the swimwear itself barely covers her perky breasts and tight snatch.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 5097;
		monster.special2 = 5097;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "tough skin";
		monster.weaponName = "shark teeth";
		monster.weaponVerb = "bite";
		monster.armorDef = 5;
		monster.armorPerk = "";
		monster.weaponAttack = 3;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 40;
		monster.tou = 40;
		monster.spe = 55;
		monster.inte = 42;
		monster.lib = 75;
		monster.sens = 35;
		monster.cor = 40;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 20;
		monster.HP = eMaxHP();
		monster.lustVuln = .9;
		
		monster.lust = 40;
		
		//Level Stats
		monster.level = 4;
		monster.XP = totalXP();
		monster.gems = rand(15) + 5;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = 65;
		monster.hairColor = "silver";
		monster.hairLength = 16;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "gray";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 8;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 4;
		monster.createVagina();
		monster.createStatusAffect("Bonus vCapacity",15,0,0,0);
		monster.vaginas[0].vaginalWetness = 4;
		monster.vaginas[0].vaginalLooseness = 1;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 1;
		monster.createStatusAffect("Bonus aCapacity",40,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD FETISH ZEALOT
	if(monsterNum == 19) {
		monster.short="fetish zealot";
		monster.imageName="FetishZealot";
		monster.plural = false;
		monster.long = "The zealot is clad in a bizarre set of religious robes.  They are similar to what you've seen on other religious leaders from home, but none that included the large slit at the front that lets his above average sized human dick stick out the front.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 5103;
		monster.special2 = 5104;
		monster.special3 = 0;
		monster.pronoun1 = "he";
		monster.pronoun2 = "him";
		monster.pronoun3 = "his";
		
		//Clothing/Armor
		monster.armorName = "religious clothes";
		monster.weaponName = "wavy dagger";
		monster.weaponVerb = "stab";
		monster.armorDef = 5;
		monster.armorPerk = "";
		monster.weaponAttack = 3;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		
		//Primary stats
		monster.str = 35;
		monster.tou = 35;
		monster.spe = 30;
		monster.inte = 1;
		monster.lib = 75;
		monster.sens = 80;
		monster.cor = 90;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.HP = eMaxHP();
		monster.lust = 25;
		monster.lustVuln = 0.75;
		
		//Level Stats
		monster.level = 5;
		monster.XP = totalXP();
		monster.gems = 5+rand(10);
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = 72;
		monster.hairColor = "black";
		monster.hairLength = 4;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "tan";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 1;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 2;
		//Create goblin sex attributes
		monster.ass.analLooseness = 3;
		monster.createStatusAffect("Bonus aCapacity",40,0,0,0);
		monster.ass.analWetness = 0;
		monster.createCock();
		monster.cocks[0].cockLength = 7;
		monster.cocks[0].cockThickness = 1.5;
		doNext(1);
	}
	if(monsterNum == 20) {
		monster.short="infested hellhound";
		monster.imageName="InfestedHellhound";
		monster.plural = false;
		monster.long = "It looks like a large four-legged demon with two heads placed side-by-side. Its eyes and mouth are filled with flames, and covering each of its paws are large and menacing claws. A thick layer of dark fur covers his entire body like armor.  Both heads are looking at you hungrily as the hellhound circles around you.  A pair of black, slightly pointed cocks hang exposed, dripping with cum and worms.  You get the feeling reasoning with this beast will be impossible.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 5066;
		//Lust attack
		monster.special2 = 5067;
		monster.special3 = 5107;
		monster.pronoun1 = "he";
		monster.pronoun2 = "him";
		monster.pronoun3 = "his";
		
		//Clothing/Armor
		monster.armorName = "thick fur";
		monster.weaponName = "claws";
		monster.weaponVerb = "claw";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 5;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 65;
		monster.tou = 60;
		monster.spe = 50;
		monster.inte = 1;
		monster.lib = 95;
		monster.sens = 20;
		monster.cor = 100;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.HP = monster.tou*2 + 50;
		monster.lust = 50;
		monster.lustVuln = 0.87;
		
		//Level Stats
		monster.level = 5;
		monster.XP = totalXP();
		monster.gems = 10+rand(10);
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = 47;
		monster.hairColor = "red";
		monster.hairLength = 3;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "black";
		monster.skinDesc = "fur";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 2;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 4;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 5;
		//Create imp sex attributes
		monster.balls = 2;
		monster.ballSize = 5;
		monster.createCock();
		monster.createCock();
		monster.cocks[0].cockLength = 9;
		monster.cocks[1].cockLength = 9;
		monster.cocks[0].cockThickness = 2;
		monster.cocks[1].cockThickness = 2;
		monster.cumMultiplier = 8;
		monster.ass.analLooseness = 2;
		monster.ass.analWetness = 1;
		doNext(1);
	}
	//LOAD NAGGA PLEAS!
	if(monsterNum == 21) {
		monster.short="naga";
		monster.imageName="naga";
		monster.plural = false;
		monster.long = "You are fighting a naga. She resembles a beautiful and slender woman from the waist up, with dark hair hanging down to her neck. Her upper body is deeply tanned, while her lower body is covered with shiny scales, striped in a pattern reminiscent of the dunes around you. Instead of bifurcating into legs, her hips elongate into a snake's body which stretches far out behind her, leaving a long and curving trail in the sand.  She's completely naked, with her round C-cup breasts showing in plain sight. In her mouth you can see a pair of sharp, poisonous fangs and a long forked tongue moving rapidly as she hisses at you.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 5109;
		monster.special2 = 5110;
		monster.special3 = 5111;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "scales";
		monster.weaponName = "fist";
		monster.weaponVerb = "punch";
		monster.armorDef = 5;
		monster.armorPerk = "";
		monster.weaponAttack = 3;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 28;
		monster.tou = 20;
		monster.spe = 35;
		monster.inte = 42;
		monster.lib = 55;
		monster.sens = 55;
		monster.cor = 40;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 0;
		monster.HP = eMaxHP();
		
		monster.lust = 30;
		
		//Level Stats
		monster.level = 2;
		monster.XP = totalXP();
		monster.gems = rand(5) + 8;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = 70;
		monster.hairColor = "brown";
		monster.hairLength = 16;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "mediterranean-toned";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 8;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 8;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 3;
		monster.createVagina();
		monster.createStatusAffect("Bonus vCapacity",40,0,0,0);
		monster.vaginas[0].vaginalWetness = 5;
		monster.vaginas[0].vaginalLooseness = 1;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 1;
		monster.createStatusAffect("Bonus aCapacity",10,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//AKUBAL
	if(monsterNum == 22) {
		monster.short="Akbal";
		monster.imageName="Akbal";
		monster.plural = false;
		monster.long = "Akbal, 'God of the Terrestrial Fire', circles around you. His sleek yet muscular body is covered in tan fur, with dark spots that seem to dance around as you look upon them.  His mouth holds two ivory incisors that glint in the sparse sunlight as his lips tremble to the sound of an unending growl.  Each paw conceals lethal claws capable of shredding men and demons to ribbons.  His large and sickeningly alluring bright green eyes promise unbearable agony as you look upon them.";
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 1;
		monster.special1 = 5125;
		monster.special2 = 5126;
		monster.special3 = 5127;
		monster.pronoun1 = "he";
		monster.pronoun2 = "him";
		monster.pronoun3 = "his";
		
		//Clothing/Armor
		monster.armorName = "shimmering pelt";
		monster.weaponName = "claws";
		monster.weaponVerb = "claw-slash";
		monster.armorDef = 5;
		monster.armorPerk = "";
		monster.weaponAttack = 5;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 55;
		monster.tou = 53;
		monster.spe = 50;
		monster.inte = 75;
		monster.lib = 50;
		monster.sens = 50;
		monster.cor = 100;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 20;
		monster.HP = eMaxHP();
		monster.lust = 30;
		monster.lustVuln = 0.8;
		
		
		//Level Stats
		monster.level = 6;
		monster.XP = totalXP();
		monster.gems = 15;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = 48;
		monster.hairColor = "black";
		monster.hairLength = 5;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "spotted";
		monster.skinDesc = "fur";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 2;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 2;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 2;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 0;
		monster.breastRows[0].nipplesPerBreast = 0;
		monster.createCock();
		monster.cocks[0].cockLength = 15;
		monster.cocks[0].cockThickness = 2.5;
		monster.cocks[0].cockType = CockTypesEnum.HUMAN;
		monster.balls = 2;
		monster.cumMultiplier = 6;
		monster.ballSize = 4;
		monster.hoursSinceCum = 400;
		monster.ass.analLooseness = 1;
		monster.ass.analWetness = 1;
		doNext(1);
	}
	//LOAD CERAPH!
	if(monsterNum == 23) {
		monster.short="Ceraph";
		monster.imageName="Ceraph";
		monster.plural = false;
		monster.long = "Ceraph the Omnibus is totally nude and reveling in it.  Her large yet perky breasts jiggle heavily against her chest as she moves.  The flawless purple skin of her twin mounds glistens with a thin sheen of sweat, inviting you to touch and rub your fingers along their slippery surface.  Her eyes are solid black, but convey a mix of amusement and desire, in spite of their alien appearance.  The demon's crotch is a combination of both genders – a drooling cunt topped with a thick demonic shaft, sprouting from where a clit should be.";
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 5133;
		monster.special2 = 5134;
		monster.special3 = 5135;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "demon-skin";
		monster.weaponName = "flaming whip";
		monster.weaponVerb = "flame-whip";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 15;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 65;
		monster.tou = 40;
		monster.spe = 80;
		monster.inte = 80;
		monster.lib = 75;
		monster.sens = 15;
		monster.cor = 100;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 200;
		monster.HP = eMaxHP();
		monster.lustVuln = 0.75;
		
		monster.lust = 30;
		
		//Level Stats
		monster.level = 9;
		monster.XP = totalXP();
		monster.gems = rand(5) + 38;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 3;
		monster.tallness = 66;
		monster.hairColor = "black";
		monster.hairLength = 20;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "purple";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 2;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 5;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 10;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 6;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 7;
		monster.createVagina();
		monster.createStatusAffect("Bonus vCapacity",20,0,0,0);
		monster.vaginas[0].vaginalWetness = 5;
		monster.vaginas[0].vaginalLooseness = 3;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 4;
		monster.createStatusAffect("Bonus aCapacity",15,0,0,0);
		monster.ass.analWetness = 0;
		monster.createCock();
		monster.cocks[0].cockLength = 10;
		monster.cocks[0].cockThickness = 2;
		monster.cocks[0].cockType = CockTypesEnum.DEMON;
		doNext(1);
	}
	//LOAD TAMANI'S DAUGHTERS
	if(monsterNum == 24) {
		monster.short="Tamani's daughters";
		monster.imageName="TamanisDaughters";
		monster.plural = true;
		monster.long = "A large grouping of goblin girls has gathered around you, surrounding you on all sides.  Most have varying shades of green skin, though a few have yellowish or light blue casts to their skin.  All are barely clothed, exposing as much of their flesh as possible in order to excite a potential mate.  Their hairstyles are as varied as their clothing and skin-tones, and the only things they seem to have in common are cute faces and curvy forms.  It looks like they want something from you.";
		monster.a ="the group of ";
		monster.capitalA ="The group of ";
		monster.temperment = 2;
		//Regular attack
		monster.special1 = 0;
		//Lust attack
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "they";
		monster.pronoun2 = "them";
		monster.pronoun3 = "their";
		
		//Clothing/Armor
		monster.armorName = "leather straps";
		monster.weaponName = "fists";
		monster.weaponVerb = "tiny punch";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 55;
		monster.tou = 30;
		monster.spe = 45;
		monster.inte = 50;
		monster.lib = 70;
		monster.sens = 70;
		monster.cor = 50;
		monster.fatigue = 0;
		monster.lustVuln = .65;
		
		//Combat Stats
		//int(player.statusAffectv2("Tamani")/2)
		monster.bonusHP = 50 + (int(player.statusAffectv2("Tamani")/2)*15);
		monster.HP = eMaxHP();
		
		monster.lust = 30;
		
		//Level Stats
		monster.level = 8 + (Math.floor(player.statusAffectv2("Tamani")/2/10));
		monster.XP = totalXP();
		monster.gems = rand(15) + 5;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = 40;
		monster.hairColor = "pink";
		monster.hairLength = 16;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "greenish gray";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 7;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 7;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 4;
		monster.createVagina();
		monster.createStatusAffect("Bonus vCapacity",40,0,0,0);
		monster.vaginas[0].vaginalWetness = 4;
		monster.vaginas[0].vaginalLooseness = 0;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 1;
		monster.createStatusAffect("Bonus aCapacity",25,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD GENERIC HARPY
	if(monsterNum == 25) {
		monster.short="harpy";
		monster.imageName="harpy";
		monster.plural = false;
		monster.long = "You are fighting a tall, deranged harpy. She appears very human, about six feet six inches tall but covered in a fine layer of powder-blue down. Her arms are sinewy and muscular, with a long web connecting them to her ample hips, covered in stringy blue feathers to aid her flight. A larger pair of powdery-blue wings also protrudes from her shoulder blades, flapping idly. She appears quite deranged as she circles you, approaching and backing away erratically. Her face is quite beautiful, with fine lilac makeup adorning the features of a handsome woman, and her lips are traced with rich golden lipstick. As she circles you, squawking frantically and trying to intimidate you, your eyes are drawn to her slender torso and small, pert breasts, each the size of a small fruit and covered in a layer of the softest feathers which ripple and move with the gusts from her wings. As astounding as her breasts are, her egg-bearing hips are even more impressive.  They're twice as wide as her torso, with enormous, jiggling buttocks where her huge, meaty thighs are coming up to meet them. Her legs end in three-pronged talons; their shadowy black curves glinting evilly in the light.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 2;
		//Uber
		monster.special1 = 5136;
		//Lust attack
		monster.special2 = 5137;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "feathers";
		monster.weaponName = "talons";
		monster.weaponVerb = "slashing talons";
		monster.armorDef = 5;
		monster.armorPerk = "";
		monster.weaponAttack = 15;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 60;
		monster.tou = 40;
		monster.spe = 90;
		monster.inte = 40;
		monster.lib = 70;
		monster.sens = 30;
		monster.cor = 80;
		monster.fatigue = 0;
		monster.lustVuln = .6;
		
		//Combat Stats
		//int(player.statusAffectv2("Tamani")/2)
		monster.bonusHP = 150;
		monster.HP = eMaxHP();
		monster.lustVuln = .7;
		
		monster.lust = 10;
		
		//Level Stats
		monster.level = 10;
		monster.XP = totalXP();
		monster.gems = 10 + rand(4);
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = 78;
		monster.hairColor = "blue";
		monster.hairLength = 16;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "pink";
		monster.skinDesc = "feathers";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "large feathery wings";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 4;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 20;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 13;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 2;
		monster.createVagina();
		monster.createStatusAffect("Bonus vCapacity",40,0,0,0);
		monster.vaginas[0].vaginalWetness = 3;
		monster.vaginas[0].vaginalLooseness = 4;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 1;
		monster.createStatusAffect("Bonus aCapacity",20,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}	
	//LOAD SOPHIE
	if(monsterNum == 26) {
		monster.short="Sophie";
		monster.imageName="Sophie";
		monster.plural = false;
		monster.long = "Sophie is approximately the size of a normal human woman, not counting the large feathery wings that sprout from her back.  Her face is gorgeous, with large rounded eyes and glimmering amber lip-gloss painted on her lush, kissable lips.  In spite of her beauty, it's clear from the barely discernible laugh lines around her mouth that she's been around long to enough to have quite a few children.  Her feathers are light pink, though the downy plumage that comprises her 'hair' is brighter than the rest.  She moves with practiced grace despite the large, jiggling breasts that hang from her chest.  Judging from her confident movements, she's an experienced fighter.";
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 2;
		//Uber
		monster.special1 = 5136;
		//Lust attack
		monster.special2 = 5137;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "feathers";
		monster.weaponName = "talons";
		monster.weaponVerb = "slashing talons";
		monster.armorDef = 5;
		monster.armorPerk = "";
		monster.weaponAttack = 20;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 55;
		monster.tou = 40;
		monster.spe = 110;
		monster.inte = 60;
		monster.lib = 60;
		monster.sens = 50;
		monster.cor = 60;
		monster.fatigue = 0;
		monster.lustVuln = .3;
		
		//Combat Stats
		//int(player.statusAffectv2("Tamani")/2)
		monster.bonusHP = 250;
		monster.HP = eMaxHP();
		
		monster.lust = 10;
		
		//Level Stats
		monster.level = 11;
		monster.XP = totalXP();
		monster.gems = 20 + rand(25);
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = 65;
		monster.hairColor = "pink";
		monster.hairLength = 16;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "pink";
		monster.skinDesc = "feathers";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "large feathery wings";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 4;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 20;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 13;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 5;
		monster.createVagina();
		monster.createStatusAffect("Bonus vCapacity",40,0,0,0);
		monster.vaginas[0].vaginalWetness = 4;
		monster.vaginas[0].vaginalLooseness = 4;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 1;
		monster.createStatusAffect("Bonus aCapacity",10,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}	
	//IMP WHORED HORDE
	if(monsterNum == 27) {
		plotFight = true;
		monster.short="imp horde";
		monster.imageName="ImpMob";
		monster.plural = true;
		monster.long = "Imps of all shapes and sizes fill the room around you, keeping you completely surrounded by their myriad forms.  You can see more than a few sporting disproportionate erections, and there's even some with exotic dog-dicks, horse-pricks, and the odd spiny cat-cock.  Escape is impossible, you'll have to fight or seduce your way out of this one!";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 2;
		//Uber
		monster.special1 = 0;
		//Lust attack
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "they";
		monster.pronoun2 = "them";
		monster.pronoun3 = "their";
		
		//Clothing/Armor
		monster.armorName = "skin";
		monster.weaponName = "fists";
		monster.weaponVerb = "punches";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 20;
		monster.tou = 10;
		monster.spe = 25;
		monster.inte = 12;
		monster.lib = 45;
		monster.sens = 45;
		monster.cor = 100;
		monster.fatigue = 0;
		monster.lustVuln = .5;
		
		//Combat Stats
		//int(player.statusAffectv2("Tamani")/2)
		monster.bonusHP = 450;
		monster.HP = eMaxHP();
		
		monster.lust = 10;
		
		//Level Stats
		monster.level = 10;
		monster.XP = totalXP();
		monster.gems = 20 + rand(25);
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = 36;
		monster.hairColor = "black";
		monster.hairLength = 1;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "red";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "imp wings";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 2;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 2;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 0;
		monster.ass.analLooseness = 1;
		monster.createStatusAffect("Bonus aCapacity",10,0,0,0);
		monster.ass.analWetness = 0;
		monster.createCock();
		monster.cocks[0].cockLength = 12;
		monster.cocks[0].cockThickness = 2;
		doNext(1);
	}
	//Encapsulation pod
	if(monsterNum == 28) {
		plotFight = true;
		monster.short="pod";
		monster.imageName="pod";
		monster.plural = false;
		monster.long = "";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 2;
		//Uber
		monster.special1 = 0;
		//Lust attack
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "it";
		monster.pronoun2 = "it";
		monster.pronoun3 = "its";
		
		//Clothing/Armor
		monster.armorName = "pod";
		monster.weaponName = "";
		monster.weaponVerb = "";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 90;
		monster.tou = 1;
		monster.spe = 1;
		monster.inte = 1;
		monster.lib = 1;
		monster.sens = 1;
		monster.cor = 100;
		monster.fatigue = 0;
		monster.lustVuln = 0;
		
		//Combat Stats
		monster.bonusHP = 450;
		monster.HP = eMaxHP();
		setDescriptionForPlantPot();
		
		monster.lust = 10;
		
		//Level Stats
		monster.level = 12;
		monster.XP = totalXP() + 80;
		monster.gems = 1;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = 120;
		monster.hairColor = "black";
		monster.hairLength = 0;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "purple";
		monster.skinDesc = "covering";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 2;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		doNext(1);
	}
	//LOAD ANEMONE!
	if(monsterNum == 29) {
		monster.short="anemone";
		monster.imageName="anemone";
		monster.plural = false;
		monster.long = "The anemone is a blue androgyne humanoid of medium height and slender build, with colorful tentacles sprouting on her head where hair would otherwise be.  Her feminine face contains two eyes of solid color, lighter than her skin.  Two feathery gills sprout from the middle of her chest, along the line of her spine and below her collarbone, and drape over her pair of small B-cup breasts.  Though you wouldn't describe her curves as generous, she sways her girly hips back and forth in a way that contrasts them to her slim waist quite attractively.  Protruding from her groin is a blue shaft with its head flanged by diminutive tentacles, and below that is a dark-blue pussy ringed by small feelers.  Further down are a pair of legs ending in flat sticky feet; proof of her aquatic heritage.  She smiles broadly and innocently as she regards you from her deep eyes.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 0;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "clammy skin";
		monster.weaponName = "tendrils";
		monster.weaponVerb = "tentacle";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 5;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 40;
		monster.tou = 20;
		monster.spe = 40;
		monster.inte = 50;
		monster.lib = 55;
		monster.sens = 35;
		monster.cor = 50;
		monster.fatigue = 0;
		monster.lustVuln = .6;
		
		//Combat Stats
		monster.bonusHP = 120;
		monster.HP = eMaxHP();
		monster.lustVuln = .9;
		
		monster.lust = 30;
		
		//Level Stats
		monster.level = 4;
		monster.XP = totalXP();
		monster.gems = rand(5) + 1;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 3;
		monster.tallness = 66;
		monster.hairColor = "purplish-black";
		monster.hairLength = 20;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "purple";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 2;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 5;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 10;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 6;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 7;
		monster.createVagina();
		monster.createStatusAffect("Bonus vCapacity",5,0,0,0);
		monster.vaginas[0].vaginalWetness = 3;
		monster.vaginas[0].vaginalLooseness = 2;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 2;
		monster.createStatusAffect("Bonus aCapacity",10,0,0,0);
		monster.ass.analWetness = 0;
		monster.createCock();
		monster.cocks[0].cockLength = 7;
		monster.cocks[0].cockThickness = 1;
		monster.cocks[0].cockType = CockTypesEnum.ANEMONE;
		doNext(1);
	}
	//LOAD VALA!
	if(monsterNum == 30) {
		plotFight = true;
		monster.short="Vala";
		monster.imageName="Vala";
		monster.plural = false;
		monster.long = "While the fey girl is whip-thin, her breasts are disproportionately huge. They'd be at least a DD-cup on a normal human, but for her height and body type, they're practically as large as her head. They jiggle at her slow, uneven breathing, tiny drops of milk bubbling at her nipples with every heartbeat.  She seems fixated on mating with you, and won't take no for an answer.";
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 0;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "skin";
		monster.weaponName = "fists";
		monster.weaponVerb = "caresses";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 40;
		monster.tou = 50;
		monster.spe = 50;
		monster.inte = 60;
		monster.lib = 55;
		monster.sens = 35;
		monster.cor = 50;
		monster.fatigue = 0;
		monster.lustVuln = .5;
		if(flags[UNKNOWN_FLAG_NUMBER_00126] > 0) monster.lustVuln += .25;
		if(flags[UNKNOWN_FLAG_NUMBER_00126] > 2) monster.lustVuln += .5;
		
		//Combat Stats
		monster.bonusHP = 350;
		monster.HP = eMaxHP();
		
		monster.lust = 30 + flags[UNKNOWN_FLAG_NUMBER_00126] * 10;
		if(monster.lust > 80) monster.lust = 80;
		
		
		//Level Stats
		monster.level = 11;
		monster.XP = totalXP() + 50;
		if(flags[UNKNOWN_FLAG_NUMBER_00126] > 0) monster.XP = 5;
		if(flags[UNKNOWN_FLAG_NUMBER_00126] > 2) monster.XP = 1;
		monster.gems = 1;
		
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 3;
		monster.tallness = 48;
		monster.hairColor = "purple";
		monster.hairLength = 22;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "fair";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 2;
		monster.hornType = 0;
		monster.wingDesc = "shimmering wings";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 2;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 10;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 7;
		monster.createVagina();
		monster.createStatusAffect("Bonus vCapacity",25,0,0,0);
		monster.vaginas[0].vaginalWetness = 3;
		monster.vaginas[0].vaginalLooseness = 4;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 4;
		monster.createStatusAffect("Bonus aCapacity",10,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD Zetaz
	if(monsterNum == 31) {
		plotFight = true;
		monster.short = "Zetaz";
		monster.imageName = "Zetaz";
		monster.long="Zetaz has gone from a pipsqueak to the biggest imp you've seen!  Though he has the familiar red skin, curving pointed horns, and wings you would expect to find on an imp, his feet now end in hooves, and his body is covered with thick layers of muscle.  If the dramatic change in appearance is any indication, he's had to toughen up nearly as much as yourself over the past ";
		if(days < 60) monster.long += "weeks";
		else monster.long += "months";
		monster.long += ".  Zetaz still wears the trademark imp loincloth, though it bulges and shifts with his movements in a way that suggest a considerable flaccid size and large, full sack.  His shoulders are wrapped with studded leather and his wrists are covered with metallic bracers.  The imp has clearly invested in at least a little additional protection.  It does not look like he carries a weapon.";
		monster.plural = false;
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 1;
		monster.special1 = 0;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "he";
		monster.pronoun2 = "him";
		monster.pronoun3 = "his";
		
		//Clothing/Armor
		monster.armorName = "leathery skin";
		monster.weaponName = "claws";
		monster.weaponVerb = "claw-slash";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 65;
		monster.tou = 60;
		monster.spe = 45;
		monster.inte = 52;
		monster.lib = 55;
		monster.sens = 35;
		monster.cor = 100;
		monster.fatigue = 0;
		monster.lustVuln = .35;
		
		//Combat Stats
		//Combat Stats
		monster.bonusHP = 350;
		monster.HP = eMaxHP();
		monster.lust = 40;
		
		//Level Stats
		monster.level = 12;
		monster.XP = totalXP() + 100;
		monster.gems = rand(55) + 150;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = 49;
		monster.hairColor = "black";
		monster.hairLength = 5;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "red";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.wingDesc = "small";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 5;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 0;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 2;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 0;
		monster.breastRows[0].nipplesPerBreast = 0;
		monster.createCock();
		monster.cocks[0].cockLength = rand(2) + 11;
		monster.cocks[0].cockThickness = 2.5;
		monster.cocks[0].cockType = CockTypesEnum.HUMAN;
		monster.balls = 2;
		monster.cumMultiplier = 3;
		monster.ballSize = 1;
		monster.hoursSinceCum = 20;
		monster.ass.analLooseness = 1;
		monster.ass.analWetness = 1;
		doNext(1);
	}
	//LOAD GNOLL!
	if(monsterNum == 32) {
		plotFight = true;
		monster.short="gnoll";
		monster.imageName="gnoll";
		monster.plural = false;
		monster.long = "This lanky figure is dappled with black spots across rough, tawny fur. Wiry muscle ripples along long legs and arms, all of it seeming in perpetual frenetic motion: every moment half flinching and half lunging.  The head bears a dark muzzle curled in a perpetual leer and bright orange eyes watching with a savage animal cunning.  Between the legs hang what appears at first to be a long, thin dong; however, on closer inspection it is a fused tube of skin composed of elongated pussy lips and clitoris.  The hyena girl is sporting a pseudo-penis, and judging by the way it bobs higher as she jinks back and forth, she's happy to see you!\n\nShe wears torn rags scavenged from some other, somewhat smaller, creature, and in one hand clutches a twisted club.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 0;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "skin";
		monster.weaponName = "twisted club";
		monster.weaponVerb = "smash";
		monster.armorDef = 2;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 25;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 80;
		monster.tou = 70;
		monster.spe = 75;
		monster.inte = 60;
		monster.lib = 65;
		monster.sens = 25;
		monster.cor = 60;
		monster.fatigue = 0;
		monster.lustVuln = .35;
		
		//Combat Stats
		monster.bonusHP = 250;
		monster.HP = eMaxHP();
		
		monster.lust = 30;
	
		//Level Stats
		monster.level = 14;
		monster.XP = totalXP();
		monster.gems = 10 + rand(5);
		
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 3;
		monster.tallness = 72;
		monster.hairColor = "black";
		monster.hairLength = 22;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "tawny";
		monster.skinDesc = "fur";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 2;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 6;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 2;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 3;
		monster.createVagina();
		monster.vaginas[0].vaginalWetness = 4;
		monster.vaginas[0].vaginalLooseness = 2;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 4;
		monster.createStatusAffect("Bonus aCapacity",25,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD AMILY!
	if(monsterNum == 33) {
		plotFight = true;
		monster.short="Amily";
		monster.imageName="Amily";
		monster.plural = false;
		monster.long = "You are currently fighting Amily. The mouse-morph is dressed in rags and glares at you in rage, knife in hand. She keeps herself close to the ground, ensuring she can quickly close the distance between you two or run away.";
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 0;
		//Lusty teases
		monster.special1 = 0;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "rags";
		monster.weaponName = "knife";
		monster.weaponVerb = "slash";
		monster.armorDef = 1;
		monster.armorPerk = "";
		monster.weaponAttack = 6;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 30;
		monster.tou = 30;
		monster.spe = 85;
		monster.inte = 60;
		monster.lib = 45;
		monster.sens = 45;
		monster.cor = 10;
		monster.fatigue = 0;
		monster.lustVuln = .85;
		
		//Combat Stats
		monster.bonusHP = 20;
		monster.HP = eMaxHP();
		
		monster.lust = 20;
	
		//Level Stats
		monster.level = 4;
		monster.XP = totalXP();
		monster.gems = 2 + rand(5);
		
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = 48;
		monster.hairColor = "brown";
		monster.hairLength = 5;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 1;
		monster.skinTone = "tawny";
		monster.skinDesc = "fur";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 2;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 6;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 2;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 3;
		monster.createVagina();
		monster.vaginas[0].vaginalWetness = 1;
		monster.vaginas[0].vaginalLooseness = 1;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 0;
		monster.createStatusAffect("Bonus vCapacity",48,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD GNOLL!
	if(monsterNum == 34) {
		plotFight = true;
		monster.short="gnoll spear-thrower";
		monster.imageName="GnollSpear-thrower";
		monster.plural = false;
		monster.long = "You are fighting a gnoll.  An amalgam of voluptuous, sensual lady and snarly, pissed off hyena, she clearly intends to punish you for trespassing.  Her dark-tan, spotted hide blends into a soft cream-colored fur covering her belly and two D-cup breasts, leaving two black nipples poking through the fur.  A crude loincloth is tied around her waist, obscuring her groin from view.  A leather strap cuts between her heavy breasts, holding a basket of javelins on her back.  Large, dish-shaped ears focus on you, leaving no doubt that she can hear every move you make.  Sharp, dark eyes are locked on your body, filled with aggression and a hint of lust.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 5147;
		monster.special2 = 5146;
		monster.special3 = 5145;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "skin";
		monster.weaponName = "teeth";
		monster.weaponVerb = "bite";
		monster.armorDef = 2;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 25;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 85;
		monster.tou = 60;
		monster.spe = 100;
		monster.inte = 50;
		monster.lib = 65;
		monster.sens = 45;
		monster.cor = 60;
		monster.fatigue = 0;
		monster.lustVuln = .35;
		
		//Combat Stats
		monster.bonusHP = 250;
		monster.HP = eMaxHP();
		
		monster.lust = 30;
	
		//Level Stats
		monster.level = 10;
		monster.XP = totalXP();
		monster.gems = 10 + rand(5);
		
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 3;
		monster.tallness = 72;
		monster.hairColor = "black";
		monster.hairLength = 22;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "tawny";
		monster.skinDesc = "fur";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 2;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 6;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 2;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 3;
		monster.createVagina();
		monster.vaginas[0].vaginalWetness = 4;
		monster.vaginas[0].vaginalLooseness = 2;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 4;
		monster.createStatusAffect("Bonus aCapacity",25,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD IZMA!
	if(monsterNum == 35) {
		monster.short="Izma";
		monster.imageName="Izma";
		monster.plural = false;
		monster.long = "Izma the tigershark stands a bit over 6' tall, with orange skin bearing horizontal stripes covering most of her body.  Her silver-white hair cascades past her shoulders, draping over an impressive pair of DD-cup breasts barely restrained by a skimpy black bikini top.  Under the knee-length grass skirt below them rustles her beastly fifteen-inch penis and four-balled sack; you catch occasional glimpses of them as she moves.  She's tucked her usual reading glasses into her locker at the moment.";
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 0;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "bikini and grass skirt";
		monster.weaponName = "clawed gauntlets";
		monster.weaponVerb = "clawed punches";
		monster.armorDef = 8;
		monster.armorPerk = "";
		monster.weaponAttack = 45;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 80;
		monster.tou = 90;
		monster.spe = 85;
		monster.inte = 65;
		monster.lib = 75;
		monster.sens = 25;
		monster.cor = 40;
		monster.fatigue = 0;
		monster.lustVuln = .20;
		
		//Combat Stats
		monster.bonusHP = 330;
		monster.HP = eMaxHP();
		
		monster.lust = 20;
		
		//Level Stats
		monster.level = 15;
		monster.XP = totalXP();
		monster.gems = rand(5) + 1;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 3;
		monster.tallness = 66;
		monster.hairColor = "silver";
		monster.hairLength = 20;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "striped orange";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 2;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 10;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 6;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 7;
		monster.createVagina();
		monster.createStatusAffect("Bonus vCapacity",45,0,0,0);
		monster.vaginas[0].vaginalWetness = 3;
		monster.vaginas[0].vaginalLooseness = 2;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 2;
		monster.createStatusAffect("Bonus aCapacity",30,0,0,0);
		monster.ass.analWetness = 0;
		monster.createCock();
		monster.cocks[0].cockLength = 15;
		monster.cocks[0].cockThickness = 2.2;
		doNext(1);
	}
	//LOAD ISABELLA!
	if(monsterNum == 36) {
		monster.short="Isabella";
		monster.imageName="Isabella";
		monster.plural = false;
		monster.long = "Isabella is a seven foot tall, red-headed tower of angry cow-girl.  She's snarling at you from behind her massive shield, stamping her hooves in irritation as she prepares to lay into you.  Her skin is dusky, nearly chocolate except for a few white spots spattered over her body.  She wears a tight silk shirt and a corset that barely supports her bountiful breasts, but it's hard to get a good look at them behind her giant shield.";
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 0;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "giant shield";
		monster.weaponName = "giant shield";
		monster.weaponVerb = "smash";
		monster.armorDef = 8;
		monster.armorPerk = "";
		monster.weaponAttack = 15;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 70;
		//Primary stats
		monster.str = 70;
		monster.tou = 98;
		monster.spe = 75;
		monster.inte = 65;
		monster.lib = 65;
		monster.sens = 25;
		monster.cor = 40;
		monster.fatigue = 0;
		monster.lustVuln = .35;
		
		//Combat Stats
		monster.bonusHP = 700;
		monster.HP = eMaxHP();
		
		monster.lust = 30;
		
		//Level Stats
		monster.level = 15;
		monster.XP = totalXP();
		monster.gems = rand(5) + 20;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = 90;
		monster.hairColor = "red";
		monster.hairLength = 13;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "dusky";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 2;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 4;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 0;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 12;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 9;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 10;
		monster.createVagina();
		monster.createStatusAffect("Bonus vCapacity",45,0,0,0);
		monster.vaginas[0].vaginalWetness = 4;
		monster.vaginas[0].vaginalLooseness = 3;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 0;
		monster.createStatusAffect("Bonus aCapacity",38,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD SPIDERGAL
	if(monsterNum == 37) {
		monster.short="female spider-morph";
		monster.imageName="FemaleSpider-morph";
		monster.plural = false;
		monster.long = "The female spider-morph is completely nude, save for her thigh-high stockings and forearm-length gloves, which upon closer inspection, appear to be actually be part of her body - her exoskeleton.  Her exposed skin is pale as the full moon, save for the dusky skin of her nipples and the black-skinned delta of her sex.  Her breasts and ass are both full and well-rounded, and just above her ass-cheeks there's a bulbous spider-abdomen.  The spider-girl is currently eyeing you with a strange expression and her fangs bared.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 0;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "exoskeleton";
		monster.weaponName = "dagger";
		monster.weaponVerb = "stab";
		monster.armorDef = 14;
		monster.armorPerk = "";
		monster.weaponAttack = 15;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 50;
		//Primary stats
		monster.str = 60;
		monster.tou = 50;
		monster.spe = 99;
		monster.inte = 99;
		monster.lib = 35;
		monster.sens = 35;
		monster.cor = 20;
		monster.fatigue = 0;
		monster.lustVuln = .6;
		
		//Combat Stats
		monster.bonusHP = 200;
		monster.HP = eMaxHP();
		
		monster.lust = 20;
		
		//Level Stats
		monster.level = 13;
		monster.XP = totalXP();
		monster.gems = rand(10) + 10;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = 90;
		monster.hairColor = "red";
		monster.hairLength = 13;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "dusky";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 2;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 4;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 0;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 12;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 9;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 8;
		monster.createVagina();
		monster.createStatusAffect("Bonus vCapacity",40,0,0,0);
		monster.vaginas[0].vaginalWetness = 4;
		monster.vaginas[0].vaginalLooseness = 2;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 0;
		monster.createStatusAffect("Bonus aCapacity",30,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD SPIDERGUY
	if(monsterNum == 38) {
		monster.short="male spider-morph";
		monster.imageName="MaleSpider-morph";
		monster.plural = false;
		monster.long = "The male spider-morph is completely nude, save for his thigh-high stockings and forearm-length gloves, which upon closer inspection, appear to be actually be part of his body - his exoskeleton.  His exposed skin is pale as the full moon, save for the dusk of his nipples and a patch of jet-black that spreads out over his groin, glossing the male's foreskinned cock and dangling sack in glistening ebon.  His ass is small but well-rounded, with a weighty spider-abdomen hanging from just above.  The spider-man is currently eyeing you with a strange expression and his fangs bared.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 0;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "he";
		monster.pronoun2 = "him";
		monster.pronoun3 = "his";
		
		//Clothing/Armor
		monster.armorName = "exoskeleton";
		monster.weaponName = "dagger";
		monster.weaponVerb = "stab";
		monster.armorDef = 14;
		monster.armorPerk = "";
		monster.weaponAttack = 15;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 70;
		//Primary stats
		monster.str = 60;
		monster.tou = 50;
		monster.spe = 99;
		monster.inte = 99;
		monster.lib = 35;
		monster.sens = 35;
		monster.cor = 20;
		monster.fatigue = 0;
		monster.lustVuln = .6;
		
		//Combat Stats
		monster.bonusHP = 200;
		monster.HP = eMaxHP();
		
		monster.lust = 20;
		
		//Level Stats
		monster.level = 13;
		monster.XP = totalXP();
		monster.gems = rand(10) + 10;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = 90;
		monster.hairColor = "red";
		monster.hairLength = 13;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "dusky";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 2;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 4;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 0;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 12;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 9;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 0;
		monster.createCock();
		monster.cocks[0].cockLength = 6;
		monster.cocks[0].cockThickness = 2;
		monster.ass.analLooseness = 1;
		monster.createStatusAffect("Bonus aCapacity",40,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD Basilisk
	if(monsterNum == 39) {
		monster.short="basilisk";
		monster.imageName="basilisk";
		monster.plural = false;
		monster.long = "You are fighting a basilisk!  From what you can tell while not looking directly at it, the basilisk is a male reptilian biped standing a bit over 6' tall.  It has a thin but ropy build, its tightly muscled yellow underbelly the only part of its frame not covered in those deceptive, camouflaging grey-green scales.  A long, whip-like tail flits restlessly through the dirt behind its skinny legs, and sharp sickle-shaped index claws decorate each hand and foot.  You don't dare to look at its face, but you have the impression of a cruel jaw, a blunt lizard snout and a crown of dull spines.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 0;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "he";
		monster.pronoun2 = "him";
		monster.pronoun3 = "his";
		
		//Clothing/Armor
		monster.armorName = "scales";
		monster.weaponName = "claws";
		monster.weaponVerb = "claw";
		monster.armorDef = 10;
		monster.armorPerk = "";
		monster.weaponAttack = 30;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 70;
		//Primary stats
		monster.str = 85;
		monster.tou = 70;
		monster.spe = 35;
		monster.inte = 70;
		monster.lib = 50;
		monster.sens = 35;
		monster.cor = 60;
		monster.fatigue = 0;
		monster.lustVuln = .5;
		
		//Combat Stats
		monster.bonusHP = 200;
		monster.HP = eMaxHP();
		
		monster.lust = 30;
		
		//Level Stats
		monster.level = 12;
		monster.XP = totalXP();
		monster.gems = rand(10) + 10;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = 90;
		monster.hairColor = "none";
		monster.hairLength = 0;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 2;
		monster.skinTone = "gray";
		monster.skinDesc = "scales";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 2;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 4;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 0;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 3;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 4;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 0;
		monster.createCock();
		monster.cocks[0].cockLength = 6;
		monster.cocks[0].cockThickness = 2;
		monster.ass.analLooseness = 1;
		monster.createStatusAffect("Bonus aCapacity",30,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD Drider
	if(monsterNum == 40) {
		monster.short="corrupted drider";
		monster.imageName="CorruptedDrider";
		monster.plural = false;
		
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 0;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "carapace";
		monster.weaponName = "claws";
		monster.weaponVerb = "claw";
		monster.armorDef = 55;
		monster.armorPerk = "";
		monster.weaponAttack = 30;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 70;
		//Primary stats
		monster.str = 100;
		monster.tou = 50;
		monster.spe = 70;
		monster.inte = 100;
		monster.lib = 80;
		monster.sens = 50;
		monster.cor = 90;
		monster.fatigue = 0;
		monster.lustVuln = .4;
		
		//Combat Stats
		monster.bonusHP = 250;
		monster.HP = eMaxHP();
		
		monster.lust = 30;
		
		//Level Stats
		monster.level = 14;
		monster.XP = totalXP();
		monster.gems = rand(10) + 20;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 3;
		monster.tallness = 120;
		temp = rand(3);
		if(temp == 0) monster.hairColor = "red";
		else if(temp == 1) monster.hairColor = "orange";
		else if(temp == 2) monster.hairColor = "green";
		monster.hairLength = 24;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		//SKINTONE USED FOR EYES ON DRIDAH!
		temp = rand(4);
		if(temp == 0) monster.skinTone = "yellow";
		else if(temp == 1) monster.skinTone = "purple";
		else if(temp == 2) monster.skinTone = "red";
		else if(temp == 3) monster.skinTone = "turquoise";
		monster.skinDesc = "scales";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 0;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 12;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		if(rand(2) == 0) {
			monster.nipplesPierced = 1;
			monster.lustVuln = .25;
			//Combat Stats
			monster.bonusHP = 325;
			monster.HP = eMaxHP();
			monster.lust = 35;
			//Level Stats
			monster.level = 15;
			monster.XP = totalXP();
			monster.gems = rand(10) + 30;

		}
		monster.long = "This particular spider-woman is a drider - a creature with a humanoid top half and the lower body of a giant arachnid.  From a quick glance, you can tell that this one has fallen deeply to corruption.  She is utterly nude, exposing her four well-rounded, D-cup breasts with their shiny black nipples.  ";
		if(monster.nipplesPierced > 0) monster.long += "Gold piercings and chains link the curvy tits together, crossing in front of her four mounds in an 'x' pattern.  ";
		monster.long += "On her face and forehead, a quartet of lust-filled, " + monster.skinTone + " eyes gaze back at you.  Behind her, the monster-girl's " + monster.hairColor + " hair drapes down her back like a cloak.  The drider's lips seem to shine with a light all their own, and a steady trickle of purple, reflective fluid beads and drips from them.  At her waist, there's a juicy looking snatch with a large, highly visible clit.  From time to time it pulsates and grows, turning part-way into a demon-dick.  Her spider-half has eight spindly legs with black and " + monster.hairColor + " stripes - a menacing display if ever you've seen one.";
		monster.buttRating = 9;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 5;
		monster.createCock();
		monster.cocks[0].cockLength = 9;
		monster.cocks[0].cockThickness = 2;
		monster.createVagina();
		monster.vaginas[0].vaginalWetness = 4;
		monster.vaginas[0].vaginalLooseness = 3;
		monster.ass.analLooseness = 1;
		monster.createStatusAffect("Bonus aCapacity",70,0,0,0);
		monster.createStatusAffect("Bonus vCapacity",70,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//Minotaur gang!
	if(monsterNum == 41) {
		monster.short="minotaur";
		monster.imageName="MinotaurMob";
		if(flags[UNKNOWN_FLAG_NUMBER_00326] < 20) monster.short += " gang";
		else monster.short += " tribe";
		monster.plural = true;
		monster.long = Num2Text(flags[UNKNOWN_FLAG_NUMBER_00326]) + " shaggy beastmen stand around you in a loose circle.  Their postures aren't exactly threatening.  If anything, they seem to be standing protectively around you, as if their presence would somehow shelter you from the rest of the mountain.  All of their features share a brotherly similarity, though there's still a fair bit of differences between your minotaur sons.  One of them is a head above the rest, a massive hulk of muscle so big he seems to dwarf the rest.  In stark contrast, a feminine minitaur keeps his distance in the rear.";
		if(flags[UNKNOWN_FLAG_NUMBER_00326] >= 20) monster.long += "  The tribe constantly makes hoots and cat-calls, fully expecting to be fucking you soon.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 1;
		monster.special1 = 5029;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "they";
		monster.pronoun2 = "them";
		monster.pronoun3 = "their";
		
		//Clothing/Armor
		monster.armorName = "thick fur";
		monster.weaponName = "fists";
		monster.weaponVerb = "punches";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 65;
		monster.tou = 60;
		monster.spe = 30;
		monster.inte = 20;
		monster.lib = 40;
		monster.sens = 15;
		monster.cor = 35;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 340 + 50 * (flags[UNKNOWN_FLAG_NUMBER_00326] - 3);
		monster.HP = eMaxHP();
		monster.lustVuln = 0.45;
		if((flags[UNKNOWN_FLAG_NUMBER_00326] - 3) * 2 > 13) monster.lustVuln = .3;
		else monster.lustVuln -= (flags[UNKNOWN_FLAG_NUMBER_00326] - 3) * 0.02;
		monster.lust = 30;
		
		//Level Stats
		monster.level = 11 + Math.round((flags[UNKNOWN_FLAG_NUMBER_00326] - 3)/2);
		if(monster.level > 14) monster.level = 14;
		monster.XP = totalXP();
		monster.gems = rand(15) + 45;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = rand(37) + 84;
		//randomly assign hair color
		if(rand(2) == 0) monster.hairColor = "black";
		else monster.hairColor = "brown";
		monster.hairLength = 3;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 1;
		monster.skinTone = "red";
		monster.skinDesc = "shaggy fur";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		//3 - cowface
		monster.faceType = 3;
		monster.horns = 2;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 1;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		//7 - cow!
		monster.tailType = 7;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 4;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 5;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 0;
		monster.breastRows[0].nipplesPerBreast = 1;
		monster.createCock();
		monster.cocks[0].cockLength = rand(13) + 24;
		monster.cocks[0].cockThickness = 2 + rand(3);
		monster.cocks[0].cockType = CockTypesEnum.HORSE;
		monster.balls = 2;
		monster.cumMultiplier = 1.5;
		monster.ballSize = 2 + rand(13);
		monster.hoursSinceCum = player.ballSize * 10;
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 1;
		monster.createStatusAffect("Bonus aCapacity",30,0,0,0);
		doNext(1);
	}
	//Kiha the dragoness
	if(monsterNum == 42) {
		monster.short="Kiha";
		monster.imageName="Kiha";
		monster.plural = false;
		monster.long = "Kiha is standing across from you, holding a double-bladed axe that's nearly as big as she is.  She's six feet tall, and her leathery wings span nearly twelve feet extended.  Her eyes are pure crimson, save for a black slit in the center, and a pair of thick draconic horns sprout from her forehead, arcing over her ruby-colored hair to point behind her.  Dim red scales cover her arms, legs, back, and strong-looking tail, providing what protection they might  to large areas of her body.  The few glimpses of exposed skin are dark, almost chocolate in color, broken only by a few stray scales on the underside of her bosom and on her cheekbones.  Her vagina constantly glistens with moisture, regardless of her state of arousal.  Despite her nudity, Kiha stands with the confidence and poise of a trained fighter.";
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 1;
		monster.special1 = 0;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "thick scales";
		monster.weaponName = "double-bladed axe";
		monster.weaponVerb = "fiery cleave";
		monster.armorDef = 30;
		monster.armorPerk = "";
		monster.weaponAttack = 25;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 65;
		monster.tou = 60;
		monster.spe = 85;
		monster.inte = 60;
		monster.lib = 50;
		monster.sens = 45;
		monster.cor = 66;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 430;
		monster.HP = eMaxHP();
		monster.lustVuln = 0.4;
		monster.lust = 10;
		
		//Level Stats
		monster.level = 16;
		monster.XP = totalXP();
		monster.gems = rand(15) + 95;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = 73;
		monster.hairColor = "red";
		monster.hairLength = 3;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 2;
		monster.skinTone = "dark";
		monster.skinDesc = "skin and scales";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		//3 - cowface
		monster.faceType = 0;
		monster.horns = 2;
		monster.wingDesc = "huge";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 5;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 1;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		//7 - cow!
		monster.tailType = 9;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 6;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 5;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 4;
		monster.breastRows[0].nipplesPerBreast = 1;
		monster.createVagina();
		monster.vaginas[0].vaginalWetness = 4;
		monster.vaginas[0].vaginalLooseness = 1;
		monster.balls = 0;
		monster.cumMultiplier = 1.5;
		monster.hoursSinceCum = player.ballSize * 10;
		monster.ass.analLooseness = 3;
		monster.ass.analWetness = 0;
		monster.createStatusAffect("Bonus aCapacity",40,0,0,0);
		monster.createStatusAffect("Bonus vCapacity",40,0,0,0);
		doNext(1);
	}
	//Plain Girl (Shouldra)
	if(monsterNum == 43) {
		monster.short="plain girl";
		monster.imageName="Shouldra";
		monster.plural = false;
		monster.long = "Her face has nothing overly attractive about it; a splash of freckles flits across her cheeks, her brows are too strong to be considered feminine, and her jaw is a tad bit square. Regardless, the features come together to make an aesthetically pleasing countenance, framed by a stylish brown-haired bob. Her breasts are obscured by her grey, loose-fitting tunic, flowing down to reach the middle of her thigh. Her legs are clad in snug, form-fitting leather breeches, and a comfortable pair of leather shoes shield her soles from the potentially harmful environment around her.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 1;
		monster.special1 = 0;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "comfortable clothes";
		monster.weaponName = "fists";
		monster.weaponVerb = "punches";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 45;
		monster.tou = 30;
		monster.spe = 5;
		monster.inte = 110;
		monster.lib = 100;
		monster.sens = 0;
		monster.cor = 33;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 30;
		monster.HP = eMaxHP();
		monster.lustVuln = 1;
		monster.lust = 10;
		
		//Level Stats
		monster.level = 4;
		monster.XP = totalXP();
		monster.gems = 0;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = 65;
		monster.hairColor = "white";
		monster.hairLength = 3;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "white";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		//3 - cowface
		monster.faceType = 0;
		monster.horns = 2;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		//7 - cow!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 6;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 5;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 4;
		monster.breastRows[0].nipplesPerBreast = 1;
		monster.createVagina();
		monster.vaginas[0].vaginalWetness = 2;
		monster.vaginas[0].vaginalLooseness = 1;
		monster.balls = 0;
		monster.ass.analLooseness = 1;
		monster.ass.analWetness = 0;
		monster.createStatusAffect("Bonus aCapacity",40,0,0,0);
		monster.createStatusAffect("Bonus vCapacity",40,0,0,0);
		doNext(1);
	}
	//Goo-Girl
	if(monsterNum == 44) {
		monster.short="goo-girl";
		monster.imageName="GooGirl";
		monster.plural = false;
		monster.long = "The goo-girl has a curious expression on her youthful, shimmering face. Her body is slender and globs of slime regularly drip from her limbs, splattering into the goo puddle pooling beneath her hips. A small, heart-shaped nucleus pulses in her chest with a red glow.";
		if(player.biggestTitSize() >= 3) monster.long += "  She has apparently made herself a bit more like you, as her chest appears to be a perfect copy of your " + biggestBreastSizeDescript()+ ".";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		monster.special1 = 5040;
		monster.special2 = 5039;
		monster.special3 = 5039;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "gelatinous skin";
		monster.weaponName = "hands";
		monster.weaponVerb = "slap";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 25;
		monster.tou = 25;
		monster.spe = 20;
		monster.inte= 30;
		monster.lib = 50;
		monster.sens= 40;
		monster.cor = 10;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 40;
		monster.HP = eMaxHP();
		monster.lust = 45;
		
		//Level Stats
		monster.level = 3;
		monster.XP = totalXP();
		monster.gems = rand(5)+1;
		monster.lustVuln = .75;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = rand(8) + 70;
		
		monster.hairLength = 0;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		temp = rand(3);
		if(temp == 0) monster.skinTone = "blue";
		else if(temp == 1) monster.skinTone = "purple";
		else monster.skinTone = "crystal";
		monster.hairColor = monster.skinTone;
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 6;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create imp sex attributes
		monster.createVagina();
		monster.vaginas[0].vaginalWetness = 5;
		monster.vaginas[0].vaginalLooseness = 1;
		monster.balls = 0;
		monster.ass.analLooseness = 1;
		monster.ass.analWetness = 5;
		monster.createStatusAffect("Bonus aCapacity",9001,0,0,0);
		monster.createStatusAffect("Bonus vCapacity",9001,0,0,0);
		doNext(1);
	}
	//LOAD Hel/Salamander
	if(monsterNum == 45) {
		monster.short = "salamander";
		monster.imageName = "Hel"
		monster.plural = false;
		monster.long = "You are fighting a (literally) smoking hot salamander – a seven foot tall woman with crimson scales covering her legs, back, and forearms, with a tail swishing menacingly behind her, ablaze with a red-hot fire.  Her red hair whips wildly around her slender shoulders, occasionally flitting over her hefty E-cup breasts, only just concealed within a scale-covered bikini top.  Bright red eyes focus on you from an almost-human face as she circles you, ready to close in for the kill.  Her brutal, curved sword is raised to her side, feinting at you between genuine attacks.";
		monster.a ="the ";
		monster.capitalA ="The ";
		if(flags[HEL_TALKED_ABOUT_HER] == 1) {
			monster.short ="Hel";
			monster.a = "";
			monster.capitalA = "";
		}
		
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 0;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "scales";
		monster.weaponName = "sword";
		monster.weaponVerb = "slashing blade";
		monster.armorDef = 14;
		monster.armorPerk = "";
		monster.weaponAttack = 20;
		monster.createStatusAffect("keen",0,0,0,0);
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 50;
		//Primary stats
		monster.str = 80;
		monster.tou = 70;
		monster.spe = 75;
		monster.inte = 60;
		monster.lib = 65;
		monster.sens = 25;
		monster.cor = 30;
		monster.fatigue = 0;
		monster.lustVuln = .35;
		
		//Combat Stats
		monster.bonusHP = 275;
		monster.HP = eMaxHP();
		
		monster.lust = 30;
	
		//Level Stats
		monster.level = 16;
		monster.XP = totalXP();
		monster.gems = 10 + rand(5);
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = 90;
		monster.hairColor = "red";
		monster.hairLength = 13;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "dusky";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 2;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 4;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 0;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 12;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 9;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 8;
		monster.createVagina();
		monster.createStatusAffect("Bonus vCapacity",85,0,0,0);
		monster.vaginas[0].vaginalWetness = 1;
		monster.vaginas[0].vaginalLooseness = 1;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 0;
		monster.createStatusAffect("Bonus aCapacity",85,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD MOB OF SPIDERS!
	if(monsterNum == 46) {
		monster.short = "mob of spiders-morphs";
		monster.imageName = "SpiderMorphMob"
		monster.plural = true;
		monster.long = "You are fighting a horde of spider-morphs!  A group of some two-dozen spiders and driders approaches you, all baring their teeth.  A pair of large, powerful driders lead the group, their corrupt, lusty stares sending shivers up your spine.  While ";
		if(player.level <= 13) monster.long += "you'd never face such a large horde on your own";
		else monster.long += "you could probably handle them alone";
		monster.long += ", you have a powerful ally in this fight - the dragoness Kiha!";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 5043;
		//Lust attack
		monster.special2 = 5044;
		monster.special3 = 0;
		monster.pronoun1 = "they";
		monster.pronoun2 = "them";
		monster.pronoun3 = "their";
		
		//Clothing/Armor
		monster.armorName = "chitin";
		monster.weaponName = "claws";
		monster.weaponVerb = "claws";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 60;
		monster.tou = 50;
		monster.spe = 99;
		monster.inte = 99;
		monster.lib = 35;
		monster.sens = 35;
		monster.cor = 20;
		monster.fatigue = 0;
		monster.lustVuln = .2;
		
		//Combat Stats
		monster.bonusHP = 1200;
		monster.HP = eMaxHP();
		monster.lust = 0;
		
		//Level Stats
		monster.level = 18;
		monster.XP = totalXP();
		monster.gems = rand(25)+40;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 3;
		monster.tallness = rand(8) + 70;
		monster.hairColor = "black";
		monster.hairLength = 15;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "red";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 10;
		monster.hornType = 1;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 3;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 8;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create imp sex attributes
		monster.createCock();
		monster.cocks[0].cockLength = 9;
		monster.cocks[0].cockThickness = 2;
		monster.cocks[0].cockType = CockTypesEnum.HUMAN;
		monster.createVagina();
		monster.vaginas[0].virgin = false;
		monster.vaginas[0].vaginalWetness = 3;
		monster.vaginas[0].vaginalLooseness = 2;
		monster.balls = 0;
		monster.cumMultiplier = 3;
		monster.ballSize = 1;
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 5;
		doNext(1);
	}
	//LOAD GOO ARMOR!
	if(monsterNum == 47) {
		monster.short = "Goo Armor";
		monster.imageName = "GooArmor"
		monster.plural = false;
		monster.long = "Before you stands a suit of plated mail armor filled with a bright blue goo, standing perhaps six feet off the ground.  She has a beautiful, feminine face, and her scowl as she stands before you is almost cute.  She has formed a mighty greatsword from her goo, and has assumed the stance of a well-trained warrior.";
		monster.a ="a ";
		monster.capitalA ="A ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 0;
		//Lust attack
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "armor";
		monster.weaponName = "claws";
		monster.weaponVerb = "claws";
		monster.armorDef = 50;
		monster.armorPerk = "";
		monster.weaponAttack = 60;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 60;
		monster.tou = 50;
		monster.spe = 50;
		monster.inte = 40;
		monster.lib = 60;
		monster.sens = 35;
		monster.cor = 50;
		monster.fatigue = 0;
		monster.lustVuln = .35;
		
		
		
		//Combat Stats
		monster.bonusHP = 500;
		monster.HP = eMaxHP();
		monster.lust = 0;
		
		//Level Stats
		monster.level = 16;
		monster.XP = totalXP();
		monster.gems = rand(25)+40;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 3;
		monster.tallness = rand(8) + 70;
		monster.hairColor = "black";
		monster.hairLength = 15;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "red";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 10;
		monster.hornType = 1;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 3;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 8;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create imp sex attributes
		monster.createVagina();
		monster.vaginas[0].virgin = false;
		monster.vaginas[0].vaginalWetness = 5;
		monster.vaginas[0].vaginalLooseness = 4;
		monster.balls = 0;
		monster.cumMultiplier = 3;
		monster.ballSize = 1;
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 5;
		doNext(1);
	}
	//LOAD HARPY WING
	if(monsterNum == 48) {
		monster.short="harpy horde";
		monster.imageName = "HarpyMob";
		monster.plural = true;
		monster.long = "You are surrounded by a wing of particularly large and muscular harpies, perhaps a dozen of them in total.  All of them are clad in simple brown shifts that give them good camouflage in the mountains, and are using their talon-like claws as weapons against you. While not a great threat to a champion of your ability individually, a whole brood of them together is... something else entirely.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 0;
		//Lust attack
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "they";
		monster.pronoun2 = "them";
		monster.pronoun3 = "their";
		
		//Clothing/Armor
		monster.armorName = "armor";
		monster.weaponName = "claw";
		monster.weaponVerb = "claw";
		monster.armorDef = 20;
		monster.armorPerk = "";
		monster.weaponAttack = 10;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 50;
		monster.tou = 50;
		monster.spe = 120;
		monster.inte = 40;
		monster.lib = 60;
		monster.sens = 45;
		monster.cor = 50;
		monster.fatigue = 0;
		monster.lustVuln = .2;
		
		//Combat Stats
		monster.bonusHP = 1000;
		monster.HP = eMaxHP();
		monster.lust = 20;
		
		//Level Stats
		monster.level = 18;
		monster.XP = totalXP() + 50;
		monster.gems = rand(25)+140;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 3;
		monster.tallness = rand(8) + 70;
		monster.hairColor = "black";
		monster.hairLength = 15;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "red";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 10;
		monster.hornType = 1;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 3;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 8;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create imp sex attributes
		monster.createVagina();
		monster.vaginas[0].virgin = false;
		monster.vaginas[0].vaginalWetness = 5;
		monster.vaginas[0].vaginalLooseness = 4;
		monster.balls = 0;
		monster.cumMultiplier = 3;
		monster.ballSize = 1;
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 5;
		doNext(1);
	}	
	//LOAD BRIGID JAILER
	if(monsterNum == 49) {
		monster.short="Brigid the Jailer";
		monster.imageName = "Brigid";
		monster.plural = false;
		monster.long = "Brigid is a monster of a harpy, standing a foot taller than any other you've seen. She's covered in piercings, and her pink-dyed hair is shaved down to a long mohawk. She's nude, save for the hot poker in her right hand and the shield in her left, which jingles with every step she takes thanks to the cell keys beneath it.";
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 0;
		//Lust attack
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "armor";
		monster.weaponName = "poker";
		monster.weaponVerb = "burning stab";
		monster.armorDef = 20;
		monster.armorPerk = "";
		monster.weaponAttack = 30;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 90;
		monster.tou = 60;
		monster.spe = 120;
		monster.inte = 40;
		monster.lib = 40;
		monster.sens = 45;
		monster.cor = 50;
		monster.fatigue = 0;
		monster.lustVuln = .25;
		
		//Combat Stats
		monster.bonusHP = 1000;
		monster.HP = eMaxHP();
		monster.lust = 20;
		
		//Level Stats
		monster.level = 19;
		monster.XP = totalXP() + 50;
		monster.gems = rand(25)+140;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 3;
		monster.tallness = rand(8) + 70;
		monster.hairColor = "black";
		monster.hairLength = 15;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "red";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 10;
		monster.hornType = 1;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 3;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 8;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create imp sex attributes
		monster.createVagina();
		monster.vaginas[0].virgin = false;
		monster.vaginas[0].vaginalWetness = 5;
		monster.vaginas[0].vaginalLooseness = 2;
		monster.balls = 0;
		monster.cumMultiplier = 3;
		monster.ballSize = 1;
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD PHOENIX PLATOON
	if(monsterNum == 50) {
		monster.short="phoenix platoon";
		monster.imageName="PhoenixMob";
		monster.plural = true;
		monster.long = "You are faced with a platoon of heavy infantry, all armed to the teeth and protected by chain vests and shields. They look like a cross between salamander and harpy, humanoid save for crimson wings, scaled feet, and long fiery tails. They stand in a tight-knit shield wall, each phoenix protecting herself and the warrior next to her with their tower-shield. Their scimitars cut great swaths through the room as they slowly advance upon you.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 0;
		//Lust attack
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "they";
		monster.pronoun2 = "them";
		monster.pronoun3 = "their";
		
		//Clothing/Armor
		monster.armorName = "armor";
		monster.weaponName = "spears";
		monster.weaponVerb = "stab";
		monster.armorDef = 20;
		monster.armorPerk = "";
		monster.weaponAttack = 20;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 70;
		monster.tou = 60;
		monster.spe = 120;
		monster.inte = 40;
		monster.lib = 40;
		monster.sens = 45;
		monster.cor = 50;
		monster.fatigue = 0;
		monster.lustVuln = .15;
		
		//Combat Stats
		monster.bonusHP = 1000;
		monster.HP = eMaxHP();
		monster.lust = 20;
		
		//Level Stats
		monster.level = 20;
		monster.XP = totalXP() + 50;
		monster.gems = rand(25)+160;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 3;
		monster.tallness = rand(8) + 70;
		monster.hairColor = "black";
		monster.hairLength = 15;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "red";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 10;
		monster.hornType = 1;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 3;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 8;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create imp sex attributes
		monster.createCock();
		monster.createVagina();
		monster.vaginas[0].virgin = false;
		monster.vaginas[0].vaginalWetness = 5;
		monster.vaginas[0].vaginalLooseness = 2;
		monster.balls = 0;
		monster.cumMultiplier = 3;
		monster.ballSize = 1;
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD HARPY QUEEN
	if(monsterNum == 51) {
		monster.short="Harpy Queen";
		monster.imageName="HarpyQueen";
		monster.plural = false;
		monster.long = "You face the Harpy Queen, a broodmother of epic proportions - literally.  Her hips are amazingly wide, thrice her own width at the least, and the rest of her body is lushly voluptuous, with plush, soft thighs and a tremendous butt.  Her wide wings beat occasionally, sending ripples through her jiggly body.  She wields a towering whitewood staff in one hand, using the other to cast eldritch spells.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 0;
		//Lust attack
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "armor";
		monster.weaponName = "eldritch staff";
		monster.weaponVerb = "thwack";
		monster.armorDef = 20;
		monster.armorPerk = "";
		monster.weaponAttack = 20;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 70;
		monster.tou = 60;
		monster.spe = 120;
		monster.inte = 40;
		monster.lib = 40;
		monster.sens = 45;
		monster.cor = 50;
		monster.fatigue = 0;
		monster.lustVuln = .15;
		
		//Combat Stats
		monster.bonusHP = 1000;
		monster.HP = eMaxHP();
		monster.lust = 20;
		
		//Level Stats
		monster.level = 20;
		monster.XP = totalXP() + 50;
		monster.gems = rand(25)+160;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 3;
		monster.tallness = rand(8) + 70;
		monster.hairColor = "black";
		monster.hairLength = 15;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "red";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 10;
		monster.hornType = 1;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 3;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 8;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create imp sex attributes
		monster.createVagina();
		monster.vaginas[0].virgin = false;
		monster.vaginas[0].vaginalWetness = 5;
		monster.vaginas[0].vaginalLooseness = 2;
		monster.balls = 0;
		monster.cumMultiplier = 3;
		monster.ballSize = 1;
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD FARMERS
	if(monsterNum == 52) {
		monster.short="farmers";
		monster.imageName="farmers";
		monster.plural = true;
		monster.long = "This is a group of thirty angry villagers, almost all human-looking but for the tiny horn-like protrusions growing from their heads and the white fuzz that almost passes off as hair.  They are all armed with pitchforks or other crude farming tools they use in their everyday task.  Rebecc is staring from behind them with horrified eyes at the combat, paralyzed by the sudden turn of events.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 5043;
		//Lust attack
		monster.special2 = 5044;
		monster.special3 = 0;
		monster.pronoun1 = "they";
		monster.pronoun2 = "them";
		monster.pronoun3 = "their";
		
		//Clothing/Armor
		monster.armorName = "chitin";
		monster.weaponName = "pitchforks";
		monster.weaponVerb = "stab";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 40;
		monster.tou = 50;
		monster.spe = 99;
		monster.inte = 99;
		monster.lib = 35;
		monster.sens = 35;
		monster.cor = 20;
		monster.fatigue = 0;
		monster.lustVuln = 0;
		
		//Combat Stats
		monster.bonusHP = 500;
		monster.HP = eMaxHP();
		monster.lust = 0;
		
		//Level Stats
		monster.level = 10;
		monster.XP = totalXP();
		monster.gems = rand(25)+40;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 3;
		monster.tallness = rand(8) + 70;
		monster.hairColor = "black";
		monster.hairLength = 15;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "red";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 10;
		monster.hornType = 1;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 3;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 8;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create imp sex attributes
		monster.createCock();
		monster.cocks[0].cockLength = 9;
		monster.cocks[0].cockThickness = 2;
		monster.cocks[0].cockType = CockTypesEnum.HUMAN;
		monster.createVagina();
		monster.vaginas[0].virgin = false;
		monster.vaginas[0].vaginalWetness = 3;
		monster.vaginas[0].vaginalLooseness = 2;
		monster.balls = 0;
		monster.cumMultiplier = 3;
		monster.ballSize = 1;
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 5;
		doNext(1);
	}
	//LOAD EMBER\
	if(monsterNum == 53) {
		monster.short="Ember";
		monster.imageName="Ember";
		monster.plural = false;
		monster.long = "You are currently 'battling' Ember, the dragon, in a playfight.  At least, that was the intention.  The way " + emberMF("he","she") + " lashes "+ emberMF("his","her") + " tail along the ground, with claws spread and teeth bared ferociously, makes you wonder.";
		monster.a =" ";
		monster.capitalA =" ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 0;
		//Lust attack
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = emberMF("he","she");
		monster.pronoun2 = emberMF("him","her");
		monster.pronoun3 = emberMF("his","her");
		
		//Clothing/Armor
		monster.armorName = "scales";
		monster.weaponName = "claws";
		monster.weaponVerb = "claw";
		monster.armorDef = 40;
		monster.armorPerk = "";
		monster.weaponAttack = 30;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 75;
		monster.tou = 75;
		monster.spe = 75;
		monster.inte = 75;
		monster.lib = 50;
		monster.sens = 35;
		monster.cor = flags[EMBER_COR];
		monster.fatigue = 0;
		monster.lustVuln = .25;
		
		//Combat Stats
		monster.bonusHP = 600;
		monster.HP = eMaxHP();
		monster.lust = 20;
		
		//Level Stats
		monster.level = 15;
		monster.XP = totalXP();
		monster.gems = 0;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = flags[EMBER_GENDER];
		monster.tallness = rand(8) + 70;
		monster.hairColor = "black";
		monster.hairLength = 15;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "red";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 10;
		monster.hornType = 1;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 3;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 8;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create imp sex attributes
		if(flags[EMBER_GENDER] >= 2) {
			monster.createVagina();
			monster.vaginas[0].virgin = false;
			monster.vaginas[0].vaginalWetness = 5;
			monster.vaginas[0].vaginalLooseness = 2;
		}
		if(flags[EMBER_GENDER] == 1 || flags[EMBER_GENDER] == 3) {
			monster.balls = 2;
			monster.createCock();
			monster.cocks[0].cockLength = 16;
			monster.cocks[0].cockThickness = 2;
			monster.cocks[0].cockType = CockTypesEnum.DRAGON;
			monster.ballSize = 4;
		}
		monster.cumMultiplier = 3;
		monster.ass.analLooseness = 2;
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD CHAMELEON
	if(monsterNum == 54) {
		monster.short="chameleon girl";
		monster.imageName="ChameleonGirl";
		monster.plural = false;
		monster.skinTone = "red";
		monster.skinAdj = "";
		temp = rand(6);
		switch(temp) {
			case 0:
				monster.skinTone = "red";
				monster.skinAdj = "black";
				break;
			case 1:
				monster.skinTone = "green";
				monster.skinAdj = "yellowish";
				break;
			case 2:
				monster.skinTone = "blue";
				monster.skinAdj = "lighter blue";
				break;
			case 3:
				monster.skinTone = "purple";
				monster.skinAdj = "bright yellow";
				break;
			case 4:
				monster.skinTone = "orange";
				monster.skinAdj = "brown";
				break;
			case 5:
				monster.skinTone = "tan";
				monster.skinAdj = "white";
				break;
			default:
				monster.skinTone = "Fudgup";
				monster.skinAdj = "Error";
				break;
		}
		monster.long = "You're faced with a tall lizard-like girl with smooth " + monster.skinTone + " skin and long, " + monster.skinAdj + " stripes that run along her body from ankle to shoulder.  An abnormally large tail swishes behind her, and her hands are massive for her frame, built for easily climbing the trees.  A pair of small, cute horns grow from her temples, and a pair of perky B-cups push out through her skimpy drapings.  Large, sharp claws cap her fingers, gesturing menacingly at you.";

		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 0;
		//Lust attack
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "skin";
		monster.weaponName = "claws";
		monster.weaponVerb = "claw";
		monster.armorDef = 20;
		monster.armorPerk = "";
		monster.weaponAttack = 30;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 65;
		monster.tou = 65;
		monster.spe = 95;
		monster.inte = 85;
		monster.lib = 50;
		monster.sens = 45;
		monster.cor = flags[EMBER_COR];
		monster.fatigue = 0;
		monster.lustVuln = .25;
		
		//Combat Stats
		monster.bonusHP = 350;
		monster.HP = eMaxHP();
		monster.lust = 30;
		
		//Level Stats
		monster.level = 14;
		monster.XP = totalXP();
		monster.gems = 10 + rand(50);
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = rand(2) + 68;
		monster.hairColor = "black";
		monster.hairLength = 15;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 0;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 8;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		monster.createVagina();
		monster.vaginas[0].virgin = false;
		monster.vaginas[0].vaginalWetness = 5;
		monster.vaginas[0].vaginalLooseness = 2;
		monster.cumMultiplier = 3;
		monster.ass.analLooseness = 2;
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD SANDTRAP
	if(monsterNum == 55) {
		//1/3 have fertilized eggs!
		if(rand(3) == 0) monster.createStatusAffect("Fertilized",0,0,0,0);
		monster.short="sandtrap";
		if(silly()) monster.short = "sand tarp";
		monster.imageName="sandtrap";
		monster.plural = false;
		monster.long = "You are fighting the sandtrap.  It sits half buried at the bottom of its huge conical pit, only its lean human anatomy on show, leering at you from beneath its shoulder length black hair with its six equally sable eyes.  You cannot say whether its long, soft face with its pointed chin is very pretty or very handsome - every time the creature's face moves, its gender seems to shift.  Its lithe, brown flat-chested body supports four arms, long fingers playing with the rivulets of powder sand surrounding it.  Beneath its belly you occasionally catch glimpses of its insect half: a massive sand-coloured abdomen which anchors it to the desert, with who knows what kind of anatomy.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 0;
		//Lust attack
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "he";
		monster.pronoun2 = "him";
		monster.pronoun3 = "his";
		
		//Clothing/Armor
		monster.armorName = "chitin";
		monster.weaponName = "claws";
		monster.weaponVerb = "claw";
		monster.armorDef = 20;
		monster.armorPerk = "";
		monster.weaponAttack = 10;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 55;
		monster.tou = 10;
		monster.spe = 45;
		monster.inte = 55;
		monster.lib = 60;
		monster.sens = 45;
		monster.cor = 50;
		monster.fatigue = 0;
		monster.lustVuln = .55;
		
		//Combat Stats
		monster.bonusHP = 100;
		monster.HP = eMaxHP();
		monster.lust = 20;
		
		//Level Stats
		monster.level = 4;
		monster.XP = totalXP();
		monster.gems = 2 + rand(5);
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = rand(8) + 150;
		monster.hairColor = "black";
		monster.hairLength = 15;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "fair";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 10;
		monster.hornType = 1;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 3;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 8;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create imp sex attributes
		monster.balls = 2;
		monster.createCock();
		monster.cocks[0].cockLength = 10;
		monster.cocks[0].cockThickness = 2;
		monster.cocks[0].cockType = CockTypesEnum.HUMAN;
		monster.ballSize = 4;
		monster.cumMultiplier = 3;
		monster.ass.analLooseness = 2;
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD SATYR
	if(monsterNum == 56) {
		monster.short="satyr";
		monster.imageName="satyr";
		monster.plural = false;
		monster.long = "From the waist up, your opponent is perfectly human, save his curling, goat-like horns and his pointed, elven ears.  His muscular chest is bare and glistening with sweat, while his coarsely rugged, masculine features are contorted into an expression of savage lust.  Looking at his waist, you notice he has a bit of a potbelly, no doubt the fruits of heavy drinking, judging by the almost overwhelming smell of booze and sex that emanates from him.  Further down you see his legs are the coarse, bristly-furred legs of a bipedal goat, cloven hooves pawing the ground impatiently, sizable manhood swaying freely in the breeze.";
		monster.a ="a ";
		monster.capitalA ="A ";
		monster.temperment = 1;
		monster.special1 = 5029;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "he";
		monster.pronoun2 = "him";
		monster.pronoun3 = "his";
		
		//Clothing/Armor
		monster.armorName = "thick fur";
		monster.weaponName = "fist";
		monster.weaponVerb = "punch";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 75;
		monster.tou = 70;
		monster.spe = 110;
		monster.inte = 70;
		monster.lib = 60;
		monster.sens = 35;
		monster.cor = 45;
		monster.fatigue = 0;
		monster.lust = 20;
		
		monster.lustVuln = 0.30;
		//Combat Stats
		monster.bonusHP = 300;
		monster.HP = eMaxHP();
		
		//Level Stats
		monster.level = 14;
		monster.XP = totalXP();
		monster.gems = rand(25) + 25;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = rand(37) + 64;
		//randomly assign hair color
		if(rand(2) == 0) monster.hairColor = "black";
		else monster.hairColor = "brown";
		monster.hairLength = 3+rand(20);
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "tan";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		//3 - cowface
		monster.faceType = 3;
		monster.horns = 2;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 1;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		//7 - cow!
		monster.tailType = 7;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 4;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 5;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 0;
		monster.breastRows[0].nipplesPerBreast = 1;
		monster.createCock();
		monster.cocks[0].cockLength = rand(13) + 14;
		monster.cocks[0].cockThickness = 1.5 + rand(20)/2;
		monster.cocks[0].cockType = CockTypesEnum.HUMAN;
		monster.balls = 2;
		monster.cumMultiplier = 1.5;
		monster.ballSize = 2 + rand(13);
		monster.hoursSinceCum = player.ballSize * 10;
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 1;
		monster.createStatusAffect("Bonus aCapacity",20,0,0,0);
		doNext(1);
	}
	//LOAD Kitsune
	if(monsterNum == 57) {
		monster.short="kitsune";
		monster.imageName="kitsune";
		monster.plural = false;
		monster.long = "A kitsune stands in front of you, about five and a half feet tall.  She has a head of ";
		
		if(monster.hairColor == "blonde") monster.long += "long flaxen";
		else if(monster.hairColor == "black") monster.long += "lustrous, ass-length black";
		else monster.long += "unkempt, shoulder-length reddish";
		monster.long += " hair.  She appears mostly human, except for a pair of large, furry ears poking through her hair and six luxurious silky tails swaying in the air behind her.  Her robes are revealing but comfortable-looking, hugging her voluptuous curves and exposing large swaths of tattooed skin.  A layer of ornate tattoos covers patches of her exposed flesh, accentuating her feminine curves nicely, and each movement brings a pleasant jiggle from her plump backside and large breasts.";
		if(rand(3) != 2) flags[redheadIsFuta] = 1;
		monster.a ="a ";
		monster.capitalA ="A ";
		monster.temperment = 1;
		monster.special1 = 5029;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "skin";
		monster.weaponName = "claws";
		monster.weaponVerb = "punch";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 35;
		monster.tou = 45;
		monster.spe = 90;
		monster.inte = 95;
		monster.lib = 60;
		monster.sens = 65;
		monster.cor = 45;
		monster.fatigue = 0;
		monster.lust = 20;
		
		monster.lustVuln = 0.9;
		//Combat Stats
		monster.bonusHP = 120;
		monster.HP = eMaxHP();
		
		//Level Stats
		monster.level = 6;
		monster.XP = totalXP();
		monster.gems = rand(10) + 10;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		if(flags[redheadIsFuta] == 1) monster.gender == 3;
		monster.tallness = rand(24) + 60;
		
		monster.hairLength = 13+rand(20);
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "pale";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		//3 - cowface
		monster.faceType = 3;
		monster.horns = 2;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		//7 - cow!
		monster.tailType = 13;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 6;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 5;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 4;
		monster.breastRows[0].nipplesPerBreast = 1;
		if(monster.hairColor == "red") {
			monster.createCock();
			monster.cocks[0].cockLength = rand(13) + 14;
			monster.cocks[0].cockThickness = 1.5 + rand(20)/2;
			monster.cocks[0].cockType = CockTypesEnum.HUMAN;
			monster.balls = 2;
			monster.cumMultiplier = 1.5;
			monster.ballSize = 2 + rand(13);
			monster.hoursSinceCum = player.ballSize * 10;
		}
		monster.ass.analLooseness = 1;
		monster.ass.analWetness = 1;
		monster.createVagina();
		monster.vaginas[0].vaginalWetness = 3;
		monster.vaginas[0].vaginalLooseness = 1;
		monster.createStatusAffect("Bonus aCapacity",20,0,0,0);
		monster.createStatusAffect("Bonus vCapacity",20,0,0,0);
		doNext(1);
	}
	//LOAD NAGGA PLEAS!
	if(monsterNum == 58) {
		monster.short="Sirius, a naga hypnotist";
		monster.imageName="Sirius";
		monster.plural = false;
		monster.long = "A strange being with the upper torso of a human man topped with the head of a giant serpent stands before you, hissing in anger and occasionally letting a long, fork-tipped tongue flicker out past his lips.  An imperial-featured masculine human face regards you with an indifferent expression.  A ponytail of deep orange - almost bright red - hair falls down between his shoulders, held together by snake-styled circlets of silver, and matching bracelets of the same material and design adorn his wrists. Scales begin at his lower waist, concealing his manhood from you; he's completely naked otherwise.  His snake body is long and slender, covered in finely meshing scales of a rich orange-red shade, the red broken by a pattern of randomly thick or thin stripes of black.  His burning yellow eyes stare directly into yours, vertical slits of pupils fixated on your own as he undulates and coils in an eerily seductive manner.";
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 5109;
		monster.special2 = 5110;
		monster.special3 = 5111;
		monster.pronoun1 = "he";
		monster.pronoun2 = "him";
		monster.pronoun3 = "his";
		
		//Clothing/Armor
		monster.armorName = "scales";
		monster.weaponName = "fangs";
		monster.weaponVerb = "bite";
		monster.armorDef = 30;
		monster.armorPerk = "";
		monster.weaponAttack = 25;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 75;
		monster.tou = 70;
		monster.spe = 75;
		monster.inte = 92;
		monster.lib = 45;
		monster.sens = 35;
		monster.cor = 40;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 400;
		monster.HP = eMaxHP();
		
		monster.lust = 30;
		
		//Level Stats
		monster.level = 12;
		monster.XP = totalXP();
		monster.gems = rand(5) + 8;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = 70;
		monster.hairColor = "orange";
		monster.hairLength = 16;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "mediterranean-toned";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 8;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 8;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 0;
		monster.createCock();
		monster.cocks[0].cockLength = 14;
		monster.cocks[0].cockThickness = 2;
		monster.ass.analLooseness = 1;
		monster.createStatusAffect("Bonus aCapacity",10,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}
	if(monsterNum == 59) {
		monster.short="minotaur lord";
		monster.imageName="MinotaurLord";
		monster.plural = false;
		monster.long = "Across from you is the biggest minotaur you've ever seen.  Fully eleven feet tall, this shaggy monstrosity has muscles so thick that they stand even through his thick, obscuring fur.  A leather collar with a tag indicates his status as 'pet' though it seems completely out of place on the herculean minotaur.  His legs and arms are like thick tree trunks, imposing and implacable, flexing fiercely with every movement.  This can only be a minotaur lord, a minotaur of strength and virility far beyond his lesser brothers. In his hands, a massive chain swings, connected to his collar, but used as an impromptu weapon for now.  A simple loincloth girds his groin, though it does little to hide the massive, erect length that tents it.  It winds up looking more like a simple, cloth condom than any sort of clothing, and it drips long strings of musky pre-slime in ribbons onto the ground.  Below, heavy testes, each easily the size of a basketball, swing in a taut, sloshing sack.  You can almost smell the liquid bounty he has for you, and the musk he's giving off makes it seem like a good idea...";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 1;
		monster.special1 = 5029;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "he";
		monster.pronoun2 = "him";
		monster.pronoun3 = "his";
		
		//Clothing/Armor
		monster.armorName = "thick fur";
		monster.weaponName = "chain";
		monster.weaponVerb = "chain-whip";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 50;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 125;
		monster.tou = 90;
		monster.spe = 30;
		monster.inte = 30;
		monster.lib = 70;
		monster.sens = 25;
		monster.cor = 85;
		monster.fatigue = 0;
		
		monster.lust = 50;
		monster.lustVuln = 0.33;
		//Combat Stats
		monster.bonusHP = 700;
		monster.HP = eMaxHP();
		//Level Stats
		monster.level = 15;
		monster.XP = totalXP();
		monster.gems = rand(5) + 5;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = rand(37) + 84;
		//randomly assign hair color
		if(rand(2) == 0) monster.hairColor = "black";
		else monster.hairColor = "brown";
		monster.hairLength = 3;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 1;
		monster.skinTone = "red";
		monster.skinDesc = "shaggy fur";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		//3 - cowface
		monster.faceType = 3;
		monster.horns = 2;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 1;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		//7 - cow!
		monster.tailType = 7;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 4;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 5;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 0;
		monster.breastRows[0].nipplesPerBreast = 1;
		monster.createCock();
		monster.cocks[0].cockLength = rand(13) + 24;
		monster.cocks[0].cockThickness = 2 + rand(3);
		monster.cocks[0].cockType = CockTypesEnum.HORSE;
		monster.balls = 2;
		monster.cumMultiplier = 1.5;
		monster.ballSize = 2 + rand(13);
		monster.hoursSinceCum = player.ballSize * 10;
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 1;
		monster.createStatusAffect("Bonus aCapacity",50,0,0,0);
		doNext(1);
	}
	//LOAD COW SUCCUBUS
	if(monsterNum == 60) {
		plotFight = true;
		monster.short="milky succubus";
		monster.imageName="MilkySuccubus";
		monster.plural = false;
		monster.long = "You are fighting a milky, cow-like succubus.  She stands about seven feet tall and is hugely voluptuous, with breasts three times the size of her head, tipped with a cluster of four obscenely teat-like nipples.  Her hips flare out into an exaggerated hourglass shape, with a long tail tipped with a fleshy arrow-head spade that waves above her spankable butt.  A small cowbell is tied at the base of the arrow-head with a cute little ribbon.  Wide, cow-like horns, easily appropriate for a minotaur, rise from her head, and she flicks bovine ears about the sides of her head whilst sashaying from side to side on demonic, high-heeled feet.  Her skin is a vibrant purple with splotches of shiny black here and there, including one large spot covering her right eye.  She's using a leather whip as a weapon.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 11020;
		//Lust attack
		monster.special2 = 11021;
		monster.special3 = 11022;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "demonic skin";
		monster.weaponName = "whip";
		monster.weaponVerb = "whipping";
		monster.armorDef = 10;
		monster.armorPerk = "";
		monster.weaponAttack = 10;
		monster.weaponPerk = "";
		monster.weaponValue = 150;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 75;
		monster.tou = 50;
		monster.spe = 125;
		monster.inte = 95;
		monster.lib = 90;
		monster.sens = 60;
		monster.cor = 99;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 700;
		monster.HP = eMaxHP();
		monster.lustVuln = .3;
		monster.lust = 40;
		
		//Level Stats
		monster.level = 16;
		monster.XP = totalXP() + 50;
		monster.gems = rand(25)+10;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = rand(9) + 60;
		monster.hairColor = "black";
		monster.hairLength = 13;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "blue";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 4;
		monster.hornType = 3;
		monster.wingDesc = "tiny hidden";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 5;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 3;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 10;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 9;
		//Create succubus sex attributes
		monster.createStatusAffect("Bonus vCapacity",300,0,0,0);
		monster.createVagina();
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 15;
		monster.vaginas[0].vaginalWetness = 5;
		monster.vaginas[0].vaginalLooseness = 1;
		monster.vaginas[0].virgin = false;
		monster.balls = 0;
		monster.cumMultiplier = 3;
		monster.ballSize = 0;
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 5;
		doNext(1);
	}
	if(monsterNum == 61) {
		monster.short="Kelt";
		monster.imageName="Kelt";
		monster.plural = false;
		monster.long = "Kelt has changed for the worse since your first meeting.  Gone is his muscular, barrel chest.  In its place is a softer frame, capped with tiny boobs - remnants of your last treatment.  His jaw is fairly square and chiselled (though less than before).  From the waist down, he has the body of a horse, complete with fairly large pair of balls and a decent-sized dong.  Both are smaller than they used to be, however.  He has his bow strung and out, clearly intent on defending himself from your less than gentle touches.";
		if(flags[KELT_BREAK_LEVEL] == 2) monster.long = "Kelt is looking less and less like the burly centaur from before, and more and more like a woman.  He looks more like an odd, androgynous hybrid than the beautiful woman you had turned him into.  He currently sports roughly b-cup breasts and a smallish, miniature horse-cock.  There's barely any hair on his human body, aside from a long mane of hair.  Each treatment seems to be more effective than the last, and you can't wait to see what happens after you tame him THIS time.";
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 1;
		monster.special1 = 0;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "he";
		monster.pronoun2 = "him";
		monster.pronoun3 = "his";
		
		//Clothing/Armor
		monster.armorName = "tough skin";
		monster.weaponName = "fist";
		monster.weaponVerb = "punch";
		monster.armorDef = 4;
		monster.armorPerk = "";
		monster.weaponAttack = 10;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 60;
		monster.tou = 70;
		monster.spe = 40;
		monster.inte = 20;
		monster.lib = 40;
		monster.sens = 25;
		monster.cor = 55;
		monster.fatigue = 0;
		
		monster.lust = 40;
		monster.lustVuln = 0.83;
		//Combat Stats
		monster.bonusHP = 200;
		monster.HP = eMaxHP();
		//Level Stats
		monster.level = 6;
		monster.XP = totalXP();
		monster.gems = rand(5) + 5;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = 84;
		//randomly assign hair color
		if(rand(2) == 0) monster.hairColor = "black";
		else monster.hairColor = "brown";
		monster.hairLength = 3;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "tan";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		//3 - cowface
		monster.faceType = 0;
		monster.horns = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 4;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		//7 - cow!
		monster.tailType = 1;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 4;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 5;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 0;
		monster.breastRows[0].nipplesPerBreast = 1;
		monster.createCock();
		monster.cocks[0].cockLength = 36;
		monster.cocks[0].cockThickness = 3.5;
		monster.cocks[0].cockType = CockTypesEnum.HORSE;
		monster.balls = 2;
		monster.cumMultiplier = 1.5;
		monster.ballSize = 2 + rand(13);
		monster.hoursSinceCum = player.ballSize * 10;
		monster.ass.analLooseness = 2;
		monster.ass.analWetness = 0;
		monster.createStatusAffect("Bonus aCapacity",50,0,0,0);
		doNext(1);
	}
	//Sheila
	if(monsterNum == 62) {
		monster.short="Sheila";
		monster.imageName="Sheila";
		monster.plural = false;
		monster.long = "Sheila is a slim, somewhat athletic woman, over six feet in height.  Most of her lightly-tanned skin is hidden, either by her vest and shorts or by the fuzzy fur that covers her legs from the thighs down to her prominent nails.  Her " + sheilaCup() + " breasts are briefly defined against the white of her shirt as she sways on her feet, ";
		//[(sheila corruption <=40)
		if(sheilaCorruption() <= 40) monster.long += "small, round things that match her slender frame.";
		else monster.long += "swollen, jiggling globes that stand in contrast to her slender body and tell a tale of all the corruption that has been pumped into her.";
		monster.long += "  Her straight, jaw-length auburn hair hangs unrestrained, falling around the fuzzy ears that stick out sideways from her head.  The hat she usually wears is hanging on her back by a string, pushed off to prevent its being lost in the chaos.  Something about slipping a rope around her own neck just to keep a hat tells you that Sheila's mind isn't really staying in the fight - though it could also be the desperate, faraway look in her eyes.";
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 1;
		monster.special1 = 0;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "clothes";
		monster.weaponName = "foot";
		monster.weaponVerb = "kick";
		monster.armorDef = 4;
		monster.armorPerk = "";
		monster.weaponAttack = 10;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 80;
		monster.tou = 45;
		monster.spe = 95;
		monster.inte = 50;
		monster.lib = 30;
		monster.sens = 45;
		monster.cor = 25;
		monster.fatigue = 0;
		
		monster.lust = 30;
		monster.lustVuln = 0.4;
		//Combat Stats
		monster.bonusHP = 200;
		monster.HP = eMaxHP();
		//Level Stats
		monster.level = 14;
		monster.XP = totalXP();
		monster.gems = rand(5) + 5;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = 72;
		//randomly assign hair color
		monster.hairColor = "auburn";
		monster.hairLength = 11;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "tan";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		//3 - cowface
		monster.faceType = 0;
		monster.horns = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		//7 - cow!
		monster.tailType = 1;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 4;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 5;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 0;
		monster.breastRows[0].nipplesPerBreast = 1;
		monster.createVagina();
		monster.vaginas[0].vaginalWetness = 3;
		monster.vaginas[0].vaginalLooseness = 1;
		monster.ass.analLooseness = 1;
		monster.ass.analWetness = 0;
		monster.createStatusAffect("Bonus aCapacity",20,0,0,0);
		monster.createStatusAffect("Bonus vCapacity",30,0,0,0);
		if(flags[SHEILA_DEMON] == 1) {
			//-slightly slower, has much more stamina, intel, and HP now
			monster.spe -= 15;
			monster.tou += 30
			monster.inte += 30;
			monster.bonusHP += 200;
			monster.HP = eMaxHP();
			monster.lust = 50;
			monster.lustVuln = .15;
			//-all special attacks are lust damage
			//-no normal attack
			//-starts with a high base lust(50%+), but also has high resistance to additional lust damage
			//-little higher difficulty than other plains fights, but not much
			//-now totally okay with taking gems and riding the player so hard he passes out for 8 hours regardless
			//-drops shitty kangaroo item and imp food
			monster.long = "Sheila is a slim, somewhat athletic woman, over six feet in height.  Her smooth, dark skin is exposed from her head to her clawed feet, and she makes no effort to conceal anything your eyes might linger on.  The " + sheilaCup() + " breasts on her chest";
			if(sheilaCorruption() <= 40) monster.long += " are firm, squeezable teardrops; she runs a hand absently over one from time to time.";
			else monster.long += " jiggle as she moves, and she shoves them out to make sure you see just how lewd her body has become since your first meeting.";
			monster.long += "  Straight, jaw-length auburn hair frames her face along with two long, smooth ears that stick out sideways.  Her only nods to civilization are a dangling purple earring and the finger rings that she wears on her hands, and the wild woman stares openly at you, touching herself.";
		}
		if(flags[SHEILA_XP] > 3 || flags[SHEILA_DEMON] > 0) {
			monster.vaginas[0].virgin = false;
		}
		doNext(1);
	}
	//LOAD MINERVA
	if(monsterNum == 63) {
		plotFight = true;
		monster.short="Minerva";
		monster.imageName="Minerva";
		monster.plural = false;
		monster.long = "You're fighting the tainted siren, Minerva.  Standing around eight feet and wielding a weapon just as tall, she is a force to be reckoned with.  Her skin is a dark navy blue, though her belly, neck and inner thighs are as white as the clouds in the sky, and a golden piecing decorates her navel.  Orange and white stripes adorn her legs, tail and back.  Two large wings sprout from her back, their feathers an attention-grabbing red and orange mix.  She wears a tube-top that hold back her double d-cups, and short shorts around her wide waist that seem to be holding back a huge bulge.\n\nHer weapon is a halberd, made from a shiny, silvery metal, and seems to have an unnatural glow to it.";
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 11020;
		//Lust attack
		monster.special2 = 11021;
		monster.special3 = 11022;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "comfortable clothes";
		monster.weaponName = "halberd";
		monster.weaponVerb = "slash";
		monster.armorDef = 1;
		monster.armorPerk = "";
		monster.weaponAttack = 30;
		monster.weaponPerk = "";
		monster.weaponValue = 150;
		monster.armorValue = 5;
		//Primary stats
		monster.str = 50;
		monster.tou = 65;
		monster.spe = 95;
		monster.inte = 75;
		monster.lib = 30;
		monster.sens = 25;
		monster.cor = 45;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 470;
		monster.HP = eMaxHP();
		monster.lustVuln = .2;
		monster.lust = 20;
		
		//Level Stats
		monster.level = 16;
		monster.XP = totalXP() + 50;
		monster.gems = rand(25)+10;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 3;
		monster.tallness = 101;
		monster.hairColor = "red";
		monster.hairLength = 25;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "blue";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.hornType = 0;
		monster.wingDesc = "fluffy feathery";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 4;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 10;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 9;
		//Create succubus sex attributes
		monster.createVagina();
		monster.createCock();
		monster.cocks[0].cockLength = 16;
		monster.cocks[0].cockThickness = 3;
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 5;
		monster.vaginas[0].vaginalWetness = 3;
		monster.vaginas[0].vaginalLooseness = 1;
		monster.vaginas[0].virgin = false;
		monster.balls = 2;
		monster.cumMultiplier = 3;
		monster.ballSize = 3;
		monster.ass.analLooseness = 1;
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//LOAD IMP
	if(monsterNum == 64) {
		monster.short="imp lord";
		monster.imageName="ImpLord";
		monster.plural = false;
		monster.long = "The greater imp has an angular face, complete with curved nose and burnt red skin typical of imps.  He has no hair on his head, leaving his cold, lust-clouded, black eyes unobstructed.  Just above his long pointed ears are two curved bovine horns.  While still short, he's much taller then the average imp, being nearly four feet tall, and extremely well-muscled.  A pair of powerful wings extends out from his shoulders, however, you suspect he wouldn't be able to fly for long due to his extreme bulk.  A thick coating of fur starts at his well toned hips and works it's way down his powerful legs.  His legs end in a pair of oddly jointed, demonic hooves.  His demonic figure is completed by a thin tail that has an arrowhead shaped tip.\n\nThe greater imp, like most imps wears very little clothing, only a simple loincloth and satchel hang from his waist.  You also note that the imp has two barbell piercings in his nipples. The creature doesn't seem to have any weapons, aside from his sharp black finger nails.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 1;
		monster.special1 = 5019;
		monster.special2 = 0;
		monster.special3 = 0;
		monster.pronoun1 = "he";
		monster.pronoun2 = "him";
		monster.pronoun3 = "his";
		
		//Clothing/Armor
		monster.armorName = "leathery skin";
		monster.weaponName = "fist";
		monster.weaponVerb = "punch";
		monster.armorDef = 5;
		monster.armorPerk = "";
		monster.weaponAttack = 10;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 55;
		monster.tou = 40;
		monster.spe = 75;
		monster.inte = 42;
		monster.lib = 55;
		monster.sens = 35;
		monster.cor = 100;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP
		monster.HP = eMaxHP();
		monster.lust = 30;
		monster.lustVuln = .65;
		
		//Level Stats
		monster.level = 7;
		monster.XP = totalXP();
		monster.gems = rand(15) + 25;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 1;
		monster.tallness = rand(14) + 40;
		monster.hairColor = "black";
		monster.hairLength = 0;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "red";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.wingDesc = "small";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 5;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 0;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 2;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 0;
		monster.breastRows[0].nipplesPerBreast = 0;
		monster.createCock();
		monster.cocks[0].cockLength = rand(2) + 11;
		monster.cocks[0].cockThickness = 2.5;
		monster.cocks[0].cockType = rand(3);
		if(monster.cocks[0].cockType == CockTypesEnum.HUMAN) monster.cocks[0].cockType = CockTypesEnum.DEMON;
		monster.balls = 2;
		monster.cumMultiplier = 3;
		monster.ballSize = 1;
		monster.hoursSinceCum = 20;
		monster.ass.analLooseness = 4;
		monster.ass.analWetness = 1;
		doNext(1);
	}
	//SAND WITCHES
	if(monsterNum == 65) {
		plotFight = true;
		monster.short="sand witches";
		monster.imageName="SandWitchMob";
		monster.plural = true;
		monster.long = "You are surrounded by a veritable tribe of sand witches.  Like the ones that roam the sands, they have simple robes, blond hair, and four big breasts that push at the concealing cloth immodestly.  Glowering at you hatefully, the pack of female spellcasters readies itself to drag you down with sheer numbers.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 11020;
		//Lust attack
		monster.special2 = 11021;
		monster.special3 = 11022;
		monster.pronoun1 = "they";
		monster.pronoun2 = "them";
		monster.pronoun3 = "their";
		
		//Clothing/Armor
		monster.armorName = "robes";
		monster.weaponName = "fists";
		monster.weaponVerb = "punches";
		monster.armorDef = 1;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 150;
		monster.armorValue = 5;
		//Primary stats
		monster.str = 25;
		monster.tou = 25;
		monster.spe = 35;
		monster.inte = 45;
		monster.lib = 55;
		monster.sens = 40;
		monster.cor = 30;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 80;
		monster.HP = eMaxHP();
		monster.lustVuln = .5;
		monster.lust = 30;
		
		//Level Stats
		monster.level = 4;
		monster.XP = totalXP();
		monster.gems = rand(15) + 5;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = rand(12) + 55;
		monster.hairColor = "sandy-blonde";
		monster.hairLength = 15;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "bronzed";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.wingDesc = "";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 10;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 5;
		monster.breastRows[0].nipplesPerBreast = 1;
		monster.createBreastRow();
		monster.breastRows[1].breastRating = 5;
		monster.breastRows[1].nipplesPerBreast = 1;
		monster.createVagina();
		monster.vaginas[0].vaginalWetness = 2;
		monster.vaginas[0].vaginalLooseness = 2;
		monster.vaginas[0].virgin = false;
		monster.cumMultiplier = 3;
		monster.hoursSinceCum = 20;
		monster.ass.analLooseness = 1;
		monster.ass.analWetness = 1;
		doNext(1);
	}
	//LOAD CUM WITCH
	if(monsterNum == 66) {
		monster.short="Cum Witch";
		monster.imageName="CumWitch";
		monster.plural = false;
		monster.long = "The Cum Witch is a moderately tall woman, almost six feet in height.  Her dark ebony skin is nearly as black as pitch, though it glitters with sweat from her recent sexual activities and the fight.  She has plump lips and long, smooth blonde hair, though much of it is hidden behind a pointed, wide-brimmed hat.  Her robes are even blacker than she is, but she wields an alabaster staff that fairly sizzles with magical might.  Of course, her garments don't do much to conceal her gigantic breasts.  Though there are only two, they're large enough to dwarf the four tits most sand witches are packing.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 5133;
		monster.special2 = 5134;
		monster.special3 = 5135;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "robes";
		monster.weaponName = "fists";
		monster.weaponVerb = "punches";
		monster.armorDef = 0;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		
		//Primary stats
		monster.str = 35;
		monster.tou = 35;
		monster.spe = 35;
		monster.inte = 85;
		monster.lib = 55;
		monster.sens = 40;
		monster.cor = 30;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 100;
		monster.HP = eMaxHP();
		monster.lustVuln = .8;
		monster.lust = 30;
		
		//Level Stats
		monster.level = 6;
		monster.XP = totalXP();
		monster.gems = rand(15) + 5;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = rand(12) + 55;
		monster.hairColor = "sandy-blonde";
		monster.hairLength = 15;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "black";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.wingDesc = "";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 10;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 7;
		monster.breastRows[0].nipplesPerBreast = 1;
		monster.createVagina();
		monster.createStatusAffect("Bonus vCapacity",20,0,0,0);
		monster.vaginas[0].vaginalWetness = 2;
		monster.vaginas[0].vaginalLooseness = 2;
		monster.vaginas[0].virgin = false;
		monster.cumMultiplier = 3;
		monster.hoursSinceCum = 20;
		monster.ass.analLooseness = 1;
		monster.ass.analWetness = 1;
		monster.createCock();
		monster.cocks[0].cockLength = 12;
		monster.cocks[0].cockThickness = 2;
		monster.cocks[0].cockType = CockTypesEnum.HUMAN;

		doNext(1);
	}
	//SAND MOTHER
	if(monsterNum == 67) {
		plotFight = true;
		monster.short="Sand Mother";
		monster.imageName="SandMother";
		monster.plural = false;
		monster.long = "The Sand Mother is a towering woman of imposing stature and bust.  She wears a much silkier, regal-looking robe than her sisters, and it barely serves to contain her four milk-laden breasts, straining under their jiggling weight.  Dangling around her in a way that reminds you oddly of a halo, the Sand Mother's blonde-white hair fans around her, hanging long behind her.  The queen witch is brandishing a pearly white scepter rather threateningly, though from the way she holds it, it's clear she doesn't intend to use it as a physical weapon.";
		monster.a ="the ";
		monster.capitalA ="The ";
		monster.temperment = 3;
		//Regular attack
		monster.special1 = 11020;
		//Lust attack
		monster.special2 = 11021;
		monster.special3 = 11022;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "robes";
		monster.weaponName = "fists";
		monster.weaponVerb = "punches";
		monster.armorDef = 1;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 150;
		monster.armorValue = 0;
		//Primary stats
		monster.str = 55;
		monster.tou = 55;
		monster.spe = 35;
		monster.inte = 45;
		monster.lib = 55;
		monster.sens = 40;
		monster.cor = 30;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 130;
		monster.HP = eMaxHP();
		monster.lustVuln = .6;
		monster.lust = 20;
		
		//Level Stats
		monster.level = 7;
		monster.XP = totalXP();
		monster.gems = rand(15) + 55;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness =  102;
		monster.hairColor = "platinum-blonde";
		monster.hairLength = 15;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "bronzed";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.wingDesc = "";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 10;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 5;
		monster.breastRows[0].nipplesPerBreast = 1;
		monster.createBreastRow();
		monster.breastRows[1].breastRating = 5;
		monster.breastRows[1].nipplesPerBreast = 1;
		monster.createVagina();
		monster.vaginas[0].vaginalWetness = 2;
		monster.vaginas[0].vaginalLooseness = 2;
		monster.vaginas[0].virgin = false;
		monster.createStatusAffect("Bonus vCapacity",70,0,0,0);
		monster.createStatusAffect("Bonus aCapacity",50,0,0,0);
		monster.createPerk("Resolute",0,0,0,0);
		monster.createPerk("Focused",0,0,0,0);
		monster.cumMultiplier = 3;
		monster.hoursSinceCum = 20;
		monster.ass.analLooseness = 1;
		monster.ass.analWetness = 1;
		doNext(1);
	}
	//LOAD HOLLI
	if(monsterNum == 68) {
		flags[FOUGHT_HOLLI] = 1;
		monster.short="Holli";
		monster.imageName="Holli";
		monster.plural = false;
		monster.long = "Marae's offshoot, Holli stands rooted in front of you.  Solid black eyes with golden pupils stare out at you.  Her normally-nude body is concealed inside her tree, though occasionally she will flash you the devilish grin of a sadistic temptress and the bark will split to reveal a pale, jiggling bit of flesh.  A pair of gnarled oak horns sprout from her forehead; leaves and flowers alternately bloom and wither on them as her face contorts with emotion.";
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 5133;
		monster.special2 = 5134;
		monster.special3 = 5135;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		//Clothing/Armor
		monster.armorName = "bark";
		monster.weaponName = "branches";
		monster.weaponVerb = "branchy thwack";
		monster.armorDef = 40;
		monster.armorPerk = "";
		monster.weaponAttack = 0;
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 0;
		
		//Primary stats
		monster.str = 150;
		monster.tou = 80;
		monster.spe = 80;
		monster.inte = 85;
		monster.lib = 75;
		monster.sens = 40;
		monster.cor = 80;
		monster.fatigue = 0;
		
		//Combat Stats
		monster.bonusHP = 1000;
		monster.HP = eMaxHP();
		monster.lustVuln = .2;
		monster.lust = 20;
		
		//Level Stats
		monster.level = 20;
		monster.XP = totalXP();
		monster.gems = 0;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = rand(12) + 55;
		monster.hairColor = "sandy-blonde";
		monster.hairLength = 15;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "black";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 0;
		monster.wingDesc = "";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 10;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 8;
		//Create imp sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 7;
		monster.breastRows[0].nipplesPerBreast = 1;
		monster.createVagina();
		monster.createStatusAffect("Bonus vCapacity",20,0,0,0);
		monster.vaginas[0].vaginalWetness = 2;
		monster.vaginas[0].vaginalLooseness = 2;
		monster.vaginas[0].virgin = false;
		monster.cumMultiplier = 3;
		monster.hoursSinceCum = 20;
		monster.ass.analLooseness = 1;
		monster.ass.analWetness = 1;
		monster.createCock();
		monster.cocks[0].cockLength = 12;
		monster.cocks[0].cockThickness = 2;
		monster.cocks[0].cockType = CockTypesEnum.HUMAN;

		doNext(1);
	}
	//LOAD HOLLI
	if(monsterNum == 69) {
		monster.short = flags[HELSPAWN_NAME];
		monster.imageName = "HolliSpawn"
		monster.plural = false;
		monster.long = "Marae's offshoot, Holli stands rooted in front of you.  Solid black eyes with golden pupils stare out at you.  Her normally-nude body is concealed inside her tree, though occasionally she will flash you the devilish grin of a sadistic temptress and the bark will split to reveal a pale, jiggling bit of flesh.  A pair of gnarled oak horns sprout from her forehead; leaves and flowers alternately bloom and wither on them as her face contorts with emotion.";
		helSpawnDesc();
		monster.a ="";
		monster.capitalA ="";
		monster.temperment = 2;
		//Lusty teases
		monster.special1 = 5133;
		monster.special2 = 5134;
		monster.special3 = 5135;
		monster.pronoun1 = "she";
		monster.pronoun2 = "her";
		monster.pronoun3 = "her";
		
		monster.armorDef = 12;
		monster.armorPerk = "";
		monster.weaponAttack = 20;
		monster.createStatusAffect("keen",0,0,0,0);
		monster.weaponPerk = "";
		monster.weaponValue = 0;
		monster.armorValue = 50;
		//Primary stats
		monster.str = 50;
		monster.tou = 50;
		monster.spe = 65;
		monster.inte = 40;
		monster.lib = 35;
		monster.sens = 55;
		monster.cor = 20;
		monster.fatigue = 0;
		monster.lustVuln = .55;
		
		//Combat Stats
		monster.bonusHP = 175;
		monster.HP = eMaxHP();
		
		monster.lust = 30;
	
		//Level Stats
		monster.level = 12;
		monster.XP = totalXP();
		monster.gems = 10 + rand(5);
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		monster.gender = 2;
		monster.tallness = 90;
		monster.hairColor = "red";
		monster.hairLength = 13;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		monster.skinType = 0;
		monster.skinTone = "helspawn";
		monster.skinDesc = "skin";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		monster.faceType = 0;
		monster.horns = 2;
		monster.hornType = 0;
		monster.wingDesc = "non-existant";
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		monster.wingType = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		monster.lowerBody = 0;
		//tailType:
		//0 - none
		//1 - horse
		//2 - dog
		//3 - demon
		//4 - cow!
		//5 - spider!
		//6 - bee!
		monster.tailType = 4;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		monster.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		monster.tailRecharge = 0;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		monster.hipRating = 12;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		monster.buttRating = 9;
		//Create goblin sex attributes
		monster.createBreastRow();
		monster.breastRows[0].breastRating = 8;
		monster.createVagina();
		monster.createStatusAffect("Bonus vCapacity",85,0,0,0);
		monster.vaginas[0].vaginalWetness = 1;
		monster.vaginas[0].vaginalLooseness = 1;
		monster.vaginas[0].virgin = false;
		monster.ass.analLooseness = 0;
		monster.createStatusAffect("Bonus aCapacity",85,0,0,0);
		monster.ass.analWetness = 0;
		doNext(1);
	}
	//Reduce enemy def if player has precision!
	if(player.hasPerk("Precision") >= 0 && player.inte >= 25) {
		if(monster.armorDef <= 10) monster.armorDef = 0;
		else monster.armorDef -= 10;
	}
}
function eMaxHP():Number {
	return monster.tou * 2 + 50 + monster.bonusHP;
}
function display():void {
	var percent:String = "";
	var math:Number = monster.HP/eMaxHP();
	if(monster.short == "worms") math = monster.HP/40;
	percent = "(<b>" + String(int(math * 1000) / 10) + "% HP</b>)";
	if (monster.imageName != "")
	{
		if (monster.imageName.indexOf("Mob") >= 0)
		{
			outputText(images.showImage("monster-" + monster.imageName), false);
		}
		else
		{
			outputText(images.showImage("monster-" + monster.imageName), false);
		}
	}
	if(gameState == 2) outputText("<b>You are grappling with:\n</b>", false);
	else outputText("<b>You are fighting ", false);
	outputText(monster.a + monster.short + ":</b> (Level: " + monster.level + ")\n");
	if(player.hasStatusAffect("Blind") >= 0) outputText("It's impossible to see anything!\n");
	else {
		outputText(monster.long + "\n", false);
		//Bonus sand trap stuff
		if(monster.hasStatusAffect("level") >= 0) {
			temp = monster.statusAffectv1("level");
			//[(new PG for PC height levels)PC level 4: 
			outputText("\n");
			if(temp == 4) outputText("You are right at the edge of its pit.  If you can just manage to keep your footing here, you'll be safe.");
			else if(temp == 3) outputText("The sand sinking beneath your feet has carried you almost halfway into the creature's pit.");
			else outputText("The dunes tower above you and the hissing of sand fills your ears.  <b>The leering sandtrap is almost on top of you!</b>");
			//no new PG)
			outputText("  You could try attacking it with your " + player.weaponName + ", but that will carry you straight to the bottom.  Alternately, you could try to tease it or hit it at range, or wait and maintain your footing until you can clamber up higher.");
			outputText("\n");
		}
		if(monster.plural || monster.short == "demons" || monster.short == "worms") {
			if(math >= 1) outputText("You see " + monster.pronoun1 + " are in perfect health.", false);
			else if(math > .75) outputText("You see " + monster.pronoun1 + " aren't very hurt.", false);
			else if(math > .5) outputText("You see " + monster.pronoun1 + " are slightly wounded.", false);
			else if(math > .25) outputText("You see " + monster.pronoun1 + " are seriously hurt.", false);
			else outputText("You see " + monster.pronoun1 + " are unsteady and close to death.", false);
		}
		else {
			if(math >= 1) outputText("You see " + monster.pronoun1 + " is in perfect health.", false);
			else if(math > .75) outputText("You see " + monster.pronoun1 + " isn't very hurt.", false);
			else if(math > .5) outputText("You see " + monster.pronoun1 + " is slightly wounded.", false);
			else if(math > .25) outputText("You see " + monster.pronoun1 + " is seriously hurt.", false);
			else outputText("You see " + monster.pronoun1 + " is unsteady and close to death.", false);
		}
		outputText("  " + percent + "\n", false);
		showMonsterLust();
	}
}
function enemyTeaseReaction(lustDelta:Number):void {
	lustDelta = monster.lustVuln * lustDelta;
	if(monster.short == "demons") {
		outputText("\n", false);
		if(lustDelta == 0) 
		if(lustDelta > 0 && lustDelta < 5) outputText("The demons lessen somewhat in the intensity of their attack, and some even eye up your assets as they strike at you.", false);
		if(lustDelta >= 5 && lustDelta < 10) outputText("The demons are obviously steering clear from damaging anything you might use to fuck and they're starting to leave their hands on you just a little longer after each blow. Some are starting to cop quick feels with their other hands and you can smell the demonic lust of a dozen bodies on the air.", false);
		if(lustDelta >= 10) outputText("The demons are less and less willing to hit you and more and more willing to just stroke their hands sensuously over you. The smell of demonic lust is thick on the air and part of the group just stands there stroking themselves openly.", false);
	}
	else if(monster.short == "Holli" && monster.hasStatusAffect("Holli Burning") >= 0) {
		outputText("Holli doesn't even seem to notice, so concerned is she with defeating you before the mounting bonfire causes her any more pain.");
		lustDelta = 0;
	}
	else if(monster.short == "milky succubus") {
		milkCubiGainsHPFromTeasing();
	}
	else if(monster.short == "lusty demons") {
		if(lustDelta > 0 && lustDelta < 5) outputText("The demons lessen somewhat in the intensity of their attack, and some even eye up your assets as they strike at you. Vapula has trouble giving her orders.");
		if(lustDelta >= 5 && lustDelta < 10) outputText("The demons are obviously avoiding damaging anything you might use to fuck and they're starting to leave their hands on you just a little longer after each blow.  Some are copping quick feels and you can smell the demonic lust on the air.  Vapula is starting to get frustrated as her minions are more and more reluctant to attack you, preferring to caress each other instead.");
		if(lustDelta >= 10) outputText("The demons are decreasingly willing to hit you and more and more willing to just stroke their hands sensuously over you.  Vapula is uncontrollably aroused herself and shivers even as she tries to maintain some semblance of offense, but most of the demons are visibly uncomfortable and some just lie on the ground, tamed by their own lust.");
	}
	//Amily has her own reaction.
	else if(amilyTeaseConcentration()) {}
	//Googals!
	else if(monster.short == "goo-girl") {
		if(monster.lust <= 99) {
			if(lustDelta <= 0) outputText("\nThe goo-girl looks confused by your actions, as if she's trying to understand what you're doing.", false);
			else if(lustDelta < 13) outputText("\nThe curious goo has begun stroking herself openly, trying to understand the meaning of your actions by imitating you.", false);
			else outputText("\nThe girl begins to understand your intent. She opens and closes her mouth, as if panting, while she works slimy fingers between her thighs and across her jiggling nipples.", false);
		}
		else outputText("\nIt appears the goo-girl has gotten lost in her mimicry, squeezing her breasts and jilling her shiny " + monster.skinTone + " clit. Her desire to investigate you forgotten.", false);
	}
	//Everybody else
	else {
		if(monster.plural) {
			if(lustDelta == 0) outputText("\n\n" + monster.capitalA + monster.short + " seem unimpressed.", false);
			if(lustDelta > 0 && lustDelta < 4) outputText("\n" + monster.capitalA + monster.short + " look intrigued by what " + monster.pronoun1 + " see.", false);
			if(lustDelta >= 4 && lustDelta < 10) outputText("\n" + monster.capitalA + monster.short + " definitely seem to be enjoying the show.", false);
			if(lustDelta >= 10 && lustDelta < 15) outputText("\n" + monster.capitalA + monster.short + " openly stroke " + monster.pronoun2 + "selves as " + monster.pronoun1 + " watch you.", false);
			if(lustDelta >= 15 && lustDelta < 20) outputText("\n" + monster.capitalA + monster.short + " flush hotly with desire, " + monster.pronoun3 + " eyes filled with longing.", false);
			if(lustDelta >= 20) outputText("\n" + monster.capitalA + monster.short + " lick " + monster.pronoun3 + " lips in anticipation, " + monster.pronoun3 + " hands idly stroking " + monster.pronoun3 + " bodies.", false);
		}
		else {
			if(lustDelta == 0) outputText("\n" + monster.capitalA + monster.short + " seems unimpressed.", false);
			if(lustDelta > 0 && lustDelta < 4) {
				if(monster.plural) outputText("\n" + monster.capitalA + monster.short + " looks intrigued by what " + monster.pronoun1 + " see.", false);
				else outputText("\n" + monster.capitalA + monster.short + " looks intrigued by what " + monster.pronoun1 + " sees.", false);
			}
			if(lustDelta >= 4 && lustDelta < 10) outputText("\n" + monster.capitalA + monster.short + " definitely seems to be enjoying the show.", false);
			if(lustDelta >= 10 && lustDelta < 15) {
				if(monster.plural) outputText("\n" + monster.capitalA + monster.short + " openly strokes " + monster.pronoun2 + "selves as " + monster.pronoun1 + " watch you.", false);
				else outputText("\n" + monster.capitalA + monster.short + " openly strokes " + monster.pronoun2 + "self as " + monster.pronoun1 + " watches you.", false);
			}
			if(lustDelta >= 15 && lustDelta < 20) {
				if(monster.plural) outputText("\n" + monster.capitalA + monster.short + " flush hotly with desire, " + monster.pronoun3 + " eyes filling with longing.", false);
				else outputText("\n" + monster.capitalA + monster.short + " flushes hotly with desire, " + monster.pronoun3 + " eyes filled with longing.", false);
			}
			if(lustDelta >= 20) {
				if(monster.plural) outputText("\n" + monster.capitalA + monster.short + " licks " + monster.pronoun3 + " lips in anticipation, " + monster.pronoun3 + " hands idly stroking " + monster.pronoun3 + " own bodies.", false);
				else outputText("\n" + monster.capitalA + monster.short + " licks " + monster.pronoun3 + " lips in anticipation, " + monster.pronoun3 + " hands idly stroking " + monster.pronoun3 + " own body.", false);
			}
		}
	}
	if(lustDelta > 0) {
		//Imp mob uber interrupt!
	  	if(monster.hasStatusAffect("ImpUber") >= 0) {
			outputText("\nThe imps in the back stumble over their spell, their loincloths tenting obviously as your display interrupts their casting.  One of them spontaneously orgasms, having managed to have his spell backfire.  He falls over, weakly twitching as a growing puddle of whiteness surrounds his defeated form.", false);
			//(-5% of max enemy HP)
			monster.HP -= monster.bonusHP * .05;
			monster.lust -= 15;
			monster.removeStatusAffect("ImpUber");
			monster.createStatusAffect("ImpSkip",0,0,0,0);
		}
	}
	monster.lust += lustDelta;
	lustDelta = Math.round(lustDelta * 10)/10;
	outputText(" (" + lustDelta + ")", false);
}
function showMonsterLust():void {
	//Entrapped
	if(monster.hasStatusAffect("Constricted") >= 0) {
		outputText(monster.capitalA + monster.short + " is currently wrapped up in your tail-coils!  ", false);
	}
	//Venom stuff!
	if(monster.hasStatusAffect("Naga Venom") >= 0) {
		if(monster.plural) {
			if(monster.statusAffectv1("Naga Venom") <= 1) {
				outputText("You notice " + monster.pronoun1 + " are beginning to show signs of weakening, but there still appears to be plenty of fight left in " + monster.pronoun2 + ".  ", false);
			}
    	    else {
				outputText("You notice " + monster.pronoun1 + " are obviously affected by your venom, " + monster.pronoun3 + " movements become unsure, and " + monster.pronoun3 + " balance begins to fade. Sweat begins to roll on " + monster.pronoun3 + " skin. You wager " + monster.pronoun1 + " are probably beginning to regret provoking you.  ", false);
			}
		}
		//Not plural
		else {
			if(monster.statusAffectv1("Naga Venom") <= 1) {
				outputText("You notice " + monster.pronoun1 + " is beginning to show signs of weakening, but there still appears to be plenty of fight left in " + monster.pronoun2 + ".  ", false);
			}
    	    else {
				outputText("You notice " + monster.pronoun1 + " is obviously affected by your venom, " + monster.pronoun3 + " movements become unsure, and " + monster.pronoun3 + " balance begins to fade. Sweat is beginning to roll on " + monster.pronoun3 + " skin. You wager " + monster.pronoun1 + " is probably beginning to regret provoking you.  ", false);
			}
		}
		
		monster.spe -= monster.statusAffectv1("Naga Venom");
		monster.str -= monster.statusAffectv1("Naga Venom");
		if(monster.spe < 1) monster.spe = 1;
		if(monster.str < 1) monster.str = 1;
	}
	if(monster.short == "harpy") {
		//(Enemy slightly aroused) 
		if(monster.lust >= 45 && monster.lust < 70) outputText("The harpy's actions are becoming more and more erratic as she runs her mad-looking eyes over your body, her chest jiggling, clearly aroused.  ", false);
		//(Enemy moderately aroused) 
		if(monster.lust >= 70 && monster.lust < 90) outputText("She stops flapping quite so frantically and instead gently sways from side to side, showing her soft, feathery body to you, even twirling and raising her tail feathers, giving you a glimpse of her plush pussy, glistening with fluids.", false);
		//(Enemy dangerously aroused) 
		if(monster.lust >= 90) outputText("You can see her thighs coated with clear fluids, the feathers matted and sticky as she struggles to contain her lust.", false);
	}
	//{Bonus Lust Descripts}
	else if(monster.short == "Minerva") {
		if(monster.lust < 40) {}
		//(40)
		else if(monster.lust < 60) outputText("Letting out a groan Minerva shakes her head focusing on the fight at hand.  The bulge in her short is getting larger, but the siren ignores her growing hard-on and continues to keep fighting.  ");
		//(60) 
		else if(monster.lust < 80) outputText("Tentacles are squirming out from the crotch of her shorts as the throbbing bulge grows bigger and bigger.  Becoming harder and harder... for Minerva to ignore.  And a damp spot has formed just below the bulge.  ");
		//(80)
		else outputText("She's holding onto her weapon for support as her face is flushed and pain-stricken.  Her tiny, short shorts are painfully holding back her quaking bulge, making the back of the fabric act like a thong as they ride up her ass and struggle against her cock.  Her cock-tentacles are lashing out in every direction.  The dampness has grown and is leaking down her leg.");
	}
	else if(monster.short == "Cum Witch") {
		//{Bonus Lust Desc (40+)}
		if(monster.lust < 40) {}
		else if(monster.lust < 50) outputText("Her nipples are hard, and poke two visible tents into the robe draped across her mountainous melons.  ");
		//{Bonus Lust Desc (50-75)}
		else if(monster.lust < 75) outputText("Wobbling dangerously, you can see her semi-hard shaft rustling the fabric as she moves, evidence of her growing needs.  ");
		//{75+}
		if(monster.lust >= 75) outputText("Swelling obscenely, the Cum Witch's thick cock stands out hard and proud, its bulbous tip rustling through the folds of her fabric as she moves and leaving dark smears it its wake.  ");
		//(85+}
		if(monster.lust >= 85) outputText("Every time she takes a step, those dark patches seem to double in size.  ");
		//{93+}
		if(monster.lust >= 93) outputText("There's no doubt about it, the Cum Witch is dripping with pre-cum and so close to caving in.  Hell, the lower half of her robes are slowly becoming a seed-stained mess.  ");
		//{Bonus Lust Desc (60+)}
		if(monster.lust >= 70) outputText("She keeps licking her lips whenever she has a moment, and she seems to be breathing awfully hard.  ");
	}
	else if(monster.short == "Kelt") {
		//Kelt Lust Levels
		//(sub 50)
		if(monster.lust < 50) outputText("Kelt actually seems to be turned off for once in his miserable life.  His maleness is fairly flaccid and droopy.  ");
		//(sub 60)
		else if(monster.lust < 60) outputText("Kelt's gotten a little stiff down below, but he still seems focused on taking you down.  ");
		//(sub 70)
		else if(monster.lust < 70) outputText("Kelt's member has grown to its full size and even flared a little at the tip.  It bobs and sways with every movement he makes, reminding him how aroused you get him.  ");
		//(sub 80)
		else if(monster.lust < 80) outputText("Kelt has unabashedly aroused at this point.  His skin is flushed, his manhood is erect, and a thin bead of pre has begun to bead underneath.  ");
		//(sub 90)
		else if(monster.lust < 90) outputText("Kelt seems to be having trouble focusing.  He keeps pausing and flexing his muscles, slapping his cock against his belly and moaning when it smears his pre-cum over his equine underside.  ");
		//(sub 100) 
		else outputText("There can be no doubt that you're having quite the effect on Kelt.  He keeps fidgeting, dripping pre-cum everywhere as he tries to keep up the facade of fighting you.  His maleness is continually twitching and bobbing, dripping messily.  He's so close to giving in...");
	}
	else if(monster.short == "green slime") {
		if(monster.lust >= 45 && monster.lust < 65) outputText("A lump begins to form at the base of the figure's torso, where its crotch would be.  ", false); 
		if(monster.lust >= 65 && monster.lust < 85) outputText("A distinct lump pulses at the base of the slime's torso, as if something inside the creature were trying to escape.  ", false);
		if(monster.lust >= 85 && monster.lust < 93) outputText("A long, thick pillar like a small arm protrudes from the base of the slime's torso.  ", false);
		if(monster.lust >= 93) outputText("A long, thick pillar like a small arm protrudes from the base of the slime's torso.  Its entire body pulses, and it is clearly beginning to lose its cohesion.  ", false);
		return;	
	}
	else if(monster.short == "Sirius, a naga hypnotist") {
		if(monster.lust < 40) {}
		else if(monster.lust >= 40) outputText("You can see the tip of his reptilian member poking out of its protective slit. ");
		else if(monster.lust >= 60) outputText("His cock is now completely exposed and half-erect, yet somehow he still stays focused on your eyes and his face is inexpressive.  ");
		else outputText("His cock is throbbing hard, you don't think it will take much longer for him to pop.   Yet his face still looks inexpressive... despite the beads of sweat forming on his brow.  ");

	}
	else if(monster.short == "kitsune") {
		//Kitsune Lust states:
		//Low
		if(monster.lust > 30 && monster.lust < 50) outputText("The kitsune's face is slightly flushed.  She fans herself with her hand, watching you closely.");
		//Med
		else if(monster.lust > 30 && monster.lust < 75) outputText("The kitsune's cheeks are bright pink, and you can see her rubbing her thighs together and squirming with lust.");
		//High
		else if(monster.lust > 30) {
			//High (redhead only)
			if(monster.hairColor == "red") outputText("The kitsune is openly aroused, unable to hide the obvious bulge in her robes as she seems to be struggling not to stroke it right here and now.");
			else outputText("The kitsune is openly aroused, licking her lips frequently and desperately trying to hide the trail of fluids dripping down her leg.");
		}
	}
	else if(monster.short == "demons") {
		if(monster.lust > 30 && monster.lust < 60) outputText("The demons lessen somewhat in the intensity of their attack, and some even eye up your assets as they strike at you.", false);
		if(monster.lust >= 60 && monster.lust < 80) outputText("The demons are obviously steering clear from damaging anything you might use to fuck and they're starting to leave their hands on you just a little longer after each blow. Some are starting to cop quick feels with their other hands and you can smell the demonic lust of a dozen bodies on the air.", false);
		if(monster.lust >= 80) outputText(" The demons are less and less willing to hit you and more and more willing to just stroke their hands sensuously over you. The smell of demonic lust is thick on the air and part of the group just stands there stroking themselves openly.", false);
	}
	else {
		if(monster.plural) {
			if(monster.lust > 50 && monster.lust < 60) outputText(monster.capitalA + monster.short + "' skin remains flushed with the beginnings of arousal.  ", false);
			if(monster.lust >= 60 && monster.lust < 70) outputText(monster.capitalA + monster.short + "' eyes constantly dart over your most sexual parts, betraying " + monster.pronoun3 + " lust.  ", false);
			if(monster.cocks.length > 0) {
				if(monster.lust >= 70 && monster.lust < 85) outputText(monster.capitalA + monster.short + " are having trouble moving due to the rigid protrusion in " + monster.pronoun3 + " groins.  ", false);
				if(monster.lust >= 85) outputText(monster.capitalA + monster.short + " are panting and softly whining, each movement seeming to make " + monster.pronoun3 + " bulges more pronounced.  You don't think " + monster.pronoun1 + " can hold out much longer.  ", false);
			}
			if(monster.vaginas.length > 0) {
				if(monster.lust >= 70 && monster.lust < 85) outputText(monster.capitalA + monster.short + " are obviously turned on, you can smell " + monster.pronoun3 + " arousal in the air.  ", false);
				if(monster.lust >= 85) outputText(monster.capitalA + monster.short + "' " + eVaginaDescript(0) + "s are practically soaked with their lustful secretions.  ", false);
			}
		}
		else {
			if(monster.lust > 50 && monster.lust < 60) outputText(monster.capitalA + monster.short + "'s skin remains flushed with the beginnings of arousal.  ", false);
			if(monster.lust >= 60 && monster.lust < 70) outputText(monster.capitalA + monster.short + "'s eyes constantly dart over your most sexual parts, betraying " + monster.pronoun3 + " lust.  ", false);
			if(monster.cocks.length > 0) {
				if(monster.lust >= 70 && monster.lust < 85) outputText(monster.capitalA + monster.short + " is having trouble moving due to the rigid protrusion in " + monster.pronoun3 + " groin.  ", false);
				if(monster.lust >= 85) outputText(monster.capitalA + monster.short + " is panting and softly whining, each movement seeming to make " + monster.pronoun3 + " bulge more pronounced.  You don't think " + monster.pronoun1 + " can hold out much longer.  ", false);
			}
			if(monster.vaginas.length > 0) {
				if(monster.lust >= 70 && monster.lust < 85) outputText(monster.capitalA + monster.short + " is obviously turned on, you can smell " + monster.pronoun3 + " arousal in the air.  ", false);
				if(monster.lust >= 85) outputText(monster.capitalA + monster.short + "'s " + eVaginaDescript(0) + " is practically soaked with her lustful secretions.  ", false);
			}
		}
	}
}

function tease():void {
	outputText("", true);
	//You cant tease a blind guy!
	if(monster.hasStatusAffect("Blind") >= 0) {
		outputText("You do your best to tease " + monster.a + monster.short + " with your body.  It doesn't work - you blinded " + monster.pronoun2 + ", remember?\n\n", true);
		return;
	}
	if(player.hasStatusAffect("Sealed") >= 0 && player.statusAffectv2("Sealed") == 1) {
		outputText("You do your best to tease " + monster.a + monster.short + " with your body.  Your artless twirls have no effect, as <b>your ability to tease is sealed.</b>\n\n", true);
		return;
	}	
	if(monster.short == "Sirius, a naga hypnotist") {
		outputText("He is too focused on your eyes to pay any attention to your teasing moves, <b>looks like you'll have to beat him up.</b>\n\n");
		return;
	}
	fatigueRecovery();
	var damage:Number = 0;
	var chance:Number= 0;
	var bimbo:Boolean = false;
	var bro:Boolean = false;
	var futa:Boolean = false;
	var choices:Array = new Array();
	var select:Number = 0;
	//Tags used for bonus damage and chance later on
	var breasts:Boolean = false;
	var penis:Boolean = false;
	var balls:Boolean = false;
	var vagina:Boolean = false;
	var anus:Boolean = false;
	var ass:Boolean = false;
	//If auto = true, set up bonuses using above flags
	var auto:Boolean = true;
	//==============================
	//Determine basic success chance.
	//==============================
	chance = 60;
	//5% chance for each tease level.
	chance += player.teaseLevel * 5;
	//10% for seduction perk
	if(player.hasPerk("Seduction") >= 0) chance += 10;
	//10% for sexy armor types
	if(player.hasPerk("Slutty Seduction") >= 0) chance += 10;
	//10% for bimbo shits
	if(player.hasPerk("Bimbo Body") >= 0) {
		chance += 10;
		bimbo = true;
	}
	if(player.hasPerk("Bro Body") >= 0) {
		chance += 10;
		bro = true;
	}
	if(player.hasPerk("Futa Form") >= 0) {
		chance += 10;
		futa = true;
	}
	//2 & 2 for seductive valentines!
	if(player.hasPerk("Sensual Lover") >= 0) {
		chance += 2;
	}
	//==============================
	//Determine basic damage.
	//==============================
	damage = 6 + rand(3);
	if(player.hasPerk("Sensual Lover") >= 0) {
		damage += 2;
	}
	if(player.hasPerk("Seduction") >= 0) damage += 5;
	//+ slutty armor bonus
	if(player.hasPerk("Slutty Seduction") >= 0) damage += player.perkv1("Slutty Seduction");
	//10% for bimbo shits
	if(bimbo || bro || futa) {
		damage += 5;
		bimbo = true;
	}
	damage += player.level;
	damage += player.teaseLevel*2;
	//==============================
	//TEASE SELECT CHOICES
	//==BASICS========
	//0 butt shake
	//1 breast jiggle
	//2 pussy flash
	//3 cock flash
	//==BIMBO STUFF===
	//4 butt shake
	//5 breast jiggle
	//6 pussy flash
	//7 special Adjatha-crafted bend over bimbo times
	//==BRO STUFF=====
	//8 Pec Dance
	//9 Heroic Pose
	//10 Bulgy groin thrust
	//11 Show off dick
	//==EXTRAS========
	//12 Cat flexibility.
	//13 Pregnant
	//14 Brood Mother
	//15 Nipplecunts
	//16 Anal gape
	//17 Bee abdomen tease
	//18 DOG TEASE
	//19 Maximum Femininity:
	//20 Maximum MAN:
	//21 Perfect Androgyny:
	//22 SPOIDAH SILK
	//23 RUT
	//24 Poledance - req's staff! - Req's gender!  Req's TITS!
	//25 Tall Tease! - Reqs 2+ feet & PC Cunt!
	//26 SMART PEEPS! 70+ int, arouse spell!
	//27 - FEEDER
	//28 FEMALE TEACHER COSTUME TEASE
	//29 Male Teacher Outfit Tease
	//30 Naga Fetish Clothes
	//31 Centaur harness clothes
	//32 Genderless servant clothes
	//33 Crotch Revealing Clothes (herm only?)
	//34 Maid Costume (female only):
	//35 Servant Boy Clothes (male only)
	//36 Bondage Patient Clothes 
	//37 Kitsune Tease
	//38 Kitsune Tease
	//39 Kitsune Tease
	//40 Kitsune Tease
	//41 Kitsune Gendered Tease
	//42 Urta teases
	//43 Cowgirl teases
	//44 Bikini Mail Tease
	//==============================
	//BUILD UP LIST OF TEASE CHOICES!
	//==============================
	//Futas!
	if((futa || bimbo) && player.gender == 3) {
		//Once chance of butt.
		choices[choices.length] = 4;
		//Big butts get more butt
		if(player.buttRating >= 7) choices[choices.length] = 4;
		if(player.buttRating >= 10) choices[choices.length] = 4;
		if(player.buttRating >= 14) choices[choices.length] = 4;
		if(player.buttRating >= 20) choices[choices.length] = 4;
		if(player.buttRating >= 25) choices[choices.length] = 4;
		//Breast jiggle!
		if(player.biggestTitSize() >= 2) choices[choices.length] = 5;
		if(player.biggestTitSize() >= 4) choices[choices.length] = 5;
		if(player.biggestTitSize() >= 8) choices[choices.length] = 5;
		if(player.biggestTitSize() >= 15) choices[choices.length] = 5;
		if(player.biggestTitSize() >= 30) choices[choices.length] = 5;
		if(player.biggestTitSize() >= 50) choices[choices.length] = 5;
		if(player.biggestTitSize() >= 75) choices[choices.length] = 5;
		if(player.biggestTitSize() >= 100) choices[choices.length] = 5;
		//Pussy Flash!
		if(player.hasVagina()) {
			choices[choices.length] = 2;
			if(player.wetness() >= 3) choices[choices.length] = 6;
			if(player.wetness() >= 5) choices[choices.length] = 6;
			if(player.vaginalCapacity() >= 30) choices[choices.length] = 6;
			if(player.vaginalCapacity() >= 60) choices[choices.length] = 6;
			if(player.vaginalCapacity() >= 75) choices[choices.length] = 6;
		}
		//Adj special!
		if(player.hasVagina() && player.buttRating >= 8 && player.hipRating >= 6 && player.biggestTitSize() >= 4) {
			choices[choices.length] = 7;
			choices[choices.length] = 7;
			choices[choices.length] = 7;
			choices[choices.length] = 7;
		}
		//Cock flash!
		if(futa && player.hasCock()) {
			choices[choices.length] = 10;
			choices[choices.length] = 11;
			if(player.cockTotal() > 1) choices[choices.length] = 10;
			if(player.cockTotal() >= 2) choices[choices.length] = 11;
			if(player.biggestCockArea() >= 10) choices[choices.length] = 10;
			if(player.biggestCockArea() >= 25) choices[choices.length] = 11;
			if(player.biggestCockArea() >= 50) choices[choices.length] = 11;
			if(player.biggestCockArea() >= 75) choices[choices.length] = 10;
			if(player.biggestCockArea() >= 100) choices[choices.length] = 11;
			if(player.biggestCockArea() >= 300) choices[choices.length] = 10;
		}
	}
	else if(bro) {
		//8 Pec Dance
		if(player.biggestTitSize() < 1 && player.tone >= 60) {
			choices[choices.length] = 8;
			if(player.tone >= 70) choices[choices.length] = 8;
			if(player.tone >= 80) choices[choices.length] = 8;
			if(player.tone >= 90) choices[choices.length] = 8;
			if(player.tone == 100) choices[choices.length] = 8;
		}
		//9 Heroic Pose
		if(player.tone >= 60 && player.str >= 50) {
			choices[choices.length] = 9;
			if(player.tone >= 80) choices[choices.length] = 9;
			if(player.str >= 70) choices[choices.length] = 9;
			if(player.tone >= 90) choices[choices.length] = 9;
			if(player.str >= 80) choices[choices.length] = 9;
		}	
		//Cock flash!
		if(player.hasCock()) {
			choices[choices.length] = 10;
			choices[choices.length] = 11;
			if(player.cockTotal() > 1) choices[choices.length] = 10;
			if(player.cockTotal() >= 2) choices[choices.length] = 11;
			if(player.biggestCockArea() >= 10) choices[choices.length] = 10;
			if(player.biggestCockArea() >= 25) choices[choices.length] = 11;
			if(player.biggestCockArea() >= 50) choices[choices.length] = 11;
			if(player.biggestCockArea() >= 75) choices[choices.length] = 10;
			if(player.biggestCockArea() >= 100) choices[choices.length] = 11;
			if(player.biggestCockArea() >= 300) choices[choices.length] = 10;
		}
	}
	//VANILLA FOLKS
	else {
		//Once chance of butt.
		choices[choices.length] = 0;
		//Big butts get more butt
		if(player.buttRating >= 7) choices[choices.length] = 0;
		if(player.buttRating >= 10) choices[choices.length] = 0;
		if(player.buttRating >= 14) choices[choices.length] = 0;
		if(player.buttRating >= 20) choices[choices.length] = 0;
		if(player.buttRating >= 25) choices[choices.length] = 0;
		//Breast jiggle!
		if(player.biggestTitSize() >= 2) choices[choices.length] = 1;
		if(player.biggestTitSize() >= 4) choices[choices.length] = 1;
		if(player.biggestTitSize() >= 8) choices[choices.length] = 1;
		if(player.biggestTitSize() >= 15) choices[choices.length] = 1;
		if(player.biggestTitSize() >= 30) choices[choices.length] = 1;
		if(player.biggestTitSize() >= 50) choices[choices.length] = 1;
		if(player.biggestTitSize() >= 75) choices[choices.length] = 1;
		if(player.biggestTitSize() >= 100) choices[choices.length] = 1;
		//Pussy Flash!
		if(player.hasVagina()) {
			choices[choices.length] = 2;
			if(player.wetness() >= 3) choices[choices.length] = 2;
			if(player.wetness() >= 5) choices[choices.length] = 2;
			if(player.vaginalCapacity() >= 30) choices[choices.length] = 2;
			if(player.vaginalCapacity() >= 60) choices[choices.length] = 2;
			if(player.vaginalCapacity() >= 75) choices[choices.length] = 2;
		}
		//Cock flash!
		if(player.hasCock()) {
			choices[choices.length] = 3;
			if(player.cockTotal() > 1) choices[choices.length] = 3;
			if(player.cockTotal() >= 2) choices[choices.length] = 3;
			if(player.biggestCockArea() >= 10) choices[choices.length] = 3;
			if(player.biggestCockArea() >= 25) choices[choices.length] = 3;
			if(player.biggestCockArea() >= 50) choices[choices.length] = 3;
			if(player.biggestCockArea() >= 75) choices[choices.length] = 3;
			if(player.biggestCockArea() >= 100) choices[choices.length] = 3;
			if(player.biggestCockArea() >= 300) choices[choices.length] = 3;
		}
	}
	//==EXTRAS========
	//12 Cat flexibility.
	if(player.hasPerk("Flexibility") >= 0 && player.isBiped() && player.hasVagina()) {
		choices[choices.length] = 12;
		choices[choices.length] = 12;
		if(player.wetness() >= 3) choices[choices.length] = 12;
		if(player.wetness() >= 5) choices[choices.length] = 12;
		if(player.vaginalCapacity() >= 30) choices[choices.length] = 12;
	}
	//13 Pregnant
	if(player.pregnancyIncubation <= 216 && player.pregnancyIncubation > 0) {
		choices[choices.length] = 13;
		if(player.biggestLactation() >= 1) choices[choices.length] = 13;
		if(player.pregnancyIncubation <= 180) choices[choices.length] = 13;
		if(player.pregnancyIncubation <= 120) choices[choices.length] = 13;
		if(player.pregnancyIncubation <= 100) choices[choices.length] = 13;
		if(player.pregnancyIncubation <= 50) choices[choices.length] = 13;
		if(player.pregnancyIncubation <= 24) choices[choices.length] = 13;
		if(player.pregnancyIncubation <= 24) choices[choices.length] = 13;
		if(player.pregnancyIncubation <= 24) choices[choices.length] = 13;
		if(player.pregnancyIncubation <= 24) choices[choices.length] = 13;
	}
	//14 Brood Mother
	if(monster.hasCock() && player.hasVagina() && player.hasPerk("Brood Mother") >= 0 && (player.pregnancyIncubation <= 0 || player.pregnancyIncubation > 216)) {
		choices[choices.length] = 14;
		choices[choices.length] = 14;
		choices[choices.length] = 14;
		if(player.hasStatusAffect("heat") >= 0) choices[choices.length] = 14;
		if(player.hasStatusAffect("heat") >= 0) choices[choices.length] = 14;
		if(player.hasStatusAffect("heat") >= 0) choices[choices.length] = 14;
		if(player.hasStatusAffect("heat") >= 0) choices[choices.length] = 14;
		if(player.hasStatusAffect("heat") >= 0) choices[choices.length] = 14;
		if(player.hasStatusAffect("heat") >= 0) choices[choices.length] = 14;
		if(player.hasStatusAffect("heat") >= 0) choices[choices.length] = 14;
	}
	//15 Nipplecunts
	if(player.hasFuckableNipples()) {
		choices[choices.length] = 15;
		choices[choices.length] = 15;
		if(player.hasVagina()) choices[choices.length] = 15;
		if(player.hasVagina()) choices[choices.length] = 15;
		if(player.hasVagina()) choices[choices.length] = 15;
		if(player.wetness() >= 3) choices[choices.length] = 15;
		if(player.wetness() >= 5) choices[choices.length] = 15;
		if(player.biggestTitSize() >= 3) choices[choices.length] = 15;
		if(player.nippleLength >= 3) choices[choices.length] = 15;
	}
	//16 Anal gape
	if(player.ass.analLooseness >= 4) {
		choices[choices.length] = 16;
		if(player.ass.analLooseness >= 5) choices[choices.length] = 16;
	}		
	//17 Bee abdomen tease
	if(player.tailType == 6) {
		choices[choices.length] = 17;
		choices[choices.length] = 17;
	}
	//18 DOG TEASE
	if(player.dogScore() >= 4 && player.hasVagina() && player.isBiped()) {
		choices[choices.length] = 18;
		choices[choices.length] = 18;
	}
	//19 Maximum Femininity:
	if(player.femininity >= 100) {
		choices[choices.length] = 19;
		choices[choices.length] = 19;
		choices[choices.length] = 19;
	}
	//20 Maximum MAN:
	if(player.femininity <= 0) {
		choices[choices.length] = 20;
		choices[choices.length] = 20;
		choices[choices.length] = 20;
	}
	//21 Perfect Androgyny:
	if(player.femininity == 50) {
		choices[choices.length] = 21;
		choices[choices.length] = 21;
		choices[choices.length] = 21;
	}
	//22 SPOIDAH SILK
	if(player.tailType == 5) {
		choices[choices.length] = 22;
		choices[choices.length] = 22;
		choices[choices.length] = 22;
		if(player.spiderScore() >= 4) {
			choices[choices.length] = 22;
			choices[choices.length] = 22;
			choices[choices.length] = 22;
		}
	}
	//23 RUT
	if(player.hasStatusAffect("rut") >= 0 && monster.hasVagina() && player.hasCock()) {
		choices[choices.length] = 23;
		choices[choices.length] = 23;
		choices[choices.length] = 23;
		choices[choices.length] = 23;
		choices[choices.length] = 23;
	}
	//24 Poledance - req's staff! - Req's gender!  Req's TITS!
	if(player.weaponName == "wizard's staff" && player.biggestTitSize() >= 1 && player.gender > 0) {
		choices[choices.length] = 24;
		choices[choices.length] = 24;
		choices[choices.length] = 24;
		choices[choices.length] = 24;
		choices[choices.length] = 24;
	}
	//25 Tall Tease! - Reqs 2+ feet & PC Cunt!
	if(player.tallness - monster.tallness >= 24 && player.biggestTitSize() >= 4) {
		choices[choices.length] = 25;
		choices[choices.length] = 25;
		choices[choices.length] = 25;
		choices[choices.length] = 25;
		choices[choices.length] = 25;
	}
	//26 SMART PEEPS! 70+ int, arouse spell!
	if(player.inte >= 70 && player.hasStatusAffect("Knows Arouse") >= 0) {
		choices[choices.length] = 26;
		choices[choices.length] = 26;
		choices[choices.length] = 26;
	}
	//27 FEEDER
	if(player.hasPerk("Feeder") >= 0 && player.biggestTitSize() >= 4) {
		choices[choices.length] = 27;
		choices[choices.length] = 27;
		choices[choices.length] = 27;
		if(player.biggestTitSize() >= 10) choices[choices.length] = 27;
		if(player.biggestTitSize() >= 15) choices[choices.length] = 27;
		if(player.biggestTitSize() >= 25) choices[choices.length] = 27;
		if(player.biggestTitSize() >= 40) choices[choices.length] = 27;
		if(player.biggestTitSize() >= 60) choices[choices.length] = 27;
		if(player.biggestTitSize() >= 80) choices[choices.length] = 27;
	}
	//28 FEMALE TEACHER COSTUME TEASE
	if(player.armorName == "backless female teacher's clothes" && player.gender == 2) {
		choices[choices.length] = 28;
		choices[choices.length] = 28;
		choices[choices.length] = 28;
		choices[choices.length] = 28;
	}
	//29 Male Teacher Outfit Tease
	if(player.armorName == "formal vest, tie, and crotchless pants" && player.gender == 1) {
		choices[choices.length] = 29;
		choices[choices.length] = 29;
		choices[choices.length] = 29;
		choices[choices.length] = 29;
	}
	//30 Naga Fetish Clothes
	if(player.armorName == "headdress, necklaces, and many body-chains") {
		choices[choices.length] = 30;
		choices[choices.length] = 30;
		choices[choices.length] = 30;
		choices[choices.length] = 30;
	}
	//31 Centaur harness clothes
	if(player.armorName == "bridle bit and saddle set") {
		choices[choices.length] = 31;
		choices[choices.length] = 31;
		choices[choices.length] = 31;
		choices[choices.length] = 31;
	}
	//32 Genderless servant clothes
	if(player.armorName == "servant's clothes" && player.gender == 0) {
		choices[choices.length] = 32;
		choices[choices.length] = 32;
		choices[choices.length] = 32;
		choices[choices.length] = 32;
	}
	//33 Crotch Revealing Clothes (herm only?)
	if(player.armorName == "crotch-revealing clothes" && player.gender == 3) {
		choices[choices.length] = 33;
		choices[choices.length] = 33;
		choices[choices.length] = 33;
		choices[choices.length] = 33;
	}
	//34 Maid Costume (female only):
	if(player.armorName == "maid's clothes" && player.hasVagina()) {
		choices[choices.length] = 34;
		choices[choices.length] = 34;
		choices[choices.length] = 34;
		choices[choices.length] = 34;
	}
	//35 Servant Boy Clothes (male only)
	if(player.armorName == "cute servant's clothes" && player.hasCock()) {
		choices[choices.length] = 35;
		choices[choices.length] = 35;
		choices[choices.length] = 35;
		choices[choices.length] = 35;
	}
	//36 Bondage Patient Clothes 
	if(player.armorName == "bondage patient clothes") {
		choices[choices.length] = 36;
		choices[choices.length] = 36;
		choices[choices.length] = 36;
		choices[choices.length] = 36;
	}	
	//37 Kitsune Tease
	//38 Kitsune Tease
	//39 Kitsune Tease
	//40 Kitsune Tease
	if(player.kitsuneScore() >= 2 && player.tailType == 13) {
		choices[choices.length] = 37;
		choices[choices.length] = 37;
		choices[choices.length] = 37;
		choices[choices.length] = 37;
		choices[choices.length] = 38;
		choices[choices.length] = 38;
		choices[choices.length] = 38;
		choices[choices.length] = 38;
		choices[choices.length] = 39;
		choices[choices.length] = 39;
		choices[choices.length] = 39;
		choices[choices.length] = 39;
		choices[choices.length] = 40;
		choices[choices.length] = 40;
		choices[choices.length] = 40;
		choices[choices.length] = 40;
	}
	//41 Kitsune Gendered Tease
	if(player.kitsuneScore() >= 2 && player.tailType == 13) {
		choices[choices.length] = 41;
		choices[choices.length] = 41;
		choices[choices.length] = 41;
		choices[choices.length] = 41;
	}
	//42 Urta teases!
	if(player.short == "Urta" && player.hasCock() && player.hasVagina() && player.balls > 0) {
		choices[choices.length] = 42;
		choices[choices.length] = 42;
		choices[choices.length] = 42;
		choices[choices.length] = 42;
		choices[choices.length] = 42;
		choices[choices.length] = 42;
		choices[choices.length] = 42;
		choices[choices.length] = 42;
		choices[choices.length] = 42;
	}
	//43 - special mino + cowgirls
	if(player.hasVagina() && player.lactationQ() >= 500 && player.biggestTitSize() >= 6 && player.cowScore() >= 3 && player.tailType == 4) {
		choices[choices.length] = 43;
		choices[choices.length] = 43;
		choices[choices.length] = 43;
		choices[choices.length] = 43;
		choices[choices.length] = 43;
		choices[choices.length] = 43;
		choices[choices.length] = 43;
		choices[choices.length] = 43;
		choices[choices.length] = 43;
	}
	//44 - Bikini Mail Teases!
	if(player.hasVagina() && player.biggestTitSize() >= 4 && player.armorName == "lusty maiden's armor") {
		choices[choices.length] = 44;
		choices[choices.length] = 44;
		choices[choices.length] = 44;
		choices[choices.length] = 44;
		choices[choices.length] = 44;
		choices[choices.length] = 44;
		choices[choices.length] = 44;
		choices[choices.length] = 44;
		choices[choices.length] = 44;
		choices[choices.length] = 44;
		choices[choices.length] = 44;
		choices[choices.length] = 44;
		choices[choices.length] = 44;
		choices[choices.length] = 44;
		choices[choices.length] = 44;
	}
	//=======================================================
	//    CHOOSE YOUR TEASE AND DISPLAY IT!
	//=======================================================
	select = choices[rand(choices.length)];
	if(monster.short.indexOf("minotaur") != -1) 
	{
		if(player.hasVagina() && player.lactationQ() >= 500 && player.biggestTitSize() >= 6 && player.cowScore() >= 3 && player.tailType == 4)
			select = 43;
	}
	//Lets do zis!
	switch(select) {
		//0 butt shake
		case 0:
			//Display
			outputText("You slap your " + buttDescript(), false);
			if(player.buttRating >= 10 && player.tone < 60) outputText(", making it jiggle delightfully.", false);
			else outputText(".", false);
			//Mod success
			ass = true;
			break;
		//1 BREAST JIGGLIN'
		case 1:
			//Single breast row
			if(player.breastRows.length == 1) {
				//50+ breastsize% success rate
				outputText("Your lift your top, exposing your " + breastDescript(0) + " to " + monster.a + monster.short + ".  You shake them from side to side enticingly.", false);
				if(player.lust >= 50) outputText("  Your " + nippleDescript(0) + "s seem to demand " + monster.pronoun3 + " attention.", false);
			}
			//Multirow
			if(player.breastRows.length > 1) {
				//50 + 10% per breastRow + breastSize%
				outputText("You lift your top, freeing your rows of " + breastDescript(0) + " to jiggle freely.  You shake them from side to side enticingly", false);
				if(player.lust >= 50) outputText(", your " + nippleDescript(0) + "s painfully visible.", false);
				else outputText(".", false);
				chance++;
			}
			breasts = true;
			break;
		//2 PUSSAH FLASHIN'
		case 2:
			if(player.isTaur()) {
				outputText("You gallop toward your unsuspecting enemy, dodging their defenses and knocking them to the ground.  Before they can recover, you slam your massive centaur ass down upon them, stopping just short of using crushing force to pin them underneath you.  In this position, your opponent's face is buried right in your girthy horsecunt.  You grind your cunt into " + monster.pronoun3 + " face for a moment before standing.  When you do, you're gratified to see your enemy covered in your lubricant and smelling powerfully of horsecunt.", false);
				chance += 2;
				damage += 4;
			}
			else {	
				outputText("You open your " + player.armorName + ", revealing your ", false);
				if(player.cocks.length > 0) {
					chance++;
					damage++;
					if(player.cocks.length == 1) outputText(cockDescript(0), false);
					if(player.cocks.length > 1) outputText(multiCockDescriptLight(), false);
					outputText(" and ", false);
					if(player.hasPerk("Bulge Armor") >= 0) {
						damage += 5;
					}
					penis = true;
				}
				outputText(vaginaDescript(0), false);
				outputText(".", false);
			}
			vagina = true;
			break;
		//3 cock flash
		case 3:
			if(player.isTaur() && player.horseCocks() > 0) {
				outputText("You let out a bestial whinny and stomp your hooves at your enemy.  They prepare for an attack, but instead you kick your front hooves off the ground, revealing the hefty horsecock hanging beneath your belly.  You let it flop around, quickly getting rigid and to its full erect length.  You buck your hips as if you were fucking a mare in heat, letting your opponent know just what's in store for them if they surrender to pleasure...", false);
				if(player.hasPerk("Bulge Armor") >= 0) damage += 5;
			}
			else {
				outputText("You open your " + player.armorName + ", revealing your ", false);
				if(player.cocks.length == 1) outputText(cockDescript(0), false);
				if(player.cocks.length > 1) outputText(multiCockDescriptLight(), false);
				if(player.hasVagina()) outputText(" and ", false);
				//Bulgy bonus!
				if(player.hasPerk("Bulge Armor") >= 0) {
					damage += 5;
					chance++;
				}
				if(player.vaginas.length > 0) {
					outputText(vaginaDescript(0), false);
					vagina = true;
				}
				outputText(".", false);
			}
			penis = true;
			break;
		//BIMBO
		//4 butt shake
		case 4:
			outputText("You turn away and bounce your " + buttDescript() + " up and down hypnotically", false);
			//Big butts = extra text + higher success
			if(player.buttRating >= 10) {
				outputText(", making it jiggle delightfully.  " + monster.capitalA + monster.short + " even gets a few glimpses of the " + assholeDescript() + " between your cheeks.", false);
				chance += 3;
			}
			//Small butts = less damage, still high success
			else {
				outputText(", letting " + monster.a + monster.short + " get a good look at your " + assholeDescript() + " and " + vaginaDescript(0) + ".", false);
				chance += 1;
				vagina = true;
			}
			ass = true;
			anus = true;
			break;
		//5 breast jiggle
		case 5:
			outputText("You lean forward, letting the well-rounded curves of your " + allBreastsDescript() + " show to " + monster.a + monster.short + ".", false);
			outputText("  You cup them in your palms and lewdly bounce them, putting on a show and giggling the entire time.  An inch at a time, your " + player.armorName + " starts to come down, dropping tantalizingly slowly until your " + nippleDescript(0) + "s pop free.", false);
			if(player.lust >= 50) {
				if(player.hasFuckableNipples()) {
					chance++;
					outputText("  Clear slime leaks from them, making it quite clear that they're more than just nipples.", false);
				}
				else outputText("  Your hard nipples seem to demand " + monster.pronoun3 + " attention.", false);
				chance += 1;
				damage += 2;
			}
			//Damage boosts!
			breasts = true;
			break;
		//6 pussy flash
		case 6:
			if(player.hasPerk("Bimbo Brains") >= 0) outputText("You coyly open your " + player.armorName + " and giggle, \"<i>Is this, like, what you wanted to see?</i>\"  ", false);
			else {
				outputText("You coyly open your " + player.armorName + " and purr, \"<i>Does the thought of a hot, ", false);
				if(futa) outputText("futanari ", false);
				else if(player.hasPerk("Bimbo Body") >= 0) outputText("bimbo ", false);
				else outputText("sexy ");
				outputText("body turn you on?</i>\"  ", false);
			}
			if(monster.plural) outputText(monster.capitalA + monster.short + "' gazes are riveted on your groin as you run your fingers up and down your folds seductively.", false);
			else outputText(monster.capitalA + monster.short + "'s gaze is riveted on your groin as you run your fingers up and down your folds seductively.", false);
			if(player.clitLength > 3) outputText("  You smile as your " + clitDescript() + " swells out from the folds and stands proudly, begging to be touched.", false);
			else outputText("  You smile and pull apart your lower-lips to expose your " + clitDescript() + ", giving the perfect view.", false);
			if(player.cockTotal() > 0) outputText("  Meanwhile, " + sMultiCockDesc() + " bobs back and forth with your gyrating hips, adding to the display.", false);
			//BONUSES!
			if(player.hasCock()) {
				if(player.hasPerk("Bulge Armor") >= 0) damage += 5;
				penis = true;
			}
			vagina = true;
			break;
		//7 special Adjatha-crafted bend over bimbo times
		case 7:
			outputText("The glinting of light catches your eye and you whip around to inspect the glittering object, turning your back on " + monster.a + monster.short + ".  Locking your knees, you bend waaaaay over, " + chestDesc() + " swinging in the open air while your " + buttDescript() + " juts out at the " + monster.a + monster.short + ".  Your plump cheeks and " + hipDescript() + " form a jiggling heart-shape as you eagerly rub your thighs together.\n\n", false);
			outputText("The clear, warm fluid of your happy excitement trickles down from your loins, polishing your " + player.skin() + " to a glossy, inviting shine.  Retrieving the useless- though shiny- bauble, you hold your pose for just a moment longer, a sly little smile playing across your lips as you wiggle your cheeks one more time before straightening up and turning back around.", false);
			vagina = true;
			chance++;
			damage += 2;
			break;
		//==BRO STUFF=====
		//8 Pec Dance
		case 8:
			outputText("You place your hands on your hips and flex repeatedly, skillfully making your pecs alternatively bounce in a muscular dance.  ", false);
			if(player.hasPerk("Bro Brains") >= 0) outputText("Damn, " + monster.a + monster.short + " has got to love this!", false);
			else outputText(monster.capitalA + monster.short + " will probably enjoy the show, but you feel a bit silly doing this.", false);
			chance += (player.tone - 75)/5;
			damage += (player.tone - 70)/5;
			auto = false;
			break;
		//9 Heroic Pose
		case 9:
			outputText("You lift your arms and flex your incredibly muscular arms while flashing your most disarming smile.  ", false);
			if(player.hasPerk("Bro Brains") >= 0) outputText(monster.capitalA + monster.short + " can't resist such a heroic pose!", false);
			else outputText("At least the physical changes to your body are proving useful!", false);
			chance += (player.tone - 75)/5;
			damage += (player.tone - 70)/5;
			auto = false;
			break;
		//10 Bulgy groin thrust
		case 10:
			outputText("You lean back and pump your hips at " + monster.a + monster.short + " in an incredibly vulgar display.  The bulging, barely-contained outline of your " + cockDescript(0) + " presses hard into your gear.  ", false);
			if(player.hasPerk("Bro Brains") >= 0) outputText("No way could " + monster.pronoun1 + " resist your huge cock!", false);
			else outputText("This is so crude, but at the same time, you know it'll likely be effective.", false);
			outputText("  You go on like that, humping the air for your foe", false);
			outputText("'s", false);
			outputText(" benefit, trying to entice them with your man-meat.", false);
			if(player.hasPerk("Bulge Armor") >= 0) damage += 5;
			penis = true;
			break;
		//11 Show off dick
		case 11:
			if(silly() && rand(2) == 0) outputText("You strike a herculean pose and flex, whispering, \"<i>Do you even lift?</i>\" to " + monster.a + monster.short + ".", false);
			else {
				outputText("You open your " + player.armorName + " just enough to let your " + cockDescript(0) + " and " + ballsDescriptLight() + " dangle free.  A shiny rope of pre-cum dangles from your cock, showing that your reproductive system is every bit as fit as the rest of you.  ", false);
				if(player.hasPerk("Bro Brains") >= 0) outputText("Bitches love a cum-leaking cock.", false);
				else outputText("You've got to admit, you look pretty good down there.", false);
			}
			if(player.hasPerk("Bulge Armor") >= 0) damage += 5;
			penis = true;
			break;
		//==EXTRAS========
		//12 Cat flexibility.
		case 12:
			//CAT TEASE MOTHERFUCK (requires flexibility and legs [maybe can't do it with armor?])
			outputText("Reaching down, you grab an ankle and pull it backwards, looping it up and over to touch the foot to your " + hairDescript() + ".  You bring the leg out to the side, showing off your " + vaginaDescript(0) + " through your " + player.armorName + ".  The combination of the lack of discomfort on your face and the ease of which you're able to pose shows " + monster.a + monster.short + " how good of a time they're in for with you.", false);
			vagina = true;
			if(player.thickness < 33) chance++;
			else if(player.thickness >= 66) chance--;
			damage += (player.thickness - 50)/10;
			break;
		//13 Pregnant
		case 13:
			//PREG
			outputText("You lean back, feigning a swoon while pressing a hand on the small of your back.  The pose juts your huge, pregnant belly forward and makes the shiny spherical stomach look even bigger.  With a teasing groan, you rub the protruding tummy gently, biting your lip gently as you stare at " + monster.a + monster.short + " through heavily lidded eyes.  \"<i>All of this estrogen is making me frisky,</i>\" you moan, stroking hand gradually shifting to the southern hemisphere of your big baby-bump.", false);
			//if lactating] 
			if(player.biggestLactation() >= 1) {
				outputText("  Your other hand moves to expose your " + chestDesc() + ", cupping and squeezing a stream of milk to leak down the front of your " + player.armorName + ".  \"<i>Help a mommy out.</i>\"\n\n", false);
				chance += 2;
				damage += 4;
			}
			if(player.pregnancyIncubation < 100) {
				chance++;
				damage += 2;
			}
			if(player.pregnancyIncubation < 50) {
				chance++;
				damage += 2;
			}
			break;
		//14 Brood Mother
		case 14:
			if(rand(2) == 0) outputText("You tear open your " + player.armorName + " and slip a few fingers into your well-used birth canal, giving your opponent a good look at what they're missing.  \"<i>C'mon stud,</i>\" you say, voice dripping with lust and desire, \"<i>Come to mama " + player.short + " and fuck my pussy 'till your baby batter just POURS out.  I want your children inside of me, I want your spawn crawling out of this cunt and begging for my milk.  Come on, FUCK ME PREGNANT!</i>\"", false);
			else outputText("You wiggle your " + hipDescript() + " at your enemy, giving them a long, tantalizing look at the hips that have passed so very many offspring.  \"<i>Oh, like what you see, bad boy?  Well why don't you just come on over and stuff that cock inside me?  Give me your seed, and I'll give you suuuuch beautiful offspring.  Oh?  Does that turn you on?  It does!  Come on, just let loose and fuck me full of your babies!</i>\"", false);
			chance += 2;
			damage += 4;
			if(player.hasStatusAffect("heat") >= 0) {
				chance += 2;
				damage += 4;
			}
			vagina = true;
			break;
		//15 Nipplecunts
		case 15:
			//Req's tits & Pussy
			if(player.biggestTitSize() > 1 && player.hasVagina() && rand(2) == 0) {
				outputText("Closing your eyes, you lean forward and slip a hand under your " + player.armorName + ".  You let out the slightest of gasps as your fingers find your drooling honeypot, warm tips poking, one after another between your engorged lips.  When you withdraw your hand, your fingers have been soaked in the dripping passion of your cunny, translucent beads rolling down to wet your palm.  With your other hand, you pull down the top of your " + player.armorName + " and bare your " + chestDesc() + " to " + monster.a + monster.short + ".\n\n", false);
				outputText("Drawing your lust-slick hand to your " + nippleDescript(0) + "s, the yielding flesh of your cunt-like nipples parts before the teasing digits.  Using your own girl cum as added lubrication, you pump your fingers in and out of your nipples, moaning as you add progressively more digits until only your thumb remains to stroke the inflamed flesh of your over-stimulated chest.  Your throat releases the faintest squeak of your near-orgasmic delight and you pant, withdrawing your hands and readjusting your armor.\n\n", false);
				outputText("Despite how quiet you were, it's clear that every lewd, desperate noise you made was heard by " + monster.a + monster.short + ".", false);
				chance += 2;
				damage += 4;
			}
			else if(player.biggestTitSize() > 1 && rand(2) == 0) {
				outputText("You yank off the top of your " + player.armorName + ", revealing your " + chestDesc() + " and the gaping nipplecunts on each.  With a lusty smirk, you slip a pair of fingers into the nipples of your " + chestDesc() + ", pulling the nipplecunt lips wide, revealing the lengthy, tight passage within.  You fingerfuck your nipplecunts, giving your enemy a good show before pulling your armor back on, leaving the tantalizing image of your gaping titpussies to linger in your foe's mind.", false);
				chance += 1;
				damage += 2;
			}
			else outputText("You remove the front of your " + player.armorName + " exposing your " + chestDesc() + ".  Using both of your hands, you thrust two fingers into your nipple cunts, milky girl cum soaking your hands and fingers.  \"<i>Wouldn't you like to try out these holes too?</i>\"", false);
			breasts = true;
			break;
		//16 Anal gape
		case 16:
			outputText("You quickly strip out of your " + player.armorName + " and turn around, giving your " + buttDescript() + " a hard slap and showing your enemy the real prize: your " + assholeDescript() + ".  With a smirk, you easily plunge your hand inside, burying yourself up to the wrist inside your anus.  You give yourself a quick fisting, watching the enemy over your shoulder while you moan lustily, sure to give them a good show.  You withdraw your hand and give your ass another sexy spank before readying for combat again.", false);
			anus = true;
			ass = true;
			break;
		//17 Bee abdomen tease
		case 17:
			outputText("You swing around, shedding the " + player.armorName + " around your waist to expose your " + buttDescript() + " to " + monster.a + monster.short + ".  Taking up your oversized bee abdomen in both hands, you heft the thing and wave it about teasingly.  Drops of venom drip to and fro, a few coming dangerously close to " + monster.pronoun2 + ".  \"<i>Maybe if you behave well enough, I'll even drop a few eggs into your belly,</i>\" you say softly, dropping the abdomen back to dangle above your butt and redressing.", false);
			ass = true;
			chance += .5;
			damage += .5;
			break;			
		//18 DOG TEASE
		case 18:
			outputText("You sit down like a dog, your [legs] are spread apart, showing your ", false);
			if(player.hasVagina()) outputText("parted cunt-lips", false);
			else outputText("puckered asshole, hanging, erect maleness,", false);
			outputText(" and your hands on the ground in front of you.  You pant heavily with your tongue out and promise, \"<i>I'll be a good little bitch for you</i>.\"", false);
			vagina = true;
			chance += 1;
			damage += 2;
			break;
		//19 MAX FEM TEASE - SYMPHONIE
		case 19:
			outputText("You make sure to capture your foe's attention, then slowly and methodically allow your tongue to slide along your lush, full lips.  The glistening moisture that remains on their plump beauty speaks of deep lust and deeper throats.  Batting your long lashes a few times, you pucker them into a playful blown kiss, punctuating the act with a small moan. Your gorgeous feminine features hint at exciting, passionate moments together, able to excite others with just your face alone.", false);
			chance += 2;
			damage += 4;
			break;
		//20 MAX MASC TEASE
		case 20:
			outputText("As your foe regards you, you recognize their attention is fixated on your upper body.  Thrusting your strong jaw forward you show off your chiseled chin, handsome features marking you as a flawless specimen.  Rolling your broad shoulders, you nod your head at your enemy.  The strong, commanding presence you give off could melt the heart of an icy nun.  Your perfect masculinity speaks to your confidence, allowing you to excite others with just your face alone.", false);
			chance += 2;
			damage += 4;
			break;
		//21 MAX ADROGYN
		case 21:
			outputText("You reach up and run your hands down your delicate, androgynous features.  With the power of a man but the delicacy of a woman, looking into your eyes invites an air of enticing mystery.  You blow a brief kiss to your enemy while at the same time radiating a sexually exciting confidence.  No one could identify your gender by looking at your features, and the burning curiosity they encourage could excite others with just your face alone.", false);
			damage -= 3;
			break;
		//22 SPOIDAH SILK
		case 22:
			outputText("Reaching back, you milk some wet silk from your spider-y abdomen and present it to " + monster.a + monster.short + ", molding the sticky substance as " + monster.pronoun1 + " looks on curiously.  Within moments, you hold up a silken heart scuplture, and with a wink, you toss it at " + monster.pronoun2 + ". It sticks to " + monster.pronoun3 + " body, the sensation causing " + monster.pronoun2 + " to hastily slap the heart off.  " + monster.mf("He","She") + " returns " + monster.pronoun3 + " gaze to you to find you turned around, " + buttDescript() + " bared and abdomen bouncing lazily.  \"<i>I wonder what would happen if I webbed up your hole after I dropped some eggs inside?</i>\" you hiss mischievously.  " + monster.mf("He","She") + " gulps.", false);
			ass = true;
			break;
		//23 RUT TEASE
		case 23:
			if(player.horseCocks() > 0 && player.longestHorseCockLength() >= 12) {
				outputText("You whip out your massive horsecock, and are immediately surrounded by a massive, heady musk.  Your enemy swoons, nearly falling to her knees under your oderous assault.  Grinning, you grab her shoulders and force her to her knees.  Before she can defend herself, you slam your horsecock onto her head, running it up and down on her face, her nose acting like a sexy bump in an onahole.  You fuck her face -- literally -- for a moment before throwing her back and sheathing your cock.", false);
			}
			else {
				outputText("Panting with your unstoppable lust for the deliscious, impregnatable cunt before you, you yank off your " + player.armorName + " with strength born of your inhuman rut, and quickly wave your fully erect cock at your enemy.  She flashes with lust, quickly feeling the heady effect of your man-musk.  You rush up, taking advantage of her aroused state and grab her shoulders.  ", false);
				outputText("Before she can react, you push her down until she's level with your cock, and start to spin it in a circle, slapping her right in the face with your musky man-meat.  Her eyes swim, trying to follow your meatspin as you swat her in the face with your cock!  Satisfied, you release her and prepare to fight!", false);
			}
			penis = true;
			break
		//24 STAFF POLEDANCE
		case 24:
			outputText("You run your tongue across your lips as you plant your staff into the ground.  Before your enemy can react, you spin onto the long, wooden shaft, using it like an impromptu pole.  You lean back against the planted staff, giving your enemy a good look at your body.  You stretch backwards like a cat, nearly touching your fingertips to the ground beneath you, now holding onto the staff with only one leg.  You pull yourself upright and give your " + buttDescript() + " a little slap and your " + chestDesc() + " a wiggle before pulling open your " + player.armorName + " and sliding the pole between your tits.  You drop down to a low crouch, only just covering your genitals with your hand as you shake your " + buttDescript() + " playfully.  You give the enemy a little smirk as you slip your " + player.armorName + " back on and pick up your staff.", false);
			ass = true;
			breasts = true;
			break;
		//TALL WOMAN TEASE
		case 25:
			outputText("You move close to your enemy, handily stepping over " + monster.pronoun3 + " defensive strike before leaning right down in " + monster.pronoun3 + " face, giving " + monster.pronoun2 + " a good long view at your cleavage.  \"<i>Hey, there, little " + monster.mf("guy","girl") + ",</i>\" you smile.  Before " + monster.pronoun1 + " can react, you grab " + monster.pronoun2 + " and smoosh " + monster.pronoun3 + " face into your " + allChestDesc() + ", nearly choking " + monster.pronoun2 + " in the canyon of your cleavage.  " + monster.mf("He","She") + " struggles for a moment.  You give " + monster.pronoun2 + " a little kiss on the head and step back, ready for combat.", false);
			breasts = true;
			chance += 2;
			damage += 4;
			break;
		//Magic Tease
		case 26:
			outputText("Seeing a lull in the battle, you plant your " + player.weaponName + " on the ground and let your magic flow through you.  You summon a trickle of magic into a thick, slowly growing black ball of lust.  You wave the ball in front of you, making a little dance and striptease out of the affair as you slowly saturate the area with latent sexual magics.", false);
			chance++;
			damage += 2;
			break;
		//Feeder
		case 27:
			outputText("You present your swollen breasts full of milk to " + monster.a + monster.short + " and say \"<i>Wouldn't you just love to lie back in my arms and enjoy what I have to offer you?</i>\"", false);
			breasts = true;
			chance ++;
			damage++;
			break;
		//28 FEMALE TEACHER COSTUME TEASE
		case 28:
			outputText("You turn to the side and give " + monster.a + monster.short + " a full view of your body.  You ask them if they're in need of a private lesson in lovemaking after class.", false);
			ass = true;
			break;
		//29 Male Teacher Outfit Tease
		case 29:
			outputText("You play with the strings on your outfit a bit and ask " + monster.a + monster.short + " just how much do they want to see their teacher pull them off?", false);
			chance++;
			damage += 3;
			break;
		//30 Naga Fetish Clothes
		case 30:
			outputText("You sway your body back and forth, and do an erotic dance for " + monster.a + monster.short + ".", false);
			chance += 2;
			damage += 4;
			break;
		//31 Centaur harness clothes
		case 31:
			outputText("You rear back, and declare that, \"<i>This horse is ready to ride, all night long!</i>\"", false);
			chance += 2;
			damage += 4;
			break;
		//32 Genderless servant clothes
		case 32:
			outputText("You turn your back to your foe, and flip up your butt flap for a moment.   Your " + buttDescript() + " really is, all you have to offer downstairs.", false);
			ass = true;
			chance++;
			damage += 2;
			break;
		//33 Crotch Revealing Clothes (herm only?)
		case 33:
			outputText("You do a series of poses to accentuate what you've got on display with your crotch revealing clothes, while asking if your " + player.mf("master","mistress") + " is looking to sample what is on display.", false);
			chance += 2;
			damage += 4;
			break;
		//34 Maid Costume (female only)
		case 34:
			outputText("You give a rather explicit curtsey towards " + monster.a + monster.short + " and ask them if your " + player.mf("master","mistress") + " is interested in other services today.", false);
			chance ++;
			damage += 2;
			breasts = true;
			break;
		//35 Servant Boy Clothes (male only)
		case 35:
			outputText("You brush aside your crotch flap for a moment, then ask " + monster.a + monster.short + " if, " + player.mf("Master","Mistress") + " would like you to use your " + multiCockDescriptLight() + " on them?", false);
			penis = true;
			chance++;
			damage += 2;
			break;
		//36 Bondage Patient Clothes (done):
		case 36:
			outputText("You pull back one of the straps on your bondage cloths and let it snap back.  \"<i>I need some medical care, feeling up for it?</i>\" you tease.", false);
			damage+= 2;
			chance++;
			break;
		default:
			outputText("You shimmy and shake sensually. (An error occurred.)", false);
			break;
		case 37:
			outputText("You purse your lips coyly, narrowing your eyes mischievously and beckoning to " + monster.a + monster.short + " with a burning come-hither glare.  Sauntering forward, you pop your hip to the side and strike a coquettish pose, running " + ((player.tailVenom > 1) ? "one of your tails" : "your tail") + " up and down " + monster.pronoun3 + " body sensually.");
			chance+= 6;
			damage+= 3;
			break;
		case 38:
			outputText( "You wet your lips, narrowing your eyes into a smoldering, hungry gaze.  Licking the tip of your index finger, you trail it slowly and sensually down the front of your " + player.armorName + ", following the line of your " + chestDesc() + " teasingly.  You hook your thumbs into your top and shimmy it downward at an agonizingly slow pace.  The very instant that your [nipples] pop free, your tail crosses in front, obscuring " + monster.a + monster.short + "'s view.");
			breasts = true;
			chance++;
			damage++;
			break;
		case 39:
			outputText( "Leaning forward, you bow down low, raising a hand up to your lips and blowing " + monster.a + monster.short + " a kiss.  You stand straight, wiggling your " + hipDescript() + " back and forth seductively while trailing your fingers down your front slowly, pouting demurely.  The tip of ");
			if(player.tailVenom == 1) outputText("your");
			else outputText("a");
			outputText(" bushy tail curls up around your " + player.leg() + ", uncoiling with a whipping motion that makes an audible crack in the air.");
			ass = true;
			chance++;
			damage += 1;
			break;
		case 40:
			outputText("Turning around, you stare demurely over your shoulder at " + monster.a + monster.short + ", batting your eyelashes amorously.");
			if(player.tailVenom == 1) outputText("  Your tail twists and whips about, sliding around your " + hipDescript() + " in a slow arc and framing your rear nicely as you slowly lift your " + player.armorName + ".");
			else outputText("  Your tails fan out, twisting and whipping sensually, sliding up and down your " + player.legs() + " and framing your rear nicely as you slowly lift your " + player.armorName + ".");
			outputText("  As your [butt] comes into view, you brush your tail" + ((player.tailVenom > 1) ? "s" : "" ) + " across it, partially obscuring the view in a tantalizingly teasing display.");
			ass = true;
			anus = true;
			chance++;
			damage += 2;
			break;
		case 41:
			outputText( "Smirking coyly, you sway from side to side, running your tongue along your upper teeth seductively.  You hook your thumbs into your " + player.armorName + " and pull them away to partially reveal ");
			if(player.cockTotal() > 0) outputText(sMultiCockDesc());
			if(player.gender == 3) outputText(" and ");
			if(player.gender >= 2) outputText("your " + vaginaDescript(0));
			outputText(".  Your bushy tail" + ((player.tailVenom > 1) ? "s" : "" ) + " cross" + ((player.tailVenom > 1) ? "": "es") + " in front, wrapping around your genitals and obscuring the view teasingly.");
			vagina = true;
			penis = true;
			damage += 2;
			chance++;
			break;
		case 42:
			//Tease #1:
			if(rand(2) == 0) {
				outputText("You lift your skirt and flash your king-sized stallionhood, already unsheathing itself and drooling pre, at your opponent.  \"<i>Come on, then; I got plenty of girlcock for you if that's what you want!</i>\" you cry.");
				penis = true;
				damage += 3;
				chance--;
			}
			//Tease #2:
			else {
				outputText("You turn partially around and then bend over, swaying your tail from side to side in your most flirtatious manner and wiggling your hips seductively, your skirt fluttering with the motions.  \"<i>Come on then, what are you waiting for?  This is a fine piece of ass here,</i>\" you grin, spanking yourself with an audible slap.");
				ass = true;
				chance+= 2;
				damage += 3;
			}
			break;
		case 43:
			var cows:int = rand(7);
			if(cows == 0) {
				outputText("You tuck your hands under your chin and use your arms to squeeze your massive, heavy breasts together.  Milk squirts from your erect nipples, filling the air with a rich, sweet scent.");
				breasts = true;
				chance += 2;
				damage++;
			}
			else if(cows == 1) {
				outputText("Moaning, you bend forward, your full breasts nearly touching the ground as you sway your [hips] from side to side.  Looking up from under heavily-lidded eyes, you part your lips and lick them, letting out a low, lustful \"<i>Mooooo...</i>\"");
				breasts = true;
				chance += 2;
				damage += 2;
			}
			else if(cows == 2) {
				outputText("You tuck a finger to your lips, blinking innocently, then flick your tail, wafting the scent of your ");
				if(player.wetness() >= 3) outputText("dripping ");
				outputText("sex through the air.");
				vagina = true;
				chance++;
				damage++;
			}
			else if(cows == 3) {
				outputText("You heft your breasts, fingers splayed across your [nipples] as you SQUEEZE.  Milk runs in rivulets over your hands and down the massive curves of your breasts, soaking your front with sweet, sticky milk.");
				breasts = true;
				chance += 3;
				damage++;
			}
			else if(cows == 4) {
				outputText("You lift a massive breast to your mouth, suckling loudly at yourself, finally letting go of your nipple with a POP and a loud, satisfied gasp, milk running down your chin.");
				breasts = true;
				chance++;
				damage += 3;
			}
			else if(cows == 5) {
				outputText("You crouch low, letting your breasts dangle in front of you.  Each hand caresses on in turn as you slowly milk yourself onto your thighs, splashing white, creamy milk over your hips and sex.");
				vagina = true;
				breasts = true;
				chance++;
			}
			else {
				outputText("You lift a breast to your mouth, taking a deep draught of your own milk, then tilt your head back.  With a low moan, you let it run down your front, winding a path between your breasts until it drips sweetly from your crotch.");
				vagina = true;
				breasts = true;
				damage += 2;
			}
			if(monster.short.indexOf("minotaur") != -1) {
				damage += 6;
				chance += 3;
			}
			break;
		//lusty maiden's armor teases
		case 44:
			var maiden:int = rand(5);
			damage += 5;
			chance += 3;
			if(maiden == 0) {
				outputText("Confidently sauntering forward, you thrust your chest out with your back arched in order to enhance your [chest].  You slowly begin to shake your torso back and forth, slapping your chain-clad breasts against each other again and again.  One of your hands finds its way to one of the pillowy expanses and grabs hold, fingers sinking into the soft tit through the fine, mail covering.  You stop your shaking to trace a finger down through the exposed center of your cleavage, asking, \"<i>Don't you just want to snuggle inside?</i>\"");
				breasts = true;
			}
			else if(maiden == 1) {
				outputText("You skip up to " + monster.a + monster.short + " and spin around to rub your barely-covered butt up against " + monster.pronoun2 + ".  Before " + monster.pronoun1 + " can react, you're slowly bouncing your [butt] up and down against " + monster.pronoun3 + " groin.  When " + monster.pronoun1 + " reaches down, you grab " + monster.pronoun3 + " hand and press it up, under your skirt, right against the steamy seal on your sex.  The simmering heat of your overwhelming lust burns hot enough for " + monster.pronoun2 + " to feel even through the contoured leather, and you let " + monster.pronoun2 + " trace the inside of your [leg] for a moment before moving away, laughing playfully.");
				ass = true;
				vagina = true;
			}
			else if(maiden == 2) {
				outputText("You flip up the barely-modest chain you call a skirt and expose your g-string to " +  monster.a + monster.short + ".  Slowly swaying your [hips], you press a finger down on the creased crotch plate and exaggerate a lascivious moan into a throaty purr of enticing, sexual bliss.  Your eyes meet " + monster.pronoun3 + ", and you throatily whisper, \"<i>");
				if(player.hasVirginVagina()) outputText("Think you can handle a virgin's infinite lust?");
				else outputText("Think you have what it takes to satisfy this perfect pussy?");
				outputText("</i>\"");
				vagina = true;
				damage += 3;
			}
			else if(maiden == 3) {
				outputText("You seductively wiggle your way up to " + monster.a + monster.short + ", and before " + monster.pronoun1 + " can react to your salacious advance, you snap a [leg] up in what would be a vicious kick, if you weren't simply raising it to rest your [foot] on " + monster.pronoun3 + " shoulder.  With your thighs so perfectly spready, your skirt is lifted, and " + monster.a + monster.short + " is given a perfect view of your thong-enhanced cameltoe and the moisture that beads at the edges of your not-so-modest covering.");
				vagina = true;
			}
			else {
				outputText("Bending over, you lift your [butt] high in the air.  Most of your barely-covered tush is exposed, but the hem of your chainmail skirt still protects some of your anal modesty.  That doesn't last long.  You start shaking your [butt] up, down, back, and forth to an unheard rhythm, flipping the pointless covering out of the way so that " + monster.a + monster.short + " can gaze upon your curvy behind in it all its splendid detail.  A part of you hopes that " + monster.pronoun1 + " takes in the intricate filigree on the back of your thong, though to " + monster.pronoun2 + " it looks like a bunch of glittering arrows on an alabaster background, all pointing squarely at your [asshole].");
				ass = true;
				chance += 2;
			}
			break;
	}
	//===========================
	//BUILD BONUSES IF APPLICABLE
	//===========================	
	var bonusChance:Number = 0;
	var bonusDamage:Number = 0;
	if(auto) {
		//TIT BONUSES
		if(breasts) {
			if(player.bRows() > 1) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.bRows() > 2) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.bRows() > 4) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.biggestLactation() >= 2) {
				bonusChance++;
				bonusDamage += 2;
			}
			if(player.biggestLactation() >= 3) {
				bonusChance++;
				bonusDamage += 2;
			}
			if(player.biggestTitSize() >= 4) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.biggestTitSize() >= 7) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.biggestTitSize() >= 12) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.biggestTitSize() >= 25) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.biggestTitSize() >= 50) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.hasFuckableNipples()) {
				bonusChance++;
				bonusDamage += 2;
			}
			if(player.averageNipplesPerBreast() > 1) {
				bonusChance++;
				bonusDamage += 2;
			}
		}
		//PUSSY BONUSES
		if(vagina) {
			if(player.hasVagina() && player.wetness() >= 2) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.hasVagina() && player.wetness() >= 3) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.hasVagina() && player.wetness() >= 4) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.hasVagina() && player.wetness() >= 5) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.clitLength > 1.5) {
				bonusChance += .5;
				bonusDamage++;
			}
			if(player.clitLength > 3.5) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.clitLength > 7) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.clitLength > 12) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.vaginalCapacity() >= 30) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.vaginalCapacity() >= 70) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.vaginalCapacity() >= 120) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.vaginalCapacity() >= 200) {
				bonusChance += .5;
				bonusDamage += 1;
			}
		}
		//Penis bonuses!
		if(penis) {
			if(player.cockTotal() > 1) {
				bonusChance += 1;
				bonusDamage += 2;
			}
			if(player.biggestCockArea() >= 15) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.biggestCockArea() >= 30) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.biggestCockArea() >= 60) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.biggestCockArea() >= 120) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.cumQ() >= 50) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.cumQ() >= 150) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.cumQ() >= 300) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.cumQ() >= 1000) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(balls > 0) {
				if(player.balls > 2) {
					bonusChance += 1;
					bonusDamage += 2;
				}
				if(player.ballSize > 3) {
					bonusChance += .5;
					bonusDamage += 1;
				}
				if(player.ballSize > 7) {
					bonusChance += .5;
					bonusDamage += 1;
				}
				if(player.ballSize > 12) {
					bonusChance += .5;
					bonusDamage += 1;
				}
			}
			if(player.biggestCockArea() < 8) {
				bonusChance--;
				bonusDamage-=2;
				if(player.biggestCockArea() < 5) {
					bonusChance--;
					bonusDamage-=2;
				}
			}
		}
		if(ass) {
			if(player.buttRating >= 6) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.buttRating >= 10) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.buttRating >= 13) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.buttRating >= 16) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.buttRating >= 20) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.hipRating >= 6) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.hipRating >= 10) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.hipRating >= 13) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.hipRating >= 16) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.hipRating >= 20) {
				bonusChance += .5;
				bonusDamage += 1;
			}
		}
		if(anus) {
			if(player.ass.analLooseness == 0) {
				bonusChance += 1.5;
				bonusDamage += 3;
			}
			if(player.ass.analWetness > 0) {
				bonusChance += 1;
				bonusDamage += 2;
			}
			if(player.analCapacity() >= 30) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.analCapacity() >= 70) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.analCapacity() >= 120) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.analCapacity() >= 200) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.ass.analLooseness == 4) {
				bonusChance += .5;
				bonusDamage += 1;
			}
			if(player.ass.analLooseness == 5) {
				bonusChance += 1.5;
				bonusDamage += 3;
			}
		}
		//Trim it down!
		if(bonusChance > 5) bonusChance = 5;
		if(bonusDamage > 10) bonusDamage = 10;
	}
	//Land the hit!
	if(rand(100) <= chance + rand(bonusChance)) {
		//NERF TEASE DAMAGE
		damage *= .7;
		bonusDamage *= .7;
		if(player.hasPerk("History: Whore") >= 0) {
			damage *= 1.15;
			bonusDamage *= 1.15;
		}
		if(monster.plural) damage *= 1.3;
		enemyTeaseReaction(damage + rand(bonusDamage));
		if(flags[PC_FETISH] >= 1) {
			if(player.lust < 75) outputText("\nFlaunting your body in such a way gets you a little hot and bothered.", false);
			else outputText("\nIf you keep exposing yourself you're going to get too horny to fight back.  This exhibitionism fetish makes it hard to resist just stripping naked and giving up.", false);
			stats(0,0,0,0,0,0,2 + rand(3),0);
		}
		teaseXP(1);
	}
	//Nuttin honey
	else {
		teaseXP(5);
		outputText("\n" + monster.capitalA + monster.short + " seems unimpressed.", false);
	}
	outputText("\n\n", false);
}

function teaseXP(XP:Number = 0):void {
	while(XP > 0) {
		XP--;
		player.teaseXP++;
		//Level dat shit up!
		if(player.teaseLevel < 5 && player.teaseXP >= 10 + (player.teaseLevel + 1) * 5 * (player.teaseLevel + 1)) {
			outputText("\n<b>Tease skill leveled up to " + (player.teaseLevel + 1) + "!</b>", false);
			player.teaseLevel++;
			player.teaseXP = 0;
		}
	}
}



//VICTORY OR DEATH?
function combatRoundOver():Boolean {
	statScreenRefresh();
	player.weaponAttack = fixedDamage(player.weaponName);
	applyArmorStats(player.armorName, false);
	if(gameState < 1) return false;
	if(monster.HP < 1) {
		doNext(5008);
		return true;
	}
	if(monster.lust > 99) {
		doNext(5009);
		return true;
	}
	if(monster.hasStatusAffect("level") >= 0) {
		if(trapLevel() <= 1) {
			sandtrapmentLoss();
			return true;
		}
	}
	if(monster.short == "basilisk" && player.spe <= 1) {
		doNext(5010);
		return true;
	}
	if(player.HP < 1) {
		doNext(5010);
		return true;
	}
	if(player.lust > 99) {
		doNext(5011);
		return true;
	}
	doNext(1);
	return false;
}
function hasSpells():Boolean {
	if(player.hasStatusAffect("Knows Arouse") >= 0) return true;
	if(player.hasStatusAffect("Knows Heal") >= 0) return true;
	if(player.hasStatusAffect("Knows Might") >= 0) return true;
	if(player.hasStatusAffect("Knows Charge") >= 0) return true;
	if(player.hasStatusAffect("Knows Blind") >= 0) return true;
	if(player.hasStatusAffect("Knows Whitefire") >= 0) return true;
	return false;
}
function spellCount():Number {
	var count:Number = 0;
	if(player.hasStatusAffect("Knows Arouse") >= 0) count++;
	if(player.hasStatusAffect("Knows Heal") >= 0) count++;
	if(player.hasStatusAffect("Knows Might") >= 0) count++;
	if(player.hasStatusAffect("Knows Charge") >= 0) count++;
	if(player.hasStatusAffect("Knows Blind") >= 0) count++;
	if(player.hasStatusAffect("Knows Whitefire") >= 0) count++;
	return count;
}
function magicMenu():void {
	menuLoc = 3;
	var arouseEvent:Number = 0;
	var healEvent:Number = 0;
	var mightEvent:Number = 0;
	var chargeEvent:Number = 0;
	var blindEvent:Number = 0;
	var whitefireEvent:Number = 0;
	if(inCombat() && player.hasStatusAffect("Sealed") >= 0 && player.statusAffectv2("Sealed") == 2) {
		clearOutput();
		outputText("You reach for your magic, but you just can't manage the focus necessary.  <b>Your ability to use magic was sealed, and now you've wasted a chance to attack!</b>\n\n");
		enemyAI();
		return;
	}
	outputText("What spell will you use?\n\n", true);
	//WHITE SHITZ
	if(player.lust >= 75) outputText("You are far too aroused to focus on white magic.\n\n", false);
	else {
		if(player.hasStatusAffect("Knows Charge") >= 0) {
			if(player.hasStatusAffect("Charge Weapon") < 0) chargeEvent = 5083;
			else outputText("<b>Charge weapon is already active and cannot be cast again.</b>\n\n", false);
		}
		if(player.hasStatusAffect("Knows Blind") >= 0) {
			if(monster.hasStatusAffect("Blind") < 0) blindEvent = 5084;
			else outputText("<b>" + monster.capitalA + monster.short + " is already affected by blind.</b>\n\n", false);
		}
		if(player.hasStatusAffect("Knows Whitefire") >= 0) whitefireEvent = 5085;
	}
	//BLACK MAGICSKS
	if(player.lust < 50) outputText("You aren't turned on enough to use any black magics.\n\n", false);
	else {
		if(player.hasStatusAffect("Knows Arouse") >= 0) arouseEvent = 5080;
		if(player.hasStatusAffect("Knows Heal") >= 0) healEvent = 5081;
		if(player.hasStatusAffect("Knows Might") >= 0) {
			if(player.hasStatusAffect("Might") < 0) mightEvent = 5082;		
			else outputText("<b>You are already under the effects of Might and cannot cast it again.</b>\n\n", false);
		}
	}
	choices("Charge W.",chargeEvent,"Blind",blindEvent,"Whitefire",whitefireEvent,"",0,"",0,"Arouse",arouseEvent,"Heal",healEvent,"Might",mightEvent,"",0,"Back",5000);
}
function spellMod():Number {
	var mod:Number = 1;
	if(player.hasPerk("Archmage") >= 0 && player.inte >= 75) mod += .5;
	if(player.hasPerk("Channeling") >= 0 && player.inte >= 60) mod += .5;
	if(player.hasPerk("Mage") >= 0 && player.inte >= 50) mod += .5;
	if(player.hasPerk("Spellpower") >= 0 && player.inte >= 50) mod += .5;
	if(player.hasPerk("Wizard's Focus") >= 0) {
		if(player.perkv1("Wizard's Focus") is Number) mod += player.perkv1("Wizard's Focus");
	}
	return mod;
}
function spellArouse():void {
	if(player.hasPerk("Blood Mage") < 0 && player.fatigue + spellCost(15) > 100) {
		outputText("You are too tired to cast this spell.", true);
		doNext(5002);
		return;
	}
	menuLoc = 0;
	fatigue(15,1);
	statScreenRefresh();
	if(monster.hasStatusAffect("Shell") >= 0) {
		outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
		flags[SPELLS_CAST]++;
		spellPerkUnlock();
		enemyAI();
		return;
	}
	outputText("You make a series of arcane gestures, drawing on your own lust to inflict it upon your foe!\n", true);
	//Worms be immune
	if(monster.short == "worms") {
		outputText("The worms appear to be unaffected by your magic!", false);
		outputText("\n\n", false);
		flags[SPELLS_CAST]++;
		spellPerkUnlock();
		doNext(1);
		if(monster.lust >= 100) doNext(5009);
		else enemyAI();
		return;
	}
	if(monster.lustVuln == 0) {
		outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n", false);
		flags[SPELLS_CAST]++;
		spellPerkUnlock();
		enemyAI();
		return;
	}
	monster.lust += monster.lustVuln * (player.inte/5*spellMod() + rand(monster.lib - monster.inte*2 + monster.cor)/5);
	if(monster.lust < 30) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ", false);
	if(monster.lust >= 30 && monster.lust < 60) {
		if(monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ", false);
		else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ", false);
	}
	if(monster.lust >= 60) {
		outputText(monster.capitalA + monster.short + "'");
		if(!monster.plural) outputText("s");
		outputText(" eyes glaze over with desire for a moment.  ", false);
	}
	if(monster.cocks.length > 0) {
		if(monster.lust >= 60 && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + eMultiCockDescriptLight() + " dribble pre-cum.  ", false);
		if(monster.lust >= 30 && monster.lust < 60 && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + eCockDescript(0) + " hardens, distracting " + monster.pronoun2 + " further.  ", false);
		if(monster.lust >= 30 && monster.lust < 60 && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + eMultiCockDescriptLight() + " harden uncomfortably.  ", false);
	}
	if(monster.vaginas.length > 0) {
		if(monster.plural) {
			if(monster.lust >= 60 && monster.vaginas[0].vaginalWetness == 1) outputText(monster.capitalA + monster.short + "'s " + eVaginaDescript(0) + "s dampen perceptibly.  ", false);
			if(monster.lust >= 60 && monster.vaginas[0].vaginalWetness == 2) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ", false);
			if(monster.lust >= 60 && monster.vaginas[0].vaginalWetness == 3) outputText(monster.capitalA + monster.short + "'s " + eVaginaDescript(0) + "s become sloppy and wet.  ", false);
			if(monster.lust >= 60 && monster.vaginas[0].vaginalWetness == 4) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ", false);
			if(monster.lust >= 60 && monster.vaginas[0].vaginalWetness == 5) outputText(monster.capitalA + monster.short + "'s " + eVaginaDescript(0) + "s instantly soak " + monster.pronoun2 + " groin.  ", false);
		}
		else {
			if(monster.lust >= 60 && monster.vaginas[0].vaginalWetness == 1) outputText(monster.capitalA + monster.short + "'s " + eVaginaDescript(0) + " dampens perceptibly.  ", false);
			if(monster.lust >= 60 && monster.vaginas[0].vaginalWetness == 2) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ", false);
			if(monster.lust >= 60 && monster.vaginas[0].vaginalWetness == 3) outputText(monster.capitalA + monster.short + "'s " + eVaginaDescript(0) + " becomes sloppy and wet.  ", false);
			if(monster.lust >= 60 && monster.vaginas[0].vaginalWetness == 4) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ", false);
			if(monster.lust >= 60 && monster.vaginas[0].vaginalWetness == 5) outputText(monster.capitalA + monster.short + "'s " + eVaginaDescript(0) + " instantly soaks her groin.  ", false);
		}
	}
	outputText("\n\n", false);
	doNext(1);
	flags[SPELLS_CAST]++;
	spellPerkUnlock();
	if(monster.lust >= 100) doNext(5009);
	else enemyAI();
	return;	
}
function spellHeal():void {
	if(player.hasPerk("Blood Mage") < 0 && player.fatigue + spellCost(20) > 100) {
		outputText("You are too tired to cast this spell.", true);
		doNext(5002);
		return;
	}
	menuLoc = 0;
	fatigue(20,1);
	outputText("You focus on your body and its desire to end pain, trying to draw on your arousal without enhancing it.\n", true);
	//25% backfire!
	if(rand(4) == 0) {
		outputText("An errant sexual thought crosses your mind, and you lose control of the spell!  Your ", false);
		if(player.gender == 0) outputText(assholeDescript() + " tingles with a desire to be filled as your libido spins out of control.", false);
		if(player.gender == 1) {
			if(player.cockTotal() == 1) outputText(cockDescript(0) + " twitches obscenely and drips with pre-cum as your libido spins out of control.", false);
			else outputText(multiCockDescriptLight() + " twitch obscenely and drip with pre-cum as your libido spins out of control.", false);
		}
		if(player.gender == 2) outputText(vaginaDescript(0) + " becomes puffy, hot, and ready to be touched as the magic diverts into it.", false);
		if(player.gender == 3) outputText(vaginaDescript(0) + " and " + multiCockDescriptLight() + " overfill with blood, becoming puffy and incredibly sensitive as the magic focuses on them.", false);
		stats(0,0,0,0,.25,0,15,0);
	}
	else {
		temp = int((player.inte/(2 + rand(3)) * spellMod()) * (maxHP()/150));
		if(player.armorName == "skimpy nurse's outfit") temp *= 1.2;
		outputText("You flush with success as your wounds begin to knit (+" + temp + ").", false);
		HPChange(temp,false);
	}
	outputText("\n\n", false);
	statScreenRefresh();
	flags[SPELLS_CAST]++;
	spellPerkUnlock();
	if(player.lust >= 100) doNext(5011);
	else enemyAI();
	return;
}

//(25) Might – increases strength/toughness by 5 * spellMod, up to a 
//maximum of 15, allows it to exceed the maximum.  Chance of backfiring 
//and increasing lust by 15.
function spellMight():void {
	if(player.hasPerk("Blood Mage") < 0 && player.fatigue + spellCost(25) > 100) {
		outputText("You are too tired to cast this spell.", true);
		doNext(5002);
		return;
	}
	menuLoc = 0;
	fatigue(25,1);
	var tempStr:Number = 0;
	var tempTou:Number = 0;
	outputText("You flush, drawing on your body's desires to empower your muscles and toughen you up.\n\n", true);
	//25% backfire!
	if(rand(4) == 0) {
		outputText("An errant sexual thought crosses your mind, and you lose control of the spell!  Your ", false);
		if(player.gender == 0) outputText(assholeDescript() + " tingles with a desire to be filled as your libido spins out of control.", false);
		if(player.gender == 1) {
			if(player.cockTotal() == 1) outputText(cockDescript(0) + " twitches obscenely and drips with pre-cum as your libido spins out of control.", false);
			else outputText(multiCockDescriptLight() + " twitch obscenely and drip with pre-cum as your libido spins out of control.", false);
		}
		if(player.gender == 2) outputText(vaginaDescript(0) + " becomes puffy, hot, and ready to be touched as the magic diverts into it.", false);
		if(player.gender == 3) outputText(vaginaDescript(0) + " and " + multiCockDescriptLight() + " overfill with blood, becoming puffy and incredibly sensitive as the magic focuses on them.", false);
		stats(0,0,0,0,.25,0,15,0);
	}
	else {
		outputText("The rush of success and power flows through your body.  You feel like you can do anything!", false);
		player.createStatusAffect("Might",0,0,0,0);
		temp = 5 * spellMod();
		tempStr = temp;
		tempTou = temp;
		if(player.str + temp > 100) tempStr = 100 - player.str;
		if(player.tou + temp > 100) tempTou = 100 - player.tou;
		player.changeStatusValue("Might",1,tempStr);
		player.changeStatusValue("Might",2,tempTou);
		if(player.str < 100) {
			strUp.visible = true;
			strDown.visible = false;
			touUp.visible = true;
			touDown.visible = false;
		}
		player.str += player.statusAffectv1("Might");
		player.tou += player.statusAffectv2("Might");
	}
	outputText("\n\n", false);
	statScreenRefresh();
	flags[SPELLS_CAST]++;
	spellPerkUnlock();
	if(player.lust >= 100) doNext(5011);
	else enemyAI();
	return;
}

//(15) Charge Weapon – boosts your weapon attack value by 10 * SpellMod till the end of combat.
function spellChargeWeapon():void {
	if(player.hasPerk("Blood Mage") < 0 && player.fatigue + spellCost(15) > 100) {
		outputText("You are too tired to cast this spell.", true);
		doNext(5002);
		return;
	}
	menuLoc = 0;
	fatigue(15,1);
	outputText("You utter words of power, summoning an electrical charge around your " + player.weaponName + ".  It crackles loudly, ensuring you'll do more damage with it for the rest of the fight.\n\n", true);
	player.createStatusAffect("Charge Weapon",10*spellMod(),0,0,0);
	player.weaponAttack += player.statusAffectv1("Charge Weapon");
	statScreenRefresh();
	flags[SPELLS_CAST]++;
	spellPerkUnlock();
	enemyAI();
}
//(20) Blind – reduces your opponent's accuracy, giving an additional 50% miss chance to physical attacks.
function spellBlind():void {
	outputText("", true);
	if(player.hasPerk("Blood Mage") < 0 && player.fatigue + spellCost(20) > 100) {
		outputText("You are too tired to cast this spell.", true);
		doNext(5002);
		return;
	}
	menuLoc = 0;
	fatigue(20,1);
	if(monster.hasStatusAffect("Shell") >= 0) {
		outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
		flags[SPELLS_CAST]++;
		spellPerkUnlock();
		enemyAI();
		return;
	}
	outputText("You glare at " + monster.a + monster.short + " and point at " + monster.pronoun2 + ".  A bright flash erupts before " + monster.pronoun2 + "!\n", true);
	if(rand(3) != 0) {
		outputText(" <b>" + monster.capitalA + monster.short + " ", false);
		if(monster.plural && monster.short != "imp horde") outputText("are blinded!</b>", false);
		else outputText("is blinded!</b>", false);
		monster.createStatusAffect("Blind",5*spellMod(),0,0,0);
		if(monster.short == "Isabella") outputText("\n\n\"<i>Nein! I cannot see!</i>\" cries Isabella.", false);
		if(monster.short == "Kiha") outputText("\n\n\"<i>You think blindness will slow me down?  Attacks like that are only effective on those who don't know how to see with their other senses!</i>\" Kiha cries defiantly.", false);
		if(monster.short == "plain girl") {
			outputText("  Remarkably, it seems as if your spell has had no effect on her, and you nearly get clipped by a roundhouse as you stand, confused. The girl flashes a radiant smile at you, and the battle continues.", false);
			monster.removeStatusAffect("Blind");
		}
	}
	else outputText(monster.capitalA + monster.short + " blinked!", false);	
	outputText("\n\n", false);
	flags[SPELLS_CAST]++;
	spellPerkUnlock();
	statScreenRefresh();
	enemyAI();
}
//(30) Whitefire – burns the enemy for int/5 * spellMod + rand(int/2*spellMod).
function spellWhitefire():void {
	outputText("", true);
	if(player.hasPerk("Blood Mage") < 0 && player.fatigue + spellCost(30) > 100) {
		outputText("You are too tired to cast this spell.", true);
		doNext(5002);
		return;
	}
	menuLoc = 0;
	fatigue(30,1);
	if(monster.hasStatusAffect("Shell") >= 0) {
		outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
		flags[SPELLS_CAST]++;
		spellPerkUnlock();
		enemyAI();
		return;
	}
	outputText("You narrow your eyes, focusing your mind with deadly intent.  You snap your fingers and " + monster.a + monster.short + " is enveloped in a flash of white flames!\n", true);
	temp = int(10+(player.inte/3 + rand(player.inte/2)) * spellMod());
	//High damage to goes.
	if(monster.short == "goo-girl") temp = Math.round(temp * 1.5);
	outputText(monster.capitalA + monster.short + " takes " + temp + " damage.", false);
	//Using fire attacks on the goo]
	if(monster.short == "goo-girl") {
		outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.", false);
		if(monster.hasPerk("Acid") < 0) monster.createPerk("Acid",0,0,0,0);
	}
	outputText("\n\n", false);
	flags[SPELLS_CAST]++;
	spellPerkUnlock();
	monster.HP -= temp;
	statScreenRefresh();
	if(monster.HP < 1) doNext(5008);
	else enemyAI();
}

function spellPerkUnlock():void {
	if(flags[SPELLS_CAST] >= 5 && player.hasPerk("Spellcasting Affinity") < 0) {
		outputText("<b>You've become more comfortable with your spells, unlocking the Spellcasting Affinity perk and reducing fatigue cost of spells by 20%!</b>\n\n");
		player.createPerk("Spellcasting Affinity",20,0,0,0);
	}
	if(flags[SPELLS_CAST] >= 15 && player.perkv1("Spellcasting Affinity") < 35) {
		outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 15%!</b>\n\n");
		player.changePerkValue("Spellcasting Affinity",1,35);
	}
	if(flags[SPELLS_CAST] >= 45 && player.perkv1("Spellcasting Affinity") < 50) {
		outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 15%!</b>\n\n");
		player.changePerkValue("Spellcasting Affinity",1,50);
	}
}


//player gains hellfire perk.  
//Hellfire deals physical damage to completely pure foes, 
//lust damage to completely corrupt foes, and a mix for those in between.  Its power is based on the PC's corruption and level.  Appearance is slightly changed to mention that the PC's eyes and mouth occasionally show flicks of fire from within them, text could possibly vary based on corruption.
function hellFire():void {
	outputText("", true);
	if(player.fatigue + 20 > 100) {
		outputText("You are too tired to breathe fire.\n", true);
		doNext(5000);
		return;
	}
	menuLoc = 0;
	changeFatigue(20);
	//Amily!
	if(monster.hasStatusAffect("Concentration") >= 0) {
		outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n", true);
		enemyAI();
		return;
	}
	var damage:Number = 0;
	damage = (player.level * 8 + rand(10) + player.cor/5);
	if(player.hasStatusAffect("GooArmorSilence") < 0) outputText("You take in a deep breath and unleash a wave of corrupt red flames from deep within.", false);
	
	if(player.hasStatusAffect("Web-Silence") >= 0) {
		outputText("  <b>The fire burns through the webs blocking your mouth!</b>", false);
		player.removeStatusAffect("Web-Silence");
	}
	if(player.hasStatusAffect("GooArmorSilence") >= 0) {
		outputText("  <b>A growl rumbles from deep within as you charge the terrestrial fire, and you force it from your chest and into the slime.  The goop bubbles and steams as it evaporates, drawing a curious look from your foe, who pauses in her onslaught to lean in and watch.  While the tension around your mouth lessens and your opponent forgets herself more and more, you bide your time.  When you can finally work your jaw enough to open your mouth, you expel the lion's - or jaguar's? share of the flame, inflating an enormous bubble of fire and evaporated slime that thins and finally pops to release a superheated cloud.  The armored girl screams and recoils as she's enveloped, flailing her arms.</b>", false);
		player.removeStatusAffect("GooArmorSilence");
		damage += 25;
	}
	if(monster.short == "Isabella") {
		outputText("  Isabella shoulders her shield into the path of the crimson flames.  They burst over the wall of steel, splitting around the impenetrable obstruction and washing out harmlessly to sides.\n\n", false);
		outputText("\"<i>Is zat all you've got?  It'll take more than a flashy magic trick to beat Izabella!</i>\" taunts the cow-girl.\n\n", false);
		enemyAI();
		return;
	}
	else if(monster.short == "Vala") {
		outputText("  Vala beats her wings with surprising strength, blowing the fireball back at you!  ", false);		
		if(player.hasPerk("Evade") >= 0 && rand(2) == 0) {
			outputText("You dive out of the way and evade it!", false);
		}
		else if(player.hasPerk("Flexibility") >= 0 && rand(4) == 0) {
			outputText("You use your flexibility to barely fold your body out of the way!", false);
		}
		else {
			damage = int(damage / 6);
			outputText("Your own fire smacks into your face, arousing you!", false);
			stats(0,0,0,0,0,0,damage,0);
		}
		outputText("\n", false);
	}
	else {
		if(monster.inte < 10) {
			outputText("  Your foe lets out a shriek as their form is engulfed in the blistering flames.", false);
			damage = int(damage);
			outputText("(" + damage + ")\n", false);
			monster.HP -= damage;
		}
		else {
			if(monster.lustVuln > 0) {
				outputText("  Your foe cries out in surprise and then gives a sensual moan as the flames of your passion surround them and fill their body with unnatural lust.\n", false);
				monster.lust += monster.lustVuln * damage/6;
			}
			else {
				outputText("  The corrupted fire doesn't seem to have affect on " + monster.a + monster.short + "!\n", false);
			}
		}
	}
	outputText("\n", false);
	if(monster.short == "Holli" && monster.hasStatusAffect("Holli Burning") < 0) lightHolliOnFireMagically();
	if(monster.HP < 1) {
		doNext(5008);
		return;
	}
	else if(monster.lust >= 99) {
		doNext(5009);
		return;
	}
	else enemyAI();
}

function kick():void {
	outputText("", true);
	if(player.fatigue + physicalCost(15) > 100) {
		outputText("You're too fatigued to use a charge attack!", true);
		doNext(5000);
		return;
	}
	fatigue(15,2);
	//Variant start messages!
	if(player.lowerBody == 14) {
		//(tail)
		if(player.tailType == 12) outputText("You balance on your flexible kangaroo-tail, pulling both legs up before slamming them forward simultaneously in a brutal kick.  ", false);
		//(no tail) 
		else outputText("You balance on one leg and cock your powerful, kangaroo-like leg before you slam it forward in a kick.  ", false);
	}
	//(bunbun kick) 
	else if(player.lowerBody == 12) outputText("You leap straight into the air and lash out with both your furred feet simultaneously, slamming forward in a strong kick.  ", false);
	//(centaur kick)
	else if(player.lowerBody == 4) outputText("You lurch up onto your backlegs, lifting your forelegs from the ground a split-second before you lash them out in a vicious kick.  ", false);
	//(bipedal hoof-kick) 
	else if(player.lowerBody == 1) outputText("You twist and lurch as you raise a leg and slam your hoof forward in a kick.  ", false);

	if(flags[PC_FETISH] >= 3) {
		outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  Ceraph's piercings have made normal attack impossible!  Maybe you could try something else?\n\n", false);
		enemyAI();
		return;
	}
	//Amily!
	if(monster.hasStatusAffect("Concentration") >= 0) {
		outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n", true);
		enemyAI();
		return;
	}
	//Blind
	if(player.hasStatusAffect("Blind") >= 0) {
		outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ", false);
	}
	//Worms are special
	if(monster.short == "worms") {
		//50% chance of hit (int boost)
		if(rand(100) + player.inte/3 >= 50) {
			temp = int(player.str/5 - rand(5));
			if(temp == 0) temp = 1;
			outputText("You strike at the amalgamation, crushing countless worms into goo, dealing " + temp + " damage.\n\n", false);
			monster.HP -= temp;
			if(monster.HP <= 0) {
				doNext(5008);
				return;
			}
		}
		//Fail
		else {
			outputText("You attempt to crush the worms with your reprisal, only to have the collective move its individual members, creating a void at the point of impact, leaving you to attack only empty air.\n\n", false);
		}
		enemyAI();
		return;
	}
	var damage:Number = 0;
	//Determine if dodged!
	if((player.hasStatusAffect("Blind") >= 0 && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80)) {
		//Akbal dodges special education
		if(monster.short == "Akbal") outputText("Akbal moves like lightning, weaving in and out of your furious attack with the speed and grace befitting his jaguar body.\n", false);
		else {		
			outputText(monster.capitalA + monster.short + " manage", false);
			if(!monster.plural) outputText("s", false);
			outputText(" to dodge your kick!", false);
			outputText("\n\n", false);
		}
		enemyAI();
		return;
	}
	//Determine damage
	//Base:
	damage = player.str;
	//Leg bonus
	//Bunny - 20, Kangaroo - 35, 1 hoof = 30, 2 hooves = 40
	if(player.lowerBody == 4) damage += 40;
	else if(player.lowerBody == 1) damage += 30;
	else if(player.lowerBody == 12) damage += 20;
	else if(player.lowerBody == 14) damage += 35;
	//Start figuring enemy damage resistance
	var reduction:Number = rand(monster.tou);
	//Add in enemy armor if needed
	reduction += monster.armorDef;
	//Apply AND DONE!
	damage -= reduction;
	//Damage post processing!
	if(player.hasPerk("History: Fighter") >= 0) damage *= 1.1;
	//(None yet!)
	if(damage > 0) damage = doDamage(damage);
	
	//BLOCKED
	if(damage <= 0) {
		damage = 0;
		outputText(monster.capitalA + monster.short, false);
		if(monster.plural) outputText("'", false);
		else outputText("s", false);
		outputText(" defenses are too tough for your kick to penetrate!", false);
	}
	//LAND A HIT!
	else {
		outputText(monster.capitalA + monster.short, false);
		if(!monster.plural) outputText(" reels from the damaging impact! (" + damage + ")", false);
		else outputText(" reel from the damaging impact! (" + damage + ")", false);
	}
	if(damage > 0) {
		//Lust raised by anemone contact!
		if(monster.short == "anemone") {
			outputText("\nThough you managed to hit the anemone, several of the tentacles surrounding her body sent home jolts of venom when your swing brushed past them.", false);
			//(gain lust, temp lose str/spd)
			applyVenom((1+rand(2)));
		}
	}
	outputText("\n\n", false);
	if(monster.HP < 1 || monster.lust > 99) combatRoundOver();
	else enemyAI();
}

function PCWebAttack():void {
	outputText("", true);
	//Keep logic sane if this attack brings victory
	if(player.tailVenom < 33) {
		outputText("You do not have enough webbing to shoot right now!", true);
		doNext(5161);
		return;
	}
	player.tailVenom-= 33;
	//Amily!
	if(monster.hasStatusAffect("Concentration") >= 0) {
		outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n", true);
		enemyAI();
		return;
	}
	//Blind
	if(player.hasStatusAffect("Blind") >= 0) {
		outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ", false);
	}
	else outputText("Turning and clenching muscles that no human should have, you expel a spray of sticky webs at " + monster.a + monster.short + "!  ", false);
	//Determine if dodged!
	if((player.hasStatusAffect("Blind") >= 0 && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80)) {
		outputText("You miss " + monster.a + monster.short + " completely - ", false);
		if(monster.plural) outputText("they", false);
		else outputText(monster.mf("he","she") + " moved out of the way!\n\n", false);
		enemyAI();
		return;
	}
	//Over-webbed
	if(monster.spe < 1) {
		if(!monster.plural) outputText(monster.capitalA + monster.short + " is completely covered in webbing, but you hose " + monster.mf("him","her") + " down again anyway.", false);
		else outputText(monster.capitalA + monster.short + " are completely covered in webbing, but you hose them down again anyway.", false);
	}
	//LAND A HIT!
	else {
		if(!monster.plural) outputText("The adhesive strands cover " + monster.a + monster.short + " with restrictive webbing, greatly slowing " + monster.mf("him","her") + ".", false);
		else outputText("The adhesive strands cover " + monster.a + monster.short + " with restrictive webbing, greatly slowing " + monster.mf("him","her") + ".", false);
		monster.spe -= 45;
		if(monster.spe < 0) monster.spe = 0;
	}
	outputText("\n\n", false);
	if(monster.HP < 1 || monster.lust > 99) combatRoundOver();
	else enemyAI();
}
function nagaBiteAttack():void {
	outputText("", true);
	//FATIIIIGUE
	if(player.fatigue + physicalCost(10) > 100) {
		outputText("You just don't have the energy to bite something right now...", true);
		menuLoc = 1;
		doNext(5000);
		return;
	}
	fatigue(10,2);
	//Amily!
	if(monster.hasStatusAffect("Concentration") >= 0) {
		outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.", true);
		enemyAI();
		return;
	}
	//Works similar to bee stinger, must be regenerated over time. Shares the same poison-meter
    if(rand(player.spe/2 + 40) + 20 > monster.spe/1.5) {
		//(if monster = demons)
		if(monster.short == "demons") outputText("You look at the crowd for a moment, wondering which of their number you should bite. Your glance lands upon the leader of the group, easily spotted due to his snakeskin cloak. You quickly dart through the demon crowd as it closes in around you and lunge towards the broad form of the leader. You catch the demon off guard and sink your needle-like fangs deep into his flesh. You quickly release your venom and retreat before he, or the rest of the group manage to react.", false);
		//(Otherwise) 
		else outputText("You lunge at the foe headfirst, fangs bared. You manage to catch " + monster.a + monster.short + " off guard, your needle-like fangs penetrating deep into " + monster.pronoun3 + " body. You quickly release your venom, and retreat before " + monster.pronoun1 + " manages to react.", false);
        //The following is how the enemy reacts over time to poison. It is displayed after the description paragraph,instead of lust
        monster.str -= 5 + rand(5);
		monster.spe -= 5 + rand(5);
		if(monster.str < 1) monster.str = 1;
		if(monster.spe < 1) monster.spe = 1;
		if(monster.hasStatusAffect("Naga Venom") >= 0)
		{
			monster.addStatusValue("Naga Venom",1,1);
		}
		else monster.createStatusAffect("Naga Venom",1,0,0,0);
	}
	else {
       outputText("You lunge headfirst, fangs bared. Your attempt fails horrendously, as " + monster.a + monster.short + " manages to counter your lunge, knocking your head away with enough force to make your ears ring.", false);
	}
	outputText("\n\n", false);
	if(monster.HP < 1 || monster.lust > 99) combatRoundOver();
	else enemyAI();
}
function spiderBiteAttack():void {
	outputText("", true);
	//FATIIIIGUE
	if(player.fatigue + physicalCost(10) > 100) {
		outputText("You just don't have the energy to bite something right now...", true);
		menuLoc = 1;
		doNext(5000);
		return;
	}
	fatigue(10,2);
	//Amily!
	if(monster.hasStatusAffect("Concentration") >= 0) {
		outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.", true);
		enemyAI();
		return;
	}
	//Works similar to bee stinger, must be regenerated over time. Shares the same poison-meter
    if(rand(player.spe/2 + 40) + 20 > monster.spe/1.5) {
		//(if monster = demons)
		if(monster.short == "demons") outputText("You look at the crowd for a moment, wondering which of their number you should bite. Your glance lands upon the leader of the group, easily spotted due to his snakeskin cloak. You quickly dart through the demon crowd as it closes in around you and lunge towards the broad form of the leader. You catch the demon off guard and sink your needle-like fangs deep into his flesh. You quickly release your venom and retreat before he, or the rest of the group manage to react.", false);
		//(Otherwise) 
		else {
			if(!monster.plural) outputText("You lunge at the foe headfirst, fangs bared. You manage to catch " + monster.a + monster.short + " off guard, your needle-like fangs penetrating deep into " + monster.pronoun3 + " body. You quickly release your venom, and retreat before " + monster.a + monster.pronoun1 + " manages to react.", false);
			else outputText("You lunge at the foes headfirst, fangs bared. You manage to catch one of " + monster.a + monster.short + " off guard, your needle-like fangs penetrating deep into " + monster.pronoun3 + " body. You quickly release your venom, and retreat before " + monster.a + monster.pronoun1 + " manage to react.", false);
		}
		//React
		if(monster.lustVuln == 0) outputText("  Your aphrodisiac toxin has no effect!", false);
		else {
			if(monster.plural) outputText("  The one you bit flushes hotly, though the entire group seems to become more aroused in sympathy to their now-lusty compatriot.", false);
			else outputText("  " + monster.mf("He","She") + " flushes hotly and " + monster.mf("touches his suddenly-stiff member, moaning lewdly for a moment.","touches a suddenly stiff nipple, moaning lewdly.  You can smell her arousal in the air."), false);
			monster.lust += 25 * monster.lustVuln;
			if(rand(5) == 0) monster.lust += 25 * monster.lustVuln;
		}
	}
	else {
       outputText("You lunge headfirst, fangs bared. Your attempt fails horrendously, as " + monster.a + monster.short + " manages to counter your lunge, pushing you back out of range.", false);
	}
	outputText("\n\n", false);
	if(monster.HP < 1 || monster.lust > 99) combatRoundOver();
	else enemyAI();
}


//New Abilities and Items
//[Abilities]
//Whisper 
function superWhisperAttack():void {
	outputText("", true);
	if(player.fatigue + 10 > 100) {
		outputText("You are too tired to focus this ability.", true);
		doNext(5000);
		return;
	}
	if(player.hasStatusAffect("Throat Punch") >= 0 || player.hasStatusAffect("Web-Silence") >= 0) {
		outputText("You cannot focus to reach the enemy's mind while you're having so much difficult breathing.", true);
		doNext(5000);
		return;
	}
	if(monster.short == "pod" || monster.inte == 0) {
		outputText("You reach for the enemy's mind, but cannot find anything.  You frantically search around, but there is no consciousness as you know it in the room.\n\n", true);
		changeFatigue(1);
		enemyAI();
		return;
	}
	menuLoc = 0;
	changeFatigue(10);
	if(monster.hasStatusAffect("Shell") >= 0) {
		outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
		enemyAI();
		return;
	}
	if(monster.hasPerk("Focused") >= 0) {
		if(!monster.plural) outputText(monster.capitalA + monster.short + " is too focused for your whispers to influence!\n\n");
		enemyAI();
		return;
	}
	//Enemy too strong or multiplesI think you 
	if(player.inte < monster.inte || monster.plural) {
		outputText("You reach for your enemy's mind, but can't break through.\n", false);
		changeFatigue(10);
		enemyAI();
		return;
	}
	//[Failure] 
	if(rand(10) == 0) {
		outputText("As you reach for your enemy's mind, you are distracted and the chorus of voices screams out all at once within your mind. You're forced to hastily silence the voices to protect yourself.", false);
		changeFatigue(10);
		enemyAI();
		return;
	}
	outputText("You reach for your enemy's mind, watching as its sudden fear petrifies your foe.\n\n", false);
	monster.createStatusAffect("Fear",1,0,0,0);
	enemyAI();
	return;
}

//Attack used:
//This attack has a cooldown and is more dramatic when used by the PC, it should be some sort of last ditch attack for emergencies. Don't count on using this whenever you want.
	//once a day or something
	//Effect of attack: Damages and stuns the enemy for the turn you used this attack on, plus 2 more turns. High chance of success.
function dragonBreath():void {
	clearOutput();
	if(player.fatigue + 20 > 100) {
		outputText("You are too tired to breathe fire.", true);
		doNext(5000);
		return;
	}
	//Not Ready Yet:
	if(player.hasStatusAffect("Dragon Breath Cooldown") >= 0) {
		outputText("You try to tap into the power within you, but your burning throat reminds you that you're not yet ready to unleash it again...");
		doNext(5000);
		return;
	}
	menuLoc = 0;
	changeFatigue(20);
	player.createStatusAffect("Dragon Breath Cooldown",0,0,0,0);
	var damage:Number = int(player.level * 8 + 25 + rand(10));
	if(player.hasStatusAffect("Dragon Breath Boost") >= 0) {
		player.removeStatusAffect("Dragon Breath Boost");
		damage *= 1.5;
	}
	//Shell
	if(monster.hasStatusAffect("Shell") >= 0) {
		outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
		enemyAI();
		return;
	}
	//Amily!
	if(monster.hasStatusAffect("Concentration") >= 0) {
		outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.", true);
		enemyAI();
		return;
	}
	outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around " + monster.pronoun2 + ".  " + monster.capitalA + monster.short + " does " + monster.pronoun3 + " best to avoid it, but the wave of force is too fast.");
	if(monster.hasStatusAffect("sandstorm") >= 0) {
		outputText("  <b>Your breath is massively dissipated by the swirling vortex, causing it to hit with far less force!</b>");
		damage = Math.round(0.2 * damage);
	}
	//Miss: 
	if((player.hasStatusAffect("Blind") >= 0 && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80)) {
		outputText("  Despite the heavy impact caused by your roar, " + monster.a + monster.short + " manages to take it at an angle and remain on " + monster.pronoun3 + " feet and focuses on you, ready to keep fighting.");
	}
	//Special enemy avoidances
	else if(monster.short == "Vala") {
		outputText("Vala beats her wings with surprising strength, blowing the fireball back at you! ", false);		
		if(player.hasPerk("Evade") >= 0 && rand(2) == 0) {
			outputText("You dive out of the way and evade it!", false);
		}
		else if(player.hasPerk("Flexibility") >= 0 && rand(4) == 0) {
			outputText("You use your flexibility to barely fold your body out of the way!", false);
		}
		else {
			damage = takeDamage(damage);
			outputText("Your own fire smacks into your face! (" + damage + ")", false);
		}
		outputText("\n\n", false);
	}
	//Goos burn
	else if(monster.short == "goo-girl") {
		outputText(" Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer. ", false);
		if(monster.hasPerk("Acid") < 0) monster.createPerk("Acid",0,0,0,0);
		damage = Math.round(damage * 1.5);
		damage = doDamage(damage);
		monster.createStatusAffect("Stunned",0,0,0,0);
		outputText("(" + damage + ")\n\n", false);
	}
	else {
		if(monster.hasPerk("Resolute") < 0) {
			outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " crashing to the ground, too dazed to strike back.");
			monster.createStatusAffect("Stunned",1,0,0,0);
		}
		else {
			outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
			if(!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be stunned by your attack.</b>");
		}
		damage = doDamage(damage);
		outputText(" (" + damage + ")");
	}
	outputText("\n\n");
	if(monster.short == "Holli" && monster.hasStatusAffect("Holli Burning") < 0) lightHolliOnFireMagically();
	combatRoundOver();
}



//* Terrestrial Fire
function fireballuuuuu():void {
	outputText("", true);
	if(player.fatigue + 20 > 100) {
		outputText("You are too tired to breathe fire.", true);
		doNext(5000);
		return;
	}
	menuLoc = 0;
	changeFatigue(20);
	if(monster.hasStatusAffect("Shell") >= 0) {
		outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
		enemyAI();
		return;
	}
	//Amily!
	if(monster.hasStatusAffect("Concentration") >= 0) {
		outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.", true);
		enemyAI();
		return;
	}
	//[Failure]
	//(high damage to self, +20 fatigue)
	if(rand(5) == 0 || player.hasStatusAffect("Web-Silence") >= 0) {
		if(player.hasStatusAffect("Web-Silence") >= 0) outputText("You reach for the terrestrial fire, but as you ready to release a torrent of flame, it backs up in your throat, blocked by the webbing across your mouth.  It causes you to cry out as the sudden, heated force explodes in your own throat.\n\n", false);
		else if(player.hasStatusAffect("GooArmorSilence") >= 0) outputText("You reach for the terrestrial fire but as you ready the torrent, it erupts prematurely, causing you to cry out as the sudden heated force explodes in your own throat.  The slime covering your mouth bubbles and pops, boiling away where the escaping flame opens small rents in it.  That wasn't as effective as you'd hoped, but you can at least speak now.");
		else outputText("You reach for the terrestrial fire, but as you ready to release a torrent of flame, the fire inside erupts prematurely, causing you to cry out as the sudden heated force explodes in your own throat.\n\n", false);
		changeFatigue(10);
		takeDamage(10+rand(20));
		enemyAI();
		return;
	}
	var damage:Number = 0;
	damage = int(player.level * 10 + 45 + rand(10));
	if(player.hasStatusAffect("GooArmorSilence") >= 0) {
		outputText("<b>A growl rumbles from deep within as you charge the terrestrial fire, and you force it from your chest and into the slime.  The goop bubbles and steams as it evaporates, drawing a curious look from your foe, who pauses in her onslaught to lean in and watch.  While the tension around your mouth lessens and your opponent forgets herself more and more, you bide your time.  When you can finally work your jaw enough to open your mouth, you expel the lion's - or jaguar's? share of the flame, inflating an enormous bubble of fire and evaporated slime that thins and finally pops to release a superheated cloud.  The armored girl screams and recoils as she's enveloped, flailing her arms.</b> ", false);
		player.removeStatusAffect("GooArmorSilence");
		damage += 25;
	}
	else outputText("A growl rumbles deep with your chest as you charge the terrestrial fire.  When you can hold it no longer, you release an ear splitting roar and hurl a giant green conflagration at your enemy. ", false);
	
	
	if(monster.short == "Isabella") {
		outputText("Isabella shoulders her shield into the path of the emerald flames.  They burst over the wall of steel, splitting around the impenetrable obstruction and washing out harmlessly to sides.\n\n", false);
		outputText("\"<i>Is zat all you've got?  It'll take more than a flashy magic trick to beat Izabella!</i>\" taunts the cow-girl.\n\n", false);
		enemyAI();
		return;
	}
	else if(monster.short == "Vala") {
		outputText("Vala beats her wings with surprising strength, blowing the fireball back at you! ", false);		
		if(player.hasPerk("Evade") >= 0 && rand(2) == 0) {
			outputText("You dive out of the way and evade it!", false);
		}
		else if(player.hasPerk("Flexibility") >= 0 && rand(4) == 0) {
			outputText("You use your flexibility to barely fold your body out of the way!", false);
		}
		else {
			outputText("Your own fire smacks into your face! (" + damage + ")", false);
			takeDamage(damage);
		}
		outputText("\n\n", false);
	}
	else {
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText(" Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer. ", false);
			if(monster.hasPerk("Acid") < 0) monster.createPerk("Acid",0,0,0,0);
			damage = Math.round(damage * 1.5);
		}
		if(monster.hasStatusAffect("sandstorm") >= 0) {
			outputText("<b>Your breath is massively dissipated by the swirling vortex, causing it to hit with far less force!</b>  ");
			damage = Math.round(0.2 * damage);
		}
		outputText("(" + damage + ")\n\n", false);
		monster.HP -= damage;
		if(monster.short == "Holli" && monster.hasStatusAffect("Holli Burning") < 0) lightHolliOnFireMagically();
	}
	if(monster.HP < 1) {
		doNext(5008);
		return;
	}
	else enemyAI();
}

function kissAttack():void {
	if(player.hasStatusAffect("Blind") >= 0) {
		outputText("There's no way you'd be able to find their lips while you're blind!", true);
		menuLoc = 3;
		doNext(5161);
		return;
	}
	outputText("", true);
	var attack:Number = rand(6);
	switch(attack) {
		case 1:
			//Attack text 1:
			outputText("You hop up to " + monster.a + monster.short + " and attempt to plant a kiss on " + monster.pronoun3 + ".", false);
			break;
		//Attack text 2:
		case 2:
			outputText("You saunter up and dart forward, puckering your golden lips into a perfect kiss.", false);
			break;
		//Attack text 3: 
		case 3:
			outputText("Swaying sensually, you wiggle up to " + monster.a + monster.short + " and attempt to plant a nice wet kiss on " + monster.pronoun2 + ".", false);
			break;
		//Attack text 4:
		case 4:
			outputText("Lunging forward, you fly through the air at " + monster.a + monster.short + " with your lips puckered and ready to smear drugs all over " + monster.pronoun2 + ".", false);
			break;
		//Attack text 5:
		case 5:
			outputText("You lean over, your lips swollen with lust, wet with your wanting slobber as you close in on " + monster.a + monster.short + ".", false);
			break;
		//Attack text 6:
		default:
			outputText("Pursing your drug-laced lips, you close on " + monster.a + monster.short + " and try to plant a nice, wet kiss on " + monster.pronoun2 + ".", false);
			break;
	}
	//Dodged!
	if(monster.spe - player.spe > 0 && rand(((monster.spe - player.spe)/4)+80) > 80) {
		attack = rand(3);
		switch(attack) {
			//Dodge 1:
			case 1:
				if(monster.plural) outputText("  " + monster.capitalA + monster.short + " sees it coming and moves out of the way in the nick of time!\n\n", false);
				break;
			//Dodge 2:
			case 2:
				if(monster.plural) outputText("  Unfortunately, you're too slow, and " + monster.a + monster.short + " slips out of the way before you can lay a wet one on one of them.\n\n", false);
				else outputText("  Unfortunately, you're too slow, and " + monster.a + monster.short + " slips out of the way before you can lay a wet one on " + monster.pronoun2 + ".\n\n", false);
				break;
			//Dodge 3:
			default:
				if(monster.plural) outputText("  Sadly, " + monster.a + monster.short + " moves aside, denying you the chance to give one of them a smooch.\n\n", false);
				else outputText("  Sadly, " + monster.a + monster.short + " moves aside, denying you the chance to give " + monster.pronoun2 + " a smooch.\n\n", false);
				break;
		}
		enemyAI();
		return;
	}
	//Success but no effect:
	if(monster.lustVuln <= 0 || !monster.hasCock()) {
		if(monster.plural) outputText("  Mouth presses against mouth, and you allow your tongue to stick out to taste the saliva of one of their number, making sure to give them a big dose.  Pulling back, you look at " + monster.a + monster.short + " and immediately regret wasting the time on the kiss.  It had no effect!\n\n", false);
		else outputText("  Mouth presses against mouth, and you allow your tongue to stick to taste " + monster.pronoun3 + "'s saliva as you make sure to give them a big dose.  Pulling back, you look at " + monster.a + monster.short + " and immediately regret wasting the time on the kiss.  It had no effect!\n\n", false);
		enemyAI();
		return;
	}
	attack = rand(4);
	var damage:Number = 0;
	switch(attack) {
		//Success 1:
		case 1:
			if(monster.plural) outputText("  Success!  A spit-soaked kiss lands right on one of their mouths.  The victim quickly melts into your embrace, allowing you to give them a nice, heavy dose of sloppy oral aphrodisiacs.\n\n", false);
			else outputText("  Success!  A spit-soaked kiss lands right on " + monster.a + monster.short + "'s mouth.  " + monster.mf("He","She") + " quickly melts into your embrace, allowing you to give them a nice, heavy dose of sloppy oral aphrodisiacs.\n\n", false);
			damage = 15;
			break;
		//Success 2:
		case 2:
			if(monster.plural) outputText("  Gold-gilt lips press into one of their mouths, the victim's lips melding with yours.  You take your time with your suddenly cooperative captive and make sure to cover every bit of their mouth with your lipstick before you let them go.\n\n", false);
			else outputText("  Gold-gilt lips press into " + monster.a + monster.short + ", " + monster.pronoun3 + " mouth melding with yours.  You take your time with your suddenly cooperative captive and make sure to cover every inch of " + monster.pronoun3 + " with your lipstick before you let " + monster.pronoun2 + " go.\n\n", false);
			damage = 20;
			break;
		//CRITICAL SUCCESS (3)
		case 3:
			if(monster.plural) outputText("  You slip past " + monster.a + monster.short + "'s guard and press your lips against one of them.  " + monster.mf("He","She") + " melts against you, " + monster.mf("his","her") + " tongue sliding into your mouth as " + monster.mf("he","she") + " quickly succumbs to the fiery, cock-swelling kiss.  It goes on for quite some time.  Once you're sure you've given a full dose to " + monster.mf("his","her") + " mouth, you break back and observe your handwork.  One of " + monster.a + monster.short + " is still standing there, licking " + monster.mf("his","her") + " his lips while " + monster.mf("his","her") + " dick is standing out, iron hard.  You feel a little daring and give the swollen meat another moist peck, glossing the tip in gold.  There's no way " + monster.mf("he","she") + " will go soft now.  Though you didn't drug the rest, they're probably a little 'heated up' from the show.\n\n", false);
			else outputText("  You slip past " + monster.a + monster.short + "'s guard and press your lips against " + monster.pronoun3 + ".  " + monster.mf("He","She") + " melts against you, " + monster.pronoun3 + " tongue sliding into your mouth as " + monster.pronoun1 + " quickly succumbs to the fiery, cock-swelling kiss.  It goes on for quite some time.  Once you're sure you've given a full dose to " + monster.pronoun3 + " mouth, you break back and observe your handwork.  " + monster.capitalA + monster.short + " is still standing there, licking " + monster.pronoun3 + " lips while " + monster.pronoun3 + " dick is standing out, iron hard.  You feel a little daring and give the swollen meat another moist peck, glossing the tip in gold.  There's no way " + monster.pronoun1 + " will go soft now.\n\n", false);
			damage = 30;
			break;
		//Success 4:
		default:
			outputText("  With great effort, you slip through an opening and compress their lips against your own, lust seeping through the oral embrace along with a heavy dose of drugs.\n\n", false);
			damage = 12;
			break;
	}
	//Add status if not already drugged
	if(monster.hasStatusAffect("Lust Stick") < 0) monster.createStatusAffect("Lust Stick",0,0,0,0);
	//Else add bonus to round damage
	else monster.addStatusValue("Lust Stick",2,Math.round(damage/10));
	//Deal damage
	monster.lust += Math.round(monster.lustVuln * damage);
	//Sets up for end of combat, and if not, goes to AI.
	if(!combatRoundOver()) enemyAI();
	return;
}
function possess():void {
	outputText("", true);
	if(monster.short == "plain girl" || monster.hasPerk("Incorporeality") >= 0) {
		outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself toward the opponent's frame.  Sadly, it was doomed to fail, as you bounce right off your foe's ghostly form.", false);
	}
	//Sample possession text (>79 int, perhaps?):
	else if((!monster.hasCock() && !monster.hasVagina()) || monster.lustVuln == 0 || monster.inte == 0 || monster.inte > 100) {
		outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into the opponent's frame.  Unfortunately, it seems ", false);
		if(monster.inte > 100) outputText("they were FAR more mentally prepared than anything you can handle, and you're summarily thrown out of their body before you're even able to have fun with them.  Darn, you muse.\n\n", false);
		else outputText("they have a body that's incompatible with any kind of possession.\n\n", false);
	}
	//Success!
	else if(player.inte >= (monster.inte - 10) + rand(21)) {
		outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into your opponent's frame. Before they can regain the initiative, you take control of one of their arms, vigorously masturbating for several seconds before you're finally thrown out. Recorporealizing, you notice your enemy's blush, and know your efforts were somewhat successful.\n\n", false);
		var damage:Number = Math.round(player.inte/5) + rand(player.level) + player.level;
		monster.lust += monster.lustVuln * damage;
	}
	//Fail
	else {
		outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into the opponent's frame. Unfortunately, it seems they were more mentally prepared than you hoped, and you're summarily thrown out of their body before you're even able to have fun with them. Darn, you muse. Gotta get smarter.\n\n", false);
	}
	if(!combatRoundOver()) enemyAI();
}

function runAway():void {
	outputText("", true);
	if(inCombat() && player.hasStatusAffect("Sealed") >= 0 && player.statusAffectv2("Sealed") == 4) {
		clearOutput();
		outputText("You try to run, but you just can't seem to escape.  <b>Your ability to run was sealed, and now you've wasted a chance to attack!</b>\n\n");
		enemyAI();
		return;
	}
	//Rut doesnt let you run from dicks.
	if(player.hasStatusAffect("rut") >= 0 && monster.totalCocks() > 0) {
		outputText("The thought of another male in your area competing for all the pussy infuriates you!  No way will you run!", true);
		menuLoc = 3;
		doNext(5000);
		return;
	}
	if(monster.hasStatusAffect("level") >= 0 && player.canFly()) {
		clearOutput();
		outputText("You flex the muscles in your back and, shaking clear of the sand, burst into the air!  Wasting no time you fly free of the sandtrap and its treacherous pit.  \"One day your wings will fall off, little ant,\" the snarling voice of the thwarted androgyne carries up to you as you make your escape.  \"And I will be waiting for you when they do!\"");
		gameState = 0;
		clearStatuses(false);
		doNext(13);
		return;
	}
	if(monster.hasStatusAffect("Generic Run Disabled") >= 0 || isUrta()) {
		menuLoc = 3;
		outputText("You can't escape from this fight!");
		doNext(5000);
		return;
	}
	if(monster.hasStatusAffect("level") >= 0 && monster.statusAffectv1("level") < 4) {
		menuLoc = 3;
		outputText("You're too deeply mired to escape!  You'll have to <b>climb</b> some first!");
		doNext(5000);
		return;
	}
	if(monster.hasStatusAffect("Run Disabled") >= 0) {
		menuLoc = 3;
		outputText("You'd like to run, but you can't scale the walls of the pit with so many demonic hands pulling you down!");
		doNext(5000);
		return;
	}
	if(flags[UNKNOWN_FLAG_NUMBER_00329] == 1 && (monster.short == "minotaur gang" || monster.short == "minotaur tribe")) {
		flags[UNKNOWN_FLAG_NUMBER_00329] = 0;
		//(Free run away) 
		outputText("You slink away while the pack of brutes is arguing.  Once they finish that argument, they'll be sorely disappointed!", true);
		gameState = 0;
		clearStatuses(false);
		doNext(13);
		return;
	}
	else if(monster.short == "minotaur tribe" && monster.HP/eMaxHP() >= 0.75) {
		outputText("There's too many of them surrounding you to run!", true);
		menuLoc = 3;
		doNext(5000);
		return;
	}
	if(inDungeon) {
		outputText("You're trapped in your foe's home turf - there is nowhere to run!\n\n", true);
		enemyAI();
		return;
	}
	//Attempt texts!
	if(monster.short == "Ember") {
		outputText("You take off");
		if(!player.canFly()) outputText(" running");
		else outputText(", flapping as hard as you can");
		outputText(", and Ember, caught up in the moment, gives chase.  ");
	}
	else if(player.canFly()) outputText("Gritting your teeth with effort, you beat your wings quickly and lift off!  ", false);	
	//Nonflying PCs
	else {
		//Stuck!
		if(player.hasStatusAffect("NoFlee") >= 0) {
			if(monster.short == "goblin") outputText("You try to flee but get stuck in the sticky white goop surrounding you.\n\n", true);
			else outputText("You put all your skills at running to work and make a supreme effort to escape, but are unable to get away!\n\n", true);
			enemyAI();
			return;
		}
		//Nonstuck!
		else outputText("You turn tail and attempt to flee!  ", false);
	}
		
	//Calculations
	var escapeMod:Number = 20 + monster.level * 3;
	if(debug) escapeMod -= 300;
	if(player.canFly()) escapeMod -= 20;
	if(player.tailType == 15 && player.earType == 11 && player.hasPerk("Runner") >= 0) escapeMod -= 25;
	
	//Big tits doesn't matter as much if ya can fly!
	else {
		if(player.biggestTitSize() >= 35) escapeMod += 5;
		if(player.biggestTitSize() >= 66) escapeMod += 10;
		if(player.hipRating >= 20) escapeMod += 5;
		if(player.buttRating >= 20) escapeMod += 5;
		if(player.ballSize >= 24 && player.balls > 0) escapeMod += 5;
		if(player.ballSize >= 48 && player.balls > 0) escapeMod += 10;
		if(player.ballSize >= 120 && player.balls > 0) escapeMod += 10;
	}
	//ANEMONE OVERRULES NORMAL RUN
	if(monster.short == "anemone") {
		//Autosuccess - less than 60 lust
		if(player.lust < 60) {
			outputText("Marshalling your thoughts, you frown at the strange girl and turn to march up the beach.  After twenty paces inshore you turn back to look at her again.  The anemone is clearly crestfallen by your departure, pouting heavily as she sinks beneath the water's surface.", true);
			gameState = 0;
			clearStatuses(false);
			doNext(13);
			return;
		}
		//Speeed dependant
		else {
			//Success
			if(player.spe > rand(monster.spe+escapeMod)) {
				gameState = 0;
				clearStatuses(false);
				outputText("Marshalling your thoughts, you frown at the strange girl and turn to march up the beach.  After twenty paces inshore you turn back to look at her again.  The anemone is clearly crestfallen by your departure, pouting heavily as she sinks beneath the water's surface.", true);
				doNext(13);
				return;
			}
			//Run failed:
			else {
				outputText("You try to shake off the fog and run but the anemone slinks over to you and her tentacles wrap around your waist.  <i>\"Stay?\"</i> she asks, pressing her small breasts into you as a tentacle slides inside your " + player.armorName + " and down to your nethers.  The combined stimulation of the rubbing and the tingling venom causes your knees to buckle, hampering your resolve and ending your escape attempt.", false);
				//(gain lust, temp lose spd/str)
				applyVenom((4+player.sens/20));
				combatRoundOver();
				return;
			}
		}
	}
	//Ember is SPUCIAL
	if(monster.short == "Ember") {
		//GET AWAY
		if(player.spe > rand(monster.spe + escapeMod) || (player.hasPerk("Runner") >= 0 && rand(100) < 50)) {
			if(player.hasPerk("Runner") >= 0) outputText("Using your skill at running, y");
			else outputText("Y");
			outputText("ou easily outpace the dragon, who begins hurling imprecations at you.  \"What the hell, [name], you weenie; are you so scared that you can't even stick out your punishment?\"");
			outputText("\n\nNot to be outdone, you call back, \"Sucks to you!  If even the mighty Last Ember of Hope can't catch me, why do I need to train?  Later, little bird!\"");
			gameState = 0;
			clearStatuses(false);
			doNext(13);
		}
		//Fail: 
		else {
			outputText("Despite some impressive jinking, " + emberMF("he","she") + " catches you, tackling you to the ground.\n\n");
			enemyAI();
		}
		return;
	}
	//SUCCESSFUL FLEE
	if(player.spe > rand(monster.spe + escapeMod)) {
		//Fliers flee!
		if(player.canFly()) outputText(monster.capitalA + monster.short + " can't catch you.", false);
		//sekrit benefit: if you have coon ears, coon tail, and Runner perk, change normal Runner escape to flight-type escape
		else if(player.tailType == 15 && player.earType == 11 && player.hasPerk("Runner") >= 0) {
			outputText("Using your running skill, you build up a head of steam and jump, then spread your arms and flail your tail wildly; your opponent dogs you as best " + monster.pronoun1 + " can, but stops and stares dumbly as your spastic tail slowly propels you several meters into the air!  You leave " + monster.pronoun2 + " behind with your clumsy, jerky, short-range flight.");
		}		
		//Non-fliers flee
		else outputText(monster.capitalA + monster.short + " rapidly disappears into the shifting landscape behind you.", false);
		if(monster.short == "Izma") {
			outputText("\n\nAs you leave the tigershark behind, her taunting voice rings out after you.  \"<i>Oooh, look at that fine backside!  Are you running or trying to entice me?  Haha, looks like we know who's the superior specimen now!  Remember: next time we meet, you owe me that ass!</i>\"  Your cheek tingles in shame at her catcalls.", false);
		}
		gameState = 0;
		clearStatuses(false);
		doNext(13);
		return;
	}
	//Runner perk chance
	else if(player.hasPerk("Runner") >= 0 && rand(100) < 50) {
		gameState = 0;
		outputText("Thanks to your talent for running, you manage to escape.", false);
		if(monster.short == "Izma") {
			outputText("\n\nAs you leave the tigershark behind, her taunting voice rings out after you.  \"<i>Oooh, look at that fine backside!  Are you running or trying to entice me?  Haha, looks like we know who's the superior specimen now!  Remember: next time we meet, you owe me that ass!</i>\"  Your cheek tingles in shame at her catcalls.", false);
		}
		clearStatuses(false);
		doNext(13);
		return;
	}
	//FAIL FLEE
	else {
		if(monster.short == "Holli") {
			escapeFailWithHolli();
			return;
		}
		//Flyers get special failure message.
		if(player.canFly()) {
			if(monster.plural) outputText(monster.capitalA + monster.short + " manage to grab your " + player.legs() + " and drag you back to the ground before you can fly away!", false);
			else outputText(monster.capitalA + monster.short + " manages to grab your " + player.legs() + " and drag you back to the ground before you can fly away!", false);
		}
		//fail
		else if(player.tailType == 15 && player.earType == 11 && player.hasPerk("Runner") >= 0) outputText("Using your running skill, you build up a head of steam and jump, but before you can clear the ground more than a foot, your opponent latches onto you and drags you back down with a thud!");
		//Nonflyer messages
		else {
			//Huge balls messages
			if(player.balls > 0 && player.ballSize >= 24) {
				if(player.ballSize < 48) outputText("With your " + ballsDescriptLight() + " swinging ponderously beneath you, getting away is far harder than it should be.  ", false);
				else outputText("With your " + ballsDescriptLight() + " dragging along the ground, getting away is far harder than it should be.  ", false);
			}
			//FATASS BODY MESSAGES
			if(player.biggestTitSize() >= 35 || player.buttRating >= 20 || player.hipRating >= 20)
			{
				//FOR PLAYERS WITH GIANT BREASTS
				if(player.biggestTitSize() >= 35 && player.biggestTitSize() < 66)
				{
					if(player.hipRating >= 20)
					{
						outputText("Your " + hipDescript() + " forces your gait to lurch slightly side to side, which causes the fat of your " + player.skinTone + " ", false);
						if(player.buttRating >= 20) outputText(buttDescript() + " and ", false);
						outputText(chestDesc() + " to wobble immensely, throwing you off balance and preventing you from moving quick enough to escape.", false);
					}
					else if(player.buttRating >= 20) outputText("Your " + player.skinTone + buttDescript() + " and " + chestDesc() + " wobble and bounce heavily, throwing you off balance and preventing you from moving quick enough to escape.", false);
					else outputText("Your " + chestDesc() + " jiggle and wobble side to side like the " + player.skinTone + " sacks of milky fat they are, with such force as to constantly throw you off balance, preventing you from moving quick enough to escape.", false);
				}
				//FOR PLAYERS WITH MASSIVE BREASTS
				else if(player.biggestTitSize() >= 66) {
					if(player.hipRating >= 20) {
						outputText("Your " + chestDesc() + " nearly drag along the ground while your " + hipDescript() + " swing side to side ", false);
						if(player.buttRating >= 20) outputText("causing the fat of your " + player.skinTone + buttDescript() + " to wobble heavily, ", false);
						outputText("forcing your body off balance and preventing you from moving quick enough to get escape.", false);
					}
					else if(player.buttRating >= 20) outputText("Your " +chestDesc() + " nearly drag along the ground while the fat of your " + player.skinTone + buttDescript() + " wobbles heavily from side to side, forcing your body off balance and preventing you from moving quick enough to escape.", false);
					else outputText("Your " + chestDesc() + " nearly drag along the ground, preventing you from moving quick enough to get escape.", false);
				}
				//FOR PLAYERS WITH EITHER GIANT HIPS OR BUTT BUT NOT THE BREASTS
				else if(player.hipRating >= 20) {
					outputText("Your " + hipDescript() + " swing heavily from side to side ", false);
					if(player.buttRating >= 20) outputText("causing your " + player.skinTone + buttDescript() + " to wobble obscenely ", false);
					outputText("and forcing your body into an awkward gait that slows you down, preventing you from escaping.", false);
				}
				//JUST DA BOOTAH
				else if(player.buttRating >= 20) outputText("Your " + player.skinTone + buttDescript() + " wobbles so heavily that you're unable to move quick enough to escape.", false);
			}
			//NORMAL RUN FAIL MESSAGES
			else if(monster.plural) outputText(monster.capitalA + monster.short + " stay hot on your heels, denying you a chance at escape!", false);
			else outputText(monster.capitalA + monster.short + " stays hot on your heels, denying you a chance at escape!", false);
		}
	}
	outputText("\n\n", false);
	enemyAI();
	return;
}

function anemoneSting():void {
	outputText("", true);
	//-sting with hair (combines both bee-sting effects, but weaker than either one separately):
	//Fail!
	//25% base fail chance
	//Increased by 1% for every point over PC's speed
	//Decreased by 1% for every inch of hair the PC has
	var prob:Number = 70;
	if(monster.spe > player.spe) prob -= monster.spe - player.spe;
	prob += player.hairLength;
	if(prob <= rand(101)) {
		//-miss a sting
		if(monster.plural) outputText("You rush " + monster.a + monster.short + ", whipping your hair around to catch them with your tentacles, but " + monster.pronoun1 + " easily dodge.  Oy, you hope you didn't just give yourself whiplash.", false);
		else outputText("You rush " + monster.a + monster.short + ", whipping your hair around to catch it with your tentacles, but " + monster.pronoun1 + " easily dodges.  Oy, you hope you didn't just give yourself whiplash.", false);
	}	
	//Success!
	else {
		outputText("You rush " + monster.a + monster.short + ", whipping your hair around like a genie", false);
		outputText(", and manage to land a few swipes with your tentacles.  ", false);
		if(monster.plural) outputText("As the venom infiltrates " + monster.pronoun3 + " bodies, " + monster.pronoun1 + " twitch and begin to move more slowly, hampered half by paralysis and half by arousal.", false);
		else outputText("As the venom infiltrates " + monster.pronoun3 + " body, " + monster.pronoun1 + " twitches and begins to move more slowly, hampered half by paralysis and half by arousal.", false);
		//(decrease speed/str, increase lust)
		//-venom capacity determined by hair length, 2-3 stings per level of length
		//Each sting does 5-10 lust damage and 2.5-5 speed damage
		var damage:Number = 0;
		temp = 1 + rand(2);
		if(player.hairLength >= 12) temp += 1 + rand(2);
		if(player.hairLength >= 24) temp += 1 + rand(2);
		if(player.hairLength >= 36) temp += 1;
		while(temp > 0) {
			temp--;
			damage += 5 + rand(6);
		}
		damage += player.level * 1.5;
		monster.spe -= damage/2;
		damage = monster.lustVuln * damage;
		monster.lust += damage;
		//Clean up down to 1 decimal point
		damage = Math.round(damage*10)/10;		
		outputText(" (" + damage + ")", false);
	}
	//New lines and moving on!
	outputText("\n\n", false);
	doNext(5000);
	if(!combatRoundOver()) enemyAI();
}

function magicalSpecials():void {
	if(inCombat() && player.hasStatusAffect("Sealed") >= 0 && player.statusAffectv2("Sealed") == 6) {
		clearOutput();
		outputText("You try to ready a special ability, but wind up stumbling dizzily instead.  <b>Your ability to use magical special attacks was sealed, and now you've wasted a chance to attack!</b>\n\n");
		enemyAI();
		return;
	}
	menuLoc = 3;
	menu();
	
	//Berserk
	if(player.hasPerk("Berzerker") >= 0) {
		addButton(0,"Berzerk",berzerk);
	}
	if(player.hasPerk("Dragonfire") >= 0) {
		addButton(1,"DragonFire",dragonBreath);
	}
	if(player.hasPerk("Fire Lord") >= 0) {
		addButton(2,"Fire Breath",fireballuuuuu);
	}
	if(player.hasPerk("Hellfire") >= 0) {
		addButton(3,"Hellfire",hellFire);
	}
	//Possess ability.
	if(player.hasPerk("Incorporeality") >= 0) {
		addButton(4,"Possess",possess);
	}
	if(player.hasPerk("Whispered") >= 0) {
		addButton(5,"Whisper",superWhisperAttack);
	}
	if(player.hasPerk("Corrupted Nine-tails") >= 0) {
		addButton(6,"C.FoxFire",corruptedFoxFire);
		addButton(7,"Terror",kitsuneTerror);
	}
	if(player.hasPerk("Enlightened Nine-tails") >= 0) {
		addButton(6,"FoxFire",foxFire);
		addButton(7,"Illusion",kitsuneIllusion);
	}
	if(player.hasStatusAffect("Shielding Spell") >= 0) addButton(8,"Shielding",shieldingSpell);
	if(player.hasStatusAffect("Immolation Spell") >= 0) addButton(8,"Immolation",immolationSpell);
	addButton(9,"Back",eventParser,5000);
}
function physicalSpecials():void {
	if(isUrta()) {
		urtaSpecials();
		return;
	}
	menuLoc = 3;
	var butt1:Number = 0;
	var butt2:Number = 0;
	var butt3:Number = 0;
	var butt4:Number = 0;
	var butt5:Number = 0;
	var butt6:Number = 0;
	var butt7:Number = 0;
	var butt8:Number = 0;
	var butt9:Number = 0;
	var b1T:String = "";
	var b2T:String = "";
	var b3T:String = "";
	var b4T:String = "";
	var b5T:String = "";
	var b6T:String = "";
	var b7T:String = "";
	var b8T:String = "";
	var b9T:String = "";
	if(inCombat() && player.hasStatusAffect("Sealed") >= 0 && player.statusAffectv2("Sealed") == 5) {
		clearOutput();
		outputText("You try to ready a special attack, but wind up stumbling dizzily instead.  <b>Your ability to use physical special attacks was sealed, and now you've wasted a chance to attack!</b>\n\n");
		enemyAI();
		return;
	}
	
	if(player.hairType == 4) {
		b1T = "AnemoneSting";
		butt1 = 5162;
	}
	//Bitez
	if(player.faceType == 4 || player.faceType == 5 || player.faceType == 10) {
		if(player.faceType == 4) butt2 = 5102;
		else if(player.faceType == 5) butt2 = 5117;
		else if(player.faceType == 10) butt2 = 5157;
		b2T = "Bite";
	}
	//Bow attack
	if(player.hasKeyItem("Bow") >= 0) {
		butt3 = 5079;
		b3T = "Bow";
	}
	//Constrict
	if(player.lowerBody == 3) {
		butt4 = 5118;
		b4T = "Constrict";
	}
	//Kick attackuuuu
	else if(player.isTaur() || player.lowerBody == 4 || player.lowerBody == 1 || player.lowerBody == 12 || player.lowerBody == 14) {
		butt4 = 5150;
		b4T = "Kick";
	}
	//Gore if mino horns
	if(player.hornType == 2 && player.horns >= 6) {
		b5T = "Gore";
		butt5 = 5038;
	}
	//Infest if infested
	if(player.hasStatusAffect("infested") >= 0 && player.hasCock()) {
		if(player.statusAffects[player.hasStatusAffect("infested")].value1 == 5) {
			b6T = "Infest";
			butt6 = 5060;
		}
	}
	//Kiss supercedes bite.
	if(player.hasStatusAffect("Lust Stick Applied") >= 0) {
		butt7 = 5158;
		b7T = "Kiss";
	}	
	//Sting attack if bee butt
	if(player.tailType == 6) {
		butt8 = 5037;
		b8T = "Sting";
	}
	if(player.tailType == 5) {
		butt8 = 5156;
		b8T = "Web";
	}
	if(player.tailType == 15 || player.tailType == 7 || player.tailType == 9 || player.tailType == 14 || player.tailType == 12) {
		butt8 = 5165;
		b8T = "Tail Whip";
	}
	choices(b1T,butt1,b2T,butt2,b3T,butt3,b4T,butt4,b5T,butt5,b6T,butt6,b7T,butt7,b8T,butt8,b9T,butt9,"Back",5000);
}

function berzerk():void {
	clearOutput();
	if(player.hasStatusAffect("Berzerking") >= 0) {
		outputText("You're already pretty goddamn mad!", true);
		doNext(5160);
		return;
	}
	menuLoc = 0;
	outputText("You roar and unleash your savage fury, forgetting about defense in order to destroy your foe!\n\n", true);
	player.createStatusAffect("Berzerking",0,0,0,0);
	applyArmorStats(player.armorName, false);
	player.weaponAttack = fixedDamage(player.weaponName);
	enemyAI();
}

	




//Corrupted Fox Fire
function corruptedFoxFire():void {
	clearOutput();
	if(player.hasPerk("Blood Mage") < 0 && player.fatigue + spellCost(35) > 100) {
		outputText("You are too tired to use this ability.", true);
		doNext(5160);
		return;
	}
	if(player.hasStatusAffect("Throat Punch") >= 0 || player.hasStatusAffect("Web-Silence") >= 0) {
		outputText("You cannot focus to use this ability while you're having so much difficult breathing.", true);
		doNext(5160);
		return;
	}
	menuLoc = 0;
	fatigue(35,1);
	//Deals direct damage and lust regardless of enemy defenses.  Especially effective against non-corrupted targets.
	outputText("Holding out your palm, you conjure corrupted purple flame that dances across your fingertips.  You launch it at " + monster.a + monster.short + " with a ferocious throw, and it bursts on impact, showering dazzling lavender sparks everywhere.");
	
	
	var dmg = int(10+(player.inte/3 + rand(player.inte/2)) * spellMod());
	if(monster.cor >= 66) dmg = Math.round(dmg * .66);
	else if(monster.cor >= 50) dmg = Math.round(dmg * .8);
	//High damage to goes.
	if(monster.short == "goo-girl") temp = Math.round(temp * 1.5);
	//Using fire attacks on the goo]
	if(monster.short == "goo-girl") {
		outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.", false);
		if(monster.hasPerk("Acid") < 0) monster.createPerk("Acid",0,0,0,0);
	}
	dmg = doDamage(dmg);
	outputText("  (" + dmg + ")\n\n", false);
	statScreenRefresh();
	if(monster.HP < 1) doNext(5008);
	else enemyAI();
}
//Fox Fire
function foxFire():void {
	clearOutput();
	if(player.hasPerk("Blood Mage") < 0 && player.fatigue + spellCost(35) > 100) {
		outputText("You are too tired to use this ability.", true);
		doNext(5160);
		return;
	}
	if(player.hasStatusAffect("Throat Punch") >= 0 || player.hasStatusAffect("Web-Silence") >= 0) {
		outputText("You cannot focus to use this ability while you're having so much difficult breathing.", true);
		doNext(5160);
		return;
	}
	menuLoc = 0;
	fatigue(35,1);
	if(monster.hasStatusAffect("Shell") >= 0) {
		outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
		enemyAI();
		return;
	}
	//Deals direct damage and lust regardless of enemy defenses.  Especially effective against corrupted targets.
	outputText("Holding out your palm, you conjure an ethereal blue flame that dances across your fingertips.  You launch it at " + monster.a + monster.short + " with a ferocious throw, and it bursts on impact, showering dazzling azure sparks everywhere.");
	var dmg = int(10+(player.inte/3 + rand(player.inte/2)) * spellMod());
	if(monster.cor < 33) dmg = Math.round(dmg * .66);
	else if(monster.cor < 50) dmg = Math.round(dmg * .8);
	//High damage to goes.
	if(monster.short == "goo-girl") temp = Math.round(temp * 1.5);
	//Using fire attacks on the goo]
	if(monster.short == "goo-girl") {
		outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.", false);
		if(monster.hasPerk("Acid") < 0) monster.createPerk("Acid",0,0,0,0);
	}
	dmg = doDamage(dmg);
	outputText("  (" + dmg + ")\n\n", false);
	statScreenRefresh();
	if(monster.HP < 1) doNext(5008);
	else enemyAI();
}

//Terror
function kitsuneTerror():void {
	clearOutput();
	//Fatigue Cost: 25
	if(player.hasPerk("Blood Mage") < 0 && player.fatigue + spellCost(20) > 100) {
		outputText("You are too tired to use this ability.", true);
		doNext(5160);
		return;
	}
	if(monster.hasStatusAffect("Shell") >= 0) {
		outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
		enemyAI();
		return;
	}
	if(player.hasStatusAffect("Throat Punch") >= 0 || player.hasStatusAffect("Web-Silence") >= 0) {
		outputText("You cannot focus to reach the enemy's mind while you're having so much difficult breathing.", true);
		doNext(5160);
		return;
	}
	if(monster.short == "pod" || monster.inte == 0) {
		outputText("You reach for the enemy's mind, but cannot find anything.  You frantically search around, but there is no consciousness as you know it in the room.\n\n", true);
		changeFatigue(1);
		enemyAI();
		return;
	}
	menuLoc = 0;
	fatigue(20,1);
	//Inflicts fear and reduces enemy SPD.
	outputText("The world goes dark, an inky shadow blanketing everything in sight as you fill " + monster.a + monster.short + "'s mind with visions of otherworldly terror that defy description.");
	//(succeed)
	if(player.inte/10 + rand(20) + 1 > monster.inte/10 + 10) {
		outputText("  They cower in horror as they succumb to your illusion, believing themselves beset by eldritch horrors beyond their wildest nightmares.\n\n");
		monster.createStatusAffect("Fear",1,0,0,0);
		monster.spe -= 5;
		if(monster.spe < 1) monster.spe = 1;
	}
	else outputText("  The dark fog recedes as quickly as it rolled in as they push back your illusions, resisting your hypnotic influence.\n\n");
	enemyAI();
	return;
}

//Illusion
function kitsuneIllusion():void {
	clearOutput();
	//Fatigue Cost: 25
	if(player.hasPerk("Blood Mage") < 0 && player.fatigue + spellCost(25) > 100) {
		outputText("You are too tired to use this ability.", true);
		doNext(5160);
		return;
	}
	if(player.hasStatusAffect("Throat Punch") >= 0 || player.hasStatusAffect("Web-Silence") >= 0) {
		outputText("You cannot focus to use this ability while you're having so much difficult breathing.", true);
		doNext(5160);
		return;
	}
	if(monster.short == "pod" || monster.inte == 0) {
		outputText("In the tight confines of this pod, there's no use making such an attack!\n\n", true);
		changeFatigue(1);
		enemyAI();
		return;
	}
	menuLoc = 0;
	fatigue(25,1);
	if(monster.hasStatusAffect("Shell") >= 0) {
		outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
		enemyAI();
		return;
	}
	//Decrease enemy hit chance and increase their susceptibility to lust attacks.
	outputText("The world begins to twist and distort around you as reality bends to your will, " + monster.a + monster.short + "'s mind blanketed in the thick fog of your illusions.");
	//(succeed)
	if(player.inte/10 + rand(20) + 1 > monster.inte/10 + 10) {
		outputText("  They stumble humorously to and fro, unable to keep pace with the shifting illusions that cloud their perceptions.\n\n");
		monster.spe -= 20;
		if(monster.spe < -50) monster.spe = -20;
		if(monster.lustVuln >= 1.1) monster.lustVuln += .1;
	}
	else outputText("  Like the snapping of a rubber band, reality falls back into its rightful place as they resist your illusory conjurations.\n\n");
	enemyAI();
	return;
}


//special attack: tail whip? could unlock button for use by dagrons too
//tiny damage and lower monster armor by ~75% for one turn
//hit
function tailWhipAttack():void {
	clearOutput();
	//miss
	if((player.hasStatusAffect("Blind") >= 0 && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80)) {
		outputText("Twirling like a top, you swing your tail, but connect with only empty air.");
	}
	else {
		if(!monster.plural) outputText("Twirling like a top, you bat your opponent with your tail.  For a moment, " + monster.pronoun1 + " looks disbelieving, as if " + monster.pronoun3 + " world turned upside down, but " + monster.pronoun1 + " soon becomes irate and redoubles " + monster.pronoun3 + " offense, leaving large holes in " + monster.pronoun3 + " guard.  If you're going to take advantage, it had better be right away; " + monster.pronoun1 + "'ll probably cool off very quickly.");
		else outputText("Twirling like a top, you bat your opponent with your tail.  For a moment, " + monster.pronoun1 + " look disbelieving, as if " + monster.pronoun3 + " world turned upside down, but " + monster.pronoun1 + " soon become irate and redouble " + monster.pronoun3 + " offense, leaving large holes in " + monster.pronoun3 + " guard.  If you're going to take advantage, it had better be right away; " + monster.pronoun1 + "'ll probably cool off very quickly.");
		if(monster.hasStatusAffect("Coon Whip") < 0) monster.createStatusAffect("Coon Whip",0,0,0,0);
		temp = Math.round(monster.armorDef * .75);
		while(temp > 0 && monster.armorDef >= 1) {
			monster.armorDef--;
			monster.addStatusValue("Coon Whip",1,1);
			temp--;
		}
		monster.addStatusValue("Coon Whip",2,2);
		if(player.tailType == 15) monster.addStatusValue("Coon Whip",2,2);
	}
	outputText("\n\n");
	enemyAI();
}

//Arian's stuff
//Using the Talisman in combat
function immolationSpell():void {
	clearOutput();
	outputText("You gather energy in your Talisman and unleash the spell contained within.  A wave of burning flames gathers around " + monster.a + monster.short + ", slowly burning " + monster.pronoun2 + ".");
	var temp:int = int(75+(player.inte/3 + rand(player.inte/2)) * spellMod());
	temp = doDamage(temp);
	outputText(" (" + temp + ")\n\n");
	player.removeStatusAffect("Immolation Spell");
	clearTalisman();
	enemyAI();
}

function shieldingSpell():void {
	clearOutput();
	outputText("You gather energy in your Talisman and unleash the spell contained within.  A barrier of light engulfs you, before turning completely transparent.  Your defense has been increased.\n\n");
	player.createStatusAffect("Shielding",0,0,0,0);
	player.removeStatusAffect("Shielding Spell");
	clearTalisman();
	enemyAI();
}