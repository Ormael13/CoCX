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
import classes.Scenes.NPCs.DivaScene;
import classes.Scenes.NPCs.EvangelineFollower;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;
	
public class GraydaRetainer extends NPCAwareContent
	{
		
		public function GraydaRetainer() 
		{
		}
		
public function graydaAffection(changes:Number = 0):Number
{
	flags[kFLAGS.GRAYDA_AFFECTION] += changes;
	if (flags[kFLAGS.GRAYDA_AFFECTION] > 100) flags[kFLAGS.GRAYDA_AFFECTION] = 100;
	return flags[kFLAGS.GRAYDA_AFFECTION];
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
	addButton(1, "Talk", graydaMainTalk);
	addButtonIfTrue(2, "Sex", graydaMainSex, "Req. 60%+ affection and 33+ lust.", (flags[kFLAGS.GRAYDA_AFFECTION] >= 60 && player.lust >= 33));
	addButtonIfTrue(3, "Bathing", graydaMainBathingWillingly, "At least 1 day since last Bathing.", flags[kFLAGS.GRAYDA_BATHING] > 0);
	//5 - team option
	//6 - night guard
	if (flags[kFLAGS.SLEEP_WITH] != "Grayda") addButton(7, "Sleep With", graydaSleepToggle).hint("Spend your nights with Grayda.");
	else addButton(7, "Sleep Alone", graydaSleepToggle).hint("Stop sleeping with Grayda.");
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
	addButton(7, "Others at camp?", graydaMainTalkOthersAtCamp)
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
	outputText("She takes a long gulp of whatever the continents of the flask were, before returning the empty container to her cloak for a final time, a flush of blue on her cheeks makes it quite obvious as to what the contents were. \"<i>I'm not sure how long I stayed there, unable to move… to live with the reality that was forced upon me… eventually I couldn't remain conscious and collapsed from exhaustion. However, when I woke up, I was somewhere different, as well as something I wasn't before, but the thing that mattered most to me was the desire to grow stronger. I wanted revenge, I would become a one-woman army if it meant finally being able to catch the one who caused so much ruin in a day.</i>\"\n\n");
	outputText("She leans back into her chair and takes a deep breath before continuing. \"<i>But that was all so long ago, and I was much too young to have a proper understanding of how the world works. So for now, my duty is protecting you and giving you my guidance. Or at least until we both perish.</i>\" Her eyes regain their glow as she seems to return to her normal attitude.\n\n");
	outputText("She shuffles a bit as her attention is regained on you. \"<i>I suppose you wouldn’t mind if I asked what you did before our encounter? I understand you have a duty that takes priority over being a leader for our kind, but what were you like before our encounter?</i>\"\n\n");
	outputText("You can’t help but let out a low growl looking back on your time in your hometown. ");
	if (SceneLib.dungeons.checkFactoryClear()) outputText("After all, you were nothing but a sacrifice to the elders for their own personal gain, and worst of all is that they are continuing on unpunished. How long until someone you held dear is thrown through and defiled by the land?");
	else outputText("This reaction seems to somewhat concern you, nothing bad exactly happened. In fact, you are your village’s champion, so why does this upset you?");
	outputText("\n\n\"<i>Princess I understand if you don’t wish to discuss this, but please know I will stay by your side to the end regardless of your past.</i>\"\n\n");
	graydaAffection(2.5);
	doNext(graydaMainTalk);
	advanceMinutes(15);
}
private	function graydaMainTalkOutsiders():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	outputText("You ask Grayda what she thinks of the other races of Mareth.\n\n");
	outputText("\"<i>Outsiders? With all due respect Princess I don't trust them, they seem quick to turn on each other, however, the demons are a more serious threat for the moment. I would also be wary of any Mindbreakers you come across my princess, they seem to have some ulterior motive which could prove detrimental if left unchecked.</i>\"\n\n");
	outputText("She takes a moment to look around the camp before continuing. \"<i>Although, most of the folk you’ve gathered around here seem quite pleasant, and trade between one of the nearby towns could help this place grow quite nicely.</i>\"\n\n");
	graydaAffection(2.5);
	doNext(graydaMainTalk);
	advanceMinutes(5);
}
private	function graydaMainTalkOtherArigeans():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	outputText(" You ask how the Arigeans at the trench will fare without you or Grayda present.\n\n");
	outputText("\"<i>Well, they aren’t completely without leadership as the other princesses would have placed a replacement for me there. However, I'm sure they would benefit from a visit from us every once in a while though.</i>\" She closes her eyes to think for a few moments. \"<i>Any infectees might find their way there, some might even find themselves drawn here if we have enough space for them.</i>\"\n\n");
	graydaAffection(2.5);
	doNext(graydaMainTalk);
	advanceMinutes(5);
}
private	function graydaMainTalkSunlight():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	outputText("You’ve noticed how when Grayda isn’t by your side or patrolling then she’s staying in a shaded area. You’ve also noticed that the sun has been irritating your skin ever since you’ve become an Arigean, is there a reason for this?\n\n");
	outputText("\"<i>Yes my Princess. We lack the chemicals in our skin that give us color like most other surface dwellers, so we can’t handle constant sunlight exposure like most other races can. I would recommend wearing eye protection and resting in the shade every once in a while to avoid irritation.</i>\"\n\n");
	graydaAffection(2.5);
	doNext(graydaMainTalk);
	advanceMinutes(5);
}
private	function graydaMainTalkOthersAtCamp():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	outputText("You ask Grayda what she thinks of the others at camp.\n\n");
	if (flags[kFLAGS.LUNA_FOLLOWER] >= 4 && !player.hasStatusEffect(StatusEffects.LunaOff)) outputText("\"<i>That maid, Luna, seems to be a good maid but she has a few issues, such as her lust towards you, keep a close eye on her.</i>\"\n\n");
	if (flags[kFLAGS.LUNA_FOLLOWER] >= 7 && !player.hasStatusEffect(StatusEffects.LunaOff)) outputText("\"<i>That maid, Luna, seems to be a good maid but she has a few issues, such as her lust towards you, and her...condition...thank you for not firing her by the way my princess, I feel as if you did...nothing good would have come from it.</i>\"\n\n");
	if (player.hasStatusEffect(StatusEffects.CampRathazul)) outputText("\"<i>The old one seems quite friendly, but I wish he would stop trying to collect ‘samples’ from me. It's getting quite irritating. Please let me know if he starts bugging you, my Princess.</i>\"\n\n");
	if (EvangelineFollower.EvangelineFollowerStage >= 1) outputText("\"<i>That rather tall human with the cross-shaped pupils seems almost afraid of us, did you do something, my princess? Or is she just always weary?</i>\"\n\n");
	if (flags[kFLAGS.KONSTANTIN_FOLLOWER] >= 2 && !player.hasStatusEffect(StatusEffects.KonstantinOff)) outputText("\"<i>The smith seems surprisingly polite for how large he is, hopefully, he doesn’t get the wrong idea if I were to ask to sample his wares, or put off by our… strange diets</i>\"\n\n");
	if (player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_BIMBO_STATE] != 3) outputText("\"<i>I'm sorry my Princess, but I can’t help but see that little monk as prey. Surely I'm not the only one thinking he would taste well with a bit of seasoning. However, other than that I've noticed he seems quite cautious around me, I hope I haven’t scared him too badly.</i>\"\n\n");
	if (DivaScene.instance.isCompanion()) outputText("\"<i>Is… that a vampire? I thought they were nothing but a myth, although it is nice to meet another who is irritated by the harsh sun here.</i>\"\n\n");
	if (flags[kFLAGS.ALVINA_FOLLOWER] > 12 && flags[kFLAGS.ALVINA_FOLLOWER] < 20 && !SceneLib.alvinaFollower.AlvinaPurified) outputText("\"<i>My Princess there seems to be a witch near our camp who reeks of corruption, and when I tried confronting her she shooed me away saying you had allowed her to be here. I would be cautious of her Princess, she seems to be the kind to have her own interests in mind.</i>\"\n\n");
	if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] > 3) outputText("\"<i>That paladin doesn’t seem to be the brightest, but he certainly is dedicated towards his cause. If he wasn’t so hostile towards me then I could imagine we would get along quite well. That soup also smells lovely.</i>\"\n\n");
	outputText("\"<i>Overall you have quite a collection of people here my princess, this should prove to be quite interesting.</i>\"\n\n");
	graydaAffection(2.5);
	doNext(graydaMainTalk);
	advanceMinutes(5);
}
private	function graydaMainTalkTheCamp():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0) outputText("\"<i>It’s nice, there’s at least some shelter so our skins don’t burn. But shouldn't we try to continue to expand our defense a bit given we are currently out in the open?</i>\"\n\n");
	else outputText("\"<i>It’s… something, but don’t you think you should build some shelter, my princess? I'm not sure how you handle constantly being in this harsh sunlight.</i>\"\n\n");
	graydaAffection(2.5);
	doNext(graydaMainTalk);
	advanceMinutes(5);
}
private	function graydaMainSex():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	outputText("The effects of this land have been taking it’s toll on you, maybe Grayda wouldn’t mind helping you relieve yourself of stress?\n\n");
	outputText("\"<i>I… would prefer not to give in to my baser urges, but if my Princess is in need of relief I don’t mind helping, but only for you, my Princess.</i>\"\n\n");
	menu();
	addButton(1, "-1-", graydaMainSex1);
	addButton(3, "-2-", graydaMainSex2);
}
private	function graydaMainSex1():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	outputText("Grayda sheepishly leads you towards your shared resting place. Her hands start by slowly working their way onto you. Her glowing orbs pierce into yours as she very delicately places her warm lips against yours. She makes slow work of roaming her hands softly against every curve of your body. You sigh into her, your nervousness slipping away, being replaced by overwhelming lust. Your body reacts in lewd ways, your nether regions growing awfully needy, your skin becomes sensitive to the slightest whisper of air. Her lips leave yours to much discontent. You feel her lips trail to your jawline, and her hands working ever slowly further down to your growing heat.\n\n");
	outputText("\"<i>My, my princess… you’re so sensitive, I can feel the heat of your lips from here…</i>\" You blush at her remark, making your body react, rubbing your thighs to create some sort of friction. She quickly pins you down, using her legs to spread your legs apart to stop your self-pleasuring. You try to use your tail to create friction as well, but quickly she uses her wet tongue to lick you from your core to your perky breasts. You moan in pleasure and begin to sigh with satisfaction as she begins to softly suck on your breasts, leaving hickeys scattered all over them. ");
	outputText("She uses her hand to fondle the other, but then sticks two fingers into your mouth when you begin moaning. “!!!”. You were shocked at first but then succumbed and began sucking on her fingers, wetting them while she littered your body in wet kisses and soft caresses. She removes her fingers with a loud pop from your lips.\n\n");
	outputText("Quickly undoing your armor, she sees your heat. You see her eyes glow brighter in arousal. She looks at you directly and begins to slowly leave touches down your thighs. You buck your hips to desperately achieve some sort of relief. Seeing your impatience she licks your wet folds slowly, watching your arch your back, withering in lust. She keeps her tongue moving constantly, licking your clit and slightly penetrating your wet core. You grab onto her hair hoping to create more friction to satisfy your growing desires. She lifts your legs onto her shoulders and pushes her tongue as deep as it can go inside of you. You push into her face as you feel your climax approaching. ");
	outputText("She sees you getting close and inserts her wet digits. You moan out grinding your hips against her, trying to move to get more and more stimulation. She quickly thrusts her hand in and out of you, curling her long fingers, hitting the special spot inside of your folds making you moan loudly, almost shouting in pure ecstasy. You look down seeing her also play with her own wet core, moaning into your growing orgasm, the vibrations making you shake with the need of relief. ");
	outputText("You can help it anymore and feel the orgasm rip through your body, her moaning from her own orgasm vibrating into you making you feel even more. You slump in exhaustion and sweat as she crawls up next to you. Placing a chaste kiss to your lips before you lull into a deep slumber.\n\n");
	outputText("You wake up after what feels like a short nap, your body completely intertwined with Grayda’s. You slowly and gently try to free yourself from her grasp without waking her, thankfully her sleep seems to be much deeper than the one you were in, allowing you to successfully escape without waking her and re-dress. Before you leave, you plant a small quick peck on her forehead as thanks.\n\n");
	player.sexReward("Default", "Vaginal", true, false);
	graydaAffection(5);
	doNext(camp.returnToCampUseOneHour);
}
private	function graydaMainSex2():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	outputText("Grayda sheepishly leads you towards your shared resting place. As you slowly strip off your armor, her lust-filled gaze grows stronger. Without a warning, she pins you to the wall. You struggle against her strength as she kisses your neck furiously. You try to speak but she quickly engulfs your lips in a passionate kiss. Her eyes were completely coated in lewd thoughts. You go weak as she kisses and nips at your soft yet strong chest. Her lips and tongue leaving no inch untouched.\n\n");
	outputText("Her hands leave yours as she grabs your chin looking at you intensely before she pinches your nipples, making you shake and wriggle in pain and pleasure. She watches you intently, savoring every expression. She picks you up and throws you over her shoulder as she carries you to bed. Quickly laying you down gently enough to not hurt you. Bite marks and kisses litter you, your body covered in a light sweat. She licks your neck before rubbing her wet core against your member. ");
	outputText("You rut against her in desperation, she smirks and sinks down onto you. Her hips move fast and rough against you. You know she has left bruises on your hips, arms, and legs. She leans down while she continues grinding against your throbbing cock, kissing you softly and peering into your soft orbs.\n\n");
	outputText("You feel her fingers grab your shoulder to create leverage. Before you can reach your peak orgasm she pulls away, leaving you feeling empty. Quickly she uses her mouth, wet and hot tongue curling around places unexplored. Your body is almost paralyzed in arousal before she finally licks away the pain of holding in the ecstasy. You arch in the overwhelming waves of pleasure, her eyes never abandoning your face, eating every single detail of your bruised, sweaty, and albino body. You can’t seem to move but she pushes away the stray hairs on your face. She lays against you, slipping you into a deep slumber.\n\n");
	outputText("You wake up after what feels like a short nap, your body completely intertwined with Grayda’s. You slowly and gently try to free yourself from her grasp without waking her, thankfully her sleep seems to be much deeper than the one you were in, allowing you to successfully escape without waking her and re-dress. Before you leave, you plant a small quick peck on her forehead as thanks.\n\n");
	player.sexReward("Default", "Vaginal", true, false);
	graydaAffection(5);
	doNext(camp.returnToCampUseOneHour);
}
public function graydaMainBathingByForce():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	outputText("You can see Grayda storming around the camp, her eyes intensely glowing with the haze around her being much thicker than normal. Suddenly her glowing yellows lock with your blues as she heads straight towards you.\n\n");
	outputText("\"<i>My Princess, do you have any idea how poorly you’ve been treating your body? You're covered in dirt, dried bodily fluids, and your scent could be picked up far too easily. When was the last time you bathed?</i>\" She takes up a more commanding stance like what you were used to seeing when you first properly met her.\n\n");
	outputText("\"<i>Eh… well, you see…</i>\" now come to think of it, when was the last time you bathed? And she may have a point, you’ve been so focused on completing your current task that you haven’t been taking much time to care for your body. Speaking of it feels like something is currently stuck in a joint on your natural armor.\n\n");
	outputText("\"<i>Princess, like it or not we’re taking a bath so you can get cleaned up.</i>\"\n\n");
	outputText("Before you can even protest she’s grabbed you by the hand and led you to the stream located nearby the camp.\n\n");
	outputText("\"<i>Please strip down Princess, I won't be able to thoroughly wash you with all of your equipment on.</i>\" As if to ease any embarrassment you might be experiencing, she also begins stripping herself of her own gear as you do the same.\n\n");
	outputText("Dressing down, folding your [armor] into a neat pile, and leaving your weapons by them. You turn and are greeted by the semi-shocking sight of a nude Grayda bending over, rummaging in the sack she brought for a few items. Seemingly done searching for what she was looking for, she turns back to you with a few small glass bottles, brushes, and a couple of rags in her arms.\n\n");
	outputText("\"<i>You can go first, my Princess, I'll be right behind you.</i>\"\n\n");
	outputText("Stepping into a shallow-ish part of the stream and resting on your knees while stretching your large extra maw out, Grayda is quick to keep her word and seats herself right behind you.\n\n");
	outputText("\"<i>We’re going to start with your hair, so please close your eyes so the soap doesn’t sting them.</i>\" She immediately gets to work, she starts with dumping some water over your head before beginning to softly massage your scalp as a sweet smell begins to enter your nose. Before long she’s started gently running a brush through your hair to get any remaining knots out, finishing with a couple more rinses.\n\n");
	outputText("\"<i>I'm going to move onto your back, please stay still, my Princess.</i>\"\n\n");
	outputText("Compiling with her request, you allow her to begin scrubbing off the dirt and grime with a rag and begin to press into her blissful ministrations. But before long, she’s done washing you back and shoulders.\n\n");
	outputText("\"<i>Please forgive me, Princess.</i>\"\n\n");
	outputText("\"<i>Forgive you for wh-</i>\" your words are cut off by a moan from the sudden pleasure of your chest being teased by two pale, soapy hands as they expertly go over the entirety of your chest before moving on to your stomach. Leaving you completely breathless as a heat begins to creep up your cheeks and nethers.\n\n");
	outputText("\"<i>I'm so sorry Princess,</i>\" she quickly says as her hands quickly go over your light blue folds before retreating to douse your body.\n\n");
	outputText("Still panting with a face flushed blue, you turn your head to face her equally flushed face before she presents you with a large brush.\n\n");
	outputText("\"<i>Next we’re going to clean your armored bits. Starting with your legs, so please stretch your legs out, my Princess.</i>\"\n\n");
	outputText("Stretching your legs out she immediately gets to work, with an occasional fleck of dried blood coming off from the injuries you’ve sustained. Whenever she nears one of your joints she slows her pace and eventually uses her fingers to massage the black skin in between, earning soft mewls from you and an even further blue flushed face. Before long she’s finished, with your armor being comparable to a freshly polished sword.\n\n");
	outputText("\"<i>Please stay still, my Princess. I'm going to move onto your tail.</i>\" She quickly orientates herself to sit right in between your extra maw and you.\n\n");
	outputText("And she’s swift to go to work, following the same method she used for your legs, getting multiple moans and twitches as she works her way painfully slowly across your occasionally jerking tail. You could’ve sworn you orgasmed from the ordeal, and Grayda being painfully aware of that by the end with a face completely flushed blue.\n\n");
	outputText("\"<i>T-That should be it, my Princess, now if you don’t mind. I'm going to stay here a bit longer so I can clean myself. Please try not to dirty yourself too quickly.</i>\"\n\n");
	outputText("You give your thanks and partings to your loyal Retainer as you watch her sink into a deeper part of the stream to hide her completely blue face. You feel completely refreshed and like you could crush a whole army to dust with your renewed vigor.\n\n");
	flags[kFLAGS.GRAYDA_BATHING] = 0;
	graydaAffection(2.5);
	doNext(camp.returnToCampUseOneHour);
}
private	function graydaMainBathingWillingly():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	outputText("Maybe your most loyal Subordinate could help you clean up?\n\n");
	outputText("\"<i>It would be my pleasure, Princess. Please lead the way.</i>\"\n\n");
	outputText("Before long, you find yourself at the stream near camp with Grayda following closely behind.\n\n");
	outputText("\"<i>Please strip down Princess, I won't be able to thoroughly wash you with all of your equipment on.</i>\" As if to ease any embarrassment you might be experiencing, she also begins stripping herself of her own gear as you do the same.\n\n");
	outputText("Dressing down, folding your [armor] into a neat pile, and leaving your weapons by them. You turn and are greeted by the semi-shocking sight of a nude Grayda bending over, rummaging in the sack she brought for a few items. Seemingly done searching for what she was looking for, she turns back to you with a few small glass bottles, brushes, and a couple of rags in her arms.\n\n");
	outputText("\"<i>You can go, first Princess, I'll be right behind you.</i>\"\n\n");
	outputText("Stepping into a shallow-ish part of the stream and resting on your knees while stretching your large extra maw out, Grayda is quick to keep her word and seats herself right behind you.\n\n");
	outputText("\"<i>We’re going to start with your hair, so please close your eyes so the soap doesn’t sting them.</i>\" She immediately gets to work, she starts with dumping some water over your head before beginning to softly massage your scalp as a sweet smell begins to enter your nose. Before long she’s started gently running a brush through your hair to get any remaining knots out, finishing with a couple more rinses.\n\n");
	outputText("\"<i>I'm going to move onto your back, please stay still, my Princess.</i>\"\n\n");
	outputText("Compiling with her request, you allow her to begin scrubbing off the dirt and grime with a rag and begin to press into her blissful ministrations. But before long, she’s done washing you back and shoulders.\n\n");
	outputText("\"<i>Please forgive me, Princess.</i>\"\n\n");
	outputText("\"<i>Forgive you for wh-</i>\" your words are cut off by a moan from the sudden pleasure of your chest being teased by two pale, soapy hands as they expertly go over the entirety of your chest before moving on to your stomach. Leaving you completely breathless as a heat begins to creep up your cheeks and nethers.\n\n");
	outputText("\"<i>I'm so sorry Princess,</i>\" she quickly says as her hands quickly go over your light blue folds before retreating to douse your body.\n\n");
	outputText("Still panting with a face flushed blue, you turn your head to face her equally flushed face before she presents you with a large brush.\n\n");
	outputText("\"<i>Next we’re going to clean your armored bits. Starting with your legs, so please stretch your legs out, my Princess.</i>\"\n\n");
	outputText("Stretching your legs out she immediately gets to work, with an occasional fleck of dried blood coming off from the injuries you’ve sustained. Whenever she nears one of your joints she slows her pace and eventually uses her fingers to massage the black skin in between, earning soft mewls from you and an even further blue flushed face. Before long she’s finished, with your armor being comparable to a freshly polished sword.\n\n");
	outputText("\"<i>Please stay still, my Princess. I'm going to move onto your tail.</i>\" She quickly orientates herself to sit right in between your extra maw and you.\n\n");
	outputText("And she’s swift to go to work, following the same method she used for your legs, getting multiple moans and twitches as she works her way painfully slowly across your occasionally jerking tail. You could’ve sworn you orgasmed from the ordeal, and Grayda being painfully aware of that by the end with a face completely flushed blue.\n\n");
	outputText("\"<i>T-That should be it, my Princess, now if you don’t mind. I'm going to stay here a bit longer so I can clean myself. Please try not to dirty yourself too quickly.</i>\"\n\n");
	outputText("You give your thanks and partings to your loyal Retainer as you watch her sink into a deeper part of the stream to hide her completely blue face. You feel completely refreshed and like you could crush a whole army to dust with your renewed vigor.\n\n");
	flags[kFLAGS.GRAYDA_BATHING] = 0;
	graydaAffection(5);
	doNext(camp.returnToCampUseOneHour);
}
private function graydaSleepToggle():void {
	clearOutput();
	if (flags[kFLAGS.SLEEP_WITH] != "Grayda") {
		outputText("You ask Grayda if she wouldn’t mind keeping you company for the night.\n\n");
		outputText("\"<i>I don’t mind, My Princess. I’ll make sure no harm comes your way while you rest.</i>\"\n\n");
		flags[kFLAGS.SLEEP_WITH] = "Grayda";
	} else {
		outputText("You ask Grayda if she wouldn’t mind letting you sleep alone for a little.");
		outputText("\"<i>If it is what you wish, my Princess.</i>\"\n\n");
		flags[kFLAGS.SLEEP_WITH] = "";
	}
	doNext(graydaMainWhenCalled);
}
public function sleepWithGrayda():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);
	outputText("You lay down and curl up as you plan to sleep through the night. Grayda eventually joins you as she proceeds to protectively hug you from behind while resting against your large tail. Her presence allows you to rest throughout the night with very little worry as you drift off into bliss.\n\n");
	if (rand(100) < 15) {
		switch (rand(3)) {
			case 0:
				outputText("Your sleep doesn’t last long without disruption, however, and the feeling of something squeezing you becomes too much to bear, forcing you to open your eyes.\n\n");
				outputText("\"<i>T-Thora… D-Don’t go!</i>\" the source of the squeezing weakly calls out behind you.\n\n");
				outputText("It seems Grayda is having a nightmare of some sort, and from the sounds of it, it’s especially unpleasant. Maybe it would be best to give her a bit of comfort before she breaks your spine or ribs? You shift around in her iron grasp so that you're now chest to chest with her.\n\n");
				outputText("\"<i>N-No please… I've gotten stronger.</i>\" Tears can be seen forming at the corners of her eyes as she starts slightly shaking. You slowly return her embrace and rest your head on her shoulder as her tremble slowly comes to a stop.\n\n");
				outputText("\"<i>Don’t… leave me.</i>\" Are the last words you're able to hear her mumble as you drift back into sleep with the newfound comfort of her embrace.\n\n");
				break;
			case 1:
				outputText("One after another they keep coming, for everyone you defeat three more swiftly takes its place in a never-ending onslaught, and slowly one by one those around you who you’ve come to know and love slowly fall to the shadows. Before long you're the only one standing as the shadowy tendrils wrap around your being, and swallow you within it’s icy darkness.\n\n");
				outputText("The painful feeling of freezing to death consumes every inch of your body as it slowly works its way to your very core, and the feeling of tendrils piercing your skin to drink your very life essence. Your attempts to cry out are quickly muffled.\n\n");
				outputText("However, the pain slowly fades, as if an invisible hand was caressing away the pain and filling the void with a loving warmth. Slowly mending your injuries and lighting the darkness with a loving violet glow.\n\n");
				outputText("\"<i>I'm… here… for… you.</i>\" An echoed voice is all you're able to hear as you feel yourself become embraced within a pair of invisible arms as you begin to lose consciousness from the soothing warmth. \"<i>Please… let… me… ease… your… burd-</i>\" but before the voice can finish, you're already deep in sleep.\n\n");
				break;
			case 2:
				outputText("Suddenly you find yourself waking up well into the night with all hints of tiredness gone, but what strikes you the strangest is that you are completely unable to move any part of your body. The only thing you're able to do is look around and feel the slow rise and fall of Grayda’s chest on your back as fear begins to take hold.\n\n");
				outputText("Suddenly a hooded figure walks up to your not so sleeping form, staring down at you with two ominous blue orbs for an uncomfortable amount of time before making any further action. Slowly, she raises what looks like a gray, armored hand towards your face and tilts your head up to stare her directly in the eyes. With a decent look now you're able to identify her as an Arigean princess with her glowing blue eyes, albino skin, and white hair, however, her tails seem to be out of your view for now.\n\n");
				outputText("\"<i>Hmph, you might actually be worthwhile,</i>\" she whispers before quickly stealing a kiss while you're incapable of resisting, but suddenly she stops and leaves.\n\n");
				outputText("After a few minutes, you jolt up as if you just woke up from a dream. Was this whole encounter nothing but a dream? And you could’ve sworn you’ve seen that woman before, but the memory feels hazy.\n\n");
				outputText("\"<i>Is something wrong Princess?</i>\" it seems your sudden action woke Grayda up.\n\n");
				outputText("You tell her it was nothing but a dream before gently lying back down into her chest, resuming the position you had before.\n\n");
				outputText("\"<i>Princess… that must’ve been some dream, because I saw it too.</i>\" You turn to face her, but it seems she’s swiftly put herself back to sleep leaving you with a shiver at the thought of that woman. Maybe you should talk to her about it later once you're both awake.\n\n");
				break;
			default:
				outputText("");
				break;
		}
	}
	doNext(camp.sleepWrapper, 1.2);
}
public function graydaRandomnCampEvents():void {
	clearOutput();
	spriteSelect(SpriteDb.s_grayda);/*
	if ((flags[kFLAGS.LUNA_FOLLOWER] >= 4 && !player.hasStatusEffect(StatusEffects.LunaOff)) && rand(2) == 0) {
		if (flags[kFLAGS.LUNA_AFFECTION] > 65 && flags[kFLAGS.LUNA_JEALOUSY] >= 100) outputText("\"<i></i>\"\n\n");
		else if (flags[kFLAGS.LUNA_AFFECTION] > 65) outputText("\"<i></i>\"\n\n");
		else if (flags[kFLAGS.LUNA_AFFECTION] > 35) outputText("\"<i></i>\"\n\n");
		else outputText("\"<i></i>\"\n\n");
	}*/
	if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] > 3 && rand(2) == 0) {
		outputText("You decide to take a breather for the moment and just lie down to relax for a minute or two… or you would if it weren’t for the sudden noise and chaos that erupted out of seemingly nowhere to torture your ears.\n\n");
		outputText("\"<i>Damn fiend! Get back here!</i>\"\n\n");
		outputText("The sound of an angry Siegweird and what sounds like the sizzling of magic is enough to draw your attention. Has a demon attempted to invade your camp? Or were they simply unlucky enough to come across Siegweird? Regardless it might be best to see what all the commotion is.\n\n");
		outputText("\"<i>I'm sorry bear! I promise to never attempt to take more than offered again. Just please cease your attack!</i>\" The sound of a panicked Grayda speaking your echoed language draws your attention, has there been some sort of misunderstanding?\n\n");
		outputText("\"<i>Praying to your gods won’t save you now!</i>\" It definitely seems there has been a misunderstanding, it might be best to step in before either of your subjects in question get hurt. A stray construct crashes a couple inches in front of your feet with a loud blast. Better get this handled quick.\n\n");
		outputText("Observing the scene. You can see Grayda perched up on top of a rock attempting to keep an angered Siegweird at bay with her staff, however, neither have seemed to notice your presence. Now, what would be the best way to get their attention? Maybe something loud would do. Taking in a deep breath, you utter a deep, fearsome roar from your extra maw that could bring any beast to fear.\n\n");
		outputText("\"<i>Princess?</i>\" Grayda’s gaze is drawn to you in a surprisingly calm fashion despite the scenario. however the same can’t be said for Siegweird, how is alarmed by the sudden noise.\n\n");
		outputText("\"<i>[name]? Forgive me, but this isn’t it what it looks like!</i>\"\n\n");
		outputText("Some explaining of the current situation would be nice as this could be taken as something much worse than it might actually be. Would he care to start first?\n\n");
		outputText("\"<i>Well, the magic cauldron needs time to refill its contents. So we need to limit how much a single person can have from it.</i>\" He seems to have eased up a little, but why was he so aggressive over a bit of soup?\n\n");
		outputText("\"<i>I get it, no more than one serving. lesson learned, but was violence necessary, surface walker?</i>\" Seems like this small incident might be another black mark on their relationship.\n\n");
		outputText("Maybe they should have a fair bit of time apart, clearly, they don’t mix well and infighting isn’t going to help anyone here.\n\n");
		outputText("\"<i>Gladly.</i>\" They both seem to have come to an agreement at least. Hopefully, this doesn’t happen again.\n\n");
	}
	if (player.hasStatusEffect(StatusEffects.CampRathazul) && rand(2) == 0) {
		outputText("Another pleasant day at camp is what crosses your mind as you take a moment to breathe and relax after facing the tribulations this land has to offer. Or at least that’s what you wanted to do if it weren’t for Grayda’s sudden outburst that could be audibly heard throughout the camp.\n\n");
		outputText("\"<i>KEEP POKING ME YOU DAMN RAT, AND I'M GOING TO PULL YOUR TAIL UP AND CONVERT YOU PERSONALLY!</i>\"\n\n");
		outputText("Come to think of it, is this the first time you’ve ever heard Grayda being genuinely angry? Maybe it wouldn’t hurt to check what’s going on over there that’s got her so riled up. Approaching the scene you can see Grayda attempting to re-find her composure in front of Rathazul.\n\n");
		outputText("\"<i>In Fact… I would take great pleasure in the action.</i>\" She pats down her stomach as if she was attempting to remove dirt which may be clinging to her clothing. Rathazul looks like he is about to speak before he is abruptly cut off by Grayda. \"<i>And don’t ask my Princess for samples… this is my only warning.</i>\"\n\n");
		outputText("Well, it seems like someone is certainly a bit overprotective of you.\n\n");
	}
	if (player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_BIMBO_STATE] != 3 && rand(2) == 0) {
		outputText("You can see Jojo and Grayda meditating a bit further out on the camp’s perimeter, or at least Jojo is. Grayda seems to be giving him a side glance as she tries to hide her drooling mouth. However, this doesn’t seem to last long as the small mouse boy takes notice of Grayda.\n\n");
		outputText("\"<i>Please focus, Grayda. The sooner you focus, the sooner we can get to solving the mystery of your and [name]’s corruption.</i>\"\n\n");
		outputText("\"<i>R-Right!</i>\" Grayda seems to quickly regain her composure and goes back to attempting to meditate. It doesn’t last long however as she seemingly goes back to looking at Jojo as if he was prey.\n\n");
	}
	if (followerKiha() && rand(2) == 0){
		outputText("Surprisingly it seems a commotion has started in camp. Unsurprisingly it seems someone has gotten Kiha fired up, best you try and calm things down before they get out of hand.\n\n");
		outputText("\"<i>Listen here, ocean slut! I don’t want you going anywhere near [name]!</i>\"\n\n");
		outputText("\"<i>Why would I neglect my duties as her loyal retainer?</i>\" it seems Grayda has somehow gotten herself entangled in a conflict with Kiha... over you oddly enough.\n\n");
		outputText("\"<i>Loyal retainer my ass! It doesn’t take a master tactician to know you're obviously manipulating her, and the cause of her corruption!</i>\" Kiha seems to be getting more and more irritated\n\n");
		outputText("\"<i>Manipulating her? How outlandish! I'm at my Princess’s beck and call. As for her ‘Corruption’, it’s something not even I know the source of, but I highly doubt my Princess is even capable of becoming a demon.</i>\" She crosses her arms and looks as though she is about to lose herself in thought before being snapped out of it by Kiha’s continued outburst.\n\n");
		outputText("\"<i>Corruption is Corruption, Fiend, so what if it doesn't turn people into demons, it still taints the mind, and in some cases, the very soul!</i>\" Kiha looks like she’s very close to snapping and taking a swing at Grayda.\n\n");
		outputText("\"<i>You are not much better, 'Dragon', you reek of corruption as well.</i>\"\n\n");
		outputText("And with that Kiha swings her ax down upon Grayda, who swiftly steps out of the way, but their fight is stopped just as fast as it started as they finally take note of your presence.\n\n");
	}
	endEncounter();
}
public function graydaRandomnCampEvents2():void {
	flags[kFLAGS.THE_TRENCH_ENTERED]++;
	graydaAffection(2.5);
	doNext(camp.returnToCampUseOneHour);
}
private	function grayda():void {
	outputText("\"<i></i>\"\n\n");
}
	}
}
