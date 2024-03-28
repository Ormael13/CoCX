/**
 * ...
 * @author Sylabt & Ohaxer
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Eyes;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;
	
public class GraydaRetainer extends NPCAwareContent
	{
		
		public function GraydaRetainer() 
		{
			
		}

public function graydaEncounter():void {
	spriteSelect(SpriteDb.s_grayda);
	clearOutput();
	if (player.eyes.type == Eyes.ARIGEAN && player.tailType == Tail.ARIGEAN_GREEN) SceneLib.theTrench.graydaEncounterTheTrench();
	else {
		outputText("Whilst sailing along the ocean’s waters, a thick fog rolls in that’s so dense you’ll fear it will cause you to get lost at sea should you not turn back. Suddenly something sizzling files overhead, missing the boat and audibly hitting the water, you snap your head in the direction it came from and ready your weapon. A woman wearing a strange hat with tentacle-like appendages seems to walk out of the fog on the water’s surface, A dark patch of yellow fog seems to cling to her skin, as she summons another bird-shaped projectile you realize...\n\n");
		startCombat(new Grayda());
	}
}
public function graydaEncounterWin():void {
	spriteSelect(SpriteDb.s_grayda);
	clearOutput();
	outputText("A final blow from your opponent sends you off your boat and into the water and with your body as tired as it is, you're unable to keep your head above the water. however the Arigean decides to spare you from a watery grave, Picking you up out of the water and carrying your tired body onto the boat, she ungraciously drops you onto the deck. Struggling to look up you find she’s very quickly pinned you to the floor, her cheeks are flushed blue and her breathing is heavy, it’s clear what her intentions are.\n\n");
	if (player.gender == 3) {
		if (player.hasVagina() && rand(2) == 0) graydaEncounterWinFemale();
		else graydaEncounterWinMale();
	}
	else {
		if (player.hasVagina()) graydaEncounterWinFemale();
		if (player.hasCock()) graydaEncounterWinMale();
	}
}
private function graydaEncounterWinFemale():void {
	outputText("She pins your arms above your head, your breath heavy. You can’t seem to push her off you! you struggle against her warm body, hoping to escape. She begins to slowly lick your wounds, her tongue soft and wet. You let out a small moan, your body and mind betraying you as she works her slick tongue down your body. She stares at you intensely with her bright glowing orbs filled with lust. Her heaving chest presses with yours as she kisses you rough and quick. ");
	outputText("You quickly clench your lips shut in hopes of not caving into her desires, but she quickly pinches your ass making you gasp out in surprise letting her tongue dance with yours. Your breath quickens as you feel your oxygen running out. She still pins you down as she explores your mouth. You feel your vision fading as you run out of oxygen. She slowly withdrawals from your lips, leaving a trail of saliva in her stead. Her hands let you go, but you can’t seem to move. ");
	outputText("She lets her hands wander your body leaving no part untouched, you can’t help but turn and sigh into pleasure, but sometimes her sharp nails break your skin making you gasp. Small streaks of blood fall down your bare exposed body as she violates your body inch by inch. As she positions her head between your legs. Her licks on your thigh make you shiver, her fingers touching the wet nub between your legs, your back arching into the rough ground. ");
	outputText("Her slick hands go inside of you, deeper her fingers went inside of you the more you continue to moan in pleasure. Your mind is polluted with lust as your climax comes quick. "+(silly()?"Your mind polluted with lust as my climax came quick. ":"")+"Her licks were fast and then slow, her tantalizing touch making you yearn for more. ");
	outputText("Her other hand wandering around your body, grabbing anywhere she could. You could feel your climax coming quick and grab her hair to push her mouth even deeper inside of your folds. Your mind goes blank in ecstasy as her glowing eyes peer at you once more…\n\n");
	graydaEncounterWinSharedEnd();
}
private function graydaEncounterWinMale():void {
	outputText("Her mischievous eyes look you up and down. you swallow down in fear and slight lust at the sight of her body. Her hands pinning you down with extreme force. She begins sucking on your neck as you shift uncomfortably, her eyes never leaving yours. you feel her hands slide down your chest, holding you in place still. Her lips trailing down your fresh wounds, leaving an arousing stinging pain. you sigh in pleasure as she continues to work herself down your body. Her hands rubbing your growing bulge as she kisses your abdomen. ");
	outputText("You hear her unbuckle your pants, you begin to panic and quickly sit up but she quickly turns and sits on your chest, her hands pulling out your member with accuracy. Her mouth quickly engulfing it, shocking you with intense pleasure. Her tongue moves skillfully against you, sucking the tip with such gentle firmness, you gasp out in pleasure as you desperately try to grab her hips. She comes off of you with a pop of her lips, moving her garments while she slides your hands up your shoulders and pushes you down. ");
	outputText("Slipping yourself inside of her, her moans and yours mixed together. Her hips move quickly at first, bouncing her entire body on you, you can’t seem to even see straight. Your hands longed to roam hers but she keeps you pinned to the ground, her eyes staring straight into yours. You begin to feel yourself unwind in the pleasure, her body slowing down, savoring every second. ");
	outputText("Her hands release you as she licks your neck and with one final grind of her hips, you feel yourself pouring into her, your moans escaping your lips with ease and her sighs of pleasure mixing with your voice. You feel your whole body become loose as she stands above you. your mind going blank in ecstasy as her glowing eyes peer at you once more…\n\n");
	graydaEncounterWinSharedEnd();
}
private function graydaEncounterWinSharedEnd():void {
	outputText("Afterward, she allows you a brief moment of respite before propping you up in her lap maintaining a firm grip on your arms, and before your even capable of protesting a tentacle-like appendage is forced down your throat, and a cold viscous liquid is pumped through it into your gullet, before long you're unable to keep your eyes open and pass out in her lap.\n\n");
	outputText("You awake several hours later with a bitter taste in your mouth, a stomach ache, and a few gems shorter.\n\n");
	outputText("<b>Your Stomach aches, you may want to rest.</b>\n\n");
	if (!player.blockingBodyTransformations()) player.createStatusEffect(StatusEffects.ArigeanInfected, 0, 0, 0, 0);
	cleanupAfterCombat();
}
public function graydaEncounterLoss():void {
	spriteSelect(SpriteDb.s_grayda);
	clearOutput();
	outputText("The Arigean grimaces as she tries to support her shaking body on her staff, however she’s unable to hold her weight and collapses into the water, quickly sinking back into the depths. The dense fog clears and you find a small satchel of gems floating in the water. You opt to return to camp for now and sail back to solid land.\n\n");
	cleanupAfterCombat();
}
public function graydaEncounterWin2():void {
	spriteSelect(SpriteDb.s_grayda);
	clearOutput();
	outputText("You stagger back from Grayda’s assault, and just as you're about to collapse into the water, Grayda comes to offer you support.\"<i>Well done! You may not have won, but you’ve definitely gotten stronger from our initial fight. Will you be okay getting back on your own with these injuries? Or do I need to walk you back?</i>\"\n\n");
	outputText("You tell her you’ll be fine and just need some rest, you’ll be sure to come by and see her once you’ve recovered.\n\n");
	cleanupAfterCombat();
}
public function graydaEncounterLoss2():void {
	spriteSelect(SpriteDb.s_grayda);
	clearOutput();
	outputText("Grayda is no longer able to withstand your attacks, and has to result to leaning on her staff, she raises a hand as if to signal her surrender.\n\n");
	outputText("\"<i>Very… Well done Elite. You’ve definitely gotten significantly stronger from when we’ve first met. You’ve proved you're not so weak after all. Cherish this moment.</i>\"\n\n");
	flags[kFLAGS.THE_TRENCH_ENTERED] = 8;
	cleanupAfterCombat();
}

public function graydaMainWhenCalled():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	outputText("You shout out to Grayda as she takes her time approaching."+((silly() && rand(5) == 0)?" You trip and fall face-first into the ground, causing Grayda to hasten her approach.":"")+"\n\n");
	outputText("\"<i>Do you need something, my Princess?</i>\"\n\n");
	menu();
	addButton(0, "Appearance", graydaMainAppearance);
	addButton(14, "Back", camp.campFollowers);
}
public function mishapsLunaGrayda():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("Grayda seems to be curled up underneath the water at the stream, her skin seems to be a shade of light blue and is flaking off as if she was shedding. It might be best to let her rest until she recovers from her sunburn.\n\n");
	outputText("Looking to where she normally rests you find most of the branches have been trimmed off, But who trimmed the trees?\n\n");
	if (player.hasStatusEffect(StatusEffects.CampLunaMishaps3)) player.addStatusValue(StatusEffects.CampLunaMishaps3, 2, 1);
			else player.createStatusEffect(StatusEffects.CampLunaMishaps3, 0, 1, 0, 0);
	if (!player.hasStatusEffect(StatusEffects.LunaWasCaugh)) player.createStatusEffect(StatusEffects.LunaWasCaugh, 1, 0, 0, 0);
	else player.addStatusValue(StatusEffects.LunaWasCaugh, 1, 1);
	if (player.statusEffectv1(StatusEffects.LunaWasCaugh) == 3) outputText("<b>That's it, you're sure of it now, it's all Luna's doing!</b>\n\n");
	doNext(playerMenu);
}
private function graydaMainAppearance():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	outputText("Grayda is a 6ft 3in Arigean Countess, and currently the one who is overseeing you and your needs. Her height is increased even further by the large hat-like symbiote which rests on her waist-long white hair. four light gray tentacles hang limply from the Symbiote. Her two glowing yellow eyes are often filled with a steadfast, or determined gleam. Her face, adorned with near albino skin, normally retains a neutral look.\n\n");
	outputText("Grayda’s body is nearly identical to that of a human’s, save for her legs which are covered up to her hips in natural, black metal armor. Her proportions are fairly normal for what one would expect from a human with a pair of C cup breasts, however, her body does seem to have some muscle definition. She normally wears what appears to be a white one-piece swimsuit, a pair of gloves, boots, and a dark gray cloak which is attached to a jaw-like piece of collar armor.\n\n");
	outputText("A soft, black, and yellow haze seem to occasionally be exhaled from her symbiotic partner, which clings to her skin. It intensifies when she’s angered or in combat, effectively giving her a protective layer of mist to help mask her movement, and appearance.\n\n");
	outputText("She confidently wields a dark metal staff with a bladed end, effectively allowing her to have a weapon to defend herself for close quarters and to help cast spells.\n\n");
	outputText("\"<i>Princess? Are you alright? Do you need me to move you somewhere darker or out of the light?</i>\"\n\n");
	doNext(graydaMainWhenCalled);
}
private	function graydaMainTalk():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	outputText("You ask Grayda if she wouldn’t mind talking with you about a few things.\n\n");
	outputText("\"<i>Of course not my princess. What is on your mind?</i>\"\n\n");
	menu();
	addButton(1, "Her", graydaMainTalkHer);
	addButton(2, "Outsiders", graydaMainTalkOutsiders);
	addButton(3, "Other Arigeans?", graydaMainTalkOtherArigeans);
	addButton(6, "Sunlight", graydaMainTalkSunlight);
	//7
	addButton(8, "The Camp?", graydaMainTalkTheCamp);
	addButton(14, "Back", graydaMainWhenCalled);
}
private	function graydaMainTalkHer():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	outputText("You ask what she was like before she became an Arigean.\n\n");
	outputText("\"<i>I suppose I could, after all, we are going to be together for quite a long time. Just… give me a moment, talking about such a subject never gets easy.</i>\" She sits down, pulls out a flask, and takes a small sip from it before re-hiding it somewhere in her cloak. \"<i>Déanann alcól rudaí i gcónaí níos fearr… much better.</i>\" Her voice gains a slight echo at the end, signaling she’s started using your kind’s native language.\n\n");
	outputText("You take a seat by her, and patiently wait for her to start her story of what she was like before.\n\n");
	outputText("\"<i>Let’s see…</i>\" she seems to almost space out, lost in thought. \"<i>Me and my sister used to be a part of a line of sailors, and we used to live a calm life almost entirely free from the corruption that plagued the land. However… our peace could not last forever, and the threat of being found by demons was becoming too great to ignore, so we stockpiled supplies, and tried to sail away from the mainland with a few close friends, family, and anyone who was willing to contribute.</i>\"\n\n");
	outputText("Her glowing yellow eyes seem to dim to a low amber as she grabs, and takes another sip from her concealed flask. \"<i>It was all going well, we had enough supplies to last us a while… until a violent storm started hounding our ship, and left us in a very poor condition, but that wasn’t the worst of it. One of those fanatic ‘Sea Witches’ attempted to attack our boat while turning us against each other.</i>\"\n\n");
	outputText("Her eyes lose all of their glow, leaving them as nothing but milky white with a faint brown coloring where her irises should be, and a frown appears on her face as watery drops started to fall from her eyes. \"<i>I… was knocked overboard during the attack, and in my weakened state was unable to stay above the water. Before I was about to pass out from a lack of air, this...</i>\" ");
	outputText("she pats the hat-like organism on her head in an affectionate manner. \"<i>It saved me from drowning by allowing me to breathe again… however there were no remains among the wreckage of the ship when I checked it. Meaning almost everyone I knew was most likely dead or turned into more fanatics.</i>\"\n\n");
	outputText("She takes a long gulp of whatever the continents of the flask were, before returning the empty container to her cloak for a final time, a flush of blue on her cheeks makes it quite obvious as to what the contents were. \"<i>I'm not sure how long I stayed there, unable to move… to live with the reality that was forced upon me… eventually I couldn't remain conscious and collapsed from exhaustion. However when I woke up, I was somewhere different, as well as something I wasn't before, but the thing that mattered most to me was the desire to grow stronger. I wanted revenge, I would become a one-woman army if it meant finally being able to catch the one who caused so much ruin in a day.</i>\"\n\n");
	outputText("She leans back into her chair and takes a deep breath before continuing. \"<i>But that was all so long ago, and I was much too young to have a proper understanding of how the world works. So for now, my duty is protecting you and giving you my guidance. Or at least until we both perish.</i>\" Her eyes regain their glow as she seems to return to her normal attitude.\n\n");
	outputText("She shuffles a bit as her attention is regained on you. \"<i>I suppose you wouldn’t mind if I asked what you did before our encounter? I understand you have a duty that takes priority over being a leader for our kind, but what were you like before our encounter?</i>\"\n\n");
	outputText("You can’t help but let out a low growl looking back on your time in your hometown. ");
	if (SceneLib.dungeons.checkFactoryClear()) outputText("After all, you were nothing but a sacrifice to the elders for their own personal gain, and worst of all is that they are continuing on unpunished. How long until someone you held dear is thrown through and defiled by the land?");
	else outputText("This reaction seems to somewhat concern you, nothing bad exactly happened. In fact, you are your village’s champion, so why does this upset you?");
	outputText("\n\n\"<i>Princess I understand if you don’t wish to discuss this, but please know I will stay by your side to the end regardless of your past.</i>\"\n\n");
	doNext(graydaMainTalk);
	advanceMinutes(15);
}
private	function graydaMainTalkOutsiders():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	outputText("You ask Grayda what she thinks of the other races of mareth.\n\n");
	outputText("\"<i>Outsiders? With all due respect Princess I don't trust them, they seem quick to turn on each other, however, the demons are a more serious threat for the moment. I would also be wary of any Mindbreakers you come across my princess, they seem to have some ulterior motive which could prove detrimental if left unchecked.</i>\"\n\n");
	outputText("She takes a moment to look around the camp before continuing. \"<i>Although, most of the folk you’ve gathered around here seem quite pleasant, and trade between one of the nearby towns could help this place grow quite nicely.</i>\"\n\n");
	doNext(graydaMainTalk);
	advanceMinutes(5);
}
private	function graydaMainTalkOtherArigeans():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	outputText(" You ask how the Arigeans at the trench will fare without you or Grayda present.\n\n");
	outputText("\"<i>Well, they aren’t completely without leadership as the other princesses would have placed a replacement for me there. However, I'm sure they would benefit from a visit from us every once in a while though.</i>\" She closes her eyes to think for a few moments. \"<i>Any infectees might find their way there, some might even find themselves drawn here if we have enough space for them.</i>\"\n\n");
	doNext(graydaMainTalk);
	advanceMinutes(5);
}
private	function graydaMainTalkSunlight():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	outputText("You’ve noticed how when Grayda isn’t by your side or patrolling then she’s staying in a shaded area. You’ve also noticed that the sun has been irritating your skin ever since you’ve become an Arigean, is there a reason for this?\n\n");
	outputText("\"<i>Yes my Princess. We lack the chemicals in our skin that give us color like most other surface dwellers, so we can’t handle constant sunlight exposure like most other races can. I would recommend wearing eye protection and resting in the shade every once in a while to avoid irritation.</i>\"\n\n");
	doNext(graydaMainTalk);
	advanceMinutes(5);
}
private	function graydaMainTalkOthersAtCamp():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	outputText("\"<i></i>\"\n\n");
	doNext(graydaMainTalk);
	advanceMinutes(5);
}
private	function graydaMainTalkTheCamp():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0) outputText("\"<i>It’s nice, there’s at least some shelter so our skins don’t burn. But shouldn't we try to continue to expand our defense a bit given we are currently out in the open?</i>\"\n\n");
	else outputText("\"<i>It’s… something, but don’t you think you should build some shelter, my princess? I'm not sure how you handle constantly being in this harsh sunlight.</i>\"\n\n");
	doNext(graydaMainTalk);
	advanceMinutes(5);
}
private	function graydaA():void {
	outputText("\"<i></i>\"\n\n");
}
private	function grayda():void {
	outputText("\"<i></i>\"\n\n");
}
	}

}
