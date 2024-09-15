/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Plains
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class Kirin extends Monster
	{
		private var superCharged:Boolean = false;
		private var runAway:Boolean = false;
		private var round:int = 0;

		// https://docs.google.com/document/d/1AuhfqxKJFdl3S8WS2Op59YFMXGYbDpWKrzS-Ag9Ub7Q/edit
		private function kirinThunderGore():void{
			var string:String = "";
			
			string += "The kirin gallops toward you, attempting to gore you with her horn.";
			
			if (player.getEvasionRoll()) {
				string += "\n\nYou barely manage to dodge in time.";
				outputText(string);
			}
			else{
				string += "\n\nYou are squarely struck, which allows her to deliver a deadly amount of voltage straight into your body, leaving you paralyzed and greatly aroused.";
				outputText(string);
				// No idea what damage balance is here
				var damage:Number = 0;
				var lustMod:Number = lust * 2;
				
				damage += (eBaseStrengthDamage() + lustMod) * 0.7;
				damage += (eBaseSpeedDamage() + lustMod) * 0.7;
				
				player.takeDamage(damage, 0,true);
				
				damage = (eBaseIntelligenceDamage() + lustMod) * 0.7;
				damage += (eBaseWisdomDamage() + lustMod) * 0.7;
				
				if(player.takeLightningDamage(damage, true)>0){
					if (player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
					else player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
				}
			}
		}
		
		private function kirinKick():void{
			var string:String = "";
			var damage:Number = 1;
			
			string += "The kirin makes a sudden turn and delivers a sudden powerful kick to your face";
			if(player.hasStatusEffect(StatusEffects.Stunned)){
				string += ", the kick hits true";
				player.removeStatusEffect(StatusEffects.Stunned);
				damage = 3
			}
			else if (player.getEvasionRoll()) {
				string += ".\n\nYou barely manage to dodge in time.";
				outputText(string);
				return;
			}
			else{
				string += ", leaving you stunned";
				if (!player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			}
			
			var lustMod:Number = lust * 2;
			
			damage *= (eBaseStrengthDamage() + lustMod) * 2.4;
			string += ". "
			outputText(string);
			
			player.takeDamage(damage, 0,true);
		}
		
		private function kirinLightningBolt():void {
			var string:String = "";
			
			string += "Kirin charge out energy in her hand and then fire it out in the form of a huge bolt of lightning at you ";
			if (player.getEvasionRoll()) {
				string += ", you barely manage to dodge in time.";
				outputText(string);
			}
			else{
				var damage:Number = 0;
				var lustMod:Number = lust * 2;
			
				damage += (eBaseIntelligenceDamage() + lustMod) * 1.5;
				damage += (eBaseWisdomDamage() + lustMod) * 1.5;
				
				outputText(" " + string);
				damage = Math.round(damage);
				player.takeLightningDamage(damage, true);
			}
		}
		
		private function kirinThunderCharging():void {
			outputText("The kirin suddenly gallops past you at high speed to build up some space between you. <b>Looks like you are not going able to engage in close quarter combat for awhile</b>.");
			runAway = true;
		}
		
		private function kirinThunderCharge(attacking:Boolean = false):void{
			runAway = false;
			var string:String = "";
			// if (Combat.playerWaitsOrDefends())
			
			string += "the Kirin suddenly raises her spear in the air like a lightning rod, a bolt coating the weapon with snaking electricity before she raises it and charges toward you!"
			
			if(attacking){
				string = "As you are preparing to attack, " + string + "\n\nYou didn't expecting this and are unable to dodge the blow in time, squarely struck by the energized weapon. ";
			}
			else{
				if (!player.getEvasionRoll()){
					string += "\n\nUnable to dodge the blow in time you are squarely struck by the weapon. ";
				}
				else{
					string += "\n\nYou dodge the blow by mere inches, had you not prepared for this you would have been hit for sure.";
					outputText(string);
					return;
				}
			}
			
			outputText(string);
			
			var damage:Number = 0;
			var lustMod:Number = lust * 2;
			
			damage += (eBaseStrengthDamage() + lustMod) * 1.5;
			damage += (eBaseSpeedDamage() + lustMod) * 1.5;
			
			player.takeDamage(damage, 0,true);
			
			damage = (eBaseIntelligenceDamage() + lustMod) * 1.5;
			damage += (eBaseWisdomDamage() + lustMod) * 1.5;
			
			damage = player.takeLightningDamage(damage, true)
			player.takeLustDamage(damage,true)
			
			if(damage>0){
				if (player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
				else player.createStatusEffect(StatusEffects.Stunned, 3, 0, 0, 0);
			}
		}
		
		override public function preAttackSeal():Boolean 
		{
			if (runAway){
				kirinThunderCharge(true)
				return false;
			}
			return true;
		}
		
		override protected function performCombatAction():void
		{
			round %= 7;
			
			if(round == 0){
				kirinThunderGore();
			}
			else if(round == 1 || round == 5){
				kirinLightningBolt();
			}
			else if(round == 2 || round == 6){
				kirinKick();
			}
			else if(round == 3){
				kirinThunderCharging();
			}
			else if(round == 4){
				if(runAway){
					kirinThunderCharge();
				}
			}
			
			round += 1;
		}

		 override public function isLustDefeatable():Boolean{
		 	return false;
		}
		
		override public function combatRoundUpdate():void 
		{
			super.combatRoundUpdate();
			this.lust += 500 * maxLust()/100
			if(runAway) {
				var kirinRunDesc:String = "Kirin don't seems too keen on getting close to you as she gallops in circle around you. <b>Looks like she is preparing for something big!</b>\n\n";
				outputText(kirinRunDesc);
			}
			// supercharge shit
			if (!superCharged && lust100 > 75) {
				var string:String = "";
				superCharged = true
				statStore.replaceBuffObject({'spe.mult':Math.round(speStat.mult.value)}, 'Supercharged', { text: 'Supercharged!' });
				CoC.instance.mainView.statsView.refreshStats(CoC.instance);
				CoC.instance.mainView.statsView.showStatUp('spe');
				// More penis description heh
				string += "The Kirin suddenly grips her massive tits in pleasure as her body overloads. It would seem the zappy pony has entered a state of supercharge, which may or may not be a <b>VERY</b> bad thing for you. Not to mention her now flared cock positively glowing with electrified desire, hosing pint after pints of neon blue pre-ejaculate with each angry throbb.\n\n"
				outputText(string);
				var kirinSuperChargedDesc:String = "You are fighting a Kirin. She looks now even more on edge as she pants constantly with her lust-crazed expression, her cock transformed into a battering ram as its flare practically doubling its size, spewing neon blue fluid like a broken faucet. Electricity enshrouding her further intensified, bombarding you with ear-splitting crack and just when you thought it couldn't get any worse, she is now practically a blur with every movement, forcing you to be on the guard constantly.";
				this.long = kirinSuperChargedDesc;
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.plains.kirinScene.kirinLost();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			// SceneLib.plains.kirinScene
			SceneLib.plains.kirinScene.kirinWon();
		}

		public function Kirin() {
			this.a = "a ";
			this.short = "kirin";
			this.imageName = "kirin";
			var kirinBaseDesc:String = "You are fighting a Kirin. Your lust addled opponent is clearly looking for a chance to knock you down and rape you, for the battle barely interests her. Running from her would be easier said than done seeing as she's a centaur with enough speed to catch on to most prey. You're somewhat wary of the electricity her body produces, there's no telling when she'll lash out and lightning might prove very hard to evade.";
			this.long = kirinBaseDesc;
			// this.plural = false;
			this.createCock(30,3,CockTypesEnum.KIRIN)
			createBreastRow(Appearance.breastCupInverse("G"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity, 25, 0, 0, 0);
			initStrTouSpeInte(99, 230, 198, 221);
			initWisLibSensCor(221, 400, 269, 60);
			this.weaponAttack = 50;
			this.armorDef = 80;
			this.armorMDef = 45;
			this.bonusHP = 1500;
			this.bonusLust = 719;
			this.level = 50;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_LOOSE);
			createVagina(true,VaginaClass.WETNESS_SLICK,VaginaClass.LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,100,0,0,0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,100,0,0,0);
			this.tallness = 108;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.bodyColor = "light";
			this.hairColor = "blue";
			this.hairLength = 13;
			this.weaponName = "claw";
			this.weaponVerb="claw-slash";
			this.armorName = "nothing";
			this.lust = 40;
			this.lustVuln = .8;
			this.gems = 500;
			this.drop = new ChainedDrop().
			add(consumables.EQUINUM,0.3).
			add(consumables.ASKIRIN,0.7);
			this.rearBody.type = RearBody.RAIJU_MANE
			this.arms.type = Arms.LIZARD;
			this.lowerBody = LowerBody.KIRIN;
			this.tailType = Tail.KIRIN;
			this.tailRecharge = 0;
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.LightningNature, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();

			this.lust = 35 * maxLust()/100
		}

	}

}
