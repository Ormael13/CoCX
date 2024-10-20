/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.EbonLabyrinth 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;
import classes.Scenes.Combat.CombatAbility;
import classes.Scenes.Combat.SpellsWhite.BlindSpell;

import coc.view.CoCButton;

use namespace CoC;

	public class Draculina extends Monster
	{
		private var _biteCounter:int = 0;
		private var _sonicScreamCooldown:int = 0;

		override public function combatStatusesUpdateWhenBound():void{
			nagaBindUpdateWhenBound();
		}

		override public function playerBoundStruggle():Boolean{clearOutput();
			if (rand(3) == 0 || rand(80) < player.str / 1.5 || player.hasPerk(PerkLib.FluidBody)) {
				outputText("You wriggle and squirm violently, tearing yourself out from within [themonster]'s coils.");
				player.removeStatusEffect(StatusEffects.PlayerBoundPhysical);
			} else {
				outputText("The [monster name]'s grip on you tightens as you struggle to break free from the stimulating pressure.");
				player.takeLustDamage(player.effectiveSensitivity() / 10 + 2, true);
				player.takePhysDamage(20 + rand(18));
			}
			return true;
		}

		override public function playerBoundWait():Boolean{
			return nagaBindWait();
		}

		override public function postPlayerBusyBtnSpecial(btnSpecial1:CoCButton, btnSpecial2:CoCButton):void{
			if (player.hasStatusEffect(StatusEffects.MonsterInvisible)) {
				if (player.hasStatusEffect(StatusEffects.KnowsBlind) && ((!player.hasPerk(PerkLib.BloodMage) && player.mana >= 30) || (player.hasStatusEffect(StatusEffects.BloodMage) && ((player.HP + 30) > (player.minHP() + 30))))) {
					btnSpecial1.show("Blind", dispellDarkness1);
				}
				if (player.hasStatusEffect(StatusEffects.KnowsSunrise) && ((!player.hasStatusEffect(StatusEffects.BloodCultivator) && player.soulforce >= 400) || (player.hasStatusEffect(StatusEffects.BloodCultivator) && ((player.HP + 400) > (player.minHP() + 400))))) {
					btnSpecial2.show("Sunrise", dispellDarkness2);
				}
			}
		}
		
		public function dispellDarkness1():void {
			clearOutput();
			outputText("You glare at point near you.  A bright flash erupts there!\n");
			dispellDarkness(1);
		}
		public function dispellDarkness2():void {
			clearOutput();
			outputText("You point finger at spot near you.  A miniature sun appears there!\n");
			dispellDarkness(2);
		}
		public function dispellDarkness(choice:Number):void {
			outputText("The light counters the smothering darkness, breaking the spell and bringing light back the area. [Themonster], who was about to viciously attack you from behind, swiftly backs out of range and flies off.\n\n");
			outputText("\"<i>Umph you broke free… No matter, your defeat is but a matter of time.</i>\"\n");
			createStatusEffect(StatusEffects.Blind, Math.min(2 + player.inte / 20, 10), 0, 0, 0);
			player.removeStatusEffect(StatusEffects.MonsterInvisible);
			if (!hasStatusEffect(StatusEffects.AbilityCooldown1) || statusEffectv1(StatusEffects.AbilityCooldown1) < 3) {
				removeStatusEffect(StatusEffects.AbilityCooldown1);
				createStatusEffect(StatusEffects.AbilityCooldown1, 3, 0, 0, 0);
			}
			EngineCore.doNext(SceneLib.combat.combatMenu);
			if (choice == 1) {
				if (game.player.hasStatusEffect(StatusEffects.BloodMage)) game.player.HP -= 30;
				else game.player.mana -= 30;
				flags[kFLAGS.SPELLS_CAST]++;
				SceneLib.combat.spellPerkUnlock();
			}
			if (choice == 2) {
				if (game.player.hasStatusEffect(StatusEffects.BloodCultivator)) game.player.HP -= 400;
				else game.player.soulforce -= 400;
			}
			EngineCore.statScreenRefresh();
            SceneLib.combat.enemyAIImpl();
		}

		/*override public function postPlayerAbility(ability:CombatAbility, display:Boolean = true):void {
			if (ability is BlindSpell && hasStatusEffect(StatusEffects.Blind)) {
				if (display) {
					outputText("The light counters the smothering darkness, breaking the spell and bringing light back the area." + 
						" [Themonster], who was about to viciously attack you from behind, swiftly backs out of range and flies off.\n\n");
					outputText("\"<i>Umph you broke free… No matter, your defeat is but a matter of time.</i>\"\n");
				}
				player.removeStatusEffect(StatusEffects.MonsterInvisible);
				//When forcibly removed, Darkness cannot be reapplied for 3 turns
				if (!hasStatusEffect(StatusEffects.AbilityCooldown1) || statusEffectv1(StatusEffects.AbilityCooldown1) < 3) {
					removeStatusEffect(StatusEffects.AbilityCooldown1);
					createStatusEffect(StatusEffects.AbilityCooldown1, 3, 0, 0, 0);
				}
			}
		}*/
		
		private function draculinaEmbrace():void {
			if (!player.getEvasionRoll()) {
				player.createStatusEffect(StatusEffects.PlayerBoundPhysical, 0, 0, 0, 0);
				outputText("The arch vampire closes her wings, blurring with speed as she arrows towards you. Her body collides with you, the impact sending you reeling, and she wraps her limbs around you, locking you in a cold embrace!");
				if (EngineCore.silly()) outputText("  Bad touch, bad touch!");
			} else {
				outputText("The arch vampire folds her wings, hurtling down towards you, her mouth open wide. She spreads her arms, intending to grab you, but you dodge to one side, forcing her to extend her wings again or crash.");
			}
		}
		
		public function draculinaBite():void {
			if (player.isGargoyle()) {
				outputText("[Themonster] tries to bite you, but quickly steps back, holding a hand to her mouth with a surprised yelp of clear pain. You smirk, amused by her stupidity, did she seriously try to bite your stone skin?");
				takePhysDamage(maxHP() * .1);
			} else if (player.isAlraune()) {
				outputText("[Themonster] tries to bite you but, just as her fang pierce your skin, she shoves you off and starts spitting."
					+ "\n\n"
					+ "\"<i>Your blood tastes like sap and flower nectar. How disgusting! How dare you bear such vile ichors.</i>\""
					+ "\n\n"
					+ "Should you be offended by her reaction? You should be grateful that plant sap is not her favorite.");
				takePhysDamage(10);
			} else {
				addHP(maxHP() * .05);
				var dam:int = this.str * 5;
				for (var i:int = 0; i < _biteCounter; i++) {
					dam += dam * .10;
				}
				_biteCounter++;
				outputText("The arch vampire bites into your neck and begins drinking her fill. The loud slurping noises she’s exuding is hardly a pleasant noise for such an intimate act. Weirdly enough you feel aroused from this despite the pain.");
				if (silly()) outputText(" You masochist, you.");
				dam = Math.round(dam);
				player.takePhysDamage(dam);
				player.takeLustDamage(10 + rand(9), true);
				if (!player.hasStatusEffect(StatusEffects.AlterBindScroll3)) {
					var drain:Number = Math.round(player.touStat.max * 0.05);
					player.saveHPRatio();
					player.buff("Bat bites").addStats({"tou":-drain}).withText("Bat bites!").combatPermanent();
					player.restoreHPRatio();
					showStatDown( 'tou' );
					if (player.tou <= 1) {
						doNext(SceneLib.combat.endHpLoss);
						return;
					}
				}
			}
		}
		
		private function draculinaBatSwarm():void {
			outputText("The hungry bat swarm bites and scratches at you, draining precious lifeblood out of your system!\n\n");
			this.HP += Math.round(this.maxHP()*0.02);
			if (!player.hasStatusEffect(StatusEffects.AlterBindScroll3)) {
				var drain:Number = Math.round(player.touStat.max * 0.05);
				player.saveHPRatio();
				player.buff("Bat bites").addStats({"tou":-drain}).withText("Bat bites!").combatPermanent();
				player.restoreHPRatio();
				showStatDown( 'tou' );
				if (player.tou <= 1) {
					doNext(SceneLib.combat.endHpLoss);
					return;
				}
			}
		}
		
		private function draculinaSonicScream():void {
			var damage:Number = 0;
			damage += inteligencescalingbonus()+eBaseToughnessDamage()+this.lib;
			damage = Math.round(damage);
			outputText("She suddenly lets out an agonising screech which echoes through the entire room, forcing you to reflexively try to cover your ears with your hands, dropping your weapons in the process and still staggering you despite your efforts. ");
			player.takePhysDamage(damage);
			if (!player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
			outputText("\n\n");
			_sonicScreamCooldown = 10;
		}
		
		private function draculinaPerfectDark():void {
			outputText("\"<i>Let us see how thou fight without this precious light of yours!</i>\""
            + "\n\n"
            + "[Themonster] lands, opening her wings wide as all light is suddenly sucked in within their fold, leaving you in complete darkness. You can’t see your own weapon, let alone your batty adversary. There is no way you can fight a foe this agile in magical darkness. You’ll need to light the place up to fight properly!");
			player.createStatusEffect(StatusEffects.MonsterInvisible, 0, 0, 0, 0);
			createStatusEffect(StatusEffects.AbilityCooldown1, 15, 0, 0, 0);
			removeStatusEffect(StatusEffects.Blind);
		}
		
		override protected function performCombatAction():void
		{
			if (_sonicScreamCooldown > 0) {
				_sonicScreamCooldown--;
			}
			if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) {
				player.removeStatusEffect(StatusEffects.MonsterInvisible);
				draculinaPerfectDark();
			}
			if (player.statStore.hasBuff("FoxflamePelt")) {
				player.removeStatusEffect(StatusEffects.MonsterInvisible);
			}
			if (player.hasStatusEffect(StatusEffects.PlayerBoundPhysical)) {
				draculinaBite();
			} else {
				var choice:Number = rand(3);
				if (choice == 0) {
					draculinaEmbrace();
				}
				if (choice == 1) {
					if (!player.hasStatusEffect(StatusEffects.MonsterInvisible) && !hasStatusEffect(StatusEffects.AbilityCooldown1)) draculinaPerfectDark();
					else draculinaBatSwarm();
				}
				if (choice == 2) {
					if (_sonicScreamCooldown == 0) draculinaSonicScream();
					else draculinaBatSwarm();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.ebonlabyrinth.draculinaScene.defeat();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.ebonlabyrinth.draculinaScene.defeatedBy();
		}
		/*
		override public function get long():String
		{
			var str:String = "";
			str += "Your fighting a… Just what the actual fuck are you fighting actually! This thing is a nightmarish combo between a giant spider and a tentacle beast except it lacks the dick and pussy instead settling for a tentacled face barely hiding two fangs dripping with venom. ";
			str += "The creature black carapace seems to be covered in blinking red eyes watching and blinking. Everything about this horror screams madness and a terrible end should it manage to overpower you, the many silk cocoons in the chamber can attest to that!";
			return str;
		}
		*/
		public function Draculina() 
		{
			//scaled from 65 now, reduced base stats to compensate
			var mod:int = inDungeon ? SceneLib.dungeons.ebonlabyrinth.enemyLevelMod : 3;
            initStrTouSpeInte(140 + 40*mod, 280 + 45*mod, 142 + 31*mod, 81 + 23*mod);
            initWisLibSensCor(81 + 23*mod, 280 + 30*mod, 90 + 40*mod, 100);
            this.armorDef = 70 + 70*mod;
            this.armorMDef = 100 + 100*mod;
            this.bonusHP = mod == 0 ? 0 : 2000*(mod-1);
            this.bonusLust = 430 + 75*mod;
            this.level = 60 + 5*mod; //starts from 65 due to EL levelMod calculations;
            this.gems = mod > 20 ? 0 : Math.floor((1500 + rand(300)) * Math.exp(0.3*mod));
            this.additionalXP = mod > 20 ? 0 : Math.floor(6500 * Math.exp(0.3*mod));
            
			this.a = "";
			this.short = "Draculina";
			this.long = "";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 10*12+10;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_NOTICEABLE + 1;
			this.weaponName = "fangs";
			this.weaponVerb = "bite";
			this.armorName = "skin";
			this.lustVuln = 0.45;
			this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			this.createPerk(PerkLib.DarknessNature, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.drop = new WeightedDrop(consumables.VAMPBLD, 1);
			this.checkMonster();
		}
	}
}