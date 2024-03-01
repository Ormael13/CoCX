/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.ChainedDrop;

public class Alvina extends Monster
	{
		override public function interruptAbility():void {
			if (PolarMidnightSequance > 0 || SoulTearInitiated)
			{
				if (PolarMidnightSequance > 1){
					outputText("<b>By some miracle Alvina was stopped from finishing you off in your vulnerable state, just enough for you to escape!</b>\n\n");
					PolarMidnightSequance = 0;
				}
				else{
					outputText("<b>Alvina recoils in frustration as she is forced to interrupt her incantation!</b>\n\n");
					PolarMidnightSequance = 0;
					SoulTearCooldown = 5;
					SoulTearInitiated = false;
				}
			}
		}

		private function alvinaNosferatu():void {
			createStatusEffect(StatusEffects.AbilityCooldown1, 4, 0, 0, 0);
			var nosferatu:Number = this.inte;
			nosferatu += this.wis;
			nosferatu *= 20;
			outputText("Alvina chants and her shadow surges toward you, grabbing at your own. You feel your energy being drained as her shadow retreats back to her, Alvina laughs as she steals your vitality. <b>(<font color=\"#800000\">" + nosferatu + "</font>)</b>");
			this.HP += nosferatu;
			player.HP -= nosferatu;
			statScreenRefresh();
			outputText("\n");
		}

		private function alvinaWaveOfEcstasy():void {
			var lustDmg:Number = player.lustPercent() * (this.inte / 3 + rand(this.lib - this.inte * 2 + 100) / 3);
			if (hasStatusEffect(StatusEffects.CreepingDoom)) lustDmg *= 2;
			outputText("Alvina moans a word of power, squirting in orgasmic pleasure as a nova of black magic explodes from her. Unable to dodge, you are squarely hit by the energy wave and feel your arousal and sensitivity rise.\n\n");
			lustDmg = Math.round(lustDmg);
			player.takeLustDamage(lustDmg, true);
			player.addCurse("sens", 10, 2);
		}

		private function alvinaPolarMidnight():void {
			if (PolarMidnightSequance == 0) {
				outputText("Alvina starts incanting a spell. While nothing visible happens, you feel a chill in the air.");
				PolarMidnightSequance++;
				createStatusEffect(StatusEffects.Uber, 0, 0,0,0);
				clearTempResolute(false);
			}
			else {
				if (PolarMidnightSequance == 1) {
					var damage:Number = 0;
					damage += eBaseIntelligenceDamage() * 40;
					if (hasStatusEffect(StatusEffects.Maleficium)) damage *= 2;
					outputText("The room gets darker as lights are snuffed out, and it gets colder by the second. ");
					if (flags[kFLAGS.GAME_DIFFICULTY] >= 2){
						outputText("Alvina snaps her fingers and large spear-like shards of ice form all around you before raining from all directions. You are impaled from all sides by spears, your blood dripping on the floor. This is, however, only the first phase of this terrifying spell. ");
						if (!player.immuneToBleed()) player.createStatusEffect(StatusEffects.IzmaBleed, 3, 0, 0, 0);
					}
					outputText("You barely have time to scream as the air around you freezes solid. You are encased in a thick layer of black ice! ");
					player.takeIceDamage(damage, true);//, true
					player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
					createStatusEffect(StatusEffects.AbilityCooldown2, 6, 0, 0, 0);
					PolarMidnightSequance++;
				}
				else {
					removeStatusEffect(StatusEffects.Uber);
					outputText("You can see Alvina approaching you, and raising her scythe. This is gonna hurt.... She smashes your prison with her weapon, causing the ice to shatter all around you. You feel like your body is breaking apart.");
					player.HP -= player.maxHP() * 0.8;
					PolarMidnightSequance = 0;
				}
			}
		}

		private function alvinaInfernalFlare():void {
			var damage:Number = 0;
			damage += eBaseIntelligenceDamage() * 2;
			if (player.cor >= 66) damage = Math.round(damage * 1.0);
			else if (player.cor >= 50) damage = Math.round(damage * 1.1);
			else if (player.cor >= 25) damage = Math.round(damage * 1.2);
			else if (player.cor >= 10) damage = Math.round(damage * 1.3);
			else damage = Math.round(damage * 1.4);
			if (hasStatusEffect(StatusEffects.Maleficium)) damage *= 2;
			outputText("Alvina weaves her scythe above her head tracing complicated arcane signs, as a purple flame surges under you, searing your flesh. ");
			//outputText(". (" + damage + ")");
			player.takeFireDamage(damage, true);//, true
			if (!player.immuneToBurn()) {
				if (player.hasStatusEffect(StatusEffects.BurnDoT)) player.addStatusValue(StatusEffects.BurnDoT, 1, 1);
				else player.createStatusEffect(StatusEffects.BurnDoT,SceneLib.combat.debuffsOrDoTDuration(5),0.05,0,0);
			}
			statScreenRefresh();
			outputText("\n");
		}

		private function alvinaMeteorStorm():void {
			if (MeteorStormSequence == 0) {
				outputText("Alvina weaves her scythe above her head tracing complicated arcane signs.");
				MeteorStormSequence++;
				createStatusEffect(StatusEffects.Uber, 0, 0,0,0);
				clearTempResolute(false);
			} else {
				var damage:Number = 0;
				damage += eBaseIntelligenceDamage() * 10;
				outputText("“<i>You know [name], I wonder if you can endure this. I doubt it, but again no such thing as overkill when it comes to getting rid of you. Be glad you get to see true magic! Magic worthy of gods before your end!</i>”\n\n");
				outputText("A seal forms under your feet as the two of you are teleported outside. You're in the middle of the blight ridge and Alvina is standing on a faraway hill, incanting god knows what. You're about to run to her when you see it, in the sky above you, a massive arcane circle the size of the entire ridge with patterns so complex, even if you had her level of skill with magic you would fail to get a grasp of whatever spell she is using!\n\n");
				outputText("The clouds part if only for an instant to reveal a vision of horrors. A full set of meteors, each the size of a small house, are falling in your direction.  You are sure to be caught in the barrage and so you hope whatever protection you have will be enough.\n\n");
				if (player.getEvasionRoll()) {
					outputText("You are crushed by the meteor storm! ");
					damage *= 1.5;
				} else {
					outputText("You barely manage to lessen your injury, still getting hit by the meteor storm.");
				}

				player.takeFireDamage(damage);
				player.takeDamage(damage);
				if (rand(100) < 40 && !player.hasPerk(PerkLib.Resolute)) {
					player.createStatusEffect(StatusEffects.Stunned, 4, 0, 0, 0);
				}
				outputText("You are teleported back to Alvina’s laboratory afterward. She’s far from done with you.");
				MeteorStormSequence = 0;
				MeteorStormCooldown = 10;
			}
		}

		private function alvinaMaleficium():void {
			outputText("Alvina's skin flushes in arousal as purple flames start to rise from the ground around her.  A telltale sign of a severe power increase.\n\n");
			createStatusEffect(StatusEffects.Maleficium,15,0,0,0);
		}

		private function alvinaSoulTear():void {
			if (SoulTearInitiated) {
				var damage:Number = player.maxHP();
				if (player.minHP() < 0) damage -= player.minHP();
				outputText("You barely register in disbelief as the tendrils rush for you like some horrible monsters out of your worst nightmares. These creatures have a mind of their own and even as you try to run away, they plunge into your chest and grab something before forcefully tearing it out. You scream in anguish as your soul is torn from your body. (" + damage + ")\n\n");
				SoulTearInitiated = false;
				SoulTearCooldown = 5;
				player.HP -= damage;
			}
			else {
				outputText("\"<i>Most demons steal souls through sex. I have a more academic approach to it. Do not worry, you will still writhe in pleasure and reach orgasm as I tear it out of your chest!</i>\"\n\n");
				outputText("You see a set of dark tendrils of black magic surging around her body, like grasping claws, ready to bury themselves in you. You need to stop that incantation before she strikes you with it!\n\n");
				SoulTearInitiated = true;
				clearTempResolute(false);
			}
		}

		private function alvinaCreepingDoom():void {
			outputText("Alvina weaves a circle with her scythe which opens a portal to some weird dimension. At first, you ponder what exactly she is trying to do until a wriggling mass of larva starts pouring out of the portal. Alvina grabs and affectionately pets one before throwing it at you.\n\n");
			outputText("\"<i>Don’t worry, my little friends will take good care of you...</i>\"\n\n");
			outputText("Before you know it the things are swarming you, trying to enter your every orifice and teasing your skin! You need to get rid of these pests before they take you down!\n\n");
			createStatusEffect(StatusEffects.CreepingDoom, 0, 0, 0, 0);
		}

		private function alvinaReapersVerdict():void {
			outputText("\"<i>Perish, you insect!!!</i>\"\n\n");
			outputText("Alvina spins her scythe around her head, and you feel the room filling with nothing short of death itself, you can feel your very life slipping out of you. You barely manage to stand upright and stay conscious, noting how Alvina also seems exhausted, she likely will have to rest for a moment.\n\n");
			VerdictCooldown = 5;
			hasChanneledVerdict = 3;
			if (player.minHP() < 0) player.HP = player.minHP() + 1;
			else player.HP = 1;
		}

		private function alvinaIceStorm():void {
			var damage:Number = 0;
			damage += eBaseIntelligenceDamage() * 4;
			if (hasStatusEffect(StatusEffects.Maleficium)) damage *= 2;
			outputText("Large crystalline shards of ice form in a fan around Alvina. She waves her scythe in an arc launching them in a barrage at you. You are impaled several times over, your wounds bleeding grievously. ");
			player.takeIceDamage(damage, true);
			if (!player.immuneToBleed()) {
				if (player.hasStatusEffect(StatusEffects.IzmaBleed)) player.addStatusValue(StatusEffects.IzmaBleed,1,1);
				else player.createStatusEffect(StatusEffects.IzmaBleed, SceneLib.combat.debuffsOrDoTDuration(5), 0, 0, 0);
			}
			statScreenRefresh();
			outputText("\n");
		}

		private function alvinaTimeStop():void {
			outputText("\"<i>Enough!</i>\"\n\n");
			outputText("Alvina snaps her finger and suddenly you find yourself unable to move as if frozen in time yet you are conscious of your surroundings, horrifyingly so even as Alvina casually walks up to you, cupping your chin with her claws.\n\n");
			outputText("\"<i>I could behead you with a single swing, but where would be the satisfaction with that. I'm impressed that you managed to last this long, however this all ends now. I can only admire your tenacity in making it this far, so I will give you the honor of watching the entire orchestration of your impending demise.</i>\"\n\n");
			outputText("Alvina lifts your time frozen body telekinetically in the air. Being an object frozen in time of course you don't fall down. ");
			if (player.hasPerk(PerkLib.Mage)) outputText("Your magic might be strong but this is on a whole new level, she is actually playing with the very fabric of reality and time right before your eyes. ");
			outputText("She walks to the side and starts weavings her hands in so many arcane patterns it becomes hard for you to fellow, not unlike a maestro weaving a symphony of death come to think of it as thousands of ethereal swords appears out of thin air all around you, circling around in a perfect spherical shape, ");
			outputText("all pointing in your direction. There's so many of them you don't believe you'd be able to dodge everything, if you could dodge at all!\n\n");
			outputText("\"<i>Let's see if this is your limit [name]. Will you be found wanting?</i>\"\n\n");
			outputText("Alvina snaps her finger again and all the blades suddenly converge in your direction!\n\n");
			if (player.hasStatusEffect(StatusEffects.EverywhereAndNowhere) || player.hasStatusEffect(StatusEffects.ShadowTeleport)) {
				outputText("Little does she know that you have the ability to completely remove yourself from existence if only for a brief moment thanks to "
						+ "being everywhere and nowhere at the same time, a living paradox"
						+ ". You are barely conscious of the blades colliding together at your previous position with a deafening crash as you appear a few yards away!\n\n");
			}
			else if (player.isRace(Races.FAIRY, 1, false)) outputText("You avoid the attack thanks to your Faerie magic, flickering out of reality just as the blades collides.\n\n");
			else if (player.isRace(Races.DISPLACERBEAST, 1, false)) outputText("Little does she know that you have the ability to displace yourself out of such deadly attacks, You are barely conscious of the blades colliding together at your previous position with a deafening crash as you appear a few yards away!\n\n");
			else {
				var damage:Number = player.maxHP() * 1.1;
				if (player.minHP() < 0) damage += player.minHP();
				if (combatParry2() > 0) damage -= 0.01 * player.maxHP() * combatParry2();
				if (player.shieldBlock > 0) damage -= 0.01 * player.maxHP() * combatBlock2();
				if (damage < 1) damage = 0;
				player.HP -= damage;
				if (player.HP <= player.minHP()) outputText("You dodge, deflect, parry and block as best as you can to take as little damage as possible yet are still impaled a few hundred times!"); //This seems rather boring of a death message.
				else {
					outputText("Realising that you are still alive Alvina applauds your resilience in annoyance. The fight is far from over but what matters is that you can win.");
				}
				outputText(" (" + damage + ")\n\n");
			}
			timeStopUsed = true;
		}

		private function alvinaBlackfireDance():void {
			outputText("Alvina suddenly charges at you swinging both of her blazing scythes in a deadly arc burning you in the process. You feel your very life force being seared away.");
			for (var i:int = 0; i < 5 && soulforce >= maxSoulforce() * 0.2; i++) {
				if (!player.getEvasionRoll()){
					var damage:int = eBaseIntelligenceDamage() * 2;
					player.takeFireDamage(damage);
					player.mana -= player.mana * 0.2;
				}
				soulforce -= maxSoulforce() * 0.2;
			}
		}

		// AI variables
		public var VerdictCooldown:int = 0;
		public var hasChanneledVerdict:int = 0;
		public var timeStopUsed:Boolean = false;
		public var PolarMidnightSequance:int = 0;
		public var SoulTearInitiated:Boolean = false;
		public var SoulTearCooldown:int = 0;
		public var MeteorStormSequence:int = 0;
		public var MeteorStormCooldown:int = 0;

		override public function combatRoundUpdate():void {
			super.combatRoundUpdate();
			if (SoulTearCooldown > 0) SoulTearCooldown--;
			if (hasChanneledVerdict > 0) hasChanneledVerdict--;
			if (VerdictCooldown > 0) VerdictCooldown--;
			if (MeteorStormCooldown > 0) MeteorStormCooldown--;
		}
		/*
					if (HPRatio() < .5 && !hasStatusEffect(StatusEffects.TimeStopUsed)) alvinaTimeStop();
			if (!hasStatusEffect(StatusEffects.AbilityCooldown3)) alvinaReapersVerdict();
			else if (hasStatusEffect(StatusEffects.Uber)) {
				if (hasStatusEffect(StatusEffects.AbilityCooldown3)) outputText("Alvina seems to be recovering her energy.\n");
				alvinaPolarMidnight();
			}
			if (hasStatusEffect(StatusEffects.AbilityCooldown3) && !hasStatusEffect(StatusEffects.AbilityCooldown4)) alvinaSoulTear();
			else {
				if (hasStatusEffect(StatusEffects.AbilityCooldown3)) outputText("Alvina seems to be recovering her energy.\n");
		* */

		override protected function performCombatAction():void {
			if (HPRatio() < .5 && !timeStopUsed) {
				alvinaTimeStop();
				return;
			}
			if (SoulTearInitiated) {
				alvinaSoulTear();
				return;
			}
			if (PolarMidnightSequance > 0) {
				alvinaPolarMidnight();
				return;
			}
			if (hasChanneledVerdict > 0){
				outputText("Alvina seems to be recovering her energy.\n");
				return;
			}
			if (MeteorStormSequence > 0) {
				alvinaMeteorStorm();
				return;
			}
			RandomiseAction();
		}

		protected function RandomiseAction():void {
			var choice:Number = rand((flags[kFLAGS.GAME_DIFFICULTY] >= 2) ? 11 : 9);
			switch (choice) {
				case 0:
					alvinaInfernalFlare();
					break;
				case 1:
					alvinaIceStorm();
					break;
				case 2:
					alvinaWaveOfEcstasy();
					break;
				case 3:
					if ((this.HP < this.maxHP() * 9) && !hasStatusEffect(StatusEffects.AbilityCooldown1)) alvinaNosferatu();
					else RandomiseAction();
					break;
				case 4:
					if (!hasStatusEffect(StatusEffects.Maleficium)) alvinaMaleficium();
					else RandomiseAction();
					break;
				case 5:
					if (!hasStatusEffect(StatusEffects.AbilityCooldown2)) alvinaPolarMidnight();
					else RandomiseAction();
					break;
				case 6:
					if (hasStatusEffect(StatusEffects.CreepingDoom)) alvinaInfernalFlare();
					else alvinaCreepingDoom();
					break;
				case 7:
					if (VerdictCooldown <= 0) alvinaReapersVerdict();
					else RandomiseAction();
					break;
				case 8:
					if (SoulTearCooldown <= 0) alvinaSoulTear();
					else RandomiseAction();
					break;
				case 9:
					if (MeteorStormCooldown <= 0) alvinaMeteorStorm();
					else RandomiseAction();
					break;
				case 10:
					if (soulforce100 > 20) alvinaBlackfireDance();
					else RandomiseAction();
					break;
				default:
					alvinaInfernalFlare();
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			cleanupAfterCombat();
			doNext(SceneLib.alvinaFollower.alvinaThirdEncounterYesNeverWon);
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			cleanupAfterCombat();
			if (flags[kFLAGS.GAME_DIFFICULTY] >= 2)
				SceneLib.alvinaFollower.alvinaThirdEncounterYesNeverLostNightmare();
			else
				SceneLib.alvinaFollower.alvinaThirdEncounterYesNeverLost();
		}

		public function Alvina()
		{
			this.a = "";
			this.short = "Archmage Alvina Shadowmantle, Mother of Black Magic";
			this.imageName = "alvina";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 20, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("A"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,15,0,0,0);
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE;
			this.lowerBody = LowerBody.HOOFED;
			this.bodyColor = "purple";
			this.hairColor = "black";
			this.hairLength = 20;
			if (flags[kFLAGS.GAME_DIFFICULTY] >= 2 || SceneLib.alvinaFollower.FightForAlvina) {
				this.long = "Alvina is a goat-like succubus. She is obviously an accomplished spellcaster.  She holds a pair of burning scythes in both hands, her spellbook levitating around her. The aura of black magic emanating from her is almost smothering you. She has taken on a way more intimidating form, reaching 11 feet tall with ease. Her black wings stretch from one side of the room to the other while the very ground she walks catches on fire as if unable to support her energy pressure.";
				this.tallness = 11*12;
				initStrTouSpeInte(800, 930, 840, 1160);
				initWisLibSensCor(900, 800, 240, 100);
				this.weaponAttack = 800;
				this.armorDef = 120;
				this.armorMDef = 120;
				if (SceneLib.alvinaFollower.DefeatedAlvinaFirstStage){
					this.bonusHP = 4250000;
					alvinaMaleficium();
				}
				else {
					this.bonusHP = 425000;
				}
				this.bonusMana = 32000;
				this.bonusLust = 1310;
				this.level = 205;
			} else {
				this.long = "Alvina is a goat-like succubus. While she is barely taller than 4 and a half feet, she is obviously an accomplished spellcaster.  From the way she holds her scythe in one hand and her spellbook in the other you also expect her to be very strong,  despite the fact that she wears glasses. A powerful aura of black magic emanates from her.";
				this.tallness = 4*12+6;
				initStrTouSpeInte(375, 455, 390, 480);
				initWisLibSensCor(480, 375, 115, 100);
				this.weaponAttack = 25;
				this.armorDef = 50;
				this.armorMDef = 50;
				if (SceneLib.alvinaFollower.DefeatedAlvinaFirstStage){
					this.bonusHP = 2000000;
					alvinaMaleficium();
				}
				else this.bonusHP = 200000;
				this.bonusMana = 15000;
				this.bonusLust = 590;
				this.level = 100;
			}
			this.weaponName = "demonic scythe";
			this.weaponVerb="slash";
			this.armorName = "demon-skin";
			this.lust = 30;
			if (hasStatusEffect(StatusEffects.Maleficium)) this.lustVuln = 0.75;
			else this.lustVuln = 0.5;
			this.drop = NO_DROP;
			this.gems = rand(25) + 138;
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.MindOverBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, 100, 0, 0, 0);
			this.createPerk(PerkLib.Phylactery, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyResiliance, 0, 0, 0, 0);
			checkMonster();
		}
	}
}
