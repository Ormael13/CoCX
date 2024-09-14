package classes.Scenes.Areas.Forest
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Monsters.Goblin;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

public class TamanisDaughters extends Goblin
	{
		private function midRoundMadness():void {
			var selector:Number = rand(4);
			if(selector == 0) {
				outputText("A slender hand reaches inside your [armor] and gives your ");
				if(player.hasBalls()) {
					if(rand(2) == 0) outputText(player.multiCockDescriptLight());
					else outputText(player.ballsDescriptLight());
				}
				else outputText(player.multiCockDescriptLight());
				outputText(" a gentle squeeze.  You twist away but your breathing gets a little heavier.\n\n");
			}
			else if(selector == 1) {
				outputText("A girl latches onto your [legs] and begins caressing your body lovingly, humming happily.  You quickly shake her loose but the attention makes you blush a little more.\n\n");
			}
			else if(selector == 2) {
				outputText("One of your daughters launches onto your back and presses her hard, pierced nipples against your neck.  She whispers in your ear, \"<i>Twist my nipples dad!</i>\"\n\n");
				outputText("You reach back and throw her off, but her perverted taunts still leave you feeling a little hot under the collar.\n\n");
			}
			else outputText("A daughter lays down in front of you and starts jilling herself on the spot.  It's impossible to not glance down and see her or hear her pleasured moans.  You step away to remove the distraction but it definitely causes some discomfort in your [armor].\n\n");
			player.takeLustDamage(1 + player.lib/15+rand(player.cor/30), true);
		}

		private function tamaniShowsUp():void {
			if (TamainsDaughtersScene.tamaniPresent) {
				if (rand(4) == 0) goblinDrugAttack(); //Tamani already there - chance of potion
			}
			else if (rand(6) == 0) {
				TamainsDaughtersScene.tamaniPresent = true;
				outputText("A high-pitched yet familiar voice calls out, \"<i><b>So this is where you skanks ran off to---wait a second.  Are you trying to poach Tamani's man!?</b></i>\"\n\n");
				outputText("You can see Tamani lurking around the rear of the goblin pack, visibly berating her daughters.  On one hand it sounds like she might help you, but knowing goblins, she'll probably forget about her anger and help them subdue you for more cum...\n\n");
				//(+5 mob strength)
				strStat.core.value += (5 * (1 + flags[kFLAGS.TAMANI_LVL_UP]));
				//(+5 mob toughness)
				touStat.core.value += (5 * (1 + flags[kFLAGS.TAMANI_LVL_UP]));
				HP += (10 * (1 + flags[kFLAGS.TAMANI_LVL_UP]));
				//(-20 mob lust)
				lust -= 20;
				//append combat desc
				long += " <b>Tamani lurks in the back of the crowd, curvier than her brood and watching with a mixture of amusement and irritation.  She runs a hand through her pink and black hair, waiting for an opportunity to get involved...</b>";
			}
		}

		override protected function performCombatAction():void
		{
			midRoundMadness();
			tamaniShowsUp();
			var choice:Number = rand(4);
			if (choice == 0) special2();
			if (choice == 1) special1();
			if (choice >= 2) {
				createStatusEffect(StatusEffects.Attacks, int((flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] / 20) + (flags[kFLAGS.TAMANI_DAUGHTERS_LVL_UP] / 2)), 0, 0, 0); //Tamani's Daughters get multiattacks!
				eAttack();
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.forest.tamaniDaughtersScene.combatWinAgainstDaughters();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foes seem visibly disgusted and leave, telling you to, \"<i>quit being so fucking gross...</i>\"");
				SceneLib.combat.cleanupAfterCombatImpl();
			} else {
				SceneLib.forest.tamaniDaughtersScene.loseToDaughters();
			}
		}

		public function TamanisDaughters()
		{
			super(true);
			var mod1:int = (flags[kFLAGS.TAMANI_DAUGHTERS_LVL_UP] + flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS]);
			var mod2:int = ((flags[kFLAGS.TAMANI_DAUGHTERS_LVL_UP]*6) + flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS]);
			this.a = "the group of ";
			this.short = "Tamani's daughters";
			this.imageName = "tamanisdaughters";
			this.long = "A large grouping of goblin girls has gathered around you, surrounding you on all sides.  Most have varying shades of green skin, though a few have yellowish or light blue casts to their skin.  All are barely clothed, exposing as much of their flesh as possible in order to excite a potential mate.  Their hairstyles are as varied as their clothing and skin-tones, and the only things they seem to have in common are cute faces and curvy forms.  It looks like they want something from you.";
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
			this.tallness = 40;
			this.hips.type = Hips.RATING_AMPLE + 1;
			this.butt.type = Butt.RATING_NOTICEABLE + 1;
			this.bodyColor = "greenish gray";
			this.hairColor = "pink";
			this.hairLength = 16;
			initStrTouSpeInte(55+mod1*8, 30+mod1*4, 45+mod1*6, 50+mod1*10);
			initWisLibSensCor(50+mod1*10, 70+mod1*60, 70+mod1*20, 10);
			this.weaponName = "fists";
			this.weaponVerb="tiny punch";
			this.weaponAttack = 10 + mod1;
			this.armorName = "leather straps";
			this.armorDef = 10 + (mod1*10);
			this.armorMDef = 2 + (mod1*2);
			this.bonusHP = (100 * (1 + mod2));
			this.bonusLust = 148 + (mod1 * 80) + mod2;
			this.lust = 30;
			this.lustVuln = .65;
			this.level = 8 + mod2;
			this.gems = rand(15) + 5;
			this.drop = new WeightedDrop().
					add(consumables.GOB_ALE,5).
					addMany(1,consumables.L_DRAFT,
							consumables.PINKDYE,
							consumables.BLUEDYE,
							consumables.ORANGDY,
							consumables.PURPDYE);
			this.special1 = goblinDrugAttack;
			this.special2 = goblinTeaseAttack;
			if (flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] > 20) this.createPerk(PerkLib.EnemyLargeGroupType, 0, 0, 0, 0);
			else this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			if (flags[kFLAGS.TAMANI_DAUGHTERS_LVL_UP] >= 2) this.createPerk(PerkLib.JobSeducer, 0, 0, 0, 0);
			if (flags[kFLAGS.TAMANI_DAUGHTERS_LVL_UP] >= 4) this.createPerk(PerkLib.JobCourtesan, 0, 0, 0, 0);
			if (flags[kFLAGS.TAMANI_DAUGHTERS_LVL_UP] >= 6) this.createPerk(PerkLib.JobEromancer, 0, 0, 0, 0);
			if (flags[kFLAGS.TAMANI_DAUGHTERS_LVL_UP] >= 8) this.createPerk(PerkLib.EpicLibido, 0, 0, 0, 0);
			if (flags[kFLAGS.TAMANI_DAUGHTERS_LVL_UP] >= 10) this.createPerk(PerkLib.EpicToughness, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
