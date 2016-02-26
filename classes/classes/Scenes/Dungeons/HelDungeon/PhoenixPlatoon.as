package classes.Scenes.Dungeons.HelDungeon
{
	import classes.*;

	public class PhoenixPlatoon extends Monster
	{
		//ATTACK ONE: SPARTAN RUSH
		public function phoenixPlatoonRush():void {
			outputText("You fall back under a hail of scimitar attacks.  The sheer number of phoenixes attacking is bad enough, but their attacks are perfectly coordinated, leaving virtually no room for escape or maneuver without getting hit!\n");
			//(Effect: Multiple medium-damage attacks)
			//(Effect: Multiple light attacks)
			createStatusEffect(StatusEffects.Attacks,2+rand(3),0,0,0);
			eAttack();
			combatRoundOver();
		}

		//ATTACK TWO: FIRE BREATH
		public function phoenixPlatoonFireBreath():void {
			outputText("Suddenly, the shield wall parts, revealing a single member of the platoon, a particularly muscular girl with a raging erection.  Before you can consider what's going on, she rears back and huffs at you.  To your horror, a great gout of fire erupts from her mouth, rolling towards you.  You dive, but are still caught partially in the inferno.");
			//(Effect: One heavy-damage attack)
			var damage:Number = 100 + rand(50);
			damage = player.takeDamage(damage, true);
			combatRoundOver();
		}
		//ATTACK THREE: LUSTBANG GRENADE
		public function phoenixPlatoonLustbang():void {
			outputText("\"<i>LUSTBANG OUT!</i>\" one of the rear-most phoenixes shouts, causing all the other warriors to duck down behind their shields.  Oh, shit!  A large glass sphere rolls out from the shield wall, and immediately explodes in a great pink cloud.  You cough and wave your arms, but by the time the cloud has dissipated, you feel lightheaded and lusty, barely able to resist the urge to throw yourself at the phoenixes and beg for their cocks and cunts.");
			//(Effect: Large lust increase)
			game.dynStats("lus", 40);
			combatRoundOver();
		}

		public function phoenixPlatoonAI():void {
			if (findStatusEffect(StatusEffects.Platoon) < 0) {
				phoenixPlatoonRush();
				createStatusEffect(StatusEffects.Platoon,0,0,0,0);
			}
			else if (statusEffectv1(StatusEffects.Platoon) == 0) {
				phoenixPlatoonFireBreath();
				addStatusValue(StatusEffects.Platoon,1,1);
			}
			else {
				phoenixPlatoonLustbang()
				removeStatusEffect(StatusEffects.Platoon);
			}
		}
		
		override protected function performCombatAction():void
		{
			phoenixPlatoonAI();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.dungeons.heltower.phoenixPlatoonLosesToPC();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.dungeons.heltower.phoenixPlatoonMurdersPC();
		}
		
		public function PhoenixPlatoon()
		{
			this.a = "the ";
			this.short = "phoenix platoon";
			this.imageName = "phoenixmob";
			this.long = "You are faced with a platoon of heavy infantry, all armed to the teeth and protected by chain vests and shields. They look like a cross between salamander and harpy, humanoid save for crimson wings, scaled feet, and long fiery tails. They stand in a tight-knit shield wall, each phoenix protecting herself and the warrior next to her with their tower-shield. Their scimitars cut great swaths through the room as they slowly advance upon you.";
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createCock();
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 3;
			this.createVagina(false, VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_LOOSE);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.tallness = rand(8) + 70;
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_LARGE;
			this.lowerBody = LOWER_BODY_TYPE_LIZARD;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(70, 60, 120, 40);
			initLibSensCor(40, 45, 50);
			this.weaponName = "spears";
			this.weaponVerb="stab";
			this.weaponAttack = 20;
			this.armorName = "armor";
			this.armorDef = 20;
			this.bonusHP = 1000;
			this.lust = 20;
			this.lustVuln = .15;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 20;
			this.gems = rand(25) +160;
			this.additionalXP = 50;
			this.hornType = HORNS_DRACONIC_X2;
			this.horns = 2;
			this.tailType = TAIL_TYPE_HARPY;
			this.wingType = WING_TYPE_FEATHERED_LARGE;
			this.drop = NO_DROP;
			checkMonster();
		}
		
	}

}