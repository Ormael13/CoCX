package classes.Scenes.Dungeons.D3 
{
	import classes.Monster;
	import classes.StatusAffects;
	import classes.PerkLib;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class LivingStatue extends Monster
	{
		override public function defeated(hpVictory:Boolean):void
		{
			game.d3.livingStatue.beatUpDaStatue(hpVictory);
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.d3.livingStatue.fuckinMarbleOP(hpVictory, pcCameWorms);
		}
		
		public function LivingStatue() 
		{
			this.a = "the ";
			this.short = "living statue";
			this.imageName = "livingstatue";
			this.long = "This animate marble statue shows numerous signs of wear and tear, but remains as strong and stable as the day it was carved. It's pearly, white skin is pockmarked in places from age, yet the alabaster muscles seem to move with almost liquid grace. You get the impression that the statue was hewn in the days before the demons, then brought to life shortly after. It bears a complete lack of genitalia - an immaculately carved leaf is all that occupies its loins. It wields a hammer carved from the same material as the rest of it.";
			
			initStrTouSpeInte(100, 80, 25, 50);
			initLibSensCor(10, 10, 100);
			
			this.lustVuln = 0;
			
			createPerk(PerkLib.Resolute, 0, 0, 0, 0);
			
		}
		
		override public function handleStun():Boolean
		{
			game.outputText("The stone giant's unforgiving flesh seems incapable of being stunned.");
			return true;
		}
		
		override public function handleFear():Boolean
		{
			game.outputText("The stone giant cares little for your attempted intimidation.");
			return true;
		}
		
		override protected function handleBlind():Boolean
		{
			return true;
		}
		
		private function concussiveBlow():void
		{
			//Maybe replace this with passive stun? TERRIBLE IDEA
			outputText("The giant raises his hammer for an obvious downward strike. His marble muscles flex as he swings it downward. You're able to hop out of the way of the clearly telegraphed attack, but nothing could prepare you for the shockwave it emits as it craters the ground.");

			//Light magic-type damage!
			var damage:Number = (50 * (inte/player.inte)) - player.armorDef - (player.tou/5);
			damage = player.takeDamage(damage);
			
			//Stun success
			if (rand(2) == 0 && player.findStatusAffect(StatusAffects.Stunned) < 0)
			{
				outputText(" <b>The vibrations leave you rattled and stunned. It'll take you a moment to recover!</b>");
				player.createStatusAffect(StatusAffects.Stunned, 2, 0, 0, 0);
			}
			else
			//Fail
			{
				outputText(" You shake off the vibrations immediately. It'll take more than that to stop you!");
			}
			
			outputText(" (" + damage + ")");
		}
		
		private function dirtKick():void
		{
			outputText("The animated sculpture brings its right foot around, dragging it through the gardens at a high enough speed to tear a half score of bushes out by the root. A cloud of shrubbery and dirt washes over you!");
			
			//blind
			if (rand(2) == 0 && player.findStatusAffect(StatusAffects.Blind) < 0)
			{
				player.createStatusAffect(StatusAffects.Blind, 2, 0, 0, 0);
				outputText(" <b>You are blinded!</b>");
			}
			else
			{
				//Not blind
				outputText(" You close your eyes until it passes and resume the fight!");
			}
		}
		
		private function backhand():void
		{
			//Knocks you away and forces you to spend a turn running back to do melee attacks.
			outputText("The marble golem's visage twists into a grimace of irritation, and it swings its hand at you in a vicious backhand.");
	
			var damage:Number = int ((str + weaponAttack) - rand(player.tou) - player.armorDef);
			//Dodge
			if (damage <= 0 || (combatMiss() || combatEvade() || combatFlexibility() || combatMisdirect())) outputText(" You slide underneath the surprise swing!");
			else
			{
				//Get hit
				outputText(" It chits you square in the chest. The momentum sends you flying through the air. You land with a crunch against a wall. <b>You'll have to run back to the giant to engage it in melee once more.</b>");
				
				player.createStatusAffect(StatusAffects.KnockedBack, 0, 0, 0, 0);
				damage = player.takeDamage(damage);
				
				outputText(" (" + damage + ")");
			}
		}
		
		private function overhandSmash():void
		{
			//High damage, lowish accuracy.
			outputText("Raising its hammer high overhead, the giant swiftly brings its hammer down in a punishing strike!");
			
			var damage:Number = 200 + int((str + weaponAttack) - rand(player.tou) - player.armorDef);
			if (damage <= 0 || (combatMiss() && combatMiss()) || combatEvade() || combatFlexibility() || combatMisdirect()) outputText(" You're able to sidestep it just in time.");
			else
			{
				//Hit
				outputText(" The concussive strike impacts you with bonecrushing force.");
				damage = player.takeDamage(damage);
				outputText(" (" + damage + ")");
			}
		}
		
		private function disarm():void
		{
			outputText("The animated statue spins its hammer around, striking at your [weapon] with its haft.");
	
			//Avoid
			if ((combatMiss() && combatMiss()) || combatEvade() || combatFlexibility() || combatMisdirect()) outputText(" You manage to hold onto your equipment, for now.");
			//Oh noes!
			else
			{
				outputText(" Your equipment flies off into the bushes! You'll have to fight another way.");
				player.createStatusAffect(StatusAffects.Disarmed, 0, 0, 0, 0);
				flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = player.weapon.id;
				flags[kFLAGS.PLAYER_DISARMED_WEAPON_ATTACK] = player.weaponAttack;
				player.weapon.unequip(player,false,true);
			}
		}
		
		private function cycloneStrike():void
		{
			//Difficult to avoid, moderate damage.
			outputText("Twisting back, the giant abruptly launches into a circular spin. It's hammer stays low enough to the ground that its circular path is tearing a swath of destruction through the once pristine garden, and it's coming in your direction!");
//Avoid
By the grace of the gods, you somehow avoid the spinning hammer.
//Hit
You're squarely struck by the spinning hammer.
		}
		
		override protected function performCombatAction():void
		{
			
		}
		
	}

}