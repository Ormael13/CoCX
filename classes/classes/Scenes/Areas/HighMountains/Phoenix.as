package classes.Scenes.Areas.HighMountains 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.internals.ChainedDrop;
	
	public class Phoenix extends Monster
	{
		protected function doubleSlash():void {
			outputText("You fall back under a hail of feints and jabs as your enemy darts at you, swinging furiously. The sheer number of blows the phoenix lays against you is incredible, forcing you backwards as you try to deflect the flurry of deadly strikes.  ");
			if (player.getEvasionRoll()) {
				outputText("You are able to parry one of her blows with enough force to push her back, giving you a little more breathing room.");
			}
			if (combatBlock(true)) {
				outputText("You are able to raise your " + player.shieldName + " in time to block the phoenix's blows.");
			}
			else {
				outputText("Seeing an opening, the phoenix forces her way through your guard with a quick pair of powerful strikes. ");
				//Get hit
				var damage:int = str + weaponAttack + rand(80);
				damage = player.reduceDamage(damage);
				player.takeDamage(damage, true);
				//Get hit again
				damage = str + weaponAttack + rand(80);
				damage = player.reduceDamage(damage);
				player.takeDamage(damage, true);
			}
			combatRoundOver();
		}
		
		protected function phoenixFireBreath():void {
			if (findStatusAffect(StatusAffects.Uber) < 0) {
				outputText("Suddenly the phoenix disengages from you and loops through the air, giving out a loud cry before she starts to barrel down at you. She’s clearly building up for something, so you’d better wait until she makes her move if you want a chance to dodge!");
				createStatusAffect(StatusAffects.Uber, 0, 0, 0, 0);
			}
			else {
				if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1) {
					outputText("You dive to the ground just as the phoenix breathes a great gout of flame at you. The fire blooms over your back, singeing your [armor], but doesn’t harm you. As she swoops low you see the phoenix scowl, looking quite disappointed, but it’s clear she isn’t done yet!", false);
				}
				//MASSIVE DAMAGE!
				else {
					var damage:int = str + weaponAttack + 300 + rand(250);
					if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
					if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
					damage = Math.round(damage);
					if (player.findStatusAffect(StatusAffects.Blizzard) >= 0) {
						player.addStatusValue(StatusAffects.Blizzard, 1, -1);
						outputText("As she zooms over you a great gout of flame erupts from the phoenix’s mouth! You dive out of the way, but all too late. The wall of fire rolls over covering you blizzard you as you leap through it, the brief contact with the inferno searing both you and your " + player.armorName + " slightly due to still swirling around you ice shards. ", false);
						damage *= 0.2;
					}
					else {
						outputText("As she zooms over you a great gout of flame erupts from the phoenix’s mouth! You dive out of the way, but all too late. The wall of fire rolls over you as you leap through it, the brief contact with the inferno searing both you and your " + player.armorName + " badly. ", false);
					}
					damage = Math.round(damage);
					damage = player.reduceDamage(damage);
					player.takeDamage(damage, true);
				}
				removeStatusAffect(StatusAffects.Uber);
			}
			combatRoundOver();
		}
		
		protected function lustBang():void {
			outputText("\"<i>Here, CATCH!</i>\" The phoenix shouts, lobbing a small, circular canister at you before ducking behind her sturdy shield. Oh shit!");
			if (player.getEvasionRoll()) {
				outputText("Luckily, the metal cylinder bounces off the uneven terrain of the mountain, giving you just enough time to dive away as a huge cloud of pink erupts into the air. The phoenix glances around her shield, face darkening as she sees you readying yourself for another strike instead of writhing on the ground in an oversensitive pile of lust.");
			}
			else {
				outputText("You cough and hack, waving your arms to try and dissipate the fog, but by the time the cloud has faded you feel lightheaded and lusty. Your");
				if (player.hasCock()) outputText("shaft quickly engorges inside your armour, already leaking precum down your leg");
				if (player.hasCock() && player.hasVagina()) outputText("whilst your");
				if (player.hasVagina()) outputText("thighs are suddenly soaked by a torrent of girlcum as your body reacts to the potent chemicals");
				outputText(".");
				var lustDmg:Number = (30 + rand(30)) * (game.lustPercent()/100);
				game.dynStats("lus", lustDmg, "resisted", false);
				outputText(" <b>(<font color=\"#ff00ff\">" + (Math.round(lustDmg*10)/10) + "</font>)</b>");
			}
			combatRoundOver();
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(4);
			if (findStatusAffect(StatusAffects.Uber) >= 0) {
				phoenixFireBreath();
				return;
			}
			switch (choice) {
				case 0:
					eAttack();
					break;
				case 1:
					doubleSlash();
					break;
				case 2:
					phoenixFireBreath();
					break;
				case 3:
					lustBang();
					break;
				default:
					eAttack();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.highMountains.phoenixScene.winAgainstPhoenix();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nYour foe doesn't seem disgusted enough to leave...");
				doNext(game.endLustLoss);
			} else {
				game.highMountains.phoenixScene.loseToPhoenix();
			}
		}
		
		public function Phoenix() 
		{
			this.a = "the ";
			this.short = "phoenix";
			this.imageName = "phoenix";
			this.long = "The figure facing you is one of the dangerous hybrids of the Salamander and Harpy races; a Phoenix created by the self proclaimed harpy \"Queen\". Her appearance is close to a normal, crimson-feathered harpy, save for a few noticeable additions. Wings larger than a normal harpy’s sprout from her back, probably to make up for the fact that the usual harpy armwings fade into scaled forearms, an obvious marker of her Salamander parentage. Her lower body is much the same, feather-covered hips and thighs merging with scales around the knee and ending in a clawed lizard foot; not to mention the long, fiery tail that swishes to and from behind her as she circles you. \n\nStanding perhaps six and a half feet tall, her large breasts strain against the tarnished metal of her vest, just as her ample hips threaten to burst free from her tight loincloth. A half-erect lizard cock pokes out pushing the cloth to one side and allowing for a clear view of her slick, puffy pussy just below it. Her scimitar cuts great swaths through the air as she darts through the air above you, taking full advantage of the open space you find yourselves in.";
			// this.plural = false;
			this.createCock(8, 1.2, CockTypesEnum.LIZARD);
			this.createVagina(false, VAGINA_WETNESS_SLICK, VAGINA_LOOSENESS_LOOSE);
			this.createStatusAffect(StatusAffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_MOIST;
			this.createStatusAffect(StatusAffects.BonusACapacity,20,0,0,0);
			this.tallness = 6 * 12 + 6;
			this.tailType = TAIL_TYPE_SALAMANDER;
			this.hipRating = HIP_RATING_CURVY;
			this.buttRating = BUTT_RATING_JIGGLY;
			this.lowerBody = LOWER_BODY_TYPE_SALAMANDER;
			this.skinTone = "light";
			this.skinType = SKIN_TYPE_SCALES;
			this.skinDesc = "crimson";
			this.hairColor = "red";
			this.hairLength = 16;
			initStrTouSpeInte(125, 110, 120, 84);
			initLibSensCor(50, 30, 45);
			this.weaponName = "scimitar and shield";
			this.weaponVerb="slash";
			this.weaponAttack = 41 + (9 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "chainmail and loincloth";
			this.armorDef = 37 + (4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 800;
			this.bonusLust = 10;
			this.lust = 10;
			this.lustVuln = .7;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 30;
			this.gems = 60 + rand(45);
			this.drop = new ChainedDrop().add(useables.EBONBLO,1/20)
					.add(weapons.SCIMITR,1/20)
					.elseDrop(consumables.NOCELIQ);
			this.wingType = WING_TYPE_FEATHERED_PHOENIX;
			this.special1 = doubleSlash;
			this.special2 = phoenixFireBreath;
			this.special3 = lustBang;
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			this.str += 37 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 33 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 36 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 25 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 15 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 5840;
			checkMonster();
		}
		
	}

}
