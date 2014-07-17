/*
	var CMdelta:Number = modCumMultiplier(0.5);

	if (CMdelta > 2)
		outputText("your balls feel a lot denser.</b>", false);
	else if ( CMdelta > 1 )
		outputText("you think your balls feel denser.</b>", false);
	else
		outputText("you think your balls feel a little denser.</b>", false);
 */
public function modCumMultiplier(delta:Number):Number
{
	trace("modCumMultiplier called with: " + delta);
		
	if (delta == 0) {
		trace( "Whoops! modCumMuliplier called with 0... aborting..." );
		return delta;
	}
	else if (delta > 0) {
		trace("and increasing");
		if (player.findPerk(PerkLib.MessyOrgasms) >= 0) {
			trace("and MessyOrgasms found");
			delta *= 1.5
		}
	}
	else if (delta < 0) {
		trace("and decreasing");
		if (player.findPerk(PerkLib.MessyOrgasms) >= 0) {
			trace("and MessyOrgasms found");
			delta *= 0.5
		}
	}

	trace("and modifying by " + delta);
	player.cumMultiplier += delta;
	return delta;
}

public function increaseCock(player:Player, cockNum:Number, lengthDelta:Number):Number
{
	var bigCock:Boolean = false;
	var bigCockVal1:Number = 0;
	
	if (player.findPerk(PerkLib.BigCock) >= 0) {
		bigCock = true;
		bigCockVal1 = player.perk(player.findPerk(PerkLib.BigCock)).value1;
	}

	return player.cocks[cockNum].growCock(lengthDelta, bigCock, bigCockVal1);
}