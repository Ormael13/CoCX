/**
 * ...
 * @author Zevos
 */
package classes.Scenes.Places.HeXinDao 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.internals.*;

public class IgnisArenaSeer extends Monster
	{
		public var ignisfight:IgnisArenaSeerScene = new IgnisArenaSeerScene();
		
		public function IgnisCastsNuke():void {
			outputText("Ignis raises his palm, a orb of fire appearing above it.  Then without warning, the fire radiates out with the force of an explosion! You are buffeted by wave after wave of flames, burning hotter than you could have ever imagined. ");
			if (player.findPerk(PerkLib.SoulSprite) > 0 || player.findPerk(PerkLib.Archmage) > 0) outputText("You try and cast makeshift defenses around yourself, with limited success. ");
			outputText("You try and huddle down and take shelter from the infernal storm, but the fire is everywhere. Then, as suddenly as the flame came, they are gone.\n\n");
			this.createStatusEffect(StatusEffects.IgnisCastedNuke, 0, 0, 0, 0);
			var damage:Number = 5000;
			damage += 2000 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				player.removeStatusEffect(StatusEffects.Blizzard);
				damage *= 0.5;
			}
			damage = Math.round(damage);
			if (player.findPerk(PerkLib.SoulSprite) > 0) player.takeFireDamage(damage, true);
			if (player.findPerk(PerkLib.Archmage) > 0) player.takeFireDamage(damage, true);
			player.takeMagicDamage(damage, true);
		}
		
		public function IgnisCastsFoxFire():void {
			outputText("Holding out his palm, Ignis conjures a blaze of blue flames, dancing across his palm. He casts the flame towards you, the flames twisting mid air to foil your attempts to dodge them.  On contact, the azure fires burst like fireworks, covering the area around you with color and light. ");
			var damage:Number = 0;
			damage += inteligencescalingbonus() * 0.5;
			damage += wisdomscalingbonus() * 0.5;
			damage = Math.round(damage);
			player.takeFireDamage(damage, true);
			outputText(" ");
			var lustDmg:Number = player.lustVuln * ((this.inte / 10) + rand(player.lib + player.cor) / 5);
			lustDmg = Math.round(lustDmg);
			player.dynStats("lus", lustDmg, "scale", false);
			if (!hasStatusEffect(StatusEffects.IgnisCounter)) createStatusEffect(StatusEffects.IgnisCounter, 1, 0, 0, 0);
			else addStatusValue(StatusEffects.IgnisCounter, 1, 1);
		}
		
		public function IgnisCastsComet():void {
			outputText("Ignis raises a hand, focusing with intensity.  From above comes a crystalline meteor, which you barely manage to dodge.  The crystal shatters upon contact with the ground, sending a shower of splinters that you cannot avoid. ");
			if (player.armorPerk == "Heavy" || player.armorPerk == "Ayo") outputText("Thankfully, your armor manages to absorb most of the impact. ");
			var damage:Number = 0;
			damage += inteligencescalingbonus();
			if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
			if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
			if (player.armorPerk != "Heavy" || player.armorPerk != "Ayo") damage *= 2;
			damage = Math.round(damage);
			player.takeMagicDamage(damage, true);
			removeStatusEffect(StatusEffects.IgnisCounter);
		}
		
		override protected function performCombatAction():void
		{
			if (!this.hasStatusEffect(StatusEffects.IgnisCastedNuke)) IgnisCastsNuke();
			else {
				if (this.statusEffectv1(StatusEffects.IgnisCounter) > 2) IgnisCastsComet();
				else IgnisCastsFoxFire();
			}
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			ignisfight.PCisBeatenByIgnisAtArena();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			clearOutput();
			if (HP <= 0) outputText("Ignis staggers, signaling he’s had enough.  \"<i>I surrender!  I surrender!  Damn...  You’re pretty good, [name].</i>\"");
			else outputText("Ignis collapses, his self control finally taxed beyond limit.  He throws aside his kimono and begins vigorously masturbating, in full view of everyone in the arena’s stands. Within a minute, Ignis’ foxcock is hanging limp and the kitsune himself is covered in several layers of his own cum.  After catching his breath, he shakily puts his kimono on and gestures at you.  \"<i>That was quite a display.  You could give the demons a run for their money.!</i>\"");
			outputText(" He walks up to you, still somewhat shaky from the fight.  ");
			ignisfight.PCbeatenIgnisAtArena();
		}
		
		override public function get long():String
		{
			var ignisBelow50:Boolean = (HP < maxHP() * 0.5);
			return "You’re facing Ignis, a kitsune seer.   The white furred kitsune is wearing a "+
					(ignisBelow50?("torn "):"") +
					"grey kimono, flickering with magical flames. "+
					(hasStatusEffect(StatusEffects.KnowsChargeA)?"It seems Ignis is using a variant of charged armor. ":"") +
					"Ignis’ left hand is lit up by an aura of blue flames, ready to flare up into gouts of foxfire at a moment’s notice. In his right hand is his metal staff, foxfire burning at it’s tip.";
		}
		
		public function IgnisArenaSeer() 
		{
			this.a = "";
			this.short = "Ignis, the Seer of the Arena";
			this.imageName = "ignis";
			this.long = "";
			// this.plural = false;
			this.createCock(15,2.5,CockTypesEnum.FOX);
			this.balls = 2;
			this.ballSize = 4;
			this.cumMultiplier = 6;
			this.hoursSinceCum = 400;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = rand(24) + 60;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.skinTone = "white";
			this.hairColor = "silver";
			this.hairLength = 13 + rand(20);
			initStrTouSpeInte(45, 75, 180, 160);
			initWisLibSensCor(160, 70, 85, 45);
			this.weaponName = "staff";
			this.weaponVerb="smack";
			this.weaponAttack = 8;
			this.armorName = "grey kimono";
			this.armorDef = 20;
			this.armorMDef = 50;
			this.bonusHP = 120;
			this.bonusLust = 20;
			this.lust = 20;
			this.lustVuln = 0.9;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 45;//mają wtedy tylko 2 ogony ale z czasem jak PC też rośnie w siłe z lvl-em bdą mieć awans to lvl może 18-20 i trzeci ogon plus wzmocnienie statów itp.
			this.gems = rand(20) + 20;
			if (flags[kFLAGS.IGNIS_ARENA_SEER] < 3) {
			this.drop = new ChainedDrop()
					.add(headjewelries.SEERPIN, 1);
			}
			if (flags[kFLAGS.IGNIS_ARENA_SEER] > 2) {
				this.drop = new WeightedDrop().
					add(consumables.MG_SFRP,1).
					add(consumables.FOXJEWL, 4);
			}
			this.tailType = Tail.FOX;
			this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}