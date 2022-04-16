/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kFLAGS;
import classes.Items.WeaponLib;
import classes.Scenes.SceneLib;
import classes.StatusEffects.Combat.WebDebuff;
import classes.internals.*;

	public class Lily extends Monster//drider cumdump slave from swamp area
	{
		private function lilyBasicAttack():void {
			outputText("The drider woman draws her recurve bow, nocking an arrow and firing in less than half a second. You try to dodge, but the arrow hits you in the [foot], pinning you to the ground.");
			damageCalc();
			lilyBasicAttackRe();
			lilyBasicAttackRe();
			lilyBasicAttackRe();
			lilyBasicAttackRe();
		}
		private function lilyBasicAttackRe():void {
			var choices:Number = 4;
			if (!player.hasStatusEffect(StatusEffects.Disarmed) && !player.isFistOrFistWeapon()) choices += 1;
			var re:Number = rand(choices);
			switch (re) {
				case 0:
					outputText("Another arrow follows, sinking deep into your [chest].");
					damageCalc();
					break;
				case 1:
					outputText("Another arrow follows, sinking into your [leg].");
					damageCalc();
					break;
				case 2:
					outputText("An arrow is fired into your shoulder.");
					damageCalc();
					break;
				case 3:
					outputText("The drider fires an arrow with an explosive tip. You cover your [face] as the concussive blast erupts, sending metal shards into your body.");
					damageCalc();
					if (rand(10) == 0 && !player.hasPerk(PerkLib.Resolute) && !player.hasStatusEffect(StatusEffects.Stunned)) player.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
					break;
				case 4:
					outputText("You look down at your foot, and another arrow comes whistling at you. You block with your [weapon], but the impact sends your [weapon] tumbling from your hands.");
					if (rand(3) == 0) {
						flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = player.weapon.id;
						player.setWeapon(WeaponLib.FISTS);
						player.createStatusEffect(StatusEffects.Disarmed, 2, 0, 0, 0);
					}
					break;
				default:
					outputText("Another arrow follows, sinking deep into your [chest].");
					damageCalc();
			}
		}
		
		private function lilyWebAttack():void {
			outputText("She spins, exposing her spider back-half and spinnerets. The Drider spits webbing in great strands.");
			//Blind dodge change
			if (hasStatusEffect(StatusEffects.Blind) && rand(3) < 2) {
				outputText("She misses completely due to their blindness. As she spins back around, your opponent…seems to be looking at the strands in disappointment. Is it your imagination, or does she seem to regret the loss of silk?");
			}
			//Determine if dodged!
			else if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				outputText("You dodge away, avoiding the sticky strands! As she spins back around, your opponent…seems to be looking at the strands in disappointment. Is it your imagination, or does she seem to regret the loss of silk?");
			}
			//Determine if evaded
			else if (player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
				outputText("You evade, avoiding the sticky strands! As she spins back around, your opponent…seems to be looking at the strands in disappointment. Is it your imagination, or does she seem to regret the loss of silk?");
			}
			//("Misdirection"
			else if (player.hasPerk(PerkLib.Misdirection) && rand(100) < 10 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
				outputText("Your misleading movements allow you to easily sidestep the sticky strands! As she spins back around, your opponent…seems to be looking at the strands in disappointment. Is it your imagination, or does she seem to regret the loss of silk?");
			}
			//Determine if cat'ed
			else if (player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
				outputText("You throw yourself out of the way with cat-like agility at the last moment, avoiding " + mf("his", "her") + " attack. As she spins back around, your opponent…seems to be looking at the strands in disappointment. Is it your imagination, or does she seem to regret the loss of silk?\n");
			}
			//Got hit
			else {
				var web:WebDebuff = player.statusEffectByType(StatusEffects.Web) as WebDebuff;
				if (web == null) {
					outputText("You’re unable to dodge, and the heavy strands wrap around your arms and legs, weighing you down and restricting your movements.");
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
		
		private function lilyVolley():void {
			outputText("Several arrows come flying at you, and you see the Drider-woman’s top half through the treeline. You gasp, disbelieving, as said arrows seem to multiply into a veritable shower of shafts, and you barely have time to crouch down, making yourself less of a target. ");
			if (player.hasStatusEffect(StatusEffects.WindWall)) outputText("Still surrounding you wind wall stops them without much trouble. ");
			LilyFireBow();
			LilyFireBow();
			LilyFireBow();
			LilyFireBow();
			LilyFireBow();
			LilyFireBow();
			LilyFireBow();
			LilyFireBow();
			LilyFireBow();
			LilyFireBow();
			LilyFireBow();
			LilyFireBow();
		}
		public function LilyFireBow():void {
			if (player.hasStatusEffect(StatusEffects.WindWall)) player.addStatusValue(StatusEffects.WindWall,2,-1);
			else damageCalc();
		}
		
		private function damageCalc():void {
			var damage:Number = 0;
			damage += eBaseSpeedDamage() * 0.2;
			if (damage < 10) damage = 10;
			//weapon bonus
			if (this.weaponRangeAttack < 51) damage *= (1 + (this.weaponRangeAttack * 0.03));
			else if (this.weaponRangeAttack >= 51 && this.weaponRangeAttack < 101) damage *= (2.5 + ((this.weaponRangeAttack - 50) * 0.025));
			else if (this.weaponRangeAttack >= 101 && this.weaponRangeAttack < 151) damage *= (3.75 + ((this.weaponRangeAttack - 100) * 0.02));
			else if (this.weaponRangeAttack >= 151 && this.weaponRangeAttack < 201) damage *= (4.75 + ((this.weaponRangeAttack - 150) * 0.015));
			else damage *= (5.5 + ((this.weaponRangeAttack - 200) * 0.01));
			player.takePhysDamage(damage, true);
		}
		
		override protected function performCombatAction():void
		{
			var choice0:Number = rand(3);
			switch (choice0) {
				case 0:
					lilyBasicAttack();
					break;
				case 1:
					lilyWebAttack();
					break;
				case 2:
					lilyVolley();
					break;
				default:
					lilyBasicAttack();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (LilyFollower.LilyFollowerState) cleanupAfterCombat();
			else SceneLib.lily.LilyAfterBattle();
		}
		
		public function Lily() 
		{
			if (flags[kFLAGS.LILY_LVL_UP] < 2) {
				initStrTouSpeInte(70, 75, 110, 100);
				initWisLibSensCor(100, 80, 50, 90);
				this.weaponAttack = 3;
				this.weaponRangeAttack = 30;
				this.armorDef = 60;
				this.armorMDef = 6;
				this.bonusHP = 400;
				this.bonusLust = 152;
				this.level = 22;
			}
			if (flags[kFLAGS.LILY_LVL_UP] == 2) {
				initStrTouSpeInte(70, 75, 110, 100);
				initWisLibSensCor(100, 80, 50, 90);
				this.weaponAttack = 3;
				this.weaponRangeAttack = 30;
				this.armorDef = 60;
				this.armorMDef = 6;
				this.bonusHP = 400;
				this.bonusLust = 152;
				this.level = 22;
			}
			this.imageName = "corrupteddrider";
			if (LilyFollower.LilyTalked > 0) { 
				this.a = "";
				this.short = "Lily";
				this.long = "Lily is a drider - a creature with a humanoid top half and the lower body of a giant arachnid.  From a quick glance, you can tell that this one has fallen deeply to corruption.  She is utterly nude, exposing her four well-rounded, DD-cup breasts with their shiny black nipples.  Gold piercings and chains link the curvy tits together, crossing in front of her four mounds in an 'x' pattern.  On her face and forehead, a sextet of lust-filled, " + LilyFollower.LilySkinTone + " eyes gaze back at you.  Behind her, the monster-girl's " + LilyFollower.LilyHairColor + " hair drapes down her back like a cloak.  The drider's lips seem to shine with a light all their own, and a steady trickle of purple, reflective fluid beads and drips from them.  At her waist, there's a juicy looking snatch with a large, highly visible clit.  Her spider-half has eight spindly legs with black and " + LilyFollower.LilyHairColor + " stripes - a menacing display if ever you've seen one.";
			}
			else {
				this.a = "the ";
				this.short = "corrupted drider";
				this.long = "This particular spider-woman is a drider - a creature with a humanoid top half and the lower body of a giant arachnid.  From a quick glance, you can tell that this one has fallen deeply to corruption.  She is utterly nude, exposing her four well-rounded, DD-cup breasts with their shiny black nipples.  Gold piercings and chains link the curvy tits together, crossing in front of her four mounds in an 'x' pattern.  On her face and forehead, a sextet of lust-filled, " + LilyFollower.LilySkinTone + " eyes gaze back at you.  Behind her, the monster-girl's " + LilyFollower.LilyHairColor + " hair drapes down her back like a cloak.  The drider's lips seem to shine with a light all their own, and a steady trickle of purple, reflective fluid beads and drips from them.  At her waist, there's a juicy looking snatch with a large, highly visible clit.  Her spider-half has eight spindly legs with black and " + LilyFollower.LilyHairColor + " stripes - a menacing display if ever you've seen one.";
			}
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 70, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,70,0,0,0);
			this.tallness = 10*12;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.lowerBody = LowerBody.DRIDER;
			this.skinTone = LilyFollower.LilySkinTone;
			this.hairColor = LilyFollower.LilyHairColor;
			this.hairLength = 24;
			this.weaponName = "claws";
			this.weaponVerb = "claw";
			this.weaponRangeName = "bow";
			this.armorName = "carapace";
			this.armorPerk = "";
			this.armorValue = 70;
			this.nipplesPierced = 1;
			this.lust = 35;
			this.lustVuln = .2;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = rand(15) + 35;
			this.drop = new WeightedDrop().add(consumables.B_GOSSR,5)
					.add(useables.T_SSILK,1)
					.add(null,4);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}