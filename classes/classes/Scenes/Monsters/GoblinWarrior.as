package classes.Scenes.Monsters 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class GoblinWarrior extends Goblin
	{
		public function slash():void {
			outputText("The goblin charges at you with her sword!  As soon as she approaches you, she swings her sword! ");
			if (player.getEvasionRoll()) {
				outputText("You avoid her slash!");
			}
			else {
				outputText("You fail to dodge and you get hit. ");
				//Get hit
				var damage:int = str + weaponAttack + rand(40);
				player.takePhysDamage(damage, true);
			}
		}
		
		public function shieldBash():void {
			outputText("The goblin charges at you with her shield! ");
			if (player.getEvasionRoll()) {
				outputText("You avoid her shield bash!");
			}
			else {
				outputText("Her shield hits you! ");
				//Get hit
				if (rand(100) < 40 && player.findPerk(PerkLib.Resolute) < 0) {
					outputText("The impact from the shield has left you with a concussion. <b>You are stunned.</b> ");
					player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				}
				var damage:int = str + rand(10);
				player.takePhysDamage(damage, true);
			}
		}
		
		public function warriorSpecial():void {
			if (rand(2) == 0) slash();
			else shieldBash();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.goblinWarriorScene.goblinWarriorRapeIntro();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.gender == 0 || flags[kFLAGS.SFW_MODE] > 0) {
				outputText("You collapse in front of the goblin, too wounded to fight.  She growls and kicks you in the head, making your vision swim. As your sight fades, you hear her murmur, \"<i>Fucking dicks can't even bother to grow a dick or cunt.</i>\"");
				SceneLib.combat.cleanupAfterCombatImpl();
			} 
			else {
				SceneLib.goblinWarriorScene.gobboWarriorBeatYaUp();
			}
		}
		
		public function GoblinWarrior() 
		{
			this.a = "the ";
			this.short = "goblin warrior";
			this.imageName = "goblinwarrior";
			this.long = "The goblin before you is slightly taller than most of the goblins and her hair is a deep red hue. She has dark green skin and her ears are pierced in several spots. Unlike most goblins you've seen, this one is well armed. She's wearing a metal breastplate that covers her torso, offering her more defense. There are more straps covering her legs than a goblin typically has. She's wielding a shortsword in her right hand and a wooden shield in her left hand. Despite how well-armed she is, her nipples and cooter are exposed.";
			if (player.hasCock()) this.long += "  She's clearly intent on beating you up just so she can forcibly make you impregnate her.";
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 44 + rand(7);
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.skinTone = "dark green";
			this.hairColor = "red";
			this.hairLength = 4;
			initStrTouSpeInte(75, 50, 70, 72);
			initWisLibSensCor(70, 45, 45, 60);
			this.weaponName = "sword and shield";
			this.weaponVerb = "slash";
			this.weaponAttack = 14;
			this.armorName = "platemail";
			this.armorDef = 12;
			this.bonusHP = 400;
			this.bonusLust = 20;
			this.lust = 50;
			this.lustVuln = 0.44;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 16;
			this.gems = rand(15) + 15;
			this.drop = new WeightedDrop().
					add(consumables.GOB_ALE,5).
					addMany(1,consumables.L_DRAFT,
							consumables.PINKDYE,
							consumables.BLUEDYE,
							consumables.ORANGDY,
							consumables.GREEN_D,
							consumables.PURPDYE);
			this.special1 = goblinDrugAttack;
			this.special2 = goblinTeaseAttack;
			this.special3 = warriorSpecial;
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
