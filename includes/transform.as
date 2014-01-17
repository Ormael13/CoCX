//Updates the player's gender
public function genderCheck():void {
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

