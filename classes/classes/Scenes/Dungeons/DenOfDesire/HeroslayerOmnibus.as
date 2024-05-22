/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.DenOfDesire
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;
import classes.Scenes.SceneLib;

public class HeroslayerOmnibus extends Monster
	{
		public function moveLustAura():void {
			outputText("The demoness blinks her eyes closed and knits her eyebrows in concentration.  The red orbs open wide and she smiles, licking her lips.   The air around her grows warmer, and muskier, as if her presence has saturated it with lust.");
			if (hasStatusEffect(StatusEffects.LustAura)) {
				outputText("  Your eyes cross with unexpected feelings as the taste of desire in the air worms its way into you.  The intense aura quickly subsides, but it's already done its job.");
				player.takeLustDamage((8 + int(player.lib / 20 + player.cor / 25)), true);
			}
			else {
				createStatusEffect(StatusEffects.LustAura, 0, 0, 0, 0);
			}
		}
		
		public function moveFireWhip():void {
			outputText("The demoness weaves her whip in the air until you can practically hear it slithering like a snake, cutting the air as it weaves back and forth, still magically alight with flames.  In a blink she lashes out twice in quick succession!\n");
			singleWhipStrike();
			singleWhipStrike();
		}
		private function singleWhipStrike():void {
			var damage:Number = 0;
			//Blind dodge change
			if (hasStatusEffect(StatusEffects.Blind) && rand(10) != 9) {
				outputText(capitalA + short + " completely misses you with a blind attack!");
			}
			//Determine if dodged!
			else if (player.getEvasionRoll()) {
				if (player.spe - spe < 8) outputText("You narrowly avoid " + a + short + "'s " + weaponVerb + "!");
				if (player.spe - spe >= 8 && player.spe - spe < 20) outputText("You dodge " + a + short + "'s " + weaponVerb + " with superior quickness!");
				if (player.spe - spe >= 20) outputText("You deftly avoid " + a + short + "'s slow " + weaponVerb + ".");
			}
			else {
				//Determine damage - str modified by enemy toughness!
				damage = int((eBaseDamage() * 1.5) - Math.random() * (player.tou + player.armorDef));
				if (damage > 0) {
					damage = player.takeFireDamage(damage);
				}
				if (damage <= 0) {
					damage = 0;
					//Due to toughness or amor...
					if (rand(player.armorDef + player.tou) < player.armorDef) outputText("Your [armor] absorb and deflect every " + weaponVerb + " from " + a + short + ".");
					else outputText("You deflect and block every " + weaponVerb + " " + a + short + " throws at you.");
				}
				if (damage > 0 && damage < 101) {
					outputText("You are struck a glancing blow by " + a + short + "! ");
				}
				if (damage > 100 && damage < 201) {
					outputText(capitalA + short + " wounds you! ");
				}
				if (damage > 200 && damage < 401) {
					outputText(capitalA + short + " staggers you with the force of " + pronoun3 + " " + weaponVerb + "! ");
				}
				if (damage > 400) {
					outputText(capitalA + short + " <b>mutilates</b> you with " + pronoun3 + " powerful " + weaponVerb + "! ");
				}
				if (damage > 0) outputText("<b>([font-damage]" + damage + "[/font])</b>");
				else outputText("<b>([font-miss]" + damage + "[/font])</b>");
			}
			statScreenRefresh();
			outputText("\n");
		}
		
		public function moveShadowfire():void {
			if (!hasStatusEffect(StatusEffects.Uber)) {
				if (rand(2) == 0) {
					outputText(capitalA + short + " winks and says, \"<i>Have you ever cum without being touched? You will.</i>\"\n\n");
				}
				else {
					outputText(capitalA + short + " titters, \"<i>Let me show you the true power of an Omnibus.</i>\"\n\n");
				}
				outputText("Despite her sultry tease, you can tell she's starting to build up to something big...");
				createStatusEffect(StatusEffects.Uber, 0, 0, 0, 0);
			}
			else {
				//(Next Round)
				if (statusEffectv1(StatusEffects.Uber) == 0) {
					addStatusValue(StatusEffects.Uber, 1, 1);
					if (rand(2) == 0) outputText("The demonic hermaphrodite begins forging demonic symbols in the air before her, each glowing brilliant purple before they blur away in a haze.");
					else outputText("The demonette makes obscene motions with her hands, as if masturbating an imaginary cock or vagina while her hands are wreathed in purple flames.");
					outputText("  <b>She's about to unleash something huge!</b>");
					if (player.inte > 50) outputText("  You should probably wait so you'll have a chance to avoid whatever's coming.");
				}
				//FIRE!
				else {
					removeStatusEffect(StatusEffects.Uber);
					//(Avoid!)
					if (Combat.playerWaitsOrDefends()) {
						outputText("She throws her hands out, palms facing you, and a rush of purple flame washes towards you.  Thanks to your decision to wait, it's easy to avoid the onrushing flames and her attack.\n\n");
						outputText(capitalA + short + " sighs and asks, \"<i>Why would you move?  It would make you feel soooo good!</i>\"");
					}
					//(Direct Hit)
					else {
						outputText("She throws her hands out, palms facing you, and a rush of purple flame washes towards you.  Too busy with your own attack to effectively dodge, you're hit full on by the purple fire.  Incredibly, it doesn't burn.  The fire actually seems to flow inside you, disappearing into your skin.  You stumble, confused for a second, but then it hits you.  Every inch of your body is buzzing with pleasure, practically squirming and convulsing with sexual delight.  You collapse, twitching and heaving, feeling the constant sensation of sexual release running from your head to your [feet].");
						player.takeLustDamage(1000, true);
						if (player.lust >= player.maxOverLust()) outputText("  Too horny and pleasured to resist, you lie down and tremble, occasionally rubbing yourself to enhance the bliss.");
					}
				}
			}
		}
		
		public function moveHerobane():void {
			outputText("The omnibus throws an ethereal chain at you, binding you to her.");
			player.createStatusEffect(StatusEffects.HeroBane, 2, 0, 0, 0);
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Uber)) {
				moveShadowfire();
			}
			else {
				var choice:Number = rand(5);
				if (choice == 0) moveLustAura();
				if (choice == 1) moveFireWhip();
				if (choice == 2) moveShadowfire();
				if (choice == 3) {
					if (player.hasStatusEffect(StatusEffects.HeroBane)) moveShadowfire();
					else moveHerobane();
				}
				if (choice == 4) eAttack();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.denofdesire.defeatedHeroslayerOmnibus();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.denofdesire.defeatedByHeroslayerOmnibus();
		}
		
		public function HeroslayerOmnibus()
		{
			this.a = "the";
			this.short = "hero slayer omnibus";
			this.imageName = "hero slayer omnibus";
			this.long = "This omnibus has lustrous black skin and a pair of goat like horns sitting like a crown above her fiery red hair. While you don't know her name you're pretty sure she defeated " + flags[kFLAGS.GAR_NAME] + "’s former master and that she's a serious threat. She wields a flaming whip and seems to hold a purple fireball in her other hand. Her very presence is intoxicating, saturating the very air with lust.";
			// this.plural = false;
			this.createCock(10,2,CockTypesEnum.DEMON);
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 20, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,15,0,0,0);
			this.tallness = 5*12+6;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_NOTICEABLE;
			this.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
			this.bodyColor = "black";
			this.hairColor = "red";
			this.hairLength = 20;
			initStrTouSpeInte(104, 100, 90, 150);
			initWisLibSensCor(150, 120, 50, 100);
			this.weaponName = "flaming whip";
			this.weaponVerb="flame-whip";
			this.weaponAttack = 26;
			this.armorName = "demon-skin";
			this.armorDef = 1;
			this.armorMDef = 75;
			this.bonusHP = 2500;
			this.bonusLust = 200;
			this.lust = 30;
			this.lustVuln = 0.75;
			this.level = 30;
			this.gems = rand(5) + 38;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, 30, 0, 0, 0);
			checkMonster();
		}
	}
}
