//(Poorly) done/expanded by Jtex. Project killed due to not being in theme.
//I know this folder is for NPC's but... isn't a split personality technically not the player's character?
package classes.Scenes.NPCs{
import classes.*;
import classes.BodyParts.Skin;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Perks.DarkenedKitsunePerk;
import classes.Scenes.Combat.Combat;

public class HydeKitsuneScene extends NPCAwareContent {
	public function splitPersonalityFirstEncounter():void { //First time obtaining perk. Recurring ones will have different scene.
		//clearOutput();
		outputText("\n\nAn odd feeling wells up in your chest, and you slow your pace, worried that you might have pushed yourself a bit too far this trip when suddenly, the corruption you gained during your journeys across Mareth attacks your star crystal, infecting it, and by extention, your soul. It roots itself deep inside, and starts to affect your sanity. Further increasing your corruption may be a bad idea, unless you can keep your wits about.\n\n"
				+"Suddenly, you hear "+(((kFLAGS.SHOULDRA_FOLLOWER_STATE) == 1) || (player.statusEffectv1(StatusEffects.Exgartuan) >0)? "yet another":"a")+" voice in your head. Or rather, whispers that you strain to hear. You stop in your tracks, tuning out as much noise as you can, which becomes a natural thing for you thanks to your meditation sessions at the shrine.\n\n"
				+"You wait in silence for a couple moments, eyes closed and standing still, your ears twitching this way and that, listening for any hint of the voices. A butterfly could land on you, and you wouldn't notice, but it wouldn't matter anyways, since the voices seem to have left.\n\n"
				+"As you return back to reality, a thought strikes you: What was so important about the voices anyways?\n\n");
	}

	public function splitPersonalityTakesOver():void { //Bad end. Will require tweaking of values, but is currently easy to keep away from. Req >75% Int&Wis and <95% Corr to avoid.
		clearOutput();
		outputText("\n\nAs you return back to your camp, a sharp stabbing pain strikes your chest.  Almost as soon as the pain fades, you also feel like the world is losing its cohesion. You desperately consider what could be happening to you when suddenly you feel your connection to your star sphere snap, to be quickly reattached by something much darker.\n\n"
				+"It immediately feasts upon your body and mind, silencing you while tearing your very consciousness apart, shredding every ounce of will and individuality from you, and consuming it into itself. \n\n"
				+"As the last remnants of you keep screaming into the empty white void that was your very self, a new being emerges from nothingness. Looking closely, it slowly morphs into... it's morphing into you! It soon finishes, and inky black tentacles smash into the metaphorical walls, staining it wherever it anchors itself to, and slowly, it opens it's eyes and stares at you, before you are consumed by a vast torrent of darkness.\n\n"
				+"You whimper, but you don't even have the energy to do so, before the corruption takes over your last concious spark, and begins masquerading as [name], the destroyer of Mareth... and perhaps even Ingnam?\n\n\n\n"
				+"You grin, and let loose a terrible laugh, as the world silently enters a new age of despair.");
				EventParser.gameOver();
	}

	public function splitPersonalityLost(lossDKtype:int):void{ //Losing perk due to race or stat.
		//clearOutput();
		var x:int = lossDKtype
		switch (x) {
			case 1:
				outputText("\n\nThe corruption loses its grip on your soul, and retreats from your star sphere. For the first time in a while, you feel a massive burden removed from somewhere deep within you.\n\n");
				player.statStore.removeBuffs("DarkenedKitsunePerk");
				break;
			case 2:
				outputText("\n\nNo longer close enough to be considered a full-blooded kitsune, the corruption loses its grip on your soul, and retreats from your star sphere. For the first time in a while, you feel a massive burden removed from somewhere deep within you.\n\n");
				player.statStore.removeBuffs("DarkenedKitsunePerk");
				break;
		}
		//return true;
	}

	public function splitPersonalityWarning(statchk:int):void{ //Warning when PC is 15% below max for either wis/int stat.
		var x:int = statchk
		switch (x){
			case 1:
				outputText("\n\nYou look at the corruption currently infecting your star sphere, and contemplate what to do about the problem, however, the more you look at it, the slower you feel your brain moving. Then again, with all that you've been through lately, a few brain cells might be knocked loose. Perhaps something to restore your <b>intelligence</b> might be in order?")
				break;
			case 2:
				outputText("\n\nYou look at the corruption currently infecting your star sphere, and contemplate what to do about the problem, however, you can't think of a solution. Then, it strikes you like a bolt. Perhaps there may be other records of this phenomena happening, all you need to do is to look for the <b>wisdom</b> of the elders!")
				break;
		}
		//return true;
	}

	public function splitPersonalityRandom():void { //Random events for fun.
		//var x:int = rand(5)
		var x:int = 1 //For now. I need to think of more lines.
		outputText("\n\nAs you walk back to your camp, you hear the voices again, ")
		if ((player.cor) >= 90){
			switch (x) {
				case 1:
					outputText( "and immediately, your shackles are raised in fury. You shout into the sky demanding to know who is talking to you, before the voices dissipate, leaving behind faint notes of laughter.\n "
					+ ((kFLAGS.SHOULDRA_FOLLOWER_STATE) == 1 && (player.statusEffectv1(StatusEffects.Exgartuan) > 0)) ? "You demand an all hands on deck meeting with your two inhabitants, which they join in your mind. You glare at them both for a solid minute, before asking them if they were trying anything sneaky. They look at each other, both terrified at your expression, before simultaneously responding with a negative. You then growl at them, before continuing on with your trek to your camp, your two associates a lot quieter along the way." :
							((kFLAGS.SHOULDRA_FOLLOWER_STATE) == 1) ? "You demand Shouldra to appear before you, which she quickly does, and ask her if she has been messing with your head. She shakes, and quietly responds that she had not been, then quickly jumps back into you, hiding somewhere. A low growl rumbles from the back of your throat, making sure that she understands that you're in a foul mood." :
									(player.statusEffectv1(StatusEffects.Exgartuan) > 0) ? "You demand to know if" + ((player.statusEffectv1(StatusEffects.Exgartuan) == 1) ? "he" : "she") + " was scheming with another demon. In your head, Exgartuan makes a scared look, before quickly vanishing, leaving you even more infuriated.":"" +"\n\n")
				break;
			}
		}else if ((player.cor) >= 75){
			switch (x) {
				case 1:
					outputText("and turn around, staring at the direction the voices were coming from. Your ears twitch this way and that, suddenly hyperaware of each noise, and aiming at the whisper which seems to now come from your sides, before suddenly.. Silence.\n "
					+ ((kFLAGS.SHOULDRA_FOLLOWER_STATE) == 1 && (player.statusEffectv1(StatusEffects.Exgartuan) > 0)) ? "You call out to your two inhabitants and ask them if they were playing tricks on you, to which they both deny. They then look closer at you, concern on both of their faces, before you dismiss them." :
							((kFLAGS.SHOULDRA_FOLLOWER_STATE) == 1) ? "You call out to Shouldra  and ask if she was messing with you, She becomes silent for a while, looking apprehensively at your face, before stating she had not. As she whisks herself back into you she mentions something about seeing another kitsune with a similar condition, and that she was going to look into it." :
									(player.statusEffectv1(StatusEffects.Exgartuan) > 0) ? "You call out to Exgartuan and ask if" + ((player.statusEffectv1(StatusEffects.Exgartuan) == 1) ? "he" : "she") + " was playing with your head, making you hear things that weren't there. In your head, Exgartuan makes a troubled expression before disappearing, mentioning something about \"...insane kitsunes\".":""+"\n\n")
				break;
			}
		}else {
			switch (x) {
				case 1:
					outputText("and listen intently on what they say, slowing down your pace.\n "
					+ ((kFLAGS.SHOULDRA_FOLLOWER_STATE) == 1 && (player.statusEffectv1(StatusEffects.Exgartuan) > 0)) ? "You ask your two inhabitants if they had said or heard anything, to which neither claim they did. Perhaps staying here in Mareth has frayed your nerves a bit more than you thought.\n\n" :
							((kFLAGS.SHOULDRA_FOLLOWER_STATE) == 1) ? "You ask Shouldra if she was messing with you, to which she replies <i> Why? The last spell I did on you should have dissipated by now, are you still feeling side-effects? </i>. You file the thought away, curious as to what new thing she has used your body to test.\n\n" :
									(player.statusEffectv1(StatusEffects.Exgartuan) > 0) ? "You ask Exgartuan if" + ((player.statusEffectv1(StatusEffects.Exgartuan) == 1) ? "he" : "she") + " was messing with you, or looking for another demon to converse with. In your head, Exgartuan makes a confused expression before dissipating, muttering to itself.":""+"\n\n")
				break;
			}
		}
	}
	public function splitPersonalityStatchange():void {//Should grant slow inte + wis loss, str + tough + wrath + cor gain, loss/gain varies by cor. Missing: Wrath, cor
		if (rand(20)==0) {
			outputText("\n\nThe corruption continues to change you, changing you to become more feral,  more like the agent of corruption it envisions you to become, " + ((player.cor) >= 90 ? "and you welcome it, embracing your new role in this world." : (player.cor) >= 75 ? "and you wonder if this might not be an entirely bad thing." : (player.cor) >= 50 ? "and you are slightly worried about the prospect." : ""));
		}
		statScreenRefresh();
		if (player.statStore.hasBuff("DarkenedKitsunePerk")){
			player.statStore.removeBuffs("DarkenedKitsunePerk");
		}
		player.statStore.addBuffObject({
			"str.mult": +1+(player.cor/100),
			"tou.mult": +1+(player.cor/100),
			"int": -(player.intStat.max*((player.cor * 0.01)/3)), //Due to the formula for calculating stats taking the mult first, I can cheat by getting the value after the multiplier has occurred, thus more or less guaranteeing the 33% max reduction, margin of error on additional, non mult bonuses.
			"wis": -(player.wisStat.max*((player.cor * 0.01)/3))
		}, 'DarkenedKitsunePerk', {text: 'Darkened Kitsune\'s Perk'});

	}

	public function darkenedKitsuneExpression():String {
		return "\n\nThe corruption has turned you into a" + ((player.cor >= 75) ? "n inhuman" : " different") + " being; With your head " + ((player.cor >= 75) ? "tilted to 35 degrees" : "slightly off-center") + " and ears " + ((player.cor >= 75) ? "twitching erratically" : "constantly moving at the slightest sound") + "  every so often, it would almost be " + ((player.cor >= 75) ? "cute if not for your gesugao expression." : "considered cute, if not for your paranoid expression.")
	}
	public function darkKitsuneCombat():Boolean { //Random extra attack using pc's own weapons.
		//combat.basemeleeattacks()
		outputText("The corruption suddenly takes hold of your limbs, and further rends into the enemy!")
		return true;
	}
	}
}