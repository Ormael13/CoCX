/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.Scenes.SceneLib;

	public class SiegweirdBoss extends Monster
	{

		//Revenant’s fury: Every 5 turns Siegweird will attempt to empower himself. He channels for 2 rounds and if uninterrupted gain +40% damage for the battle duration.
		private var revenantFuryReady:Boolean = false;
		private var revenantFuryMod:Number = 1;
		override public function interruptAbility():void {
			if (revenantFuryReady) revenantFuryReset();
		}

		private function revenantFuryReset():void {
			revenantFuryReady = false;
			createStatusEffect(StatusEffects.AbilityCooldown1, 5, 0, 0, 0);
		}
		private function revenantFuryCharge():void {
			outputText("Siegweird begins gathering energy, it might be wise to stop him.");
			revenantFuryReady = true;
		}
		private function revenantFuryExplode():void {
			outputText("Siegweird’s aura explodes, sending you flying as unholy power covers his form. The holy vengeance he radiates is even deadlier than before.");
			revenantFuryMod += 0.4;
			var damage:int = (inte + 400 + rand(100)) * (1 + player.newGamePlusMod()) * revenantFuryMod;
			damage = player.takeFireDamage(damage, true);
			revenantFuryReset();
		}

		private function multiAttack():void {
			var hit:Boolean = false;
			var damageTotal:int = 0;
			for (var i:int = 0; i < 5; ++i) {
				outputText("\nSiegweird slashes at you wildly with his sword, leaping around at light speed.");
				if (player.getEvasionRoll()) outputText(" You somehow manage to evade the strike!");
				else {
					var damage:int = eBaseDamage() * (1 + player.newGamePlusMod()) * revenantFuryMod;
					damage = player.takePhysDamage(damage, true);
					damageTotal += damage;
					hit = true;
				}
			}
			if (hit) {
				var heal:int = damageTotal * 10;
				if (HP + heal > maxOverHP()) heal = maxOverHP() - HP;
				HP += heal;
				outputText("\n\nEach blow he lands seems to heal his wounds as if he drained the life out of you to replenish his own! <b>([font-heal]+" + heal + "[/font])</b>.\n\n");
			}
		}

		//Strangulate: If player spell casts twice in a row Sieg will grapple the player with vengeful magic and start choking them. This prevents spellcasting and deals 25% of the players health per round.
		public var castedSpellThisTurn:Boolean = false;
		public var castedSpellLastTurn:Boolean = false;

		private function strangulate():void {
			outputText("Siegweird lifts his hand and a blazing halo quickly wraps around you and throws you to him. He grabs you by the neck and starts squeezing.");
			player.createStatusEffect(StatusEffects.SiegweirdGrapple, 0, 0, 0, 0);
			strangleDamage();
		}
		public function siegweirdStruggle():void {
			clearOutput();
			outputText("You try to struggle and get away from the bear..  ");
			if (rand(player.str * 2) > str || player.hasPerk(PerkLib.FluidBody)) {
				outputText("You manage to break out of Siegweird’s death grip\n\n");
				player.removeStatusEffect(StatusEffects.SiegweirdGrapple);
			}
			else outputText("Despite your valiant efforts, you can't get away at all - he still holds you tightly!\n\n");
		}

		private function strangleDamage():void {
			var damage:int = player.maxHP() * 0.25;
			player.takePhysDamage(damage, true);
		}

		//Defy pain: Sieg gains damage reduction physical +90% for 5 rounds.
		private function defyPain():void {
			outputText("Fiery runes appear on Siegweird’s armor.");
			createStatusEffect(StatusEffects.PhysicalResist, 0.9, 5, 0, 0);
		}

		//Defy magic: Sieg gains resistance to all elements for 5 rounds.
		private function defyMagic():void {
			outputText("Divine runes appear on Siegweird’s armor.");
			createStatusEffect(StatusEffects.ElementalResist, 1, 5, 0, 0);
		}

		private var haloTurnsLeft:int = 0;
		public function immolatingHalo():void {
			outputText("Siegweird channels the flames of divine vengeance as a fiery halo manifests itself above him, burning brightly. It wicks with violent flames, ready to lash out against the impure.");
			haloTurnsLeft = 2;
		}

		public function damageReaction(damageReceived:int = 0):void {
			if (haloTurnsLeft > 0) {
				var mul:int = maxHP() / (maxHP() - HP + 1);
				if (mul > 10) mul = 10;
				var damage:int = damageReceived * 0.1 + (tou + inte) * 2 * mul;
				outputText("As you strike Siegweird, his fiery halo lashes out, searing your flesh with divine judgement! ");
				player.takeMagicDamage(damage, true);
			}
		}

		private var devourUsed:Boolean = false;
		public function devourLife():void {
			devourUsed = true;
			outputText("“<i>I WILL NOT STOP, I WILL NOT REST UNTIL YOU ARE DRAINED OF EVERY LAST OUNCE OF LIFE. YOU WILL KNOW  MY NAME, FOR IT IS SAERUS!</i>”\n"
				+ "\n"
				+ "Siegweird cries, radiating vengeful fury when you feel your essence drawn to his raised sword! He leaves you on the brink of death and you see him recover as a result of this leeching magic. However, the spell leaves him staggered and wide open. ");
			var damage:int = player.HP - 1;
			player.HP = 1;
			HP += damage;
			createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		}

		override public function doAI():void {
			if (hasStatusEffect(StatusEffects.PhysicalResist)) addStatusValue(StatusEffects.PhysicalResist, 2, -1);
			if (statusEffectv2(StatusEffects.PhysicalResist) <= 0) removeStatusEffect(StatusEffects.PhysicalResist);
			if (hasStatusEffect(StatusEffects.ElementalResist)) addStatusValue(StatusEffects.ElementalResist, 2, -1);
			if (statusEffectv2(StatusEffects.ElementalResist) <= 0) removeStatusEffect(StatusEffects.ElementalResist);
			if (haloTurnsLeft > 0) --haloTurnsLeft;
			super.doAI();
		}

		override protected function performCombatAction():void {
			var readyToStrangle:Boolean = castedSpellLastTurn && castedSpellThisTurn;
			castedSpellLastTurn = castedSpellThisTurn;
			castedSpellThisTurn = false;
			//If channeling
			if (revenantFuryReady) revenantFuryExplode();
			//HEAL NOOOOW. Not stunned
			else if (HP < maxHP() * 0.1) devourLife();
			//grapple checks
			else if (player.hasStatusEffect(StatusEffects.SiegweirdGrapple)) {
				outputText("  Siegweird slowly strangles you.");
				strangleDamage();
			}
			else if (readyToStrangle) strangulate();
			//can channel
			else if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) revenantFuryCharge();
			//other actions
			else {
				var actions:Array = [];
				if (!hasStatusEffect(StatusEffects.PhysicalResist)) actions.push(defyPain);
				if (!hasStatusEffect(StatusEffects.ElementalResist)) actions.push(defyMagic);
				if (haloTurnsLeft == 0) actions.push(immolatingHalo);
				actions.push(multiAttack, multiAttack, multiAttack);
				actions[rand(actions.length)]();
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			//can regenerate once even if stunned
			if (!devourUsed || !monsterIsStunned() && !hasStatusEffect(StatusEffects.Fear) && !monsterIsConstricted()) {
				devourLife();
				doNext(SceneLib.combat.combatMenu, false);
			} else SceneLib.alvinaFollower.marriagePostFight();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.siegweirdFollower.siegweirdFirstEncounterPostFightAnotherFightLost();
		}
		
		public function SiegweirdBoss()
		{
			this.a = "";
			this.short = "Siegweird of Catelyna";
			this.imageName = "siegweird";
			this.long = "Siegweird, for it is indeed Siegweird, the knight you killed at Alvina’s request, is pointing his sword at you. His armor looks corroded and burnt, black fluid seeps through the damaged armor. How the knight managed to come back from the grave is a mystery but the holy fury he's radiating is all the warning you need to know that he will not stop until he has slaughtered everyone here." + (silly() ? "\n\nAt least, the knight is not hollow." : "");
			// this.plural = false;
			this.createCock(7.5,1.8);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 1;
			this.hoursSinceCum = 10000;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 7*12+6;
			this.skin.growFur({color:"tawny"});
			this.hairColor = "brown";
			this.hairLength = 5;
			initStrTouSpeInte(475, 405, 340, 330);
			initWisLibSensCor(300, 175, 175, 0);
			this.weaponName = "greatsword";
			this.weaponVerb="slash";
			this.weaponAttack = 200;
			this.armorName = "holy armor";
			this.armorDef = 700;
			this.armorMDef = 700;
			this.bonusHP = 7000;
			this.lustVuln = 0.01;
			this.level = 90;
			this.gems = rand(300) + 700;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.LimitBreakerBody1stStage, 0, 0, 0, 0);
			this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}