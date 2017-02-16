//Combat 2.0
package classes.Scenes.Combat 
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Items.*;
	import classes.Scenes.Areas.Bog.*;
	import classes.Scenes.Areas.Desert.*;
	import classes.Scenes.Areas.Forest.*;
	import classes.Scenes.Areas.GlacialRift.*;
	import classes.Scenes.Areas.HighMountains.*;
	import classes.Scenes.Areas.Lake.*;
	import classes.Scenes.Areas.Mountain.*;
	import classes.Scenes.Areas.Plains.*;
	import classes.Scenes.Areas.Swamp.*;
	import classes.Scenes.Areas.VolcanicCrag.*;
	import classes.Scenes.Dungeons.DeepCave.*;
	import classes.Scenes.Dungeons.DesertCave.*;
	import classes.Scenes.Dungeons.D3.*;
	import classes.Scenes.Dungeons.Factory.*;
	import classes.Scenes.Dungeons.HelDungeon.*;
	import classes.Scenes.Monsters.*;
	import classes.Scenes.NPCs.*;
	import classes.Scenes.Places.Boat.*;
	import classes.Scenes.Places.Farm.*;
	import classes.Scenes.Places.Owca.*;
	import classes.Scenes.Places.Prison.*;
	import classes.Scenes.Quests.UrtaQuest.*;
	import classes.Scenes.Places.TelAdre.UmasShop;

	import coc.view.MainView;
	import classes.internals.Utils;

	public class Combat extends BaseContent
	{
		public function Combat() {}
		
		public var combatAbilities:CombatAbilities = new CombatAbilities();
		public var combatTeases:CombatTeases = new CombatTeases();
		
		public var plotFight:Boolean = false; //Used to restrict random drops from overlapping uniques
		public var combatRound:int = 0;
		
		//Used to display image of the enemy while fighting
		//Set once during beginCombat() to prevent it from changing every combat turn
		private var imageText:String = "";
		
		public function get inCombat():Boolean {
			return getGame().inCombat;
		}
		
		public function set inCombat(mode:Boolean):void {
			getGame().inCombat = mode;
		}
		
		//Victory & Loss
		public function endHpVictory():void { 
			monster.defeated_(true);
		}
		public function endLustVictory():void {
			monster.defeated_(false);
		}
		public function endHpLoss():void {
			monster.won_(true,false);
		}
		public function endLustLoss():void {
			if (player.findStatusEffect(StatusEffects.Infested) >= 0 && flags[kFLAGS.CAME_WORMS_AFTER_COMBAT] == 0) {
				flags[kFLAGS.CAME_WORMS_AFTER_COMBAT] = 1;
				getGame().mountain.wormsScene.infestOrgasm();
				monster.won_(false,true);
			} else {
				monster.won_(false,false);
			}
		}
		
		//Combat is over. Clear shit out and go to main. Also given different name to avoid conflicts with BaseContent.
		public function cleanupAfterCombat(nextFunc:Function = null):void {
			combatAbilities.fireMagicLastTurn = -100;
			if (nextFunc == null) nextFunc = camp.returnToCampUseOneHour;
			if (prison.inPrison && prison.prisonCombatWinEvent != null) nextFunc = prison.prisonCombatWinEvent;
			if (inCombat) {
				//clear status
				clearStatuses(false);
				
				//reset the stored image for next monster
				imageText = "";
				
				//Clear itemswapping in case it hung somehow
		//No longer used:		itemSwapping = false;
				//Player won
				if (monster.HP < 1 || monster.lust >= monster.eMaxLust()) {
					awardPlayer(nextFunc);
				}
				//Player lost
				else {
					if (monster.statusEffectv1(StatusEffects.Sparring) == 2) {
						outputText("The cow-girl has defeated you in a practice fight!", true);
						outputText("\n\nYou have to lean on Isabella's shoulder while the two of your hike back to camp.  She clearly won.", false);
						inCombat = false;
						player.HP = 1;
						statScreenRefresh();
						doNext(nextFunc);
						return;
					}
					//Next button is handled within the minerva loss function
					if (monster.findStatusEffect(StatusEffects.PeachLootLoss) >= 0) {
						inCombat = false;
						player.HP = 1;
						statScreenRefresh();
						return;
					}
					if (monster.short == "Ember") {
						inCombat = false;
						player.HP = 1;
						statScreenRefresh();
						doNext(nextFunc);
						return;
					}
					temp = rand(10) + 1 + Math.round(monster.level / 2);
					if (inDungeon) temp += 20 + monster.level * 2;
					//Increases gems lost in NG+.
					temp *= 1 + (player.newGamePlusMod() * 0.5);
					//Round gems.
					temp = Math.round(temp);
					//Keep gems from going below zero.
					if (temp > player.gems) temp = player.gems;
					var timePasses:int = monster.handleCombatLossText(inDungeon, temp); //Allows monsters to customize the loss text and the amount of time lost
					player.gems -= temp;
					inCombat = false;
					if (prison.inPrison == false && flags[kFLAGS.PRISON_CAPTURE_CHANCE] > 0 && rand(100) < flags[kFLAGS.PRISON_CAPTURE_CHANCE] && (prison.trainingFeed.prisonCaptorFeedingQuestTrainingIsTimeUp() || !prison.trainingFeed.prisonCaptorFeedingQuestTrainingExists()) && (monster.short == "goblin" || monster.short == "goblin assassin" || monster.short == "imp" || monster.short == "imp lord" || monster.short == "imp warlord" || monster.short == "hellhound" || monster.short == "minotaur" || monster.short == "satyr" || monster.short == "gnoll" || monster.short == "gnoll spear-thrower" || monster.short == "basilisk")) {
						outputText("  You feel yourself being dragged and carried just before you black out.");
						doNext(prison.prisonIntro);
						return;
					}
					//BUNUS XPZ
					if (flags[kFLAGS.COMBAT_BONUS_XP_VALUE] > 0) {
						player.XP += flags[kFLAGS.COMBAT_BONUS_XP_VALUE];
						outputText("  Somehow you managed to gain " + flags[kFLAGS.COMBAT_BONUS_XP_VALUE] + " XP from the situation.");
						flags[kFLAGS.COMBAT_BONUS_XP_VALUE] = 0;
					}
					//Bonus lewts
					if (flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] != "") {
						outputText("  Somehow you came away from the encounter with " + ItemType.lookupItem(flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID]).longName + ".\n\n");
						inventory.takeItem(ItemType.lookupItem(flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID]), createCallBackFunction(camp.returnToCamp, timePasses));
					}
					else doNext(createCallBackFunction(camp.returnToCamp, timePasses));
				}
			}
			//Not actually in combat
			else doNext(nextFunc);
		}

		public function checkAchievementDamage(damage:Number):void
		{
			flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] += damage;
			if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 50000) kGAMECLASS.awardAchievement("Bloodletter", kACHIEVEMENTS.COMBAT_BLOOD_LETTER);
			if (damage >= 50) kGAMECLASS.awardAchievement("Pain", kACHIEVEMENTS.COMBAT_PAIN);
			if (damage >= 100) kGAMECLASS.awardAchievement("Fractured Limbs", kACHIEVEMENTS.COMBAT_FRACTURED_LIMBS);
			if (damage >= 250) kGAMECLASS.awardAchievement("Broken Bones", kACHIEVEMENTS.COMBAT_BROKEN_BONES);
			if (damage >= 500) kGAMECLASS.awardAchievement("Overkill", kACHIEVEMENTS.COMBAT_OVERKILL);
		}
		public function approachAfterKnockback():void
		{
			clearOutput();
			outputText("You close the distance between you and " + monster.a + monster.short + " as quickly as possible.\n\n");
			player.removeStatusEffect(StatusEffects.KnockedBack);
			if (player.weaponName == "flintlock pistol") {
				if (flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] <= 0) {
					flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = 4;
					outputText("At the same time, you open the chamber of your pistol to reload the ammunition.  This takes up a turn.\n\n");
					monster.doAI();
					return;
				}
				else {
					outputText("At the same time, you fire a round at " + monster.short + ". ");
					attack();
					return;
				}
			}
			if (player.weaponName == "crossbow") {
				outputText("At the same time, you fire a bolt at " + monster.short + ". ");
				attack();
				return;
			}
			monster.doAI();
			return;
		}

		private function isPlayerSilenced():Boolean
		{
			var temp:Boolean = false;
			if (player.findStatusEffect(StatusEffects.ThroatPunch) >= 0) temp = true;
			if (player.findStatusEffect(StatusEffects.WebSilence) >= 0) temp = true;
			if (player.findStatusEffect(StatusEffects.GooArmorSilence) >= 0) temp = true;
			if (player.findStatusEffect(StatusEffects.WhipSilence) >= 0) temp = true;
			return temp;
		}

		private function isPlayerBound():Boolean 
		{
			var temp:Boolean = false;
			if (player.findStatusEffect(StatusEffects.HarpyBind) >= 0 || player.findStatusEffect(StatusEffects.GooBind) >= 0 || player.findStatusEffect(StatusEffects.TentacleBind) >= 0 || player.findStatusEffect(StatusEffects.NagaBind) >= 0 || monster.findStatusEffect(StatusEffects.QueenBind) >= 0 || monster.findStatusEffect(StatusEffects.PCTailTangle) >= 0) temp = true;
			if (player.findStatusEffect(StatusEffects.HolliConstrict) >= 0) temp = true;
			if (player.findStatusEffect(StatusEffects.GooArmorBind) >= 0) temp = true;
			if (monster.findStatusEffect(StatusEffects.MinotaurEntangled) >= 0) {
				outputText("\n<b>You're bound up in the minotaur lord's chains!  All you can do is try to struggle free!</b>");
				temp = true;
			}
			if (player.findStatusEffect(StatusEffects.UBERWEB) >= 0) temp = true;
			if (player.findStatusEffect(StatusEffects.Bound) >= 0) temp = true;
			if (player.findStatusEffect(StatusEffects.Chokeslam) >= 0) temp = true;
			if (player.findStatusEffect(StatusEffects.Titsmother) >= 0) temp = true;
			if (player.findStatusEffect(StatusEffects.GiantGrabbed) >= 0) {
				outputText("\n<b>You're trapped in the giant's hand!  All you can do is try to struggle free!</b>");
				temp = true;
			}
			if (player.findStatusEffect(StatusEffects.Tentagrappled) >= 0) {
				outputText("\n<b>The demonesses tentacles are constricting your limbs!</b>");
				temp = true;
			}
			return temp;
		}

		private function isPlayerStunned():Boolean 
		{
			var temp:Boolean = false;
			if (player.findStatusEffect(StatusEffects.IsabellaStunned) >= 0 || player.findStatusEffect(StatusEffects.Stunned) >= 0) {
				outputText("\n<b>You're too stunned to attack!</b>  All you can do is wait and try to recover!");
				temp = true;
			}
			if (player.findStatusEffect(StatusEffects.Whispered) >= 0) {
				outputText("\n<b>Your mind is too addled to focus on combat!</b>  All you can do is try and recover!");
				temp = true;
			}
			if (player.findStatusEffect(StatusEffects.Confusion) >= 0) {
				outputText("\n<b>You're too confused</b> about who you are to try to attack!");
				temp = true;
			}
			return temp;
		}

		public function combatMenu(newRound:Boolean = true):void { //If returning from a sub menu set newRound to false
			clearOutput();
			flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] = 0;
			mainView.hideMenuButton(MainView.MENU_DATA);
			mainView.hideMenuButton(MainView.MENU_APPEARANCE);
			mainView.hideMenuButton(MainView.MENU_PERKS);
			hideUpDown();
			if (newRound) combatStatusesUpdate(); //Update Combat Statuses
			display();
			statScreenRefresh();
		//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
			if (combatRoundOver()) return;
			menu();
			var attacks:Function = normalAttack;
			//Standard menu before modifications.
			if (!isWieldingRangedWeapon())
				addButton(0, "Attack", attacks, null, null, null, "Attempt to attack the enemy with your " + player.weaponName + ".  Damage done is determined by your strength and weapon.");
			else if (player.weaponName.indexOf("staff") != -1)
				addButton(0, "M.Bolt", attacks, null, null, null, "Attempt to attack the enemy with magic bolt from your " + player.weaponName + ".  Damage done is determined by your intelligence, speed and weapon.", "Magic Bolt");
			else if (flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] <= 0 && player.weaponName == "flintlock pistol")
				addButton(0, "Reload", attacks, null, null, null, "Your " + player.weaponName + " is out of ammo.  You'll have to reload it before attack.");
			else
				addButton(0, "Shoot", attacks, null, null, null, "Fire a round at your opponent with your " + player.weaponName + "!  Damage done is determined by your strength, speed and weapon.");
				
			addButton(1, "Tease", combatTeases.teaseAttack, null, null, null, "Attempt to make an enemy more aroused by striking a seductive pose and exposing parts of your body.");
			if (combatAbilities.canUseMagic()) addButton(2, "Spells", combatAbilities.magicMenu, null, null, null, "Opens your spells menu, where you can cast any spells you have learned.  Beware, casting spells increases your fatigue, and if you become exhausted you will be easier to defeat.");
			addButton(3, "Items", inventory.inventoryMenu, null, null, null, "The inventory allows you to use an item.  Be careful as this leaves you open to a counterattack when in combat.");
			addButton(4, "Run", runAway, null, null, null, "Choosing to run will let you try to escape from your enemy. However, it will be hard to escape enemies that are faster than you and if you fail, your enemy will get a free attack.");
			addButton(5, "P. Specials", combatAbilities.physicalSpecials, null, null, null, "Physical special attack menu.", "Physical Specials");
			addButton(6, "M. Specials", combatAbilities.magicalSpecials, null, null, null, "Mental and supernatural special attack menu.", "Magical Specials");
			addButton(7, "Wait", wait, null, null, null, "Take no action for this round.  Why would you do this?  This is a terrible idea.");
			if (monster.findStatusEffect(StatusEffects.Level) >= 0) addButton(7, "Climb", wait, null, null, null, "Climb the sand to move away from the sand trap.");
			addButton(8, "Fantasize", fantasize, null, null, null, "Fantasize about your opponent in a sexual way.  Its probably a pretty bad idea to do this unless you want to end up getting raped.");
			if (CoC_Settings.debugBuild && !debug) addButton(9, "Inspect", debugInspect, null, null, null, "Use your debug powers to inspect your enemy.");
			//Modify menus.
			if (monster.findStatusEffect(StatusEffects.AttackDisabled) >= 0) {
				if (monster.short == "minotaur lord") {
					outputText("\n<b>Chained up as you are, you can't manage any real physical attacks!</b>");
					attacks = null;
				}
				else if (monster.short == "Lethice") {
					outputText("\n<b>Lethice's wings continue to flap and she keeps herself just out of reach.</b>");
					if (isWieldingRangedWeapon()) {
						outputText(" <b>Fortunately, you have a ranged weapon.</b>");
					}
					else {
						attacks = null;
					}
				}
			}
			//Knocked back
			if (player.findStatusEffect(StatusEffects.KnockedBack) >= 0)
			{
				outputText("\n<b>You'll need to close some distance before you can use any physical attacks!</b>");
				if (isWieldingRangedWeapon()) {
					if (flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] <= 0 && player.weaponName == "flintlock pistol") addButton(0, "Reload&Approach", approachAfterKnockback, null, null, null, "Reload your flintlock pistol while approaching.", "Reload and Approach");
					else addButton(0, "Shoot&Approach", approachAfterKnockback, null, null, null, "Fire a round at your opponent and approach.", "Reload and Approach");
				}
				else addButton(0, "Approach", approachAfterKnockback, null, null, null, "Close some distance between you and your opponent.");
				if (player.hasKeyItem("Bow") >= 0 || player.hasKeyItem("Kelt's Bow") >= 0) addButton(5, "Bow", combatAbilities.fireBow);
			}
			//Disabled physical attacks
			if (monster.findStatusEffect(StatusEffects.PhysicalDisabled) >= 0) {
				outputText("<b>  Even physical special attacks are out of the question.</b>");
				removeButton(5); //Removes physical special attack.
			}
			//Bound: Struggle or wait
			if (isPlayerBound()) {
				menu();
				addButton(0, "Struggle", struggle);
				addButton(1, "Wait", wait);
				if (player.findStatusEffect(StatusEffects.UBERWEB) >= 0) {
					addButton(6, "M. Special", combatAbilities.magicalSpecials);
				}
				if (player.findStatusEffect(StatusEffects.Bound) >= 0) {
					addButton(0, "Struggle", (monster as Ceraph).ceraphBindingStruggle);
					addButton(1, "Wait", (monster as Ceraph).ceraphBoundWait);
				}
				if (player.findStatusEffect(StatusEffects.Chokeslam) >= 0) {
					addButton(0, "Struggle", (monster as Izumi).chokeSlamStruggle);
					addButton(1, "Wait", (monster as Izumi).chokeSlamWait);
				}
				if (player.findStatusEffect(StatusEffects.Titsmother) >= 0) {
					addButton(0, "Struggle", (monster as Izumi).titSmotherStruggle);
					addButton(1, "Wait", (monster as Izumi).titSmotherWait);
				}
				if (player.findStatusEffect(StatusEffects.Tentagrappled) >= 0) {
					addButton(0, "Struggle", (monster as SuccubusGardener).grappleStruggle);
					addButton(1, "Wait", (monster as SuccubusGardener).grappleWait);
				}
			}
			//Silence: Disables magic menu.
			if (isPlayerSilenced()) {
				removeButton(2);
			}
			//Stunned: Recover, lose 1 turn.
			if (isPlayerStunned()) {
				menu();
				addButton(0, "Recover", wait);
			}
			else if (monster.findStatusEffect(StatusEffects.Constricted) >= 0) {
				menu();
				addButton(0, "Squeeze", getGame().desert.nagaScene.naggaSqueeze, null, null, null, "Squeeze some HP out of your opponent! \n\nFatigue Cost: " + player.physicalCost(20) + "");
				addButton(1, "Tease", getGame().desert.nagaScene.naggaTease);
				addButton(4, "Release", getGame().desert.nagaScene.nagaLeggoMyEggo);
			}
		}

		private function normalAttack():void {
			clearOutput();
			attack();
		}

		public function packAttack():void {
			//Determine if dodged!
			if (player.spe - monster.spe > 0 && int(Math.random() * (((player.spe - monster.spe) / 4) + 80)) > 80) {
				outputText("You duck, weave, and dodge.  Despite their best efforts, the throng of demons only hit the air and each other.");
			}
			//Determine if evaded
			else if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep " + monster.a + monster.short + "' attacks.");
			}
			//("Misdirection"
			else if (player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 15 && player.armorName == "red, high-society bodysuit") {
				outputText("Using Raphael's teachings, you anticipate and sidestep " + monster.a + monster.short + "' attacks.");
			}
			//Determine if cat'ed
			else if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 6) {
				outputText("With your incredible flexibility, you squeeze out of the way of " + monster.a + monster.short + "' attacks.");
			}
			else {
				temp = int((monster.str + monster.weaponAttack) * (player.damagePercent() / 100)); //Determine damage - str modified by enemy toughness!
				if (temp <= 0) {
					temp = 0;
					if (!monster.plural)
						outputText("You deflect and block every " + monster.weaponVerb + " " + monster.a + monster.short + " throw at you.");
					else outputText("You deflect " + monster.a + monster.short + " " + monster.weaponVerb + ".");
				}
				else {
					if (temp <= 5)
						outputText("You are struck a glancing blow by " + monster.a + monster.short + "! ");
					else if (temp <= 10)
						outputText(monster.capitalA + monster.short + " wound you! ");
					else if (temp <= 20)
						outputText(monster.capitalA + monster.short + " stagger you with the force of " + monster.pronoun3 + " " + monster.weaponVerb + "s! ");
					else outputText(monster.capitalA + monster.short + " <b>mutilates</b> you with powerful fists and " + monster.weaponVerb + "s! ");
					takeDamage(temp, true);
				}
				statScreenRefresh();
				outputText("\n");
			}
			combatRoundOver();
		}

		public function lustAttack():void {
			if (player.lust < 35) {
				outputText("The " + monster.short + " press in close against you and although they fail to hit you with an attack, the sensation of their skin rubbing against yours feels highly erotic.");
			}
			else if (player.lust < 65) {
				outputText("The push of the " + monster.short + "' sweaty, seductive bodies sliding over yours is deliciously arousing and you feel your ");
				if (player.cocks.length > 0)
					outputText(player.multiCockDescriptLight() + " hardening ");
				else if (player.vaginas.length > 0) outputText(player.vaginaDescript(0) + " get wetter ");
				outputText("in response to all the friction.");
			}
			else {
				outputText("As the " + monster.short + " mill around you, their bodies rub constantly over yours, and it becomes harder and harder to keep your thoughts on the fight or resist reaching out to touch a well lubricated cock or pussy as it slips past.  You keep subconsciously moving your ");
				if (player.gender == 1) outputText(player.multiCockDescriptLight() + " towards the nearest inviting hole.");
				if (player.gender == 2) outputText(player.vaginaDescript(0) + " towards the nearest swinging cock.");
				if (player.gender == 3) outputText("aching cock and thirsty pussy towards the nearest thing willing to fuck it.");
				if (player.gender == 0) outputText("groin, before remember there is nothing there to caress.");
			}
			dynStats("lus", 10 + player.sens / 10);
			combatRoundOver();
		}

		private function wait():void {
			//Gain fatigue if not fighting sand tarps
			if (monster.findStatusEffect(StatusEffects.Level) < 0) player.changeFatigue(-5);
			flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] = 1;
			if (monster.findStatusEffect(StatusEffects.PCTailTangle) >= 0) {
				(monster as Kitsune).kitsuneWait();
			}
			else if (monster.findStatusEffect(StatusEffects.Level) >= 0) {
				(monster as SandTrap).sandTrapWait();
			}
			else if (monster.findStatusEffect(StatusEffects.MinotaurEntangled) >= 0) {
				clearOutput();
				outputText("You sigh and relax in the chains, eying the well-endowed minotaur as you await whatever rough treatment he desires to give.  His musky, utterly male scent wafts your way on the wind, and you feel droplets of your lust dripping down your thighs.  You lick your lips as you watch the pre-cum drip from his balls, eager to get down there and worship them.  Why did you ever try to struggle against this fate?\n\n");
				dynStats("lus", 30 + rand(5), "resisted", false);
				monster.doAI();
			}
			else if (player.findStatusEffect(StatusEffects.Whispered) >= 0) {
				clearOutput();
				outputText("You shake off the mental compulsions and ready yourself to fight!\n\n");
				player.removeStatusEffect(StatusEffects.Whispered);
				monster.doAI();
			}
			else if (player.findStatusEffect(StatusEffects.HarpyBind) >= 0) {
				clearOutput();
				outputText("The brood continues to hammer away at your defenseless self. ");
				temp = 80 + rand(40);
				temp = takeDamage(temp, true);
				combatRoundOver();
			}
			else if (monster.findStatusEffect(StatusEffects.QueenBind) >= 0) {
				(monster as HarpyQueen).ropeStruggles(true);
			}
			else if (player.findStatusEffect(StatusEffects.GooBind) >= 0) {
				clearOutput();
				outputText("You writhe uselessly, trapped inside the goo girl's warm, seething body. Darkness creeps at the edge of your vision as you are lulled into surrendering by the rippling vibrations of the girl's pulsing body around yours.");
				temp = takeDamage(.35 * player.maxHP(), true);
				combatRoundOver();
			}
			else if (player.findStatusEffect(StatusEffects.GooArmorBind) >= 0) {
				clearOutput();
				outputText("Suddenly, the goo-girl leaks half-way out of her heavy armor and lunges at you. You attempt to dodge her attack, but she doesn't try and hit you - instead, she wraps around you, pinning your arms to your chest. More and more goo latches onto you - you'll have to fight to get out of this.");
				player.addStatusValue(StatusEffects.GooArmorBind, 1, 1);
				if (player.statusEffectv1(StatusEffects.GooArmorBind) >= 5) {
					if (monster.findStatusEffect(StatusEffects.Spar) >= 0)
						getGame().valeria.pcWinsValeriaSparDefeat();
					else getGame().dungeons.heltower.gooArmorBeatsUpPC();
					return;
				}
				combatRoundOver();
			}
			else if (player.findStatusEffect(StatusEffects.NagaBind) >= 0) {
				clearOutput();
				outputText("The naga's grip on you tightens as you relax into the stimulating pressure.");
				dynStats("lus", player.sens / 5 + 5);
				takeDamage(5 + rand(5));
				combatRoundOver();
			}
			else if (player.findStatusEffect(StatusEffects.HolliConstrict) >= 0) {
				(monster as Holli).waitForHolliConstrict(true);
			}
			else if (player.findStatusEffect(StatusEffects.TentacleBind) >= 0) {
				clearOutput();
				if (player.cocks.length > 0)
					outputText("The creature continues spiraling around your cock, sending shivers up and down your body. You must escape or this creature will overwhelm you!");
				else if (player.hasVagina())
					outputText("The creature continues sucking your clit and now has latched two more suckers on your nipples, amplifying your growing lust. You must escape or you will become a mere toy to this thing!");
				else outputText("The creature continues probing at your asshole and has now latched " + num2Text(player.totalNipples()) + " more suckers onto your nipples, amplifying your growing lust.  You must escape or you will become a mere toy to this thing!");
				dynStats("lus", (8 + player.sens / 10));
				combatRoundOver();
			}
			else if (player.findStatusEffect(StatusEffects.GiantGrabbed) >= 0) {
				clearOutput();
				(monster as FrostGiant).giantGrabFail(false);
			}
			else if (player.findStatusEffect(StatusEffects.GiantBoulder) >= 0) {
				clearOutput();
				(monster as FrostGiant).giantBoulderMiss();
			}
			else if (player.findStatusEffect(StatusEffects.IsabellaStunned) >= 0) {
				clearOutput();
				outputText("You wobble about for some time but manage to recover. Isabella capitalizes on your wasted time to act again.\n\n");
				player.removeStatusEffect(StatusEffects.IsabellaStunned);
				monster.doAI();
			}
			else if (player.findStatusEffect(StatusEffects.Stunned) >= 0) {
				clearOutput();
				outputText("You wobble about, stunned for a moment.  After shaking your head, you clear the stars from your vision, but by then you've squandered your chance to act.\n\n");
				player.removeStatusEffect(StatusEffects.Stunned);
				monster.doAI();
			}
			else if (player.findStatusEffect(StatusEffects.Confusion) >= 0) {
				clearOutput();
				outputText("You shake your head and file your memories in the past, where they belong.  It's time to fight!\n\n");
				player.removeStatusEffect(StatusEffects.Confusion);
				monster.doAI();
			}
			else if (monster is Doppleganger) {
				clearOutput();
				outputText("You decide not to take any action this round.\n\n");
				(monster as Doppleganger).handlePlayerWait();
				monster.doAI();
			}
			else {
				clearOutput();
				outputText("You decide not to take any action this round.\n\n");
				monster.doAI();
			}
		}

		private function struggle():void {
			if (monster.findStatusEffect(StatusEffects.MinotaurEntangled) >= 0) {
				clearOutput();
				if (player.str / 9 + rand(20) + 1 >= 15) {
					outputText("Utilizing every ounce of your strength and cunning, you squirm wildly, shrugging through weak spots in the chain's grip to free yourself!  Success!\n\n");
					monster.removeStatusEffect(StatusEffects.MinotaurEntangled);
					if (flags[kFLAGS.URTA_QUEST_STATUS] == 0.75) outputText("\"<i>No!  You fool!  You let her get away!  Hurry up and finish her up!  I need my serving!</i>\"  The succubus spits out angrily.\n\n");
					combatRoundOver();
				}
				//Struggle Free Fail*
				else {
					outputText("You wiggle and struggle with all your might, but the chains remain stubbornly tight, binding you in place.  Damnit!  You can't lose like this!\n\n");
					monster.doAI();
				}
			}
			else if (monster.findStatusEffect(StatusEffects.PCTailTangle) >= 0) {
				(monster as Kitsune).kitsuneStruggle();
			}
			else if (player.findStatusEffect(StatusEffects.HolliConstrict) >= 0) {
				(monster as Holli).struggleOutOfHolli();
			}
			else if (monster.findStatusEffect(StatusEffects.QueenBind) >= 0) {
				(monster as HarpyQueen).ropeStruggles();
			}
			else if (player.findStatusEffect(StatusEffects.GooBind) >= 0) {
				clearOutput();
				//[Struggle](successful) :
				if (rand(3) == 0 || rand(80) < player.str) {
					outputText("You claw your fingers wildly within the slime and manage to brush against her heart-shaped nucleus. The girl silently gasps and loses cohesion, allowing you to pull yourself free while she attempts to solidify.");
					player.removeStatusEffect(StatusEffects.GooBind);
				}
				//Failed struggle
				else {
					outputText("You writhe uselessly, trapped inside the goo girl's warm, seething body. Darkness creeps at the edge of your vision as you are lulled into surrendering by the rippling vibrations of the girl's pulsing body around yours. ");
					temp = takeDamage(Math.min(.15 * player.maxHP(), 100 * (1 + (player.newGamePlusMod() * 0.2))), true);
				}
				combatRoundOver();
			}
			else if (player.findStatusEffect(StatusEffects.HarpyBind) >= 0) {
				(monster as HarpyMob).harpyHordeGangBangStruggle();
			}
			else if (player.findStatusEffect(StatusEffects.GooArmorBind) >= 0) {
				(monster as GooArmor).struggleAtGooBind();
			}
			else if (player.findStatusEffect(StatusEffects.UBERWEB) >= 0) {
				clearOutput();
				outputText("You claw your way out of the webbing while Kiha does her best to handle the spiders single-handedly!\n\n");
				player.removeStatusEffect(StatusEffects.UBERWEB);
				monster.doAI();
			}
			else if (player.findStatusEffect(StatusEffects.NagaBind) >= 0) {
				clearOutput();
				if (rand(3) == 0 || rand(80) < player.str / 1.5) {
					outputText("You wriggle and squirm violently, tearing yourself out from within the naga's coils.");
					player.removeStatusEffect(StatusEffects.NagaBind);
				}
				else {
					outputText("The naga's grip on you tightens as you struggle to break free from the stimulating pressure.");
					dynStats("lus", player.sens / 10 + 2);
					takeDamage(7 + rand(5));
				}
				combatRoundOver();
			}
			else if (player.findStatusEffect(StatusEffects.GiantGrabbed) >= 0) {
				(monster as FrostGiant).giantGrabStruggle();
			}
			else {
				clearOutput();
				outputText("You struggle with all of your might to free yourself from the tentacles before the creature can fulfill whatever unholy desire it has for you.\n");
				//33% chance to break free + up to 50% chance for strength
				if (rand(3) == 0 || rand(80) < player.str / 2) {
					outputText("As the creature attempts to adjust your position in its grip, you free one of your " + player.legs() + " and hit the beast in its beak, causing it to let out an inhuman cry and drop you to the ground smartly.\n\n");
					player.removeStatusEffect(StatusEffects.TentacleBind);
					monster.createStatusEffect(StatusEffects.TentacleCoolDown, 3, 0, 0, 0);
					monster.doAI();
				}
				//Fail to break free
				else {
					outputText("Despite trying to escape, the creature only tightens its grip, making it difficult to breathe.\n\n");
					takeDamage(5);
					if (player.cocks.length > 0)
						outputText("The creature continues spiraling around your cock, sending shivers up and down your body. You must escape or this creature will overwhelm you!");
					else if (player.hasVagina())
						outputText("The creature continues sucking your clit and now has latched two more suckers on your nipples, amplifying your growing lust. You must escape or you will become a mere toy to this thing!");
					else outputText("The creature continues probing at your asshole and has now latched " + num2Text(player.totalNipples()) + " more suckers onto your nipples, amplifying your growing lust.  You must escape or you will become a mere toy to this thing!");
					dynStats("lus", (3 + player.sens / 10 + player.lib / 20));
					combatRoundOver();
				}
			}
		}

		private function debugInspect():void {
			outputText(monster.generateDebugDescription());
			doNext(playerMenu);
		}

		//Fantasize
		public function fantasize():void {
			var temp2:Number = 0;
			doNext(combatMenu);
			clearOutput();
			if (monster.short == "frost giant" && (player.findStatusEffect(StatusEffects.GiantBoulder) >= 0)) {
				temp2 = 10 + rand(player.lib / 5 + player.cor / 8);
				dynStats("lus", temp2, "resisted", false);
				(monster as FrostGiant).giantBoulderFantasize();
				monster.doAI();
				return;
			}
			if (player.armorName == "goo armor") {
				outputText("As you fantasize, you feel Valeria rubbing her gooey body all across your sensitive skin");
				if (player.gender > 0) outputText(" and genitals");
				outputText(", arousing you even further.\n");
				temp2 = 25 + rand(player.lib/8+player.cor/8)
			}	
			else if (player.balls > 0 && player.ballSize >= 10 && rand(2) == 0) {
				outputText("You daydream about fucking " + monster.a + monster.short + ", feeling your balls swell with seed as you prepare to fuck " + monster.pronoun2 + " full of cum.\n", false);
				temp2 = 5 + rand(player.lib/8+player.cor/8);
				outputText("You aren't sure if it's just the fantasy, but your " + player.ballsDescriptLight() + " do feel fuller than before...\n", false);
				player.hoursSinceCum += 50;
			}
			else if (player.biggestTitSize() >= 6 && rand(2) == 0) {
				outputText("You fantasize about grabbing " + monster.a + monster.short + " and shoving " + monster.pronoun2 + " in between your jiggling mammaries, nearly suffocating " + monster.pronoun2 + " as you have your way.\n", false);
				temp2 = 5 + rand(player.lib/8+player.cor/8)
			}
			else if (player.biggestLactation() >= 6 && rand(2) == 0) {
				outputText("You fantasize about grabbing " + monster.a + monster.short + " and forcing " + monster.pronoun2 + " against a " + player.nippleDescript(0) + ", and feeling your milk let down.  The desire to forcefeed SOMETHING makes your nipples hard and moist with milk.\n", false);
				temp2 = 5 + rand(player.lib/8+player.cor/8)
			}
			else {
				outputText("You fill your mind with perverted thoughts about " + monster.a + monster.short + ", picturing " + monster.pronoun2 + " in all kinds of perverse situations with you.\n", true);	
				temp2 = 10+rand(player.lib/5+player.cor/8);		
			}
			if (temp2 >= 20) outputText("The fantasy is so vivid and pleasurable you wish it was happening now.  You wonder if " + monster.a + monster.short + " can tell what you were thinking.\n\n", false);
			else outputText("\n", false);
			dynStats("lus", temp2, "resisted", false);
			if (player.lust >= player.maxLust()) {
				if (monster.short == "pod") {
					outputText("<b>You nearly orgasm, but the terror of the situation reasserts itself, muting your body's need for release.  If you don't escape soon, you have no doubt you'll be too fucked up to ever try again!</b>\n\n", false);
					player.lust = 99;
					dynStats("lus", -25);
				}
				else {
					doNext(endLustLoss);
					return;
				}
			}
			monster.doAI();	
		}


		public function fatigueRecovery():void {
			player.changeFatigue(-1);
			if (player.findPerk(PerkLib.EnlightenedNinetails) >= 0 || player.findPerk(PerkLib.CorruptedNinetails) >= 0) player.changeFatigue(-(1+rand(3)));
		}

		//ATTACK
		public function attack():void {
			if (player.findStatusEffect(StatusEffects.FirstAttack) < 0) {
				clearOutput();
				fatigueRecovery();
			}
			if (player.findStatusEffect(StatusEffects.Sealed) >= 0 && player.statusEffectv2(StatusEffects.Sealed) == 0 && !isWieldingRangedWeapon()) {
				outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  The kitsune's seals have made normal attack impossible!  Maybe you could try something else?\n\n", false);
				monster.doAI();
				return;
			}
			if (flags[kFLAGS.PC_FETISH] >= 3 && !getGame().urtaQuest.isUrta() && !isWieldingRangedWeapon()) {
				outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  Ceraph's piercings have made normal attack impossible!  Maybe you could try something else?\n\n", false);
				monster.doAI();
				return;
			}
			if (player.findStatusEffect(StatusEffects.TaintedMind) >= 0 && !isWieldingRangedWeapon()) {
				(monster as DriderIncubus).taintedMindAttackAttempt();
				monster.doAI();
				return;
			}
			flags[kFLAGS.LAST_ATTACK_TYPE] = 0;
			//Reload
			if (player.weaponName == "flintlock pistol") {
				if (flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] <= 0) {
					flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = 4;
					outputText("You open the chamber of your pistol to reload the ammunition.  This takes up a turn.\n\n");
					monster.doAI();
					return;
				}
				else flags[kFLAGS.FLINTLOCK_PISTOL_AMMO]--;
			}
			//Amily!
			if (monster.findStatusEffect(StatusEffects.Concentration) >= 0 && !isWieldingRangedWeapon()) {
				outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n", true);
				monster.doAI();
				return;
			}
			if (monster.findStatusEffect(StatusEffects.Level) >= 0 && player.findStatusEffect(StatusEffects.FirstAttack) < 0 && !isWieldingRangedWeapon()) {
				outputText("It's all or nothing!  With a bellowing cry you charge down the treacherous slope and smite the sandtrap as hard as you can!  ");
				(monster as SandTrap).trapLevel(-4);
			}
			if (player.findPerk(PerkLib.DoubleAttack) >= 0 && player.spe >= 50 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] < 2) {
				if (player.findStatusEffect(StatusEffects.FirstAttack) >= 0) player.removeStatusEffect(StatusEffects.FirstAttack);
				else {
					//Always!
					if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0) player.createStatusEffect(StatusEffects.FirstAttack,0,0,0,0);
					//Alternate!
					else if (player.str < 61 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 1) player.createStatusEffect(StatusEffects.FirstAttack,0,0,0,0);
				}
			}
			//"Brawler perk". Urta only. Thanks to Fenoxo for pointing this out... Even though that should have been obvious :<
			//Urta has fists and the Brawler perk. Don't check for that because Urta can't drop her fists or lose the perk!
			else if (getGame().urtaQuest.isUrta()) {
				if (player.findStatusEffect(StatusEffects.FirstAttack) >= 0) {
					player.removeStatusEffect(StatusEffects.FirstAttack);
				}
				else {
					player.createStatusEffect(StatusEffects.FirstAttack,0,0,0,0);
					outputText("Utilizing your skills as a bareknuckle brawler, you make two attacks!\n");
				}
			}
			//Blind
			if (player.findStatusEffect(StatusEffects.Blind) >= 0) {
				outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ", false);
			}
			if (monster is Basilisk && player.findPerk(PerkLib.BasiliskResistance) < 0 && !isWieldingRangedWeapon()) {
				if (monster.findStatusEffect(StatusEffects.Blind) >= 0)
					outputText("Blind basilisk can't use his eyes, so you can actually aim your strikes!  ", false);
				//basilisk counter attack (block attack, significant speed loss): 
				else if (player.inte/5 + rand(20) < 25) {
					outputText("Holding the basilisk in your peripheral vision, you charge forward to strike it.  Before the moment of impact, the reptile shifts its posture, dodging and flowing backward skillfully with your movements, trying to make eye contact with you. You find yourself staring directly into the basilisk's face!  Quickly you snap your eyes shut and recoil backwards, swinging madly at the lizard to force it back, but the damage has been done; you can see the terrible grey eyes behind your closed lids, and you feel a great weight settle on your bones as it becomes harder to move.", false);
					Basilisk.basiliskSpeed(player,20);
					player.removeStatusEffect(StatusEffects.FirstAttack);
					combatRoundOver();
					flags[kFLAGS.BASILISK_RESISTANCE_TRACKER] += 2;
					return;
				}
				//Counter attack fails: (random chance if PC int > 50 spd > 60; PC takes small physical damage but no block or spd penalty)
				else {
					outputText("Holding the basilisk in your peripheral vision, you charge forward to strike it.  Before the moment of impact, the reptile shifts its posture, dodging and flowing backward skillfully with your movements, trying to make eye contact with you. You twist unexpectedly, bringing your " + player.weaponName + " up at an oblique angle; the basilisk doesn't anticipate this attack!  ", false);
				}
			}
			if (monster is FrostGiant && player.findStatusEffect(StatusEffects.GiantBoulder) >= 0) {
				(monster as FrostGiant).giantBoulderHit(0);
				monster.doAI();
				return;
			}
			//Worms are special
			if (monster.short == "worms") {
				//50% chance of hit (int boost)
				if (rand(100) + player.inte/3 >= 50) {
					temp = int(player.str/5 - rand(5));
					if (temp == 0) temp = 1;
					outputText("You strike at the amalgamation, crushing countless worms into goo, dealing <b><font color=\"#800000\">" + temp + "</font></b> damage.\n\n", false);
					monster.HP -= temp;
					if (monster.HP <= 0) {
						doNext(endHpVictory);
						return;
					}
				}
				//Fail
				else {
					outputText("You attempt to crush the worms with your reprisal, only to have the collective move its individual members, creating a void at the point of impact, leaving you to attack only empty air.\n\n", false);
				}
				if (player.findStatusEffect(StatusEffects.FirstAttack) >= 0) {
					attack();
					return;
				}
				monster.doAI();
				return;
			}
			
			var damage:Number = 0;
			//Determine if dodged!
			if ((player.findStatusEffect(StatusEffects.Blind) >= 0 && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe-player.spe) / 4) + 80)) > 80)) {
				//Akbal dodges special education
				if (monster.short == "Akbal") outputText("Akbal moves like lightning, weaving in and out of your furious strikes with the speed and grace befitting his jaguar body.\n", false);
				else if (monster.short == "plain girl") outputText("You wait patiently for your opponent to drop her guard. She ducks in and throws a right cross, which you roll away from before smacking your " + player.weaponName + " against her side. Astonishingly, the attack appears to phase right through her, not affecting her in the slightest. You glance down to your " + player.weaponName + " as if betrayed.\n", false);
				else if (monster.short == "kitsune") {
					//Player Miss:
					outputText("You swing your [weapon] ferociously, confident that you can strike a crushing blow.  To your surprise, you stumble awkwardly as the attack passes straight through her - a mirage!  You curse as you hear a giggle behind you, turning to face her once again.\n\n");
				}
				else {
					if (player.weapon == weapons.HNTCANE && rand(2) == 0) {
						if (rand(2) == 0) outputText("You slice through the air with your cane, completely missing your enemy.");
						else outputText("You lunge at your enemy with the cane.  It glows with a golden light but fails to actually hit anything.");
					}
					if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!", false);
					if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!", false);
					if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.", false);
					outputText("\n", false);
					if (player.findStatusEffect(StatusEffects.FirstAttack) >= 0) {
						attack();
						return;
					}
					else outputText("\n", false);
				}
				monster.doAI();
				return;
			}
			//BLOCKED ATTACK:
			if (monster.findStatusEffect(StatusEffects.Earthshield) >= 0 && rand(4) == 0) {
				outputText("Your strike is deflected by the wall of sand, dirt, and rock!  Damn!\n");
				if (player.findStatusEffect(StatusEffects.FirstAttack) >= 0) {
					attack();
					return;
				}
				else outputText("\n", false);
				monster.doAI();
				return;
			}
			//------------
			// DAMAGE
			//------------
			//Determine damage
			//BASIC DAMAGE STUFF
			
			//Double Attack Hybrid Reductions
			var getBase:Function = function(init:Number):Number {
				if (player.findPerk(PerkLib.DoubleAttack) >= 0 && player.spe >= 50 && init > 61 + (player.newGamePlusMod() * 15) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0) {
					return 60.5 + (player.newGamePlusMod() * 15);
				} else return init;
			};
			
			// init value depending on weapon type
			if (isWieldingRangedWeapon()) {
				if (player.weaponName.indexOf("staff") != -1) damage = getBase.call(null, player.inte) + player.spe * 0.1;
				else damage = getBase.call(null, player.str) + player.spe * 0.2; // woudn't be better to use speed as base and int as extra?
			}
			else
				damage = getBase.call(null, player.str);
				
			if (player.findPerk(PerkLib.HoldWithBothHands) >= 0 && player.weapon != WeaponLib.FISTS && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) damage += (player.str * 0.2);
			//Weapon addition!
			damage += player.weaponAttack;
			if (damage < 10) damage = 10;
			//Bonus sand trap damage!
			if (monster.findStatusEffect(StatusEffects.Level) >= 0) damage = Math.round(damage * 1.75);
			//Determine if critical hit!
			var crit:Boolean = false;
			var critChance:int = 5;
			if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) critChance += (player.inte - 50) / 5;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			//Apply AND DONE!
			damage *= (monster.damagePercent(false, true) / 100);
			//Damage post processing!
			//Thunderous Strikes
			if (player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80)
				damage *= 1.2;
				
			if (player.findPerk(PerkLib.ChiReflowMagic) >= 0) damage *= UmasShop.NEEDLEWORK_MAGIC_REGULAR_MULTI;
			if (player.findPerk(PerkLib.ChiReflowAttack) >= 0) damage *= UmasShop.NEEDLEWORK_ATTACK_REGULAR_MULTI;
			if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
			if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
			//One final round
			damage = Math.round(damage);
			
			//ANEMONE SHIT
			if (monster.short == "anemone" && !isWieldingRangedWeapon()) {
				//hit successful:
				//special event, block (no more than 10-20% of turns, also fails if PC has >75 corruption):
				if (rand(10) <= 1) {
					outputText("Seeing your " + player.weaponName + " raised, the anemone looks down at the water, angles her eyes up at you, and puts out a trembling lip.  ", false);
					if (player.cor < 75) {
						outputText("You stare into her hangdog expression and lose most of the killing intensity you had summoned up for your attack, stopping a few feet short of hitting her.\n", false);
						damage = 0;
						//Kick back to main if no damage occured!
						if (monster.HP > 0 && monster.lust < monster.eMaxLust()) {
							if (player.findStatusEffect(StatusEffects.FirstAttack) >= 0) {
								attack();
								return;
							}
							monster.doAI();
						}
						else {
							if (monster.HP <= 0) doNext(endHpVictory);
							else doNext(endLustVictory);
						}
						return;
					}
					else outputText("Though you lose a bit of steam to the display, the drive for dominance still motivates you to follow through on your swing.", false);
				}
			}

			// Have to put it before doDamage, because doDamage applies the change, as well as status effects and shit.
			if (monster is Doppleganger)
			{
				if (monster.findStatusEffect(StatusEffects.Stunned) < 0)
				{
					if (damage > 0 && player.findPerk(PerkLib.HistoryFighter) >= 0) damage *= 1.1;
					if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
					if (damage > 0) damage = doDamage(damage, false);
				
					(monster as Doppleganger).mirrorAttack(damage);
					return;
				}
				
				// Stunning the doppleganger should now "buy" you another round.
			}
			if (player.weapon == weapons.HNTCANE) {
				switch(rand(2)) {
					case 0:
						outputText("You swing your cane through the air. The light wood lands with a loud CRACK that is probably more noisy than painful. ");
						damage *= 0.5;
						break;
					case 1:
						outputText("You brandish your cane like a sword, slicing it through the air. It thumps against your adversary, but doesn’t really seem to harm them much. ");
						damage *= 0.5;
						break;
					default:
				}
			}
			if (damage > 0) {
				if (player.findPerk(PerkLib.HistoryFighter) >= 0) damage *= 1.1;
				damage = doDamage(damage);
			}
			if (damage <= 0) {
				damage = 0;
				outputText("Your attacks are deflected or blocked by " + monster.a + monster.short + ".", false);
			}
			else {
				outputText("You hit " + monster.a + monster.short + "! ", false);
				if (crit) outputText("<b>Critical hit! </b>");
				outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>", false)
			}
			if (player.findPerk(PerkLib.BrutalBlows) >= 0 && player.str > 75) {
				if (monster.armorDef > 0) outputText("\nYour hits are so brutal that you damage " + monster.a + monster.short + "'s defenses!");
				if (monster.armorDef - 10 > 0) monster.armorDef -= 10;
				else monster.armorDef = 0;
			}
			//Damage cane.
			if (player.weapon == weapons.HNTCANE) {
				flags[kFLAGS.ERLKING_CANE_ATTACK_COUNTER]++;
				//Break cane
				if (flags[kFLAGS.ERLKING_CANE_ATTACK_COUNTER] >= 10 && rand(20) == 0) {
					outputText("\n<b>The cane you're wielding finally snaps! It looks like you won't be able to use it anymore.</b>");
					player.setWeapon(WeaponLib.FISTS);
				}
			}
			if (damage > 0) {
				//Lust raised by anemone contact!
				if (monster.short == "anemone" && !isWieldingRangedWeapon()) {
					outputText("\nThough you managed to hit the anemone, several of the tentacles surrounding her body sent home jolts of venom when your swing brushed past them.", false);
					//(gain lust, temp lose str/spd)
					(monster as Anemone).applyVenom((1+rand(2)));
				}
				
				//Lust raising weapon bonuses
				if (monster.lustVuln > 0) {
					if (player.weaponPerk == "Aphrodisiac Weapon") {
						outputText("\n" + monster.capitalA + monster.short + " shivers as your weapon's 'poison' goes to work.", false);
						monster.teased(monster.lustVuln * (5 + player.cor / 10));
					}
					if (player.weaponName == "coiled whip" && rand(2) == 0) {		
						if (!monster.plural) outputText("\n" + monster.capitalA + monster.short + " shivers and gets turned on from the whipping.", false);
						else outputText("\n" + monster.capitalA + monster.short + " shiver and get turned on from the whipping.", false);
						monster.teased(monster.lustVuln * (5 + player.cor / 12));
					}
					if (player.weapon == weapons.SUCWHIP) {
						if (player.cor < 60) dynStats("cor", .1);
						if (player.cor < 90) dynStats("cor", .05);
						if (!monster.plural) outputText("\n" + monster.capitalA + monster.short + " shivers and moans involuntarily from the whip's touches.", false);
						else outputText("\n" + monster.capitalA + monster.short + " shiver and moan involuntarily from the whip's touches.", false);
						monster.teased(monster.lustVuln * (20 + player.cor / 15));
						if (rand(2) == 0) {
							outputText(" You get a sexual thrill from it. ", false);
							dynStats("lus", 1);
						}
						
					}
					if (player.weapon == weapons.L_WHIP) {
						if (player.cor < 60) dynStats("cor", .1);
						if (player.cor < 90) dynStats("cor", .05);
						if (!monster.plural) outputText("\n" + monster.capitalA + monster.short + " shivers and moans involuntarily from the flaming whip's touches.", false);
						else outputText("\n" + monster.capitalA + monster.short + " shiver and moan involuntarily from the flaming whip's touches.", false);
						monster.teased(monster.lustVuln * (25 + player.cor / 10));
						if (rand(2) == 0) {
							outputText(" You get a sexual thrill from it. ", false);
							dynStats("lus", 1);
						}
					}
				}
				//Weapon Procs!
				if (player.weaponName == "huge warhammer" || player.weaponName == "spiked gauntlet" || player.weaponName == "hooked gauntlets") {
					//10% chance
					if (rand(10) == 0 && monster.findPerk(PerkLib.Resolute) < 0) {
						outputText("\n" + monster.capitalA + monster.short + " reels from the brutal blow, stunned.", false);
						if (monster.findStatusEffect(StatusEffects.Stunned) < 0) monster.createStatusEffect(StatusEffects.Stunned,rand(2),0,0,0);
					}
					//50% Bleed chance
					if (player.weaponName == "hooked gauntlets" && rand(2) == 0 && monster.armorDef < 10 && monster.findStatusEffect(StatusEffects.IzmaBleed) < 0) 
					{
						if (monster is LivingStatue)
						{
							outputText("Despite the rents you've torn in its stony exterior, the statue does not bleed.");
						}
						else
						{
							monster.createStatusEffect(StatusEffects.IzmaBleed,3,0,0,0);
							if (monster.plural) outputText("\n" + monster.capitalA + monster.short + " bleed profusely from the many bloody gashes your hooked gauntlets leave behind.", false);
							else outputText("\n" + monster.capitalA + monster.short + " bleeds profusely from the many bloody gashes your hooked gauntlets leave behind.", false);
						}
					}
				}
				
			}
			
			if (monster is JeanClaude && player.findStatusEffect(StatusEffects.FirstAttack) < 0)
			{
				if (monster.HP < 1 || monster.lust >= monster.eMaxLust())
				{
					// noop
				}
				if (player.lust <= 30)
				{
					outputText("\n\nJean-Claude doesn’t even budge when you wade into him with your [weapon].");

					outputText("\n\n“<i>Why are you attacking me, slave?</i>” he says. The basilisk rex sounds genuinely confused. His eyes pulse with hot, yellow light, reaching into you as he opens his arms, staring around as if begging the crowd for an explanation. “<i>You seem lost, unable to understand, lashing out at those who take care of you. Don’t you know who you are? Where you are?</i>” That compulsion in his eyes, that never-ending heat, it’s... it’s changing things. You need to finish this as fast as you can.");
				}
				else if (player.lust <= 50)
				{
					outputText("\n\nAgain your [weapon] thumps into Jean-Claude. Again it feels wrong. Again it sends an aching chime through you, that you are doing something that revolts your nature.");

					outputText("\n\n“<i>Why are you fighting your master, slave?</i>” he says. He is bigger than he was before. Or maybe you are smaller. “<i>You are confused. Put your weapon down- you are no warrior, you only hurt yourself when you flail around with it. You have forgotten what you were trained to be. Put it down, and let me help you.</i>” He’s right. It does hurt. Your body murmurs that it would feel so much better to open up and bask in the golden eyes fully, let it move you and penetrate you as it may. You grit your teeth and grip your [weapon] harder, but you can’t stop the warmth the hypnotic compulsion is building within you.");
				}
				else if (player.lust <= 80)
				{
					outputText("\n\n“<i>Do you think I will be angry at you?</i>” growls Jean-Claude lowly. Your senses feel intensified, his wild, musky scent rich in your nose. It’s hard to concentrate... or rather it’s hard not to concentrate on the sweat which runs down his hard, defined frame, the thickness of his bulging cocks, the assured movement of his powerful legs and tail, and the glow, that tantalizing, golden glow, which pulls you in and pushes so much delicious thought and sensation into your head…  “<i>I am not angry. You will have to be punished, yes, but you know that is only right, that in the end you will accept and enjoy being corrected. Come now, slave. You only increase the size of the punishment with this silliness.</i>”");
				}
				else
				{
					outputText("\n\nYou can’t... there is a reason why you keep raising your weapon against your master, but what was it? It can’t be that you think you can defeat such a powerful, godly alpha male as him. And it would feel so much better to supplicate yourself before the glow, lose yourself in it forever, serve it with your horny slut body, the only thing someone as low and helpless as you could possibly offer him. Master’s mouth is moving but you can no longer tell where his voice ends and the one in your head begins... only there is a reason you cling to like you cling onto your [weapon], whatever it is, however stupid and distant it now seems, a reason to keep fighting...");
				}
				
				dynStats("lus", 25);
			}
			
			outputText("\n", false);
			if (isWieldingRangedWeapon()) flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
			if (player.weaponName.indexOf("staff") != -1 && player.findPerk(PerkLib.StaffChanneling) >= 0) flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
			checkAchievementDamage(damage);
			//Kick back to main if no damage occured!
			if (monster.HP >= 1 && monster.lust < monster.eMaxLust()) {
				if (player.findStatusEffect(StatusEffects.FirstAttack) >= 0) {
					attack();
					return;
				}
				outputText("\n", false);
				monster.doAI();
			}
			else {
				if (monster.HP <= 0) doNext(endHpVictory);
				else doNext(endLustVictory);
			}
		}
		
		public function combatMiss():Boolean {
			return player.spe - monster.spe > 0 && int(Math.random() * (((player.spe - monster.spe) / 4) + 80)) > 80;
		}
		public function combatParry():Boolean {
			return player.findPerk(PerkLib.Parry) >= 0 && player.spe >= 50 && player.str >= 50 && rand(100) < ((player.spe - 50) / 5) && player.weapon != WeaponLib.FISTS;
			trace("Parried!");
		}
		public function combatCritical():Boolean {
			var critChance:int = 4;
			if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) critChance += (player.inte - 50) / 10;
			if (player.findPerk(PerkLib.Blademaster) >= 0 && (player.weaponVerb == "slash" || player.weaponVerb == "cleave" || player.weaponVerb == "keen cut")) critChance += 5;
			if (player.jewelry.effectId == JewelryLib.MODIFIER_CRITICAL) critChance += player.jewelry.effectMagnitude;
			return rand(100) <= critChance;
		}

		public function combatBlock(doFatigue:Boolean = false):Boolean {
			//Set chance
			var blockChance:int = 20 + player.shieldBlock + Math.floor((player.str - monster.str) / 5);
			if (player.findPerk(PerkLib.ShieldMastery) >= 0 && player.tou >= 50) blockChance += (player.tou - 50) / 5;
			if (blockChance < 10) blockChance = 10;
			//Fatigue limit
			var fatigueLimit:int = player.maxFatigue() - player.physicalCost(10);;
			if (blockChance >= (rand(100) + 1) && player.fatigue <= fatigueLimit && player.shieldName != "nothing") {
				if (doFatigue) player.changeFatigue(10, 2);
				return true;
			}
			else return false;
		}
		public function isWieldingRangedWeapon():Boolean {
			if (player.weaponName == "flintlock pistol" || player.weaponName == "crossbow" || player.weaponName == "blunderbuss rifle" || (player.weaponName.indexOf("staff") != -1 && player.findPerk(PerkLib.StaffChanneling) >= 0)) return true;
			else return false;
		}

		/**
		 * Deal damage to opponent.
		 * @param	damage	The amount of damage dealt.
		 * @param	apply	If true, deducts HP from monster.
		 * @param	display	If true, displays the damage done.
		 * @return	damage	The amount of damage.
		 */
		public function doDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
			if (player.findPerk(PerkLib.Sadist) >= 0) {
				damage *= 1.2;
				dynStats("lus", 3);
			}
			if (monster.HP - damage <= 0) {
				/* No monsters use this perk, so it's been removed for now
				if (monster.findPerk(PerkLib.LastStrike) >= 0) doNext(monster.perk(monster.findPerk(PerkLib.LastStrike)).value1);
				else doNext(endHpVictory);
				*/
				doNext(endHpVictory);
			}
			
			// Uma's Massage Bonuses
			var statIndex:int = player.findStatusEffect(StatusEffects.UmasMassage);
			if (statIndex >= 0)
			{
				if (player.statusEffect(statIndex).value1 == UmasShop.MASSAGE_POWER)
				{
					damage *= player.statusEffect(statIndex).value2;
				}
			}
			
			damage = Math.round(damage);
			
			if (damage < 0) damage = 1;
			if (apply) monster.HP -= damage;
			if (display) output.text(getDamageText(damage));
			//Isabella gets mad
			if (monster.short == "Isabella") {
				flags[kFLAGS.ISABELLA_AFFECTION]--;
				//Keep in bounds
				if (flags[kFLAGS.ISABELLA_AFFECTION] < 0) flags[kFLAGS.ISABELLA_AFFECTION] = 0;
			}
			//Interrupt gigaflare if necessary.
			if (monster.findStatusEffect(StatusEffects.Gigafire) >= 0) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
			//Keep shit in bounds.
			if (monster.HP < 0) monster.HP = 0;
			return damage;
		}

		public function takeDamage(damage:Number, display:Boolean = false):Number {
			return player.takeDamage(damage, display);
		}

		public function getDamageText(damage:Number):String
		{
			var color:String;
			if (damage > 0)  color = "#800000";
			if (damage == 0) color = "#000080";
			if (damage < 0)  color = "#008000";
			return "<b>(<font color=\"" + color + "\">" + damage + "</font>)</b>";
		}

		public function finishCombat():void
		{
			var hpVictory:Boolean = monster.HP < 1;
			if (hpVictory) {
				outputText("You defeat " + monster.a + monster.short + ".\n", true);
			} else {
				outputText("You smile as " + monster.a + monster.short + " collapses and begins masturbating feverishly.", true);
			}
			cleanupAfterCombat();
		}
		public function dropItem(monster:Monster, nextFunc:Function = null):void {
			if (nextFunc == null) nextFunc = camp.returnToCampUseOneHour;
			if (monster.findStatusEffect(StatusEffects.NoLoot) >= 0) {
				return;
			}
			var itype:ItemType = monster.dropLoot();
			if (monster.short == "tit-fucked Minotaur") {
				itype = consumables.MINOCUM;
			}
			if (monster is Minotaur) {
				if (monster.weaponName == "axe") {
					if (rand(2) == 0) {
						//50% breakage!
						if (rand(2) == 0) {
							itype = weapons.L__AXE;
							if (player.tallness < 78 && player.str < 90) {
								outputText("\nYou find a large axe on the minotaur, but it is too big for a person of your stature to comfortably carry.  ", false);
								if (rand(2) == 0) itype = null;
								else itype = consumables.SDELITE;
							}
							//Not too tall, dont rob of axe!
							else plotFight = true;
						}
						else outputText("\nThe minotaur's axe appears to have been broken during the fight, rendering it useless.  ", false);
					}
					else itype = consumables.MINOBLO;
				}
			}
			if (monster is BeeGirl) {
				//force honey drop if milked
				if (flags[kFLAGS.FORCE_BEE_TO_PRODUCE_HONEY] == 1) {
					if (rand(2) == 0) itype = consumables.BEEHONY;
					else itype = consumables.PURHONY;
					flags[kFLAGS.FORCE_BEE_TO_PRODUCE_HONEY] = 0;
				}
			}
			if (monster is Jojo && flags[kFLAGS.JOJO_STATUS] > 4) {
				if (rand(2) == 0) itype = consumables.INCUBID;
				else {
					if (rand(2) == 0) itype = consumables.B__BOOK;
					else itype = consumables.SUCMILK;
				}
			}
			if (monster is Harpy || monster is Sophie) {
				if (rand(10) == 0) itype = armors.W_ROBES;
				else if (rand(3) == 0 && player.findPerk(PerkLib.LuststickAdapted) >= 0) itype = consumables.LUSTSTK;
				else itype = consumables.GLDSEED;
			}
			//Chance of armor if at level 1 pierce fetish
			if (!plotFight && !(monster is Ember) && !(monster is Kiha) && !(monster is Hel) && !(monster is Isabella)
					&& flags[kFLAGS.PC_FETISH] == 1 && rand(10) == 0 && !player.hasItem(armors.SEDUCTA, 1) && !getGame().ceraphFollowerScene.ceraphIsFollower()) {
				itype = armors.SEDUCTA;
			}

			if (!plotFight && rand(200) == 0 && player.level >= 7) itype = consumables.BROBREW;
			if (!plotFight && rand(200) == 0 && player.level >= 7) itype = consumables.BIMBOLQ;
			if (!plotFight && rand(1000) == 0 && player.level >= 7) itype = consumables.RAINDYE;
			//Chance of eggs if Easter!
			if (!plotFight && rand(6) == 0 && getGame().plains.bunnyGirl.isItEaster()) {
				temp = rand(13);
				if (temp == 0) itype =consumables.BROWNEG;
				if (temp == 1) itype =consumables.L_BRNEG;
				if (temp == 2) itype =consumables.PURPLEG;
				if (temp == 3) itype =consumables.L_PRPEG;
				if (temp == 4) itype =consumables.BLUEEGG;
				if (temp == 5) itype =consumables.L_BLUEG;
				if (temp == 6) itype =consumables.PINKEGG;
				if (temp == 7) itype =consumables.NPNKEGG;
				if (temp == 8) itype =consumables.L_PNKEG;
				if (temp == 9) itype =consumables.L_WHTEG;
				if (temp == 10) itype =consumables.WHITEEG;
				if (temp == 11) itype =consumables.BLACKEG;
				if (temp == 12) itype = consumables.L_BLKEG;
				flags[kFLAGS.ACHIEVEMENT_PROGRESS_EGG_HUNTER]++;
			}
			//Ring drops!
			if (!plotFight && rand(200) <= 0 + Math.min(6, Math.floor(monster.level / 10))) { //Ring drops!
				var ringDropTable:Array = [];
				ringDropTable.push(jewelries.SILVRNG);
				if (monster.level < 10) ringDropTable.push(jewelries.SILVRNG);
				if (monster.level < 15 && rand(2) == 0) ringDropTable.push(jewelries.SILVRNG);
				ringDropTable.push(jewelries.GOLDRNG);
				if (monster.level < 20) ringDropTable.push(jewelries.GOLDRNG);
				ringDropTable.push(jewelries.PLATRNG);
				if (rand(2) == 0) ringDropTable.push(jewelries.DIAMRNG);
				if (monster.level >= 15 && rand(4) == 0) ringDropTable.push(jewelries.LTHCRNG);
				if (monster.level >= 25 && rand(3) == 0) ringDropTable.push(jewelries.LTHCRNG);
				if (monster.level >= 1 && monster.level < 15) {
					ringDropTable.push(jewelries.CRIMRN1);
					ringDropTable.push(jewelries.FERTRN1);
					ringDropTable.push(jewelries.ICE_RN1);
					ringDropTable.push(jewelries.CRITRN1);
					ringDropTable.push(jewelries.REGNRN1);
					ringDropTable.push(jewelries.LIFERN1);
					ringDropTable.push(jewelries.MYSTRN1);
					ringDropTable.push(jewelries.POWRRN1);
				}
				if (monster.level >= 11 && monster.level < 25) {
					ringDropTable.push(jewelries.CRIMRN2);
					ringDropTable.push(jewelries.FERTRN2);
					ringDropTable.push(jewelries.ICE_RN2);
					ringDropTable.push(jewelries.CRITRN2);
					ringDropTable.push(jewelries.REGNRN2);
					ringDropTable.push(jewelries.LIFERN2);
					ringDropTable.push(jewelries.MYSTRN2);
					ringDropTable.push(jewelries.POWRRN2);
				}
				if (monster.level >= 21) {
					ringDropTable.push(jewelries.CRIMRN3);
					ringDropTable.push(jewelries.FERTRN3);
					ringDropTable.push(jewelries.ICE_RN3);
					ringDropTable.push(jewelries.CRITRN3);
					ringDropTable.push(jewelries.REGNRN3);
					ringDropTable.push(jewelries.LIFERN3);
					ringDropTable.push(jewelries.MYSTRN3);
					ringDropTable.push(jewelries.POWRRN3);
				}
				

			}
			//Bonus loot overrides others
			if (flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] != "") {
				itype = ItemType.lookupItem(flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID]);
			}
			monster.handleAwardItemText(itype); //Each monster can now override the default award text
			if (itype != null) {
				if (inDungeon)
					inventory.takeItem(itype, playerMenu);
				else inventory.takeItem(itype, nextFunc);
			}
		}
		public function awardPlayer(nextFunc:Function = null):void
		{
			if (nextFunc == null) nextFunc = camp.returnToCampUseOneHour; //Default to returning to camp.
			if (player.countCockSocks("gilded") > 0) {
				//trace( "awardPlayer found MidasCock. Gems bumped from: " + monster.gems );
				
				var bonusGems:int = monster.gems * 0.15 + 5 * player.countCockSocks("gilded"); // int so AS rounds to whole numbers
				monster.gems += bonusGems;
				//trace( "to: " + monster.gems )
			}
			if (player.findPerk(PerkLib.HistoryFortune) >= 0) {
				var bonusGems2:int = monster.gems * 0.15;
				monster.gems += bonusGems2;
			}
			if (player.findPerk(PerkLib.HistoryWhore) >= 0) {
				var bonusGems3:int = (monster.gems * 0.04) * player.teaseLevel;
				if (monster.lust >= monster.eMaxLust()) monster.gems += bonusGems3;
			}
			if (player.findPerk(PerkLib.AscensionFortune) >= 0) {
				monster.gems *= 1 + (player.perkv1(PerkLib.AscensionFortune) * 0.1);
				monster.gems = Math.round(monster.gems);
			}
			monster.handleAwardText(); //Each monster can now override the default award text
			if (!inDungeon && !inRoomedDungeon && !prison.inPrison) { //Not in dungeons
				if (nextFunc != null) doNext(nextFunc);
				else doNext(playerMenu);
			}
			else {
				if (nextFunc != null) doNext(nextFunc);
				else doNext(playerMenu);
			}
			dropItem(monster, nextFunc);
			inCombat = false;
			player.gems += monster.gems;
			player.XP += monster.XP;
			mainView.statsView.showStatUp('xp');
			dynStats("lust", 0, "resisted", false); //Forces up arrow.
		}

		//Clear statuses
		public function clearStatuses(visibility:Boolean):void {
			player.clearStatuses(visibility);
		}
		//Update combat status effects
		private function combatStatusesUpdate():void {
			//old outfit used for fetish cultists
			var oldOutfit:String = "";
			var changed:Boolean = false;
			//Reset menuloc
		//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
			hideUpDown();
			if (player.findStatusEffect(StatusEffects.Sealed) >= 0) {
				//Countdown and remove as necessary
				if (player.statusEffectv1(StatusEffects.Sealed) > 0) {
					player.addStatusValue(StatusEffects.Sealed,1,-1);
					if (player.statusEffectv1(StatusEffects.Sealed) <= 0) player.removeStatusEffect(StatusEffects.Sealed);
					else outputText("<b>One of your combat abilities is currently sealed by magic!</b>\n\n");
				}
			}
			monster.combatRoundUpdate();
			//[Silence warning]
			if (player.findStatusEffect(StatusEffects.ThroatPunch) >= 0) {
				player.addStatusValue(StatusEffects.ThroatPunch,1,-1);
				if (player.statusEffectv1(StatusEffects.ThroatPunch) >= 0) outputText("Thanks to Isabella's wind-pipe crushing hit, you're having trouble breathing and are <b>unable to cast spells as a consequence.</b>\n\n", false);
				else {
					outputText("Your wind-pipe recovers from Isabella's brutal hit.  You'll be able to focus to cast spells again!\n\n", false);
					player.removeStatusEffect(StatusEffects.ThroatPunch);
				}
			}
			if (player.findStatusEffect(StatusEffects.GooArmorSilence) >= 0) {
				if (player.statusEffectv1(StatusEffects.GooArmorSilence) >= 2 || rand(20) + 1 + player.str/10 >= 15) {
					//if passing str check, output at beginning of turn
					outputText("<b>The sticky slop covering your mouth pulls away reluctantly, taking more force than you would expect, but you've managed to free your mouth enough to speak!</b>\n\n");
					player.removeStatusEffect(StatusEffects.GooArmorSilence);
				}
				else {
					outputText("<b>Your mouth is obstructed by sticky goo!  You are silenced!</b>\n\n", false);
					player.addStatusValue(StatusEffects.GooArmorSilence,1,1);
				}
			}
			if (player.findStatusEffect(StatusEffects.LustStones) >= 0) {
				//[When witches activate the stones for goo bodies]
				if (player.isGoo()) {
					outputText("<b>The stones start vibrating again, making your liquid body ripple with pleasure.  The witches snicker at the odd sight you are right now.\n\n</b>");
				}
				//[When witches activate the stones for solid bodies]
				else {
					outputText("<b>The smooth stones start vibrating again, sending another wave of teasing bliss throughout your body.  The witches snicker at you as you try to withstand their attack.\n\n</b>");
				}
				dynStats("lus", player.statusEffectv1(StatusEffects.LustStones) + 4);
			}
			if (player.findStatusEffect(StatusEffects.WebSilence) >= 0) {
				if (player.statusEffectv1(StatusEffects.WebSilence) >= 2 || rand(20) + 1 + player.str/10 >= 15) {
					outputText("You rip off the webbing that covers your mouth with a cry of pain, finally able to breathe normally again!  Now you can cast spells!\n\n", false);
					player.removeStatusEffect(StatusEffects.WebSilence);
				}
				else {
					outputText("<b>Your mouth and nose are obstructed by sticky webbing, making it difficult to breathe and impossible to focus on casting spells.  You try to pull it off, but it just won't work!</b>\n\n", false);
					player.addStatusValue(StatusEffects.WebSilence,1,1);
				}
			}		
			if (player.findStatusEffect(StatusEffects.HolliConstrict) >= 0) {
				outputText("<b>You're tangled up in Holli's verdant limbs!  All you can do is try to struggle free...</b>\n\n");
			}
			if (player.findStatusEffect(StatusEffects.UBERWEB) >= 0)
				outputText("<b>You're pinned under a pile of webbing!  You should probably struggle out of it and get back in the fight!</b>\n\n", false);
			if (player.findStatusEffect(StatusEffects.Blind) >= 0 && monster.findStatusEffect(StatusEffects.Sandstorm) < 0) 
			{
				if (player.findStatusEffect(StatusEffects.SheilaOil) >= 0) 
				{
					if (player.statusEffectv1(StatusEffects.Blind) <= 0) {
						outputText("<b>You finish wiping the demon's tainted oils away from your eyes; though the smell lingers, you can at least see.  Sheila actually seems happy to once again be under your gaze.</b>\n\n", false);
						player.removeStatusEffect(StatusEffects.Blind);
					}
					else {
						outputText("<b>You scrub at the oily secretion with the back of your hand and wipe some of it away, but only smear the remainder out more thinly.  You can hear the demon giggling at your discomfort.</b>\n\n", false);
						player.addStatusValue(StatusEffects.Blind,1,-1);
					}
				}
				else 
				{
					//Remove blind if countdown to 0
					if (player.statusEffectv1(StatusEffects.Blind) == 0) 
					{
						player.removeStatusEffect(StatusEffects.Blind);
						//Alert PC that blind is gone if no more stacks are there.
						if (player.findStatusEffect(StatusEffects.Blind) < 0) 
						{
							outputText("<b>Your eyes have cleared and you are no longer blind!</b>\n\n", false);
						}
						else outputText("<b>You are blind, and many physical attacks will miss much more often.</b>\n\n", false);
					}
					else 
					{
						player.addStatusValue(StatusEffects.Blind,1,-1);
						outputText("<b>You are blind, and many physical attacks will miss much more often.</b>\n\n", false);
					}
				}
			}
			//Basilisk compulsion
			if (player.findStatusEffect(StatusEffects.BasiliskCompulsion) >= 0) {
				Basilisk.basiliskSpeed(player,15);
				//Continuing effect text: 
				outputText("<b>You still feel the spell of those grey eyes, making your movements slow and difficult, the remembered words tempting you to look into its eyes again. You need to finish this fight as fast as your heavy limbs will allow.</b>\n\n", false);
				flags[kFLAGS.BASILISK_RESISTANCE_TRACKER]++;
			}
			if (player.findStatusEffect(StatusEffects.IzmaBleed) >= 0) {
				if (player.statusEffectv1(StatusEffects.IzmaBleed) <= 0) {
					player.removeStatusEffect(StatusEffects.IzmaBleed);
					outputText("<b>You sigh with relief; your bleeding has slowed considerably.</b>\n\n", false);
				}
				//Bleed effect:
				else {
					var bleed:Number = (2 + rand(4))/100;
					bleed *= player.HP;
					bleed = takeDamage(bleed);
					outputText("<b>You gasp and wince in pain, feeling fresh blood pump from your wounds. (<font color=\"#800000\">" + temp + "</font>)</b>\n\n", false);
				}
			}
			if (player.findStatusEffect(StatusEffects.AcidSlap) >= 0) {
				var slap:Number = 3 + (player.maxHP() * 0.02);
				outputText("<b>Your muscles twitch in agony as the acid keeps burning you. <b>(<font color=\"#800000\">" + slap + "</font>)</b></b>\n\n", false);
			}
			if (player.findPerk(PerkLib.ArousingAura) >= 0 && monster.lustVuln > 0 && player.cor >= 70) {
				if (monster.lust < 50) outputText("Your aura seeps into " + monster.a + monster.short + " but does not have any visible effects just yet.\n\n", false);
				else if (monster.lust < 60) {
					if (!monster.plural) outputText(monster.capitalA + monster.short + " starts to squirm a little from your unholy presence.\n\n", false);
					else outputText(monster.capitalA + monster.short + " start to squirm a little from your unholy presence.\n\n", false);
				}
				else if (monster.lust < 75) outputText("Your arousing aura seems to be visibly affecting " + monster.a + monster.short + ", making " + monster.pronoun2 + " squirm uncomfortably.\n\n", false);
				else if (monster.lust < 85) {
					if (!monster.plural) outputText(monster.capitalA + monster.short + "'s skin colors red as " + monster.pronoun1 + " inadvertently basks in your presence.\n\n", false);
					else outputText(monster.capitalA + monster.short + "' skin colors red as " + monster.pronoun1 + " inadvertently bask in your presence.\n\n", false);
				}
				else {
					if (!monster.plural) outputText("The effects of your aura are quite pronounced on " + monster.a + monster.short + " as " + monster.pronoun1 + " begins to shake and steal glances at your body.\n\n", false);
					else outputText("The effects of your aura are quite pronounced on " + monster.a + monster.short + " as " + monster.pronoun1 + " begin to shake and steal glances at your body.\n\n", false);
				}
				monster.lust += monster.lustVuln * (2 + rand(4));
			}
			if (player.findStatusEffect(StatusEffects.Bound) >= 0 && flags[kFLAGS.PC_FETISH] >= 2) {
				outputText("The feel of tight leather completely immobilizing you turns you on more and more.  Would it be so bad to just wait and let her play with you like this?\n\n", false);
				dynStats("lus", 3);
			}
			if (player.findStatusEffect(StatusEffects.GooArmorBind) >= 0) {
				if (flags[kFLAGS.PC_FETISH] >= 2) {
					outputText("The feel of the all-encapsulating goo immobilizing your helpless body turns you on more and more.  Maybe you should just wait for it to completely immobilize you and have you at its mercy.\n\n");
					dynStats("lus", 3);
				}
				else outputText("You're utterly immobilized by the goo flowing around you.  You'll have to struggle free!\n\n");
			}
			if (player.findStatusEffect(StatusEffects.HarpyBind) >= 0) {
				if (flags[kFLAGS.PC_FETISH] >= 2) {
					outputText("The harpies are holding you down and restraining you, making the struggle all the sweeter!\n\n");
					dynStats("lus", 3);
				}
				else outputText("You're restrained by the harpies so that they can beat on you with impunity.  You'll need to struggle to break free!\n\n");
			}
			if (player.findStatusEffect(StatusEffects.NagaBind) >= 0 && flags[kFLAGS.PC_FETISH] >= 2) {
				outputText("Coiled tightly by the naga and utterly immobilized, you can't help but become aroused thanks to your bondage fetish.\n\n", false);
				dynStats("lus", 5);
			}
			if (player.findStatusEffect(StatusEffects.TentacleBind) >= 0) {
				outputText("You are firmly trapped in the tentacle's coils.  <b>The only thing you can try to do is struggle free!</b>\n\n", false);
				if (flags[kFLAGS.PC_FETISH] >= 2) {
					outputText("Wrapped tightly in the tentacles, you find it hard to resist becoming more and more aroused...\n\n", false);
					dynStats("lus", 3);
				}
			}
			if (player.findStatusEffect(StatusEffects.DriderKiss) >= 0) {
				//(VENOM OVER TIME: WEAK)
				if (player.statusEffectv1(StatusEffects.DriderKiss) == 0) {
					outputText("Your heart hammers a little faster as a vision of the drider's nude, exotic body on top of you assails you.  It'll only get worse if she kisses you again...\n\n", false);
					dynStats("lus", 8);
				}
				//(VENOM OVER TIME: MEDIUM)
				else if (player.statusEffectv1(StatusEffects.DriderKiss) == 1) {
					outputText("You shudder and moan, nearly touching yourself as your ", false);
					if (player.gender > 0) outputText("loins tingle and leak, hungry for the drider's every touch.", false);
					else outputText("asshole tingles and twitches, aching to be penetrated.", false);
					outputText("  Gods, her venom is getting you so hot.  You've got to end this quickly!\n\n", false);
					dynStats("lus", 15);
				}
				//(VENOM OVER TIME: MAX)
				else {
					outputText("You have to keep pulling your hands away from your crotch - it's too tempting to masturbate here on the spot and beg the drider for more of her sloppy kisses.  Every second that passes, your arousal grows higher.  If you don't end this fast, you don't think you'll be able to resist much longer.  You're too turned on... too horny... too weak-willed to resist much longer...\n\n", false);
					dynStats("lus", 25);
				}
			}
			//Harpy lip gloss
			if (player.hasCock() && player.findStatusEffect(StatusEffects.Luststick) >= 0 && (monster.short == "harpy" || monster.short == "Sophie")) {
				//Chance to cleanse!
				if (player.findPerk(PerkLib.Medicine) >= 0 && rand(100) <= 14) {
					outputText("You manage to cleanse the harpy lip-gloss from your system with your knowledge of medicine!\n\n", false);
					player.removeStatusEffect(StatusEffects.Luststick);
				}		
				else if (rand(5) == 0) {
					if (rand(2) == 0) outputText("A fantasy springs up from nowhere, dominating your thoughts for a few moments.  In it, you're lying down in a soft nest.  Gold-rimmed lips are noisily slurping around your " + player.cockDescript(0) + ", smearing it with her messy aphrodisiac until you're completely coated in it.  She looks up at you knowingly as the two of you get ready to breed the night away...\n\n", false);		
					else outputText("An idle daydream flutters into your mind.  In it, you're fucking a harpy's asshole, clutching tightly to her wide, feathery flanks as the tight ring of her pucker massages your " + player.cockDescript(0) + ".  She moans and turns around to kiss you on the lips, ensuring your hardness.  Before long her feverish grunts of pleasure intensify, and you feel the egg she's birthing squeezing against you through her internal walls...\n\n", false);
					dynStats("lus", 20);
				}
			}
			if (player.findStatusEffect(StatusEffects.StoneLust) >= 0) {
				if (player.vaginas.length > 0) {
					if (player.lust < 40) outputText("You squirm as the smooth stone orb vibrates within you.\n\n", false);
					if (player.lust >= 40 && player.lust < 70) outputText("You involuntarily clench around the magical stone in your twat, in response to the constant erotic vibrations.\n\n", false);
					if (player.lust >= 70 && player.lust < 85) outputText("You stagger in surprise as a particularly pleasant burst of vibrations erupt from the smooth stone sphere in your " + player.vaginaDescript(0) + ".\n\n", false);
					if (player.lust >= 85) outputText("The magical orb inside of you is making it VERY difficult to keep your focus on combat, white-hot lust suffusing your body with each new motion.\n\n", false);
				}
				else {
					outputText("The orb continues vibrating in your ass, doing its best to arouse you.\n\n", false);
				}
				dynStats("lus", 7 + int(player.sens)/10);
			}
			if (player.findStatusEffect(StatusEffects.KissOfDeath) >= 0) {
				//Effect 
				outputText("Your lips burn with an unexpected flash of heat.  They sting and burn with unholy energies as a puff of ectoplasmic gas escapes your lips.  That puff must be a part of your soul!  It darts through the air to the succubus, who slurps it down like a delicious snack.  You feel feverishly hot and exhausted...\n\n", false);
				dynStats("lus", 5);
				takeDamage(15);		
			}
			if (player.findStatusEffect(StatusEffects.DemonSeed) >= 0) {
				outputText("You feel something shift inside you, making you feel warm.  Finding the desire to fight this... hunk gets harder and harder.\n\n", false);
				dynStats("lus", (player.statusEffectv1(StatusEffects.DemonSeed) + int(player.sens/30) + int(player.lib/30) + int(player.cor/30)));
			}
			if (player.inHeat && player.vaginas.length > 0 && monster.totalCocks() > 0) {
				dynStats("lus", (rand(player.lib/5) + 3 + rand(5)));
				outputText("Your " + player.vaginaDescript(0) + " clenches with an instinctual desire to be touched and filled.  ", false);
				outputText("If you don't end this quickly you'll give in to your heat.\n\n", false);
			}
			if (player.inRut && player.totalCocks() > 0 && monster.hasVagina()) {
				dynStats("lus", (rand(player.lib/5) + 3 + rand(5)));
				if (player.totalCocks() > 1) outputText("Each of y", false);
				else outputText("Y", false);
				if (monster.plural) outputText("our " + player.multiCockDescriptLight() + " dribbles pre-cum as you think about plowing " + monster.a + monster.short + " right here and now, fucking " + monster.pronoun3 + " " + monster.vaginaDescript() + "s until they're totally fertilized and pregnant.\n\n", false);
				else outputText("our " + player.multiCockDescriptLight() + " dribbles pre-cum as you think about plowing " + monster.a + monster.short + " right here and now, fucking " + monster.pronoun3 + " " + monster.vaginaDescript() + " until it's totally fertilized and pregnant.\n\n", false);
			}
			if (player.findStatusEffect(StatusEffects.NagaVenom) >= 0) {
				//Chance to cleanse!
				if (player.findPerk(PerkLib.Medicine) >= 0 && rand(100) <= 14) {
					outputText("You manage to cleanse the naga venom from your system with your knowledge of medicine!\n\n", false);
					player.spe += player.statusEffectv1(StatusEffects.NagaVenom);
					mainView.statsView.showStatUp( 'spe' );
					// speUp.visible = true;
					// speDown.visible = false;
					player.removeStatusEffect(StatusEffects.NagaVenom);
				}
				else if (player.spe > 3) {
					player.addStatusValue(StatusEffects.NagaVenom,1,2);
					//stats(0,0,-2,0,0,0,0,0);
					player.spe -= 2;
				}
				else takeDamage(5);
				outputText("You wince in pain and try to collect yourself, the naga's venom still plaguing you.\n\n", false);
				takeDamage(2);
			}
			else if (player.findStatusEffect(StatusEffects.TemporaryHeat) >= 0) {
				//Chance to cleanse!
				if (player.findPerk(PerkLib.Medicine) >= 0 && rand(100) <= 14) {
					outputText("You manage to cleanse the heat and rut drug from your system with your knowledge of medicine!\n\n", false);
					player.removeStatusEffect(StatusEffects.TemporaryHeat);
				}
				else {
					dynStats("lus", (player.lib/12 + 5 + rand(5)) * player.statusEffectv2(StatusEffects.TemporaryHeat));
					if (player.hasVagina()) {
						outputText("Your " + player.vaginaDescript(0) + " clenches with an instinctual desire to be touched and filled.  ", false);
					}
					else if (player.totalCocks() > 0) {
						outputText("Your " + player.cockDescript(0) + " pulses and twitches, overwhelmed with the desire to breed.  ", false);			
					}
					if (player.gender == 0) {
						outputText("You feel a tingle in your " + player.assholeDescript() + ", and the need to touch and fill it nearly overwhelms you.  ", false);
					}
					outputText("If you don't finish this soon you'll give in to this potent drug!\n\n", false);
				}
			}
			//Poison
			if (player.findStatusEffect(StatusEffects.Poison) >= 0) {
				//Chance to cleanse!
				if (player.findPerk(PerkLib.Medicine) >= 0 && rand(100) <= 14) {
					outputText("You manage to cleanse the poison from your system with your knowledge of medicine!\n\n", false);
					player.removeStatusEffect(StatusEffects.Poison);
				}
				else {
					outputText("The poison continues to work on your body, wracking you with pain!\n\n", false);
					takeDamage(8+rand(player.maxHP()/20) * player.statusEffectv2(StatusEffects.Poison));
				}
			}
			//Bondage straps + bondage fetish
			if (flags[kFLAGS.PC_FETISH] >= 2 && player.armorName == "barely-decent bondage straps") {
				outputText("The feeling of the tight, leather straps holding tightly to your body while exposing so much of it turns you on a little bit more.\n\n", false);
				dynStats("lus", 2);
			}
			//Giant boulder
			if (player.findStatusEffect(StatusEffects.GiantBoulder) >= 0) {
				outputText("<b>There is a large boulder coming your way. If you don't avoid it in time, you might take some serious damage.</b>\n\n");
			}
			if (player.findStatusEffect(StatusEffects.DriderIncubusVenom) >= 0) {
				//Chance to cleanse!
				if (player.findPerk(PerkLib.Medicine) >= 0 && rand(100) <= 14) {
					outputText("You manage to cleanse the drider incubus venom from your system with your knowledge of medicine!\n\n", false);
					player.str += player.statusEffectv1(StatusEffects.DriderIncubusVenom);
					mainView.statsView.showStatUp('str');
					player.removeStatusEffect(StatusEffects.DriderIncubusVenom);
				}
			}
			//Drider Incubus' purple haze
			if (player.findStatusEffect(StatusEffects.PurpleHaze) >= 0) {
				outputText("<b>The purple haze is filling your vision with unsubtle erotic imagery, arousing you.</b>\n\n");
				dynStats("lus", 3);
			}
			//Minotaur King's musk
			if (player.findStatusEffect(StatusEffects.MinotaurKingMusk) >= 0) {
				outputText("<b>The smell of the minotaur pheronome is intense, turning you on. You should try to deal with him as soon as possible.</b>\n\n");
				dynStats("lus", 2);
			}
			//Minotaur King Touched
			if (player.findStatusEffect(StatusEffects.MinotaurKingsTouch) >= 0) {
				outputText("<b>The residual cum from the Minotaur King continues to arouse you.</b>\n\n");
				dynStats("lus", 1);
			}
			//Pigby's Hands
			if (player.findStatusEffect(StatusEffects.PigbysHands) >= 0) {
				dynStats("lus", 3);
			}
			//Whip Silence
			if (player.findStatusEffect(StatusEffects.WhipSilence) >= 0) {
				if (player.statusEffectv1(StatusEffects.WhipSilence) > 0) {
					outputText("<b>You are silenced by the burning cord wrapped around your neck. It's painful... and arousing too.</b> ");
					player.takeDamage(10 + rand(8), true);
					dynStats("lus", 4);
					player.addStatusValue(StatusEffects.WhipSilence, 1, -1);
					outputText("\n\n");
				}
				else {
					outputText("The cord has finally came loose and falls off your neck. It dissipates immediately. You can cast spells again now!\n\n");
					player.removeStatusEffect(StatusEffects.WhipSilence);
				}
			}
			regeneration(true);
			if (player.lust >= player.maxLust()) doNext(endLustLoss);
			if (player.HP <= 0) doNext(endHpLoss);
		}

		public function regeneration(combat:Boolean = true):void {
			var healingPercent:Number = 0;
			var healingBonus:Number = 0;
			if (combat) {
				//Regeneration
				healingPercent = 0;
				if (player.hunger >= 25 || flags[kFLAGS.HUNGER_ENABLED] <= 0)
				{
					if (player.findPerk(PerkLib.Regeneration) >= 0) healingPercent += 1;
					if (player.findPerk(PerkLib.Regeneration2) >= 0) healingPercent += 1;
				}
				if (player.findPerk(PerkLib.LustyRegeneration) >= 0) healingPercent += 1;
				if (player.armor == armors.NURSECL) healingPercent += 1;
				if (player.armor == armors.GOOARMR) healingPercent += (getGame().valeria.valeriaFluidsEnabled() ? (flags[kFLAGS.VALERIA_FLUIDS] < 50 ? flags[kFLAGS.VALERIA_FLUIDS] / 25 : 2) : 2);
				if (player.jewelry.effectId == JewelryLib.MODIFIER_REGENERATION) healingBonus += player.jewelry.effectMagnitude;
				if (healingPercent > 5) healingPercent = 5;
				HPChange(Math.round(player.maxHP() * healingPercent / 100) + healingBonus, false);
			}
			else {
				//Regeneration
				healingPercent = 0;
				if (player.hunger >= 25 || flags[kFLAGS.HUNGER_ENABLED] <= 0)
				{
					if (player.findPerk(PerkLib.Regeneration) >= 0) healingPercent += 2;
					if (player.findPerk(PerkLib.Regeneration2) >= 0) healingPercent += 2;
				}
				if (player.armorName == "skimpy nurse's outfit") healingPercent += 2;
				if (player.armorName == "goo armor") healingPercent += (getGame().valeria.valeriaFluidsEnabled() ? (flags[kFLAGS.VALERIA_FLUIDS] < 50 ? flags[kFLAGS.VALERIA_FLUIDS] / 16 : 3) : 3);
				if (player.findPerk(PerkLib.LustyRegeneration) >= 0) healingPercent += 2;
				if (healingPercent > 10) healingPercent = 10;
				HPChange(Math.round(player.maxHP() * healingPercent / 100), false);
			}
		}
		
		public function beginCombat(monster_:Monster, plotFight_:Boolean = false):void {
			combatRound = 0;
			plotFight = plotFight_;
			mainView.hideMenuButton( MainView.MENU_DATA );
			mainView.hideMenuButton( MainView.MENU_APPEARANCE );
			mainView.hideMenuButton( MainView.MENU_LEVEL );
			mainView.hideMenuButton( MainView.MENU_PERKS );
			mainView.hideMenuButton( MainView.MENU_STATS );
			showStats();
			//Flag the game as being "in combat"
			inCombat = true;
			monster = monster_;
			
			//Set image once, at the beginning of combat
			if (monster.imageName != "")
			{
				var monsterName:String = "monster-" + monster.imageName;
				imageText = images.showImage(monsterName);
			} else imageText = "";
			
			//Reduce enemy def if player has precision!
			if (player.findPerk(PerkLib.Precision) >= 0 && player.inte >= 25) {
				if (monster.armorDef <= 10) monster.armorDef = 0;
				else monster.armorDef -= 10;
			}
			if (player.findPerk(PerkLib.Battlemage) >= 0 && player.lust >= 50) {
				combatAbilities.spellMight(true); // XXX: message?
			}
			if (player.findPerk(PerkLib.Spellsword) >= 0 && player.lust < combatAbilities.getWhiteMagicLustCap()) {
				combatAbilities.spellChargeWeapon(true); // XXX: message?
			}
			monster.str += 25 * player.newGamePlusMod();
			monster.tou += 25 * player.newGamePlusMod();
			monster.spe += 25 * player.newGamePlusMod();
			monster.inte += 25 * player.newGamePlusMod();
			monster.level += 30 * player.newGamePlusMod();
			if (flags[kFLAGS.GRIMDARK_MODE] > 0) {
				monster.level = Math.round(Math.pow(monster.level, 1.4));
			}
			//Adjust lust vulnerability in New Game+.
			if (player.newGamePlusMod() == 1) monster.lustVuln *= 0.8;
			else if (player.newGamePlusMod() == 2) monster.lustVuln *= 0.65;
			else if (player.newGamePlusMod() == 3) monster.lustVuln *= 0.5;
			else if (player.newGamePlusMod() >= 4) monster.lustVuln *= 0.4;
			monster.HP = monster.eMaxHP();
			monster.XP = monster.totalXP();
			if (player.weaponName == "flintlock pistol") flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = 4;
			if (player.weaponName == "blunderbuss") flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = 12;
			if (prison.inPrison && prison.prisonCombatAutoLose) {
				dynStats("lus", player.maxLust(), "resisted", false);
				doNext(endLustLoss);
				return;
			}
			doNext(playerMenu);
		}
		public function beginCombatImmediate(monster:Monster, _plotFight:Boolean):void {
			beginCombat(monster, _plotFight);
		}
		
		public function display():void {
			if (!monster.checkCalled){
				outputText("<B>/!\\BUG! Monster.checkMonster() is not called! Calling it now...</B>\n");
				monster.checkMonster();
			}
			if (monster.checkError != ""){
				outputText("<B>/!\\BUG! Monster is not correctly initialized! </B>"+
						monster.checkError+"</u></b>\n");
			}
			var hpDisplay:String = "";
			var lustDisplay:String = "";
			var math:Number = monster.HPRatio();
			//hpDisplay = "(<b>" + String(int(math * 1000) / 10) + "% HP</b>)";
			hpDisplay = Math.floor(monster.HP) + " / " + monster.eMaxHP() + " (" + (int(math * 1000) / 10) + "%)";
			lustDisplay = Math.floor(monster.lust) + " / " + monster.eMaxLust();;

			//imageText set in beginCombat()
			outputText(imageText);
			
			outputText("<b>You are fighting ");
			outputText(monster.a + monster.short + ":</b> \n");
			if (player.findStatusEffect(StatusEffects.Blind) >= 0) {
				outputText("It's impossible to see anything!\n");
			}
			else {
				outputText(monster.long + "\n\n");
				//Bonus sand trap stuff
				if (monster.findStatusEffect(StatusEffects.Level) >= 0) {
					temp = monster.statusEffectv1(StatusEffects.Level);
					//[(new PG for PC height levels)PC level 4: 
					if (temp == 4) outputText("You are right at the edge of its pit.  If you can just manage to keep your footing here, you'll be safe.");
					else if (temp == 3) outputText("The sand sinking beneath your feet has carried you almost halfway into the creature's pit.");
					else outputText("The dunes tower above you and the hissing of sand fills your ears.  <b>The leering sandtrap is almost on top of you!</b>");
					//no new PG)
					outputText("  You could try attacking it with your " + player.weaponName + ", but that will carry you straight to the bottom.  Alternately, you could try to tease it or hit it at range, or wait and maintain your footing until you can clamber up higher.");
					outputText("\n\n");
				}
				if (monster.plural) {
					if (math >= 1) outputText("You see " + monster.pronoun1 + " are in perfect health.  ");
					else if (math > .75) outputText("You see " + monster.pronoun1 + " aren't very hurt.  ");
					else if (math > .5) outputText("You see " + monster.pronoun1 + " are slightly wounded.  ");
					else if (math > .25) outputText("You see " + monster.pronoun1 + " are seriously hurt.  ");
					else outputText("You see " + monster.pronoun1 + " are unsteady and close to death.  ");
				}
				else {
					if (math >= 1) outputText("You see " + monster.pronoun1 + " is in perfect health.  ");
					else if (math > .75) outputText("You see " + monster.pronoun1 + " isn't very hurt.  ");
					else if (math > .5) outputText("You see " + monster.pronoun1 + " is slightly wounded.  ");
					else if (math > .25) outputText("You see " + monster.pronoun1 + " is seriously hurt.  ");
					else outputText("You see " + monster.pronoun1 + " is unsteady and close to death.  ");
				}
				showMonsterLust();
				outputText("\n\n<b><u>" + capitalizeFirstLetter(monster.short) + "'s Stats</u></b>\n")
				outputText("Level: " + monster.level + "\n");
				outputText("HP: " + hpDisplay + "\n");
				outputText("Lust: " + lustDisplay + "\n");
			}
			if (debug){
				outputText("\n----------------------------\n");
				outputText(monster.generateDebugDescription(),false);
			}
		}
		public function showMonsterLust():void {
			//Entrapped
			if (monster.findStatusEffect(StatusEffects.Constricted) >= 0) {
				outputText(monster.capitalA + monster.short + " is currently wrapped up in your tail-coils!  ", false);
			}
			//Venom stuff!
			if (monster.findStatusEffect(StatusEffects.NagaVenom) >= 0) {
				if (monster.plural) {
					if (monster.statusEffectv1(StatusEffects.NagaVenom) <= 1) {
						outputText("You notice " + monster.pronoun1 + " are beginning to show signs of weakening, but there still appears to be plenty of fight left in " + monster.pronoun2 + ".  ", false);
					}
		    	    else {
						outputText("You notice " + monster.pronoun1 + " are obviously affected by your venom, " + monster.pronoun3 + " movements become unsure, and " + monster.pronoun3 + " balance begins to fade. Sweat begins to roll on " + monster.pronoun3 + " skin. You wager " + monster.pronoun1 + " are probably beginning to regret provoking you.  ", false);
					}
				}
				//Not plural
				else {
					if (monster.statusEffectv1(StatusEffects.NagaVenom) <= 1) {
						outputText("You notice " + monster.pronoun1 + " is beginning to show signs of weakening, but there still appears to be plenty of fight left in " + monster.pronoun2 + ".  ", false);
					}
		    	    else {
						outputText("You notice " + monster.pronoun1 + " is obviously affected by your venom, " + monster.pronoun3 + " movements become unsure, and " + monster.pronoun3 + " balance begins to fade. Sweat is beginning to roll on " + monster.pronoun3 + " skin. You wager " + monster.pronoun1 + " is probably beginning to regret provoking you.  ", false);
					}
				}
				
				monster.spe -= monster.statusEffectv1(StatusEffects.NagaVenom);
				monster.str -= monster.statusEffectv1(StatusEffects.NagaVenom);
				if (monster.spe < 1) monster.spe = 1;
				if (monster.str < 1) monster.str = 1;
			}
			if (monster.short == "harpy") {
				//(Enemy slightly aroused) 
				if (monster.lust >= 45 && monster.lust < 70) outputText("The harpy's actions are becoming more and more erratic as she runs her mad-looking eyes over your body, her chest jiggling, clearly aroused.  ", false);
				//(Enemy moderately aroused) 
				if (monster.lust >= 70 && monster.lust < 90) outputText("She stops flapping quite so frantically and instead gently sways from side to side, showing her soft, feathery body to you, even twirling and raising her tail feathers, giving you a glimpse of her plush pussy, glistening with fluids.", false);
				//(Enemy dangerously aroused) 
				if (monster.lust >= 90) outputText("You can see her thighs coated with clear fluids, the feathers matted and sticky as she struggles to contain her lust.", false);
			}
			else if (monster is Clara)
			{
				//Clara is becoming aroused
				if (monster.lust <= 40)	 {}
				else if (monster.lust <= 65) outputText("The anger in her motions is weakening.");
				//Clara is somewhat aroused
				else if (monster.lust <= 75) outputText("Clara seems to be becoming more aroused than angry now.");
				//Clara is very aroused
				else if (monster.lust <= 85) outputText("Clara is breathing heavily now, the signs of her arousal becoming quite visible now.");
				//Clara is about to give in
				else outputText("It looks like Clara is on the verge of having her anger overwhelmed by her lusts.");
			}
			//{Bonus Lust Descripts}
			else if (monster.short == "Minerva") {
				if (monster.lust < 40) {}
				//(40)
				else if (monster.lust < 60) outputText("Letting out a groan Minerva shakes her head, focusing on the fight at hand.  The bulge in her short is getting larger, but the siren ignores her growing hard-on and continues fighting.  ");
				//(60) 
				else if (monster.lust < 80) outputText("Tentacles are squirming out from the crotch of her shorts as the throbbing bulge grows bigger and bigger, becoming harder and harder... for Minerva to ignore.  A damp spot has formed just below the bulge.  ");
				//(80)
				else outputText("She's holding onto her weapon for support as her face is flushed and pain-stricken.  Her tiny, short shorts are painfully holding back her quaking bulge, making the back of the fabric act like a thong as they ride up her ass and struggle against her cock.  Her cock-tentacles are lashing out in every direction.  The dampness has grown and is leaking down her leg.");
			}
			else if (monster.short == "Cum Witch") {
				//{Bonus Lust Desc (40+)}
				if (monster.lust < 40) {}
				else if (monster.lust < 50) outputText("Her nipples are hard, and poke two visible tents into the robe draped across her mountainous melons.  ");
				//{Bonus Lust Desc (50-75)}
				else if (monster.lust < 75) outputText("Wobbling dangerously, you can see her semi-hard shaft rustling the fabric as she moves, evidence of her growing needs.  ");
				//{75+}
				if (monster.lust >= 75) outputText("Swelling obscenely, the Cum Witch's thick cock stands out hard and proud, its bulbous tip rustling through the folds of her fabric as she moves and leaving dark smears in its wake.  ");
				//(85+}
				if (monster.lust >= 85) outputText("Every time she takes a step, those dark patches seem to double in size.  ");
				//{93+}
				if (monster.lust >= 93) outputText("There's no doubt about it, the Cum Witch is dripping with pre-cum and so close to caving in.  Hell, the lower half of her robes are slowly becoming a seed-stained mess.  ");
				//{Bonus Lust Desc (60+)}
				if (monster.lust >= 70) outputText("She keeps licking her lips whenever she has a moment, and she seems to be breathing awfully hard.  ");
			}
			else if (monster.short == "Kelt") {
				//Kelt Lust Levels
				//(sub 50)
				if (monster.lust < 50) outputText("Kelt actually seems to be turned off for once in his miserable life.  His maleness is fairly flaccid and droopy.  ");
				//(sub 60)
				else if (monster.lust < 60) outputText("Kelt's gotten a little stiff down below, but he still seems focused on taking you down.  ");
				//(sub 70)
				else if (monster.lust < 70) outputText("Kelt's member has grown to its full size and even flared a little at the tip.  It bobs and sways with every movement he makes, reminding him how aroused you get him.  ");
				//(sub 80)
				else if (monster.lust < 80) outputText("Kelt is unabashedly aroused at this point.  His skin is flushed, his manhood is erect, and a thin bead of pre has begun to bead underneath.  ");
				//(sub 90)
				else if (monster.lust < 90) outputText("Kelt seems to be having trouble focusing.  He keeps pausing and flexing his muscles, slapping his cock against his belly and moaning when it smears his pre-cum over his equine underside.  ");
				//(sub 100) 
				else outputText("There can be no doubt that you're having quite the effect on Kelt.  He keeps fidgeting, dripping pre-cum everywhere as he tries to keep up the facade of fighting you.  His maleness is continually twitching and bobbing, dripping messily.  He's so close to giving in...");
			}
			else if (monster.short == "green slime") {
				if (monster.lust >= 45 && monster.lust < 65) outputText("A lump begins to form at the base of the figure's torso, where its crotch would be.  ", false); 
				if (monster.lust >= 65 && monster.lust < 85) outputText("A distinct lump pulses at the base of the slime's torso, as if something inside the creature were trying to escape.  ", false);
				if (monster.lust >= 85 && monster.lust < 93) outputText("A long, thick pillar like a small arm protrudes from the base of the slime's torso.  ", false);
				if (monster.lust >= 93) outputText("A long, thick pillar like a small arm protrudes from the base of the slime's torso.  Its entire body pulses, and it is clearly beginning to lose its cohesion.  ", false);
			}
			else if (monster.short == "Sirius, a naga hypnotist") {
				if (monster.lust < 40) {}
				else if (monster.lust >= 40) outputText("You can see the tip of his reptilian member poking out of its protective slit. ");
				else if (monster.lust >= 60) outputText("His cock is now completely exposed and half-erect, yet somehow he still stays focused on your eyes and his face is inexpressive.  ");
				else outputText("His cock is throbbing hard, you don't think it will take much longer for him to pop.   Yet his face still looks inexpressive... despite the beads of sweat forming on his brow.  ");

			}
			else if (monster.short == "kitsune") {
				//Kitsune Lust states:
				//Low
				if (monster.lust > 30 && monster.lust < 50) outputText("The kitsune's face is slightly flushed.  She fans herself with her hand, watching you closely.");
				//Med
				else if (monster.lust > 30 && monster.lust < 75) outputText("The kitsune's cheeks are bright pink, and you can see her rubbing her thighs together and squirming with lust.");
				//High
				else if (monster.lust > 30) {
					//High (redhead only)
					if (monster.hairColor == "red") outputText("The kitsune is openly aroused, unable to hide the obvious bulge in her robes as she seems to be struggling not to stroke it right here and now.");
					else outputText("The kitsune is openly aroused, licking her lips frequently and desperately trying to hide the trail of fluids dripping down her leg.");
				}
			}
			else if (monster.short == "demons") {
				if (monster.lust > 30 && monster.lust < 60) outputText("The demons lessen somewhat in the intensity of their attack, and some even eye up your assets as they strike at you.", false);
				if (monster.lust >= 60 && monster.lust < 80) outputText("The demons are obviously steering clear from damaging anything you might use to fuck and they're starting to leave their hands on you just a little longer after each blow. Some are starting to cop quick feels with their other hands and you can smell the demonic lust of a dozen bodies on the air.", false);
				if (monster.lust >= 80) outputText(" The demons are less and less willing to hit you and more and more willing to just stroke their hands sensuously over you. The smell of demonic lust is thick on the air and part of the group just stands there stroking themselves openly.", false);
			}
			else {
				if (monster.plural) {
					if (monster.lust > 50 && monster.lust < 60) outputText(monster.capitalA + monster.short + "' skin remains flushed with the beginnings of arousal.  ", false);
					if (monster.lust >= 60 && monster.lust < 70) outputText(monster.capitalA + monster.short + "' eyes constantly dart over your most sexual parts, betraying " + monster.pronoun3 + " lust.  ", false);
					if (monster.cocks.length > 0) {
						if (monster.lust >= 70 && monster.lust < 85) outputText(monster.capitalA + monster.short + " are having trouble moving due to the rigid protrusion in " + monster.pronoun3 + " groins.  ", false);
						if (monster.lust >= 85) outputText(monster.capitalA + monster.short + " are panting and softly whining, each movement seeming to make " + monster.pronoun3 + " bulges more pronounced.  You don't think " + monster.pronoun1 + " can hold out much longer.  ", false);
					}
					if (monster.vaginas.length > 0) {
						if (monster.lust >= 70 && monster.lust < 85) outputText(monster.capitalA + monster.short + " are obviously turned on, you can smell " + monster.pronoun3 + " arousal in the air.  ", false);
						if (monster.lust >= 85) outputText(monster.capitalA + monster.short + "' " + monster.vaginaDescript() + "s are practically soaked with their lustful secretions.  ", false);
					}
				}
				else {
					if (monster.lust > 50 && monster.lust < 60) outputText(monster.capitalA + monster.short + "'s skin remains flushed with the beginnings of arousal.  ", false);
					if (monster.lust >= 60 && monster.lust < 70) outputText(monster.capitalA + monster.short + "'s eyes constantly dart over your most sexual parts, betraying " + monster.pronoun3 + " lust.  ", false);
					if (monster.cocks.length > 0) {
						if (monster.lust >= 70 && monster.lust < 85) outputText(monster.capitalA + monster.short + " is having trouble moving due to the rigid protrusion in " + monster.pronoun3 + " groin.  ", false);
						if (monster.lust >= 85) outputText(monster.capitalA + monster.short + " is panting and softly whining, each movement seeming to make " + monster.pronoun3 + " bulge more pronounced.  You don't think " + monster.pronoun1 + " can hold out much longer.  ", false);
					}
					if (monster.vaginas.length > 0) {
						if (monster.lust >= 70 && monster.lust < 85) outputText(monster.capitalA + monster.short + " is obviously turned on, you can smell " + monster.pronoun3 + " arousal in the air.  ", false);
						if (monster.lust >= 85) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " is practically soaked with her lustful secretions.  ", false);
					}
				}
			}
		}

		//VICTORY OR DEATH?
		public function combatRoundOver():Boolean { //Called after the monster's action. Given a different name to avoid conflicing with BaseContent.
			combatRound++;
			statScreenRefresh();
			flags[kFLAGS.ENEMY_CRITICAL] = 0;
			if (!inCombat) return false;
			if (monster.HP < 1) {
				doNext(endHpVictory);
				return true;
			}
			if (monster.lust >= monster.eMaxLust()) {
				doNext(endLustVictory);
				return true;
			}
			if (monster.findStatusEffect(StatusEffects.Level) >= 0) {
				if ((monster as SandTrap).trapLevel() <= 1) {
					getGame().desert.sandTrapScene.sandtrapmentLoss();
					return true;
				}
			}
			if (monster.short == "basilisk" && player.spe <= 1) {
				doNext(endHpLoss);
				return true;
			}
			if (player.HP < 1) {
				doNext(endHpLoss);
				return true;
			}
			if (player.lust >= player.maxLust()) {
				doNext(endLustLoss);
				return true;
			}
			doNext(playerMenu); //This takes us back to the combatMenu and a new combat round
			return false;
		}

		public function runAway(callHook:Boolean = true):void {
			if (callHook && monster.onPcRunAttempt != null){
				monster.onPcRunAttempt();
				return;
			}
			clearOutput();
			if (inCombat && player.findStatusEffect(StatusEffects.Sealed) >= 0 && player.statusEffectv2(StatusEffects.Sealed) == 4) {
				clearOutput();
				outputText("You try to run, but you just can't seem to escape.  <b>Your ability to run was sealed, and now you've wasted a chance to attack!</b>\n\n");
				monster.doAI();
				return;
			}
			//Rut doesnt let you run from dicks.
			if (player.inRut && monster.totalCocks() > 0) {
				outputText("The thought of another male in your area competing for all the pussy infuriates you!  No way will you run!", true);
		//Pass false to combatMenu instead:		menuLoc = 3;
		//		doNext(combatMenu);
				menu();
				addButton(0, "Next", combatMenu, false);
				return;
			}
			if (monster.findStatusEffect(StatusEffects.Level) >= 0 && player.canFly()) {
				clearOutput();
				outputText("You flex the muscles in your back and, shaking clear of the sand, burst into the air!  Wasting no time you fly free of the sandtrap and its treacherous pit.  \"One day your wings will fall off, little ant,\" the snarling voice of the thwarted androgyne carries up to you as you make your escape.  \"And I will be waiting for you when they do!\"");
				inCombat = false;
				clearStatuses(false);
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			if (monster.findStatusEffect(StatusEffects.GenericRunDisabled) >= 0 || getGame().urtaQuest.isUrta()) {
				outputText("You can't escape from this fight!");
		//Pass false to combatMenu instead:		menuLoc = 3;
		//		doNext(combatMenu);
				menu();
				addButton(0, "Next", combatMenu, false);
				return;
			}
			if (monster.findStatusEffect(StatusEffects.Level) >= 0 && monster.statusEffectv1(StatusEffects.Level) < 4) {
				outputText("You're too deeply mired to escape!  You'll have to <b>climb</b> some first!");
		//Pass false to combatMenu instead:		menuLoc = 3;
		//		doNext(combatMenu);
				menu();
				addButton(0, "Next", combatMenu, false);
				return;
			}
			if (monster.findStatusEffect(StatusEffects.RunDisabled) >= 0) {
				outputText("You'd like to run, but you can't scale the walls of the pit with so many demonic hands pulling you down!");
		//Pass false to combatMenu instead:		menuLoc = 3;
		//		doNext(combatMenu);
				menu();
				addButton(0, "Next", combatMenu, false);
				return;
			}
			if (flags[kFLAGS.MINOTAUR_SONS_WASTED_TURN] == 1 && (monster.short == "minotaur gang" || monster.short == "minotaur tribe")) {
				flags[kFLAGS.MINOTAUR_SONS_WASTED_TURN] = 0;
				//(Free run away) 
				outputText("You slink away while the pack of brutes is arguing.  Once they finish that argument, they'll be sorely disappointed!", true);
				inCombat = false;
				clearStatuses(false);
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			else if (monster.short == "minotaur tribe" && monster.HPRatio() >= 0.75) {
				outputText("There's too many of them surrounding you to run!", true);
		//Pass false to combatMenu instead:		menuLoc = 3;
		//		doNext(combatMenu);
				menu();
				addButton(0, "Next", combatMenu, false);
				return;
			}
			if (inDungeon || inRoomedDungeon) {
				outputText("You're trapped in your foe's home turf - there is nowhere to run!\n\n", true);
				monster.doAI();
				return;
			}
			if (prison.inPrison && !prison.prisonCanEscapeRun()) {
				addButton(0, "Next", combatMenu, false);
				return;
			}
			//Attempt texts!
			if (monster.short == "Marae") {
				outputText("Your boat is blocked by tentacles! ");
				if (!player.canFly()) outputText("You may not be able to swim fast enough. ");
				else outputText("You grit your teeth with effort as you try to fly away but the tentacles suddenly grab your " + player.legs() + " and pull you down. ");
				outputText("It looks like you cannot escape. ");
				monster.doAI();
				return;
			}
			if (monster.short == "Ember") {
				outputText("You take off");
				if (!player.canFly()) outputText(" running");
				else outputText(", flapping as hard as you can");
				outputText(", and Ember, caught up in the moment, gives chase.  ");
			}
			if (monster.short == "lizan rogue") {
				outputText("As you retreat the lizan doesn't even attempt to stop you. When you look back to see if he's still there you find nothing but the empty bog around you.");
				inCombat = false;
				clearStatuses(false);
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			else if (player.canFly()) outputText("Gritting your teeth with effort, you beat your wings quickly and lift off!  ", false);	
			//Nonflying PCs
			else {
				//In prison!
				if (prison.inPrison) {
					outputText("You make a quick dash for the door and attempt to escape! ");
				}
				//Stuck!
				else if (player.findStatusEffect(StatusEffects.NoFlee) >= 0) {
					if (monster.short == "goblin") outputText("You try to flee but get stuck in the sticky white goop surrounding you.\n\n", true);
					else outputText("You put all your skills at running to work and make a supreme effort to escape, but are unable to get away!\n\n", true);
					monster.doAI();
					return;
				}
				//Nonstuck!
				else outputText("You turn tail and attempt to flee!  ", false);
			}
				
			//Calculations
			var escapeMod:Number = 20 + monster.level * 3;
			if (debug) escapeMod -= 300;
			if (player.canFly()) escapeMod -= 20;
			if (player.tailType == TAIL_TYPE_RACCOON && player.earType == EARS_RACCOON && player.findPerk(PerkLib.Runner) >= 0) escapeMod -= 25;
			if (monster.findStatusEffect(StatusEffects.Stunned) >= 0) escapeMod -= 50;
			
			//Big tits doesn't matter as much if ya can fly!
			else {
				if (player.biggestTitSize() >= 35) escapeMod += 5;
				if (player.biggestTitSize() >= 66) escapeMod += 10;
				if (player.hipRating >= 20) escapeMod += 5;
				if (player.buttRating >= 20) escapeMod += 5;
				if (player.ballSize >= 24 && player.balls > 0) escapeMod += 5;
				if (player.ballSize >= 48 && player.balls > 0) escapeMod += 10;
				if (player.ballSize >= 120 && player.balls > 0) escapeMod += 10;
			}
			//ANEMONE OVERRULES NORMAL RUN
			if (monster.short == "anemone") {
				//Autosuccess - less than 60 lust
				if (player.lust < 60) {
					outputText("Marshalling your thoughts, you frown at the strange girl and turn to march up the beach.  After twenty paces inshore you turn back to look at her again.  The anemone is clearly crestfallen by your departure, pouting heavily as she sinks beneath the water's surface.", true);
					inCombat = false;
					clearStatuses(false);
					doNext(camp.returnToCampUseOneHour);
					return;
				}
				//Speed dependent
				else {
					//Success
					if (player.spe > rand(monster.spe+escapeMod)) {
						inCombat = false;
						clearStatuses(false);
						outputText("Marshalling your thoughts, you frown at the strange girl and turn to march up the beach.  After twenty paces inshore you turn back to look at her again.  The anemone is clearly crestfallen by your departure, pouting heavily as she sinks beneath the water's surface.", true);
						doNext(camp.returnToCampUseOneHour);
						return;
					}
					//Run failed:
					else {
						outputText("You try to shake off the fog and run but the anemone slinks over to you and her tentacles wrap around your waist.  <i>\"Stay?\"</i> she asks, pressing her small breasts into you as a tentacle slides inside your " + player.armorName + " and down to your nethers.  The combined stimulation of the rubbing and the tingling venom causes your knees to buckle, hampering your resolve and ending your escape attempt.", false);
						//(gain lust, temp lose spd/str)
						(monster as Anemone).applyVenom((4+player.sens/20));
						combatRoundOver();
						return;
					}
				}
			}
			//Ember is SPUCIAL
			if (monster.short == "Ember") {
				//GET AWAY
				if (player.spe > rand(monster.spe + escapeMod) || (player.findPerk(PerkLib.Runner) >= 0 && rand(100) < 50)) {
					if (player.findPerk(PerkLib.Runner) >= 0) outputText("Using your skill at running, y");
					else outputText("Y");
					outputText("You easily outpace the dragon, who begins hurling imprecations at you.  \"What the hell, [name], you weenie; are you so scared that you can't even stick out your punishment?\"");
					outputText("\n\nNot to be outdone, you call back, \"Sucks to you!  If even the mighty Last Ember of Hope can't catch me, why do I need to train?  Later, little bird!\"");
					inCombat = false;
					clearStatuses(false);
					doNext(camp.returnToCampUseOneHour);
				}
				//Fail: 
				else {
					outputText("Despite some impressive jinking, " + getGame().emberScene.emberMF("he", "she") + " catches you, tackling you to the ground.\n\n");
					monster.doAI();
				}
				return;
			}
			//SUCCESSFUL FLEE
			if (player.spe > rand(monster.spe + escapeMod)) {
				//Escape prison
				if (prison.inPrison) {
					outputText("You quickly bolt out of the main entrance and after hiding for a good while, there's no sign of " + monster.a + " " + monster.short + ". You sneak back inside to retrieve whatever you had before you were captured. ");
					inCombat = false;
					clearStatuses(false);
					prison.prisonEscapeSuccessText();
					doNext(prison.prisonEscapeFinalePart1);
					return;
				}
				//Fliers flee!
				else if (player.canFly()) outputText(monster.capitalA + monster.short + " can't catch you.", false);
				//sekrit benefit: if you have coon ears, coon tail, and Runner perk, change normal Runner escape to flight-type escape
				else if (player.tailType == TAIL_TYPE_RACCOON && player.earType == EARS_RACCOON && player.findPerk(PerkLib.Runner) >= 0) {
					outputText("Using your running skill, you build up a head of steam and jump, then spread your arms and flail your tail wildly; your opponent dogs you as best " + monster.pronoun1 + " can, but stops and stares dumbly as your spastic tail slowly propels you several meters into the air!  You leave " + monster.pronoun2 + " behind with your clumsy, jerky, short-range flight.");
				}
				//Non-fliers flee
				else outputText(monster.capitalA + monster.short + " rapidly disappears into the shifting landscape behind you.", false);
				if (monster.short == "Izma") {
					outputText("\n\nAs you leave the tigershark behind, her taunting voice rings out after you.  \"<i>Oooh, look at that fine backside!  Are you running or trying to entice me?  Haha, looks like we know who's the superior specimen now!  Remember: next time we meet, you owe me that ass!</i>\"  Your cheek tingles in shame at her catcalls.", false);
				}
				inCombat = false;
				clearStatuses(false);
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			//Runner perk chance
			else if (player.findPerk(PerkLib.Runner) >= 0 && rand(100) < 50) {
				inCombat = false;
				outputText("Thanks to your talent for running, you manage to escape.", false);
				if (monster.short == "Izma") {
					outputText("\n\nAs you leave the tigershark behind, her taunting voice rings out after you.  \"<i>Oooh, look at that fine backside!  Are you running or trying to entice me?  Haha, looks like we know who's the superior specimen now!  Remember: next time we meet, you owe me that ass!</i>\"  Your cheek tingles in shame at her catcalls.", false);
				}
				clearStatuses(false);
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			//FAIL FLEE
			else {
				if (monster.short == "Holli") {
					(monster as Holli).escapeFailWithHolli();
					return;
				}
				//Flyers get special failure message.
				if (player.canFly()) {
					if (monster.plural) outputText(monster.capitalA + monster.short + " manage to grab your " + player.legs() + " and drag you back to the ground before you can fly away!", false);
					else outputText(monster.capitalA + monster.short + " manages to grab your " + player.legs() + " and drag you back to the ground before you can fly away!", false);
				}
				//fail
				else if (player.tailType == TAIL_TYPE_RACCOON && player.earType == EARS_RACCOON && player.findPerk(PerkLib.Runner) >= 0) outputText("Using your running skill, you build up a head of steam and jump, but before you can clear the ground more than a foot, your opponent latches onto you and drags you back down with a thud!");
				//Nonflyer messages
				else {
					//Huge balls messages
					if (player.balls > 0 && player.ballSize >= 24) {
						if (player.ballSize < 48) outputText("With your " + player.ballsDescriptLight() + " swinging ponderously beneath you, getting away is far harder than it should be.  ", false);
						else outputText("With your " + player.ballsDescriptLight() + " dragging along the ground, getting away is far harder than it should be.  ", false);
					}
					//FATASS BODY MESSAGES
					if (player.biggestTitSize() >= 35 || player.buttRating >= 20 || player.hipRating >= 20)
					{
						//FOR PLAYERS WITH GIANT BREASTS
						if (player.biggestTitSize() >= 35 && player.biggestTitSize() < 66)
						{
							if (player.hipRating >= 20)
							{
								outputText("Your " + player.hipDescript() + " forces your gait to lurch slightly side to side, which causes the fat of your " + player.skinTone + " ", false);
								if (player.buttRating >= 20) outputText(player.buttDescript() + " and ", false);
								outputText(player.chestDesc() + " to wobble immensely, throwing you off balance and preventing you from moving quick enough to escape.", false);
							}
							else if (player.buttRating >= 20) outputText("Your " + player.skinTone + player.buttDescript() + " and " + player.chestDesc() + " wobble and bounce heavily, throwing you off balance and preventing you from moving quick enough to escape.", false);
							else outputText("Your " + player.chestDesc() + " jiggle and wobble side to side like the " + player.skinTone + " sacks of milky fat they are, with such force as to constantly throw you off balance, preventing you from moving quick enough to escape.", false);
						}
						//FOR PLAYERS WITH MASSIVE BREASTS
						else if (player.biggestTitSize() >= 66) {
							if (player.hipRating >= 20) {
								outputText("Your " + player.chestDesc() + " nearly drag along the ground while your " + player.hipDescript() + " swing side to side ", false);
								if (player.buttRating >= 20) outputText("causing the fat of your " + player.skinTone + player.buttDescript() + " to wobble heavily, ", false);
								outputText("forcing your body off balance and preventing you from moving quick enough to get escape.", false);
							}
							else if (player.buttRating >= 20) outputText("Your " + player.chestDesc() + " nearly drag along the ground while the fat of your " + player.skinTone + player.buttDescript() + " wobbles heavily from side to side, forcing your body off balance and preventing you from moving quick enough to escape.", false);
							else outputText("Your " + player.chestDesc() + " nearly drag along the ground, preventing you from moving quick enough to get escape.", false);
						}
						//FOR PLAYERS WITH EITHER GIANT HIPS OR BUTT BUT NOT THE BREASTS
						else if (player.hipRating >= 20) {
							outputText("Your " + player.hipDescript() + " swing heavily from side to side ", false);
							if (player.buttRating >= 20) outputText("causing your " + player.skinTone + player.buttDescript() + " to wobble obscenely ", false);
							outputText("and forcing your body into an awkward gait that slows you down, preventing you from escaping.", false);
						}
						//JUST DA BOOTAH
						else if (player.buttRating >= 20) outputText("Your " + player.skinTone + player.buttDescript() + " wobbles so heavily that you're unable to move quick enough to escape.", false);
					}
					//NORMAL RUN FAIL MESSAGES
					else if (monster.plural) outputText(monster.capitalA + monster.short + " stay hot on your heels, denying you a chance at escape!", false);
					else outputText(monster.capitalA + monster.short + " stays hot on your heels, denying you a chance at escape!", false);
				}
			}
			outputText("\n\n", false);
			monster.doAI();
		}
		
	}

}