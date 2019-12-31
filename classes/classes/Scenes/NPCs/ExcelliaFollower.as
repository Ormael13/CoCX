/**
 * ...
 * @author Ya Boi Guzma
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.display.SpriteDb;
	
	public class ExcelliaFollower extends NPCAwareContent implements TimeAwareInterface
	{
		public var pregnancy:PregnancyStore;
		
		public function ExcelliaFollower() 
		{
			pregnancy = new PregnancyStore(kFLAGS.EXCELLIA_PREGNANCY_TYPE, kFLAGS.EXCELLIA_PREGNANCY_INCUBATION, 0, 0);
			pregnancy.addPregnancyEventSet(PregnancyStore.PREGNANCY_PLAYER, 340, 270, 190, 130, 60);
												//Event: 0 (= not pregnant),  1,   2,   3,   4,  5,  6 (< 50)
			EventParser.timeAwareClassAdd(this);
		}
		
		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			pregnancy.pregnancyAdvance();
			return false;
		}
		public function timeChangeLarge():Boolean {
			return false;
		}
		//End of Interface Implementation

public function ExcelliaPathChoice():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	if (followerShouldra()) {
		outputText("When you arrive back at camp you notice the cow-queen Excellia sitting patiently by your bedroll, seemingly waiting for your return. Approaching carefully, she gently opens her eyes and reveals to you that Shouldra is still driving the Queen.\n\n");
		outputText("\"<i>Hey, champ! Good to see ya again! ...Does this mean you managed to defeat Lethice?</i>\"\n\n");
		outputText("She stands up, bringing herself to her full height. She must be over seven feet tall, you realise as she pulls you into a soft, squishy embrace. Her tail gently caresses your butt, and she lets out a moo of happiness. Pulling away, she looks at you.\n\n");
		outputText("\"<i>Well, I guess it's time for me to leave this body~</i>\"\n\n");
		outputText("You look into Shouldra's eyes as she leans forward, lips puckered. Happy to oblige, you kiss her fiercely, golden lipstick sending sensations rushing through your body. Her tongue searches hungrily in your mouth, exploring it's depths with zeal. You feel the odd sensation as Shouldra leaps across the gap, worming her way back into you. Excellia's eyes fade from gold back to a lighter yellow colour, before rolling back in her head and collapsing suddenly to the ground.\n\n");
		outputText("\"<i>Huh... I wondered why she wasn't fighting me. She's still exhausted from being ravaged by the minotaur king... I'm sure she'll wake up in a few hours, though</i>\"\n\n");
	}
	else {
		outputText("When you return, you bring her to your "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "cabin and lay her on your bed":"tent and lay her on you bedroll")+" . You're pretty sure she'll come to in a few hours or so.\n\n");
	}
	doNext(ExcelliaPathChoice2);
}
public function ExcelliaPathChoice2():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("For the past few hours you've been sitting "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "in a chair":"inside your tent")+" waiting for the ex-cow queen to wake up. You find yourself dozing off a bit. Just as you're about to close your eyes you hear Excellia stirring. You look over to see the cow sitting up. She looks around somewhat dazed and confused, unsure of where she is. Her yellow eyes fall onto you but they appear glazed over and vaguely aware.\n\n");
	outputText("\"<i>" + player.mf("Lord", "Lady") + "…? My... " + player.mf("Lord", "Lady") + "… Is it time?</i>\"\n\n");
	outputText("Time? Time for what exactly?\n\n");
	outputText("\"<i>To make use of my shameless pussy my " + player.mf("Lord", "Lady") + ". I am always willing and wanting for you… Please don't keep me waiting!</i>\"\n\nThe cow slut gets up on her hands and knees then turns around, lifting up her tail and presenting her large curvaceous ass and dripping womanhood. ");
	outputText("She either thinks you're the Minotaur King or she simply can't think clearly with her cum addicted mind. After spending so long under the effects of minotaur spunk, that seems to be the only thing on her mind at the moment. Looking at the slight jiggle her ass gives with each ragged breath is more than tempting. Though you're not sure if that would be a good idea if you want to help restore her. What will you do?");
	menu();
	addButton(1, "Fix Her", ExcelliaPathChoiceFixHer);
	addButton(3, "Make Slave", ExcelliaPathChoiceMakeSlave);
}
public function ExcelliaPathChoiceFixHer():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You shake your head, chasing away the thought. While it would probably feel more than amazing to take the ex-cow queen in this manner, it would probably do more harm than good at this given point and you let her know that much by getting up and turning her back around. She looks up at you, confused as to why you didn't take her. You explain to her that she doesn't have to service you. Her confusion seems to deepen.\n\n");
	outputText("\"<i>I… don't understand… You don't want me…?</i>\"\n\n");
	outputText("It's not that you don't want her, it's just she doesn't have to do it all the time. There is more to life than just slutting. The cow girl shakes her head, obviously upset.\n\n");
	outputText("\"<i>I've been good I swear! P-Please use me! I-</i>\"\n\n");
	outputText("You shush her, telling her to calm down. She isn't a slave to the Minotaur King anymore. She doesn't have to be forced to serve anyone nor does she need to be impaled on mino dick every waking moment of the day. Excellia sits in silence staring at the floor. You're not entirely sure if your words are even reaching her. Maybe in time perhaps. For now you need to get her sleeping arrangements in order. You sigh then grab her hands, urging her to get up.");
	outputText(" She looks up at you hopeful.\n\n\"<i>My " + player.mf("Lord", "Lady") + "? Have you changed your mind?</i>\"\n\n");
	outputText("You tell her that you're going to help her get settled in for the time being then head outside with her. She looks around almost in awe, almost as if she’s barely seen the outside world. You find a good place for her to stay then sit her down as you head off to fetch some supplies for a tent and a bedroll. ");
	outputText("When you return you find the ex-cow queen obediently waiting where you left her. In no time flat, you set up her tent and bedroll, making it as cozy as possible. You tell Excellia that this is where she can sleep from now on. She looks at her tent then back at you, biting her lip nervously.\n\n");
	outputText("\"<i>Does this mean you’ll finally make use of me my " + player.mf("Lord", "Lady") + "?</i>\"\n\n");
	outputText("You explain to her that she doesn’t need to call you that. She also doesn’t need to be used in that manner either. She isn’t a slave to the Minotaur King anymore after all and you’re not like him either nor will you ever be. That’s one point you wish to make very clear with her. She looks at you, crestfallen, having been denied a second time. Instead of saying anything else, she crawls into her tent letting out a pitiful moo. ");
	outputText("Once she’s inside, you let out a shaky sigh. While it was hard enough to resist the curvaceous cowgirl’s advances, you know this is the best for her at the moment. That tainted minotaur cum constantly pumped into her more than likely turned her into a full cow slut but maybe given enough time, you can help bring her back around mentally and physically… in your own way. Some items could help too.\n\n");
	outputText("(<b>Excellia has been added to the Followers menu!</b>)\n\n");
	flags[kFLAGS.EXCELLIA_RECRUITED] = 3;
	doNext(camp.returnToCampUseFourHours);
}
public function ExcelliaPathChoiceMakeSlave():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("It’s hard to resist a cowslut presenting herself to you begging to be fucked and you’re more willing to oblige.\n\n");
	if (player.hasCock()) {
		outputText("You waste no time "+(player.isNaked() ? "":"stripping off your gear and ")+"stepping up behind the ex-cow queen then grabbing her hips. You grind your [cock] between her large jiggly ass cheeks. Her tail swishes back and forth as she eagerly waits for her treat. She looks back over her shoulder at you, a deep blush present on her face. She pushes back against you every time your rock hard cock rubs against her pussy.\n\n");
		outputText("\"<i>P-Please my " + player.mf("Lord", "Lady") + "! I can't wait any longer. My pussy needs your cock!</i>\"\n\n");
		outputText("You deliver a sharp smack across her ass. You're the one who will decide when she's granted the pleasure of receiving your dick. She whimpers and lets out a needy moan as you continue to fuck her fat cheeks. Her massive milky mammaries slowly leak their euphoric sweet cream onto your "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "bed":"bedroll")+". The huge soft orbs jiggling freely with every breath their owner takes. ");
		outputText("The bovine slut moos pleadingly for your [cock] inside her. You slide your dick across her entrance, coating yourself in her slick lubricants in preparation. With little warning, you slip your shaft into her, stretching her big pussy lips into a warm embrace. Rearing back, you slam your groin into Excellia's needy cunt, grinning as she sprays fem lube around your [cock]. She lets out a fulfilled moo as you finally penetrate her.\n\n");
		outputText("You pick up the pace, giving her rough, strong thrusts until your "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "bed":"bedroll")+" is sodden with her juices and thick blobs of your pre-cum. You reach forward and grab her massive milk gushing tits. She groans and moos as you manhandle her chest and milk her. You slam your dick into her depths with increased ferocity until she throws her head back and screams, cumming hard around your dick. ");
		outputText("You thrust your way through it, riding out her powerful contractions and bucking until she’s panting and heaving, and her flow seems to pick up more. You're hardly done with the cum slut. You plow into her harder, sinking your fingers into her squishy cheeks as you pound her soaked cunt. Her lube and femcum helping you to slam in and out of her at pelvis breaking speeds. She moos loudly, but it turns into a muffled yelp when you shove her face into your ");
		outputText("now soaked "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "bed":"bedroll")+" and yank on her tail, causing her passage to squeeze like a vice around you. Slick and tight, Excellia’s cow-cunt is the perfect hole for your needy [cock]. You roar and yank her tail one last time, splattering her innermost depths with your hot baby batter until her belly begins to bloat with the sheer amount of cream you’re pumping into her.\n\n");
		outputText("You pull out, jerking off the last of your seed onto her ass and back. You grin as the slutty cow-girl collapses in the pool of spunk, femcum, and milk you’ve made beneath, her exhausted and panting. You roll her onto her back, laughing at her blissed expression. Her eyes are rolled back into her head and her tongue lolls out.\n\n");
		outputText("\"<i>T-Thank you my " + player.mf("Lord", "Lady") + "... I… am always… here to serve you…</i>\"\n\n");
		outputText("You pat your new cum receptacle on the head and tell her that you'll be sure to make great use of her. She lets out a tired moo before drifting off to sleep again. Your grin widens as you think of more ways to use her.\n\n");
	}
	else {
		outputText("You waste no time "+(player.isNaked() ? "":"stripping off your gear and ")+"stepping up to the ex-cow queen then turn her around. You tell her to get to it then lower her head down to your pussy. Excellia lifts her head and begins desperately licking and slurping your pussy. She blows on your clit, causing you to gasp in pleasure. The cow slut licks you until your first orgasm rocks you, drenching her face and mouth with femcum. ");
		outputText("She quickly slurps down your juices, not wasting a single drop.\n\n\"<i>P-Please my Lady… M-More…</i>\"\n\n");
		outputText("Now with such a slutty look on her face, who are you to deny your new fuckpet? She pushes her mouth against your snatch, tightly sealing her mouth around your dripping snatch before diving her tongue back in. You moan and grip her horns tightly, mashing her face further into your pussy. The cow slut is eager to lap every little drop of femcum that spills from you. Her tongue pushes you closer and closer to the edge. ");
		outputText("When she sucks your clit into her mouth, a body rocking orgasm tears through you. Your juices floods her mouth as she greedily gulps it all down. You keep feeding her more of your femcum, your orgasm seemingly lasting an eternity. Excellia rubs her growing belly as it rounds out from the amount she's drinking. Her pussy and milk filled jugs leaks like a running faucet, adding to the growing puddle beneath her.\n\n");
		outputText("With a satisfied sigh, you let go of her and get up. The ex-cow queen slumps down with a dreamy expression on her face.\n\n");
		outputText("\"<i>T-Thank you my Lady… I'm always… willing to serve you…</i>\"\n\n");
		outputText("After that she sinks down then drift off into sleep. You pat the sleeping cow slut on the head. You grin thinking of new ways to use your new fuckpet.\n\n");
	}
	outputText("(<b>Excellia has been added to the Slaves menu!</b>)\n\n");
	flags[kFLAGS.EXCELLIA_RECRUITED] = 2;
	player.orgasm();
	doNext(camp.returnToCampUseFourHours);
}

public function ExcelliaCampMainMenuFixHer():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	if (flags[kFLAGS.EXCELLIA_RECRUITED] > 32) {
		outputText("When you approach, the sizable cowgirl turns to you with a warm smile on her face.\n\n");
		outputText("\"<i>Hello, [name]! Something you need?</i>\"\n\n");
	}
	else {
		outputText("When you approach, the ex-cow queen eagerly crawls up to you.\n\n");
		outputText("\"<i>My " + player.mf("Lord", "Lady") + "! Have you finally come to take me? Oh, please say yes!</i>\"\n\n");
	}
	menu();
	addButton(14, "Back", camp.campFollowers);
}
public function ExcelliaCampMainMenuMakeSlave():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You approach your needy cowslut. She perks up then crawls over to you. She kneels in front of you, shivering in anticipation and huge milk jugs dribbling milk.\n\n");
	outputText("\"<i>My " + player.mf("Lord", "Lady") + "! How will you use your lowly cowslut today?</i>\"\n\n");
	menu();
	addButton(14, "Back", camp.campSlavesMenu);
}

private function excelliaPreg():void {
	if (!pregnancy.isPregnant && rand(100) < (10 + Math.round(player.cumQ() / 100))) {
		pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_EXCELLIA);
		//player.createStatusEffect(StatusEffects.MitziPregnant, 0, 0, 0, 0);
	}
}

	}
}