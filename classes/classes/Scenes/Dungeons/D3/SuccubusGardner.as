package classes.Scenes.Dungeons.D3 
{
	import classes.Appearance;
	import classes.Monster;
	import classes.StatusAffects;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class SuccubusGardner extends Monster
	{
		
		public function SuccubusGardner() 
		{
			this.a = "the ";
			this.capitalA = "The ";
			this.short = "succubus gardner";
			this.long = "This succubus has everything you would expect from one of her kind: a bust that would drive women wild with jealousy, hips that could melt a preacher's conviction, an ass so perfectly rounded that it seems designed to be cupped, and a smoldering visage that simultaneously entices whilst wearing a domineering grin. Her raven hair cascades around ram horns that gleam like polished ivory, and her red eyes greedily drink in your every motion. What clothing she wears is only designed to enhance her rampant sexuality, somehow making her look more naked than if she actually were.\n\nBehind her, the shrubbery itself has come to life, revealing corded vines with inhuman strength, some capped with oozing, phallus-like tips. A few are as thick as your arm and tipped with gasping, swollen lips or violet, blooming pussies. Others still bear no ornamentation at all. There is little rhyme or reason to the mass of vegetation: only a theme of rampant, overgrown sexuality encouraged to an obscene degree.";
			
			this.createVagina();
			this.createBreastRow(Appearance.breastCupInverse("FF"));
			
			this.ass.analLooseness = ANAL_LOOSENESS_LOOSE;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			
			this.tallness = 7 * 12;
			this.hipRating = HIP_RATING_AVERAGE;
			this.buttRating = BUTT_RATING_TIGHT;
			
			initStrTouSpeInte(85, 60, 85, 100);
			initLibSensCor(85, 60, 100);
			
			this.bonusHP = 600;
			
			this.gems = 50 + rand(33);
			this.level = 20;
			
			this.lustVuln = 0;
			
			this.drop = NO_DROP;
			
			createStatusAffect(StatusAffects.TentagrappleCooldown, 10, 0, 0, 0);
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			
		}
		
		override protected function performCombatAction():void
		{
			// The succubus gardener is a multistage fight. She starts off all but immune to lust damage. She has enough HP not to be one-shot and a heal move that takes priority over any stun. Once she is reduced to 60% HP, she either drinks from her tentacles or is force-fed by them (if stunned). This fully heals her but makes her 15% more vulnerable to lust.
			
			// Also, the more turned on she gets, the more aggressive she gets.
			
			// Her damage is all lust but in low amounts. This is something of a marathon fight.
			
			if (findStatusAffect(StatusAffects.TentagrappleCooldown) >= 0)
			{
				addStatusValue(StatusAffects.TentagrappleCooldown, 1, -1);
				if (statusAffectv1(StatusAffects.TentacleCoolDown) <= 0)
				{
					removeStatusAffect(StatusAffects.TentagrappleCooldown);
				}
			}
			
			if (this.HPRatio() <= 0.6)
			{
				vineHeal();
			}
			else if (findStatusAffect(StatusAffects.TentagrappleCooldown) < 0)
			{
				tentagrapple();
			}
			
			combatRoundOver();
		}
		
		override protected function handleStun():Boolean
		{
			if (HPRatio() <= 0.6) return true;
			else
			{
				return super.handleStun();
			}
		}
		
		private function vineHeal():void
		{
			if (findStatusAffect(StatusAffects.Stunned) < 0)
			{
				outputText("Tipping herself backward, the succubus gardener lets herself pitch into the writhing tendrils behind her, her mouth opened welcomingly. The tentacles gently catch her, and rather than ravishing her vulnerable form, they merely gather above her parted lips, dribbling thick flows of pink slime. Her throat bobs as she swallows, her injuries vanishing in seconds. The vines push her back up onto her feet. She's smiling a little dopily.");
				
				if (this.lustVuln <= 0.15)
				{
					outputText(" <b>You aren't sure, but she seems to be leering at you a little more openly.</b>");
				}
				else if (this.lustVuln <= 0.45)
				{
					outputText(" <b>She's definitely leering at you now.</b>");
				}
				else
				{
					outputText(" <b>There's no disguising the lecherous look on her face while she eye-humps you.</b>");
				}
				
				if (this.lustVuln <= 0.3) outputText(" Whatever is in that healing nectar must be weakening her self-control.");
			}
			else
			{
				outputText("Acting on some unseen signal, the forest of tentacles lurches into action, surrounding its insensate mistress in a veil of wiggling green. A bundle of slime-dripping vines can be spotted through gaps in the verdant veil, hanging over their demonic caretaker with remarkable care, leaking gooey strands of pink into her mouth. Her throat works to swallow it, and when she emerges a second later, her injuries have vanished and her eyes");
				
				if (this.lustVuln <= 0.15)
				{
					outputText(" are slightly glassy.");
				}
				else if (this.lustVuln <= 0.45)
				{
					outputText(" are even glassier.");
				}
				else 
				{
					outputText(" are dilated and a little slow.");
				}
				
				if (this.lustVuln <= 0.3) outputText(" Whatever is in that healing nectar must be weakening her self-control.");
			}
			
			this.HP = this.eMaxHP();
			this.lustVuln += 0.15;
		}
		
		private function tentagrapple():void
		{
			createStatusAffect(StatusAffects.TentagrappleCooldown, 10, 0, 0, 0);
			
			//Used once every ten rounds
			outputText("A web of interwoven vines lashes out from behind the succubus, somehow leaving her untouched by the wave of advancing greenery. They're trying to grab you!");
			
			if (combatMiss() || combatEvade() || combatFlexibility() || combatMisdirect())
			{
				//Dodge
				outputText(" You slip aside at the last moment, barely avoiding being wrapped in the squirming mass. It snaps back, perhaps at the limits of its reach, leaving you once more eye to eye with the alluring gardener.");
			}
			else
			{
				//Do not dodddddddggggeee
				outputText(" You twist to the side, but one snags you by the wrist. Another loops around your [leg], and an avalanche of slime-oozing tentacles falls across the rest of you, wrapping you up in snug coils. Their grip is equal parts iron grip and lover's caress. You'd better struggle free before they really start to work on you!");
				player.createStatusAffect(StatusAffects.Tentagrapple, 0, 0, 0, 0);
			}
		}
		
		private function squeeze():void
		{
			
		}
	}

}