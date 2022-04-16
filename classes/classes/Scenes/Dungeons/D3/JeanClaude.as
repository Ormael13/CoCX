package classes.Scenes.Dungeons.D3
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.Items.*;
import classes.Scenes.Combat.CombatAbility;
import classes.Scenes.Combat.SpellsWhite.BlindSpell;
import classes.Scenes.SceneLib;

/**
	 * ...
	 * @author Gedan
	 */
	public class JeanClaude extends Monster
	{
		private function doubleAttack():void
		{
			outputText("The monstrous basilisk suddenly lunges forward, snarling wordlessly as he swings his cutlass at you twice, the blows of a savage yet expert swordsman.\n\n");
			createStatusEffect(StatusEffects.Attacks, 2, 0, 0, 0);
			eAttack();
		}
		
		override protected function performCombatAction():void
		{
			doubleAttack();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.d3.jeanClaude.beatDaFuckhugeBasilisk(hpVictory);
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.isGargoyle()) SceneLib.d3.gargoyleBadEndD3();
			else SceneLib.d3.jeanClaude.fuckhugeBasiliskFuckedYouUp(hpVictory);
		}
		
		override public function interceptPlayerAbility(ability:CombatAbility):Boolean {
			if (ability is BlindSpell) {
				outputText("Jean-Claude howls, reeling backwards before turning back to you, rage clenching his dragon-like face and enflaming his eyes. Your spell seemed to cause him physical pain, but did nothing to blind his lidless sight.");
				
				outputText("\n\n\"<i>You think your hedge magic will work on me, intrus?</i>\" he snarls. \"<i>Here- let me show you how it’s really done.</i>\" The light of anger in his eyes intensifies, burning a retina-frying white as it demands you stare into it...");
				
				if (rand(player.spe) >= 50 || rand(player.inte) >= 50) {
					outputText("\n\nThe light sears into your eyes, but with the discipline of conscious effort you escape the hypnotic pull before it can mesmerize you, before Jean-Claude can blind you.");
					
					outputText("\n\n\"<i>You fight dirty,</i>\" the monster snaps. He sounds genuinely outraged. \"<i>I was told the interloper was a dangerous warrior, not a little [boy] who accepts duels of honour and then throws sand into his opponent’s eyes. Look into my eyes, little [boy]. Fair is fair.</i>\"");
					
					HP -= int(10+(player.inte/3 + rand(player.inte/2)) * SceneLib.combat.spellModWhite());
				} else {
					outputText("\n\nThe light sears into your eyes and mind as you stare into it. It’s so powerful, so infinite, so exquisitely painful that you wonder why you’d ever want to look at anything else, at anything at- with a mighty effort, you tear yourself away from it, gasping. All you can see is the afterimages, blaring white and yellow across your vision. You swipe around you blindly as you hear Jean-Claude bark with laughter, trying to keep the monster at arm’s length.");
					
					outputText("\n\n\"<i>The taste of your own medicine, it is not so nice, eh? I will show you much nicer things in there in time intrus, don’t worry. Once you have learnt your place.</i>\"");
					
					if (!player.hasPerk(PerkLib.BlindImmunity)) player.createStatusEffect(StatusEffects.Blind, 2 + player.inte / 20, 0, 0, 0);
				}
				return true;
			}
			return false;
		}
		
		public function handleTease(lustDelta:Number, successful:Boolean):void
		{
			if (!player.hasStatusEffect(StatusEffects.RemovedArmor) && player.armor != ArmorLib.NOTHING)
			{
				outputText("\n\nJean-Claude stops circling you, looking mildly surprised as you attempt to entice him with your body.");

				outputText("\n\n\"<i>This is the legendary Champion of Ignam?</i>\" he husks. \"<i>Flaunting themselves like the most amateur of Lethice’s strippers?</i>\" His eyes glow orange. \"<i>If that was your intent all along, interloper, you should not do it so half-assedly. You should take off all your clothes, embrace what you truly are, show me what you are really made of.</i>\" The hypnotic compulsion presses upon you, commanding you to raise your hands to your [armor]’s clasps...");
				
				if (!successful)
				{
					outputText("\n\nYou grit your teeth, resist, and tear your hands away from your clothes. Jean-Claude snorts dismissively, gripping his cutlass anew.");
				}
				else
				{
					outputText("\n\nYour intent is to arouse this creature. Surely the most arousing thing you can do right now is to take off all of your clothes. You smile at him, your eyes half-lidded as you slowly, sexily slide out of your [armor], pushing your [butt] out and sucking on a finger as you loosen first the top half, then the bottom half, letting it all slide off, piece by piece. The basilisk stands back and watches, grinning, his eyes a bonfire of lust, gripping one of his girthy dicks and slowly masturbating as you kick your underclothes outwards, smouldering at him and arching your back to display your [chest].");

					outputText("\n\n\"<i>Very nice, interloper,</i>\" Jean-Claude breathes. His wide smile turns ugly. \"<i>Look forward to seeing that every night. I hope it is not too chilly in here for you.</i>\" The basilisks which surround you snigger and you blink, the scales falling from your eyes as you realize what you have just done. There is no time to claw your clothes back on: Jean-Claude is upon you, forcing you to fall back, and you will have to fight the rest of this battle in the buff!");

					// (JC arousal up one level, PC’s armor removed for rest of battle)
					player.createStatusEffect(StatusEffects.RemovedArmor, 0, 0, 0, 0);
					
					if (!this.hasStatusEffect(StatusEffects.JCLustLevel))
					{
						this.createStatusEffect(StatusEffects.JCLustLevel, 1, 0, 0, 0);
						lustVuln += 0.1;
					}
					else
					{
						this.addStatusValue(StatusEffects.JCLustLevel, 1, 1);
					}
					
					applyTease(lustDelta);
					player.dynStats("lus+", 20);
				}
			}
			else
			{
				outputText("\n\n\"<i>Even when made the fool, still you try it, still you think you can entice me with things I have seen a thousand times before,</i>\" Jean-Claude sighs. \"<i>Why not give up, interloper? You do these things because they arouse YOU, not because you hope they arouse me. Give up, and embrace the life you were born to lead.</i>\" Despite these words his hungry eyes remain on your body. Perhaps he can’t help it. You can only hope...");
				
				if (successful) applyTease(lustDelta);
				player.dynStats("lus+", 20);
			}
		}
		
		public function JeanClaude()
		{
			this.a = "";
			this.short = "Jean-Claude";
			this.imageName = "jeanclaude";
			this.long = "You are fighting Jean-Claude. He stands over seven feet tall and has a perfect frame, padded with hard, defined muscle despite not looking heavy on his feet in the slightest; the way he circles you, his thighs tensing and relaxing, his powerful tail swishing, ready to spring forward at the first hint of an opening, makes a deep, monkey part of your brain panic, warning you that you are battling an apex predator in his prime. He is dressed in a leather tunic, a bronze cuirass and a centurion’s helmet that combine to give him even more protection than his thick, green and purple mottled hide otherwise would. His eyes glow with a depthless yellow light, endlessly catching your own, enticing you to look further into them. He wields a stained-looking cutlass, which he swings by his side with mocking casualness as he moves; it mimics the movement of his dual, tumescent purple cocks, swaying beneath his tunic in crude suggestion.";
			this.plural = false;
			this.createCock(12, 2, CockTypesEnum.LIZARD);
			this.balls = 2;
			this.ballSize = 6;
			this.hoursSinceCum = 9999;
			this.createBreastRow(0);
			this.tallness = 86;
			this.ass.analLooseness = 0;
			this.ass.analWetness = 0;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE;
			this.lowerBody = LowerBody.LIZARD;
			this.skinDesc = "green-purple mottled hide";
			initStrTouSpeInte(100, 200, 110, 70);
			initWisLibSensCor(70, 40, 40, 80);
			this.faceType = Face.LIZARD;
			this.weaponName = "cutlass";
			this.weaponVerb = "slash";
			this.weaponAttack = 25;
			this.armorName = "leather tunic";
			this.armorDef = 25;
			this.armorMDef = 10;
			this.bonusHP = 1000;
			this.bonusLust = 118;
			this.lustVuln = 0.6;
			this.lust = 5;
			this.level = 38;
			this.gems = 700 + rand(100);
			this.drop = NO_DROP;
			this.createPerk(PerkLib.BasicSelfControl, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
