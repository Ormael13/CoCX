/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Forest 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.Scenes.Holidays;
import classes.Scenes.SceneLib;
import classes.internals.ChainedDrop;
import classes.display.SpriteDb;

public class Alraune extends Monster
	{
		public function trapLevel(adjustment:Number = 0):Number {
			if(!hasStatusEffect(StatusEffects.Level)) createStatusEffect(StatusEffects.Level,6,0,0,0);
			if(adjustment != 0) {
				addStatusValue(StatusEffects.Level,1,adjustment);
				if(statusEffectv1(StatusEffects.Level) < 1) changeStatusValue(StatusEffects.Level,1,1);
				if(statusEffectv1(StatusEffects.Level) > 6) changeStatusValue(StatusEffects.Level,1,6);
			}
			return statusEffectv1(StatusEffects.Level);
		}
		
		public function alrauneStruggle():void {
			clearOutput();
			if (this.short == "snow lily alraune") game.spriteSelect(SpriteDb.s_snow_lily);
			else if (this.short == "cinderbloom alraune") game.spriteSelect(SpriteDb.s_cinderbloom);
			else game.spriteSelect(SpriteDb.s_alraune);
			outputText("You struggle against ");
			if (Holidays.isHalloween()) outputText("Jack-O-Raune");
			else outputText("the " + this.short + "");
			outputText(" vines, forcefully pulling yourself a good distance away from her.\n\n");
			trapLevel(2);
			player.fatigue += 50;
		}
		
		public function alraunePollenCloud():void {
			if (Holidays.isHalloween()) outputText("Jack-O-Raune");
			else outputText("The alraune");
			outputText(" giggles as she unleashes a thick cloud of pollen in your general direction.\n\n");
			outputText("\"<i>Just give in to me. I will make it so pleasurable for you.</i>\"\n\n");
			outputText("There is no way you will be able to not breathe it in and you feel your desire rise as the insidious aphrodisiac does its dirty work.\n\n");
			createStatusEffect(StatusEffects.LustAura, 0, 0, 0, 0);
		}
		
		public function alrauneStrangulate():void {
			if (Holidays.isHalloween()) outputText("Jack-O-Raune");
			else outputText("The alraune");
			outputText("’s vines suddenly wrap tight around your neck and strangle you, preventing you from pronouncing any incantations. The ");
			if (Holidays.isHalloween()) outputText("pumpkin");
			else outputText("plant");
			outputText(" woman gives you an annoyed glare.");
			outputText("\"<i>I’m done with your magic. Be a good " + player.mf("boy", "girl") + " and just give in.</i>\"");
			player.removeStatusEffect(StatusEffects.CastedSpell);
			player.createStatusEffect(StatusEffects.Sealed, 2, 10, 0, 0);
		}
		
		public function alrauneTeaseAttack():void {
			if (rand(2) == 1) {
				if (Holidays.isHalloween()) outputText("Jack-O-Raune");
				else outputText("The alraune");
				outputText(" parts her grass-like hair away to reveal her supple breasts, moving her other hand to her nectar drenched pussy then back to her mouth. She sensually licks her fingers clean, then blows you a kiss.\n\n");
				outputText("\"<i>Don’t you want a taste of what my lovely body can offer? It is all yours to play with, all you need to do is give in to me.</i>\"\n\n");
			}
			else {
				if (Holidays.isHalloween()) outputText("Jack-O-Raune");
				else outputText("The alraune");
				outputText(" grabs some of her nectar suggestively, letting it flow all over her breast, thigh and even in her hair.\n\n");
				outputText("\"<i>Mmmmmmm I so love being covered in sticky fluids. How about you?</i>\"\n\n");
			}
			outputText("Unable to take your gaze away from her lewd show, you feel yourself getting more aroused. ");
			var lustDmg:int = rand(player.lib / 20) + rand(this.lib / 10) + 10;
			player.dynStats("lus", lustDmg);
			outputText("\n\n");
		}
		
		public function alrauneHaloweenSpecial():void {
			outputText("The Jack-O-Raune suddenly starts laughing and throwing small pumpkins at you. They explode upon contact splashing you with what seems to be aphrodisiac.\n\n");
			alrauneHaloweenSpecial1();
			alrauneHaloweenSpecial1();
			alrauneHaloweenSpecial1();
		}
		public function alrauneHaloweenSpecial1():void {
			if (player.getEvasionRoll()) outputText("The pumpkin miss you by a few inch.\n");
			else {
				var damage:int = 5 + rand(20);
				damage = Math.round(damage);
				var lustDmg:int = rand(player.lib / 25) + rand(this.lib / 15) + 5;
				lustDmg = Math.round(lustDmg);
				outputText("You are hit by a pumpkin for " + damage + " damage! " + lustDmg + " lust damage!");
				damage = player.takePhysDamage(damage, true);
				player.dynStats("lus", lustDmg);
				outputText("\n");
			}
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Level)) {
				if (!hasStatusEffect(StatusEffects.Stunned) && player.hasStatusEffect(StatusEffects.CastedSpell)) alrauneStrangulate();
				else {
					if (Holidays.isHalloween()) {
						var choice1:Number = rand(3);
						if (choice1 == 0) alrauneTeaseAttack();
						if (choice1 == 1) {
							if (!hasStatusEffect(StatusEffects.LustAura)) alraunePollenCloud();
							else alrauneTeaseAttack();
						}
						if (choice1 == 2) alrauneHaloweenSpecial();
					}
					else {
						var choice2:Number = rand(2);
						if (choice2 == 0) alrauneTeaseAttack();
						if (choice2 == 1) {
							if (!hasStatusEffect(StatusEffects.LustAura)) alraunePollenCloud();
							else alrauneTeaseAttack();
						}
					}
				}
				if (!hasStatusEffect(StatusEffects.Climbed)) {
					outputText("\n\nMeanwhile the vines keep pulling you toward the pitcher.");
					trapLevel(-1);
				}
				else removeStatusEffect(StatusEffects.Climbed);
			}
			else super.performCombatAction();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.forest.alrauneScene.alrauneDeepwoodsWon();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			SceneLib.forest.alrauneScene.alrauneDeepwoodsLost();
		}
		
		public function Alraune() 
		{
			super();
			if (Holidays.isHalloween()) {
				this.a = "";
				this.short = "Jack-O-Raune";
				this.long = "You are fighting against a Jack-O-Raune, an intelligent plant with the torso of a woman and the lower body of a giant pumpkin with snaking tentacle vines. She seems really keen on raping you.";
				this.skinTone = "pale orange";
				this.hairColor = "green";
			}
			else {
				this.a = "an ";
				this.short = "alraune";
				this.long = "You are fighting against an Alraune, an intelligent plant with the torso of a woman and the lower body of a giant flower. She seems really keen on raping you.";
				this.skinTone = "light green";
				this.hairColor = "dark green";
			}
			this.imageName = "alraune";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_GAPING);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = rand(14) + 59;
			this.hips.type = Hips.RATING_CURVY + 3;
			this.butt.type = Butt.RATING_EXPANSIVE;
			this.lowerBody = LowerBody.PLANT_FLOWER;
			this.hairLength = 6;
			initStrTouSpeInte(10, 100, 10, 60);
			initWisLibSensCor(60, 100, 50, 0);
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.weaponAttack = 1;
			this.armorName = "skin";
			this.armorDef = 45;
			this.armorMDef = 5;
			this.bonusHP = 100;
			this.bonusLust = 20;
			this.lust = 20 + rand(40);
			this.lustVuln = 0.2;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 24;
			this.gems = rand(20) + 5;
			this.drop = new ChainedDrop().add(consumables.MARAFRU, 1 / 6);
				//	.add(consumables.W__BOOK, 1 / 4)
				//	.add(consumables.BEEHONY, 1 / 2)
				//	.elseDrop(useables.B_CHITN);
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
			this.createStatusEffect(StatusEffects.GenericRunDisabled, 0, 0, 0, 0);
			createStatusEffect(StatusEffects.Level,6,0,0,0);
			checkMonster();
		}
		
	}

}