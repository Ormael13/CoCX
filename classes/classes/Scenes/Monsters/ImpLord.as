package classes.Scenes.Monsters
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class ImpLord extends Imp
	{
		//sMaSh
		protected function sMaSh():void
		{
			str *= 4;
			eAttack();
			str *= 0.25;
		}
		
		//Special Attack 1
		protected function impFire():void
		{
			//[-HP // +Lust(minor)]
			var damage:int = 40 + rand(10);
			if (player.hasStatusEffect(StatusEffects.Blizzard)) {
			player.addStatusValue(StatusEffects.Blizzard, 1, -1);
			outputText("The imp mutters something to himself. Before you have time to react the demonic creature's hand is filled with a bright red fire that he hurls at you.  The flames lick at your body leaving a small burn on you torso due to protedction of blizzard, as well as an arousing heat in your groin. ");
			damage *= 0.2;
			}
			else {
			outputText("The imp mutters something to himself. Before you have time to react the demonic creature's hand is filled with a bright red fire that he hurls at you.  The flames lick at your body leaving a painful burn on you torso, as well as an arousing heat in your groin. ");
			}
			damage = Math.round(damage);
			player.takeFireDamage(damage, true);
			player.dynStats("lus", 20 + player.cor / 10);
		}
		
		//Heavy Attack
		protected function impLordHeavyEncounter():void
		{
			var damage:int = int((str + weaponAttack + 20) - rand(player.tou) - player.armorDef);
			outputText("The demonic creature slashes a clawed hand towards your stomach,");
			if (player.getEvasionRoll()) outputText(" but you handily avoid it.");
			else if (damage <= 0) outputText(" but the attack proves ineffectual.");
			else {
				outputText("leaving a large gash. The attack leaves you slightly stunned, but you recover. ");
				player.takePhysDamage(damage, true);
			}
		}

		//Lust Attack
		protected function impLordLustAttack():void
		{
			outputText("Lowering his loincloth the imp reveals his inhumanly thick shaft.  He smirks and licks his lips as he gives his cock a squeeze, milking a few beads of clear pre from the tip.  You shake your head and try to ignore your growing need.");
			//[+Lust]
			player.dynStats("lus", 5 + player.lib / 5 + player.cor / 5);
		}

		//Lust and Light Attack
		protected function impLordLustAttack2():void
		{
			outputText("Reaching into his satchel the devilish creature pulls out a leather riding crop.  He quickly rushes forward, but somehow manages to get behind you.  Before you can react the imp lashes out, striking your [butt] twice with the riding crop.  The strikes leave a slight burning feeling, as well as a strange sense of arousal. ");
			var damage:int = 3 + rand(10);
			player.takePhysDamage(damage, true);
			//[-HP(minor) // +Lust]
			player.dynStats("lus", 5 + player.sens / 4 + player.cor / 10);
		}
        override protected function performCombatAction():void
		{
			var choices:Array = [impFire, impLordLustAttack2, impLordLustAttack, impLordHeavyEncounter, eAttack];
			choices[rand(choices.length)]();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.SiegweirdImp)) {
				player.removeStatusEffect(StatusEffects.SiegweirdImp);
				cleanupAfterCombat();
				SceneLib.siegweirdFollower.siegweirdFirstEncounterPostFight();
			}
			else {
				game.flags[kFLAGS.DEMONS_DEFEATED]++;
				SceneLib.impScene.defeatImpLord();
			}
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.SiegweirdImp)) {
				player.removeStatusEffect(StatusEffects.SiegweirdImp);
				SceneLib.impScene.impRapesYou();
			}
			else SceneLib.impScene.loseToAnImpLord();
		}

		public function ImpLord()
		{
			super(true);
			this.a = "the ";
			if (player.hasStatusEffect(StatusEffects.SiegweirdImp)) this.short = "imp with a huge greatsword";
			else this.short = "imp lord";
			this.imageName = "implord";
			if (player.hasStatusEffect(StatusEffects.SiegweirdImp)) this.long = "You are under attack by an imp wielding a huge greatsword! The imp’s arms are so muscular it would be funny if not for the fact he’s trying to split you in half with a weapon trice his size!";
			else this.long = "The greater imp has an angular face, complete with curved nose and burnt red skin typical of imps.  He has no hair on his head, leaving his cold, lust-clouded, black eyes unobstructed.  Just above his long pointed ears are two curved bovine horns.  While still short, he's much taller then the average imp, being nearly four feet tall, and extremely well-muscled.  A pair of powerful wings extends out from his shoulders, however, you suspect he wouldn't be able to fly for long due to his extreme bulk.  A thick coating of fur starts at his well toned hips and works its way down his powerful legs.  His legs end in a pair of oddly jointed, demonic hooves.  His demonic figure is completed by a thin tail that has an arrowhead shaped tip.\n\nThe greater imp, like most imps wear very little clothing; only a simple loincloth and satchel hang from his waist.  You also note that the imp has two barbell piercings in his nipples. The creature doesn't seem to have any weapons, aside from his sharp black finger nails.";
			// this.plural = false;
			// Imps now only have demon dicks.
			// Not sure if I agree with this, I can imagine the little fuckers abusing the
			// shit out of any potions they can get their hands on.
			this.createCock(rand(2)+11,2.5,CockTypesEnum.DEMON);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 3;
			this.hoursSinceCum = 20;
			if (flags[kFLAGS.IMP_LORD_MALEHERM_PROGRESS] >= 10 && !player.hasStatusEffect(StatusEffects.SiegweirdImp)) this.createVagina();
			createBreastRow(0);
			this.pronoun1 = "he";
			this.pronoun2 = "him";
			this.pronoun3 = "his";
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = rand(14) + 40;
			this.hips.type = Hips.RATING_BOYISH;
			this.butt.type = Butt.RATING_TIGHT;
			this.lowerBody = LowerBody.HOOFED;
			this.skinTone = "red";
			initStrTouSpeInte(55, 40, 45, 42);
			initWisLibSensCor(42, 55, 35, 100);
			if (player.hasStatusEffect(StatusEffects.SiegweirdImp)) {
				this.weaponName = "fist";
				this.weaponVerb="punch";
				this.weaponAttack = 10;
			}
			else {
				this.weaponName = "huge greatsword";
				this.weaponVerb="slash";
				this.weaponAttack = 40;
			}
			this.armorName = "leathery skin";
			this.armorDef = 5;
			this.armorMDef = 1;
			this.bonusHP = 100;
			this.bonusLust = 30;
			this.lust = 30;
			this.lustVuln = .65;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 7;
			this.gems = rand(15) + 25;
			this.drop = new WeightedDrop().
					add(consumables.MINOBLO,1).
					add(consumables.LABOVA_,1).
					add(consumables.INCUBID,6).
					add(consumables.SUCMILK,6);
			this.wings.type = Wings.IMP;
			if (player.hasStatusEffect(StatusEffects.SiegweirdImp)) this.special1 = sMaSh;
			else this.special1 = lustMagicAttack;
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
