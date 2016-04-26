package classes.Scenes.NPCs
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;

	public class Helspawn extends Monster
	{

		override public function doAI():void
		{
			var choices:Array = [];
			choices[choices.length] = helspawnTwinStrikes;
			//Bowmander only
			if (flags[kFLAGS.HELSPAWN_WEAPON] == "bow") choices[choices.length] = calledShot;
			//Zerker ability
			if (weaponAttack < 50 || flags[kFLAGS.HELSPAWN_WEAPON] == "scimitar") choices[choices.length] = helSpawnBerserk;	//Shield Bash (Shieldmander Only)
			if (flags[kFLAGS.HELSPAWN_WEAPON] == "scimitar and shield") choices[choices.length] = helSpawnShieldBash;
			//Tease (Sluttymander Only)
			if (flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50) choices[choices.length] = sluttyMander;
			//Focus (Chastemander Only)
			//Self-healing & lust restoration
			if (flags[kFLAGS.HELSPAWN_PERSONALITY] < 50) choices[choices.length] = helSpawnFocus;
			choices[rand(choices.length)]();
			//Tail Whip
			if (rand(4) == 0) tailWhipShitYo();
			combatRoundOver();
		}

//Basic Attack - Twin Strike
// Two light attacks
private function helspawnTwinStrikes():void {
	//if Bowmander
	if (flags[kFLAGS.HELSPAWN_WEAPON] == "bow") outputText(flags[kFLAGS.HELSPAWN_NAME] + " leaps back out of your reach and nocks a pair of blunted arrows, drawing them back together and loosing them at once!\n");
	else outputText(flags[kFLAGS.HELSPAWN_NAME] + " lunges at you, scimitar cleaving through the air toward your throat!\n");
	createStatusEffect(StatusEffects.Attacks,0,0,0,0);
	eAttack();
}

//Called Shot (Bowmander Only)
// Super-high chance of hitting. On hit, speed debuff
private function calledShot():void {
	outputText(flags[kFLAGS.HELSPAWN_NAME] + " draws back her bowstring, spending an extra second aiming before letting fly!");
	var damage:Number = int((str + weaponAttack) - rand(player.tou) - player.armorDef);
	//standard dodge/miss text
	if (damage <= 0 || (rand(2) == 0 && (player.getEvasionRoll()))) outputText("\nYou avoid the hit!");
	else {
		outputText("\nOne of her arrows smacks right into your [leg], nearly bowling you over.  God DAMN that hurt! You're going to be limping for a while! ");
		var affect:int = 20 + rand(5);
		if (player.findStatusEffect(StatusEffects.CalledShot) >= 0) {
			while(affect > 0 && player.spe >= 2) {
				affect--;
				player.addStatusValue(StatusEffects.CalledShot,1,1);
				player.spe--;
				showStatDown( 'spe' );
				// speDown.visible = true;
				// speUp.visible = false;
			}
		}
		else {
			player.createStatusEffect(StatusEffects.CalledShot,0,0,0,0);
			while(affect > 0 && player.spe >= 2) {
				affect--;
				player.addStatusValue(StatusEffects.CalledShot,1,1);
				player.spe--;
				showStatDown( 'spe' );
				// speDown.visible = true;
				// speUp.visible = false;
			}
		}
		damage = player.takeDamage(damage, true);
	}
}

		//Berzerkergang (Berzerkermander Only)
		//Gives Helspawn the benefit of the Berzerk special ability
		private function helSpawnBerserk():void {
			outputText(flags[kFLAGS.HELSPAWN_NAME] + " lets out a savage warcry, throwing her head back in primal exaltation before charging back into the fray with utter bloodlust in her wild eyes!");
			this.weaponAttack = weaponAttack + 30;
			armorDef = 0;
		}

		//Shield Bash (Shieldmander Only)
		private function helSpawnShieldBash():void {
			clearOutput();
			var damage:Number = int((str) - rand(player.tou) - player.armorDef);
			// Stuns a bitch
			outputText(flags[kFLAGS.HELSPAWN_NAME] + " lashes out with her shield, trying to knock you back!");
			//standard dodge/miss text
			if (damage <= 0 || player.getEvasionRoll()) outputText("\nYou evade the strike.");
			else {
				outputText("\nHer shield catches you right in the face, sending you tumbling to the ground and leaving you open to attack! ");
				damage = player.takeDamage(damage, true);
				if (rand(2) == 0 && player.findStatusEffect(StatusEffects.Stunned) < 0) {
					player.createStatusEffect(StatusEffects.Stunned,0,0,0,0);
					outputText(" <b>The hit stuns you.</b>");
				}
			}
		}

		//Tail Whip
		private function tailWhipShitYo():void {
			// Light physical, armor piercing (fire, bitch). Random chance to get this on top of any other attack
			var damage:Number = int((str) - rand(player.tou));
			outputText("\n" + flags[kFLAGS.HELSPAWN_NAME] + " whips at you with her tail, trying to sear you with her brilliant flames!");
			//standard dodge/miss text
			if (damage <= 0 || player.getEvasionRoll()) outputText("\nYou evade the strike.");
			else {
				outputText("\n" + flags[kFLAGS.HELSPAWN_NAME] + "'s tail catches you as you try to dodge.  Your [armor] sizzles, and you leap back with a yelp as she gives you a light burning. ");
				damage = player.takeDamage(damage, true);
			}
		}

		//Tease (Sluttymander Only)
		private function sluttyMander():void {
			// Medium Lust damage
			outputText(flags[kFLAGS.HELSPAWN_NAME] + " jumps just out of reach before spinning around, planting her weapon in the ground as she turns her backside to you and gives her sizable ass a rhythmic shake, swaying her full hips hypnotically.");
			//if no effect:
			if (rand(2) == 0) outputText("\nWhat the fuck is she trying to do?  You walk over and give her a sharp kick in the kiester, \"<i>Keep your head in the game, kiddo.  Pick up your weapon!</i>\"");
			else {
				outputText("\nDat ass.  You lean back, enjoying the show as the slutty little salamander slips right past your guard, practically grinding up against you until you can feel a fire boiling in your loins!");
				var lustDelta:Number = player.lustVuln * (10 + player.lib/10);
				player.lust += lustDelta;
				game.mainView.statsView.showStatUp( 'lust' );
				// lustDown.visible = false;
				// lustUp.visible = true;
				lustDelta = Math.round(lustDelta * 10)/10;
				outputText(" (" + lustDelta + ")", false);
			}
		}

		//Focus (Chastemander Only)
		//Self-healing & lust restoration
		private function helSpawnFocus():void {
			outputText("Seeing a momentary lull in the melee, " + flags[kFLAGS.HELSPAWN_NAME] + " slips out of reach, stumbling back and clutching at the bruises forming all over her body.  \"<i>Come on, " + flags[kFLAGS.HELSPAWN_NAME] + ", you can do this. Focus, focus,</i>\" she mutters, trying to catch her breath.  A moment later and she seems to have taken a second wind as she readies her weapon with a renewed vigor.");
			lust -= 30;
			if (lust < 0) lust = 0;
			addHP(eMaxHP() / 3.0);
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.helSpawnScene.beatUpYourDaughter();
		}


		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.helSpawnScene.loseSparringToDaughter();
		}

		public function Helspawn()
		{
			var weapon:String = game.flags[kFLAGS.HELSPAWN_WEAPON];
			this.a = "";
			this.short = game.flags[kFLAGS.HELSPAWN_NAME];
			this.imageName = "hollispawn";
			this.long = game.flags[kFLAGS.HELSPAWN_NAME] + " is a young salamander, appearing in her later teens.  Clad in " +
							(game.flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50 ?
									"a slutty scale bikini like her mother's, barely concealing anything" :
									"a short skirt, thigh-high boots, and a sky-blue blouse, in stark contrast to her mother’s sluttier attire") +
							", she stands about six feet in height, with a lengthy, fiery tail swishing menacingly behind her. She's packing a " +
							{
								'bow': "recurve bow, using blunted, soft-tipped arrows",
								'scimitar': "scimitar, just like her mom's, and holds it in the same berzerk stance Helia is wont to use",
								'scimitar and shield': "scimitar and shield, giving her a balanced fighting style"
							}[ weapon] +
							".  Pacing around you, the well-built young warrior intently studies her mentor's defenses, readying for your next attack.";
			// this.plural = false;
			this.createVagina(false, VAGINA_WETNESS_NORMAL, VAGINA_LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 85, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E+"));
			this.ass.analLooseness = ANAL_LOOSENESS_VIRGIN;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,85,0,0,0);
			this.tallness = 90;
			this.hipRating = HIP_RATING_CURVY+2;
			this.buttRating = BUTT_RATING_LARGE+1;
			this.skinTone = "dusky";
			this.hairColor = "red";
			this.hairLength = 13;
			initStrTouSpeInte(50, 50, 65, 40);
			initLibSensCor(35, 55, 20);
			this.weaponName = weapon;
			this.weaponVerb = {
				'bow': "blunted arrow",
				'scimitar': "slash",
				'scimitar and shield': "slash"}[weapon];
			this.weaponAttack = 20;
			this.armorName = "scales";
			this.armorDef = 12;
			this.armorPerk = "";
			this.armorValue = 50;
			this.bonusHP = 175;
			this.lust = 30;
			this.lustVuln = .55;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 12;
			this.gems = 10 + rand(5);
			this.tailType = TAIL_TYPE_SALAMANDER;
			this.tailRecharge = 0;
			this.createStatusEffect(StatusEffects.Keen, 0, 0, 0, 0);
			this.drop = NO_DROP;
			checkMonster();
		}

	}

}
