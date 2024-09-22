package classes.Items.Consumables
{
import classes.BaseContent;
import classes.CoC;
import classes.EventParser;
import classes.PerkLib;
import classes.VaginaClass;
import classes.BodyParts.*;
import classes.internals.Utils;
import classes.Items.Consumable;
import classes.Races.DemonRace;
import classes.Scenes.SceneLib;

public class DemonizeMe extends Consumable {
		
		public function DemonizeMe() 
		{
			super("DemonMe", "DemonizeMe", "a bottle of Demonize Me", 300, "The oil-like dark blue substance within the bottle seems ordinary enough, as normal as unholy fluids can get.");
		}
		
		override public function canUse():Boolean {
			if (!player.blockingBodyTransformations()) return true;
			outputText("How do you want transform with this perfect form already attained?\n\n");
			return false;
		}

		override public function useItem():Boolean {
			outputText("You pop off the greasy cap, the smell of rotten flesh invading your lungs.\n\n");
			if (player.hasPerk(PerkLib.Soulless)) {
				outputText("A wave of euphoria washes over you as you lock your lips around the bottle. Not only allowing the invasive liquid, you force it down your throat with unimaginable hunger- LUST.\n");
				outputText("Sheer expectation is enough to {} (gender arousal here with tits, dicks and cunts)\n\n");
				outputText("The liquid grows colder and colder as it slowly fills your stomach. Wait, colder?\n");
				outputText("You wait for an hour or so. Your reward is not the blissful pain, but an inconvenient food poisoning...\n\n");
				outputText("You stand before Mareth exactly as you were mocked to be.\n\n");
				outputText("Clueless.. and in distress.\n\n");
			}
			else {
				player.skin.setBaseOnly({type:Skin.PLAIN, color1:"blue", pattern: Skin.PATTERN_DEMONIC_PLEASURE_RUNE});
				if (!InCollection(player.skinColor1, DemonRace.DemonSkinColors) && !InCollection(player.skinColor2, DemonRace.DemonSkin2Colors)) {
					var choice1:String = randomChoice(DemonRace.DemonSkinColors);
					var choice2:String = randomChoice(DemonRace.DemonSkin2Colors);
					player.skinColor1 = choice1;
					player.skinColor2 = choice2;
				}
				if (player.cor <= 50) {
					outputText("Relucantly you raise the bottle to your lips. As soon as you take the first sip, rest of the oily fluid moves on its own. You cannot move your limbs, nor cough, not even blink.\n");
					outputText("The liquid grows hotter and hotter as it slowly fills your stomach. Or is it you thats getting hotter? Hard to distinguish.\n\n");
					outputText("A wave of dread takes you under once you realise you are not sweating, you are bleeding!\n");
					outputText("Every single orifice, from tiniest of pores to largest of cavities is vomiting out blood.\n\n");
					outputText("It feels like needles stabbing your skin from underneath all over your body.\n");
					outputText("The deafening sounds of your screams, soon muffled behind a small pool of boiling blood.\n");
					outputText("Your ears clogged, your skin covered from head to toe with blood.\n");
					outputText("At last, it starts pouring out of your eyes, cutting off your last remaining connection to outside world.\n");
					outputText("Excruciating pain clouds your perception of time.\n\n");
					outputText("Boiling blood is on constant move right above your skin, yet not a single drop has smeared the ground.\n");
					outputText("Its colour changes from red to "+player.skinColor1+" before your body slowly starts to drain it back.\n\n");
					outputText("There are now extra weights on your back and head, disrupting your attempts at standing on your feet. You collapse on to the ground.\n\n");
					outputText("You rise a different person, a different champion. Not of Ingam, but someone worthy of Mareth. You can see the world as it saw you all this time.\n\n");
					outputText("Ripe for the taking.\n\n");
				}
				else {
					outputText("Excitement takes over you as you raise the bottle to your lips. The first gulp welcomes the next, oily fluid moves on its own. You cannot move your limbs, any sign of resistance instantly fades away.\n");
					outputText("The liquid grows hotter and hotter as it slowly fills your stomach. Or is it you thats getting hotter? Hard to distinguish.\n\n");
					outputText("Your thoughts are interrupted with increasing volume of blood covering your skin. YOUR BLOOD.\n");
					outputText("Every single orifice, from tiniest of pores to largest of cavities is vomiting out blood.\n\n");
					outputText("It feels like needles stabbing your skin from underneath all over your body.\n\n");
					outputText("The deafening sounds of your screams, soon muffled behind a small pool of boiling blood.\n");
					outputText("Your ears clogged, your skin covered from head to toe with blood.\n");
					outputText("At last, it starts pouring out of your eyes, cutting off your last remaining connection to outside world.\n");
					outputText("Excruciating pain clouds your perception of time.\n\n");
					outputText("Boiling blood is on constant move right above your skin, yet not a single drop has smeared the ground.\n");
					outputText("Its colour changes from red to "+player.skinColor1+" before your body slowly starts to drain it back.\n\n");
					outputText("New additions on your back and head momentarily disorients you.\n\n");
					outputText("You rise from the ashes of so-called Champion. You are no longer the \"<i>Lamb of Ingam</i>\". You are someone strong, someone to be feared!.. And desired.\n\n");
					outputText("As you are observing your new wings, tail and extra demonic additions, the small note written at the bottom of the label catches your eye.\n");
					outputText("\"<i>Use in small dosage.</i>\"\n\n");
				}
				if (player.hasCock()) player.lowerBody = LowerBody.DEMONIC_CLAWS;
				else {
					if (rand(2) == 0) player.lowerBody = LowerBody.DEMONIC_CLAWS;
					else {
						if (rand(2) == 0) player.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
						else player.lowerBody = LowerBody.DEMONIC_GRACEFUL_FEET;
					}
				}
				player.legCount = 2;
				CoC.instance.transformations.TailDemonic.applyEffect(false);
				CoC.instance.transformations.HairHuman.applyEffect(false);
				CoC.instance.transformations.FaceDemon.applyEffect(false);
				CoC.instance.transformations.EyesDemon.applyEffect(false);
				CoC.instance.transformations.ArmsDemon.applyEffect(false);
				CoC.instance.transformations.TongueDemonic.applyEffect(false);
				CoC.instance.transformations.EarsElfin.applyEffect(false);
				CoC.instance.transformations.HornsDemonic.applyEffect(false);
				CoC.instance.transformations.AntennaeNone.applyEffect(false);
				CoC.instance.transformations.GillsNone.applyEffect(false);
				CoC.instance.transformations.WingsDemonicLarge.applyEffect(false);
				CoC.instance.transformations.RearBodyNone.applyEffect(false);
				if (player.hasCock()) CoC.instance.transformations.CockDemon().applyEffect(false);
				if (player.hasVagina()) CoC.instance.transformations.VaginaDemonic().applyEffect(false);
				outputText("\n<b>Gained Perk: Soulless!</b> "+PerkLib.Soulless.desc());
				player.createPerk(PerkLib.Soulless, 0, 0, 0, 0);
				player.npcsThatLeaveSoullessPC();
				if (player.level < 25) SceneLib.inventory.takeItem(CoC.instance.consumables.LETHITE, EventParser.playerMenu);
				else if (player.level < 50) SceneLib.inventory.takeItem(CoC.instance.consumables.LETH1TE, EventParser.playerMenu);
				else if (player.level < 75) SceneLib.inventory.takeItem(CoC.instance.consumables.LETH2TE, EventParser.playerMenu);
				else SceneLib.inventory.takeItem(CoC.instance.consumables.LETH3TE, EventParser.playerMenu);
			}
			return false;
		}
	}
}