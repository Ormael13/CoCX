/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.internals.*;
	
	public class Jeniffer extends Monster
	{
		override protected function performCombatAction():void {
			var choice:Number = rand(2);
			if (choice == 0) eAttack();
			if (choice == 1) {
				if (!player.hasStatusEffect(StatusEffects.IzmaBleed) && rand(2) == 0) Specials1();
				else eAttack();
			}
		}
		
		public function Specials1():void {
			//Blind dodge change
			if(hasStatusEffect(StatusEffects.Blind) && rand(3) < 2) {
				outputText("J1c blindly tries to clinch you, but misses completely.\n");
				return;
			}
			//Determine if dodged!
			if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80) {
				outputText("J1c tries to clinch you, but you use your speed to keep just out of reach.\n");
				return;
			}
			//Determine if evaded
			if(player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("J1c tries to clinch you, but she didn't count on your skills in evasion.  You manage to sidestep her at the last second.\n");
				return;
			}
			//("Misdirection"
			if(player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				outputText("J1c ducks and weaves forward to clinch you, but thanks to Raphael's teachings, you're easily able to misguide her and avoid the clumsy grab.\n");
				return;
			}
			//Determine if cat'ed
			if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 6) {
				outputText("J1c tries to lock you in a clinch, but your cat-like flexibility makes it easy to twist away from her grab.\n");
				return;
			}
			var damage:Number = 0;
			damage = Math.round(130 - rand(player.tou+player.armorDef));
			if(damage < 0) damage = 0;
			outputText("J1c ducks and jinks, working to close quarters, and clinches you. Unable to get your weapon into play, you can only ");
			if(player.armorDef >= 10 || damage == 0) {
				//(armor-dependent Health damage, fullplate, chain, scale, and bee chitin armor are unaffected, has a chance to inflict 'Bleed' damage which removes 4-10% of health for the next three turns if successful)
				outputText("writhe as she painfully drags the sharp end of the metal shards on her golem forearm down your back");
				player.createStatusEffect(StatusEffects.IzmaBleed,3,0,0,0);
			}
			else outputText("laugh as her blades scape uselessly at your armor-clad back");
			outputText(" before breaking her embrace and leaping away. ");
			player.takePhysDamage(damage, true);
		}
		
		public function Jeniffer() 
		{
			this.a = "the ";
			this.short = "J1c golem";
			this.imageName = "J1c golem";
			this.long = "You're currently fighting a golemancer controling personaly created golem called J1c. It's ten feet tall with general shape of a female but lacking any fine details. It stone body is covered with soulmetal plates in many placed and from it looks like using spike covered fists to smash enemies. Despite been controled by a goblin it construction greatly reduce effects of most of sexual moves.";
			this.plural = false;
			initStrTouSpeInte(120, 120, 20, 10);
			initWisLibSensCor(10, 10, 10, 50);
			this.lustVuln = .1;
			this.tallness = 120;
			this.createBreastRow(0, 1);
			initGenderless();
			this.drop = new ChainedDrop()
					.add(useables.GOLCORE, 1/4);
			this.level = 15;
			//this.bonusHP = 200;
			this.weaponName = "spiked fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 36;
			this.armorName = "stone covered by soulmetal plating";
			this.armorDef = 45;
			this.armorMDef = 45;
			this.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}