package classes.Scenes.Monsters
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.*;
import classes.IMutations.IMutationsLib;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class Priscilla extends Goblin
	{
		public var spellCostCharge:int = 6;
		public var spellCostBlind:int = 8;
		public var spellCostWhitefire:int = 12;
		public var spellCostArouse:int = 6;
		public var spellCostHeal:int = 8;
		public var spellCostMight:int = 10;
		
		//Magical specials
		public function castSpell():void {
			var spellChooser:int = rand(6);
			//Makes sure to not stack spell effects.
			if (lust < 50) spellChooser = rand(3);
			if (lust > 75) spellChooser = rand(3) + 3;
			if (spellChooser == 0 && hasStatusEffect(StatusEffects.ChargeWeapon)) {
				spellChooser = rand(5) + 1;
			}
			if (spellChooser == 4 && HPRatio() >= 0.7) {
				spellChooser++;
			}
			if (spellChooser == 5 && statStore.hasBuff("GoblinMight")) {
				spellChooser = rand(5);
				if (spellChooser == 0 && hasStatusEffect(StatusEffects.ChargeWeapon)) spellChooser++;
			}
			//Spell time!
			//Charge Weapon
			if (spellChooser == 0 && mana >= spellCostCharge) {
				outputText("The goblin utters word of power, summoning an electrical charge around her sword. <b>It looks like she'll deal more physical damage now!</b>");
				createStatusEffect(StatusEffects.ChargeWeapon, 15 * spellMultiplier(), 0, 0, 0);
				this.weaponAttack += 15 * spellMultiplier();
				mana -= spellCostCharge;
			}
			//Blind
			else if (spellChooser == 1 && mana >= spellCostBlind) {
				outputText("The goblin glares at you and points at you! A bright flash erupts before you!  ");
				if ((!player.perkv1(IMutationsLib.GorgonEyesIM) >= 1 && rand(player.inte / 5) <= 4) && !player.isImmuneToBlind()) {
					outputText("<b>You are blinded!</b>");
					player.createStatusEffect(StatusEffects.Blind, 1 + rand(3), 0, 0, 0);
				}
				else if (player.perkv1(IMutationsLib.GorgonEyesIM) >= 1) {
					outputText("Your mutated eyes not been affected at all by this flash!");
				}
				else {
					outputText("You manage to blink in the nick of time!");
				}
				mana -= spellCostBlind;
			}
			//Whitefire
			else if (spellChooser == 2 && mana >= spellCostWhitefire) {
				outputText("The goblin narrows her eyes and focuses her mind with deadly intent. She snaps her fingers and you are enveloped in a flash of white flames!  ");
				var damage:int = inte + rand(50) * spellMultiplier();
				if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				player.addStatusValue(StatusEffects.Blizzard, 1, -1);
				outputText("Luckly protective ice maelstorm still surrounding you lessening amount of damage.  ");
				damage *= 0.2;
				}
				if (player.isGoo()) {
					damage *= 1.5;
					outputText("It's super effective! ");
				}
				
				damage = Math.round(damage);
				player.takeFireDamage(damage, true);
				mana -= spellCostWhitefire;
			}
			//Arouse
			else if (spellChooser == 3 && mana >= spellCostArouse) {
				outputText("She makes a series of arcane gestures, drawing on her lust to inflict it upon you! ");
				var lustDamage:int = (inte / 10) + (player.lib / 10) + rand(10) * spellMultiplier();
				player.takeLustDamage(lustDamage, true);
				mana -= spellCostArouse;
			}
			//Heal
			else if (spellChooser == 4 && mana >= spellCostHeal) {
				outputText("She focuses on her body and her desire to end pain, trying to draw on her arousal without enhancing it.");
				var temp:int = int(10 + (inte/2) + rand(inte/3)) * spellMultiplier();
				outputText("She flushes with success as her wounds begin to knit! <b>([font-heal]+" + temp + "[/font])</b>.");
				addHP(temp);
				mana -= spellCostHeal;
			}
			//Might
			else if (spellChooser == 5 && mana >= spellCostMight) {
				outputText("She flushes, drawing on her body's desires to empower her muscles and toughen her up.");
				outputText("The rush of success and power flows through her body.  She feels like she can do anything!");
				this.statStore.addBuffObject({"str":+15 * spellMultiplier(), "tou":+15 * spellMultiplier()},"GoblinMight");
				mana -= spellCostMight;
			}
			else outputText("[Themonster] tries to cast something, but fails miserably. Seems like she's out of mana!");
		}
		
		//Melee specials
		public function slash():void {
			outputText("The goblin charges at you with her sword!  As soon as she approaches you, she swings her sword! ");
			if (player.getEvasionRoll()) {
				outputText("You avoid her slash!");
			}
			else {
				outputText("Her strike connects with you! ");
				//Get hit
				var damage:int = str + weaponAttack + rand(40);
				if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 1) damage += (flags[kFLAGS.PRISCILLA_LVL_UP] + rand(15)) * 4;
				if (damage < 40) damage = 40;
				player.takePhysDamage(damage, true);
			}
		}
		
		public function shieldBash():void {
			outputText("The goblin charges at you with her shield! ");
			if (player.getEvasionRoll()) {
				outputText("You avoid her shield bash!");
			}
			else {
				outputText("Her shield hits you! ");
				//Get hit
				if (rand(100) < 40 && !player.hasPerk(PerkLib.Resolute)) {
					outputText("The impact from the shield has left you with a concussion. <b>You are stunned.</b> ");
					player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				}
				var damage:int = str + rand(10);
				if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 1) damage += flags[kFLAGS.PRISCILLA_LVL_UP] + rand(15);
				if (damage < 10) damage = 10;
				player.takePhysDamage(damage, true);
			}
		}
		
		private function spellMultiplier():Number {
			var mult:Number = 1;
			mult += 0.5 * player.newGamePlusMod();
			return mult;
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.priscillaScene.priscillaDefeated();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.goblinScene.gobboSpecialBeatYaUp();
		}
		
		public function Priscilla()
		{
			if (flags[kFLAGS.PRISCILLA_LVL_UP] < 1) {
				initStrTouSpeInte(115, 95, 80, 120);
				initWisLibSensCor(120, 65, 35, -10);
				this.weaponAttack = 35;
				this.armorDef = 48;
				this.armorMDef = 18;
				this.bonusHP = 900;
				this.bonusLust = 132;
				this.level = 32;
			}
			else if (flags[kFLAGS.PRISCILLA_LVL_UP] == 11) {
				initStrTouSpeInte(335, 205, 278, 340);
				initWisLibSensCor(340, 120, 90, -10);
				this.weaponAttack = 90;
				this.armorDef = 125;
				this.armorMDef = 51;
				this.bonusHP = 2550;
				this.bonusLust = 308;
				this.level = 98;
			}
			else {	//leave min and max levels to easily balance npc combat
				var lvlMulti:Number = flags[kFLAGS.PRISCILLA_LVL_UP];
				initStrTouSpeInte(115 + 20*lvlMulti, 95 + 10*lvlMulti, 80 + 18*lvlMulti, 120 + 20*lvlMulti);
				initWisLibSensCor(120 + 20*lvlMulti, 65 + 5*lvlMulti, 35 + 5*lvlMulti, -10);
				this.weaponAttack = 35 + 5*lvlMulti;
				this.armorDef = 48 + 7*lvlMulti;
				this.armorMDef = 18 + 3*lvlMulti;
				this.bonusHP = 900 + 150*lvlMulti;
				this.bonusLust = 132 + 16*lvlMulti;
				this.level = 32 + 6*lvlMulti;
			}//level up giving 2x all growns and so follow next level ups's as long each npc break lvl 100 (also makes npc use new better gear)
			this.a = "the ";
			this.short = "goblin elder";
			if (flags[kFLAGS.PRISCILLA_TALK_COUNTER] > 0) {
				a = "";
				short = "Priscilla";
			}
			this.imageName = "goblinelder";
			this.long = "The goblin before you stands a little over four feet tall. It's difficult to determine an age of goblin thanks to their corrupt nature but this one looks unusual. Her skin tone is yellowish-green skin and her hair is crimson black. Her body is painted in imp and minotaur blood to scare away anybody who would try to rape her. She's wearing a shark-tooth necklace and her ears are pierced with what appears to be lethicite. Her breasts look to be FF-cups despite her \"age\". Unlike most goblins, she's well armed. She's wielding a crudely fashioned metal sword and a large metal square shield. She's wearing a spider-silk loincloth and the imp skulls hang from the leather strap holding her loincloth together. Her helmet is fashioned out of a minotaur skull and her chestpiece appears to be carved from minotaur ribcage. Her pauldrons are also fashioned from bones. Despite how well-armored she is, her lethicite-pierced nipples are exposed. It's obvious she has traveled quite a lot and slain a lot of minotaurs and imps. She must have lived long thanks to Reducto to keep her breasts at normal size.";
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("FF"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 48;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.bodyColor = "yellowish-green";
			this.hairColor = "dark green";
			this.hairLength = 4;
			this.weaponName = "primal sword";
			this.weaponVerb = "slash";
			this.armorName = "bone armor";
			this.fatigue = 0;
			this.lust = 35;
			this.lustVuln = 0.4;
			this.gems = rand(10) + 40;
			this.drop = new WeightedDrop().
					add(consumables.GOB_ALE, 5).
					add(consumables.REDUCTO,2).
					add(jewelries.POWRRNG,1).
					addMany(1,consumables.L_DRAFT,
							consumables.PINKDYE,
							consumables.BLUEDYE,
							consumables.ORANGDY,
							consumables.GREEN_D,
							consumables.PURPDYE);
			this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 1) this.createPerk(PerkLib.JobWarrior, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 2) this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 3) this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 4) this.createPerk(PerkLib.ManaAffinityI, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 5) this.createPerk(PerkLib.EpicToughness, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 6) this.createPerk(PerkLib.MindOverBodyI, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 7) this.createPerk(PerkLib.LegendaryToughness, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 8) this.createPerk(PerkLib.PrestigeJobSpellKnight, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 9) this.createPerk(PerkLib.EpicLifeline, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 10) this.createPerk(PerkLib.MythicalToughness, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 11) this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			this.abilities = [
				{ call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_WEAPON], weight:2},
				{ call: goblinDrugAttack, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[TAG_FLUID]},
				{ call: goblinTeaseAttack, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[]},
				{ call: castSpell, type: ABILITY_MAGIC, range: RANGE_RANGED, tags:[]},
			];
			checkMonster();
		}
		
	}

}
