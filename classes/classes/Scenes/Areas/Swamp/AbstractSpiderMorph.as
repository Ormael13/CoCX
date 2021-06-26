/**
 * Created by aimozg on 03.01.14.
 */
package classes.Scenes.Areas.Swamp
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.WeaponLib;
	import classes.StatusEffects.Combat.WebDebuff;

public class AbstractSpiderMorph extends Monster
	{
		public function AbstractSpiderMorph()
		{
		}

		override protected function performCombatAction():void
		{
			if(player.spe >= 2 && rand(2) == 0) {
				spiderMorphWebAttack();
			}
			else if(!player.hasStatusEffect(StatusEffects.WebSilence) && rand(3) == 0) {
				spiderSilence();
			}
			else if(!player.hasStatusEffect(StatusEffects.Disarmed) && !player.isFistOrFistWeapon() && rand(3) == 0) {
				spiderDisarm();
			}
			else if(rand(2) == 0 || player.spe < 2) getBitten();
			else eAttack();
		}

		/**
		 * -Web - lowers speed by 25 each application and disables
		 * flight once hit.*/
		public function spiderMorphWebAttack():void
		{
			outputText("Turning to the side, " + a + short + " raises " + mf("his", "her") + " abdomen and unleashes a spray of webbing in your direction!  ");
			//Blind dodge change
			if (hasStatusEffect(StatusEffects.Blind) && rand(3) < 2) {
				outputText(capitalA + short + " misses completely due to their blindness.");
			}
			//Determine if dodged!
			else if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				outputText("You dodge away, avoiding the sticky strands!");
			}
			//Determine if evaded
			else if (player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
				outputText("You evade, avoiding the sticky strands!");
			}
			//("Misdirection"
			else if (player.hasPerk(PerkLib.Misdirection) && rand(100) < 10 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
				outputText("Your misleading movements allow you to easily sidestep the sticky strands!");
			}
			//Determine if cat'ed
			else if (player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
				outputText("You throw yourself out of the way with cat-like agility at the last moment, avoiding " + mf("his", "her") + " attack.\n");
			}
			//Got hit
			else {
				var web:WebDebuff = player.statusEffectByType(StatusEffects.Web) as WebDebuff;
				if (web == null) {
					outputText("The silky strands hit you, webbing around you and making it hard to move with any degree of speed.");
					if (player.canFly()) outputText("  Your wings struggle uselessly in the bindings, no longer able to flap fast enough to aid you.");
					outputText("\n");
					web = new WebDebuff();
					player.addStatusEffect(web);
				}
				else {
					outputText("The silky strands hit you, weighing you down and restricting your movement even further.\n");
				}
				web.increase();
			}
		}

		/**-Bite - Raises arousal by 30*/
		public function getBitten():void
		{
			//-Languid Bite - Inflicted on PC's who have been reduced to 1 speed by webbing, raises arousal by 60.
			if (player.spe < 2 && player.hasStatusEffect(StatusEffects.Web)) {
				outputText("The arachnid aggressor slowly saunters forward while you struggle under the heaps of webbing, gently placing " + mf("his", "her") + " arms around your back in a tender hug.  " + mf("His", "Her") + " fangs slide into your neck with agonizing slowness, immediately setting off a burning heat inside you that makes you dizzy and weak.  ");
				if (player.hasCock()) {
					outputText(player.SMultiCockDesc() + " turns rock hard and squirts weakly, suddenly so aroused that it starts soaking your " + player.armorName);
					if (player.hasVagina()) outputText(" along with your [pussy]");
					outputText(".  ");
				}
				else if (player.hasVagina()) outputText("Your [vagina] grows wet as hell and so sensitive that every step and movement reminds you of the powerful need for something between your sopping nether-lips.  ");
				outputText("While " + mf("his", "her") + " venom pours into you, the spider-" + mf("boy", "girl") + " reaches into your gear to play with your [nipple], and you moan like a whore from the dual stimulation of " + mf("his", "her") + " venom and nipple-play.\n\n");
				if (hasVagina()) outputText("The saucy dominatrix exhausts her supply of aphrodisiac toxin for the moment and finally steps back, admiring her work and giving you a lewd wink.  You ");
				else outputText("The confident male exhausts his supply of aphrodisiac toxin for the moment and finally steps back, admiring his work and giving you a lewd wink.  You ");
				player.dynStats("lus", 60);
				if (player.lust >= player.maxLust()) outputText("wobble, utterly defeated and about to cave in to your lust.");
				else outputText("struggle not to fall down and start masturbating on the spot.");
				outputText("\n");
				return;
			}
			outputText("The spider-" + mf("boy", "girl") + " lunges forward with " + mf("his", "her") + " mouth open, " + mf("his", "her") + " two needle-like fangs closing rapidly.  ");
			//Blind dodge change
			if (hasStatusEffect(StatusEffects.Blind) && rand(3) < 2) {
				outputText(capitalA + short + " misses completely due to their blindness.");
			}
			//Determine if dodged!
			else if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				outputText("You dodge away, avoiding " + mf("his", "her") + " bite!");
			}
			//Determine if evaded
			else if (player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
				outputText("You evade, avoiding the bite!");
			}
			//("Misdirection"
			else if (player.hasPerk(PerkLib.Misdirection) && rand(100) < 10 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
				outputText("Your misleading movements allow you to easily sidestep the spider bite!");
			}
			//Determine if cat'ed
			else if (player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
				outputText("You throw yourself out of the way with cat-like agility at the last moment, avoiding " + mf("his", "her") + " attack.\n");
			}
			else {
				if (rand(5) == 0) {
					outputText("You react far too slowly, and before you can even think to dodge, " + mf("he", "she") + "'s bitten deep into you, pumping large squirts of venom deep into your body.  Unnatural heat rolls through you, pooling in your groin until you're lewdly bucking your hips against the spider-morph's thigh.  " + mf("He", "She") + " pulls out and steps back, ");
					if (hasVagina()) outputText("casually cupping her breasts while you watch with venom-dilated eyes, slowly touching yourself.  Once she stops, you shake your head and master yourself, remembering that you're supposed to be fighting this " + mf("boy", "girl") + "!\n");
					else outputText("casually tugging on his relatively short, girthy dick as you watch with venom-dilated eyes, slowly touching yourself.  Once he stops, you shake your head and master yourself, remembering that you're supposed to be fighting this " + mf("boy", "girl") + "!\n");
					player.dynStats("lus", 50);
				}
				else {
					outputText("You react too slowly, and before you can dodge, " + mf("he", "she") + "'s bitten you, leaving behind a burning venom that warms your blood and stokes your lust.\n");
					player.dynStats("lus", 30);
				}
			}
		}

		/**-Disarm - hits the PC's weapon with web and sticks it to a
		 nearby tree, reducing PC's attack to 0 for the rest of the fight.*/
		public function spiderDisarm():void
		{
			outputText(capitalA + short + " shifts and sprays webbing, aiming a tight strand of it at your [weapon].  ");
			//Blind dodge change
			if (hasStatusEffect(StatusEffects.Blind) && rand(3) < 2) {
				outputText("The blind web-shot goes horribly wide, missing you entirely.");
			}
			//Determine if dodged!
			else if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				outputText("You pull your weapon back and the webbing goes wide, missing entirely.");
			}
			//Determine if evaded
			else if (player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
				outputText("You pull your weapon back evasively and the webbing goes wide, missing entirely!");
			}
			//("Misdirection"
			else if (player.hasPerk(PerkLib.Misdirection) && rand(100) < 10 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
				outputText("Your misleading movements allow you to easily sidestep the webbing!");
			}
			//Determine if cat'ed
			else if (player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
				outputText("You throw yourself out of the way with cat-like agility at the last moment, avoiding " + mf("his", "her") + " attack.\n");
			}
			//Shield Ward
			else if (player.hasPerk(PerkLib.ShieldWard) && rand (2) == 0) {
				outputText("You block the webbing with your shield, causing it to miss it orginal target.");
			}
			else if (player.weaponName == "spiked gauntlet" || player.weaponName == "hooked gauntlets") {
				outputText("The webbing hits your ");
				if (player.weaponName == "spiked gauntlet") outputText("gauntlet, but it's so effectively fastened to your hands that the attack fails to disarm you.\n");
				else outputText("gauntlets, but they're so effectively fastened to your hands that the attack fails to disarm you.\n");
			}
			else {
				outputText("You don't react fast enough and the sticky webbing pulls your [weapon] out of your grip, gluing it to a nearby tree.  There's no way to get it back right now, you'll have to fight bare-handed!");
				flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = player.weapon.id;
				player.setWeapon(WeaponLib.FISTS);
//No longer appears to be used				flags[kFLAGS.PLAYER_DISARMED_WEAPON_ATTACK] = player.weaponAttack;
//				player.weapon.unequip(player,false,true);
				player.createStatusEffect(StatusEffects.Disarmed, 50, 0, 0, 0);
			}
		}

		/**-Silence - sprays webs on the PC's mouth, silencing them for 1 to 3 turns.*/
		public function spiderSilence():void
		{
			outputText(capitalA + short + " squirts a concentrated spray of " + mf("his", "her") + " webs directly at your face!  ");
			//Blind dodge change
			if (hasStatusEffect(StatusEffects.Blind) && rand(3) < 2) {
				outputText("The blind web-shot goes horribly wide, missing you entirely.");
			}
			//Determine if dodged!
			else if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				outputText("You lean back and let them pass harmlessly overhead, avoiding the attack.");
			}
			//Determine if evaded
			else if (player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
				outputText("You pull your weapon back evasively and the webbing goes wide, missing entirely.");
			}
			//("Misdirection"
			else if (player.hasPerk(PerkLib.Misdirection) && rand(100) < 10 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
				outputText("Your misleading movements allow you to easily sidestep the webbing!");
			}
			//Determine if cat'ed
			else if (player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
				outputText("You throw yourself out of the way with cat-like agility at the last moment, avoiding " + mf("his", "her") + " attack.\n");
			}
			else {
				outputText("They hit you before you can move, covering most of your nose and mouth and making it hard to breathe.  You'll be unable to use your magic while you're constantly struggling just to draw air!\n");
				player.createStatusEffect(StatusEffects.WebSilence, 0, 0, 0, 0);
			}
		}
	}
}