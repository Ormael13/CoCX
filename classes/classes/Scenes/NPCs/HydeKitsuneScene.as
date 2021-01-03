package classes.Scenes.NPCs{
import classes.*;
import classes.BodyParts.Skin;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;

public class HydeKitsuneScene extends NPCAwareContent {
	public function lostDarkKitPerk() { //I don't know. Split personality?
		if (player.findPerk(PerkLib.DarkenedKitsune) < 0) { //This really is basically a reskinned exgartuan. I really don't want to do this, but I can't get combat working in DarkenedKitsunePerk.
			outputText("") //Low Corruption
		}
		return true;
	}

	public function splitPersonalityFirstEncounter() {
		clearOutput();
		outputText("\nAn odd feeling wells up in your chest, and you slow your pace, worried that you might have pushed yourself a bit too far this trip when suddenly, the corruption you gained during your journies across Mareth suddenly attack your star crystal, infecting it, and by extention, your soul. It roots itself deep inside, and starts to affect your sanity. Further increasing your corruption may be a bad idea, unless you can keep your wits about.\n\n(<b>Gained Perk: Darkened Kitsune!</b>)\n"
				+"Suddenly, you hear "+(((kFLAGS.SHOULDRA_FOLLOWER_STATE) == 1) || (player.statusEffectv1(StatusEffects.Exgartuan) >0)? "yet another":"a")+" voice in your head. Or rather, whispers that you strain to hear. You stop in your tracks, tuning out as much noise as you can, which becomes a natural thing for you from your meditation sessions at the shrine.\n\n"
				+"You wait in silence for a couple moments, eyes closed and standing still, your ears twitching this way and that, listening for any hint of the voices. A butterfly could land on you, and you wouldn't notice, but it wouldn't matter anyways, since the voices seem to have left.\n\n"
				+"As you return back to reality, a thought strikes you: What was so important about the voices anyways?");
		return true;
	}

	public function splitPersonalityTakesOver() {
		outputText("\nAs you return back to your camp, a sharp stabbing pain strikes your chest. Almost as soon as the pain fades do you also feel like the world is losing it's cohesion. You desperately consider that could be happening to you when suddenly you feel your connection to your star sphere snap, to be quickly reattached by something much darker.\n\n"
				+"It immediately feasts upon your body and mind, silencing you while tearing your very consciousness apart, shredding every ounce of will and individuality from you, and consuming it into itself. \n\n"
				+"As the last remnants of you keep screaming into the empty white void that was your very self, a new being emerges from nothingness. Looking closely, it slowly morphs into... it's morphing into you! It soon finishes, and inky black tentacles smash into the metaphorical walls, staining it wherever it anchors itself to, and slowly, it opens it's eyes and stares at you, before you are consumed by a vast torrent of darkness.\n\n"
				+"You whimper, but you don't even have the energy to do so, before the corruption takes over your last concious spark, and begins masquerading as [name], the destroyer of Mareth... and perhaps even Ingnam?\n\n\n\n"
				+"You grin, and let loose a terrible laugh, as the world silently enters a new age of despair.");
				EventParser.gameOver();
		return true;
	}

	public function darkKitsuneCombat() {
		outputText("Placeholder text.")
		return true;
	}
	}
}