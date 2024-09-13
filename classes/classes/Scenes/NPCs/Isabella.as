package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.Scenes.Combat.CombatAbility;
import classes.Scenes.Combat.SpellsWhite.BlindSpell;

public class Isabella extends Monster
	{

		//IZZY AI:

		//Isabella Combat texttttttsss
		public function isabellaAttack():void {
			//[Standard attack]
			outputText("Isabella snorts and lowers a shield a moment before she begins to charge towards you. Her hooves tear huge divots out of the ground as she closes the distance with surprising speed!  ");
			//Determine if dodged!
			if(player.getEvasionRoll()) {
				outputText("You duck aside at the last moment, relying entirely on your speed.\n");
			}
			else {
				var damage:Number;
				if (flags[kFLAGS.ISABELLA_LVL_UP] >= 1) damage = Math.round(((weaponAttack + str + 20) * flags[kFLAGS.ISABELLA_LVL_UP]) - rand(player.tou+player.armorDef));
				else damage = Math.round((weaponAttack + str + 20) - rand(player.tou + player.armorDef));
				if (flags[kFLAGS.ISABELLA_LVL_UP] >= 8) damage *= 0.25;
				if (wrath >= 50) {
					if (flags[kFLAGS.ISABELLA_LVL_UP] >= 14 && wrath >= 400) {
						wrath -= 400;
						damage *= 6;
					}
					else if (flags[kFLAGS.ISABELLA_LVL_UP] >= 10 && wrath >= 300) {
						wrath -= 300;
						damage *= 5;
					}
					else if (flags[kFLAGS.ISABELLA_LVL_UP] >= 6 && wrath >= 200) {
						wrath -= 200;
						damage *= 4;
					}
					else if (flags[kFLAGS.ISABELLA_LVL_UP] >= 2 && wrath >= 100) {
						wrath -= 100;
						damage *= 3;
					}
					else {
						wrath -= 50;
						damage *= 2;
					}
				}
				if (damage < 0) {
					outputText("You brace yourself and catch her shield in both hands, dragging through the dirt as you slow her charge to a stop.  She gapes down, completely awestruck by the show of power.");
				}
				else {
					outputText("She's coming too fast to dodge, and you're forced to try to stop her.  It doesn't work.  Isabella's shield hits you hard enough to ring your ears and knock you onto your back with bruising force. ");
					damage = player.takePhysDamage(damage, true);
					outputText("\n");
				}
			}
		}

		public function isabellaStun():void {
			//[Stunning Impact]
			outputText("Isabella spins her shield back at you in a potent, steel-assisted backhand.  ");
			if(player.getEvasionRoll()) {
				outputText("You duck aside at the last moment, relying entirely on your speed.\n");
			}
			else {
				var damage:Number = 0;
				if (flags[kFLAGS.ISABELLA_LVL_UP] >= 1) damage = Math.round(((weaponAttack + str) * (1 + (flags[kFLAGS.ISABELLA_LVL_UP] * 0.1))) - rand(player.tou+player.armorDef));
				else damage = Math.round((weaponAttack + str) - rand(player.tou+player.armorDef));
				if (flags[kFLAGS.ISABELLA_LVL_UP] >= 8) damage *= 0.25;
				if(damage < 0) {
					outputText("You deflect her blow away, taking no damage.\n");
					damage = 0;
				}
				else if(player.hasPerk(PerkLib.Resolute) && player.tou >= 75) {
					outputText("You resolutely ignore the blow thanks to your immense toughness.\n");
					damage = 0;
				}
				else {
					outputText("You try to avoid it, but her steely attack connects, rocking you back.  You stagger about while trying to get your bearings, but it's all you can do to stay on your feet.  <b>Isabella has stunned you!</b> ");
					damage = player.takePhysDamage(damage, true);
					outputText("\n");
					player.createStatusEffect(StatusEffects.IsabellaStunned,0,0,0,0);
				}
			}
		}

		public function isabellaThroatPunch():void {
			outputText("Isabella punches out from behind her shield in a punch aimed right at your throat!  ");
			//Determine if dodged!
			if(player.getEvasionRoll()) {
				outputText("You duck aside at the last moment, relying entirely on your speed.\n");
			}
			else {
				var damage:Number;
				if (flags[kFLAGS.ISABELLA_LVL_UP] >= 1) damage = Math.round((str * (1 + (flags[kFLAGS.ISABELLA_LVL_UP] * 0.1))) - rand(player.tou+player.armorDef));
				else damage = Math.round(str - rand(player.tou + player.armorDef));
				if (flags[kFLAGS.ISABELLA_LVL_UP] >= 8) damage *= 0.25;
				if(damage <= 0) {
					outputText("You manage to block her with your own fists.\n");
				}
				else if(player.hasPerk(PerkLib.Resolute) && player.tou >= 75) {
					outputText("You resolutely ignore the blow thanks to your immense toughness.\n");
				}
				else {
					outputText("You try your best to stop the onrushing fist, but it hits you square in the throat, nearly collapsing your windpipe entirely.  Gasping and sputtering, you try to breathe, and while it's difficult, you manage enough to prevent suffocation. <b>It will be impossible to focus to cast a spell in this state!</b> ");
					damage = player.takePhysDamage(damage, true);
					outputText("\n");
					player.createStatusEffect(StatusEffects.ThroatPunch,2,0,0,0);
				}
			}
		}

		//[Milk Self-Heal]
		public function drankMalkYaCunt():void {
			outputText("Isabella pulls one of her breasts out of her low-cut shirt and begins to suckle at one of the many-tipped nipples. Her cheeks fill and hollow a few times while you watch with spellbound intensity.  She finishes and tucks the weighty orb away, blushing furiously.  The quick drink seems to have reinvigorated her, and watching it has definitely aroused you.");
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 1) HP += 100 * flags[kFLAGS.ISABELLA_LVL_UP];
			else HP += 100;
			lust += 5;
			player.takeLustDamage((20+player.lib/10), true);
		}

		override public function postPlayerAbility(ability:CombatAbility, display:Boolean = true):void {
			if (ability is BlindSpell && hasStatusEffect(StatusEffects.Blind) && display) {
				if (SceneLib.isabellaFollowerScene.isabellaAccent()) outputText("\n\n\"<i>Nein! I cannot see!</i>\" cries Isabella.");
				else outputText("\n\n\"<i>No! I cannot see!</i>\" cries Isabella.");
			}
		}

		override protected function performCombatAction():void
		{
			//-If below 70% HP, 50% chance of milk drinking
			if (HPRatio() < .7 && rand(2) == 0) drankMalkYaCunt();
			//if PC has spells and isn't silenced, 1/3 chance of silence.
			else if (player.hasSpells() && !player.hasStatusEffect(StatusEffects.ThroatPunch) && rand(3) == 0) {
				isabellaThroatPunch();
			}
			//if PC isn't stunned, 1/4 chance of stun
			else if (!player.hasStatusEffect(StatusEffects.IsabellaStunned) && rand(4) == 0) {
				isabellaStun();
			}
			else isabellaAttack();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.isabellaScene.defeatIsabella();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\n\"<i>Ick,</i>\" Isabella tuts as she turns to leave...");
				SceneLib.combat.cleanupAfterCombatImpl();
			} else {
				SceneLib.isabellaScene.isabellaDefeats();
			}
		}

		public function Isabella()
		{
			this.a = "";
			this.short = "Isabella";
			this.imageName = "isabella";
			this.long = "Isabella is a seven foot tall, red-headed tower of angry cow-girl.  She's snarling at you from behind her massive shield, stamping her hooves in irritation as she prepares to lay into you.  Her skin is dusky, nearly chocolate except for a few white spots spattered over her body.  She wears a tight silk shirt and a corset that barely supports her bountiful breasts, but it's hard to get a good look at them behind her giant shield.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 45, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("EE+"));
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,38,0,0,0);
			this.tallness = 7*12+6;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.bodyColor = "dusky";
			this.hairColor = "red";
			this.hairLength = 13;
			var lvlMulti:Number = flags[kFLAGS.ISABELLA_LVL_UP];
			if (flags[kFLAGS.ISABELLA_LVL_UP] < 1) {
				initStrTouSpeInte(210, 265, 180, 128);
				initWisLibSensCor(128, 128, 50, -20);
				this.weaponAttack = 90;
				this.armorDef = 160;
				this.armorMDef = 40;
				this.bonusHP = 1200;
				this.bonusLust = 210;
				this.level = 32;
			}
			else if (flags[kFLAGS.ISABELLA_LVL_UP] <= 15) {	//leave min and max levels to easily balance npc combat
				initStrTouSpeInte(210 + 40*lvlMulti, 265 + 50*lvlMulti, 180 + 30*lvlMulti, 128 + 18*lvlMulti);
				initWisLibSensCor(128 + 18*lvlMulti, 128 + 10*lvlMulti, 50 + 5*lvlMulti, -20);
				this.weaponAttack = 90 + 15*lvlMulti;
				this.armorDef = 160 + 80*lvlMulti;
				this.armorMDef = 40 + 20*lvlMulti;
				this.bonusHP = 1200 + 400*lvlMulti;
				this.bonusLust = 210 + 21*lvlMulti;
				this.level = 32 + 6*lvlMulti;
			}
			else if (flags[kFLAGS.ISABELLA_LVL_UP] == 16) {
				initStrTouSpeInte(850, 1065, 660, 416);
				initWisLibSensCor(416, 288, 130, -20);
				this.weaponAttack = 330;
				this.armorDef = 1420;
				this.armorMDef = 360;
				this.bonusHP = 7600;
				this.bonusLust = 546;
				this.level = 128;
			}
			this.weaponName = "giant shield";
			this.weaponVerb="smash";
			this.armorName = "giant shield";
			this.armorPerk = "";
			this.armorValue = 70;
			this.lust = 30;
			this.lustVuln = .35;
			this.gems = rand(10) + 25;
			this.tailType = Tail.COW;
			this.tailRecharge = 0;
			this.noFetishDrop = true;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.JobWarrior, 0, 0, 0, 0);
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 1) this.createPerk(PerkLib.Lifeline, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 2) {
				this.createPerk(PerkLib.BasicTranquilness, 0, 0, 0, 0);
				this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 3) this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 4) {
				this.createPerk(PerkLib.HalfStepToImprovedTranquilness, 0, 0, 0, 0);
				this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 5) this.createPerk(PerkLib.ImprovedLifeline, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 6) {
				this.createPerk(PerkLib.ImprovedTranquilness, 0, 0, 0, 0);
				this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 7) this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 8) {
				this.createPerk(PerkLib.HalfStepToAdvancedTranquilness, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicToughness, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 9) this.createPerk(PerkLib.GreaterLifeline, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 10) {
				this.createPerk(PerkLib.AdvancedTranquilness, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicStrength, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 11) this.createPerk(PerkLib.LegendaryToughness, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 12) {
				this.createPerk(PerkLib.HalfStepToSuperiorTranquilness, 0, 0, 0, 0);
				this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);//lvl 104
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 13) this.createPerk(PerkLib.EpicLifeline, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 14) {
				this.createPerk(PerkLib.SuperiorTranquilness, 0, 0, 0, 0);
				this.createPerk(PerkLib.LegendaryStrength, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 15) this.createPerk(PerkLib.JobKnight, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 16) {
				this.createPerk(PerkLib.HalfStepToPeerlessTranquilness, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobBrawler, 0, 0, 0, 0);
			}
			checkMonster();
		}
		
	}

}
