/**
 * ...
 * @author Sylabt & Ohaxer
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;
	import classes.Races;

	public class ArigeanClub extends Weapon {
		
		public function ArigeanClub() 
		{
			super("AriClub", "ArigeanClub", "Arigean Club", "an Arigean Club", "smash", 11, 880, "A black club with white wrappings, the metal shines silver when even a small glimmer of light hits it. It should prove useful in keeping your foes at bay.","","Mace/Hammer");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.racialScore(Races.ARIGEAN) >= 9) boost += 4;
			if (game.player.racialScore(Races.ARIGEAN) >= 16) boost += 4;
			if (game.player.racialScore(Races.ARIGEAN) >= 18) boost += 4;
			if (game.player.racialScore(Races.ARIGEAN) >= 20) boost += 4;
			if (game.player.racialScore(Races.ARIGEAN) >= 23) boost += 4;
			return (11 + boost); 
		}	
	}
}