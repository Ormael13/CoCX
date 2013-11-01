function sackDescript():String {
	if(player.balls == 0) return "prostate";
	var rando:Number = 0;
	var desc:String = "";
	rando = rand(2);
	if(rando == 0) desc += "scrotum";
	if(rando == 1) desc += "sack";
    return desc;
}
function cockClit(number:int = 0):String {
	if(player.hasCock() && number >= 0 && number < player.cockTotal()) return cockDescript(number);
	else return clitDescript();
}
function balls(balls,noballs):String {
	if(player.balls > 0) return balls;
	return noballs;
}
function sheathDesc():String {
	if(player.hasSheath()) return "sheath";
	else return "base";
}
function chestDesc():String {
	if(player.biggestTitSize() < 1) return "chest";
	else return biggestBreastSizeDescript();
}
function allChestDesc():String {
	if(player.biggestTitSize() < 1) return "chest";
	else return allBreastsDescript();
}
function sMultiCockDesc():String {
	var desc:String = "";
	if(player.totalCocks() > 1) desc += "each of ";
	desc += "your " + multiCockSuperLight();
	return desc;
}
function SMultiCockDesc():String {
	var desc:String = "";
	if(player.totalCocks() > 1) desc += "Each of y";
	else desc += "Y";
	desc += "our " + multiCockSuperLight();
	return desc;
}
function oMultiCockDesc():String {
	var desc:String = "";
	if(player.totalCocks() > 1) desc += "one of ";
	desc += "your " + multiCockSuperLight();
	return desc;
}
function OMultiCockDesc():String {
	var desc:String = "";
	if(player.totalCocks() > 1) desc += "One of y";
	else desc += "Y";
	desc += "our " + multiCockSuperLight();
	return desc;
}
function tongueDescript():String {
	if(player.tongueType == 0) return "tongue";
	else if(player.tongueType == 1) return "serpentine tongue";
	else if(player.tongueType == 2) return "draconic tongue";
	else return "demonic tongue";
	
}

function ballsDescriptLight(forcedSize:Boolean = true):String {
	if(player.balls == 0) return "prostate";
	var descripted:int = 0;
	var rando:Number = 0;
	var desc:String = "";
	if(player.hasStatusAffect("Uniball") < 0) {
		if(player.balls == 1) {
			rando = rand(4);
			if(rando == 0) desc += "single ";
			if(rando == 1) desc += "solitary ";
			if(rando == 2) desc += "lone ";
			if(rando == 3) desc += "individual ";
		}
		if(player.balls == 2) {
			rando = rand(3);
			if(rando == 0) desc += "pair of ";
			if(rando == 1) desc += "two ";
			if(rando == 2) desc += "duo of ";
		}
		if(player.balls == 3) {
			rando = rand(3);
			if(rando == 0) desc += "three ";
			if(rando == 1) desc += "triple ";
			if(rando == 2) desc += "trio of ";
		}
		if(player.balls == 4) {
			rando = rand(3);
			if(rando == 0) desc += "quartette of ";
			if(rando == 1) desc += "four ";
			if(rando == 2) desc += "four ";
		}
	}
	//size!
	if(player.ballSize > 1 && (rand(3) <= 1 || forcedSize)) {
		if(descripted > 0) outputText(", ");
		if(player.ballSize > 1 && player.ballSize < 2) desc += "large";
		if(player.ballSize >= 2 && player.ballSize < 3) desc += "baseball-sized";
		if(player.ballSize >= 3 && player.ballSize < 4) desc += "apple-sized";
		if(player.ballSize >= 4 && player.ballSize < 5) desc += "grapefruit-sized";
		if(player.ballSize >= 5 && player.ballSize < 7) desc += "cantaloupe-sized";
		if(player.ballSize >= 7 && player.ballSize < 9) desc += "soccerball-sized";
		if(player.ballSize >= 9 && player.ballSize < 12) desc += "basketball-sized";
		if(player.ballSize >= 12 && player.ballSize < 15) desc += "watermelon-sized";
		if(player.ballSize >= 15 && player.ballSize < 18) desc += "beachball-sized";
		if(player.ballSize >= 18) desc += "hideously swollen and oversized";
		if(player.ballSize > 1) descripted++;
	}
	//UNIBALL
	if(player.hasStatusAffect("Uniball") >= 0) {
		if(descripted > 0) desc += ", ";
		rando == rand(4);
		if(rando == 0) desc += "tightly-compressed";
		else if(rando == 1) desc += "snug";
		else if(rando == 2) desc += "cute";
		else if(rando == 3) desc += "pleasantly squeezed";
		else desc += "compressed-together";
		descripted++;
	}
	//Descriptive
	if(player.hoursSinceCum >= 100 && rand(2) == 0 && !forcedSize) {
		if(descripted > 0) desc += ", ";
		rando = rand(3);
		if(rando == 0) desc += "overflowing";
		else if(rando == 1) desc += "swollen";
		else desc += "cum-engorged";
		descripted++;
	}
	//lusty
	if(player.lust > 90 && !descripted && rand(2) == 0 && !forcedSize) {
		if(descripted > 0) desc += ", ";
		rando = rand(6);
		if(rando == 0) desc += "eager";
		else if(rando == 1) desc += "full";
		else if(rando == 2) desc += "needy";
		else if(rando == 3) desc += "desperate";
		else if(rando == 4) desc += "throbbing";
		else desc += "heated";
		descripted++;
	}
	if(descripted) desc += " ";
	rando = rand(9);
	if(rando < 4) {
		if(player.balls == 4 && rand(2) == 0) desc += "quads";
		else desc += "balls";
	}
	if(rando >= 4 && rando < 6) desc += "testicles";
	if(rando == 6) desc += "testes";
	if(rando == 7) desc += "gonads";
	if(rando == 8) desc += "nuts";
	return desc;
}
function ballDescript():String {
	var descripted:Boolean = false;
	var rando:Number = 0;
	var desc:String = "";
	//size!
	if(player.ballSize > 1 && rand(3) <= 1) {
		if(player.ballSize > 1 && player.ballSize < 2) desc += "large ";
		if(player.ballSize >= 2 && player.ballSize < 3) desc += "baseball-sized ";
		if(player.ballSize >= 3 && player.ballSize < 4) desc += "apple-sized ";
		if(player.ballSize >= 4 && player.ballSize < 5) desc += "grapefruit-sized ";
		if(player.ballSize >= 5 && player.ballSize < 7) desc += "cantaloupe-sized ";
		if(player.ballSize >= 7 && player.ballSize < 9) desc += "soccerball-sized ";
		if(player.ballSize >= 9 && player.ballSize < 12) desc += "basketball-sized ";
		if(player.ballSize >= 12 && player.ballSize < 15) desc += "watermelon-sized ";
		if(player.ballSize >= 15 && player.ballSize < 18) desc += "beachball-sized ";
		if(player.ballSize >= 18) desc += "hideously swollen and oversized ";
	}	
	else {
		//Descriptive
		if(player.hoursSinceCum >= 100 && rand(2) == 0) {
			rando = rand(3);
			if(rando == 0) desc += "overflowing ";
			if(rando == 1) desc += "swollen ";
			if(rando == 2) desc += "cum-engorged ";
			descripted = true;
		}
		//lusty
		if(player.lust > 90 && !descripted && rand(2) == 0) {
			rando = rand(6);
			if(rando == 0) desc += "eager ";
			if(rando == 1) desc += "full ";
			if(rando == 2) desc += "needy ";
			if(rando == 3) desc += "desperate ";
			if(rando == 4) desc += "throbbing ";
			if(rando == 5) desc += "heated ";
			descripted = true;
		}
		if(!descripted && player.skinType == 3) {
			rando = rand(3);
			if(rando == 0) desc += "goopey ";
			if(rando == 1) desc += "gooey ";
			if(rando == 2) desc += "slimy ";
		}
	}
	rando = rand(9);
	if(rando < 4) {
		desc += "ball";
	}
	if(rando >= 4 && rando <= 6) desc += "testicle";
	if(rando == 7) desc += "gonad";
	if(rando == 8) desc += "nut";
	
	return desc;
}

function eBallsDescriptLight():String {
	var descripted:Boolean = false;
	var rando:Number = 0;
	var desc:String = "";
	if(monster.balls == 1) {
		rando = rand(4);
		if(rando == 0) desc += "single ";
		if(rando == 1) desc += "solitary ";
		if(rando == 2) desc += "lone ";
		if(rando == 3) desc += "individual ";
	}
	if(monster.balls == 2) {
		rando = rand(3);
		if(rando == 0) desc += "pair of ";
		if(rando == 1) desc += "two ";
		if(rando == 2) desc += "duo of ";
	}
	if(monster.balls == 3) {
		rando = rand(3);
		if(rando == 0) desc += "three ";
		if(rando == 1) desc += "triple ";
		if(rando == 2) desc += "trio of ";
	}
	if(monster.balls == 4) {
		rando = rand(3);
		if(rando == 0) desc += "quartette of ";
		if(rando == 1) desc += "four ";
		if(rando == 2) desc += "four ";
	}
	//Descriptive
	if(monster.hoursSinceCum >= 48 && rand(2) == 0) {
		rando = rand(3);
		if(rando == 0) desc += "overflowing ";
		if(rando == 1) desc += "swollen ";
		if(rando == 2) desc += "cum-engorged ";
		descripted = true;
	}
	//lusty
	if(monster.lust > 90 && !descripted && rand(2) == 0) {
		rando = rand(7);
		if(rando == 0) desc += "trembling ";
		if(rando == 1) desc += "overflowing ";
		if(rando == 2) desc += "needy ";
		if(rando == 3) desc += "desperate ";
		if(rando == 4) desc += "throbbing ";
		if(rando == 5) desc += "quivering ";
		if(rando == 6) desc += "quaking ";
		descripted = true;
	}
	//size!
	if(monster.ballSize > 1 && !descripted && rand(2) <= 1) {
		if(monster.ballSize > 1 && monster.ballSize < 2) desc += "large ";
		if(monster.ballSize >= 2 && monster.ballSize < 3) desc += "baseball-sized ";
		if(monster.ballSize >= 3 && monster.ballSize < 4) desc += "apple-sized ";
		if(monster.ballSize >= 4 && monster.ballSize < 5) desc += "grapefruit-sized ";
		if(monster.ballSize >= 5 && monster.ballSize < 7) desc += "cantelope-sized ";
		if(monster.ballSize >= 7 && monster.ballSize < 9) desc += "soccerball-sized ";
		if(monster.ballSize >= 9 && monster.ballSize < 12) desc += "basketball-sized ";
		if(monster.ballSize >= 12) desc += "watermelon-sized ";
	}	
	rando = rand(9);
	if(rando < 4) {
		if(monster.balls == 4 && rand(2) == 0) desc += "quads";
		else desc += "balls";
	}
	if(rando >= 4 && rando < 6) desc += "testicles";
	if(rando == 6) desc += "testes";
	if(rando == 7) desc += "gonads";
	if(rando == 8) desc += "nuts";
	return desc;
}
function eBallsDescript():String {
	var descripted:Boolean = false;
	var rando:Number = 0;
	var desc:String = "";
	if(monster.balls == 1) {
		rando = rand(4);
		if(rando == 0) desc += "a single ";
		if(rando == 1) desc += "a solitary ";
		if(rando == 2) desc += "a lone ";
		if(rando == 3) desc += "an individual ";
	}
	if(monster.balls == 2) {
		rando = rand(3);
		if(rando == 0) desc += "a pair of ";
		if(rando == 1) desc += "two ";
		if(rando == 2) desc += "a duo of ";
	}
	if(monster.balls == 3) {
		rando = rand(3);
		if(rando == 0) desc += "three ";
		if(rando == 1) desc += "triple ";
		if(rando == 2) desc += "a trio of ";
	}
	if(monster.balls == 4) {
		rando = rand(3);
		if(rando == 0) desc += "a quartette of ";
		if(rando == 1) desc += "four ";
		if(rando == 2) desc += "four ";
	}
	//Descriptive
	if(monster.hoursSinceCum >= 48 && rand(2) == 0) {
		rando = rand(3);
		if(rando == 0) desc += "over-full ";
		if(rando == 1) desc += "swollen ";
		if(rando == 2) desc += "tender ";
		descripted = true;
	}
	//lusty
	if(monster.lust > 90 && !descripted && rand(2) == 0) {
		rando = rand(7);
		if(rando == 0) desc += "trembling ";
		if(rando == 1) desc += "overflowing ";
		if(rando == 2) desc += "needy ";
		if(rando == 3) desc += "desperate ";
		if(rando == 4) desc += "throbbing ";
		if(rando == 5) desc += "quivering ";
		if(rando == 6) desc += "quaking ";
		descripted = true;
	}
	//size!
	if(monster.ballSize > 1 && !descripted && rand(2) <= 1) {
		if(monster.ballSize > 1 && monster.ballSize < 2) desc += "large ";
		if(monster.ballSize >= 2 && monster.ballSize < 3) desc += "baseball-sized ";
		if(monster.ballSize >= 3 && monster.ballSize < 4) desc += "apple-sized ";
		if(monster.ballSize >= 4 && monster.ballSize < 5) desc += "grapefruit-sized ";
		if(monster.ballSize >= 5 && monster.ballSize < 7) desc += "cantelope-sized ";
		if(monster.ballSize >= 7 && monster.ballSize < 9) desc += "soccerball-sized ";
		if(monster.ballSize >= 9 && monster.ballSize < 12) desc += "basketball-sized ";
		if(monster.ballSize >= 12) desc += "watermelon sized ";
	}	
	rando = rand(9);
	if(rando < 4) {
		if(monster.balls == 4 && rand(2) == 0) desc += "quads";
		else desc += "balls";
	}
	if(rando >= 4 && rando < 6) desc += "testicles";
	if(rando == 6) desc += "testes";
	if(rando == 7) desc += "gonads";
	if(rando == 8) desc += "nuts";
	return desc;
}

function ballsDescript():String {
	var descripted:Boolean = false;
	var rando:Number = 0;
	var desc:String = "";
	if(player.balls == 1) {
		rando = rand(4);
		if(rando == 0) desc += "a single ";
		if(rando == 1) desc += "a solitary ";
		if(rando == 2) desc += "a lone ";
		if(rando == 3) desc += "a individual ";
	}
	if(player.balls == 2) {
		rando = rand(3);
		if(rando == 0) desc += "a pair of ";
		if(rando == 1) desc += "two ";
		if(rando == 2) desc += "a duo of ";
	}
	if(player.balls == 3) {
		rando = rand(3);
		if(rando == 0) desc += "three ";
		if(rando == 1) desc += "triple ";
		if(rando == 2) desc += "a trio of ";
	}
	if(player.balls == 4) {
		rando = rand(3);
		if(rando == 0) desc += "a quartette of ";
		if(rando == 1) desc += "four ";
		if(rando == 2) desc += "four ";
	}
	//Descriptive
	if(player.hoursSinceCum >= 48) {
		rando = rand(3);
		if(rando == 0) desc += "over-full ";
		if(rando == 1) desc += "swollen ";
		if(rando == 2) desc += "tender ";
		descripted = true;
	}
	//lusty
	if(player.lust > 90 && !descripted) {
		rando = rand(7);
		if(rando == 0) desc += "trembling ";
		if(rando == 1) desc += "overflowing ";
		if(rando == 2) desc += "needy ";
		if(rando == 3) desc += "desperate ";
		if(rando == 4) desc += "throbbing ";
		if(rando == 5) desc += "quivering ";
		if(rando == 6) desc += "quaking ";
		descripted = true;
	}
	//size!
	if(player.ballSize > 1 && !descripted && rand(2) <= 1) {
		if(player.ballSize > 1 && player.ballSize < 2) desc += "large ";
		if(player.ballSize >= 2 && player.ballSize < 3) desc += "baseball-sized ";
		if(player.ballSize >= 3 && player.ballSize < 4) desc += "apple-sized ";
		if(player.ballSize >= 4 && player.ballSize < 5) desc += "grapefruit-sized ";
		if(player.ballSize >= 5 && player.ballSize < 7) desc += "cantaloupe-sized ";
		if(player.ballSize >= 7 && player.ballSize < 9) desc += "soccerball-sized ";
		if(player.ballSize >= 9 && player.ballSize < 12) desc += "basketball-sized ";
		if(player.ballSize >= 12 && player.ballSize < 15) desc += "watermelon-sized ";
		if(player.ballSize >= 15 && player.ballSize < 18) desc += "beachball-sized ";
		if(player.ballSize >= 18) desc += "hideously swollen and oversized ";
	}	
	rando = rand(9);
	if(rando < 4) {
		if(player.balls == 4 && rand(2) == 0) desc += "quads";
		else desc += "balls";
	}
	if(rando >= 4 && rando < 6) desc += "testicles";
	if(rando == 6) desc += "testes";
	if(rando == 7) desc += "gonads";
	if(rando == 8) desc += "nuts";
	if(player.hasStatusAffect("Uniball") >= 0 && rand(2) == 0) {
		if(rand(3) == 0) desc += " merged into a cute, spherical package";
		else if(rand(2) == 0) desc += " combined into a round, girlish shape";
		else desc += " squeezed together into a perky, rounded form";
	}
	return desc;
}
function simpleBallsDescript():String {
	var descripted:Boolean = false;
	var rando:Number = 0;
	var desc:String = "";
	if(player.balls == 1) {
		rando = rand(4);
		if(rando == 0) desc += "single ";
		if(rando == 1) desc += "solitary ";
		if(rando == 2) desc += "lone ";
		if(rando == 3) desc += "individual ";
	}
	if(player.balls == 2) {
		rando = rand(3);
		if(rando == 0) desc += "pair of ";
		if(rando == 1) desc += "two ";
		if(rando == 2) desc += "duo of ";
	}
	if(player.balls == 3) {
		rando = rand(3);
		if(rando == 0) desc += "three ";
		if(rando == 1) desc += "triple ";
		if(rando == 2) desc += "trio of ";
	}
	if(player.balls == 4) {
		rando = rand(3);
		if(rando == 0) desc += "quartette of ";
		if(rando == 1) desc += "four ";
		if(rando == 2) desc += "four ";
	}
	//Descriptive
	if(player.hoursSinceCum >= 48) {
		rando = rand(3);
		if(rando == 0) desc += "overflowing ";
		if(rando == 1) desc += "swollen ";
		if(rando == 2) desc += "cum-engorged ";
		descripted = true;
	}
	//lusty
	if(player.lust > 90 && !descripted) {
		rando = rand(7);
		if(rando == 0) desc += "trembling ";
		if(rando == 1) desc += "overflowing ";
		if(rando == 2) desc += "needy ";
		if(rando == 3) desc += "desperate ";
		if(rando == 4) desc += "throbbing ";
		if(rando == 5) desc += "quivering ";
		if(rando == 6) desc += "quaking ";
		descripted = true;
	}
	//size!
	if(player.ballSize > 1 && !descripted && rand(2) <= 1) {
		if(player.ballSize > 1 && player.ballSize < 2) desc += "large ";
		if(player.ballSize >= 2 && player.ballSize < 3) desc += "baseball-sized ";
		if(player.ballSize >= 3 && player.ballSize < 4) desc += "apple-sized ";
		if(player.ballSize >= 4 && player.ballSize < 5) desc += "grapefruit-sized ";
		if(player.ballSize >= 5 && player.ballSize < 7) desc += "cantaloupe-sized ";
		if(player.ballSize >= 7 && player.ballSize < 9) desc += "soccerball-sized ";
		if(player.ballSize >= 9 && player.ballSize < 12) desc += "basketball-sized ";
		if(player.ballSize >= 12 && player.ballSize < 15) desc += "watermelon-sized ";
		if(player.ballSize >= 15 && player.ballSize < 18) desc += "beachball-sized ";
		if(player.ballSize >= 18) desc += "hideously swollen and oversized ";
	}	

	rando = rand(9);
	if(rando < 4) {
		if(player.balls == 4 && rand(2) == 0) desc += "quads";
		else desc += "balls";
	}
	if(rando >= 4 && rando < 6) desc += "testicles";
	if(rando == 6) desc += "testes";
	if(rando == 7) desc += "gonads";
	if(rando == 8) desc += "nuts";
	
	return desc;
}

function assholeDescript():String {
	var desc:String = "";
	var rando:Number = 0;
	var descripted:Boolean = false;
	//66% wetness description
	if(rand(3) <= 1) {
		if(player.ass.analWetness == 2) desc += "moist ";
		if(player.ass.analWetness == 3) desc += "slimy ";
		if(player.ass.analWetness == 4) desc += "drooling ";
		if(player.ass.analWetness == 5) desc += "slime-drooling ";
	}
	//25% tightness desc
	if(rand(4) == 0 || (player.ass.analLooseness <= 1 && rand(4) <= 2)) {
		if(player.ass.analLooseness == 0) desc += "virgin ";
		if(player.ass.analLooseness == 1) desc += "tight ";
		if(player.ass.analLooseness == 2) desc += "";
		if(player.ass.analLooseness == 3) desc += "loose ";
		if(player.ass.analLooseness == 4) desc += "stretched ";
		if(player.ass.analLooseness == 5) desc += "gaping ";
	}
	//But descriptor
	rando = rand(13);
	if(rando <= 2) desc += "ass";
	if(rando > 2 && rando <= 5) desc += "anus";
	if(rando > 5 && rando <= 7) desc += "pucker";
	if(rando > 7 && rando <= 10) desc += "asshole";
	if(rando == 11) desc += "bum";
	if(rando == 12) desc += "butthole";
	return desc;
}
function eAssholeDescript():String {
	var desc:String = "";
	var rando:Number = 0;
	var descripted:Boolean = false;
	//66% wetness description
	if(rand(3) <= 1) {
		if(monster.ass.analWetness == 2) desc += "moist ";
		if(monster.ass.analWetness == 3) desc += "slimy ";
		if(monster.ass.analWetness == 4) desc += "drooling ";
		if(monster.ass.analWetness == 5) desc += "slime-drooling ";
	}
	//25% tightness desc
	if(rand(4) == 0 || (monster.ass.analLooseness <= 1 && rand(4) <= 2)) {
		if(monster.ass.analLooseness == 0) desc += "virgin ";
		if(monster.ass.analLooseness == 1) desc += "tight ";
		if(monster.ass.analLooseness == 2) desc += "";
		if(monster.ass.analLooseness == 3) desc += "loose ";
		if(monster.ass.analLooseness == 4) desc += "stretched ";
		if(monster.ass.analLooseness == 5) desc += "gaping ";
	}
	//But descriptor
	rando = rand(13);
	if(rando <= 2) desc += "ass";
	if(rando > 2 && rando <= 5) desc += "anus";
	if(rando > 5 && rando <= 7) desc += "pucker";
	if(rando > 7 && rando <= 10) desc += "asshole";
	if(rando == 11) desc += "bum";
	if(rando == 12) desc += "butthole";
	return desc;
}

		
function hipDescript():String {
	var desc:String = "";
	var rando:Number = 0;
	if(player.hipRating <= 1)
	{
		if(player.thickness > 70) {
			rando = rand(3);
			if(rando == 0) desc = "tiny ";
			else if(rando == 1) desc = "narrow ";
			else if(rando == 2) desc = "boyish ";
		}
		//Normal
		else if(player.thickness >= 30) {
			if(rand(2) == 0) desc = "boyish ";
			else desc = "tiny ";
		}
		//Uberthin
		else {
			rando = rand(3);
			if(rando == 0) desc = "tiny ";
			else if(rando == 1) desc = "narrow ";
			else if(rando == 2) desc = "boyish ";
		}
	}
	if(player.hipRating > 1 && player.hipRating < 4) {
		rando = rand(3);
		if(rando == 0) desc = "slender ";
		if(rando == 1) desc = "narrow ";
		if(rando == 2) desc = "thin ";
		if(player.thickness < 30) {
			if(rand(2) == 0) desc = "slightly-flared ";
			else desc = "curved ";
		}
	}
	if(player.hipRating >= 4 && player.hipRating < 6) {
		rando = rand(2);
		if(rando == 1) desc = "well-formed ";
		if(rando == 2) desc = "pleasant ";
		if(player.thickness < 30) {
			if(rand(2) == 0) desc = "flared ";
			else desc = "curvy ";
		}
	}
	if(player.hipRating >= 6 && player.hipRating < 10) {
		rando = rand(3);
		if(rando == 0) desc = "ample ";
		if(rando == 1) desc = "noticeable ";
		if(rando == 2) desc = "girly ";		
		if(player.thickness < 30) {
			if(rand(2) == 0) desc = "flared ";
			else desc = "waspish ";
		}
	}
	if(player.hipRating >= 10 && player.hipRating < 15) {
		rando = rand(3);
		if(rando == 0) desc = "flared ";
		if(rando == 1) desc = "curvy ";
		if(rando == 2) desc = "wide ";		
		if(player.thickness < 30) {
			if(rand(2) == 0) desc = "flared ";
			else desc = "waspish ";
		}
	}
	if(player.hipRating >= 15 && player.hipRating < 20) {
		rando = rand(3);
		if(player.thickness < 40) {
			if(rand(2) == 0) desc = "flared, ";
			else desc = "waspish, ";
		}
		if(rando == 0) desc += "fertile ";
		if(rando == 1) desc += "child-bearing ";
		if(rando == 2) desc += "voluptuous ";
	}
	if(player.hipRating >= 20) {
		if(player.thickness < 40) {
			if(rand(2) == 0) desc = "flaring, ";
			else desc = "incredibly waspish, ";
		}
		rando = rand(3);
		if(rando == 0) desc += "broodmother-sized ";
		if(rando == 1) desc += "cow-like ";
		if(rando == 2) desc += "inhumanly-wide ";
	}
	//Taurs
	if(player.isTaur() && rand(3) == 0) desc += "flanks";
	//Non taurs or taurs who didn't roll flanks
	else {
		rando = rand(2);
		if(rando == 0) desc += "hips";
		if(rando == 1) desc += "thighs";
	}
	return desc;
}
function assDescript():String {
	return buttDescript();
}
function buttDescript():String {
	var desc:String = "";
	var rando:Number = 0;
	if(player.buttRating <= 1)
	{
		if(player.tone >= 60) desc += "incredibly tight, perky ";
		else {
			if(rand(2) == 0) desc = "tiny";
			else if(rand(2) == 0) desc = "very small";
			else desc = "dainty";
			//Soft PC's buns!
			if(player.tone <= 30 && rand(3) == 0) desc += " yet soft";
			desc += " ";
		}
	}
	if(player.buttRating > 1 && player.buttRating < 4) {
		if(player.tone >= 65) {
			rando = rand(6);
			if(rando == 0) desc = "perky, muscular ";
			else if(rando == 1) desc = "tight, toned ";
			else if(rando == 2) desc = "firm ";
			else if(rando == 3) desc = "compact, muscular ";
			else if(rando == 4) desc = "tight ";
			else if(rando == 5) desc = "muscular, toned ";
		}
		//Nondescript
		else if(player.tone >= 30) {
			rando = rand(4);
			if(rando == 0) desc = "tight ";
			if(rando == 1) desc = "firm ";
			if(rando == 2) desc = "compact ";
			if(rando == 3) desc = "petite ";
		}
		//FLABBAH
		else  {
			rando = rand(7);
			if(rando == 0) desc = "small, heart-shaped ";
			else if(rando == 1) desc = "soft, compact ";
			else if(rando == 2) desc = "soft, heart-shaped ";
			else if(rando == 3) desc = "small, cushy ";
			else if(rando == 4) desc = "small ";
			else if(rando == 5) desc = "petite ";
			else if(rando == 6) desc = "snug ";
		}
	}
	if(player.buttRating >= 4 && player.buttRating < 6) {
		//TOIGHT LIKE A TIGER
		if(player.tone >= 65) {
			rando = rand(6);
			if(rando == 0) desc = "nicely muscled ";
			else if(rando == 1) desc = "nice, toned ";
			else if(rando == 2) desc = "muscly ";
			else if(rando == 3) desc = "nice toned ";
			else if(rando == 4) desc = "toned ";
			else if(rando == 5) desc = "fair ";
		}
		//Nondescript
		else if(player.tone >= 30) {
			rando = rand(2);
			if(rando == 0) desc = "nice ";
			if(rando == 1) desc = "fair ";	
		}
		//FLABBAH
		else  {
			rando = rand(5);
			if(rando == 0) desc = "nice, cushiony ";
			else if(rando == 1) desc = "soft ";
			else if(rando == 2) desc = "nicely-rounded, heart-shaped ";
			else if(rando == 3) desc = "cushy ";
			else if(rando == 4) desc = "soft, squeezable ";
		}
	}
	if(player.buttRating >= 6 && player.buttRating < 8) {
		//TOIGHT LIKE A TIGER
		if(player.tone >= 65) {
			rando = rand(7);
			if(rando == 0) desc = "full, toned ";
			else if(rando == 1) return "muscly handful of ass";
			else if(rando == 2) desc = "shapely, toned ";
			else if(rando == 3) desc = "muscular, hand-filling ";
			else if(rando == 4) desc = "shapely, chiseled ";
			else if(rando == 5) desc = "full ";
			else if(rando == 6) desc = "chiseled ";
		}
		//Nondescript
		else if(player.tone >= 30) {
			rando = rand(4);
			if(rando == 0) return "handful of ass";
			if(rando == 1) desc = "full ";
			if(rando == 2) desc = "shapely ";
			if(rando == 3) desc = "hand-filling ";
		}
		//FLABBAH
		else  {
			rando = rand(8);
			if(rando == 0) desc = "somewhat jiggly ";
			else if(rando == 1) desc = "soft, hand-filling ";
			else if(rando == 2) desc = "cushiony, full ";
			else if(rando == 3) return "supple, handful of ass";
			else if(rando == 4) desc = "plush, shapely ";
			else if(rando == 5) desc = "full ";
			else if(rando == 6) desc = "soft, shapely ";
			else if(rando == 7) desc = "rounded, spongy ";
		}
	}
	if(player.buttRating >= 8 && player.buttRating < 10) {
		//TOIGHT LIKE A TIGER
		if(player.tone >= 65) {
			rando = rand(8);
			if(rando == 0) desc = "large, muscular ";
			else if(rando == 1) desc = "substantial, toned ";
			else if(rando == 2) desc = "big-but-tight ";
			else if(rando == 3) desc = "squeezable, toned ";
			else if(rando == 4) desc = "large, brawny ";
			else if(rando == 5) desc = "big-but-fit ";
			else if(rando == 6) desc = "powerful, squeezable ";
			else if(rando == 7) desc = "large ";
		}
		//Nondescript
		else if(player.tone >= 30) {
			rando = rand(3);
			if(rando == 0) desc = "squeezable ";
			if(rando == 1) desc = "large ";
			if(rando == 2) desc = "substantial ";
		}
		//FLABBAH
		else  {
			rando = rand(9);
			if(rando == 0) desc = "large, bouncy ";
			else if(rando == 1) desc = "soft, eye-catching ";
			else if(rando == 2) desc = "big, slappable ";
			else if(rando == 3) desc = "soft, pinchable ";
			else if(rando == 4) desc = "large, plush ";
			else if(rando == 5) desc = "squeezable ";
			else if(rando == 6) desc = "cushiony ";
			else if(rando == 7) desc = "plush ";
			else if(rando == 8) desc = "pleasantly plump ";			
		}
	}
	if(player.buttRating >= 10 && player.buttRating < 13) {
		//TOIGHT LIKE A TIGER
		if(player.tone >= 65) {
			rando = rand(7);
			if(rando == 0) desc = "thick, muscular ";
			else if(rando == 1) desc = "big, burly ";
			else if(rando == 2) desc = "heavy, powerful ";
			else if(rando == 3) desc = "spacious, muscular ";
			else if(rando == 4) desc = "toned, cloth-straining ";
			else if(rando == 5) desc = "thick ";
			else if(rando == 6) desc = "thick, strong ";
		}
		//Nondescript
		else if(player.tone >= 30) {
			rando = rand(4);
			if(rando == 0) desc = "jiggling ";
			if(rando == 1) desc = "spacious ";
			if(rando == 2) desc = "heavy ";				
			if(rando == 3) desc = "cloth-straining ";
		}
		//FLABBAH
		else  {
			rando = rand(9);
			if(rando == 0) desc = "super-soft, jiggling ";
			else if(rando == 1) desc = "spacious, cushy ";
			else if(rando == 2) desc = "plush, cloth-straining ";
			else if(rando == 3) desc = "squeezable, over-sized ";
			else if(rando == 4) desc = "spacious ";
			else if(rando == 5) desc = "heavy, cushiony ";
			else if(rando == 6) desc = "slappable, thick ";
			else if(rando == 7) desc = "jiggling ";
			else if(rando == 8) desc = "spacious ";
			else if(rando == 9) desc = "soft, plump ";
		}		
	}
	if(player.buttRating >= 13 && player.buttRating < 16) {
		//TOIGHT LIKE A TIGER
		if(player.tone >= 65) {
			rando = rand(8);
			if(rando == 0) desc = "expansive, muscled ";
			else if(rando == 1) desc = "voluminous, rippling ";
			else if(rando == 2) desc = "generous, powerful ";
			else if(rando == 3) desc = "big, burly ";
			else if(rando == 4) desc = "well-built, voluminous ";
			else if(rando == 5) desc = "powerful ";
			else if(rando == 6) desc = "muscular ";
			else if(rando == 7) desc = "powerful, expansive ";
		}
		//Nondescript
		else if(player.tone >= 30) {
			rando = rand(4);
			if(rando == 0) desc = "expansive ";
			if(rando == 1) desc = "generous ";
			if(rando == 2) desc = "voluminous ";
			if(rando == 3) desc = "wide ";
		}
		//FLABBAH
		else {
			rando = rand(11);
			if(rando == 0) desc = "pillow-like ";
			else if(rando == 1) desc = "generous, cushiony ";
			else if(rando == 2) desc = "wide, plush ";
			else if(rando == 3) desc = "soft, generous ";
			else if(rando == 4) desc = "expansive, squeezable ";
			else if(rando == 5) desc = "slappable ";
			else if(rando == 6) desc = "thickly-padded ";
			else if(rando == 7) desc = "wide, jiggling ";
			else if(rando == 8) desc = "wide ";
			else if(rando == 9) desc = "voluminous ";
			else if(rando == 10) desc = "soft, padded ";
		}
	}
	if(player.buttRating >= 16 && player.buttRating < 20) {
		if(player.tone >= 65) {
			rando = rand(6);
			if(rando == 0) desc = "huge, toned ";
			else if(rando == 1) desc = "vast, muscular ";
			else if(rando == 2) desc = "vast, well-built ";
			else if(rando == 3) desc = "huge, muscular ";
			else if(rando == 4) desc = "strong, immense ";
			else if(rando == 5) desc = "muscle-bound ";
		}
		//Nondescript
		else if(player.tone >= 30) {
			rando = rand(5);
			if(rando == 0) desc = "huge ";
			if(rando == 1) desc = "vast ";
			if(rando == 2) desc = "giant ";
			if(rando == 3) return "jiggling expanse of ass";	
			if(rando == 4) return "copious ass-flesh";
		}
		//FLABBAH
		else {
			rando = rand(11);
			if(rando == 0) desc = "vast, cushiony ";
			else if(rando == 1) desc = "huge, plump ";
			else if(rando == 2) desc = "expansive, jiggling ";
			else if(rando == 3) desc = "huge, cushiony ";
			else if(rando == 4) desc = "huge, slappable ";
			else if(rando == 5) desc = "seam-bursting ";
			else if(rando == 6) desc = "plush, vast ";
			else if(rando == 7) desc = "giant, slappable ";
			else if(rando == 8) desc = "giant ";
			else if(rando == 9) desc = "huge ";
			else if(rando == 10) desc = "swollen, pillow-like ";
		}
	}
	if(player.buttRating >= 20) {
		if(player.tone >= 65) {
			rando = rand(7);
			if(rando == 0) desc = "ginormous, muscle-bound ";
			else if(rando == 1) desc = "colossal yet toned ";
			else if(rando == 2) desc = "strong, tremdously large ";
			else if(rando == 3) return "colossal, muscly ass";
			else if(rando == 4) desc = "tremendous, muscled ";
			else if(rando == 5) desc = "ginormous, toned ";
			else if(rando == 6) desc = "colossal, well-defined ";
		}
		//Nondescript
		else if(player.tone >= 30) {
			rando = rand(4);
			if(rando == 0) desc = "ginormous ";
			if(rando == 1) desc = "colossal ";
			if(rando == 2) desc = "tremendous ";
			if(rando == 3) desc = "gigantic ";
		}
		//FLABBAH
		else {
			rando = rand(13);
			if(rando == 0) desc = "ginormous, jiggly ";
			else if(rando == 1) desc = "plush, ginormous ";
			else if(rando == 2) desc = "seam-destroying ";
			else if(rando == 3) desc = "tremendous, rounded ";
			else if(rando == 4) desc = "bouncy, colossal ";
			else if(rando == 5) desc = "thong-devouring ";
			else if(rando == 6) desc = "tremendous, thickly padded ";
			else if(rando == 7) desc = "ginormous, slappable ";
			else if(rando == 8) desc = "gigantic, rippling ";
			else if(rando == 9) desc = "gigantic ";
			else if(rando == 10) desc = "ginormous ";
			else if(rando == 11) desc = "colossal ";
			else if(rando == 12) desc = "tremendous ";
		}
	}
	rando = rand(15);
	if(rando <= 4) desc += "butt";
	else if(rando <= 9) desc += "ass";
	else if(rando <= 11) desc += "backside";
	else if(rando == 12) {
		if(player.buttRating >= 10) desc += "booty";
		else desc += "derriere";
	}
	else if(rando == 13) desc += "rump";
	else if(rando == 14) desc += "bottom";
	
	//if(rando == 2) desc += "cheeks";
	

	return desc;
}
function eButtDescript():String {
	var desc:String = "";
	var rando:Number = 0;
	if(monster.buttRating <= 1)
	{
		if(rand(2) == 0) desc = "insignificant ";
		else desc = "very small ";
	}
	if(monster.buttRating > 1 && monster.buttRating < 4) {
		rando = rand(3);
		if(rando == 0) desc = "tight ";
		if(rando == 1) desc = "firm ";
		if(rando == 2) desc = "compact ";
	}
	if(monster.buttRating >= 4 && monster.buttRating < 6) {
		rando = rand(2);
		if(rando == 0) desc = "regular ";
		if(rando == 1) desc = "unremarkable ";
	}
	if(monster.buttRating >= 6 && monster.buttRating < 8) {
		rando = rand(3);
		if(rando == 0) return "handful of ass";
		if(rando == 1) desc = "full ";
		if(rando == 2) desc = "shapely ";
	}
	if(monster.buttRating >= 8 && monster.buttRating < 10) {
		rando = rand(3);
		if(rando == 0) desc = "squeezable ";
		if(rando == 1) desc = "large ";
		if(rando == 2) desc = "substantial ";		
	}
	if(monster.buttRating >= 10 && monster.buttRating < 13) {
		rando = rand(3);
		if(rando == 0) desc = "jiggling ";
		if(rando == 1) desc = "spacious ";
		if(rando == 2) desc = "heavy ";				
	}
	if(monster.buttRating >= 13 && monster.buttRating < 16) {
		rando = rand(3);
		if(rando == 0) desc = "expansive ";
		if(rando == 1) return "generous amount of ass";
		if(rando == 2) desc = "voluminous ";	
	}
	if(monster.buttRating >= 16 && monster.buttRating < 20) {
		rando = rand(3);
		if(rando == 0) desc = "huge ";
		if(rando == 1) desc = "vast ";
		if(rando == 2) return "jiggling expanse of ass";	
	}
	if(monster.buttRating >= 20) {
		rando = rand(3);
		if(rando == 0) desc = "ginormous ";
		if(rando == 1) desc = "colossal ";
		if(rando == 2) desc = "tremendous ";
	}
	rando = rand(2);
	if(rando == 0) desc += "butt";
	if(rando == 1) desc += "ass";

	return desc;
}


function num2Text(number:Number):String {
	var returnVar:String = null;
	var numWords = new Array("zero","one","two","three","four","five","six","seven","eight","nine","ten");
	if (number > 10 || int(number) != number) {
		returnVar = "" + number;
	} 
	else {
		returnVar = numWords[number];
	}
	return(returnVar);
}
function num2Text2(number:int):String {
	var returnVar:String = null;
	var numWords = new Array("zero","first","second","third","fourth","fifth","sixth","seventh","eighth","ninth","tenth");
	if (number > 10) {
		returnVar = "" + number + "th";
	} 
	else {
		returnVar = numWords[number];
	}
	return(returnVar);
}

function Num2Text(number:int):String {
	var returnVar:String = null;
	var numWords = new Array("Zero","One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten");
	if (number > 10) {
		returnVar = "" + number;
	} 
	else {
		returnVar = numWords[number];
	}
	return(returnVar);
}
function nippleDescript(rowNum:Number):String {
	//DEBUG SHIT!
	if(rowNum > (player.breastRows.length - 1)) return "<B>Error: Invalid breastRows (" + rowNum + ") passed to nippleDescript()</b>";
	if(rowNum < 0) return "<B>Error: Invalid breastRows (" + rowNum + ") passed to nippleDescript()</b>";
	var descripted:Boolean = false;
	var description:String = "";
	var rando:Number = 0;
	var temp14:Number = 0;
	//Size descriptors 33% chance
	if(rand(4) == 0) {
		//TINAHHHH
		if(player.nippleLength < .25) {
			temp14 = rand(3);
			if(temp14 == 0) description += "tiny ";
			if(temp14 == 1) description += "itty-bitty ";
			if(temp14 == 2) description += "teeny-tiny ";
			if(temp14 == 3) description += "dainty ";
		}
		//Prominant
		if(player.nippleLength >= .4 && player.nippleLength < 1) {
			temp14 = rand(5);
			if(temp14 == 0) description += "prominent ";
			if(temp14 == 1) description += "pencil eraser-sized ";
			if(temp14 == 2) description += "eye-catching ";
			if(temp14 == 3) description += "pronounced ";
			if(temp14 == 4) description += "striking ";
		}
		//Big 'uns
		if(player.nippleLength >= 1 && player.nippleLength < 2) {
			temp14 = rand(4);
			if(temp14 == 0) description += "forwards-jutting ";
			if(temp14 == 1) description += "over-sized ";
			if(temp14 == 2) description += "fleshy ";
			if(temp14 == 3) description += "large protruding ";
		}
		//'Uge
		if(player.nippleLength >= 2 && player.nippleLength < 3.2) {
			temp14 = rand(5);
			if(temp14 == 0) description += "elongated ";
			if(temp14 == 1) description += "massive ";
			if(temp14 == 2) description += "awkward ";
			if(temp14 == 3) description += "lavish ";
			if(temp14 == 4) description += "hefty ";
		}
		//Massive
		if(player.nippleLength >= 3.2) {
			temp14 = rand(5);
			if(temp14 == 0) description += "bulky ";
			if(temp14 == 1) description += "ponderous ";
			if(temp14 == 2) description += "thumb-sized ";
			if(temp14 == 3) description += "cock-sized ";
			if(temp14 == 4) description += "cow-like ";
		}
		descripted = true;
	}
	//Milkiness/Arousal/Wetness Descriptors 33% of the time
	if(rand(3) == 0 && !descripted) {
		//Fuckable chance first!
		if(player.hasFuckableNipples()) {
			//Fuckable and lactating?
			if(player.biggestLactation() > 1) {
				temp14 = rand(5);
				if(temp14 == 0) description += "milk-lubricated ";
				if(temp14 == 1) description += "lactating ";
				if(temp14 == 2) description += "lactating ";
				if(temp14 == 3) description += "milk-slicked ";
				if(temp14 == 4) description += "milky ";
			}
			//Just fuckable
			else {
				temp14 = rand(9);
				if(temp14 == 0) description += "wet ";
				if(temp14 == 1) description += "mutated ";
				if(temp14 == 2) description += "slimy ";
				if(temp14 == 3) description += "damp ";
				if(temp14 == 4) description += "moist ";
				if(temp14 == 5) description += "slippery ";
				if(temp14 == 6) description += "oozing ";
				if(temp14 == 7) description += "sloppy ";
				if(temp14 == 8) description += "dewy ";
			}
			descripted = true;
		}
		//Just lactating!
		else if(player.biggestLactation() > 0) {
			//Light lactation
			if(player.biggestLactation() <= 1) {
				temp14 = rand(3);
				if(temp14 == 0) description += "milk moistened ";
				if(temp14 == 1) description += "slightly lactating ";
				if(temp14 == 2) description += "milk-dampened ";
			}
			//Moderate lactation
			if(player.biggestLactation() > 1 && player.biggestLactation() <= 2) {
				temp14 = rand(3);
				if(temp14 == 0) description += "lactating ";
				if(temp14 == 1) description += "milky ";
				if(temp14 == 2) description += "milk-seeping ";
			}
			//Heavy lactation
			if(player.biggestLactation() > 2) {
				temp14 = rand(4);
				if(temp14 == 0) description += "dripping ";
				if(temp14 == 1) description += "dribbling ";
				if(temp14 == 2) description += "milk-leaking ";
				if(temp14 == 3) description += "drooling ";
			}
			descripted = true;
		}
	}
	//Possible arousal descriptors
	else if(rand(3) == 0 && !descripted) {
		if(player.lust > 50 && player.lust < 75) {
			temp14 = rand(5);
			if(temp14 == 0) description += "erect ";
			if(temp14 == 1) description += "perky ";
			if(temp14 == 2) description += "erect ";
			if(temp14 == 3) description += "firm ";
			if(temp14 == 4) description += "tender ";
			descripted = true;
		}
		if(player.lust >= 75) {
			temp14 = rand(4);
			if(temp14 == 0) description += "throbbing ";
			if(temp14 == 1) description += "trembling ";
			if(temp14 == 2) description += "needy ";
			if(temp14 == 3) description += "throbbing ";
			descripted = true;
		}		
	}
	if(!descripted && rand(2) == 0 && player.nipplesPierced > 0 && rowNum == 0) {
		if(player.nipplesPierced == 5) description += "chained ";
		else description += "pierced ";
		descripted = true;
	}
	if(!descripted && player.skinType == 3) {
		rando = rand(3);
		if(rando == 0) description += "slime-slick ";
		if(rando == 1) description += "goopy ";
		if(rando == 2) description += "slippery ";
	}
	if(!descripted && player.hasStatusAffect("Black Nipples") >= 0) {
		rando = rand(3);
		if(rando == 0) description += "black ";
		else if(rando == 1) description += "ebony ";
		else description += "sable ";
	}
	//Nounsssssssss*BOOM*
	temp14 = rand(5);
	if(temp14 == 0) description += "nipple";
	if(temp14 == 1) {
		if(player.nippleLength < .5) description += "perky nipple";
		else description += "cherry-like nub";
	}
	if(temp14 == 2) {
		if(player.hasFuckableNipples()) description += "fuckable nip";
		else {
			if(player.biggestLactation() >= 1 && player.nippleLength >= 1) description += "teat";
			else description += "nipple";
		}
	}
	if(temp14 == 3) {
		if(player.hasFuckableNipples()) description += "nipple-hole";
		else {
			if(player.biggestLactation() >= 1 && player.nippleLength >= 1) description += "teat";
			else description += "nipple";
		}
	}
	if(temp14 == 4) {
		if(player.hasFuckableNipples()) description += "nipple-cunt";
		else description += "nipple";
	}
	return description;
	/*OLD
	if(player.breastRows[rowNum].lactationMultiplier >= 1.5 && player.breastRows[rowNum].lactationMultiplier < 1.75) {
		if(player.breastRows[rowNum].milkFullness > 75) return "over-full leaking teat";
		if(rand(2) == 0) return "milky teat";
		else return "milk spout";
	}
	if(player.breastRows[rowNum].lactationMultiplier >= 1.75) {
		if(player.breastRows[rowNum].milkFullness > 75) return "over-full leaking teat";
		if(rand(2) == 0) return "milk-drooling teat";
		else return "drippy cow-teat";
	}
	if(player.lust > 75) {
		if(rand(2) == 0) return "painfully hard nipple";
		else return "over-stimulated nipple";
	}
	if(player.lust > 50) {
		if(rand(2) == 0) return "erect nipple";
		else return "hard nipple";
	}
	if(player.breastRows[rowNum].milkFullness > 75) return "milky over-full nipple";
	return "nipple";
	*/
}

function hairDescript():String {
	var descript:String = "";
	//
	// LENGTH ADJECTIVE!
	//
	if(player.hairLength == 0) 
	{
		if(rand(2) == 0) descript += "shaved ";
		else descript += "bald ";
		descript += "head";
		return descript;
	}
	if(player.hairLength < 1) {
		if(rand(2) == 0) descript += "close-cropped, ";
		else descript += "trim, ";
	}
	if(player.hairLength >= 1 && player.hairLength < 3) descript += "short, ";
	if(player.hairLength >= 3  && player.hairLength < 6) descript += "shaggy, ";
	if(player.hairLength >= 6 && player.hairLength < 10) descript += "moderately long, ";
	if(player.hairLength >= 10 && player.hairLength < 16) {
		if(rand(2) == 0) descript += "long, ";
		else descript += "shoulder-length, ";
	}
	if(player.hairLength >= 16 && player.hairLength < 26) {
		if(rand(2) == 0) descript += "very long, ";
		else descript += "flowing locks of ";
	}
	if(player.hairLength >= 26 && player.hairLength < 40) descript += "ass-length, ";
	if(player.hairLength >= 40 && player.hairLength < player.tallness) descript += "obscenely long, ";
	else if(player.hairLength >= player.tallness) {
		if(rand(2) == 0) descript += "floor-length, ";
		else descript += "floor-dragging, ";
	}
	//
	// COLORS
	//
	descript += player.hairColor + " ";
	//
	// HAIR WORDS
	//
	//If furry and longish hair sometimes call it a mane (50%)
	if(player.skinType == 1 && player.hairLength > 3 && rand(2) == 0) {
		if(player.hairType == 1) descript += "feather-";
		else if(player.hairType == 2) descript += "transparent ";
		else if(player.hairType == 3) descript += "goo-";
		else if(player.hairType == 4) descript += "tentacle-";
		descript += "mane";
		return descript;
	}
	//if medium length refer to as locks sometimes
	//CUT - locks is plural and screws up tense.
	/*if(player.hairLength >= 3 && player.hairLength < 16 && rand(2) == 0) {
		descript += "locks of hair";
		return descript;
	}*/
	//If nothing else used, use hair!
	if(player.hairType == 1) descript += "feather-";
	else if(player.hairType == 2) descript += "transparent ";
	else if(player.hairType == 3) descript += "goo-";
	else if(player.hairType == 4) descript += "tentacle-";
	descript += "hair";
	
	return descript;
}

function clitDescript():String {
	var descript:String = "";
	var randt:Number = rand(10);
	var descripted:Boolean = false;
	//Length Adjective - 50% chance
	if(rand(2) == 0) {
		//small clits!
		if(player.clitLength <= .5) {
			if(randt < 3) descript += "tiny ";
			if(randt >= 3 && randt < 6) descript += "little ";
			if(randt >= 6 && randt < 8) descript += "petite ";
			if(randt == 8) descript += "diminutive ";
			if(randt == 9) descript += "miniature ";
		}
		//"average".  
		if(player.clitLength > .5 && player.clitLength < 1.5) {
			//no size comment
		}
		//Biggies!
		if(player.clitLength >= 1.5 && player.clitLength < 4) {
			if(randt < 4) descript += "large ";
			if(randt >= 4 && randt < 9) descript += "substantial ";
			if(randt == 9) descript += "considerable ";
		}
		//'Uge 
		if(player.clitLength >= 4) {
			if(randt < 3) descript += "monster ";
			if(randt >= 3 && randt < 6) descript += "tremendous ";
			if(randt >= 6 && randt < 8) descript += "colossal ";
			if(randt == 8) descript += "enormous ";
			if(randt == 9) descript += "bulky ";
		}
	}
	//Descriptive descriptions - 50% chance of being called
	if(rand(2) == 0) {
		//Doggie descriptors - 50%
		if(player.skinType == 1 > 2 && !descripted && rand(2) == 0) {
			descripted = true;
			descript += "bitch-";
		}
		/*Horse descriptors - 50%
		if(player.skinType == 1 > 2 && !descripted && rand(2) == 0) {
			descripted = true;
			descript += "mare-";
		}*/
		//Horny descriptors - 75% chance
		if(player.lust > 70 && rand(4) < 3 && !descripted) {
			descripted = true;
			randt = rand(3);
			if(randt == 0) descript += "throbbing ";
			if(randt == 1) descript += "pulsating ";
			if(randt == 2) descript += "hard ";
		}
		//High libido - always use if no other descript
		if(player.lib > 50 && rand(2) == 0 && !descripted) {
			descripted = true;
			randt = rand(4);
			if(randt == 0) descript += "insatiable ";
			if(randt == 1) descript += "greedy ";
			if(randt == 2) descript += "demanding ";
			if(randt == 3) descript += "rapacious ";
		}
	}
	if(player.hasVagina()) {
		if(!descripted && player.vaginas[0].clitPierced > 0) {
			descript += "pierced ";
			descripted = true;
		}
	}
	else outputText("ERROR: CLITDESCRIPT WITH NO CLIT");
	//Clit nouns
	randt = rand(10);
	if(randt == 0) descript += "clit";
	if(randt == 1) descript += "clitty";
	if(randt == 2) descript += "button";
	if(randt == 3) descript += "pleasure-buzzer";
	if(randt == 4) descript += "clit";
	if(randt == 5) descript += "clitty";
	if(randt == 6) descript += "button";
	if(randt == 7) descript += "clit";
	if(randt == 8) descript += "clit";
	if(randt == 9) descript += "button";
	return descript;
}

//Vaginas + Descript
function vaginaDescript(vaginaNum:Number = 0):String {
	if(vaginaNum > (player.vaginas.length - 1)) return "<B>Error: Invalid vagina number (" + vaginaNum + ") passed to vaginaDescript()</b>";
	if(vaginaNum < 0) return "<B>Error: Invalid vaginaNum (" + vaginaNum + ") passed to vaginaDescript()</b>";
	var vag:String="";
	var keyNum:Number = player.vaginas.length-1;
	var rand:Number = 0;
	var descripted:Boolean = false;
	//If no vaginas back the fuck out
	if(keyNum < 0) return "VAGINA ERROR";
	//tightness descript - 40% display rate
	if(player.vaginas[vaginaNum].vaginalLooseness == 0) rand = 61;
	if(player.vaginas[vaginaNum].vaginalLooseness == 4 || player.vaginas[vaginaNum].vaginalLooseness == 5) rand = 10;
	if(int(Math.random()*100) + rand > 70) {
		if(player.vaginas[vaginaNum].vaginalLooseness == 0) {
			if(player.vaginas[vaginaNum].virgin) vag+="virgin";
			else vag +="tight";
		}
		if(player.vaginas[vaginaNum].vaginalLooseness == 2) vag+="loose";
		if(player.vaginas[vaginaNum].vaginalLooseness == 3) vag+="very loose";
		if(player.vaginas[vaginaNum].vaginalLooseness == 4) vag+="gaping";
		if(player.vaginas[vaginaNum].vaginalLooseness == 5) vag+="gaping-wide";
		
		if(player.vaginas[vaginaNum].vaginalLooseness != 1) descripted = true;
	}
	//wetness descript - 30% display rate
	if(int(Math.random()*100 > 70)) {
		if(descripted) vag += ", ";
		if(player.vaginas[vaginaNum].vaginalWetness == 0) vag+="dry";
		if(player.vaginas[vaginaNum].vaginalWetness == 1) vag+="moist";
		if(player.vaginas[vaginaNum].vaginalWetness == 2) vag+="wet";
		if(player.vaginas[vaginaNum].vaginalWetness == 3) vag+="slick";
		if(player.vaginas[vaginaNum].vaginalWetness == 4) vag+="drooling";
		if(player.vaginas[vaginaNum].vaginalWetness == 5) vag+="slavering";
		descripted = true;
	}
	if(player.vaginas[0].labiaPierced > 0 && Math.floor(Math.random() * 3) == 0) {
		if(descripted) vag += ", ";
		vag += "pierced";
		descripted = true;
	}
	if(!descripted && player.skinType == 3) {
		if(descripted) vag += ", ";
		rand = int(Math.random()*2);
		if(rand == 0) vag += "gooey";
		else vag += "slimy";
		descripted = true;
	}
	if(player.vaginaType() == 5 && Math.floor(Math.random() * 2) == 0) {
		if(descripted) vag += ", ";
		rand = Math.floor(Math.random() * 8);
		if(rand == 0) vag += "black";
		else if(rand == 1) vag += "onyx";
		else if(rand == 2) vag += "ebony";
		else if(rand == 3) vag += "dusky";
		else if(rand == 4) vag += "sable";
		else if(rand == 5) vag += "obsidian";
		else if(rand == 6) vag += "midnight-hued";
		else vag += "jet black";
		descripted = true;
	}
	
	if(descripted) vag += " ";
	rand = int(Math.random()*9);
	if(rand == 0) vag+="vagina";
	if(rand == 1 || rand == 2 || rand == 6) vag+="pussy";
	if(rand == 3 || rand == 4 || rand == 5) {
		if(player.bunnyScore() >= 3) vag += "rabbit hole";
		else vag+="cunt";
	}
	if(rand == 7)  vag+="fuck-hole";
	if(rand == 8) vag += "muff";
	return vag;
}

//Allvagina descript
function allVaginaDescript():String {
	if(player.vaginas.length == 1) return vaginaDescript(rand(player.vaginas.length));
	if(player.vaginas.length > 1) return (vaginaDescript(rand(player.vaginas.length)) + "s");
	return "ERROR: allVaginaDescript called with no vaginas.";
}
function multiCockDescript():String {
	if(player.cocks.length < 1) return "<B>Error: multiCockDescript() called with no penises present.</B>";
	//Get cock counts
	var descript:String="";
	var currCock:Number = 0;
	var totCock:Number = player.cocks.length;
	var dogCocks:Number = 0;
	var horseCocks:Number = 0;
	var normalCocks:Number = 0;
	var normalCockKey:Number = 0;
	var dogCockKey:Number = 0;
	var horseCockKey:Number = 0;
	var averageLength:Number = 0;
	var averageThickness:Number = 0;
	var same:Boolean = true;
	//For temp14 random values
	var rando:Number = 0;
	var descripted:Boolean = false;
	//Count cocks & Prep average totals
	while(currCock <= totCock-1) {
		trace("Counting cocks!");
		if(player.cocks[currCock].cockType == CockTypesEnum.HUMAN) {
			normalCocks++;
			normalCockKey = currCock;
		}
		if(player.cocks[currCock].cockType == CockTypesEnum.HORSE) {
			horseCocks++;
			horseCockKey = currCock;
		}
		if(player.cocks[currCock].cockType == CockTypesEnum.DOG) {
			dogCocks++;
			dogCockKey = currCock;
		}
		averageLength += player.cocks[currCock].cockLength;
		averageThickness += player.cocks[currCock].cockThickness;
		//If cocks are matched make sure they still are
		if(same && currCock > 0 && player.cocks[currCock].cockType != player.cocks[currCock-1].cockType) same = false;
		currCock++;
	}
	//Crunch averages
	averageLength /= currCock;
	averageThickness /= currCock;
	//Quantity descriptors
	if(currCock == 1) {
		if(dogCocks == 1) return dogDescript(0);
		if(horseCocks == 1) return horseDescript(0);
		if(normalCocks == 1) return cockDescript(0)
		//Catch-all for when I add more cocks.  Let cock descript do the sorting.
		if(player.cocks.length == 1) return cockDescript(0);
	}
	if(currCock == 2) {
		//For cocks that are the same
		if(same) {
			rando = rand(5);
			if(rando == 0) descript += "a pair of ";
			if(rando == 1) descript += "two ";
			if(rando == 2) descript += "a brace of ";			
			if(rando == 3) descript += "matching ";
			if(rando == 4) descript += "twin "
			descript += cockAdjectives(averageLength, averageThickness, player.cocks[0].cockType);
			if(normalCocks == 2) descript += " " + Appearance.cockNoun(CockTypesEnum.HUMAN) + "s";
			if(horseCocks == 2) descript += ", " + Appearance.cockNoun(CockTypesEnum.HORSE) + "s";
			if(dogCocks == 2) descript += ", " + Appearance.cockNoun(CockTypesEnum.DOG) + "s";
			//Tentacles
			if(player.cocks[0].cockType.Index > 2) descript += ", " + Appearance.cockNoun(player.cocks[0].cockType) + "s";
		}
		//Nonidentical
		else {
			rando = rand(3);
			if(rando == 0) descript += "a pair of ";
			if(rando == 1) descript += "two ";
			if(rando == 2) descript += "a brace of ";
			descript += cockAdjectives(averageLength, averageThickness, player.cocks[0].cockType) + ", ";
			rando = rand(4);
			if(rando == 0) descript += "mutated cocks";
			if(rando == 1) descript += "mutated dicks";
			if(rando == 2) descript += "mixed cocks";
			if(rando == 3) descript += "mismatched dicks";
		}
	}
	if(currCock == 3) {
		//For samecocks
		if(same) {
			rando = rand(5);
			if(rando == 0) descript += "three ";
			if(rando == 1) descript += "a group of ";
			if(rando == 2) descript += "a menage a trois of ";
			if(rando == 3) descript += "a triad of ";
			if(rando == 4) descript += "a triumvirate of ";
			descript += cockAdjectives(averageLength, averageThickness, player.cocks[currCock-1].cockType);
			if(normalCocks == 3) descript += " " + Appearance.cockNoun(CockTypesEnum.HUMAN) + "s";
			if(horseCocks == 3) descript += ", " + Appearance.cockNoun(CockTypesEnum.HORSE) + "s";
			if(dogCocks == 3) descript += ", " + Appearance.cockNoun(CockTypesEnum.DOG) + "s";
			//Tentacles
			if(player.cocks[0].cockType.Index > 2) descript += ", " + Appearance.cockNoun(player.cocks[0].cockType) + "s";   // Not sure what's going on here, referencing index *may* be a bug.

		}
		else {
			rando = rand(2);
			if(rando == 0) descript += "three ";
			if(rando == 1) descript += "a group of ";
			descript += cockAdjectives(averageLength, averageThickness, player.cocks[0].cockType);
			rando = rand(4);
			if(rando == 0) descript += ", mutated cocks";
			if(rando == 1) descript += ", mutated dicks";
			if(rando == 2) descript += ", mixed cocks";
			if(rando == 3) descript += ", mismatched dicks";
		}
	}
	//Large numbers of cocks!
	if(currCock > 3)
	{
		rando = rand(4);
		if(rando == 0) descript += "a bundle of ";
		if(rando == 1) descript += "an obscene group of ";
		if(rando == 2) descript += "a cluster of ";
		if(rando == 3) descript += "a wriggling group of ";
		//Cock adjectives and nouns
		descripted = false;
		//If same types...
		if(same) {
			if(player.cocks[0].cockType == CockTypesEnum.HUMAN) {
				descript += cockAdjectives(averageLength, averageThickness, 0) + " ";	
				descript += Appearance.cockNoun(CockTypesEnum.HUMAN) + "s";
				descripted = true;
			}
			if(player.cocks[0].cockType == CockTypesEnum.DOG) {
				descript += cockAdjectives(averageLength, averageThickness, 2) + ", ";
				descript += Appearance.cockNoun(CockTypesEnum.DOG) + "s";
				descripted = true;
			}
			if(player.cocks[0].cockType == CockTypesEnum.HORSE) {
				descript += cockAdjectives(averageLength, averageThickness, 1) + ", ";
				descript += Appearance.cockNoun(CockTypesEnum.HORSE) + "s";
				descripted = true;			
			}
			if(player.cocks[0].cockType.Index > 2) {
				descript += cockAdjectives(averageLength, averageThickness, 1) + ", ";
				descript += Appearance.cockNoun(player.cocks[0].cockType) + "s";
				descripted = true;			
			}
		}
		//If mixed
		if(!descripted) {
			descript += cockAdjectives(averageLength, averageThickness, player.cocks[0].cockType) + ", ";
			rando = rand(4);
			if(rando == 0) descript += "mutated cocks";
			if(rando == 1) descript += "mutated dicks";
			if(rando == 2) descript += "mixed cocks";
			if(rando == 3) descript += "mismatched dicks";
		}
	}	
	return descript;
}

function multiCockSuperLight():String {
	var output:String = "";
	if(player.cocks.length < 1) return "<b>ERROR: NO WANGS DETECTED for multicocksuperlight()</b>";
	if(player.horseCocks() == player.totalCocks()) output += Appearance.cockNoun(CockTypesEnum.HORSE);
	else if(player.dogCocks() == player.totalCocks()) output += Appearance.cockNoun(CockTypesEnum.DOG);
	else if(player.demonCocks() == player.totalCocks()) output += Appearance.cockNoun(CockTypesEnum.DEMON);
	else if(player.tentacleCocks() == player.totalCocks()) output += Appearance.cockNoun(CockTypesEnum.TENTACLE);
	else if(player.catCocks() == player.totalCocks()) output += Appearance.cockNoun(CockTypesEnum.CAT);
	else if(player.lizardCocks() == player.totalCocks()) output += Appearance.cockNoun(CockTypesEnum.LIZARD);
	else if(player.anemoneCocks() == player.totalCocks()) output += Appearance.cockNoun(CockTypesEnum.ANEMONE);
	else if(player.kangaCocks() == player.totalCocks()) output += Appearance.cockNoun(CockTypesEnum.KANGAROO);
	else output += Appearance.cockNoun(CockTypesEnum.HUMAN);
	//Add s if plural
	if(player.cockTotal() > 1) output += "s";
	//Reset to normal description if singular
	else output = cockDescript(0);
	return output;
}


function multiCockDescriptLight():String {
	if(player.cocks.length < 1) return "<B>Error: multiCockDescriptLight() called with no penises present.</B>";
	//Get cock counts
	var descript:String="";
	var currCock:Number = 0;
	var totCock:Number = player.cocks.length;
	var dogCocks:Number = 0;
	var horseCocks:Number = 0;
	var normalCocks:Number = 0;
	var normalCockKey:Number = 0;
	var dogCockKey:Number = 0;
	var horseCockKey:Number = 0;
	var averageLength:Number = 0;
	var averageThickness:Number = 0;
	var same:Boolean = true;
	//For temp14 random values
	var rando:Number = 0;
	var descripted:Boolean = false;
	//If one, return normal cock descript
	if(totCock == 1) return cockDescript(0);
	//Count cocks & Prep average totals
	while(currCock <= totCock-1) {
		if(player.cocks[currCock].cockType == CockTypesEnum.HUMAN) {
			normalCocks++;
			normalCockKey = currCock;
		}
		if(player.cocks[currCock].cockType == CockTypesEnum.HORSE) {
			horseCocks++;
			horseCockKey = currCock;
		}
		if(player.cocks[currCock].cockType == CockTypesEnum.DOG) {
			dogCocks++;
			dogCockKey = currCock;
		}
		averageLength += player.cocks[currCock].cockLength;
		averageThickness += player.cocks[currCock].cockThickness;
		//If cocks are matched make sure they still are
		if(same && currCock > 0 && player.cocks[currCock].cockType != player.cocks[currCock-1].cockType) same = false;
		currCock++;
	}
	//Crunch averages
	averageLength /= currCock;
	averageThickness /= currCock;
	//Quantity descriptors
	if(player.cockTotal() == 1) {
		if(dogCocks == 1) return dogDescript(0);
		if(horseCocks == 1) return horseDescript(0);
		if(normalCocks == 1) return cockDescript(0);
		//Failsafe
		return cockDescript(0);
	}
	if(currCock == 2) {
		//For cocks that are the same
		if(same) {
			rando = rand(5);
			if(rando == 0) descript += "pair of ";
			if(rando == 1) descript += "two ";
			if(rando == 2) descript += "brace of ";			
			if(rando == 3) descript += "matching ";
			if(rando == 4) descript += "twin "
			descript += cockAdjective();
			if(normalCocks == 2) descript += " " + Appearance.cockNoun(CockTypesEnum.HUMAN) + "s";
			if(horseCocks == 2) descript += ", " + Appearance.cockNoun(CockTypesEnum.HORSE) + "s";
			if(dogCocks == 2) descript += ", " + Appearance.cockNoun(CockTypesEnum.DOG) + "s";
			//Failsafe
			if(player.cocks[0].cockType.Index > 2) descript += ", " + Appearance.cockNoun(player.cocks[0].cockType) + "s";
		}
		//Nonidentical
		else {
			rando = rand(3);
			if(rando == 0) descript += "pair of ";
			if(rando == 1) descript += "two ";
			if(rando == 2) descript += "brace of ";
			descript += cockAdjective() + ", ";
			rando = rand(4);
			if(rando == 0) descript += "mutated cocks";
			if(rando == 1) descript += "mutated dicks";
			if(rando == 2) descript += "mixed cocks";
			if(rando == 3) descript += "mismatched dicks";
		}
	}
	if(currCock == 3) {
		//For samecocks
		if(same) {
			rando = rand(5);
			if(rando == 0) descript += "three ";
			if(rando == 1) descript += "group of ";
			if(rando == 2) descript += "menage a trois of ";
			if(rando == 3) descript += "triad of ";
			if(rando == 4) descript += "triumvirate of ";
			descript += cockAdjective();
			if(normalCocks == 3) descript += " " + Appearance.cockNoun(CockTypesEnum.HUMAN) + "s";
			if(horseCocks == 3) descript += ", " + Appearance.cockNoun(CockTypesEnum.HORSE) + "s";
			if(dogCocks == 3) descript += ", " + Appearance.cockNoun(CockTypesEnum.DOG) + "s";
			//Tentacles
			if (player.cocks[0].cockType.Index > 2) descript += ", " + Appearance.cockNoun(player.cocks[0].cockType) + "s";
		}
		else {
			rando = rand(2);
			if(rando == 0) descript += "three ";
			if(rando == 1) descript += "group of ";
			descript += cockAdjective() + ", ";
			rando = rand(4);
			if(rando == 0) descript += "mutated cocks";
			if(rando == 1) descript += "mutated dicks";
			if(rando == 2) descript += "mixed cocks";
			if(rando == 3) descript += "mismatched dicks";
		}
	}
	//Large numbers of cocks!
	if(currCock > 3)
	{
		rando = rand(4);
		if(rando == 0) descript += "bundle of ";
		if(rando == 1) descript += "obscene group of ";
		if(rando == 2) descript += "cluster of ";
		if(rando == 3) descript += "wriggling bunch of ";
		//Cock adjectives and nouns
		descripted = false;
		//Same
		if(same) {
			if(currCock == normalCocks) {
				descript += cockAdjective() + " ";	
				descript += Appearance.cockNoun(CockTypesEnum.HUMAN) + "s";
				descripted = true;
			}
			if(currCock == dogCocks) {
				descript += cockAdjective() + ", ";
				descript += Appearance.cockNoun(CockTypesEnum.DOG) + "s";
				descripted = true;
			}
			if(currCock == horseCocks) {
				descript += cockAdjective() + ", ";
				descript += Appearance.cockNoun(CockTypesEnum.HORSE) + "s";
				descripted = true;			
			}
			if(player.cocks[0].cockType.Index > 2) {
				descript += cockAdjective() + ", ";
				descript += Appearance.cockNoun(player.cocks[0].cockType) + "s";
				descripted = true;			
			}
		}
		//If mixed
		if(!descripted) {
			descript += cockAdjective() + ", ";
			rando = rand(4);
			if(rando == 0) descript += "mutated cocks";
			if(rando == 1) descript += "mutated dicks";
			if(rando == 2) descript += "mixed cocks";
			if(rando == 3) descript += "mismatched dicks";
		}
	}	
	return descript;
}
function eMultiCockDescriptLight():String {
	if(monster.cocks.length < 1) return "<B>Error: eMultiCockDescriptLight() called with no penises present.</B>";
	//Get cock counts
	var descript:String="";
	var currCock:Number = 0;
	var totCock:Number = monster.cocks.length;
	var dogCocks:Number = 0;
	var horseCocks:Number = 0;
	var normalCocks:Number = 0;
	var normalCockKey:Number = 0;
	var dogCockKey:Number = 0;
	var horseCockKey:Number = 0;
	var averageLength:Number = 0;
	var averageThickness:Number = 0;
	var same:Boolean = true;
	//For temp14 random values
	var rando:Number = 0;
	var descripted:Boolean = false;
	//If one, return normal cock descript
	if(totCock == 1) return eCockDescript(0);
	//Count cocks & Prep average totals
	while(currCock <= totCock-1) {
		if(monster.cocks[currCock].cockType == CockTypesEnum.HUMAN) {
			normalCocks++;
			normalCockKey = currCock;
		}
		if(monster.cocks[currCock].cockType == CockTypesEnum.HORSE) {
			horseCocks++;
			horseCockKey = currCock;
		}
		if(monster.cocks[currCock].cockType == CockTypesEnum.DOG) {
			dogCocks++;
			dogCockKey = currCock;
		}
		averageLength += monster.cocks[currCock].cockLength;
		averageThickness += monster.cocks[currCock].cockThickness;
		//If cocks are matched make sure they still are
		if(same && currCock > 0 && monster.cocks[currCock].cockType != monster.cocks[currCock-1].cockType) same = false;
		currCock++;
	}
	//Crunch averages
	averageLength /= currCock;
	averageThickness /= currCock;
	//Quantity descriptors
	if(currCock == 1) {
		if(dogCocks == 1) return eCockDescript(0);
		if(horseCocks == 1) return eCockDescript(0);
		if(normalCocks == 1) return eCockDescript(0);
		//Failsafe
		return eCockDescript(0);
	}
	if(currCock == 2) {
		//For cocks that are the same
		if(same) {
			rando = rand(5);
			if(rando == 0) descript += "pair of ";
			if(rando == 1) descript += "two ";
			if(rando == 2) descript += "brace of ";			
			if(rando == 3) descript += "matching ";
			if(rando == 4) descript += "twin "
			descript += eCockAdjectives(averageLength, averageThickness, monster.cocks[0].cockType);
			if(normalCocks == 2) descript += eCockNoun(CockTypesEnum.HUMAN) + "s";
			if(horseCocks == 2) descript += eCockNoun(CockTypesEnum.HORSE) + "s";
			if(dogCocks == 2) descript += eCockNoun(CockTypesEnum.DOG) + "s";
			//Failsafe
			if(monster.cocks[0].cockType.Index > 2) descript += eCockNoun(monster.cocks[0].cockType) + "s";
		}
		//Nonidentical
		else {
			rando = rand(3);
			if(rando == 0) descript += "pair of ";
			if(rando == 1) descript += "two ";
			if(rando == 2) descript += "brace of ";
			descript += eCockAdjectives(averageLength, averageThickness, monster.cocks[0].cockType);
			rando = rand(4);
			if(rando == 0) descript += "mutated cocks";
			if(rando == 1) descript += "mutated dicks";
			if(rando == 2) descript += "mixed cocks";
			if(rando == 3) descript += "mismatched dicks";
		}
	}
	if(currCock == 3) {
		//For samecocks
		if(same) {
			rando = rand(5);
			if(rando == 0) descript += "three ";
			if(rando == 1) descript += "group of ";
			if(rando == 2) descript += "menage a trois of ";
			if(rando == 3) descript += "triad of ";
			if(rando == 4) descript += "triumvirate of ";
			descript += eCockAdjectives(averageLength, averageThickness, monster.cocks[currCock-1].cockType);
			if(normalCocks == 3) descript += eCockNoun(CockTypesEnum.HUMAN) + "s";
			if(horseCocks == 3) descript += eCockNoun(CockTypesEnum.HORSE) + "s";
			if(dogCocks == 3) descript += eCockNoun(CockTypesEnum.DOG) + "s";
			//Tentacles
			if(monster.cocks[0].cockType.Index > 2) descript += eCockNoun(monster.cocks[0].cockType) + "s";
		}
		else {
			rando = rand(2);
			if(rando == 0) descript += "three ";
			if(rando == 1) descript += "group of ";
			descript += eCockAdjectives(averageLength, averageThickness, monster.cocks[0].cockType);
			rando = rand(4);
			if(rando == 0) descript += "mutated cocks";
			if(rando == 1) descript += "mutated dicks";
			if(rando == 2) descript += "mixed cocks";
			if(rando == 3) descript += "mismatched dicks";
		}
	}
	//Large numbers of cocks!
	if(currCock > 3)
	{
		rando = rand(4);
		if(rando == 0) descript += "bundle of ";
		if(rando == 1) descript += "obscene group of ";
		if(rando == 2) descript += "cluster of ";
		if(rando == 3) descript += "wriggling bunch of ";
		//Cock adjectives and nouns
		descripted = false;
		//Same
		if(same) {
			if(currCock == normalCocks) {
				descript += eCockAdjectives(averageLength, averageThickness, 0);	
				descript += eCockNoun(CockTypesEnum.HUMAN) + "s";
				descripted = true;
			}
			if(currCock == dogCocks) {
				descript += eCockAdjectives(averageLength, averageThickness, 2);
				descript += eCockNoun(CockTypesEnum.DOG) + "s";
				descripted = true;
			}
			if(currCock == horseCocks) {
				descript += eCockAdjectives(averageLength, averageThickness, 1);
				descript += eCockNoun(CockTypesEnum.HORSE) + "s";
				descripted = true;			
			}
			if(monster.cocks[0].cockType.Index > 2) {
				descript += eCockAdjectives(averageLength, averageThickness, 1);
				descript += eCockNoun(monster.cocks[0].cockType) + "s";
				descripted = true;			
			}
		}
		//If mixed
		if(!descripted) {
			descript += eCockAdjectives(averageLength, averageThickness, monster.cocks[0].cockType);
			rando = rand(4);
			if(rando == 0) descript += "mutated cocks";
			if(rando == 1) descript += "mutated dicks";
			if(rando == 2) descript += "mixed cocks";
			if(rando == 3) descript += "mismatched dicks";
		}
	}	
	return descript;
}

function eCockHead(cockNum:Number = 0):String {
	if(cockNum < 0) return "ERROR";
	if(cockNum > monster.cocks.length-1) return "ERROR";
	if(monster.cocks[cockNum].cockType == CockTypesEnum.HORSE) {
		if(rand(2) == 0) return "flare";
		else return "flat tip";
	}
	if(monster.cocks[cockNum].cockType == CockTypesEnum.DOG) {
		if(rand(2) == 0) return "pointed tip";
		else return "narrow tip";
	}
	if(monster.cocks[cockNum].cockType == CockTypesEnum.DEMON) {
		if(rand(2) == 0) return "tainted crown";
		else return "nub-ringed tip";
	}
	if(monster.cocks[cockNum].cockType == CockTypesEnum.TENTACLE) {
		if(rand(2) == 0) return "mushroom-like tip";
		else return "wide plant-like crown";
	}
	if(monster.cocks[cockNum].cockType == CockTypesEnum.CAT) {
		if(rand(2) == 0) return "point";
		else return "narrow tip";
	}
	if(monster.cocks[cockNum].cockType == CockTypesEnum.LIZARD) {
		if(rand(2) == 0) return "crown";
		else return "head";
	}
	if(monster.cocks[cockNum].cockType == CockTypesEnum.LIZARD) {
		if(rand(2) == 0) return "blue tip";
		else return "wiggling crown";
	}
	if(monster.cocks[cockNum].cockType == CockTypesEnum.KANGAROO) {
		if(rand(2) == 0) return "tip";
		else return "point";
	}
	if(rand(2) == 0) return "crown";
	if(rand(2) == 0) return "head";
	return "cock-head";
}




//Used in multiCockDescript and potentiall elsewhere - barebones cock names
function eCockNoun(type:CockTypesEnum):String {
	var descript:String = "";
	var rando:Number = 0;
	if(type == CockTypesEnum.HUMAN) {
		rando = rand(10) + 1;
		if(rando >= 0 && rando <=4) descript += "cock";
		if(rando ==5 || rando == 6) descript += "prick";
		if(rando == 7) descript += "pecker";
		if(rando > 7) descript += "shaft";
	}
	if(type == CockTypesEnum.DOG) {
		rando=int(Math.random()*11);
		if(rando == 0) descript+="doggie dong";
		if(rando == 1) descript+="canine shaft";
		if(rando == 2) descript+="pointed prick";
		if(rando == 3) descript+="dog-shaft";
		if(rando == 4) descript+="dog-cock";
		if(rando == 5) descript+="puppy-pecker";
		if(rando == 6) descript+="dog-dick";
		if(rando == 7) descript+="pointed shaft";
		if(rando == 8) descript+="canine cock";
		if(rando == 9) descript+="canine cock";
		if(rando == 10) descript+="dog cock";
	}
	if(type == CockTypesEnum.HORSE) {
		rando = rand(6);
		if(rando == 0) descript+="horsecock";
		if(rando == 1) descript+="equine prick";
		if(rando == 2) descript+="horse-shaft";
		if(rando == 3) descript+="horse-prick";
		if(rando == 4) descript+="stallion-prick";
		if(rando == 5) descript+="equine dong";
	}
	if(type == CockTypesEnum.DEMON) {
		rando=int(Math.random()*11);
		if(rando == 0) descript+="demon-dick";
		if(rando == 1) descript+="nubby shaft";
		if(rando == 2) descript+="corrupted cock";
		if(rando == 3) descript+="perverse pecker";
		if(rando == 4) descript+="bumpy demon-dick";
		if(rando == 5) descript+="demonic cock";
		if(rando == 6) descript+="demonic dong";
		if(rando == 7) descript+="cursed cock";
		if(rando == 8) descript+="infernal prick";
		if(rando == 9) descript+="unholy cock";
		if(rando == 10) descript+="blighted cock";
	}
	if(type == CockTypesEnum.TENTACLE) {
		rando=int(Math.random()*11);
		if(rando == 0) descript+="tentacle prick";
		if(rando == 1) descript+="plant-like shaft";
		if(rando == 2) descript+="tentacle cock";
		if(rando == 3) descript+="cock-tendril";
		if(rando == 4) descript+="tentacle pecker";
		if(rando == 5) descript+="plant prick";
		if(rando == 6) descript+="penile flora";
		if(rando == 7) descript+="smooth inhuman shaft";
		if(rando == 8) descript+="tentacle dick";
		if(rando == 9) descript+="vine prick";
		if(rando == 10) descript+="vine-like cock";
	}
	if(type == CockTypesEnum.CAT) {
		rando=int(Math.random()*11);
		if(rando == 0) descript+="feline dick";
		if(rando == 1) descript+="cat-cock";
		if(rando == 2) descript+="kitty-cock";
		if(rando == 3) descript+="spiny prick";
		if(rando == 4) descript+="pussy-prick";
		if(rando == 5) descript+="cat-penis";
		if(rando == 6) descript+="feline member";
		if(rando == 7) descript+="spined shaft";
		if(rando == 8) descript+="feline shaft";
		if(rando == 9) descript+="'barbed' dick";
		if(rando == 10) descript+="kitten-prick";
	}
	if(type == CockTypesEnum.LIZARD) {
		rando=int(Math.random()*11);
		if(rando == 0) descript+="reptile-dick";
		if(rando == 1) descript+="purple cock";
		if(rando == 2) descript+="inhuman cock";
		if(rando == 3) descript+="reptilian prick";
		if(rando == 4) descript+="purple prick";
		if(rando == 5) descript+="purple member";
		if(rando == 6) descript+="serpentine member";
		if(rando == 7) descript+="serpentine shaft";
		if(rando == 8) descript+="reptilian shaft";
		if(rando == 9) descript+="snake-shaft";
		if(rando == 10) descript+="snake dick";
	}
	return descript;
}
//Used in multiCockDescript to avoid duplicate code
function eCockAdjectives(cLength:Number, thickness:Number, type:CockTypesEnum):String {
	var descript:String = "";
	var rando:Number = 0;
	var descripted:Boolean = false;
	//length or thickness, usually length. 
	if(rand(2) == 0) {
		if(cLength < 3) {
			if(rand(3) == 0) descript = "squat ";
			else descript = "tiny ";
		}
		if(cLength >= 3 && cLength < 5) {
			if(rand(2) == 0) descript = "short ";
			else descript = "small ";
		}
		if(cLength >= 5 && cLength < 7) {
			if(rand(2) == 0) descript = "average ";
			else descript = "ordinary ";
		}
		if(cLength >= 7 && cLength < 9) {
			if(rand(2) == 0) descript = "long ";
			else descript = "lengthy ";
		}
		if(cLength >= 10 && cLength < 13) {
			if(rand(2) == 0) descript = "huge ";
			else descript = "foot-long ";
		}
		if(cLength >= 13 && cLength < 18) {
			if(rand(2) == 0) descript = "massive ";
			else descript = "horse-length ";
		}
		if(cLength >= 18 && cLength < 30) {
			if(rand(2) == 0) descript = "enormous ";
			else descript = "monster-length ";
		}
		if(cLength >= 30) {
			if(rand(2) == 0) descript = "towering ";
			else descript = "freakish ";
		}
		descripted = true;
	}
	//thickness go!
	if(rand(3) == 0 && !descripted) {
		if(thickness <= .75) descript += "narrow "
		if(thickness > 1 && thickness <= 1.4) {
			if(rand(2) == 0) descript += "ample ";
			else descript += "big ";
		}
		if(thickness > 1.4 && thickness <= 2) {
			if(rand(2) == 0) descript += "broad ";
			else descript += "girthy ";
		}
		if(thickness > 2 && thickness <= 3.5) {
			if(rand(2) == 0) descript += "fat ";
			else descript += "distended ";
		}
		if(thickness > 3.5) {
			if(rand(2) == 0) descript += "inhumanly distended ";
			else descript += "monstrously thick ";
		}
		descripted = true;
	}
	//Length/Thickness done.  Moving on to special animal characters/lust stuff.
	//Only room for one of these adjectives.
	//Lust stuff
	if(monster.lust > 90 && rand(2) == 0) {
		//lots of cum? drippy.
		if(monster.cumQ() > 50 && monster.cumQ() < 200 && rand(2) == 0) {
			//for hroses and dogs
			if(type == CockTypesEnum.HORSE || type == CockTypesEnum.DOG || CockTypesEnum.CAT || CockTypesEnum.KANGAROO) descript += "animal-pre leaking ";
			else descript += "pre-slickened ";
			descripted = true;
		}
		//Tons of cum
		if(monster.cumQ() >= 200 && rand(2) == 0) {
			//for horses and dogs
			if(type == CockTypesEnum.HORSE || type == CockTypesEnum.DOG || CockTypesEnum.CAT || CockTypesEnum.KANGAROO) descript += "animal-spunk dripping ";
			else descript += "cum-drooling ";
			descripted = true;
		}
		//Not descripted? Pulsing and twitching
		if(!descripted){
			if(rand(2) == 0) descript += "throbbing ";
			else descript += "pulsating ";
			descripted = true;
		}
	}
	//A little less lusty, but still lusty.
	if(monster.lust > 75 && monster.lust <= 90 && rand(3) == 0) {
		if(!descripted && monster.cumQ() > 50 && monster.cumQ() < 200 && rand(2) == 0) {
			descript += "pre-leaking ";
			descripted = true;
		}
		if(!descripted && player.cumQ() >= 200 && rand(2) == 0) {
			descript += "pre-cum dripping ";
			descripted = true;
		}
		if(!descripted) {
			if(rand(2) == 0) descript += "rock-hard ";
			else descript += "eager ";
			descripted = true;
		}
	}
	//animal fillers
	if(type == CockTypesEnum.HORSE && !descripted && rand(2) == 0) {
		if(rand(2) == 0) descript += "flared ";
		else descript += "musky ";
		descripted = true;
	}
	if((type == CockTypesEnum.DOG || CockTypesEnum.CAT) && !descripted && rand(2) == 0) {
		if(rand(2) == 0) descript += "musky ";
		else descript += "pointed ";
		descripted = true;
	}
	return descript;
}


//New cock adjectives.  The old one sucked dicks
function cockAdjective(cockNum:Number = -1) {
	var descript:String = "";
	var rando:Number = 0;
	var multi:Boolean = false;
	//If used for multiple cocks, set multi flag
	if(cockNum < 0) {
		//Since we have multi dicks lets talk about the biggest!
		cockNum = player.biggestCockIndex();
		multi = true;
	}
	//Pierced - 1/5 chance
	if(!multi && rand(5) == 0 && player.cocks[cockNum].pierced > 0) {
		descript += "pierced";
	}
	else if(!multi && rand(5) == 0 && player.cocks[cockNum].sock != "") {
		rando = rand(6);
		if(rando == 0) descript += "sock-sheathed";
		else if(rando == 1) descript += "garment-wrapped";
		else if(rando == 2) descript += "smartly dressed";
		else if(rando == 3) descript += "cloth-shrouded";
		else if(rando == 4) descript += "fabric swaddled";
		else descript += "covered";
	}
	//Goo - 1/4 chance
	else if(player.skinType == 3 && rand(4) == 0) {
		rando = rand(3);
		if(rando == 0) descript += "goopey";
		else if(rando == 1) descript += "gooey";
		else descript += "slimy";
	}
	//Length 1/3 chance
	else if(rand(3) == 0) {
		if(player.cocks[cockNum].cockLength < 3) {
			rando = rand(4);
			if(rando == 0) descript = "little";
			else if(rando == 1) descript = "toy-sized";
			else if(rando == 2) descript = "mini";
			else if(rando == 3) descript = "budding";
			else descript = "tiny";
		}
		else if(player.cocks[cockNum].cockLength < 5) {
			rando = rand(2);
			if(rando == 0) descript = "short";
			else descript = "small";
		}
		else if(player.cocks[cockNum].cockLength < 7) {
			rando = rand(2);
			if(rando == 0) descript = "fair-sized";
			else descript = "nice";
		}
		else if(player.cocks[cockNum].cockLength < 11) {
			rando = rand(3);
			if(rando == 0) {
				if(player.cocks[cockNum].cockType == CockTypesEnum.HORSE) descript = "pony-sized";
				else descript = "long";
			}
			else if(rando == 1) {
				if(player.cocks[cockNum].cockType == CockTypesEnum.HORSE) descript = "colt-like";
				else descript = "lengthy";
			}
			else descript = "sizable";
		}
		else if(player.cocks[cockNum].cockLength < 14) {
			rando = rand(3);
			if(rando == 0) descript = "huge";
			else if(rando == 1) {
				if(player.cocks[cockNum].cockType == CockTypesEnum.DOG) descript = "mastiff-like";
				else descript = "cucumber-length";
			}
			else descript = "foot-long";
		}
		else if(player.cocks[cockNum].cockLength < 18) {
			rando = rand(3);
			if(rando == 0) descript = "massive";
			else if(rando == 1) descript = "knee-length";
			else descript = "forearm-length";
		}
		else if(player.cocks[cockNum].cockLength < 30) {
			rando = rand(3);
			if(rando == 0) descript = "enormous";
			else if(rando == 1) descript = "giant";
			else descript = "arm-like";
		}
		else {
			rando = rand(4);
			if(player.cocks[cockNum].cockType == CockTypesEnum.TENTACLE && rand(4) == 0) descript = "coiled ";
			else {
				if(rando == 0) descript = "towering";
				else if(rando == 1) descript = "freakish";
				else if(rando == 2) descript = "monstrous";
				else descript = "massive";
			}
		}
	}
	//Hornyness 1/2
	else if(player.lust > 75 && rand(2) == 0) {
		//Uber horny like a baws!
		if(player.lust > 90) {
			//Weak as shit cum
			if(player.cumQ() < 50){
				if(rand(2) == 0) descript += "throbbing";
				else descript += "pulsating";
			}
			//lots of cum? drippy.
			else if(player.cumQ() < 200) {
				rando = rand(3);
				if(rando == 0) descript += "dribbling";
				else if(rando == 1) descript += "drooling";
				else descript += "leaking";
			}
			//Tons of cum
			else {
				rando = rand(5);
				if(rando == 0) descript += "very drippy";
				else if(rando == 1) descript += "pre-gushing";
				else if(rando == 2) descript += "cum-bubbling";
				else if(rando == 3) descript += "pre-slicked";
				else descript += "pre-drooling";
			}
		}
		//A little less lusty, but still lusty.
		else if(player.lust > 75) {
			if(player.cumQ() < 50) {
				rando = rand(5);
				if(rando == 0) descript += "turgid";
				else if(rando == 1) descript += "blood-engorged";
				else if(rando == 2) descript += "rock-hard";
				else if(rando == 3) descript += "stiff";
				else descript += "eager";
			}
			//A little drippy
			else if(player.cumQ() < 200) {
				rando = rand(10);
				if(rando == 0) descript += "turgid";
				else if(rando == 1) descript += "blood-engorged";
				else if(rando == 2) descript += "rock-hard";
				else if(rando == 3) descript += "stiff";
				else if(rando == 4) descript += "eager";
				else if(rando < 7) descript += "fluid-beading";
				else descript += "slowly-oozing";
			}
			//uber drippy
			else {
				rando = rand(4);
				if(rando == 0) descript += "dribbling";
				else if(rando == 1) descript += "drooling";
				else if(rando == 2) descript += "fluid-leaking";
				else descript += "leaking";
			}
		}
	}
	//Girth - fallback
	else {
		if(player.cocks[cockNum].cockThickness <= .75) {
			rando = rand(3);
			if(rando == 0) descript += "thin";
			else if(rando == 1) descript += "slender";
			else descript += "narrow";
		}
		else if(player.cocks[cockNum].cockThickness <= 1.2) {
			descript += "ample";
		}
		else if(player.cocks[cockNum].cockThickness <= 1.4) {
			rando = rand(2);
			if(rando == 0) descript += "ample";
			else descript += "big";
		}
		else if(player.cocks[cockNum].cockThickness <= 2) {
			rando = rand(3);
			if(rando == 0) descript += "broad";
			else if(rando == 1) descript += "girthy";
			else descript += "meaty";
		}
		else if(player.cocks[cockNum].cockThickness <= 3.5) {
			rando = rand(3);
			if(rando == 0) descript += "fat";
			else if(rando == 1) descript += "wide";
			else descript += "distended";
		}
		else if(player.cocks[cockNum].cockThickness > 3.5) {
			rando = rand(3);
			if(rando == 0) descript += "inhumanly distended";
			else if(rando == 1) descript += "bloated";
			else descript += "monstrously thick";
		}
	}
	return descript;
}

//Used in multiCockDescript to avoid duplicate code
function cockAdjectives(cLength:Number, thickness:Number, type:Number):String {
	var descript:String = "";
	var rando:Number = 0;
	var descripts:Number = 0;
	//length or thickness, usually length. 
	if(rand(4) == 0) {
		if(cLength < 3) {
			rando = rand(3);
			if(rando == 0) descript = "little";
			else if(rando == 1) descript = "toy-sized";
			else descript = "tiny";
		}
		else if(cLength < 5) {
			if(rand(2) == 0) descript = "short";
			else descript = "small";
		}
		else if(cLength < 7) {
			if(rand(2) == 0) descript = "fair-sized";
			else descript = "nice";
		}
		else if(cLength < 9) {
			rando = rand(3);
			if(rando == 0) descript = "long";
			else if(rando == 1) descript = "lengthy";
			else if(rando == 2) descript = "sizable";
		}
		else if(cLength < 13) {
			if(rand(2) == 0) descript = "huge";
			else descript = "foot-long";
		}
		else if(cLength < 18) {
			if(rand(2) == 0) descript = "massive";
			else descript = "forearm-length";
		}
		else if(cLength < 30) {
			if(rand(2) == 0) descript = "enormous";
			else descript = "monster-length";
		}
		else {
			rando = rand(3);
			if(rando == 0) descript = "towering";
			else if(rando == 1) descript = "freakish";
			else descript = "massive";
		}
		descripts = 1;
	}
	//thickness go!
	else if(rand(4) == 0 && descripts == 0) {
		if(thickness <= .75) descript += "narrow";
		else if(thickness <= 1.1) descript += "nice";
		else if(thickness <= 1.4) {
			if(rand(2) == 0) descript += "ample";
			else descript += "big";
		}
		else if(thickness <= 2) {
			if(rand(2) == 0) descript += "broad";
			else descript += "girthy";
		}
		else if(thickness <= 3.5) {
			if(rand(2) == 0) descript += "fat";
			else descript += "distended";
		}
		else  {
			if(rand(2) == 0) descript += "inhumanly distended";
			else descript += "monstrously thick";
		}
		descripts = 1;
	}
	//Length/Thickness done.  Moving on to special animal characters/lust stuff.
	/*Animal Fillers - turned off due to duplication in noun segment
	else if(type == 1 && descripts == 0 && rand(2) == 0) {
		if(rand(2) == 0) descript += "flared ";
		else descript += "musky ";
	}
	else if(type == 2 && descripts == 0 && rand(2) == 0) {
		descript += "musky ";
	}*/
	//FINAL FALLBACKS - lust descriptors
	//Lust stuff
	else if(player.lust > 90) {
		//lots of cum? drippy.
		if(player.cumQ() > 50 && player.cumQ() < 200 && rand(2) == 0) {
			//for hroses and dogs
			if(type == 1 || type == 2) descript += "animal-pre leaking";
			else descript += "pre-slickened";
			descripts = 1;
		}
		//Tons of cum
		if(player.cumQ() >= 200 && rand(2) == 0) {
			//for horses and dogs
			if(type == 1 || type == 2) descript += "animal-spunk dripping";
			else descript += "cum-drooling";
			descripts = 1;
		}
		//Not descripted? Pulsing and twitching
		if(descripts == 0){
			if(rand(2) == 0) descript += "throbbing";
			else descript += "pulsating";
			descripts = 1;
		}
	}
	//A little less lusty, but still lusty.
	else if(player.lust > 75) {
		if(descripts == 0 && player.cumQ() > 50 && player.cumQ() < 200 && rand(2) == 0) {
			descript += "pre-leaking";
			descripts = 1;
		}
		if(descripts == 0 && player.cumQ() >= 200 && rand(2) == 0) {
			descript += "pre-cum dripping";
			descripts = 1;
		}
		if(descripts == 0) {
			if(rand(2) == 0) descript += "rock-hard";
			else descript += "eager";
			descripts = 1;
		}
	}
	//Not lusty at all, fallback adjective
	else if(player.lust > 50) descript += "hard";
	else descript += "ready";
	return descript;
}


function cockDescript(cockNum:Number):String 
{
	// trace("CockIndex:", cockNum);
	if(player.totalCocks() == 0) return "<b>ERROR: CockDescript Called But No Cock Present</b>";
	if(player.cockTotal() <= cockNum && cockNum != 99) return "<b>ERROR: CockDescript called with index of " + cockNum + " - out of BOUNDS</b>";
	//Cocknum 99 to default to boring descriptions!
	if(cockNum != 99) 
	{
		if(player.cocks[cockNum].cockType == CockTypesEnum.HORSE)
		{
			// trace("CockTypeFound - HORSE");
			return horseDescript(cockNum);
		}
		else if(player.cocks[cockNum].cockType == CockTypesEnum.DOG)
		{
			// trace("CockTypeFound - DOG");
			return dogDescript(cockNum);
		}
		else if(player.cocks[cockNum].cockType == CockTypesEnum.FOX)
		{
			// trace("CockTypeFound - FOX");
			return dogDescript(cockNum);
		}
		else if(player.cocks[cockNum].cockType == CockTypesEnum.TENTACLE)
		{
			// trace("CockTypeFound - TENTACLE");
			return tentacleDescript(cockNum);
		}
		else if(player.cocks[cockNum].cockType == CockTypesEnum.DEMON)
		{
			// trace("CockTypeFound - DEMON");
			return demonDescript(cockNum);
		}
		else if(player.cocks[cockNum].cockType == CockTypesEnum.CAT)
		{
			// trace("CockTypeFound - CAT");
			return catDescript(cockNum);
		}
		else if(player.cocks[cockNum].cockType == CockTypesEnum.LIZARD)
		{
			// trace("CockTypeFound - LIZARD");
			return snakeDescript(cockNum);
		}
		else if(player.cocks[cockNum].cockType == CockTypesEnum.ANEMONE)
		{
			// trace("CockTypeFound - ANEMONE");
			return anemoneDescript(cockNum);
		}
		else if(player.cocks[cockNum].cockType == CockTypesEnum.KANGAROO)
		{
			// trace("CockTypeFound - KANGAROO");
			return kangaDescript(cockNum);
		}
		else if(player.cocks[cockNum].cockType == CockTypesEnum.DRAGON)
		{
			// trace("CockTypeFound - DRAGON");
			return dragonDescript(cockNum);
		}
		else if(player.cocks[cockNum].cockType == CockTypesEnum.DISPLACER)
		{
			// trace("CockTypeFound - DISPLACER");
			return displacerDescript(cockNum);
		}
		else if(player.cocks[cockNum].cockType == CockTypesEnum.HUMAN)
		{
			// trace("CockTypeFound - HUMAN");
			return humanDescript(cockNum);
		}
		else
		{
			trace("Cock type failed to match. ERROR", player.cocks[cockNum].cockType);
			return "Shit be failed, man!";
		}
	}
	else 
		cockNum = 0;

	trace("Fell through the if statement. Wut?", cockNum, player.cocks[cockNum].cockType);
	throw new Error("Fell through the cockType if statement. Wut?");
	var descript:String = "";
	//50% of the time add a descriptor
	if(rand(2) == 0) 
		descript += cockAdjective(cockNum) + " ";
	var rando:Number = 0;
	rando=int(Math.random()*10)
	if(rando >= 0 && rando <=4) descript += "cock";
	if(rando ==5 || rando == 6) descript += "prick";
	if(rando == 7) descript += "pecker";
	if(rando > 7) descript += "shaft";

	return descript;
}

function humanDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: humanDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to kangaDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to kangaDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}

function kangaDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: kangaDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to kangaDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to kangaDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}
function dogDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: CockDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to dogDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to dogDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(CockTypesEnum.DOG);
	return descript;
}
function tentacleDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: CockDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to tentacleDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to tentacleDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) 
		descript += cockAdjective(cockNum) + ", ";

	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}
function demonDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) 
		return "<b>ERROR: CockDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) 
		return "<B>Error: Invalid cock number (" + cockNum + ") passed to demonDescript()</b>";
	if(cockNum < 0) 
		return "<B>Error: Invalid cockNum (" + cockNum + ") passed to demonDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) 
		descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);

	// trace("DemonDescript Output - ", descript);
	// trace("Appearance.CockNoun = ", Appearance.cockNoun(player.cocks[cockNum].cockType), "cockType", player.cocks[cockNum].cockType);
	return descript;
}


//Horsecock + Descript
function horseDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: CockDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to horseDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to horseDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(CockTypesEnum.HORSE);
	return descript;
}

function catDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: catDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to catDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to catDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}

function anemoneDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: anemoneDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to anemoneDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to anemoneDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}
function dragonDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: dragonDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to dragonDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to dragonDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}

function displacerDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: dragonDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to dragonDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to dragonDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}


function snakeDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: snakeDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to snakeDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to snakeDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}
//Vaginas + Descript
function eVaginaDescript(vaginaNum):String {
	var vag:String="";
	var keyNum:Number = monster.vaginas.length-1;
	var rand:Number = 0;
	//If no vaginas back the fuck out
	if(keyNum < 0) return "VAGINA ERROR";
	//tightness descript - 40% display rate
	if(monster.vaginas[vaginaNum].vaginalLooseness == 0) rand = 61;
	if(monster.vaginas[vaginaNum].vaginalLooseness == 4 || monster.vaginas[vaginaNum].vaginalLooseness == 5) rand = 10;
	if(int(Math.random()*100) + rand > 60) {
		if(monster.vaginas[vaginaNum].vaginalLooseness == 0 || monster.vaginas[vaginaNum].virgin) vag+="virgin ";
		if(monster.vaginas[vaginaNum].vaginalLooseness == 2) vag+="loose ";
		if(monster.vaginas[vaginaNum].vaginalLooseness == 3) vag+="very loose ";
		if(monster.vaginas[vaginaNum].vaginalLooseness == 4) vag+="gaping ";
		if(monster.vaginas[vaginaNum].vaginalLooseness == 5) vag+="gaping-wide ";
	}
	//wetness descript - 30% display rate
	if(int(Math.random()*100 > 70)) {
		if(monster.vaginas[vaginaNum].vaginalWetness == 0) vag+="dry ";
		if(monster.vaginas[vaginaNum].vaginalWetness == 2) vag+="wet ";
		if(monster.vaginas[vaginaNum].vaginalWetness == 3) vag+="slick ";
		if(monster.vaginas[vaginaNum].vaginalWetness == 4) vag+="drooling ";
		if(monster.vaginas[vaginaNum].vaginalWetness == 5) vag+="slavering ";
	}
	//cunt names
	rand = int(Math.random()*8);
	if(rand == 0) vag+="vagina";
	if(rand == 1 || rand == 2 || rand == 6) vag+="pussy";
	if(rand == 3 || rand == 4 || rand == 5) vag+="cunt";
	if(rand == 7)  vag+="fuck-hole";
	return vag;
}

//Enemy cock description - value of random cock or 1000 for normal, 1001 horse, 1002 dog.
function eCockDescript(cockNum:Number):String {
	var descript:String = "";
	var descripted:Boolean = false;
	var temp14:Number = 0;
	//Discuss length one in 3 times
	if(int(Math.random()*3 == 0)) {
		if(monster.cocks[cockNum].cockLength < 5) descript = "short ";
		if(monster.cocks[cockNum].cockLength >= 5 && monster.cocks[cockNum].cockLength < 7) descript = "average ";
		if(monster.cocks[cockNum].cockLength >= 7 && monster.cocks[cockNum].cockLength < 9) descript = "long ";
		if(monster.cocks[cockNum].cockLength >= 10 && monster.cocks[cockNum].cockLength < 13) descript = "huge ";
		if(monster.cocks[cockNum].cockLength >= 13 && monster.cocks[cockNum].cockLength < 18) descript = "massive ";
		if(monster.cocks[cockNum].cockLength >= 18 && monster.cocks[cockNum].cockLength < 30) descript = "enormous ";
		if(monster.cocks[cockNum].cockLength >= 30) descript = "towering ";	
		descripted = true;
	}
	//Discuss girth one in 2 times if not already talked about length.
	else if(int(Math.random()*2 == 0) && !descripted) {
		//narrow, thin, ample, broad, distended, voluminous
		if(monster.cocks[cockNum].cockThickness <= .75) descript = "narrow "
		if(monster.cocks[cockNum].cockThickness > 1 && monster.cocks[cockNum].cockThickness <= 1.4) descript = "ample ";
		if(monster.cocks[cockNum].cockThickness > 1.4 && monster.cocks[cockNum].cockThickness <= 2) descript = "broad ";
		if(monster.cocks[cockNum].cockThickness > 2 && monster.cocks[cockNum].cockThickness <= 3.5) descript = "fat ";
		if(monster.cocks[cockNum].cockThickness > 3.5) descript = "distended ";
		descripted = true;
	}
	if(descripted && monster.cocks[cockNum].cockType.Index > 0) descript += ", ";
	descript += Appearance.cockNoun(monster.cocks[cockNum].cockType);
	return descript;	
}
function allBreastsDescript():String {
	var storage:String = "";
	if(player.breastRows.length == 0) return "unremarkable chest muscles ";
	if(player.breastRows.length == 2) {
		//if(player.totalBreasts() == 4) storage += "quartet of ";
		storage += "two rows of ";
	}
	if(player.breastRows.length == 3) {
		if(rand(2) == 0) storage += "three rows of ";
		else storage += "multi-layered ";
	}
	if(player.breastRows.length == 4) {
		if(rand(2) == 0) storage += "four rows of ";
		else storage += "four-tiered ";
	}
	if(player.breastRows.length == 5) {
		if(rand(2) == 0) storage += "five rows of ";
		else storage += "five-tiered ";
	}	
	storage += biggestBreastSizeDescript();
	return storage;
}
	
function biggestBreastSizeDescript():String {
	var temp14:int = Math.random()*3;
	var descript:String = "";
	var temp142:int = player.biggestTitRow();
	//ERROR PREVENTION
	if(player.breastRows.length - 1 < temp142) return "<b>ERROR, biggestBreastSizeDescript() working with invalid breastRow</b>";
	else if(temp142 < 0) return "ERROR SHIT SON!  BIGGESTBREASTSIZEDESCRIPT PASSED NEGATIVE!";
	if(player.breastRows[temp142].breastRating < 1) return "flat breasts";
	//50% of the time size-descript them
	if(rand(2) == 0) descript += breastSize(player.breastRows[temp142].breastRating);
	//Nouns!
	temp14 = rand(10);
	if(temp14 == 0) descript += "breasts";
	if(temp14 == 1) {
		if(player.breastRows[temp142].lactationMultiplier > 2) descript += "milk-udders";
		else descript += "breasts";
	}
	if(temp14 == 2) {
		if(player.breastRows[temp142].lactationMultiplier > 1.5) descript += "milky ";
		if(player.breastRows[temp142].breastRating > 4) descript += "tits";
		else descript += "breasts";
	}
	if(temp14 == 3) {
		//if(player.breastRows[temp142].breastRating > 6) descript += "rack";
		descript += "breasts";
	}
	if(temp14 == 4) descript += "tits";
	if(temp14 == 5) descript += "tits";
	if(temp14 == 6) descript += "tits";
	if(temp14 == 7) {
		if(player.breastRows[temp142].lactationMultiplier >= 1 && player.breastRows[temp142].lactationMultiplier < 2.5) descript += "milk jugs";
		if(player.breastRows[temp142].lactationMultiplier >= 2.5) descript += "udders";
		if(player.breastRows[temp142].lactationMultiplier < 1) descript += "jugs";
	}
	if(temp14 == 8) {
		if(player.breastRows[temp142].breastRating > 6) descript += "love-pillows";
		else descript += "boobs";
	}
	if(temp14 == 9) {
		if(player.breastRows[temp142].breastRating > 6) descript += "tits";
		else descript += "breasts";
	}
	return descript;
}

function breastSize(val:Number):String {
	var descript:String = "";
	var choice:Number = 0;
	//Catch all for dudes.
	if(val < 1) return "manly ";
	//Small - A->B
	if(val <= 2)
	{
		choice = rand(4);
		if(choice == 0) descript += "palmable ";
		else if(choice == 1) descript += "tight ";
		else if(choice == 2) descript += "perky ";		
		else if(choice == 3) descript += "baseball-sized ";
	}
	//C-D
	else if(val <= 4)
	{
		choice = rand(5);
		if(choice == 0) descript += "nice ";
		else if(choice == 1) descript += "hand-filling ";
		else if(choice == 2) descript += "well-rounded ";
		else if(choice == 3) descript += "supple ";
		//else if(choice == 4) descript += "softball-sized ";
	}
	//DD->big EE
	else if(val < 11)
	{
		choice = rand(5);
		if(choice == 0) descript += "big ";
		if(choice == 1) descript += "large ";
		if(choice == 2) descript += "pillowy ";
		if(choice == 3) descript += "jiggly ";
		if(choice == 4) descript += "volleyball-sized ";
	}
	//F->big FF
	else if(val < 15) 
	{
		choice = rand(4);
		if(choice == 0) descript += "soccerball-sized ";
		else if(choice == 1) descript += "hand-overflowing ";
		else if(choice == 2) descript += "generous ";
		else if(choice == 3) descript += "jiggling ";
	}
	//G -> HHH
	else if(val < 24) {
		choice = rand(4);
		if(choice == 0) descript += "basketball-sized ";
		else if(choice == 1) descript += "whorish ";
		else if(choice == 2) descript += "cushiony ";
		else if(choice == 3) descript += "wobbling ";
	}
	//I -> KK
	else if(val < 35) {
		choice = rand(4);
		if(choice == 0) descript += "massive motherly ";
		else if(choice == 1) descript += "luscious ";
		else if(choice == 2) descript += "smothering ";
		else descript += "prodigious ";
	}
	//K- > MMM+
	else {
		choice = rand(5);
		if(choice == 0) descript += "mountainous ";
		else if(choice == 1) descript += "monumental ";
		else if(choice == 2) descript += "back-breaking ";
		else if(choice == 3) descript += "exercise-ball-sized ";
		else descript += "immense ";
	}
	return descript;
}
function breastDescript(rowNum:Number):String
{
	//ERROR PREVENTION
	if(player.breastRows.length - 1 < rowNum) return "<b>ERROR, breastDescript() working with invalid breastRow</b>";
	if(player.breastRows.length == 0) return "<b>ERROR, breastDescript() called when no breasts are present.</b>";
	var temp14:int = Math.random()*3;
	var descript:String = "";
	if(player.breastRows[rowNum].breastRating == 0) return "flat breasts";
	//50% of the time size-descript them
	if(rand(2) == 0) descript += breastSize(player.breastRows[rowNum].breastRating);
	//Nouns!
	temp14 = rand(10);
	if(temp14 == 0) descript += "breasts";
	if(temp14 == 1) {
		if(player.breastRows[rowNum].lactationMultiplier > 2) descript += "milk-udders";
		else descript += "breasts";
	}
	if(temp14 == 2) {
		if(player.breastRows[rowNum].lactationMultiplier > 1.5) descript += "milky ";
		if(player.breastRows[rowNum].breastRating > 4) descript += "tits";
		else descript += "breasts";
	}
	if(temp14 == 3) {
		//if(player.breastRows[rowNum].breastRating > 6) descript += "rack";
		descript += "breasts";
	}
	if(temp14 == 4) descript += "tits";
	if(temp14 == 5) descript += "tits";
	if(temp14 == 6) descript += "tits";
	if(temp14 == 7) {
		if(player.breastRows[rowNum].lactationMultiplier >= 1 && player.breastRows[rowNum].lactationMultiplier < 2.5) descript += "milk jugs";
		if(player.breastRows[rowNum].lactationMultiplier >= 2.5) descript += "udders";
		if(player.breastRows[rowNum].lactationMultiplier < 1) descript += "jugs";
	}
	if(temp14 == 8) {
		if(player.breastRows[rowNum].breastRating > 6) descript += "love-pillows";
		else descript += "boobs";
	}
	if(temp14 == 9) {
		if(player.breastRows[rowNum].breastRating > 6) descript += "tits";
		else descript += "breasts";
	}
	return descript;
}
function cockHead(cockNum:Number = 0):String {
	var temp:int;
	if(cockNum < 0) return "ERROR";
	if(cockNum > player.cocks.length-1) return "ERROR";
	if(player.cocks[cockNum].cockType == CockTypesEnum.HORSE) {
		if(rand(2) == 0) return "flare";
		else return "flat tip";
	}
	if(player.cocks[cockNum].cockType == CockTypesEnum.DOG) {
		if(rand(2) == 0) return "pointed tip";
		else return "narrow tip";
	}
	if(player.cocks[cockNum].cockType == CockTypesEnum.DEMON) {
		if(rand(2) == 0) return "tainted crown";
		else return "nub-ringed tip";
	}
	if(player.cocks[cockNum].cockType == CockTypesEnum.TENTACLE) {
		if(rand(2) == 0) return "mushroom-like tip";
		else return "wide plant-like crown";
	}
	if(player.cocks[cockNum].cockType == CockTypesEnum.CAT) {
		if(rand(2) == 0) return "point";
		else return "narrow tip";
	}
	if(player.cocks[cockNum].cockType == CockTypesEnum.LIZARD) {
		if(rand(2) == 0) return "crown";
		else return "head";
	}
	if(player.cocks[cockNum].cockType == CockTypesEnum.LIZARD) {
		if(rand(2) == 0) return "blue tip";
		else return "wiggling crown";
	}
	if(player.cocks[cockNum].cockType == CockTypesEnum.KANGAROO) {
		if(rand(2) == 0) return "tip";
		else return "point";
	}
	if(player.cocks[cockNum].cockType == CockTypesEnum.DISPLACER) {
		temp = rand(5);
		if(temp == 0) return "star tip";
		else if(temp == 1) return "blooming cock-head";
		else if(temp == 2) return "open crown";
		else if(temp == 3) return "alien tip";
		else return "bizarre head";
	}
	if(rand(2) == 0) return "crown";
	if(rand(2) == 0) return "head";
	return "cock-head";
}


function npcBreastDescript(size:Number):String
{
	//ERROR PREVENTION
	var temp14:int = Math.random()*3;
	var descript:String = "";
	if(size == 0) return "flat breasts";
	//50% of the time size-descript them
	if(rand(2) == 0) descript += breastSize(size);
	//Nouns!
	temp14 = rand(10);
	if(temp14 == 0) descript += "breasts";
	if(temp14 == 1) descript += "breasts";
	if(temp14 == 2) {
		if(size > 4) descript += "tits";
		else descript += "breasts";
	}
	if(temp14 == 3) {
		//if(size > 6) descript += "rack";
		descript += "breasts";
	}
	if(temp14 == 4) descript += "tits";
	if(temp14 == 5) descript += "tits";
	if(temp14 == 6) descript += "tits";
	if(temp14 == 7) descript += "jugs";
	if(temp14 == 8) {
		if(size > 6) descript += "love-pillows";
		else descript += "boobs";
	}
	if(temp14 == 9) {
		if(size > 6) descript += "tits";
		else descript += "breasts";
	}
	return descript;
}

function breastCup(size:Number):String {
	if(size < 1) return "flat, manly breast";
	else if(size < 2) return "A-cup";
	else if(size < 3) return "B-cup";
	else if(size < 4) return "C-cup";
	else if(size < 5) return "D-cup";
	else if(size < 6) return "DD-cup";
	else if(size < 7) return "big DD-cup";
	else if(size < 8) return "E-cup";
	else if(size < 9) return "big E-cup";
	else if(size < 10) return "EE-cup";
	else if(size < 11) return "big EE-cup";
	else if(size < 12) return "F-cup";
	else if(size < 13) return "big F-cup";
	else if(size < 14) return "FF-cup";
	else if(size < 15) return "big FF-cup";
	else if(size < 16) return "G-cup";
	else if(size < 17) return "big G-cup";
	else if(size < 18) return "GG-cup";
	else if(size < 19) return "big GG-cup";
	else if(size < 20) return "H-cup";
	else if(size < 21) return "big H-cup";
	else if(size < 22) return "HH-cup";
	else if(size < 23) return "big HH-cup";
	else if(size < 24) return "HHH-cup";
	else if(size < 25) return "I-cup";
	else if(size < 26) return "big I-cup";
	else if(size < 27) return "II-cup";
	else if(size < 28) return "big II-cup";
	else if(size < 29) return "J-cup";
	else if(size < 30) return "big J-cup";
	else if(size < 31) return "JJ-cup";
	else if(size < 32) return "big JJ-cup";
	else if(size < 33) return "K-cup";
	else if(size < 34) return "big K-cup";
	else if(size < 35) return "KK-cup";
	else if(size < 36) return "big KK-cup";
	else if(size < 37) return "L-cup";
	else if(size < 38) return "big L-cup";
	else if(size < 39) return "LL-cup";
	else if(size < 40) return "big LL-cup";
	else if(size < 41) return "M-cup";
	else if(size < 42) return "big M-cup";
	else if(size < 43) return "MM-cup";
	else if(size < 44) return "big MM-cup";
	else if(size < 45) return "MMM-cup";
	else if(size < 46) return "large MMM-cup";
	else if(size < 47) return "N-cup";
	else if(size < 48) return "large N-cup";
	else if(size < 49) return "NN-cup";
	else if(size < 50) return "large NN-cup";
	else if(size < 51) return "O-cup";
	else if(size < 52) return "large O-cup";
	else if(size < 53) return "OO-cup";
	else if(size < 54) return "large OO-cup";
	else if(size < 55) return "P-cup";
	else if(size < 56) return "large P-cup";
	else if(size < 57) return "PP-cup";
	else if(size < 58) return "large PP-cup";
	else if(size < 59) return "Q-cup";
	else if(size < 60) return "large Q-cup";
	else if(size < 61) return "QQ-cup";
	else if(size < 62) return "large QQ-cup";
	else if(size < 63) return "R-cup";
	else if(size < 64) return "large R-cup";
	else if(size < 65) return "RR-cup";
	else if(size < 66) return "large RR-cup";
	else if(size < 67) return "S-cup";
	else if(size < 68) return "large S-cup";
	else if(size < 69) return "SS-cup";
	else if(size < 70) return "large SS-cup";
	else if(size < 71) return "T-cup";
	else if(size < 72) return "large T-cup";
	else if(size < 73) return "TT-cup";
	else if(size < 74) return "large TT-cup";
	else if(size < 75) return "U-cup";
	else if(size < 76) return "large U-cup";
	else if(size < 77) return "UU-cup";
	else if(size < 78) return "large UU-cup";
	else if(size < 79) return "V-cup";
	else if(size < 80) return "large V-cup";
	else if(size < 81) return "VV-cup";
	else if(size < 82) return "large VV-cup";
	else if(size < 83) return "W-cup";
	else if(size < 84) return "large W-cup";
	else if(size < 85) return "WW-cup";
	else if(size < 86) return "large WW-cup";
	else if(size < 87) return "X-cup";
	else if(size < 88) return "large X-cup";
	else if(size < 89) return "XX-cup";
	else if(size < 90) return "large XX-cup";
	else if(size < 91) return "Y-cup";
	else if(size < 92) return "large Y-cup";
	else if(size < 93) return "YY-cup";
	else if(size < 94) return "large YY-cup";
	else if(size < 95) return "Z-cup";
	else if(size < 96) return "large Z-cup";
	else if(size < 97) return "ZZ-cup";
	else if(size < 98) return "large ZZ-cup";
	else if(size < 99) return "ZZZ-cup";
	else return "large ZZZ-cup"
}


function NPCCockDescript(cockType:*, cockLength:Number = 0, lust:Number = 50):String 
{
	if (cockType is int)
		cockType = CockTypesEnum.legacySuportLoadCockType(cockType);

	var descript:String = "";
	
	if(cockType != CockTypesEnum["HUMAN"])
	{
		descript += NPCCockAdjective(cockType,cockLength,lust);
		descript += ", ";
		descript += NPCCockNoun(cockType);
	}
	else
	{
		descript += NPCCockAdjective(cockType,cockLength,lust);
		descript += " ";
		descript += NPCCockNoun(cockType);
	}
	return descript;
}
	
//Modular NPC dicks!
function NPCCockNoun(type:*):String {
	var cockTypeNum:int;

	cockTypeNum = CockTypesEnum.legacySuportGetCockType(type);
	var descript:String = "";
	var rando:Number = 0;
	if(cockTypeNum == 0) {
		rando = rand(10) + 1;
		if(rando >= 0 && rando <=4) descript += "cock";
		if(rando ==5 || rando == 6) descript += "prick";
		if(rando == 7) descript += "pecker";
		if(rando > 7) descript += "shaft";
	}
	if(cockTypeNum == 2) {
		rando=int(Math.random()*11);
		if(rando == 0) descript+="dog-shaped dong";
		if(rando == 1) descript+="canine shaft";
		if(rando == 2) descript+="pointed prick";
		if(rando == 3) descript+="knotty dog-shaft";
		if(rando == 4) descript+="bestial cock";
		if(rando == 5) descript+="animalistic puppy-pecker";
		if(rando == 6) descript+="pointed dog-dick";
		if(rando == 7) descript+="pointed shaft";
		if(rando == 8) descript+="canine member";
		if(rando == 9) descript+="canine cock";
		if(rando == 10) descript+="knotted dog-cock";
	}
	if(cockTypeNum == 1) {
		rando = rand(6);
		if(rando == 0) descript+="flared horse-cock";
		if(rando == 1) descript+="equine prick";
		if(rando == 2) descript+="bestial horse-shaft";
		if(rando == 3) descript+="flat-tipped horse-member";
		if(rando == 4) descript+="animalistic stallion-prick";
		if(rando == 5) descript+="equine dong";
		if(rando == 6) descript+="beast cock";
		if(rando == 7) descript+="flared stallion-cock";
	}
	if(cockTypeNum == 3) {
		rando=int(Math.random()*11);
		if(rando == 0) descript+="nub-covered demon-dick";
		if(rando == 1) descript+="nubby shaft";
		if(rando == 2) descript+="corrupted cock";
		if(rando == 3) descript+="perverse pecker";
		if(rando == 4) descript+="bumpy demon-dick";
		if(rando == 5) descript+="demonic cock";
		if(rando == 6) descript+="demonic dong";
		if(rando == 7) descript+="cursed cock";
		if(rando == 8) descript+="infernal prick";
		if(rando == 9) descript+="unholy cock";
		if(rando == 10) descript+="blighted cock";
	}
	if(cockTypeNum == 4) {
		rando=int(Math.random()*11);
		if(rando == 0) descript+="twisting tentacle-prick";
		if(rando == 1) descript+="wriggling plant-shaft";
		if(rando == 2) descript+="sinuous tentacle-cock";
		if(rando == 3) descript+="squirming cock-tendril";
		if(rando == 4) descript+="writhing tentacle-pecker";
		if(rando == 5) descript+="wriggling plant-prick";
		if(rando == 6) descript+="penile flora";
		if(rando == 7) descript+="smooth shaft";
		if(rando == 8) descript+="undulating tentacle-dick";
		if(rando == 9) descript+="slithering vine-prick";
		if(rando == 10) descript+="vine-shaped cock";
	}
	if(cockTypeNum == 5) {
		rando=int(Math.random()*11);
		if(rando == 0) descript+="feline dick";
		if(rando == 1) descript+="spined cat-cock";
		if(rando == 2) descript+="pink kitty-cock";
		if(rando == 3) descript+="spiny prick";
		if(rando == 4) descript+="animalistic kitty-prick";
		if(rando == 5) descript+="oddly-textured cat-penis";
		if(rando == 6) descript+="feline member";
		if(rando == 7) descript+="spined shaft";
		if(rando == 8) descript+="feline shaft";
		if(rando == 9) descript+="barbed dick";
		if(rando == 10) descript+="nubby kitten-prick";
	}
	if(cockTypeNum == 6) {
		rando=int(Math.random()*11);
		if(rando == 0) descript+="reptilian dick";
		if(rando == 1) descript+="purple cock";
		if(rando == 2) descript+="inhuman cock";
		if(rando == 3) descript+="reptilian prick";
		if(rando == 4) descript+="purple prick";
		if(rando == 5) descript+="purple member";
		if(rando == 6) descript+="serpentine member";
		if(rando == 7) descript+="serpentine shaft";
		if(rando == 8) descript+="reptilian shaft";
		if(rando == 9) descript+="bulbous snake-shaft";
		if(rando == 10) descript+="bulging snake-dick";
	}
	if(cockTypeNum == 7) {
		rando = rand(11);
		if(rando == 0) descript+="anemone dick";
		if(rando == 1) descript+="tentacle-ringed cock";
		if(rando == 2) descript+="blue member";
		if(rando == 3) descript+="stinger-laden shaft";
		if(rando == 4) descript+="pulsating prick";
		if(rando == 5) descript+="anemone prick";
		if(rando == 6) descript+="stinger-coated member";
		if(rando == 7) descript+="blue cock";
		if(rando == 8) descript+="tentacle-ringed dick";
		if(rando == 9) descript+="near-transparent shaft";
		if(rando == 10) descript+="squirming shaft";
	}
	if(cockTypeNum == 8) {
		rando = rand(11);
		if(rando == 0) descript+="kangaroo-like dick";
		if(rando == 1) descript+="pointed cock";
		if(rando == 2) descript+="marsupial member";
		if(rando == 3) descript+="tapered shaft";
		if(rando == 4) descript+="curved pecker";
		if(rando == 5) descript+="pointed prick";
		if(rando == 6) descript+="squirming kangaroo-cock";
		if(rando == 7) descript+="marsupial cock";
		if(rando == 8) descript+="tapered kangaroo-dick";
		if(rando == 9) descript+="curved kangaroo-cock";
		if(rando == 10) descript+="squirming shaft";
	}
	if(cockTypeNum == 9) {
		rando = rand(11);
		if(rando == 0) descript+="dragon-like dick";
		if(rando == 1) descript+="segmented shaft";
		if(rando == 2) descript+="pointed prick";
		if(rando == 3) descript+="knotted dragon-cock";
		if(rando == 4) descript+="mythical mast";
		if(rando == 5) descript+="segmented tool";
		if(rando == 6) descript+="draconic dick";
		if(rando == 7) descript+="draconic cock";
		if(rando == 8) descript+="tapered dick";
		if(rando == 9) descript+="unusual endowment";
		if(rando == 10) descript+="scaly shaft";
	}
	return descript;
}

//Multipurpose NPC cock descs
function NPCCockAdjective(cockType:CockTypesEnum, cockLength:Number = 5, lust:Number = 50):String 
{	
	var descript:String = "";
	var rando:Number = 0;
	var multi:Boolean = false;
	//Length 1/3 chance
	if(rand(2) == 0) {
		if(cockLength < 3) {
			rando = rand(4);
			if(rando == 0) descript = "little";
			else if(rando == 1) descript = "toy-sized";
			else if(rando == 2) descript = "mini";
			else if(rando == 3) descript = "budding";
			else descript = "tiny";
		}
		else if(cockLength < 5) {
			rando = rand(2);
			if(rando == 0) descript = "short";
			else descript = "small";
		}
		else if(cockLength < 7) {
			rando = rand(2);
			if(rando == 0) descript = "fair-sized";
			else descript = "nice";
		}
		else if(cockLength < 9) {
			rando = rand(3);
			if(rando == 0) {
				if(cockType == CockTypesEnum.HORSE) descript = "pony-sized";
				else descript = "long";
			}
			else if(rando == 1) {
				if(cockType == CockTypesEnum.HORSE) descript = "colt-like";
				else descript = "lengthy";
			}
			else descript = "sizable";
		}
		else if(cockLength < 13) {
			rando = rand(3);
			if(rando == 0) descript = "huge";
			else if(rando == 1) {
				if(cockType == CockTypesEnum.DOG) descript = "mastiff-like";
				else descript = "cucumber-length";
			}
			else descript = "foot-long";
		}
		else if(cockLength < 18) {
			rando = rand(3);
			if(rando == 0) descript = "massive";
			else if(rando == 1) descript = "knee-length";
			else descript = "forearm-length";
		}
		else if(cockLength < 30) {
			rando = rand(3);
			if(rando == 0) descript = "enormous";
			else if(rando == 1) descript = "giant";
			else descript = "arm-like";
		}
		else {
			rando = rand(4);
			if(cockType == CockTypesEnum.TENTACLE && rand(4) == 0) descript = "coiled ";
			else {
				if(rando == 0) descript = "towering";
				else if(rando == 1) descript = "freakish";
				else if(rando == 2) descript = "monstrous";
				else descript = "massive";
			}
		}
	}
	//Hornyness 1/2
	else if(lust > 75 && rand(2) == 0) {
		//Uber horny like a baws!
		if(lust > 90) {
			//Weak as shit cum
			if(rand(2) == 0) descript += "throbbing";
			else descript += "pulsating";
		}
		//A little less lusty, but still lusty.
		else if(lust > 75) {
			rando = rand(5);
			if(rando == 0) descript += "turgid";
			else if(rando == 1) descript += "blood-engorged";
			else if(rando == 2) descript += "rock-hard";
			else if(rando == 3) descript += "stiff";
			else descript += "eager";
		}
	}
	//Girth - fallback
	else {
		if(cockLength/6 <= .75) {
			rando = rand(3);
			if(rando == 0) descript += "thin";
			else if(rando == 1) descript += "slender";
			else descript += "narrow";
		}
		else if(cockLength/6 <= 1.2) {
			descript += "ample";
		}
		else if(cockLength/6 <= 1.4) {
			rando = rand(2);
			if(rando == 0) descript += "ample";
			else descript += "big";
		}
		else if(cockLength/6 <= 2) {
			rando = rand(3);
			if(rando == 0) descript += "broad";
			else if(rando == 1) descript += "girthy";
			else descript += "meaty";
		}
		else if(cockLength/6 <= 3.5) {
			rando = rand(3);
			if(rando == 0) descript += "fat";
			else if(rando == 1) descript += "wide";
			else descript += "distended";
		}
		else if(cockLength/6 > 3.5) {
			rando = rand(3);
			if(rando == 0) descript += "inhumanly distended";
			else if(rando == 1) descript += "bloated";
			else descript += "monstrously thick";
		}
	}
	return descript;
}
