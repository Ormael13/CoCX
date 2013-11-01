function cuntChange(cArea:Number, display:Boolean, spacingsF:Boolean = false, spacingsB:Boolean = true):Boolean {
	if(player.vaginas.length == 0) return false;
	var stretched:Boolean = false;
	var devirgined:Boolean = false;
	if(player.hasPerk("Fera's Boon - Milking Twat") < 0 || player.vaginas[0].vaginalLooseness <= 1) {
	//cArea > capacity = autostreeeeetch.
	if(cArea >= player.vaginalCapacity()) {
		if(player.vaginas[0].vaginalLooseness >= 5) {}
		else player.vaginas[0].vaginalLooseness++;
		stretched = true;
	}
	//If within top 10% of capacity, 50% stretch
	else if(cArea >= .9 * player.vaginalCapacity() && rand(2) == 0) {
		player.vaginas[0].vaginalLooseness++;
		stretched = true;
	}
	//if within 75th to 90th percentile, 25% stretch
	else if(cArea >= .75 * player.vaginalCapacity() && rand(4) == 0) {
		player.vaginas[0].vaginalLooseness++;
		stretched = true;
		}
	}
	//If virgin
	if(player.vaginas[0].virgin) {
		if(spacingsF) outputText("  ", false);
		outputText("<b>Your hymen is torn, robbing you of your virginity.</b>", false);
		if(spacingsB) outputText("  ", false);
		player.vaginas[0].virgin = false;
		devirgined = true;
	}
	//Delay anti-stretching
	if(cArea >= .5 * player.vaginalCapacity()) {
		//Cunt Stretched used to determine how long since last enlargement
		if(player.hasStatusAffect("CuntStretched") < 0) player.createStatusAffect("CuntStretched",0,0,0,0);
		//Reset the timer on it to 0 when restretched.
		else player.changeStatusValue("CuntStretched",1,0);
	}
	if(stretched) {
		trace("CUNT STRETCHED TO " + (player.vaginas[0].vaginalLooseness) + ".");
		//STRETCH SUCCESSFUL - begin flavor text if outputting it!
		if(display) {
			//Virgins get different formatting
			if(devirgined) {
				//If no spaces after virgin loss
				if(!spacingsB) outputText("  ", false);
			}
			//Non virgins as usual
			else if(spacingsF) outputText("  ", false);
			if(player.vaginas[0].vaginalLooseness == 5) outputText("<b>Your " + vaginaDescript(0) + " is stretched painfully wide, large enough to accomodate most beasts and demons.</b>", false);
			if(player.vaginas[0].vaginalLooseness == 4) outputText("<b>Your " + vaginaDescript(0) + " is stretched so wide that it gapes continually.</b>", false);
			if(player.vaginas[0].vaginalLooseness == 3) outputText("<b>Your " + vaginaDescript(0) + " painfully stretches, the lips now wide enough to gape slightly.</b>", false);
			if(player.vaginas[0].vaginalLooseness == 2) outputText("<b>Your " + vaginaDescript(0) + " is now very loose.</b>", false);
			if(player.vaginas[0].vaginalLooseness == 1) outputText("<b>Your " + vaginaDescript(0) + " is now a little loose.</b>", false);
			if(player.vaginas[0].vaginalLooseness == 0) outputText("<b>Your " + vaginaDescript(0) + " is stretched out to a more normal size.</b>", false);
			if(spacingsB) outputText("  ", false);
		}
	}
	return stretched;
}
function buttChange(cArea:Number, display:Boolean, spacingsF:Boolean = true, spacingsB:Boolean = true):Boolean {
	var stretched:Boolean = false;
	//cArea > capacity = autostreeeeetch half the time.
	if(cArea >= player.analCapacity() && rand(2) == 0) {
		if(player.ass.analLooseness >= 5) {}
		else player.ass.analLooseness++;
		stretched = true;
		//Reset butt stretchin recovery time
		if(player.hasStatusAffect("ButtStretched") >= 0) player.changeStatusValue("ButtStretched",1,0);
	}
	//If within top 10% of capacity, 25% stretch
	if(cArea < player.analCapacity() && cArea >= .9*player.analCapacity() && rand(4) == 0) {
		player.ass.analLooseness++;
		stretched = true;
	}
	//if within 75th to 90th percentile, 10% stretch
	if(cArea < .9 * player.analCapacity() && cArea >= .75 * player.analCapacity() && rand(10) == 0) {
		player.ass.analLooseness++;
		stretched = true;
	}
	//Anti-virgin
	if(player.ass.analLooseness == 0) {
		player.ass.analLooseness++;
		stretched = true;
	}
	//Delay un-stretching
	if(cArea >= .5 * player.analCapacity()) {
		//Butt Stretched used to determine how long since last enlargement
		if(player.hasStatusAffect("ButtStretched") < 0) player.createStatusAffect("ButtStretched",0,0,0,0);
		//Reset the timer on it to 0 when restretched.
		else player.changeStatusValue("ButtStretched",1,0);
	}
	if(stretched) {
		trace("BUTT STRETCHED TO " + (player.ass.analLooseness) + ".");
		//STRETCH SUCCESSFUL - begin flavor text if outputting it!
		if(display) {
			if(spacingsF) outputText("  ", false);
			if(player.ass.analLooseness == 5) outputText("<b>Your " + assholeDescript() + " is stretched even wider, capable of taking even the largest of demons and beasts.</b>", false);
			if(player.ass.analLooseness == 4) outputText("<b>Your " + assholeDescript() + " becomes so stretched that it gapes continually.</b>", false);
			if(player.ass.analLooseness == 3) outputText("<b>Your " + assholeDescript() + " is now very loose.</b>", false);
			if(player.ass.analLooseness == 2) outputText("<b>Your " + assholeDescript() + " is now a little loose.</b>", false);
			if(player.ass.analLooseness == 1) outputText("<b>You have lost your anal virginity.</b>", false);
			if(spacingsB) outputText("  ", false);
		}
	}
	return stretched;
}



//Updates the player's gender
function genderCheck():void {
	if(player.cocks.length > 0) {
		if(player.vaginas.length > 0) player.gender = 3;
		else player.gender = 1;
	}
	else {
		if(player.vaginas.length > 0) player.gender = 2;
		else player.gender = 0;
	}
	//Fertility fixing
	if(player.hasVagina() && player.fertility < 1) player.fertility = 1;
}

//Many transformations are part of items, see items.as
function growTits(amount:Number, rowsGrown:Number, display:Boolean, growthType:Number) {
	if(player.breastRows.length == 0) return;
	//GrowthType 1 = smallest grows
	//GrowthType 2 = Top Row working downward
	//GrowthType 3 = Only top row
	var temp2:Number = 0;
	var temp3:Number = 0;
	//Chance for "big tits" perked characters to grow larger!
	if(player.hasPerk("Big Tits") >= 0 && rand(3) == 0 && amount < 1) amount=1;
	temp = player.breastRows.length;
	if(growthType == 1) {
		//Select smallest breast, grow it, move on
		while(rowsGrown > 0) {
			//Temp = counter
			temp = player.breastRows.length;
			//Temp2 = smallest tits index
			temp2 = 0;
			//Find smallest row
			while(temp > 0) {
				temp--;
				if(player.breastRows[temp].breastRating < player.breastRows[temp2].breastRating) temp2 = temp;
			}
			//Temp 3 tracks total amount grown
			temp3 += amount;
			trace("Breastrow chosen for growth: " + String(temp2) + ".");
			//Reuse temp to store growth amount for diminishing returns.
			temp = amount;
			//Diminishing returns!
			if(player.breastRows[temp2].breastRating > 3) {
				if(player.hasPerk("Big Tits") < 0) temp/=1.5;
				else temp/=1.3;
			}
			if(player.breastRows[temp2].breastRating > 7) { 
				if(player.hasPerk("Big Tits") < 0) temp/=2;
				else temp /= 1.5;
			}
			if(player.breastRows[temp2].breastRating > 9) { 
				if(player.hasPerk("Big Tits") < 0) temp/=2;
				else temp /= 1.5;
			}
			if(player.breastRows[temp2].breastRating > 12) { 
				if(player.hasPerk("Big Tits") < 0) temp/=2;
				else temp /= 1.5;
			}
			//Grow!
			player.breastRows[temp2].breastRating += temp;
			rowsGrown--;
		}
	}
	//Diminishing returns!
	if(player.breastRows[0].breastRating > 3) {
		if(player.hasPerk("Big Tits") < 0) amount/=1.5;
		else amount/=1.3;
	}
	if(player.breastRows[0].breastRating > 7) { 
		if(player.hasPerk("Big Tits") < 0) amount/=2;
		else amount /= 1.5;
	}
	if(player.breastRows[0].breastRating > 12) { 
		if(player.hasPerk("Big Tits") < 0) amount/=2;
		else amount /= 1.5;
	}
	/*if(player.breastRows[0].breastRating > 12) { 
		if(player.hasPerk("Big Tits") < 0) amount/=2;
		else amount /= 1.5;
	}*/
	if(growthType == 2) {
		temp = 0;
		temp2 = 0;
		//Start at top and keep growing down, back to top if hit bottom before done.
		while(rowsGrown > 0) {
			if(temp+1 > player.breastRows.length) temp = 0;
			player.breastRows[temp].breastRating += amount;
			trace("Breasts increased by " + amount + " on row " + temp);
			temp++;
			temp3 += amount;
			rowsGrown--;
		}
	}
	if(growthType == 3) {
		while(rowsGrown > 0) {
			rowsGrown--;
			player.breastRows[0].breastRating += amount;
			temp3 += amount;
		}
	}
	//Breast Growth Finished...talk about changes.
	if(display) {
		if(growthType < 3) {
			if(amount <= 2) {
				if(player.breastRows.length > 1) outputText("Your rows of " + breastDescript(0) + " jiggle with added weight, growing a bit larger.", false); 
				if(player.breastRows.length == 1) outputText("Your " + breastDescript(0) + " jiggle with added weight as they expand, growing a bit larger.", false);
			}
			if(amount > 2 && amount <= 4) {
				if(player.breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your rows of " + breastDescript(0) + " expand significantly.", false);
				if(player.breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.", false);
			}
			if(amount > 4) {
				if(player.breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your " + breastDescript(0) + " tingle strongly, growing disturbingly large.", false);
				if(player.breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.", false);
			}
			if(player.biggestTitSize() >= 8.5 && player.nippleLength < 2) {
				outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
				player.nippleLength = 2;
			}
			if(player.biggestTitSize() >= 7 && player.nippleLength < 1) {
				outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
				player.nippleLength = 1;
			}
			if(player.biggestTitSize() >= 5 && player.nippleLength < .75) {
				outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
				player.nippleLength = .75;
			}
			if(player.biggestTitSize() >= 3 && player.nippleLength < .5) {
				outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
				player.nippleLength = .5;
			}
		}
		else
		{
			if(amount <= 2) {
				if(player.breastRows.length > 1) outputText("Your top row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.", false);
				if(player.breastRows.length == 1) outputText("Your row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.", false);
			}
			if(amount > 2 && amount <= 4) {
				if(player.breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your top row of " + breastDescript(0) + " expand significantly.", false);
				if(player.breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.", false);
			}
			if(amount > 4) {
				if(player.breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your top row of " + breastDescript(0) + " tingle strongly, growing disturbingly large.", false);
				if(player.breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tinglng in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.", false);
			}
			if(player.biggestTitSize() >= 8.5 && player.nippleLength < 2) {
				outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
				player.nippleLength = 2;
			}
			if(player.biggestTitSize() >= 7 && player.nippleLength < 1) {
				outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
				player.nippleLength = 1;
			}
			if(player.biggestTitSize() >= 5 && player.nippleLength < .75) {
				outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
				player.nippleLength = .75;
			}
			if(player.biggestTitSize() >= 3 && player.nippleLength < .5) {
				outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
				player.nippleLength = .5;
			}
		}
	}
}
				
function shrinkTits():void {
	var temp2:Number = 0;
	var temp3:Number = 0;
	if(player.breastRows.length == 1) {
		//Shrink if bigger than N/A cups
		if(player.breastRows[0].breastRating > 0) {
			temp = 1;
			player.breastRows[0].breastRating--;
			//Shrink again 50% chance
			if(player.breastRows[0].breastRating >= 1 && rand(2) == 0 && player.hasPerk("Big Tits") < 0) {
				temp++;
				player.breastRows[0].breastRating--;
			}
			if(player.breastRows[0].breastRating < 0) player.breastRows[0].breastRating = 0;
			//Talk about shrinkage
			if(temp == 1) outputText("\n\nYou feel a weight lifted from you, and realize your breasts have shrunk!  With a quick measure, you determine they're now " + player.breastCup(0) + "s.", false);
			if(temp == 2) outputText("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are much smaller!  With a quick measure, you determine they're now " + player.breastCup(0) + "s.", false);
		}
	}
	//multiple
	if(player.breastRows.length > 1) {
		outputText("\n", false);
		//temp2 = amount changed
		//temp3 = counter
		temp = 0;
		temp2 = 0;
		temp3 = player.breastRows.length;
		while(temp3 > 0) {
			temp3--;
			if(player.breastRows[temp3].breastRating > 0) {
				player.breastRows[temp3].breastRating--;
				if(player.breastRows[temp3].breastRating < 0) player.breastRows[temp3].breastRating = 0;
				temp2++;
				outputText("\n", false);
				if(temp3 < player.breastRows.length - 1) outputText("...and y", false);
				else outputText("Y", false);
				outputText("our " + breastDescript(temp3) + " shrink, dropping to " + player.breastCup(temp3) + "s.", false);
			}
			if(player.breastRows[temp3].breastRating < 0) player.breastRows[temp3].breastRating = 0;
		}
		if(temp2 == 2) outputText("\nYou feel so much lighter after the change.", false);
		if(temp2 == 3) outputText("\nWithout the extra weight you feel particularly limber.", false);
		if(temp2 >= 4) outputText("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.", false);
	}
}

function lengthChange(temp2:Number, cocks:Number) {
	//DIsplay the degree of length change.
	if(temp2 <= 1 && temp2 > 0) {
		if(player.cocks.length == 1) outputText("Your " + cockDescript(0) + " has grown slightly longer.", false);
		if(player.cocks.length > 1) {
			if(cocks == 1) outputText("One of your " + multiCockDescriptLight() + " grows slightly longer.", false);
			if(cocks > 1 && cocks < player.cocks.length) outputText("Some of your " + multiCockDescriptLight() + " grow slightly longer.", false);
			if(cocks == player.cocks.length) outputText("Your " + multiCockDescriptLight() + " seem to fill up... growing a little bit larger.", false);
		}
	}
	if(temp2 > 1 && temp2 < 3) {
		if(player.cocks.length == 1) outputText("A very pleasurable feeling spreads from your groin as your " + cockDescript(0) + " grows permanently longer - at least an inch - and leaks pre-cum from the pleasure of the change.", false);
		if(player.cocks.length > 1) {
			if(cocks == player.cocks.length) outputText("A very pleasurable feeling spreads from your groin as your " + multiCockDescriptLight() + " grow permanently longer - at least an inch - and leak plenty of pre-cum from the pleasure of the change.", false);
			if(cocks == 1) outputText("A very pleasurable feeling spreads from your groin as one of your " + multiCockDescriptLight() + " grows permanently longer, by at least an inch, and leaks plenty of pre-cum from the pleasure of the change.", false);
			if(cocks > 1 && cocks < player.cocks.length) outputText("A very pleasurable feeling spreads from your groin as " + num2Text(cocks) + " of your " + multiCockDescriptLight() + " grow permanently longer, by at least an inch, and leak plenty of pre-cum from the pleasure of the change.", false);
		}
	}
	if(temp2 >=3){
		if(player.cocks.length == 1) outputText("Your " + cockDescript(0) + " feels incredibly tight as a few more inches of length seem to pour out from your crotch.", false);
		if(player.cocks.length > 1) {
			if(cocks == 1) outputText("Your " + multiCockDescriptLight() + " feel incredibly tight as one of their number begins to grow inch after inch of length.", false);
			if(cocks > 1 && cocks < player.cocks.length) outputText("Your " + multiCockDescriptLight() + " feel incredibly number as " + num2Text(cocks) + " of them begin to grow inch after inch of added length.", false);
			if(cocks == player.cocks.length) outputText("Your " + multiCockDescriptLight() + " feel incredibly tight as inch after inch of length pour out from your groin.", false);
		}
	}
	//Display LengthChange
	if(temp2 > 0) {
		if(player.cocks[0].cockLength >= 8 && player.cocks[0].cockLength-temp2 < 8){
			if(player.cocks.length == 1) outputText("  <b>Most men would be overly proud to have a tool as long as yours.</b>", false);
			if(player.cocks.length > 1) outputText("  <b>Most men would be overly proud to have one cock as long as yours, let alone " + multiCockDescript() + ".</b>", false);
		}	
		if(player.cocks[0].cockLength >= 12 && player.cocks[0].cockLength-temp2 < 12) {
			if(player.cocks.length == 1) outputText("  <b>Your " + cockDescript(0) + " is so long it nearly swings to your knee at its full length.</b>", false);
			if(player.cocks.length > 1) outputText("  <b>Your " + multiCockDescriptLight() + " are so long they nearly reach your knee when at full length.</b>", false);
		}
		if(player.cocks[0].cockLength >= 16 && player.cocks[0].cockLength-temp2 < 16) {
			if(player.cocks.length == 1) outputText("  <b>Your " + cockDescript(0) + " would look more at home on a large horse than you.</b>", false);
			if(player.cocks.length > 1) outputText("  <b>Your " + multiCockDescriptLight() + " would look more at home on a large horse than on your body.</b>", false);
			if(player.gender == 3){
				if(player.cocks.length == 1) outputText("  You could easily stuff your " + cockDescript(0) + " between your breasts and give the self-titty-fuck of a lifetime.", false);
				if(player.cocks.length > 1) outputText("  They reach so far up your chest it would be easy to stuff a few cocks between your breasts and give yourself the tittyfuck of a lifetime.", false);
			}
			if(player.gender == 1){
				if(player.cocks.length == 1) outputText("  Your " + cockDescript(0) + " is so long it easily reaches your chest.  The possibility of autofellatio is now a foregone conclusion.", false);
				if(player.cocks.length > 1) outputText("  Your " + multiCockDescriptLight() + " are so long they easily reach your chest.  Autofellatio would be about as hard as looking down.", false);
			}
		}
		if(player.cocks[0].cockLength >= 20 && player.cocks[0].cockLength-temp2 < 20) {
			if(player.cocks.length == 1) outputText("  <b>As if the pulsing heat of your " + cockDescript(0) + " wasn't enough, the tip of your " + cockDescript(0) + " keeps poking its way into your view every time you get hard.</b>", false);
			if(player.cocks.length > 1) outputText("  <b>As if the pulsing heat of your " + multiCockDescriptLight() + " wasn't bad enough, every time you get hard, the tips of your " + multiCockDescriptLight() + " wave before you, obscuring the lower portions of your vision.</b>", false);
			if(player.cor > 40 && player.cor <= 60) {
				if(player.cocks.length > 1) outputText("  You wonder if there is a demon or beast out there that could take the full length of one of your " + multiCockDescriptLight() + "?", false);
				if(player.cocks.length ==1) outputText("  You wonder if there is a demon or beast out there that could handle your full length.", false);
			}
			if(player.cor > 60 && player.cor <= 80) {
				if(player.cocks.length > 1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your " + multiCockDescriptLight() + " to their hilts, milking you dry.\n\nYou smile at the pleasant thought.", false);
				if(player.cocks.length ==1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your " + cockDescript(0) + " to the hilt, milking it of all your cum.\n\nYou smile at the pleasant thought.", false);
			}
			if(player.cor > 80) {
				if(player.cocks.length > 1) outputText("  You find yourself fantasizing about impaling nubile young champions on your " + multiCockDescriptLight() + " in a year's time.", false);
			}
		}
	}
	//Display the degree of length loss.
	if(temp2 < 0 && temp2 >= -1) {
		if(player.cocks.length == 1) outputText("Your " + multiCockDescriptLight() + " has shrunk to a slightly shorter length.", false);
		if(player.cocks.length > 1) {
			if(cocks == player.cocks.length) outputText("Your " + multiCockDescriptLight() + " have shrunk to a slightly shorter length.", false);
			if(cocks > 1 && cocks < player.cocks.length) outputText("You feel " + num2Text(cocks) + " of your " + multiCockDescriptLight() + " have shrunk to a slightly shorter length.", false);
			if(cocks == 1) outputText("You feel " + num2Text(cocks) + " of your " + multiCockDescriptLight() + " has shrunk to a slightly shorter length.", false);
		}
	}
	if(temp2 < -1 && temp2 > -3) {
		if(player.cocks.length == 1) outputText("Your " + multiCockDescriptLight() + " shrinks smaller, flesh vanishing into your groin.", false);
		if(player.cocks.length > 1) {
			if(cocks == player.cocks.length) outputText("Your " + multiCockDescriptLight() + " shrink smaller, the flesh vanishing into your groin.", false);
			if(cocks == 1) outputText("You feel " + num2Text(cocks) + " of your " + multiCockDescriptLight() + " shrink smaller, the flesh vanishing into your groin.", false);
			if(cocks > 1 && cocks < player.cocks.length) outputText("You feel " + num2Text(cocks) + " of your " + multiCockDescriptLight() + " shrink smaller, the flesh vanishing into your groin.", false);
		}
	}
	if(temp2 <= -3) {
		if(player.cocks.length == 1) outputText("A large portion of your " + multiCockDescriptLight() + "'s length shrinks and vanishes.", false);
		if(player.cocks.length > 1) {
			if(cocks == player.cocks.length) outputText("A large portion of your " + multiCockDescriptLight() + " receeds towards your groin, receding rapidly in length.", false);
			if(cocks == 1) outputText("A single member of your " + multiCockDescriptLight() + " vanishes into your groin, receding rapidly in length.", false);
			if(cocks > 1 && player.cocks.length > cocks) outputText("Your " + multiCockDescriptLight() + " tingles as " + num2Text(cocks) + " of your members vanish into your groin, receding rapidly in length.", false);
		}
	}
}

function demonChanges():void {
	//Change tail if already horned.
	if(player.tailType != 3 && player.horns > 0) {
		if(player.tailType != 0) {
			outputText("\n\n", false);
			if(player.tailType == 5 || player.tailType == 6) outputText("You feel a tingling in your insectile abdomen as it stretches, narrowing, the exoskeleton flaking off as it transforms into a flexible demon-tail, complete with a round spaded tip.  ", false);
			else outputText("You feel a tingling in your tail.  You are amazed to discover it has shifted into a flexible demon-tail, complete with a round spaded tip.  ", false);
			outputText("<b>Your tail is now demonic in appearance.</b>", false);
		}
		else outputText("\n\nA pain builds in your backside... growing more and more pronounced.  The pressure suddenly disappears with a loud ripping and tearing noise.  <b>You realize you now have a demon tail</b>... complete with a cute little spade.", false);
		stats(0, 0, 0, 0, 0, 0, 0, 4);
		player.tailType = 3;	
	}
	//grow horns!
	if(player.horns == 0 || (rand(player.horns+3) == 0)) {
		if(player.horns < 12 && (player.hornType == 0 || player.hornType == 1)) {
			outputText("\n\n", false);
			if(player.horns == 0) {
				outputText("A small pair of demon horns erupts from your forehead.  They actually look kind of cute.  <b>You have horns!</b>", false);
			}
			else outputText("Another pair of demon horns, larger than the last, forms behind the first row.", false);
			if(player.hornType == 0) player.hornType = 1;
			player.horns++;
			player.horns++;
			stats(0, 0, 0, 0, 0, 0, 0, 3);
		}
		//Text for shifting horns
		else if(player.hornType > 1) {
			outputText("\n\n", false);
			outputText("Your horns shift, shrinking into two small demonic-looking horns.", false);
			player.horns = 2;
			player.hornType = 1;
			stats(0, 0, 0, 0, 0, 0, 0, 3);
		}		
	}
	//Nipples Turn Back:
	if(player.hasStatusAffect("Black Nipples") >= 0 && rand(3) == 0) {
		outputText("\n\nSomething invisible brushes against your " + nippleDescript(0) + ", making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned back to their natural flesh colour.");
		player.removeStatusAffect("Black Nipples");
	}
	//remove fur
	if((player.faceType != 0 || player.skinType != 0) && rand(3) == 0) {
		//Remove face before fur!
		if(player.faceType != 0) {
			outputText("\n\n", false);
			outputText("Your visage twists painfully, returning to a more normal human shape, albeit with flawless skin.  <b>Your face is human again!</b>", false);
			player.faceType = 0;
		}
		//De-fur
		else if(player.skinType != 0) {
			outputText("\n\n", false);
			if(player.skinType == 1) outputText("Your skin suddenly feels itchy as your fur begins falling out in clumps, <b>revealing inhumanly smooth skin</b> underneath.", false);
			if(player.skinType == 2) outputText("Your scales begin to itch as they begin falling out in droves, <b>revealing your inhumanly smooth " + player.skinTone + " skin</b> underneath.", false);
			player.skinType = 0;
			player.skinDesc = "skin";
		}
	}
	//Demon tongue
	if(player.tongueType == 1 && rand(3) == 0) {
		outputText("\n\nYour snake-like tongue tingles, thickening in your mouth until it feels more like your old human tongue, at least for the first few inches.  It bunches up inside you, and when you open up your mouth to release it, roughly two feet of tongue dangles out.  You find it easy to move and control, as natural as walking.  <b>You now have a long demon-tongue.</b>", false);
		player.tongueType = 2;
	}
	//foot changes - requires furless
	if(player.skinType == 0 && rand(4) == 0) {
		//Males/genderless get clawed feet
		if(player.gender <= 1) {
			if(player.lowerBody != 6) {
				outputText("\n\n", false);
				outputText("Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your " + player.feet() + ". Something hard breaks through your sole from the inside out as your toes splinter and curve cruelly. The pain slowly diminishes and your eyes look along a human leg that splinters at the foot into a claw with sharp black nails. When you relax, your feet grip the ground easily. <b>Your feet are now formed into demonic claws.</b>", false);
				player.lowerBody = 6;
			}
		}
		//Females/futa get high heels
		else if(player.lowerBody != 5) {
			outputText("\n\n", false);
			outputText("Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your " + player.feet() + ". Something hard breaks through your sole from the inside out. The pain slowly diminishes and your eyes look along a human leg to a thin and sharp horn protruding from the heel. When you relax, your feet are pointing down and their old posture is only possible with an enormous effort. <b>Your feet are now formed into demonic high-heels.</b> Tentatively you stand up and try to take a few steps. To your surprise you feel as if you were born with this and stride vigorously forward, hips swaying.", false);	
			player.lowerBody = 5;
		}
	}
	//Grow demon wings
	if(player.wingType != 7 && rand(8) == 0 && player.cor >= 50) {
		//grow smalls to large
		if(player.wingType == 6 && player.cor >= 75) {
			outputText("\n\n", false);
			outputText("Your small demonic wings stretch and grow, tingling with the pleasure of being attached to such a tainted body.  You stretch over your shoulder to stroke them as they unfurl, turning into full-sized demon-wings.  <b>Your demonic wings have grown!</b>", false);
			player.wingType = 7;
			player.wingDesc = "large, bat-like";
		}
		else if(player.wingType == 8) {
			outputText("\n\n", false);
			outputText("The muscles around your shoulders bunch up uncomfortably, changing to support the new bat-like wings growing from your back.  You twist your head as far as you can for a look and realize your fin has changed into ", false);
			outputText("small ", false);
			player.wingType = 6;
			player.wingDesc = "tiny, bat-like";
			outputText("bat-like demon-wings!", false);
		}
		else if(player.wingType == 1 || player.wingType == 2) {
			outputText("\n\n", false);
			outputText("The muscles around your shoulders bunch up uncomfortably, changing to support your wings as you feel their weight increasing.  You twist your head as far as you can for a look and realize they've changed into ", false);
			if(player.wingType == 1) {
				outputText("small ", false);
				player.wingType = 6;
				player.wingDesc = "tiny, bat-like";
			}
			else {
				outputText("large ", false);
				player.wingType = 7;
				player.wingDesc = "large, bat-like";
			}
			outputText("<b>bat-like demon-wings!</b>", false);
		}
		//No wings
		else if(player.wingType == 0) {
			outputText("\n\n", false);
			outputText("A knot of pain forms in your shoulders as they tense up.  With a surprising force, a pair of small demonic wings sprout from your back, ripping a pair of holes in the back of your " + player.armorName + ".  <b>You now have tiny demonic wings</b>.", false);
			player.wingType = 6;
			player.wingDesc = "tiny, bat-like";
		}
		
	}
}

function killCocks(deadCock):void {
	//Count removal for text bits
	var removed:Number = 0;
	//Holds cock index
	var storedCock:Number = 0;
	//Less than 0 = PURGE ALL
	if(deadCock < 0) {
		deadCock = player.cocks.length;
	}
	//Double loop - outermost counts down cocks to remove, innermost counts down 
	while(deadCock > 0) {
		//Find shortest cock and prune it
		temp = player.cocks.length;
		while(temp > 0) {
			temp--;
			//If anything is out of bounds set to 0.
			if(storedCock > player.cocks.length-1) storedCock = 0;
			//If temp index is shorter than stored index, store temp to stored index.
			if(player.cocks[temp].cockLength <= player.cocks[storedCock].cockLength) storedCock = temp;
		}
		//Smallest cock should be selected, now remove it!
		player.removeCock(storedCock, 1);
		removed++;
		deadCock--;
		if(player.cocks.length == 0) deadCock = 0;
	}
	//Texts
	if(removed == 1) {
		if(player.cocks.length == 0) {
			outputText("<b>Your manhood shrinks into your body, disappearing completely.</b>", false);
			if(player.hasStatusAffect("infested") >= 0) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.", false);
		}
		if(player.cocks.length == 1) {
			outputText("<b>Your smallest penis disappears, shrinking into your body and leaving you with just one " + cockDescript(0) + ".</b>", false);
		}
		if(player.cocks.length > 1) {
			outputText("<b>Your smallest penis disappears forever, leaving you with just your " + multiCockDescriptLight() + ".</b>", false);
		}
	}
	if(removed > 1) {
		if(player.cocks.length == 0) {
			outputText("<b>All your male endowments shrink smaller and smaller, disappearing one at a time.</b>", false);
			if(player.hasStatusAffect("infested") >= 0) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.", false);
		}
		if(player.cocks.length == 1) {
			outputText("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with just your " + cockDescript(0) + ".", false);
		}
		if(player.cocks.length > 1) {
			outputText("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with " + multiCockDescriptLight() + ".", false);
		}
	}
	//remove infestation if cockless
	if(player.cocks.length == 0) player.removeStatusAffect("infested");
	if(player.cocks.length == 0 && player.balls > 0) {
		outputText("  <b>Your " + sackDescript() + " and " + ballsDescriptLight() + " shrink and disappear, vanishing into your groin.</b>", false);
		player.balls = 0;
		player.ballSize = 1;
	}
}
