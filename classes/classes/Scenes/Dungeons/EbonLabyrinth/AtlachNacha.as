/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.EbonLabyrinth 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;
import classes.StatusEffects.Combat.WebDebuff;

use namespace CoC;

	public class AtlachNacha extends Monster
	{
		private function atlachNachaWeb():void {
			outputText("The nightmarish spider suddenly shoots webs at you");
			//Blind dodge change
			if (hasStatusEffect(StatusEffects.Blind) && rand(3) < 2) {
				outputText(" but " + capitalA + short + " misses completely due to their blindness.");
			}
			//Determine if dodged!
			else if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				outputText(". You dodge away, avoiding the sticky strands!");
			}
			//Determine if evaded
			else if (player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
				outputText(". You evade, avoiding the sticky strands!");
			}
			//("Misdirection"
			else if (player.hasPerk(PerkLib.Misdirection) && rand(100) < 10 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
				outputText(". Your misleading movements allow you to easily sidestep the sticky strands!");
			}
			//Determine if cat'ed
			else if (player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
				outputText(". You throw yourself out of the way with cat-like agility at the last moment, avoiding " + mf("his", "her") + " attack.\n");
			}
			//Got hit
			else {
				var web:WebDebuff = player.statusEffectByType(StatusEffects.Web) as WebDebuff;
				if (web == null) {
					outputText(" causing you to become gradually entangled.\n");
					web = new WebDebuff();
					player.addStatusEffect(web);
				}
				else {
					outputText(" causing you to become more entangled. At this rate you will become unable to move.\n");
				}
				web.increase();
			}
		}
		
		private function atlachNachaArcaneWeb():void {
			outputText("The spider’s two forelegs begin moving in patterns and you understand what is going on only as your body becomes glued to what appears to be a semi-visible magical web, is this an illusion spell?!  You begin struggling against the magical web as the spider closes in.\n\n");
			player.createStatusEffect(StatusEffects.ArcaneWeb, 0, 0, 0, 0);
		}
		
		private function atlachNachaBite():void {
			outputText("The eldritch spider ");
			if (player.hasStatusEffect(StatusEffects.ArcaneWeb)) outputText("sinks its fangs in you and the wound begins to heat");
			else outputText("rushes towards you face first and you back away feeling for two new pinpricks that start heating");
			outputText(" up. Were you poisoned just now?! This might be a very bad thing.\n\n");
			player.takePhysDamage(this.str, true);
			player.dynStats("lus", 60);
			if (!player.hasPerk(PerkLib.Insanity)) {
				player.buff("Poison").addStats({"tou":-20, "int":-20, "wis":-20}).withText("Poisoned!").forHours(24);
				showStatDown( 'tou' );
				showStatDown( 'int' );
				showStatDown( 'wis' );
				if (player.tou <= 1 || player.inte <= 1 || player.wis <= 1) {
					doNext(SceneLib.combat.endHpLoss);
					return;
				}
			}
		}
		
		private function atlachNachaSilence():void {
			outputText("The arachnid horror suddenly spray webs at you, tightly gaging you so to prevent you from speaking or using your magic. <b>Your spellcasting was sealed!</b>\n\n");
			player.createStatusEffect(StatusEffects.WebSilence, 0, 0, 0, 0);
		}
		
		private function atlachNachaPinDown():void {
			outputText("The spider spits webbing gluing your wing and causing you to crash down to the ground. ");
			player.takePhysDamage((50 + (player.thickness * 2)), true);
			outputText(" <b>There is no way you will be able to fly in these conditions!</b>\n\n");
			player.createStatusEffect(StatusEffects.FlyingDisabled, 5, 0, 0, 0);
		}
		
		override protected function performCombatAction():void
		{
			if (player.isFlying() && rand(2) == 0) atlachNachaPinDown();
			else if (player.hasStatusEffect(StatusEffects.ArcaneWeb) && rand(4) > 0) atlachNachaBite();
			else {
				var choice:Number = rand(4);
				if (choice == 0) {
					if (player.spe >= 2) atlachNachaWeb();
					else atlachNachaBite();
				}
				if (choice == 1) {
					if (player.hasStatusEffect(StatusEffects.ArcaneWeb)) atlachNachaBite();
					else atlachNachaArcaneWeb();
				}
				if (choice == 2) {
					if (player.hasStatusEffect(StatusEffects.WebSilence)) atlachNachaBite();
					else atlachNachaSilence();
				}
				if (choice == 3) atlachNachaBite();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.ebonlabyrinth.defeatAtlachNacha();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.ebonlabyrinth.defeatedByAncientTentacleBeast();
		}
		
		override public function get long():String
		{
			var str:String = "";
			str += "Your fighting a… Just what the actual fuck are you fighting actualy! This thing is a nightmarish combo between a giant spider and a tentacle beast except it lacks the dick and pussy instead settling for a tentacled face barely hiding two fangs dripping with venom. ";
			str += "The creature black carapace seems to be covered in blinking red eyes watching and blinking. Everything about this horror screams madness and a terrible end should it manage to overpower you, the many silk cocoons in the chamber can attest to that!";
			return str;
		}
		
		public function AtlachNacha()
		{
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 80) {
				initStrTouSpeInte(130, 380, 184, 150);
				initWisLibSensCor(150, 370, 190, 100);
				this.armorDef = 300;
				this.armorMDef = 300;
				this.bonusHP = 4000;
				this.bonusLust = 640;
				this.level = 80;
				this.gems = 340 + rand(110);
			}
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 85) {
				initStrTouSpeInte(160, 420, 211, 173);
				initWisLibSensCor(173, 400, 230, 100);
				this.armorDef = 375;
				this.armorMDef = 375;
				this.bonusHP = 6000;
				this.bonusLust = 715;
				this.level = 85;
				this.gems = 390 + rand(120);
			}
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 90) {
				initStrTouSpeInte(190, 460, 238, 196);
				initWisLibSensCor(196, 430, 270, 100);
				this.armorDef = 450;
				this.armorMDef = 450;
				this.bonusHP = 8000;
				this.bonusLust = 790;
				this.level = 90;
				this.gems = 440 + rand(130);
			}
			this.a = " ";
			this.short = "Atlach Nacha";
			this.long = "";
			this.tallness = 12 * 6;
			this.createCock(24,4);
			this.balls = 2;
			this.ballSize = 2;
			createBreastRow(0);
			this.hoursSinceCum = 9999;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.weaponName = "fangs";
			this.weaponVerb = "bite";
			this.armorName = "chitin";
			this.additionalXP = 1500;
			this.lustVuln = 0.45;
			this.createStatusEffect(StatusEffects.AuraOfMadness, 20, 20, 0, 0);
			this.createPerk(PerkLib.DarknessNature, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.drop = NO_DROP;
			this.checkMonster();
		}
	}
}