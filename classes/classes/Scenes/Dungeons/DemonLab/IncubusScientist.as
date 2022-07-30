package classes.Scenes.Dungeons.DemonLab 
{
	/**
	 * ...
	 * @author ...
	 */
	public class IncubusScientist 
	{
		
		public function IncubusScientist() 
		{
		this.short = "incubus Scientist";
		this.long = "This demon is clad in a heavy-looking lab coat, and wears a strange pistol at his hip. Weedy and thin, he doesn't look like he's much of a fighter, but the anger in his gaze is a clear indicator of his intent. He wears an odd contraption on his left hand, 
				initStrTouSpeInte(150, 100, 130, 305);
				initWisLibSensCor(105, 190, 110, 100);
				this.weaponAttack = 86;
				this.armorDef = 38;
				this.armorMDef = 23;
				this.bonusHP = 500;
				this.bonusLust = 206;
				this.level = 40;
				this.additionalXP = 50;
			    this.gems = rand(30) + 15;
				this.createPerk(PerkLib.OverMaxHP, 26, 0, 0, 0);	
		}
		private function ForHisNeutralSpecialHeWieldsAGun {
		outputText("The demon scientist lines you up in his sights, pulling the trigger several times.")
		//Miss:
			//Determine if evaded
			if(player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
				outputText("You dodge the bullets, and they fly past, taking small chunks out of the stone wall behind you.");
			}
			//("Misdirection"
			else if(player.hasPerk(PerkLib.Misdirection) && rand(100) < 10 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
				outputText("Using your talent for misdirection, You dodge the bullets, and they fly past, taking small chunks out of the stone wall behind you.");
			}
			//Determine if cat'ed
			else if(player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
				outputText("Using your cat-like flexibility, you manage to bend your spine, dodging the bullets. They fly past, taking small chunks out of the stone wall behind you.");
				
			}
			else {
				var damage:Number = Math.round(90 + rand(10) + (player.newGamePlusMod() * 30));
				damage = finalizeDamage(damage);
				outputText("You can’t even see the projectile as it flies, striking you in the [chest].");
				createStatusEffect(StatusEffects.Attacks, 2 + rand(2),0,0,0);
				outputText("\n");
			}
		}
		
	}

}