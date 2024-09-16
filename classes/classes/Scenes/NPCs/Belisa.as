/**
 * ...
 * @author Canadian Snas
 */
package classes.Scenes.NPCs
{
import classes.Appearance;
import classes.AssClass;
import classes.BodyParts.Butt;
import classes.BodyParts.Ears;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kFLAGS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.Combat;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.Scenes.NPCs.BelisaFollower;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;


public class Belisa extends Monster
	{
		private function spellCostWhitefire():Number {
			var cost:Number = 30;
			return cost;
		}
		private function spellCostHeal():Number {
			var cost:Number = 30;
			if (hasPerk(PerkLib.NaturalHealingMinor)) cost -= 3;
			if (hasPerk(PerkLib.NaturalHealingMajor)) cost -= 4.5;
			if (hasPerk(PerkLib.WisenedHealer)) cost *= 2;
			return cost;
		}
		
		private function HealMod():Number {
			var mod1:Number = 1;
			if (hasPerk(PerkLib.SpellpowerHealing)) mod1 += .2;
			if (hasPerk(PerkLib.NaturalHealingMinor)) mod1 += .3;
			if (hasPerk(PerkLib.NaturalHealingMajor)) mod1 += .4;
			return mod1;
		}
		private function SpellMod():Number {
			var mod2:Number = 1;
			if (hasPerk(PerkLib.Spellpower)) mod2 += .1;
			if (hasPerk(PerkLib.Channeling)) mod2 += .2;
			if (hasPerk(PerkLib.JobSorcerer)) mod2 += .1;
			return mod2;
		}
		
		private function belisaBasicAttack():void {
			var slashes:String = "six";
			if (flags[kFLAGS.BELISA_LVL_UP] >= 2) slashes = "eight";
			if (flags[kFLAGS.BELISA_LVL_UP] >= 4) slashes = "ten";
			if (flags[kFLAGS.BELISA_LVL_UP] >= 6) slashes = "twelve";
			if (flags[kFLAGS.BELISA_LVL_UP] >= 8) slashes = "fourteen";
			outputText("The nimble drider-girl leaps towards you. You raise your [weapon] to intercept, but she shoots a web above and into the trees with a sharp thwip, nimbly evading your block. She gets inside your guard. \"<i>Hya, Hya! Heeeyah!!</i>\" She slashes "+slashes+" times, cutting cleanly through your [color] [skin.type] before leaping backwards and out of your reach. Blood begins to flow from your injuries.");
			var bleedP:Number = 0.05;
			var dmg0:Number = 0;
			dmg0 += this.str;
			dmg0 += eBaseStrengthDamage();
			dmg0 += this.weaponAttack;
			dmg0 = Math.round(dmg0 * 0.8);
			player.takePhysDamage(dmg0, true);
			player.takePhysDamage(dmg0, true);
			player.takePhysDamage(dmg0, true);
			player.takePhysDamage(dmg0, true);
			player.takePhysDamage(dmg0, true);
			player.takePhysDamage(dmg0, true);
			if (flags[kFLAGS.BELISA_LVL_UP] >= 2) {
				player.takePhysDamage(dmg0, true);
				player.takePhysDamage(dmg0, true);
				bleedP += 0.01;
			}
			if (flags[kFLAGS.BELISA_LVL_UP] >= 4) {
				player.takePhysDamage(dmg0, true);
				player.takePhysDamage(dmg0, true);
				bleedP += 0.01;
			}
			if (flags[kFLAGS.BELISA_LVL_UP] >= 6) {
				player.takePhysDamage(dmg0, true);
				player.takePhysDamage(dmg0, true);
				bleedP += 0.01;
			}
			if (flags[kFLAGS.BELISA_LVL_UP] >= 8) {
				player.takePhysDamage(dmg0, true);
				player.takePhysDamage(dmg0, true);
				bleedP += 0.01;
			}
			if (!player.immuneToBleed()) {
				if (player.hasStatusEffect(StatusEffects.Hemorrhage)) player.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
				else player.createStatusEffect(StatusEffects.Hemorrhage, SceneLib.combat.debuffsOrDoTDuration(2 + rand(2)), bleedP, 0, 0);
			}
		}
		
		private function belisaWebAttack():void {
			outputText("\"<i>"+(player.hasStatusEffect(StatusEffects.SparingBelisa)?"Slow down":"Leave me alone")+"!</i>\" She yells in her high-pitched voice, spraying a wide swathe of webbing at you. It sticks to your [skin.type] like glue.");
			//Determine if dodged!
			if (player.getEvasionRoll()) {
				outputText("You dodge away, avoiding the sticky strands!");
			}
			//Got hit
			else {
				if (player.buff("Web").isPresent()) {
					outputText("The silky strands hit you, weighing you down and restricting your movement even further.\n");
					player.buff("Web").addStats( {"spe":-25} ).withText("Web").combatPermanent();
				}
				else {
					outputText("The silky strands hit you, webbing around you and making it hard to move with any degree of speed.");
					if (player.canFly()) outputText("  Your wings struggle uselessly in the bindings, no longer able to flap fast enough to aid you.");
					outputText("\n");
					player.buff("Web").addStats( {"spe":-25} ).withText("Web").combatPermanent();
				}
			}
		}
		
		private function belisaWhitefire():void {
			outputText("\"<i>"+(player.hasStatusEffect(StatusEffects.SparingBelisa)?"Eat flames!":"Corruption? Burn")+"!</i>\" She squeaks, and a sudden burst of white fire engulfs you. You hold your breath, turning your [face] away and closing your [eyes]. ");
			if (player.cor < 15) {
				outputText("You take no damage from the cleansing flame, and she stares at you, absolutely baffled. \"<i>Wh-what? H-how?! You’re Pure?!</i>\"");
				if (BelisaFollower.BelisaEncounternum == 2) BelisaFollower.BelisaEncounternum = 3;
			}
			else {
				outputText("The fire burns your flesh, but you remain standing afterward. The spider-girl in front of you takes a half-step back, bringing one hand to her breast. \"<i>You...You’re still standing?</i>\"");
				var damage:int = 4 * inteligencescalingbonus() * SpellMod();
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
			}
			mana -= spellCostWhitefire();
			createStatusEffect(StatusEffects.AbilityCooldown1, 2, 0, 0, 0);
		}
		
		private function belisaHeal():void {
			outputText("She puts her hands together, and you notice the telltale sign of holy magic coursing through her body. The injuries you left on her chitin begin to close, and an aura of health surrounds Belisa’s body. The light from within lights up the silk, temporarily letting you see right through it. Your eyes are drawn to her petite breasts, pressed gently together by her folding arms, and she opens her eyes, realizing what you can see. \"<i>Pervert!</i>\" She yells, letting the light fade.");
			var temp:Number = 0;
			temp += inteligencescalingbonus() * 2;
			if (hasPerk(PerkLib.WisenedHealer)) temp += wisdomscalingbonus() * 2;
			temp *= HealMod();
			temp = Math.round(temp);
			addHP(temp);
			mana -= spellCostHeal();
			createStatusEffect(StatusEffects.AbilityCooldown2, 2, 0, 0, 0);
			var lustDang:Number = 15 + rand(15);
			player.takeLustDamage(lustDang, true);
		}
		
		override protected function performCombatAction():void
		{
			if (BelisaFollower.BelisaEncounternum == 3 && Combat.playerWaitsOrDefends()) SceneLib.belisa.postFightOptionsWhitefireWait();
			var choice0:Number = rand(4);
			switch (choice0) {
				case 0:
					belisaBasicAttack();
					break;
				case 1:
					belisaWebAttack();
					break;
				case 2:
					if (mana >= spellCostWhitefire() && !hasStatusEffect(StatusEffects.AbilityCooldown1)) belisaWhitefire();
					else belisaBasicAttack();
					break;
				case 3:
					if (HPRatio() < .8 && (mana >= spellCostHeal()) && !hasStatusEffect(StatusEffects.AbilityCooldown2)) belisaHeal();
					else belisaWebAttack();
					break;
				default:
					belisaBasicAttack();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.belisa.BelisaHangSparWon(hpVictory);
		}
		
		override public function get long():String
		{
			var str:String = "";
			str += "Facing you is Belisa in a silk robe and Sunhat. Her backmost legs are off the ground, rubbing together nervously, but the ornate daggers in her hands smell like blood, and her abdomen is raised, ready to spit string.";
			if (BelisaFollower.BelisaQuestComp) str += " Her fangs glint dangerously in the light, and she smiles despite her situation. She seems eager to bite.";
			else str += " The one fang of hers you can see is dripping a clear venom, but her sunhat covers most of her face, hiding her eyes from you.";
			return str;
		}
		
		public function Belisa()
		{
			if (flags[kFLAGS.BELISA_LVL_UP] < 1) {
				initStrTouSpeInte(80, 90, 100, 250);
				initWisLibSensCor(100, 80, 100, -100);
				this.weaponAttack = 60;
				this.armorDef = 60;
				this.armorMDef = 200;
				this.bonusHP = 200;
				this.bonusLust = 200;
				this.level = 20;
			}
			if (flags[kFLAGS.BELISA_LVL_UP] >= 1 && flags[kFLAGS.BELISA_LVL_UP] < 8) {
				var mod:int = flags[kFLAGS.BELISA_LVL_UP];
				initStrTouSpeInte(80 + 6*mod, 90 + 8*mod, 100 + 10*mod, 250 + 15*mod);
				initWisLibSensCor(100 + 10*mod, 80 + 5*mod, 100 + 5*mod, -100);
				this.weaponAttack = 60 + 3*mod;
				this.armorDef = 60 + 3*mod;
				this.armorMDef = 200 + 10*mod;
				this.bonusHP = 200 + 25*mod;
				this.bonusLust = 200 + 16*mod;
				this.level = 20 + 6*mod;
			}
			if (flags[kFLAGS.BELISA_LVL_UP] == 8) {
				initStrTouSpeInte(130, 154, 180, 370);
				initWisLibSensCor(180, 120, 140, -100);
				this.weaponAttack = 84;
				this.armorDef = 84;
				this.armorMDef = 280;
				this.bonusHP = 400;
				this.bonusLust = 328;
				this.level = 68;
			}
			this.a = "";
			this.short = "Belisa";
			this.imageName = "puredrider";
			this.long = "";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity,100,0,0,0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,100,0,0,0);
			this.tallness = 8*12+5;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.bodyColor = "pale";
			this.hairColor = "black";
			this.hairLength = 24;
			this.weaponName = "daggers";
			this.weaponVerb="slash";
			this.armorName = "silken robe";
			this.lustVuln = .2;
			this.gems = rand(10) + 20;
			this.drop = new WeightedDrop().add(consumables.B_GOSSR,1)
					.add(useables.T_SSILK,3)
					.add(null,5);
			this.ears.type = Ears.HUMAN;
			this.lowerBody = LowerBody.DRIDER;
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
			this.createPerk(PerkLib.Spellpower, 0, 0, 0, 0);
			this.createPerk(PerkLib.Channeling, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobHealer, 0, 0, 0, 0);
			this.createPerk(PerkLib.BasicSpirituality, 0, 0, 0, 0);
			if (flags[kFLAGS.BELISA_LVL_UP] >= 1) {
				this.createPerk(PerkLib.HalfStepToImprovedSpirituality, 0, 0, 0, 0);
				this.createPerk(PerkLib.WisenedHealer, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.BELISA_LVL_UP] >= 2) this.createPerk(PerkLib.ImprovedSpirituality, 0, 0, 0, 0);
			if (flags[kFLAGS.BELISA_LVL_UP] >= 3) {
				this.createPerk(PerkLib.HalfStepToAdvancedSpirituality, 0, 0, 0, 0);
				this.createPerk(PerkLib.SpellpowerHealing, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.BELISA_LVL_UP] >= 4) this.createPerk(PerkLib.AdvancedSpirituality, 0, 0, 0, 0);
			if (flags[kFLAGS.BELISA_LVL_UP] >= 5) {
				this.createPerk(PerkLib.HalfStepToSuperiorSpirituality, 0, 0, 0, 0);
				this.createPerk(PerkLib.NaturalHealingMinor, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.BELISA_LVL_UP] >= 6) this.createPerk(PerkLib.SuperiorSpirituality, 0, 0, 0, 0);
			if (flags[kFLAGS.BELISA_LVL_UP] >= 7) {
				this.createPerk(PerkLib.HalfStepToPeerlessSpirituality, 0, 0, 0, 0);
				this.createPerk(PerkLib.NaturalHealingMajor, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.BELISA_LVL_UP] >= 8) this.createPerk(PerkLib.PeerlessSpirituality, 0, 0, 0, 0);
			checkMonster();
		}
	}
}
