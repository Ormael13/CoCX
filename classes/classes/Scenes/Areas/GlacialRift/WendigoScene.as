/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.GlacialRift
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	import classes.BodyParts.*;
	import classes.Scenes.SceneLib;

	public class WendigoScene extends BaseContent
	{

		public function WendigoScene()
		{
		}

		public function encounterWendigo():void {
			clearOutput();
			outputText("As you explore the rift you hear an unsettling scream in the far distance. Unsure about what that was you keep going along your current path until the scream happens again somewhat closer now. Now persuaded that something is stalking you, you look around for your opponent.\n\n");
			outputText("Not too far away, a feminine figure clad with a fur coat approaches you. You know better than to trust a random wanderer, especially in the middle of such an inhospitable land. Initially, you assume it to be a human girl who got lost in the snow, her voice pleading for help. She sounds miserable. Should you help her?\n\n");
			menu();
			addButton(1, "Help", encounterWendigo2);
			addButton(3, "No way", encounterWendigo3);
		}
		public function encounterWendigo2():void {
			if (rand(2) == 0) {
				outputText("You walk steadily toward the lost girl to offer her support.\n\n");
				outputText("Closing in you realize it's a young yeti, she's trying her damn best to look for her home in the snowstorm but got lost all on her own. It’s likely that if someone doesn't help her she won't make it back home alive, what with all the monsters out there.\n\n");
				outputText("You escort the girl until you find some help, Luckily for you finding Yu shop fairly easily thanks to all the wooden signs she left around. Yu is very surprised to see you arrive with the child.\n\n");
				outputText("\"<i>Yu amazed [name], [name] found this kid in the blizzard and brought her all the way here? Most never come back home. Come with Yu child, Yu will make you some warm food and once storm is over we look for parent.</i>\"\n\n");
				outputText("Thankful, Yu gives you a few gems for your trouble. Guess being nice pays off sometimes?\n\n");
				player.gems += 10 + rand(10);
				doNext(camp.returnToCampUseTwoHours);
			}
			else {
				if (player.wendigoScore() >= 10) {
					outputText("You walk steadily toward the lost girl to offer her support. Then you realise it's just another wendigo.\n\n");
					outputText("\"<i>So hungry… kin please, do you have food… anything... I’m starving.</i>\"\n\n");
					outputText("You don’t and truth be told even if you did you wouldn’t share it with her because if you did have food you would have eaten it already. Wendigos are the reason you are in this sorry state in the first place. Frustrated by your reply the wendigo turns back heels and wails as she resumes looking for food, which reminds you that you also need to look for lunch. You head back to camp still starving.\n\n");
					doNext(camp.returnToCampUseTwoHours);
				}
				else {
					outputText("You walk steadily toward the lost girl to offer her support.\n\n");
					outputText("It's only when she gets closer that you identify what you mistook for an open helmet as a pair of deer antlers jutting from under the creature's fur hood through a set of holes! Not to mention the claws, the cold glowing dead stare, or the emaciated body bordering anorexia. Your eyes are drawn to its lower body as you notice this monster hovers above the snow, its leg ending with furry forelimbs and a notable absence of feet!\n\n");
					outputText("Smiling wide with a stare that betrays an endless hunger for pleasures that can never be fully sated, the creature lunges at you with its greedy claws.\n\n");
					SceneLib.glacialRift.GlacialRiftConditions();
					startCombat(new Wendigo());
				}
			}
		}
		public function encounterWendigo3():void {
			clearOutput();
			outputText("Nope, you're not going to follow the cries of some girl in the middle of nowhere, this is a trap waiting to be sprung into action, and you will not fall for it.\n\n");
			outputText("You head back to camp in due haste, not looking back for who is crying out loud for help.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}

		public function loseToWendigo():void {
			clearOutput();
			if (!player.hasStatusEffect(StatusEffects.WendigoPsychosis) && !player.hasPerk(PerkLib.EndlessHunger)) player.createStatusEffect(StatusEffects.WendigoPsychosis,168,0,0,0);
			outputText("You fall on the ground defeated, and the wendigo howls victoriously, which only helps in preventing you from escaping. The thing begins to speak in a very psychotic manner.\n\n");
			outputText("\"<i>Hungry… so HUNGRY! Give me... GIVE ME!</i>\"\n\n");
			outputText("Just how hungry is she... is she about to devour you alive?! Your question is swiftly answered as she strips and tosses your equipment to the side zeroing right up onto your crotch.\n\n");
			if (player.hasCock() && (!player.hasVagina() || !sceneHunter.uniHerms) || (rand(2) == 0)) {
				outputText("Before you can say a word, she already has her ass up to your face, presenting you with her inhuman looking pussy as her mouth hungrily wraps around your [cock] taking in the entire length."+(player.biggestCockLength() >= 30) ? " Just how the hell can she take all of this in? This is definitely not natural!":""+" Your member is easily forced into full erection ");
				outputText("as her devilish tongue skillfully coaxes you toward the inevitable ejaculation. You try and shove her off you, but she turns out to be extremely strong for her frame, easily pinning you down with her arms. Your cock feels as if it is alive with pleasure, and inevitably you cum into the ravenous girl's mouth. A fraction of a second later you watch in a stupor as a literal fountain of juice shoots out of her pussy right into your face. ");
				outputText("Did the crazy bitch cum just from sucking you off? You thought this nightmare was finally over but to your horror it has only just started as the thing resumes tormenting your prick, is she insatiable? Your question is answered a while later as you pass out sometime before she stops.\n\n");
				outputText("When you wake up you are in some random cave, your stuff neatly piled up next to you. At least she had the decency NOT to let you die in the cold despite sucking you off until you blacked out. You head back to camp sore and tired but at least alive.\n\n");
				player.sexReward("vaginalFluids","Vaginal");
			}
			else if (player.hasVagina()) {
				outputText("Before you can say a word she already has her ass up to your face, presenting you her inhuman looking pussy as her tongue hungrily strikes at your [clit], teasing your most sensitive spots. Your pussy is easily forced into full bloom as her devilish tongue skillfully coaxes you toward the inevitable climax. ");
				outputText("You try and shove her off you, but she turns out to be extremely strong for her frame, easily pinning you down with her arms. Your pussy feels alive with pleasure and inevitably, against your will, you cum into the ravenous girl's mouth flooding her with your pussy juices. A fraction of a second later you watch in a stupor as a literal fountain of juice shoots out of her pussy right into your face. ");
				outputText("Did the crazy bitch cum just from eating you out? You thought this nightmare was finally over however but to your horror it just has started as the thing resumes tormenting your cunt, is she insatiable? Your question is answered a while later as you pass out sometime before she stops.\n\n");
				outputText("When you wake up you are in some random cave, your stuff neatly piled up next to you. At least she had the decency NOT to let you die in the cold despite eating you out until you blacked out. You head back to camp sore and tired but at least alive.\n\n");
				player.sexReward("vaginalFluids","Vaginal");
			}
			else {
				outputText("Her expression turns from anticipation to absolute despair as she discovers you have absolutely no sexual endowments!\n\n");
				outputText("\"<i>No! NOOOOO!! This is so unfair I've been starving for weeks, and the only traveler I could find has nothing between its legs! Why… WHYYYYY!!!!</i>\"\n\n");
				outputText("While she screams curses at her frustration of being denied you use this opportunity to pack off and escape. Guess it turns out having no endowment was useful for once.\n\n");
			}
			cleanupAfterCombat();
		}

		public function winAgainstWendigo():void {
			clearOutput();
			outputText("The wendigo falls to the ground too weak to keep on floating.\n\n");
			outputText("You approach the monster intent on making it regret attacking you but suddenly the blizzard increases in intensity again. You close your eyes for a mere second but when you open them again the wendigo is gone. Well of all things you didn't expect getting your victory stolen away from you by the weather.\n\n");
			outputText("Unable to find the monster anymore, you decide to head back to camp still feeling the unsettling sensation of two hungry eyes fixating you from the depths of the blizzard until the magic of the realm spirits you away.\n\n");
			cleanupAfterCombat();
		}

		public function becomeWendigo():void {
			clearOutput();
			outputText("Hungry… so damn hungry! You have been "+((flags[kFLAGS.HUNGER_ENABLED] <= 0 && player.lust >= player.maxLust()) ? "sexually ":"")+"starved for days now!\n\n");
			outputText("Unable to stand it anymore, you head into the wild and look for something… anything to sate your maddening needs! As your luck has it an imp happens to show up right at the right time. The demon tries to cast a lust inducing spell on you but to no avail, nothing will distract you from your fixation on this meaty fat cock he's sporting.\n\nYou practically leap on the imp pushing him into the ground ");
			outputText("as you begin ravenously feasting on his towering tool, licking at the flesh to coax him into orgasm. The confused demon struggles to get you off his prick but can only moan at the unrequited pleasure you coax into him from forcefully sucking him off. While the little bugger shifts and pushes around you discover new muscles and skills your tongue until now lacked and put them to good use. ");
			outputText("It merely takes you a few seconds to finally force him to cum, and you begin gleefully feast on his seed, your unnatural hunger satisfied for a fraction of seconds before it resumes again. More… you need MORE!\n\nYour body begins changing as you resume coaxing the imp into orgasm, "+(player.arms.type == Arms.HUMAN ? "":"your arms taking back on their old human shape before ")+"your nails ");
			outputText("crooks into vicious claws. Your "+(player.faceType == Face.ANIMAL_TOOTHS ? "formerly somewhat human face warp itself into that of a deer":"face"+(player.faceType == Face.HUMAN ? "":" turns back to its human self as it")+" grows sharp canines, not unlike those of a beast")+". ");
			outputText("You"+(player.tailType == Tail.NONE ? " moan as a new appendage forms out of the area just above your ass":"r tail changes becoming increasingly thick with warm fluffy fur")+". Thick fur covers the new flesh, and you are soon with a thick furry tail. Fur surge at your shoulder thickening unnaturally into a coat of which the hood covers your head. ");
			outputText("Finally, you reach orgasm "+(player.hasCock() ? "your now equine (or deer if available) cock splattering seed on the ground ":"")+""+(player.gender == 3 ? "while ":"")+""+(player.hasVagina() ? "your equine(or deer) pussy juices waters the soil beneath you ":"")+"running down your now furry feet-less legs as two large bony stump breaks out of your forehead in a pair of intimidating antlers. ");
			outputText("Your still glazed but dead eyes open upon the world their irises glowing with a spectral blue light <b>as you achieve the last of your transformation into a wendigo!</b>\n\n");
			outputText("Still hungry you resume eating out the imp dick for the next few hours until the poor thing just passes out unable to cum any further. In frustration, you head back to camp your hunger still nagging at you. You console yourself knowing that there's plenty of cock to suck and pussy to eat out, you will find some around, you just need to keep searching.\n\n");
			player.removeStatusEffect(StatusEffects.WendigoPsychosis);
			player.hairColor = "silver-white";
			player.coatColor = "snow white";
			if (player.faceType == Face.ANIMAL_TOOTHS) {
				CoC.instance.transformations.FaceDeer.applyEffect(false);
				if (!player.hasPlainSkinOnly() && !player.hasPartialCoat(Skin.FUR)) CoC.instance.transformations.SkinPlain.applyEffect(false);
				else if (player.hasPlainSkinOnly()) CoC.instance.transformations.SkinFur(Skin.COVERAGE_LOW, {color: player.coatColor}).applyEffect(false);
			}
			else {
				CoC.instance.transformations.FaceAnimalTeeth.applyEffect(false);
				if (!player.hasPlainSkinOnly() && !player.hasPartialCoat(Skin.FUR)) CoC.instance.transformations.SkinPlain.applyEffect(false);
			}
			if (player.tailType != Tail.WENDIGO) CoC.instance.transformations.TailWendigo.applyEffect(false);
			if (player.lowerBody != LowerBody.WENDIGO) transformations.LowerBodyWendigo.applyEffect(false);
			if (player.arms.type != Arms.WENDIGO) CoC.instance.transformations.ArmsWendigo.applyEffect(false);
			if (CoC.instance.transformations.EyesDead.isPossible()) {
				CoC.instance.transformations.EyesDead.applyEffect(false);
				CoC.instance.transformations.EyesChangeColor(["spectral blue"]).applyEffect(false);
			}
			if (player.tongue.type != Tongue.RAVENOUS_TONGUE) CoC.instance.transformations.TongueRavenous.applyEffect(false);
			if (player.horns.type != Horns.ANTLERS) CoC.instance.transformations.HornsAntlersWendigo.applyEffect(false);
			if (player.ears.type != Ears.DEER) CoC.instance.transformations.EarsDeer.applyEffect(false);
			if (player.wings.type != Wings.LEVITATION) CoC.instance.transformations.WingsLevitation.applyEffect(false);
			if (player.rearBody.type != RearBody.FUR_COAT) CoC.instance.transformations.RearBodyFurCoat.applyEffect(false);
			if (player.hasVagina() && player.vaginaType() != VaginaClass.EQUINE) player.vaginaType(VaginaClass.EQUINE);
			if (player.hasVagina() && player.biggestTitSize() < 8) player.breastRows[0].breastRating += 8;
			if (player.hasCock() && player.horseCocks() < player.cocks.length) player.addHorseCock();
			if (player.skin.base.pattern != Skin.PATTERN_NONE) {
				CoC.instance.transformations.SkinPatternNone.applyEffect(false);
			}
			if (!player.hasPerk(PerkLib.ColdAffinity)) player.createPerk(PerkLib.ColdAffinity, 0, 0, 0, 0);
			player.createPerk(PerkLib.UnnaturalStrength, 0, 0, 0, 0);
			player.createPerk(PerkLib.EndlessHunger, 0, 0, 0, 0);
			player.createPerk(PerkLib.WendigoCurse, 0, 0, 0, 0);
			player.hunger = 80;
			doNext(camp.returnToCampUseOneHour);
		}

	}

}