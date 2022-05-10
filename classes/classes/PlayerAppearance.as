package classes {
import classes.BodyParts.*;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.NPCs.Forgefather;
import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

import coc.xxc.BoundStory;
import coc.xxc.Story;

public class PlayerAppearance extends BaseContent {


	public function PlayerAppearance() {
		onGameInit(init);
	}
	protected function inchesOrCentimetres(...args):String { return Measurements.inchesOrCentimetres.apply(null, args); }
	protected function shortSuffix(...args):String { return Measurements.shortSuffix.apply(null, args); }
	private function init():void {
 	}
	public function appearance(debug: Boolean = false):void {
 		//Temp vars
		var temp:Number = 0;
		var rando:Number = 0;
		//Determine race type:
		clearOutput();
		mainView.hideComboBox();
		if (!debug) outputText("<font size=\"36\" face=\"Georgia\"><u>Appearance</u></font>\n");
		else outputText("<font size=\"36\" face=\"Georgia\"><u>Body Parts Editor</u></font>\n");
		if (CoC.instance.gameSettings.charviewEnabled) {
			mainViewManager.showPlayerDoll(debug);
		}
		describeRace();
		if (!player.hasPerk(PerkLib.ElementalBody)) {
			outputText("[pg]" + Utils.mergeSentences([describeSkin(), describeSkinPattern()], ", while "));
			outputText(" " + describeFace());
			outputText(" Your features are adorned by " + player.faceDescArticle() + "."); //M/F stuff!
			outputText("[pg]");
			outputText(Utils.mergeSentences([describeHair(), describeEars()], ", while "));
			if (describeHorns() || describeAntennae()) {
				outputText(" Beyond that, ");
				outputText(Utils.lowerCaseFirstLetter(Utils.mergeSentences([describeHorns(), describeAntennae()])));
			}
			outputText(" " + Utils.mergeSentences([describeEyes(), describeTongue()]));
			if (describeBeard() || describeGills()) {
				outputText(" Also, ");
				if (describeBeard() && describeGills()) {
					outputText(Utils.lowerCaseFirstLetter(Utils.mergeSentences([describeBeard(), describeGills()])));
				} else {
					outputText(describeBeard() ? Utils.lowerCaseFirstLetter(describeBeard()) : "");
					outputText(describeGills() ? Utils.lowerCaseFirstLetter(describeGills()) : "");
				}
			}
			describeVisage();
			outputText("[pg]" + Utils.mergeSentences([describeArms(), describeLowerBody()]));
			const wingsDescription: String = describeWings();
			outputText(wingsDescription ? "[pg]" + wingsDescription : "");
			const rearBodyDescription: String = describeRearBody();
			outputText(rearBodyDescription ? "[pg]" + rearBodyDescription : "");
			const tailDescription: String = describeTail();
			outputText(tailDescription ? " " + tailDescription : "");
		}
		outputText("[pg]" + describeBreasts());
		const crotchDesc: String = describeCrotch();
		outputText(crotchDesc ? " " + crotchDesc : "");
		if (player.cocks.length > 1) {
			outputText("[pg]" + describeCock());
			outputText("[pg]" + describeBalls());
		} else {
			if (player.hasCock() || player.balls > 0) {
				outputText("[pg]" + Utils.mergeSentences([describeCock(), describeBalls()]));
			}
		}
		const pussyDesc: String = describePussy();
		outputText(pussyDesc ? "[pg]" + pussyDesc : "");
		const noSexString: String = (player.cockTotal() == 0 && player.vaginas.length == 0 ? "You have a curious lack of any sexual endowments." : "");
		if (player.ass || noSexString) {
			outputText("[pg]" + Utils.mergeSentences([noSexString, describeAsshole()]));
		}
		const piercingsDesc: String = describePiercings();
		outputText(piercingsDesc ? "[pg]" + piercingsDesc : "");
		const specialCasesDescription: String = describeSpecialCases();
		outputText(specialCasesDescription ? "[pg]" + specialCasesDescription : "");
		const pregnancyDescription: String = describePregnancy();
		outputText(pregnancyDescription ? "[pg]" + pregnancyDescription : "");
		// EQUIPMENT
		outputText("[pg]" + describeGear());
		//MONEY!
		outputText("[pg]" + describeMoney());
		menu();
		addButton(0, "Next", playerMenu);
		if (player.hasPerk(PerkLib.RacialParagon)) addButton(1, "Set Race.", ApexRaceSetting);
		addButton(2, "Weap View", WeaponDisplay);
		addButton(7, "Reflect", campActionsReflect).hint("Reflect on your current state and future plans. (Also would make your body fully adjust to any sudden changes to natural limits of your attributes after eating any odd things and etc.)");
		addButton(11, "Gender Set.", GenderForcedSetting);
		addButton(10, "RacialScores", RacialScores);
		flushOutputTextToGUI();
	}

	public function	WeaponDisplay():void {
		clearOutput();
		outputText("Select which weapon type you would prefer to see in the character portrait.");
		if (flags[kFLAGS.WEAPON_DISPLAY_FLAG] == 0) outputText("[pg]Display Style: <b>Melee</b>");
		if (flags[kFLAGS.WEAPON_DISPLAY_FLAG] == 1) outputText("[pg]Display Style: <b>Ranged</b>");
		mainView.hideAllMenuButtons();
		menu();
		addButton(0, "Melee", WeaponDisplaySwitch, 0).disableIf(flags[kFLAGS.WEAPON_DISPLAY_FLAG] == 0, "You are already displaying Melee weapons");
		addButton(1, "Ranged", WeaponDisplaySwitch, 1).disableIf(flags[kFLAGS.WEAPON_DISPLAY_FLAG] == 1, "You are already displaying Ranged weapons");
		addButton(14, "Back", appearance);
	}

	public function	WeaponDisplaySwitch(Display:Number):void {
		flags[kFLAGS.WEAPON_DISPLAY_FLAG] = Display;
		WeaponDisplay();
	}

	public function ApexRaceSetting():void {
		clearOutput();
		mainView.hideAllMenuButtons();
		ApexRaceDisplayTextUpdate();
		// Display selected race
		var races:Array = [];
		for (var i:int = 0; i < Race.ALL_RACES.length; i++) {
			var x:Race = Race.ALL_RACES[i];
			if (!x) continue; // Skip non-existing races
			races.push( { label: x.name, race: x} );
		}
		// fill the races
		CoC.instance.showComboBox(races,"Select race",function(item:Object):void {
			// item is selected
			flags[kFLAGS.APEX_SELECTED_RACE] = item.race.id;
			clearOutput();
			ApexRaceDisplayTextUpdate();
		});
		menu();
		addButton(0, "Finish", appearance);
	}

	public function ApexRaceDisplayTextUpdate():void {
		outputText("Select your racial paragon race: ");
		var selectedracetext:String;
		if (player.racialParagonSelectedRace() == null)
		{
			selectedracetext = "None";
		}
		else{selectedracetext = player.racialParagonSelectedRace().name}
		outputText("[pg]Currently selected: <b>" + selectedracetext + "</b>");
		flushOutputTextToGUI()
	}

	public function describeGear(): String {
		var gearDesc: String = "";

		// story.display("gear");
		gearDesc += "<b>You are currently " + (player.armorDescript() != "gear" ? "wearing your " + player.armorDescript() : "naked") + "" + ". You're using [weapon] as your melee weapon";
		if (player.weaponRangeName != "nothing")
			gearDesc += ", [weaponrangename] as your ranged weapon";
		if (player.shieldName != "nothing")
			gearDesc += " and [shield] as your shield";
		gearDesc += ".";
		if (player.headjewelryName != "nothing") {
			if (player.headjewelryPerk == "Helmet") gearDesc += " On your head is " + player.headjewelryName + ".";
			else gearDesc += " In your hair is " + player.headjewelryName + ".";
		}
		if (player.necklaceName != "nothing")
			gearDesc += " On your neck is a " + player.necklaceName + ".";
		if (player.hasKeyItem("Gleipnir Collar") >= 0) {
			if (player.necklaceName != "nothing") gearDesc += " Benath it is ";
			else gearDesc += " On your neck is ";
			gearDesc += "Fenrir's spiked Collar, pieces of the spectral chain Gleipnir still dangling from it, floating weightlessly and tracing your movements.";
		}
		if (player.jewelryName != "nothing") {
			gearDesc += " On one of your right hand fingers is a " + player.jewelryName + "";
			if (player.jewelryName3 != "nothing") gearDesc += " and on another finger is a " + player.jewelryName3 + "";
			if (player.jewelryName2 != "nothing") gearDesc += ", on one of your left hand fingers is a " + player.jewelryName2 + "";
			if (player.jewelryName4 != "nothing") gearDesc += " and on another finger is a " + player.jewelryName4 + "";
			gearDesc += ".";
		}
		gearDesc += "</b>";

		return gearDesc;
	}

	public function describePiercings(): String {
		var piercingsDesc: String = "";

		if(player.eyebrowPierced > 0)
			piercingsDesc += "A solitary " + player.eyebrowPShort + " adorns your eyebrow, looking very stylish. ";
		if(player.earsPierced > 0)
			piercingsDesc += "Your ears are pierced with " + player.earsPShort + ". ";
		if(player.nosePierced > 0)
			piercingsDesc += "A " + player.nosePShort + " dangles from your nose. ";
		if(player.lipPierced > 0)
			piercingsDesc += "Shining on your lip, a " + player.lipPShort + " is plainly visible. ";
		if(player.tonguePierced > 0)
			piercingsDesc += "Though not visible, you can plainly feel your " + player.tonguePShort + " secured in your tongue. ";
		if(player.nipplesPierced == 3)
			piercingsDesc += "Your " + nippleDescript(0) + "s ache and tingle with every step, as your heavy " + player.nipplesPShort + " swings back and forth. ";
		else if(player.nipplesPierced > 0)
			piercingsDesc += "Your " + nippleDescript(0) + "s are pierced with " + player.nipplesPShort + ". ";
		if(player.cockTotal() > 0) {
			if(player.cocks[0].pierced > 0) {
			piercingsDesc += "Looking positively perverse, a " + player.cocks[0].pShortDesc + " adorns your [cock]. ";
			}
		}
		if(flags[kFLAGS.CERAPH_FOLLOWER_PIERCING] == 1)
			piercingsDesc += "A magical, ruby-studded bar pierces your belly button, allowing you to summon Ceraph on a whim. ";
		if(player.hasVagina()) {
			if(player.vaginas[0].labiaPierced > 0)
			piercingsDesc += "Your " + vaginaDescript(0) + " glitters with the " + player.vaginas[0].labiaPShort + " hanging from your lips. ";
			if(player.vaginas[0].clitPierced > 0)
				piercingsDesc += "Impossible to ignore, your " + clitDescript() + " glitters with its " + player.vaginas[0].clitPShort + ". ";
		}

		return piercingsDesc;
	}

	public function describeMoney(): String {
		var moneyDesc: String = "";

		if(player.gems == 0) moneyDesc += "<b>Your money-purse is devoid of any currency.</b>";
		if(player.gems > 1) moneyDesc += "<b>You have " + addComma(Math.floor(player.gems)) + " shining gems, collected in your travels.</b>";
		if(player.gems == 1) moneyDesc += "<b>You have " + addComma(Math.floor(player.gems)) + " shining gem, collected in your travels.</b>";

		return moneyDesc;
	}

	public function describeRace():void {
		// story.display("race");
		if (player.hasPerk(PerkLib.ElementalBody)) {
			if (player.perkv1(PerkLib.ElementalBody) == 4) {
				outputText("You have currently fusioned with an water elemental spirit as an undine. Your body is humanoid in shape but many of your traits remind of water. You have light blue skin the color of azure while your "+Hair.getHairLength(player)+" blue liquid hair are human at a first glance but drips into a vanishing trail of water toward the end. ");
				outputText("Your eyes are the color sea water and your expression albeit serene mask the violent mood swing your element can be subject to. Calm like a pond or raging like the sea amidst a storm you can just as easily move from one to the other in a blink.\n\n");
				outputText("Your body, while mostly unified like a pool of water, is ornamented by a number of energy runes that allows you to maintain a solid shape somewhat. Your arms are human-like in shape, but just as the rest of your body, you can extend and shift your arms into churning water at any will. The skin is like water and can be semi seen through. ");
				outputText("Your legs are human-like in shape, though they occasionally drip water to the ground. Just like the rest of your semi liquid body, it's translucent as if staring through a pool of water. Your semi liquid form allows you to pleasantly float in the air like condensation, though you cannot outright fly.");
			}
			else if (player.perkv1(PerkLib.ElementalBody) == 3) {
				outputText("You have currently fusioned with an fire elemental spirit as a ignis. Your body is humanoid in shape but many of your traits remind of fire. You have tan skin as if spending too much time under the sun while your "+Hair.getHairLength(player)+" burning, raging flame like hair flow like raging flames. Your eyes are the color of blazing embers while your vicious expression mirrors the raging fire in your heart. You feel like going violent and reckless might solve some of your problems.\n\n");
				outputText("Your arms are human-like in shape, but at the junction of your wrists, fire wicks about in the palm of your hands. Your legs are human-like in shape, but a raging fire starts at your ankles, coating your feet entirely. You levitate by burning the ambient air around you. Wreathed in a corona of flame, you can fly freely as long as you have oxygen to propel you.");
			}
			else if (player.perkv1(PerkLib.ElementalBody) == 2) {
				outputText("You have currently fusioned with an earth elemental spirit as a gnome. Your body is humanoid in shape but many of your traits remind of the solid stone. You have dark brown skin the color of stone and fertile earth while your "+Hair.getHairLength(player)+" polished stone, golem like, straight hair are decorated with a single budding vine. ");
				outputText("Your eyes are the color of emerald and verdant greenery, brimming with life while your calm serene expression mirrors the stone near infinite patience but can abruptly turn to violent quaking anger when provoked.\n\n");
				outputText("Your arms are human-like in shape, at least up to your elbow. Past your elbows, your arms shift into something large, sturdy and golem-like, capable of crushing anything. Beneath your torso, your legs turn to solid rock, fully fusing with the ground beneath you. While anybody could assume you have no mobility, you can simply move by sliding across the solid ground as if you were merely swimming.");
			}
			else {
				outputText("You have currently fused with a wind elemental spirit, morphing your body and becoming a sylph. Your body is humanoid in shape but many of your traits remind of wind. You have light green skin and "+Hair.getHairLength(player)+", weightless flowing hair that swirls into a vortex above your head in flowing locks. ");
				outputText("Your eyes are the color of the orange twilight sky and your expression is playful and capricious but mostly free. The wind goes where it wants and does what it wants. You feel like you could do anything without barrier or restraint.\n\n");
				outputText("Your arms are human-like in shape, but are covered in tattoos, vaguely resembling swirling vortexes of wind. Silky smooth gloves cover your hands up to your shoulders. "+(player.gender == 1 ?"":" like cloth forming what would appear like a translucent skirt to the untrained eye")+". ");
				outputText(" Being air incarnate, you can float and fly at will anywhere. It’s as if you’re one with the air itself.");
			}
		}
		else {
			//Discuss race
			if (player.race() != player.startingRace) outputText("You began your journey as a " + player.startingRace + ", but gave that up as you explored the dangers of this realm. ");
			//Height and race.
			outputText("You are a ");
			outputText(Measurements.footInchOrMetres(player.tallness));
			var pcrace:String = player.race();
			var genderlessRace:Array = ["half cow-morph", "half cow-girl", "cow-girl", "cow-girl", "cow-morph", "minotaur", "half-minotaur", "alraune", "liliraune", "half unicorn", "unicorn", "unicornkin", "half alicorn", "alicorn", "alicornkin", "true alicorn", "half bicorn", "bicorn", "bicornkin", "half nightmare","nightmare", "nightmarekin", "true nightmare"];
			if (!(genderlessRace.indexOf(pcrace) >= 0))
			{
				outputText(" tall [malefemaleherm] [race], with [bodytype].");
			}
			else{
				outputText(" tall [race], with [bodytype].");
			}
		}
	}

	public function describeSkin(): String {
		return Skin.getSkinAppearanceDescription(player);
	}

	public function describeLowerBody(): String {

		var lowerBodyDesc: String = "";

		lowerBodyDesc += LowerBody.getAppearanceDescription(player);

		//Hip info only displays if you aren't a centaur.
		if (player.isBiped() || player.isNaga()) {
			trace ("Hips");
			trace (player.hips.type);
			trace ("Thickness");
			trace (player.thickness);
			if (player.thickness > 70) {
				lowerBodyDesc += " You have " + hipDescript();
				if (player.hips.type < 6) {
					if (player.tone < 65)
						lowerBodyDesc += " buried under a noticeable muffin-top, and";
					else lowerBodyDesc += " that blend into your pillar-like waist, and";
				}
				if (player.hips.type >= 6 && player.hips.type < 10)
					lowerBodyDesc += " that blend into the rest of your thick form, and";
				if (player.hips.type >= 10 && player.hips.type < 15)
					lowerBodyDesc += " that would be much more noticeable if you weren't so wide-bodied, and";
				if (player.hips.type >= 15 && player.hips.type < 20)
					lowerBodyDesc += " that sway and emphasize your thick, curvy shape, and";
				if (player.hips.type >= 20)
					lowerBodyDesc += " that sway hypnotically on your extra-curvy frame, and";
			} else if (player.thickness < 30) {
				lowerBodyDesc += " You have " + hipDescript();
				if (player.hips.type < 6)
					lowerBodyDesc += " that match your trim, lithe body, and";
				if (player.hips.type >= 6 && player.hips.type < 10)
					lowerBodyDesc += " that sway to and fro, emphasized by your trim body, and";
				if (player.hips.type >= 10 && player.hips.type < 15)
					lowerBodyDesc += " that swell out under your trim waistline, and";
				if (player.hips.type >= 15 && player.hips.type < 20)
					lowerBodyDesc += ", emphasized by your narrow waist, and";
				if (player.hips.type >= 20)
					lowerBodyDesc += " that swell disproportionately wide on your lithe frame, and";
			}
			//STANDARD
			else {
				lowerBodyDesc += " You have " + hipDescript();
				if (player.hips.type < 6)
					lowerBodyDesc += ", and";
				if (player.femininity > 50) {
					if (player.hips.type >= 6 && player.hips.type < 10)
						lowerBodyDesc += " that draw the attention of those around you, and";
					if (player.hips.type >= 10 && player.hips.type < 15)
						lowerBodyDesc += " that make you walk with a sexy, swinging gait, and";
					if (player.hips.type >= 15 && player.hips.type < 20)
						lowerBodyDesc += " that make it look like you've birthed many children, and";
					if (player.hips.type >= 20)
						lowerBodyDesc += " that make you look more like an animal waiting to be bred than any kind of human, and";
				}	else {
					if (player.hips.type >= 6 && player.hips.type < 10)
						lowerBodyDesc += " that give you a graceful stride, and";
					if (player.hips.type >= 10 && player.hips.type < 15)
						lowerBodyDesc += " that add a little feminine swing to your gait, and";
					if (player.hips.type >= 15 && player.hips.type < 20)
						lowerBodyDesc += " that force you to sway and wiggle as you move, and";
					if (player.hips.type >= 20) {
						lowerBodyDesc += " that give your ";
						if (player.balls > 0)
							lowerBodyDesc += "balls plenty of room to breathe";
						else if (player.hasCock())
							lowerBodyDesc += player.multiCockDescript() + " plenty of room to swing";
						else if (player.hasVagina())
							lowerBodyDesc += vaginaDescript() + " a nice, wide berth";
						else lowerBodyDesc += "vacant groin plenty of room";
						lowerBodyDesc += ", and";
					}
				}
			}
		}
		//ASS
		//Horse version
		if (player.isTaur()) {
			//FATBUTT
			if (player.tone < 65) {
				lowerBodyDesc += " Your " + buttDescript();
				if (player.butt.type < 4)
					lowerBodyDesc += " is lean, from what you can see of it.";
				if (player.butt.type >= 4 && player.butt.type < 6)
					lowerBodyDesc += " looks fairly average.";
				if (player.butt.type >= 6 && player.butt.type < 10)
					lowerBodyDesc += " is fairly plump and healthy.";
				if (player.butt.type >= 10 && player.butt.type < 15)
					lowerBodyDesc += " jiggles a bit as you trot around.";
				if (player.butt.type >= 15 && player.butt.type < 20)
					lowerBodyDesc += " jiggles and wobbles as you trot about.";
				if (player.butt.type >= 20)
					lowerBodyDesc += " is obscenely large, bordering freakish, even for a horse.";
			}
			//GIRL LOOK AT DAT BOOTY
			else {
				lowerBodyDesc += " Your " + buttDescript();
				if (player.butt.type < 4)
					lowerBodyDesc += " is barely noticeably, showing off the muscles of your haunches.";
				if (player.butt.type >= 4 && player.butt.type < 6)
					lowerBodyDesc += " matches your toned equine frame quite well.";
				if (player.butt.type >= 6 && player.butt.type < 10)
					lowerBodyDesc += " gives hints of just how much muscle you could put into a kick.";
				if (player.butt.type >= 10 && player.butt.type < 15)
					lowerBodyDesc += " surges with muscle whenever you trot about.";
				if (player.butt.type >= 15 && player.butt.type < 20)
					lowerBodyDesc += " flexes its considerable mass as you move.";
				if (player.butt.type >= 20)
					lowerBodyDesc += " is stacked with layers of muscle, huge even for a horse.";
			}
		}
		//Non-horse PCs
		else if (player.isBiped() || player.isNaga()) {
			//TUBBY ASS
			if (player.tone < 60) {
				lowerBodyDesc += " your " + buttDescript();
				if (player.butt.type < 4)
					lowerBodyDesc += " looks great under your gear.";
				if (player.butt.type >= 4 && player.butt.type < 6)
					lowerBodyDesc += " has the barest amount of sexy jiggle.";
				if (player.butt.type >= 6 && player.butt.type < 10)
					lowerBodyDesc += " fills out your clothing nicely.";
				if (player.butt.type >= 10 && player.butt.type < 15)
					lowerBodyDesc += " wobbles enticingly with every step.";
				if (player.butt.type >= 15 && player.butt.type < 20)
					lowerBodyDesc += " wobbles like a bowl full of jello as you walk.";
				if (player.butt.type >= 20)
					lowerBodyDesc += " is obscenely large, bordering freakish, and makes it difficult to run.";
			}
			//FITBUTT
			else {
				lowerBodyDesc += " your " + buttDescript();
				if (player.butt.type < 4)
					lowerBodyDesc += " molds closely against your form.";
				if (player.butt.type >= 4 && player.butt.type < 6)
					lowerBodyDesc += " contracts with every motion, displaying the detailed curves of its lean musculature.";
				if (player.butt.type >= 6 && player.butt.type < 10)
					lowerBodyDesc += " fills out your clothing nicely.";
				if (player.butt.type >= 10 && player.butt.type < 15)
					lowerBodyDesc += " stretches your gear, flexing it with each step.";
				if (player.butt.type >= 15 && player.butt.type < 20)
					lowerBodyDesc += " threatens to bust out from under your kit each time you clench it.";
				if (player.butt.type >= 20)
					lowerBodyDesc += " is marvelously large, but completely stacked with muscle.";
			}
		}

		return lowerBodyDesc;
	}

	public function describeTail(): String {
		return Tail.getAppearanceDescription(player);
	}

	public function describeArms(): String {
		return Arms.getAppearanceDescription(player);
	}

	public function describeRearBody(): String {
		return RearBody.getAppearanceDescription(player);
	}

	public function describeWings(): String {
		return Wings.getAppearanceDescription(player);
	}

	public function describeHorns(): String {
		return Horns.getAppearanceDescription(player);
	}

	public function describeAntennae(): String {
		return Antennae.getAppearanceDescription(player);
	}

	public function describeGills(): String {
		return Gills.getAppearanceDescription(player);
	}

	public function describeTongue(): String {
		return Tongue.getAppearanceDescription(player);
	}

	public function describeBeard(): String {
		var beardDesc: String = "";

		//Beards!
		if (player.beardLength > 0) {
			beardDesc += "You have a " + beardDescript() + " ";
			if (player.beardStyle != Beard.GOATEE) {
				beardDesc += "covering your ";
				if (rand(2) == 0) beardDesc += "jaw";
				else outputText("chin and cheeks")
			} else {
				beardDesc += "protruding from your chin";
			}
			beardDesc += ".";
		}

		return beardDesc;
	}

	public function describeEyes(): String {
		return Eyes.getAppearanceDescription(player);
	}

	public function describeHair(): String {
		if (player.hairLength > 0) {
			return Hair.getAppearanceDescription(player);
		} else {
			if(player.skinType == Skin.FUR) {
				return "You have no hair, only a thin layer of fur atop of your head.";
			} else {
				return "You are completely bald, displaying [skintone] [skin.type] where your hair would otherwise be.";
			}
		}
	}

	public function describeEars(): String {
		return Ears.getAppearanceDescription(player);
	}

	public function describeSpecialCases(): String {
		var specialCasesDesc: String = "";

		if (player.hasStatusEffect(StatusEffects.GooStuffed)) {
			specialCasesDesc += "[pg]<b>Your gravid-looking belly is absolutely stuffed full of goo. There's no way you can get pregnant like this, but at the same time, you look like some fat-bellied breeder.</b>[pg]";
		}

		return specialCasesDesc;
	}

	public function describePregnancy(): String {
		var temp:Number = 0;
		var rando:Number = 0;
		var pregnancyDesc: String = "";

		if((player.buttPregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL) || (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR) || player.isPregnant()) {
			if (player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) {
				pregnancyDesc += "<b>";
				//Compute size
				temp = player.statusEffectv3(StatusEffects.Eggs) + player.statusEffectv2(StatusEffects.Eggs) * 10;
				if(player.pregnancyIncubation <= 50 && player.pregnancyIncubation > 20) {
					pregnancyDesc += "Your swollen pregnant belly is as large as a ";
					if(temp < 10)
						pregnancyDesc += "basketball.";
					if(temp >= 10 && temp < 20)
						pregnancyDesc += "watermelon.";
					if(temp >= 20)
						pregnancyDesc += "beach ball.";
				}
				if(player.pregnancyIncubation <= 20) {
					pregnancyDesc += "Your swollen pregnant belly is as large as a ";
					if(temp < 10)
						pregnancyDesc += "watermelon.";
					if(temp >= 10 && temp < 20)
						pregnancyDesc += "beach ball.";
					if(temp >= 20)
						pregnancyDesc += "large medicine ball.";
				}
				pregnancyDesc += "</b>";
				temp = 0;
			}
			//Satur preggos - only shows if bigger than regular pregnancy or not pregnancy
			else if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR && player.buttPregnancyIncubation > player.pregnancyIncubation) {
				if(player.buttPregnancyIncubation < 125 && player.buttPregnancyIncubation >= 75) {
					pregnancyDesc += "<b>You've got the beginnings of a small pot-belly.</b>";
				}
				else if(player.buttPregnancyIncubation >= 50) {
					pregnancyDesc += "<b>The unmistakable bulge of pregnancy is visible in your tummy, yet it feels odd inside you - wrong somehow.</b>";
				}
				else if(player.buttPregnancyIncubation >= 30) {
					pregnancyDesc += "<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>";
				} else { //Surely Benoit and Cotton deserve their place in this list
					if (player.pregnancyType == PregnancyStore.PREGNANCY_IZMA || player.pregnancyType == PregnancyStore.PREGNANCY_MOUSE || player.pregnancyType == PregnancyStore.PREGNANCY_AMILY || (player.pregnancyType == PregnancyStore.PREGNANCY_JOJO && (JojoScene.monk <= 0 || flags[kFLAGS.JOJO_BIMBO_STATE] == 3)) || player.pregnancyType == PregnancyStore.PREGNANCY_EMBER || player.pregnancyType == PregnancyStore.PREGNANCY_BENOIT || player.pregnancyType == PregnancyStore.PREGNANCY_COTTON
					|| player.pregnancyType == PregnancyStore.PREGNANCY_URTA || player.pregnancyType == PregnancyStore.PREGNANCY_BEHEMOTH || player.pregnancyType == PregnancyStore.PREGNANCY_ZENJI)
						pregnancyDesc += "<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>";
					else if(player.pregnancyType != PregnancyStore.PREGNANCY_MARBLE)
						pregnancyDesc += "<b>Your belly protrudes unnaturally far forward, bulging with the unclean spawn of some monster or beast.</b>";
					else pregnancyDesc += "<b>Your belly protrudes unnaturally far forward, bulging outwards with Marble's precious child.</b>";
				}
			}
			//URTA PREG
			else if (player.pregnancyType == PregnancyStore.PREGNANCY_URTA) {
				if(player.pregnancyIncubation <= 432 && player.pregnancyIncubation > 360) {
					pregnancyDesc += "<b>Your belly is larger than it used to be.</b>\n";
				}
				if(player.pregnancyIncubation <= 360 && player.pregnancyIncubation > 288) {
					pregnancyDesc += "<b>Your belly is more noticeably distended. You're pretty sure it's Urta's.</b>";
				}
				if(player.pregnancyIncubation <= 288 && player.pregnancyIncubation > 216) {
					pregnancyDesc += "<b>The unmistakable bulge of pregnancy is visible in your tummy, and the baby within is kicking nowadays.</b>";
				}
				if(player.pregnancyIncubation <= 216 && player.pregnancyIncubation > 144) {
					pregnancyDesc += "<b>Your belly is large and very obviously pregnant to anyone who looks at you. It's gotten heavy enough to be a pain to carry around all the time.</b>";
				}
				if(player.pregnancyIncubation <= 144 && player.pregnancyIncubation > 72) {
					pregnancyDesc += "<b>It would be impossible to conceal your growing pregnancy from anyone who glanced your way. It's large and round, frequently moving.</b>";
				}
				if(player.pregnancyIncubation <= 72 && player.pregnancyIncubation > 48) {
					pregnancyDesc += "<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>";
				}
				if(player.pregnancyIncubation <= 48) {
					pregnancyDesc += "<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>";
				}
			} else if (player.buttPregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL) {
				if(player.buttPregnancyIncubation >= 8)
					pregnancyDesc += "<b>Your stomach is so full of frog eggs that you look about to birth at any moment, your belly wobbling and shaking with every step you take, packed with frog ovum.</b>";
				else pregnancyDesc += "<b>You're stuffed so full with eggs that your belly looks obscenely distended, huge and weighted with the gargantuan eggs crowding your gut. They make your gait a waddle and your gravid tummy wobble obscenely.</b>";
			} else if (player.pregnancyType == PregnancyStore.PREGNANCY_FAERIE) { //Belly size remains constant throughout the pregnancy
				pregnancyDesc += "<b>Your belly remains swollen like a watermelon. ";
				if (player.pregnancyIncubation <= 100)
					pregnancyDesc += "It's full of liquid, though unlike a normal pregnancy the passenger you’re carrying is tiny.</b>";
				else if (player.pregnancyIncubation <= 140)
					pregnancyDesc += "It feels like it’s full of thick syrup or jelly.</b>";
				else pregnancyDesc += "It still feels like there’s a solid ball inside your womb.</b>";
			} else {
				if(player.pregnancyIncubation <= 336 && player.pregnancyIncubation > 280) {
					pregnancyDesc += "<b>Your belly is larger than it used to be.</b>";
				}
				if(player.pregnancyIncubation <= 280 && player.pregnancyIncubation > 216) {
					pregnancyDesc += "<b>Your belly is more noticeably distended. You are probably pregnant.</b>";
				}
				if(player.pregnancyIncubation <= 216 && player.pregnancyIncubation > 180) {
					pregnancyDesc += "<b>The unmistakable bulge of pregnancy is visible in your tummy.</b>";
				}
				if(player.pregnancyIncubation <= 180 && player.pregnancyIncubation > 120) {
					pregnancyDesc += "<b>Your belly is very obviously pregnant to anyone who looks at you.</b>";
				}
				if(player.pregnancyIncubation <= 120 && player.pregnancyIncubation > 72) {
					pregnancyDesc += "<b>It would be impossible to conceal your growing pregnancy from anyone who glanced your way.</b>";
				}
				if(player.pregnancyIncubation <= 72 && player.pregnancyIncubation > 48) {
					pregnancyDesc += "<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>";
				}
				if (player.pregnancyIncubation <= 48) { //Surely Benoit and Cotton deserve their place in this list
					if (player.pregnancyType == PregnancyStore.PREGNANCY_IZMA || player.pregnancyType == PregnancyStore.PREGNANCY_MOUSE || player.pregnancyType == PregnancyStore.PREGNANCY_AMILY || (player.pregnancyType == PregnancyStore.PREGNANCY_JOJO && JojoScene.monk <= 0) || player.pregnancyType == PregnancyStore.PREGNANCY_EMBER || player.pregnancyType == PregnancyStore.PREGNANCY_BENOIT || player.pregnancyType == PregnancyStore.PREGNANCY_COTTON
					|| player.pregnancyType == PregnancyStore.PREGNANCY_URTA || player.pregnancyType == PregnancyStore.PREGNANCY_MINERVA || player.pregnancyType == PregnancyStore.PREGNANCY_BEHEMOTH || player.pregnancyType == PregnancyStore.PREGNANCY_ZENJI)
						pregnancyDesc += "<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>";
					else if (player.pregnancyType != PregnancyStore.PREGNANCY_MARBLE)
						pregnancyDesc += "<b>Your belly protrudes unnaturally far forward, bulging with the unclean spawn of some monster or beast.</b>";
					else pregnancyDesc += "<b>Your belly protrudes unnaturally far forward, bulging outwards with Marble's precious child.</b>";
				}
			}
		}

		return pregnancyDesc;
	}

	public function describeBreasts(): String {
		var temp:Number = 0;
		var rando:Number = 0;
		var breastsDesc: String = "";

		if(player.breastRows.length == 1) {
			breastsDesc += "You have " + num2Text(player.breastRows[temp].breasts) + (player.breastRows[0].breastRating >= 1 ? " " + player.breastCup(temp) : "") + " breasts, each supporting ";
			breastsDesc += num2Text(player.breastRows[temp].nipplesPerBreast) + " "; //Number of nipples.
			breastsDesc += Measurements.shortSuffix(int(player.nippleLength *10)/10)+" ";
			//if (flags[kFLAGS.USE_METRICS] > 0 ) breastsDesc += int(player.nippleLength * 2.54 * 10) / 10 + "-cm "; //Centimeter display
			//else breastsDesc += int(player.nippleLength * 10) / 10 + "-inch "; //Inches display
			breastsDesc += nippleDescript(temp) + (player.breastRows[0].nipplesPerBreast == 1 ? "" : "s"); //Nipple description and plural
			if(player.breastRows[0].milkFullness > 75)
				breastsDesc += "; that said, your " + breastDescript(temp) + " are painful and sensitive from being so stuffed with milk, so you should probably release some pressure soon";
			breastsDesc += ".";

		} else {
			breastsDesc += "You have " + num2Text(player.breastRows.length) + " rows of breasts, the topmost pair starting at your chest.";
			while (temp < player.breastRows.length) {
				if(temp == 0)
					breastsDesc += "\n--Your uppermost rack houses ";
				if(temp == 1)
					breastsDesc += "\n--The second row holds ";
				if(temp == 2)
					breastsDesc += "\n--Your third row of breasts contains ";
				if(temp == 3)
					breastsDesc += "\n--Your fourth set of tits cradles ";
				if(temp == 4)
					breastsDesc += "\n--Your fifth and final mammary grouping swells with ";
				breastsDesc += num2Text(player.breastRows[temp].breasts) + " " + breastDescript(temp) + " with ";
				breastsDesc += num2Text(player.breastRows[temp].nipplesPerBreast) + " "; //Number of nipples per breast
				breastsDesc += Measurements.shortSuffix(int(player.nippleLength*10)/10);
				//if (flags[kFLAGS.USE_METRICS] > 0 ) breastsDesc += int(player.nippleLength * 2.54 * 10) / 10 + "-cm "; //Centimeter
				//else breastsDesc += int(player.nippleLength * 10) / 10 + "-inch "; //Inches
				breastsDesc += " " + nippleDescript(temp) + (player.breastRows[0].nipplesPerBreast == 1 ? " each." : "s each."); //Description and Plural
				if(player.breastRows[temp].breastRating >= 1)
					breastsDesc += " They could easily fill a " + player.breastCup(temp) + " bra.";
				if(player.breastRows[temp].milkFullness > 75)
					breastsDesc += " Your " + breastDescript(temp) + " are painful and sensitive from being so stuffed with milk. You should release the pressure soon.";
				temp++;
			}
		}
		return breastsDesc;
	}

	public function describeCrotch(): String {
		return LowerBody.getCrotchDescription(player);
	}

	public function describeCock(): String {
		var temp:Number = 0;
		var rando:Number = 0;
		var cockDesc: String = "";

		if (player.hasCock()) {
			rando = rand(100);
			if (player.isTaur() && player.cocks.length == 1)
			cockDesc += "Your equipment has shifted to lie between your hind legs, like a feral animal.";
			else if (player.isTaur())
			cockDesc += "Between your hind legs, you have grown " + player.multiCockDescript() + "!";
			else if ((player.isScylla() || player.isKraken()) && player.cocks.length == 1)
			cockDesc += "Your equipment has shifted to lie between your front tentacles.";
			else if (player.isScylla() || player.isKraken())
			cockDesc += "Between front tentacles of your bestial body you have grown " + player.multiCockDescript() + "!";
			else if (player.isAlraune())
			cockDesc += "Your equipment has shifted to lie below your pitcher now in the form of a mass of tentacle vine.";
			else if (player.cocks.length == 1)
			cockDesc += "";
			else
			cockDesc += "Where a penis would normally be located, you have instead grown " + player.multiCockDescript() + "!";
			for (var cock_index:int = 0; cock_index < player.cocks.length; cock_index++) {
				rando++;
				// How to start the sentence?
				if (player.cocks.length == 1) cockDesc += "Your ";
				else if (cock_index == 0) cockDesc += "--Your first ";
				else if (rando % 5 == 0) cockDesc += "\n--The next ";
				else if (rando % 5 == 1) cockDesc += "\n--The " + num2Text2(cock_index+1) + " of your ";
				else if (rando % 5 == 2) cockDesc += "\n--One of your ";
				else if (rando % 5 == 3) cockDesc += "\n--The " + num2Text2(cock_index+1) + " ";
				else if (rando % 5 == 4) cockDesc += "\n--Another of your ";
				// How large?
				cockDesc += player.cockDescript(cock_index) + ((rando % 5) % 3 == 0 || cock_index == 0 ? "":"s") + " is " + inchesOrCentimetres(player.cocks[cock_index].cockLength) + " long and ";
				cockDesc += inchesOrCentimetres(player.cocks[cock_index].cockThickness);
				if (rando % 3 == 0) cockDesc += " wide.";
				else if (rando % 3 == 1) cockDesc += " thick.";
				else if (rando % 3 == 2) cockDesc += " in diameter.";
				// What flavor of cock do you have?
				switch (player.cocks[cock_index].cockType) {
					case CockTypesEnum.HORSE: cockDesc += " It's mottled black and brown in a very animalistic pattern. The 'head' of its shaft flares proudly, just like a horse's."; break;
					case CockTypesEnum.DOG: cockDesc += " It is shiny, pointed, and covered in veins, just like a large dog's cock."; break;
					case CockTypesEnum.WOLF: cockDesc += " It is shiny red, pointed, and covered in veins, just like a large wolf's cock."; break;
					case CockTypesEnum.FOX: cockDesc += " It is shiny, pointed, and covered in veins, just like a large fox's cock."; break;
					case CockTypesEnum.DEMON: cockDesc += " The crown is ringed with a circle of rubbery protrusions that grow larger as you get more aroused. The entire thing is shiny and covered with tiny, sensitive nodules that leave no doubt about its demonic origins."; break;
					case CockTypesEnum.TENTACLE: cockDesc += " The entirety of its green surface is covered in perspiring beads of slick moisture. It frequently shifts and moves of its own volition, the slightly oversized and mushroom-like head shifting in coloration to purplish-red whenever you become aroused."; break;
					case CockTypesEnum.STAMEN: cockDesc += " It is dark green, tampered, and crowned by several colorful balls near the tip that secrete pollen when aroused."; break;
					case CockTypesEnum.CAT: cockDesc += " It ends in a single point, much like a spike, and is covered in small, fleshy barbs. The barbs are larger at the base and shrink in size as they get closer to the tip. Each of the spines is soft and flexible, and shouldn't be painful for any of your partners."; break;
					case CockTypesEnum.LIZARD: cockDesc += " It's a deep, iridescent purple in color. Unlike a human penis, the shaft is not smooth, and is instead patterned with multiple bulbous bumps."; break;
					case CockTypesEnum.CAVE_WYRM: cockDesc += " It's a deep, glowing neon blue in color. Unlike a human penis, the shaft is not smooth, and is instead patterned with multiple bulbous bumps. It also regularly drips the acidic substance that serves as your cum. In the event you need to fertilise more fragile partner you can slightly alter the composition of your cum to prevent disolving their flesh."; break;
					case CockTypesEnum.CANCER: 	 cockDesc += " It constantly drips and produce bubbles."; break;
					case CockTypesEnum.ANEMONE: cockDesc += " The crown is surrounded by tiny tentacles with a venomous, aphrodisiac payload. At its base a number of similar, longer tentacles have formed, guaranteeing that pleasure will be forced upon your partners."; break;
					case CockTypesEnum.KANGAROO: cockDesc += " It usually lies coiled inside a sheath, but undulates gently and tapers to a point when erect, somewhat like a taproot."; break;
					case CockTypesEnum.DRAGON: cockDesc += " With its tapered tip, there are few holes you wouldn't be able to get into. It has a strange, knot-like bulb at its base, but doesn't usually flare during arousal as a dog's knot would."; break;
					case CockTypesEnum.BEE: cockDesc += " It's a long, smooth black shaft that's rigid to the touch. Its base is ringed with a layer of " + shortSuffix(4) + " long soft bee hair. The tip has a much finer layer of short yellow hairs. The tip is very sensitive, and it hurts constantly if you don’t have bee honey on it."; break;
					case CockTypesEnum.PIG: cockDesc += " It's bright pinkish red, ending in a prominent corkscrew shape at the tip."; break;
					case CockTypesEnum.AVIAN: cockDesc += " It's a red, tapered cock that ends in a tip. It rests nicely in a sheath."; break;
					case CockTypesEnum.RHINO: cockDesc += " It's a smooth, tough pink colored and takes on a long and narrow shape with an oval shaped bulge along the center."; break;
					case CockTypesEnum.ECHIDNA: cockDesc += " It is quite a sight to behold, coming well-equipped with four heads."; break;
					case CockTypesEnum.RED_PANDA: cockDesc += " It lies protected in a soft, fuzzy sheath."; break;
					case CockTypesEnum.OOMUKADE: cockDesc += " It constantly drips with venom."; break;
					case CockTypesEnum.USHI_ONI: cockDesc += " It's starfish tipped shaft."; break;
					case CockTypesEnum.MINDBREAKER: cockDesc += " Hidden in a slit along with the rest of your male equipment, it constantly fills with your thick green slimy cum, to the point that your cum constantly leaks out of your genital slit, leaving a sticky trail of green \"slime\" in your wake."; break;
					default: //Nothing here, move along!
				}
				// Knot?
				if (player.cocks[cock_index].knotMultiplier > 1) {
					if (player.cocks[cock_index].knotMultiplier >= 1.8)
						cockDesc += " The obscenely swollen lump of flesh near the base of your " + player.cockDescript(cock_index) + " looks almost comically mismatched for your cock.";
					else if (player.cocks[cock_index].knotMultiplier >= 1.4)
						cockDesc += " A large bulge of flesh nestles just above the bottom of your " + player.cockDescript(cock_index) + ", to ensure it stays where it belongs during mating.";
					else // knotMultiplier < 1.4
						cockDesc += " A small knot of thicker flesh is near the base of your " + player.cockDescript(cock_index) + ", ready to expand to help you lodge it inside a female.";
					cockDesc += " The knot is " + inchesOrCentimetres(player.cocks[cock_index].cockThickness * player.cocks[cock_index].knotMultiplier) + " thick when at full size.";
				}
				// Sock Flavor
				if (player.cocks[cock_index].sock != "" && player.cocks[cock_index].sock != null){
					// I dunno what was happening, but it looks like .sock is null, as it doesn't exist. I guess this is probably more left over from some of the restucturing.
					// Anyways, check against null values, and stuff works again.
					//trace("Found a sock description (WTF even is a sock?)", player.cocks[cock_index].sock);
					cockDesc += sockDescript(cock_index);
				}
			}
			//Worm flavor
			if (player.hasStatusEffect(StatusEffects.Infested)) cockDesc += " Every now and again slimy worms coated in spunk slip partway out of your " + player.multiCockDescriptLight() + ", tasting the air like tongues of snakes";
		}

		return cockDesc;
	}

	public function describeBalls(): String {
		var ballsDesc: String = "\n";

		const ballsSizeDesc: String = " about " + num2Text(Math.round(player.ballSize)) + " " + (Math.round(player.ballSize) == 1 ? "inch" : "inches") +" across"

		if(player.balls > 0) {
			if(player.hasStatusEffect(StatusEffects.Uniball)) {
				if(player.skinType != Skin.GOO) ballsDesc += "Your [sack] clings tightly to your groin, holding [balls]," + ballsSizeDesc + ", snugly against you.";
				else if(player.skinType == Skin.GOO) ballsDesc += "Your [sack] clings tightly to your groin, dripping and holding [balls]," + ballsSizeDesc + ", snugly against you.";
			} else {
				var swingsWhere:String;
				if (player.cockTotal() == 0) swingsWhere = " where a penis would normally grow.";
				else swingsWhere = " under your [cocks].";

				if (player.hasFur()) ballsDesc += "A fuzzy [sack] filled with [ballsarticle]," + ballsSizeDesc + " each, swings low" + swingsWhere;
				else if (player.hasCoatOfType(Skin.CHITIN)) ballsDesc += "A chitin [sack] hugs your [balls]," + ballsSizeDesc + " each, tightly against your body.";
				else if (player.hasScales()) ballsDesc += "A scaly [sack] hugs your [balls]," + ballsSizeDesc + " each, tightly against your body.";
				else if (player.skinType == Skin.STONE) ballsDesc += "A stone-solid sack with [ballsarticle]," + ballsSizeDesc + " each, swings heavily" + swingsWhere;
				else if (player.skinType == Skin.GOO) ballsDesc += "An oozing, semi-solid sack with [ballsarticle]," + ballsSizeDesc + " each, swings heavily" + swingsWhere;
				else ballsDesc += "A [sack] with [ballsarticle]," + ballsSizeDesc + " each, swings heavily" + swingsWhere;
			}

			// ballsDesc += " You estimate each of them to be about " + num2Text(Math.round(player.ballSize)) + " ";
			// if(Math.round(player.ballSize) == 1)
			// ballsDesc += "inch";
			// else ballsDesc += "inches";
			// ballsDesc += " across.";

			//Worms extra descript. To match as seen in infested hellhounds.
			if (player.hasStatusEffect(StatusEffects.Infested) && player.statusEffectv1(StatusEffects.Infested) == 5) ballsDesc += " Across its surface, random lumps move rapidly around, further proof of your infested sack, and it's parasitic inhabitants that both boost and increase your cum production.";
		} else {
			if (player.hasStatusEffect(StatusEffects.Infested) && player.statusEffectv1(StatusEffects.Infested) == 5) ballsDesc += "Deep within your prostate you feel the worms moving, constantly rubbing against your trigger button, keeping you aroused and constantly churning up cum to be spewed out at a moment's notice.";
		}

		return ballsDesc;
	}

	public function describePussy(): String {
		var pussyDesc: String = "";

		if (player.vaginas.length > 0){
			var vagLoop:int = 0
			var clitExists:int = 0
			if((player.gender == 2 || player.gender == 3) && player.isTaur() && !player.isScylla())
			pussyDesc += "Your womanly parts have shifted to lie between your hind legs, in a rather feral fashion.";
			if((player.gender == 2 || player.gender == 3) && (player.isScylla() || player.isKraken()))
			pussyDesc += "Your womanly parts have shifted to lie underneath your tentacle legs.";
			if (player.vaginas.length == 1){
				if (player.lowerBody == LowerBody.MELKIE){
					pussyDesc += "You have a set of vaginal lips, "; //one twice as big as the other and hiding the smaller within its folds. Behind your first set of lips, you have a " + vaginaDescript(0) + ", with a " + Measurements.shortSuffix(int(player.clitLength*10)/10) + " clit";
				} else {
					pussyDesc += "Your " + vaginaDescript(0);
				}
			} else {
				if (player.lowerBody == LowerBody.MELKIE){
					pussyDesc += "You have two sets of vaginal lips, the first set"; //set in pairs, one twice as big as the other and hiding the smaller within its folds. Behind your first set of lips, you have a " + vaginaDescript(0) + ", with a " + Measurements.shortSuffix(int(player.clitLength*10)/10) + " clit, and behind your second set of lips, you have a " + vaginaDescript(1) + ", with a " + Measurements.shortSuffix(int(player.clitLength*10)/10) + " clit";
				} else {
					pussyDesc += "Your first " + vaginaDescript(0);
				}
			}
			for(var i:int=0; i<player.vaginas.length; i++){
				var vagType:int = player.vaginaType(-1, i) //It's not iterating properly to register the second pussy.
				switch(vagType){ //missing black sand trap, maybe melkie.
					case VaginaClass.EQUINE:
						pussyDesc += " is deep and wide just like that of a horse. Sometime you lament that most of your partners are no longer big enough to satisfy you. Inside you have a ";
						break;
					case VaginaClass.CANCER:
						pussyDesc += " is constantly foaming, in anticipation for a potential mate. Hidden within is a ";
						break;
					case VaginaClass.SCYLLA:
						pussyDesc += " has no clit. Instead, several concentric rings of small nubs line up the walls of your gaping maw of a vagina, each easily as sensitive as a human clitoris would be.";
						clitExists++
						break;
					case LowerBody.MELKIE:
						pussyDesc += " set is twice as big as the other, and the other hidden within its folds. Your outer lips hide a";
						break;
					case VaginaClass.MANTICORE:
						pussyDesc += " is ultrasensitive, even the slightest touch is enough to make you moan out a melody. Your song-box hides a ";
						break;
					case VaginaClass.CAVE_WYRM:
						pussyDesc += " constantly drools acid, small puffs of dissolving matter wafting up from beneath where you're standing. Your dissolving chamber hides a ";
						break;
					case VaginaClass.VENOM_DRIPPING:
						pussyDesc += " constantly drools an aphrodisiac venom, forcing any potential mates to be ready regardless of their physical state. Your lust-enhancers hides a ";
						break;
					case VaginaClass.ALRAUNE:
						pussyDesc += " constantly secretes aphrodisiac-like nectar, ensuring any stamen that parts your petals are sufficiently lubricated and ready to fertilize you. Your flower hides a ";
						break;
					case VaginaClass.DEMONIC:
						pussyDesc += ", unlike a normal pussy, feels and acts akin to a mouth that allows you to taste and savor the flavor of the cum injected within as if it landed on your tongue. Its sensitive walls are also prehensile, and you can control them to milk a cock just as well as your hand could. Your dexterous, cum-hungry twat hides a ";
						break;
					case VaginaClass.NAGA:
						pussyDesc += " is deep and wide enough to insert your entire arm length inside and some more. Sometimes you lament that most of your partners are no longer big enough to satisfy you";
						if (player.isNaga()) pussyDesc += "as your hot spot is now way further inside your deep canal, requiring quite a longer member to reach";
								pussyDesc += ". Inside you have a ";
						break;
					case VaginaClass.MINDBREAKER:
						pussyDesc += " constantly drools green slime, ensuring any cock that parts your infested cunt are sufficiently lubricated and ready to impregnate you. Your eldritch lips hides a ";
						break;
					case VaginaClass.SHARK:
						pussyDesc += " looks human on the outside but its depths are filled with small sensitive tendril-like feelers that wrap around and swiftly help massage just any cocks to climax. Inside you have a ";
						break;
					case VaginaClass.RAIJU:
						pussyDesc += " constantly drools plasma, small puffs of electrified matter wafting up from beneath where you're standing. Your static chamber hides a ";
						break;
					default:
						pussyDesc += " hides a ";
						break;
				}
				//Clit check. Only for Scylla for now.
				if (clitExists == 0) pussyDesc += Measurements.shortSuffix(int(player.clitLength * 10) / 10) + " clit";
				//Hymen check.
				if(player.vaginas[i].virgin) {
					pussyDesc += ". Its hymen is intact. ";
				} else{
					pussyDesc += ". ";
				}
				//Wetness check.
				if(player.lib < 50 && player.lust < 50) { //not particularly horny
					//Wetness
					if(player.vaginas[i].vaginalWetness >= VaginaClass.WETNESS_WET && player.vaginas[i].vaginalWetness< VaginaClass.WETNESS_DROOLING)
						pussyDesc += "Moisture gleams in ";
					if(player.vaginas[i].vaginalWetness>= VaginaClass.WETNESS_DROOLING) {
						pussyDesc += "Occasional beads of ";
						pussyDesc += "lubricant drip from ";
					}
					//Different description based on vag looseness
					if(player.vaginas[i].vaginalWetness>= VaginaClass.WETNESS_WET) {
						if(player.vaginas[i].vaginalLooseness< VaginaClass.LOOSENESS_LOOSE)
							pussyDesc += "your " + vaginaDescript(i) + ".";
						if(player.vaginas[i].vaginalLooseness>= VaginaClass.LOOSENESS_LOOSE && player.vaginas[i].vaginalLooseness< VaginaClass.LOOSENESS_GAPING_WIDE)
							pussyDesc += "your " + vaginaDescript(i) + ", its lips slightly parted.";
						if(player.vaginas[i].vaginalLooseness>= VaginaClass.LOOSENESS_GAPING_WIDE)
							pussyDesc += "the massive hole that is your " + vaginaDescript(0) + ".";
					}
				} else if((player.lib>=50 || player.lust >=50) && (player.lib< 80 && player.lust < 80)) { //kinda horny
					//Wetness
					if(player.vaginas[i].vaginalWetness< VaginaClass.WETNESS_WET)
						pussyDesc += "Moisture gleams in ";
					if(player.vaginas[i].vaginalWetness>= VaginaClass.WETNESS_WET && player.vaginas[i].vaginalWetness< VaginaClass.WETNESS_DROOLING) {
						pussyDesc += "Occasional beads of ";
						pussyDesc += "lubricant drip from ";
					}
					if(player.vaginas[i].vaginalWetness>= VaginaClass.WETNESS_DROOLING) {
						pussyDesc += "Thin streams of ";
						pussyDesc += "lubricant occasionally dribble from ";
					}
					//Different description based on vag looseness
					if(player.vaginas[i].vaginalLooseness< VaginaClass.LOOSENESS_LOOSE)
						pussyDesc += "your " + vaginaDescript(i) + ".";
					if(player.vaginas[i].vaginalLooseness>= VaginaClass.LOOSENESS_LOOSE && player.vaginas[i].vaginalLooseness< VaginaClass.LOOSENESS_GAPING_WIDE)
						pussyDesc += "your " + vaginaDescript(i) + ", its lips slightly parted.";
					if(player.vaginas[i].vaginalLooseness>= VaginaClass.LOOSENESS_GAPING_WIDE)
						pussyDesc += "the massive hole that is your " + vaginaDescript(0) + ".";
				} else if((player.lib> 80 || player.lust > 80)) { //WTF horny!
					//Wetness
					if(player.vaginas[i].vaginalWetness< VaginaClass.WETNESS_WET) {
						pussyDesc += "Occasional beads of ";
						pussyDesc += "lubricant drip from ";
					}
					if(player.vaginas[i].vaginalWetness>= VaginaClass.WETNESS_WET && player.vaginas[i].vaginalWetness< VaginaClass.WETNESS_DROOLING) {
						pussyDesc += "Thin streams of ";
						pussyDesc += "lubricant occasionally dribble from ";
					}
					if(player.vaginas[i].vaginalWetness>= VaginaClass.WETNESS_DROOLING) {
						pussyDesc += "Thick streams of ";
						pussyDesc += "lubricant drool constantly from ";
					}
					//Different description based on vag looseness
					if(player.vaginas[i].vaginalLooseness< VaginaClass.LOOSENESS_LOOSE)
						pussyDesc += "your " + vaginaDescript(i) + ".";
					if(player.vaginas[i].vaginalLooseness>= VaginaClass.LOOSENESS_LOOSE && player.vaginas[i].vaginalLooseness< VaginaClass.LOOSENESS_GAPING_WIDE)
						pussyDesc += "your " + vaginaDescript(i) + ", its lips slightly parted.";
					if(player.vaginas[i].vaginalLooseness>= VaginaClass.LOOSENESS_GAPING_WIDE)
						pussyDesc += "the massive hole that is your cunt.";
				}

				if (player.vaginas.length > 1 && vagLoop == 0){
					pussyDesc += "[pg]Your second " + vaginaDescript(1)+ " ";
					vagLoop++
					clitExists = 0
				}
			}
		}

		return pussyDesc;
	}

	public function describeAsshole(): String {
		return player.ass ? "You have one " + assholeDescript() + ", placed between your butt-cheeks where it belongs." : "";
	}

	public function describeSkinPattern(): String {
		return Skin.getSkinPatternAppearanceDescription(player);
	}

	public function describeFace(): String {
		return Face.getAppearanceDescription(player);
	}

	public function RacialScores():void {
		var score:int;
		var tempStr:int;
		var tempSpd:int;
		var tempInt:int;
		var tempTou:int;
		var tempWis:int;
		var tempLib:int;
		var tempMDmg:int;
		var tempSDmg:int;
		var tempRDmg:int;
		var tempUDmg:int;
		var tempSF:int;
		var tempHP:int;
		var tempMana:int;
		var tempWrath:int;
		var tempDRes:int;
		var tempSen:int;
		var tempFat:int;
		var tempDarkDmg:int;
		var tempIceDmg:int;
		var tempLtngDmg:int;
		var tempFireDmg:int;
		
		clearOutput();
		outputText("<b>Current racial scores (and bonuses to stats if applicable):</b>\n");
		//Druid fusions
		if (player.hasPerk(PerkLib.ElementalBody)) {
			if (player.perkv1(PerkLib.ElementalBody) == 1) {
				if (player.perkv2(PerkLib.ElementalBody) == 1) outputText("\n<font color=\"#0000a0\">Lesser Sylph: +100% to Str racial multi, +75% to Int racial multi, +50% to Wis racial multi, +5% Unarmed damage multi, +5% Spell/Soulskill power, +10% Evasion</font>");
				if (player.perkv2(PerkLib.ElementalBody) == 2) outputText("\n<font color=\"#0000a0\">Adept Sylph: +125% to Str racial multi, +100 to Int racial multi, +75% to Wis racial multi, +10% Unarmed damage multi, +10% Spell/Soulskill power, +20% Evasion</font>");
				if (player.perkv2(PerkLib.ElementalBody) == 3) outputText("\n<font color=\"#0000a0\">Greater Sylph: +150% to Str racial multi, +125% to Int racial multi, +100% to Wis racial multi, +15% Unarmed damage multi, +15% Spell/Soulskill power, +30% Evasion</font>");
				if (player.perkv2(PerkLib.ElementalBody) == 4) outputText("\n<font color=\"#0000a0\">Primordial Sylph: +175% to Str racial multi, +150% to Int racial multi, +125% to Wis racial multi, +20% Unarmed damage multi, +20% Spell/Soulskill power, +40% Evasion</font>");
			}
			if (player.perkv1(PerkLib.ElementalBody) == 2) {
				if (player.perkv2(PerkLib.ElementalBody) == 1) outputText("\n<font color=\"#0000a0\">Lesser Gnome: +50% to Str racial multi, +100% to Tou racial multi, +75% to Wis racial multi, +5% Unarmed damage multi, +10 natural armor/magic resistance (scal), +5% Spell/Soulskill power</font>");
				if (player.perkv2(PerkLib.ElementalBody) == 2) outputText("\n<font color=\"#0000a0\">Adept Gnome: +75% to Str racial multi, +125% to Tou racial multi, +100% to Wis racial multi, +10% Unarmed damage multi, +20 natural armor/magic resistance (scal), +10% Spell/Soulskill power</font>");
				if (player.perkv2(PerkLib.ElementalBody) == 3) outputText("\n<font color=\"#0000a0\">Greater Gnome: +125% to Str racial multi, +150% to Tou racial multi, +125% to Wis racial multi, +15% Unarmed damage multi, +35 natural armor/magic resistance (scal), +15% Spell/Soulskill power</font>");
				if (player.perkv2(PerkLib.ElementalBody) == 4) outputText("\n<font color=\"#0000a0\">Primordial Gnome: +150% to Str racial multi, +175% to Tou racial multi, +150% to Wis racial multi, +20% Unarmed damage multi, +40 natural armor/magic resistance (scal), +20% Spell/Soulskill power</font>");
			}
			if (player.perkv1(PerkLib.ElementalBody) == 3) {
				if (player.perkv2(PerkLib.ElementalBody) == 1) outputText("\n<font color=\"#0000a0\">Lesser Ignis: +75% to Str racial multi, +100% to Spe racial multi, +25% to Wis racial multi, +10% Unarmed damage multi, +5% Spell/Soulskill power, +5% Evasion</font>");
				if (player.perkv2(PerkLib.ElementalBody) == 2) outputText("\n<font color=\"#0000a0\">Adept Ignis: +100% to Str racial multi, +125% to Spe racial multi, +50% to Wis racial multi, +20% Unarmed damage multi, +10% Spell/Soulskill power, +10% Evasion</font>");
				if (player.perkv2(PerkLib.ElementalBody) == 3) outputText("\n<font color=\"#0000a0\">Greater Ignis: +125% to Str racial multi, +150% to Spe racial multi, +75% to Wis racial multi, +30% Unarmed damage multi, +15% Spell/Soulskill power, +15% Evasion</font>");
				if (player.perkv2(PerkLib.ElementalBody) == 4) outputText("\n<font color=\"#0000a0\">Primordial Ignis: +150% to Str racial multi, +175% to Spe racial multi, +100% to Wis racial multi, +40% Unarmed damage multi, +20% Spell/Soulskill power, +20% Evasion</font>");
			}
			if (player.perkv1(PerkLib.ElementalBody) == 4) {
				if (player.perkv2(PerkLib.ElementalBody) == 1) outputText("\n<font color=\"#0000a0\">Lesser Undine: +75% to Str racial multi, +50% to Tou racial multi, +100% to Wis racial multi, +5 natural armor/magic resistance (scal), +10% Spell/Soulskill power, +5% Evasion</font>");
				if (player.perkv2(PerkLib.ElementalBody) == 2) outputText("\n<font color=\"#0000a0\">Adept Undine: +100% to Str racial multi, +75% to Tou racial multi, +125% to Wis racial multi, +10 natural armor/magic resistance (scal), +20% Spell/Soulskill power +10% Evasion</font>");
				if (player.perkv2(PerkLib.ElementalBody) == 3) outputText("\n<font color=\"#0000a0\">Greater Undine: +125% to Str racial multi, +100% to Tou racial multi, +150% to Wis racial multi, +15 natural armor/magic resistance (scal), +30% Spell/Soulskill power, +15% Evasion</font>");
				if (player.perkv2(PerkLib.ElementalBody) == 4) outputText("\n<font color=\"#0000a0\">Primordial Undine: +150% to Str racial multi, +125% to Tou racial multi, +175% to Wis racial multi, +20 natural armor/magic resistance (scal), +40% Spell/Soulskill power, +20% Evasion</font>");
			}
		}
		//Alicorn
		if (player.alicornScore() >= 27) outputText("\n<font color=\"#0000a0\">True Alicorn/True Nightmare: " + player.alicornScore() + " (+60% to Str racial multi, +70% to Tou racial multi, +150% to Spe racial multi, +125% to Int racial multi)</font>");
		else if (player.alicornScore() >= 18) outputText("\n<font color=\"#0000a0\">Alicorn/Nightmare: " + player.alicornScore() + " (+55% to Tou racial multi, +120% to Spe racial multi, +95% to Int racial multi)</font>");
		else if (player.alicornScore() >= 8) outputText("\n<font color=\"#0000a0\"> Half Alicorn/Half Nightmare: " + player.alicornScore() + " (+15% to Tou racial multi, +50% to Spe racial multi, +55% to Int racial multi)</font>");
		else if (player.alicornScore() >= 1) outputText("\n<font color=\"#008000\">Alicorn/Nightmare: " + player.alicornScore() + "</font>");
		else if (player.alicornScore() < 1) outputText("\n<font color=\"#ff0000\">Alicorn/Nightmare: 0</font>");
		//AlicornKin
		if (player.alicornkinScore() >= 12) outputText("\n<font color=\"#0000a0\">Alicornkin/Nightmarekin: " + player.alicornkinScore() + " (+45% to Tou racial multi, +60% to Spe racial multi, +75% to Int racial multi)</font>");
		else if (player.alicornkinScore() >= 1) outputText("\n<font color=\"#008000\">Alicornkin/Nightmarekin: " + player.alicornkinScore() + "</font>");
		else if (player.alicornkinScore() < 1) outputText("\n<font color=\"#ff0000\">Alicornkin/Nightmarekin: 0</font>");
		//Alraune > Liliraune
		if (player.lowerBody != LowerBody.FLOWER_LILIRAUNE) {
			if (player.alrauneScore() >= 17) outputText("\n<font color=\"#0000a0\">Greater Alraune: " + player.alrauneScore() + " (+115% to Tou racial multi, -60% to Spe racial multi, +200% to Lib racial multi)</font>");
			else if (player.alrauneScore() >= 13) outputText("\n<font color=\"#0000a0\">Alraune: " + player.alrauneScore() + " (+100% to Tou racial multi, -50% to Spe racial multi, +145% to Lib racial multi)</font>");
			else if (player.alrauneScore() >= 1) outputText("\n<font color=\"#008000\">Alraune: " + player.alrauneScore() + "</font>");
			else if (player.alrauneScore() < 1) outputText("\n<font color=\"#ff0000\">Alraune: 0</font>");
		}
		else {
			if (player.alrauneScore() >= 17) outputText("\n<font color=\"#0000a0\">Greater Liliraune: " + player.alrauneScore() + " (+115% to Tou racial multi, -60% to Spe racial multi, +200% to Lib racial multi)</font>");
			else if (player.alrauneScore() >= 13) outputText("\n<font color=\"#0000a0\">Liliraune: " + player.alrauneScore() + " (+100% to Tou racial multi, -50% to Spe racial multi, +145% to Lib racial multi)</font>");
			else if (player.alrauneScore() >= 1) outputText("\n<font color=\"#008000\">Liliraune: " + player.alrauneScore() + "</font>");
			else if (player.alrauneScore() < 1) outputText("\n<font color=\"#ff0000\">Liliraune: 0</font>");
		}
		//Apophis
		if (player.apophisScore() >= 26) outputText("\n<font color=\"#0000a0\">Unhallowed Apophis: " + player.apophisScore() + " (+"+(player.isNaga() ? "95":"80")+"% to Str racial multi, +80% to Tou racial multi, +"+(player.isNaga() ? "115":"100")+"% to Spe racial multi, +130% to lib racial multi)</font>");
		else if (player.apophisScore() >= 23) outputText("\n<font color=\"#0000a0\">Apophis: " + player.apophisScore() + " (+"+(player.isNaga() ? "85":"70")+"% to Str racial multi,+70% to Tou racial multi, +"+(player.isNaga() ? "115":"100")+"% to Spe racial multi, +105% to lib racial multi)</font>");
		else if (player.apophisScore() >= 1) outputText("\n<font color=\"#008000\">Apophis: " + player.apophisScore() + "</font>");
		else if (player.apophisScore() < 1) outputText("\n<font color=\"#ff0000\">Apophis: 0</font>");
		//Atlach Nacha
		score = player.atlachNachaScore();
		if (score >= 30) outputText("\n<font color=\"#0000a0\">Greater Atlach Nacha: " + score + " (+340% to Str racial multi, +400% to Tou racial multi, +425% to Int racial multi, +425% to Lib racial multi, -90% to Wis racial multi, +150 to Sens)</font>");
		else if (score >= 21) outputText("\n<font color=\"#0000a0\">Atlach Nacha: " + score + " (+230% to Str racial multi, +265% to Tou racial multi, +300% to Int racial multi, +300% to Lib racial multi, -60% to Wis racial multi, +90 to Sens)</font>");
		else if (score >= 14) outputText("\n<font color=\"#0000a0\">Incomplete Atlach Nacha: " + score + " (+60% to Tou racial multi, +100% to Int racial multi, +60% to Lib racial multi, -10% to Wis racial multi)</font>");
		else if (score >= 1) outputText("\n<font color=\"#008000\">Incomplete Atlach Nacha: " + score + "</font>");
		else if (score < 1) outputText("\n<font color=\"#ff0000\">Half Spider-morph: 0</font>");
		//Angel
		//if (player.demonScore() >= 16 && player.hasPerk(PerkLib.Phylactery)) outputText("\n<font color=\"#0000a0\">Angel: " + player.angelScore() + " (+30% to Spe racial multi, +35% to Int racial multi, +100% to Lib racial multi, +" + (100 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		if (player.angelScore() >= 11) outputText("\n<font color=\"#0000a0\">Angel-kin: " + player.angelScore() + " (+15% to Str racial multi, +15% to Tou racial multi, +45% to Wis racial multi, -15% max Lust, +20% max Wrath, -40% max mana, +40% max SF)</font>");
		else if (player.angelScore() >= 1) outputText("\n<font color=\"#008000\">Angel-kin: " + player.angelScore() + "</font>");
		else if (player.angelScore() < 1) outputText("\n<font color=\"#ff0000\">Angel-kin: 0</font>");
		//Avian
		if (player.avianScore() >= 9) outputText("\n<font color=\"#0000a0\">Avian-morph: " + player.avianScore() + " (+30% to Str racial multi, +75% to Spe racial multi, +30% to Int racial multi)</font>");
		else if (player.avianScore() >= 1) outputText("\n<font color=\"#008000\">Avian-morph: " + player.avianScore() + "</font>");
		else if (player.avianScore() < 1) outputText("\n<font color=\"#ff0000\">Avian-morph: 0</font>");
		//Bat
		if (player.batScore() >= 10) outputText("\n<font color=\"#0000a0\">Batgirl/Batboy: " + player.batScore() + " (+35% to Str racial multi, +35% to Spe racial multi, +35% to Int racial multi, +45% to Lib racial multi)</font>");
		else if (player.batScore() >= 1) outputText("\n<font color=\"#008000\">Batgirl/Batboy: " + player.batScore() + "</font>");
		else if (player.batScore() < 1) outputText("\n<font color=\"#ff0000\">Batgirl/Batboy: 0</font>");
		//Bear/Panda
		if (player.bearpandaScore() >= 10) outputText("\n<font color=\"#0000a0\">Bear/Panda-morph: " + player.bearpandaScore() + " (+100% to Str racial multi, +70% to Tou racial multi, -20% to Int racial multi)</font>");
		else if (player.bearpandaScore() >= 1) outputText("\n<font color=\"#008000\">Bear/Panda-morph: " + player.bearpandaScore() + "</font>");
		else if (player.bearpandaScore() < 1) outputText("\n<font color=\"#ff0000\">Bear/Panda-morph: 0</font>");
		//Bee
		if (player.beeScore() >= 17) outputText("\n<font color=\"#0000a0\">Bee-morph: " + player.beeScore() + " (+80% to Tou racial multi, +80% to Spe racial multi, +50% to Int racial multi, +65% to Lib racial multi & +20 to min Lib)</font>");
		else if (player.beeScore() >= 1) outputText("\n<font color=\"#008000\">Bee-morph: " + player.beeScore() + "</font>");
		else if (player.beeScore() < 1) outputText("\n<font color=\"#ff0000\">Bee-morph: 0</font>");
		//Bunny
		if (player.bunnyScore() >= 10) outputText("\n<font color=\"#0000a0\">Bunny-morph: " + player.bunnyScore() + " (-20% to Str racial multi, -10% to Tou racial multi, +90% to Spe racial multi, +90% to Lib racial multi)</font>");
		else if (player.bunnyScore() >= 1) outputText("\n<font color=\"#008000\">Bunny-morph: " + player.bunnyScore() + "</font>");
		else if (player.bunnyScore() < 1) outputText("\n<font color=\"#ff0000\">Bunny-morph: 0</font>");
		//Cancer
		if (player.cancerScore() >= 20) outputText("\n<font color=\"#0000a0\">Cancer: " + player.cancerScore() + " (+125% to Str racial multi, +115% to Tou racial multi, +105% to Spe racial multi, -30% to Int racial multi, -15% to Wis racial multi)</font>");
		else if (player.cancerScore() >= 13) outputText("\n<font color=\"#0000a0\">Lesser Cancer: " + player.cancerScore() + " (+105% to Str racial multi, +80% to Tou racial multi, +55% to Spe racial multi, -30% to Int racial multi, -15% to Wis racial multi)</font>");
		else if (player.cancerScore() >= 1) outputText("\n<font color=\"#008000\">Lesser Cancer: " + player.cancerScore() + "</font>");
		else if (player.cancerScore() < 1) outputText("\n<font color=\"#ff0000\">Lesser Cancer: 0</font>");
		//Cat
		if (player.catScore() >= 8) outputText("\n<font color=\"#0000a0\">Cat-girl/Cat-boy/Cat Morph: " + player.catScore() + " (+"+(player.hasPerk(PerkLib.Flexibility) ? "60":"70")+"% to Spe racial multi, +60% to Lib racial multi)</font>");
		else if (player.catScore() >= 1) outputText("\n<font color=\"#008000\">Cat-girl/Cat-boy/Cat-morph: " + player.catScore() + "</font>");
		else if (player.catScore() < 1) outputText("\n<font color=\"#ff0000\">Cat-girl/Cat-boy/Cat-morph: 0</font>");
		//Cave Wyrm
		if (player.cavewyrmScore() >= 10) outputText("\n<font color=\"#0000a0\">Cave Wyrm: " + player.cavewyrmScore() + " (+60% to Str racial multi, +70% to Tou racial multi, -30% to Wis racial multi, +50% to Lib racial multi)</font>");
		else if (player.cavewyrmScore() >= 1) outputText("\n<font color=\"#008000\">Cave Wyrm: " + player.cavewyrmScore() + "</font>");
		else if (player.cavewyrmScore() < 1) outputText("\n<font color=\"#ff0000\">Cave Wyrm: 0</font>");
		//Centaur
		if (player.centaurScore() >= 8) outputText("\n<font color=\"#0000a0\">Centaur: " + player.centaurScore() + " (+40% to Tou racial multi, +80% to Spe racial multi, +100 max HP)</font>");
		else if (player.centaurScore() >= 1) outputText("\n<font color=\"#008000\">Centaur: " + player.centaurScore() + "</font>");
		else if (player.centaurScore() < 1) outputText("\n<font color=\"#ff0000\">Centaur: 0</font>");
		//Centipede
		if (player.centipedeScore() >= 8) outputText("\n<font color=\"#0000a0\">Centipede: " + player.centipedeScore() + " (+60% to Str racial multi, +80% to Spe racial multi)</font>");
		else if (player.centipedeScore() >= 1) outputText("\n<font color=\"#008000\">Centipede: " + player.centipedeScore() + "</font>");
		else if (player.centipedeScore() < 1) outputText("\n<font color=\"#ff0000\">Centipede: 0</font>");
		//Cheshire cat
		if (player.cheshireScore() >= 11) outputText("\n<font color=\"#0000a0\">Cheshire cat: " + player.cheshireScore() + " (+"+(player.hasPerk(PerkLib.Flexibility) ? "60":"70")+"% to Spe racial multi, +80% to Int racial multi, +25 max Sens)</font>");
		else if (player.cheshireScore() >= 1) outputText("\n<font color=\"#008000\">Cheshire cat: " + player.cheshireScore() + "</font>");
		else if (player.cheshireScore() < 1) outputText("\n<font color=\"#ff0000\">Cheshire cat: 0</font>");
		//CHIMERA
		outputText("\nCHIMERA: " + player.chimeraScore());
		//Couatl
		if (player.couatlScore() >= 19) outputText("\n<font color=\"#0000a0\">Greater Couatl: " + player.couatlScore() + " (+"+(player.isNaga() ? "65":"50")+"% to Str racial multi, +45% to Tou racial multi, +"+(player.isNaga() ? "155":"140")+"% to Spe racial multi, +50% to Int racial multi)</font>");//, +50 max HP
		if (player.couatlScore() >= 11) outputText("\n<font color=\"#0000a0\">Couatl: " + player.couatlScore() + " (+"+(player.isNaga() ? "45":"30")+"% to Str racial multi, +25% to Tou racial multi, +"+(player.isNaga() ? "95":"80")+"% to Spe racial multi, +30% to Int racial multi)</font>");//, +50 max HP
		else if (player.couatlScore() >= 1) outputText("\n<font color=\"#008000\">Couatl: " + player.couatlScore() + "</font>");
		else if (player.couatlScore() < 1) outputText("\n<font color=\"#ff0000\">Couatl: 0</font>");
		//Cow
		if (player.cowScore() >= 15) outputText("\n<font color=\"#0000a0\">Lacta Bovine: " + player.cowScore() + " (+170% to Str racial multi, +45% to Tou racial multi, -40% to Spe racial multi, -20% to Int racial multi, +70% to Lib racial multi, +" + (50 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.cowScore() >= 10) outputText("\n<font color=\"#0000a0\">Cow-morph: " + player.cowScore() + " (+120% to Str racial multi, +45% to Tou racial multi, -40% to Spe racial multi, -20% to Int racial multi, +45% to Lib racial multi, +" + (50 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.cowScore() >= 1) outputText("\n<font color=\"#008000\">Cow-morph: " + player.cowScore() + "</font>");
		else if (player.cowScore() < 1) outputText("\n<font color=\"#ff0000\">Cow-morph: 0</font>");
		//Cyclop
		if (player.cyclopScore() >= 12) outputText("\n<font color=\"#0000a0\">Cyclop: " + player.cyclopScore() + " (+90% to Str racial multi, +90% to Tou racial multi)</font>");
		else if (player.cyclopScore() >= 1) outputText("\n<font color=\"#008000\">Cyclop: " + player.cyclopScore() + "</font>");
		else if (player.cyclopScore() < 1) outputText("\n<font color=\"#ff0000\">Cyclop: 0</font>");
		//Dark Goo
		if (player.darkgooScore() >= 17) outputText("\n<font color=\"#0000a0\">Dark Slime Queen: " + player.darkgooScore() + " (+115% to Tou racial multi, -50% to Spe racial multi, +45% to Int racial multi, +145% to Lib racial multi)</font>");
		else if (player.darkgooScore() >= 13) outputText("\n<font color=\"#0000a0\">Dark Slime: " + player.darkgooScore() + " (+90% to Tou racial multi, -40% to Spe racial multi, +45% to Int racial multi, +100% to Lib racial multi)</font>");
		else if (player.darkgooScore() >= 1) outputText("\n<font color=\"#008000\">Dark Slime: " + player.darkgooScore() + "</font>");
		else if (player.darkgooScore() < 1) outputText("\n<font color=\"#ff0000\">Dark Slime: 0</font>");
		//Deer
		if (player.deerScore() >= 4) outputText("\n<font color=\"#0000a0\">Deer-morph: " + player.deerScore() + " (+20% to Spe racial multi)</font>");
		else if (player.deerScore() >= 1) outputText("\n<font color=\"#008000\">Deer-morph: " + player.deerScore() + "</font>");
		else if (player.deerScore() < 1) outputText("\n<font color=\"#ff0000\">Deer-morph: 0</font>");
		//Demon
		if (player.demonScore() >= 16 && player.hasPerk(PerkLib.Soulless)) outputText("\n<font color=\"#0000a0\">Succub/Incubus: " + player.demonScore() + " (+40% to Spe racial multi, +60% to Int racial multi, +140% to Lib racial multi, +60% max Lust, -45% max Wrath, +120% max mana, max SF drops to 0)</font>");
		else if (player.demonScore() >= 11) outputText("\n<font color=\"#0000a0\">Succubi-kin/Incubi-kin: " + player.demonScore() + " (+30% to Spe racial multi, +35% to Int racial multi, +100% to Lib racial multi, +40% max Lust, -30% max Wrath, +80% max mana, -80% max SF)</font>");
		else if (player.demonScore() >= 1) outputText("\n<font color=\"#008000\">Succubi-kin/Incubi-kin: " + player.demonScore() + "</font>");
		else if (player.demonScore() < 1) outputText("\n<font color=\"#ff0000\">Succubi-kin/Incubi-kin: 0</font>");
		//Devil
		if (player.devilkinScore() >= 16 && player.hasPerk(PerkLib.Phylactery)) {
			if (player.devilkinScore() >= 21) outputText("\n<font color=\"#0000a0\">Archdevil: " + player.devilkinScore() + " (+95% to Str racial multi, -30% to Spe racial multi, +180% to Int racial multi, +120% to Lib racial multi, +50 min Sens, +" + (320 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
			else outputText("\n<font color=\"#0000a0\">Devil: " + player.devilkinScore() + " (+75% to Str racial multi, -25% to Spe racial multi, +130% to Int racial multi, +100% to Lib racial multi, +40 min Sens, +" + (230 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		}
		else if (player.devilkinScore() >= 11) outputText("\n<font color=\"#0000a0\">Devilkin: " + player.devilkinScore() + " (+55% to Str racial multi, -20% to Spe racial multi, +80% to Int racial multi, +65% to Lib racial multi, +15 min Sens, +" + (150 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.devilkinScore() >= 1) outputText("\n<font color=\"#008000\">Fiend: " + player.devilkinScore() + "</font>");
		else if (player.devilkinScore() < 1) outputText("\n<font color=\"#ff0000\">Fiend: 0</font>");
		//Displacer beast
		if (player.displacerbeastScore() >= 20) outputText("\n<font color=\"#0000a0\">Displacer Beast: " + player.displacerbeastScore() + " (+140% to Str racial multi, +"+(player.hasPerk(PerkLib.Flexibility) ? "150":"140")+"% to Spe racial multi, -30% to Int racial multi, -30% to Wis racial multi, +80% to Lib racial multi)</font>");
		else if (player.displacerbeastScore() >= 14) outputText("\n<font color=\"#0000a0\">Displacer Beast: " + player.displacerbeastScore() + " (+95% to Str racial multi, +"+(player.hasPerk(PerkLib.Flexibility) ? "100":"110")+"% to Spe racial multi, -25% to Int racial multi, -20% to Wis racial multi, +60% to Lib racial multi)</font>");
		else if (player.displacerbeastScore() >= 1) outputText("\n<font color=\"#008000\">Displacer Beast: " + player.displacerbeastScore() + "</font>");
		else if (player.displacerbeastScore() < 1) outputText("\n<font color=\"#ff0000\">Displacer Beast: 0</font>");
		//Dog
		if (player.dogScore() >= 4) outputText("\n<font color=\"#0000a0\">Dog-morph: " + player.dogScore() + " (+15% to Spe racial multi, -5% to Int racial multi)</font>");
		else if (player.dogScore() >= 1) outputText("\n<font color=\"#008000\">Dog-morph: " + player.dogScore() + "</font>");
		else if (player.dogScore() < 1) outputText("\n<font color=\"#ff0000\">Dog-morph: 0</font>");
		//Dragon
		if (player.dragonScore() >= 32) {
			outputText("\n<font color=\"#0000a0\">Ancient Dragon: " + player.dragonScore() + " (+100% to Str / Tou / Spe racial multi, +80% to Int / Wis racial multi, +60% to Lib racial multi, +40 to min Sen, ");
			outputText("+30% max HP, +" + (50 * (1 + player.newGamePlusMod())) + " max Lust, +" + (200 * (1 + player.newGamePlusMod())) + " max Fatigue, +" + (10 * (1 + player.newGamePlusMod())) + " Armor / Magic Resistance)</font>");
		}
		else if (player.dragonScore() >= 24) {
			outputText("\n<font color=\"#0000a0\">Elder Dragon: " + player.dragonScore() + " (+80% to Str / Tou / Spe racial multi, +70% to Int / Wis racial multi, +40% to Lib racial multi, +30 to min Sen, ");
			outputText("+20% max HP, +" + (25 * (1 + player.newGamePlusMod())) + " max Lust, +" + (100 * (1 + player.newGamePlusMod())) + " max Fatigue, +" + (4 * (1 + player.newGamePlusMod())) + " Armor / Magic Resistance)</font>");
		}
		else if (player.dragonScore() >= 16) outputText("\n<font color=\"#0000a0\">Dragon: " + player.dragonScore() + " (+50% to Str / Tou / Spe racial multi, +40% to Int / Wis racial multi, +30% to Lib racial multi, +20 to min Sen, +10% max HP, +" + (1 + player.newGamePlusMod()) + " Armor / Magic Resistance)</font>");
		else if (player.dragonScore() >= 1) outputText("\n<font color=\"#008000\">Dragon: " + player.dragonScore() + "</font>");
		else if (player.dragonScore() < 1) outputText("\n<font color=\"#ff0000\">Dragon: 0</font>");
		//Dragonne
		outputText("\nDragonne: " + player.dragonneScore());
		//Easter Bunny
		if (player.easterbunnyScore() >= 1) {
			if (player.hasPerk(PerkLib.EasterBunnyBalls)) {
				if (player.easterbunnyScore() >= 15) outputText("\n<font color=\"#0000a0\">True Easter Bunny: " + player.easterbunnyScore() + " (-20% to Str racial multi, -10% to Tou racial multi, +105% to Spe racial multi, +150% to Lib racial multi)</font>");
				else if (player.easterbunnyScore() >= 12) outputText("\n<font color=\"#0000a0\">Easter Bunny: " + player.easterbunnyScore() + " (-20% to Str racial multi, -10% to Tou racial multi, +90% to Spe racial multi, +120% to Lib racial multi)</font>");
				else if (player.easterbunnyScore() >= 1) outputText("\n<font color=\"#008000\">Easter Bunny: " + player.easterbunnyScore() + "</font>");
			}
			else outputText("\n<font color=\"#ff0000\">Easter Bunny (Require Easter bunny balls): " + player.easterbunnyScore() + "</font>");
		}
		else if (player.easterbunnyScore() < 1) outputText("\n<font color=\"#ff0000\">Easter Bunny (Require Easter bunny balls): 0</font>");
		//Echidna
		outputText("\nEchidna: " + player.echidnaScore());
		//Elf
		if (player.elfScore() >= 11) outputText("\n<font color=\"#0000a0\">Elf: " + player.elfScore() + " (-10% to Str racial multi, -15% to Tou racial multi, +80% to Spe / Int racial multi, +60% to Wis racial multi, +30 min Sens, +20% max Mana)</font>");
		else if (player.elfScore() >= 1) outputText("\n<font color=\"#008000\">Elf: " + player.elfScore() + "</font>");
		else if (player.elfScore() < 1) outputText("\n<font color=\"#ff0000\">Elf: 0</font>");
		//Wood Elf
		if (player.woodElfScore() >= 31) outputText("\n<font color=\"#0000a0\">Wood Elf elder sister: " + player.woodElfScore() + " (-10% to Str racial multi, -15% to Tou racial multi, +550% to Spe racial multi, +495% to Int racial multi, +455% to Lib racial multi, +80 Sens, +40% max Mana)</font>");
		else if (player.woodElfScore() >= 28) outputText("\n<font color=\"#0000a0\">Wood Elf sister: " + player.woodElfScore() + " (-10% to Str racial multi, -15% to Tou racial multi, +495% to Spe racial multi, +445% to Int racial multi, +415% to Lib racial multi, +70 Sens, +30% max Mana)</font>");
		else if (player.woodElfScore() >= 25) outputText("\n<font color=\"#0000a0\">Wood Elf young sister: " + player.woodElfScore() + " (-10% to Str racial multi, -15% to Tou racial multi, +430% to Spe racial multi, +405% to Int racial multi, +375% to Lib racial multi, +60 Sens, +20% max Mana)</font>");
		else if (player.woodElfScore() >= 22) outputText("\n<font color=\"#0000a0\">Wood Elf little sister: " + player.woodElfScore() + " (-10% to Str racial multi, -15% to Tou racial multi, +375% to Spe racial multi, +355% to Int racial multi, +335% to Lib racial multi, +50 Sens, +10% max Mana)</font>");
		else if (player.woodElfScore() >= 1) outputText("\n<font color=\"#008000\">Wood Elf: " + player.woodElfScore() + "</font>");
		else if (player.woodElfScore() < 1) outputText("\n<font color=\"#ff0000\">Wood Elf: 0</font>");
		//Ferret
		outputText("\nFerret-morph: " + player.ferretScore());
		//Fire snail
		if (player.firesnailScore() >= 15) outputText("\n<font color=\"#0000a0\">Fire Snail: " + player.firesnailScore() + " (+70% to Str racial multi, +175% to Tou racial multi, -80% to Spe racial multi, +110% to Lib racial multi, +50 min Sens)</font>");
		else if (player.firesnailScore() >= 1) outputText("\n<font color=\"#008000\">Fire Snail: " + player.firesnailScore() + "</font>");
		else if (player.firesnailScore() < 1) outputText("\n<font color=\"#ff0000\">Fire Snail: 0</font>");
		//Fox
		if (player.foxScore() >= 7) outputText("\n<font color=\"#0000a0\">Fox-morph: " + player.foxScore() + " (-30% to Str racial multi, +80% to Spe racial multi, +55% to Int racial multi, +" + (20 * (1 + player.newGamePlusMod())) + " max Fatigue)</font>");
		else if (player.foxScore() >= 1) outputText("\n<font color=\"#008000\">Fox-morph: " + player.foxScore() + "</font>");
		else if (player.foxScore() < 1) outputText("\n<font color=\"#ff0000\">Fox-morph: 0</font>");
		//Fairy
		if (player.fairyScore() >= 32) outputText("\n<font color=\"#0000a0\">Titania: " + player.fairyScore() + " (-20% to Str racial multi, -10% to Tou racial multi, +660% to Spe racial multi, +660% to Int racial multi, +200% to Wis racial multi, +50 Sens)</font>");
		else if (player.fairyScore() >= 29) outputText("\n<font color=\"#0000a0\">Fairy Queen: " + player.fairyScore() + " (-20% to Str racial multi, -10% to Tou racial multi, +600% to Spe racial multi, +600% to Int racial multi, +175% to Wis racial multi, +40 Sens)</font>");
		else if (player.fairyScore() >= 26) outputText("\n<font color=\"#0000a0\">Noble Fairy: " + player.fairyScore() + " (-20% to Str racial multi, -10% to Tou racial multi, +540% to Spe racial multi, +540% to Int racial multi, +150% to Wis racial multi, +30 Sens)</font>");
		else if (player.fairyScore() >= 23) outputText("\n<font color=\"#0000a0\">Greater Fairy: " + player.fairyScore() + " (-20% to Str racial multi, -10% to Tou racial multi, +480% to Spe racial multi, +480% to Int racial multi, +125% to Wis racial multi, +20 Sens)</font>");
		else if (player.fairyScore() >= 1) outputText("\n<font color=\"#008000\">Fairy: " + player.fairyScore() + "</font>");
		else if (player.fairyScore() < 1) outputText("\n<font color=\"#ff0000\">Fairy: 0</font>");
		//Frost Wyrm
		if (player.frostWyrmScore() >= 26) outputText("\n<font color=\"#0000a0\">Greater Frost Wyrm: " + player.frostWyrmScore() + " (+18% to Str racial multi, +90% to Spe racial multi, +150% to Tou racial multi, -100% to Int racial multi, +70% to Lib racial multi, +" + (4 * (1 + player.newGamePlusMod())) + " Armor / Magic Resistance)</font>");
		else if (player.frostWyrmScore() >= 18) outputText("\n<font color=\"#0000a0\">Frost Wyrm: " + player.frostWyrmScore() + " (+130% to Str racial multi, +70% to Spe racial multi, +110% to Tou racial multi, -90% to Int racial multi, +50% to Lib racial multi, +" + (1 * (1 + player.newGamePlusMod())) + " Armor / Magic Resistance)</font>");
		else if (player.frostWyrmScore() >= 1) outputText("\n<font color=\"#008000\">Frost Wyrm: " + player.frostWyrmScore() + "</font>");
		else if (player.frostWyrmScore() < 1) outputText("\n<font color=\"#ff0000\">Frost Wyrm: 0</font>");
		//GARGOYLE
		if (player.gargoyleScore() >= 20 && (player.hasPerk(PerkLib.GargoylePure) || player.hasPerk(PerkLib.GargoyleCorrupted))) {
			
			outputText("\n<font color=\"#0000a0\">" + (player.hasPerk(PerkLib.GargoylePure) ? "Pure ":"Corrupted ") + Forgefather.materialWord() + " Gargoyle: " + player.gargoyleScore());
			switch (Forgefather.material) {
				case "stone":
					if (Forgefather.refinement == 1) {
						tempStr+=50; tempTou+=50; tempSpd+=50; tempInt +=50; tempWis+=50;
					}
					if (Forgefather.refinement == 2) {
						tempStr+=75; tempTou+=75; tempSpd+=75; tempInt +=75; tempWis+=75;
					}
					if (Forgefather.refinement == 3) {
						tempStr+=100; tempTou+=100; tempSpd+=100; tempInt +=100; tempWis+=100;
					}
					break;
				case "alabaster":					
					if (Forgefather.refinement == 1) {
						tempInt+=100; tempWis+=50; tempMana+=20; tempSDmg+=15; tempStr-=10; tempSpd -=10;
					}
					if (Forgefather.refinement == 2) {
						tempInt+=150; tempWis+=75; tempMana+=25; tempSDmg+=25; tempStr-=15; tempSpd -=15;
					}
					if (Forgefather.refinement == 3) {
						tempInt+=200; tempWis+=100; tempMana+=35; tempSDmg+=50; tempStr-=20; tempSpd -=20;
					}
					if (Forgefather.refinement == 4) {
						tempInt+=200; tempWis+=100; tempMana+=35; tempSDmg+=50; tempStr-=20; tempSpd -=20;
					}
					if (Forgefather.refinement == 5) {
						tempInt+=500; tempWis+=250; tempMana+=50; tempSDmg+=100; tempStr-=30; tempSpd -=30;
					}
					break;
				case "ebony":
					if (Forgefather.refinement == 1) {
						tempStr+=100; tempSpd+=50; tempWrath+=20; tempMDmg+=15; tempInt -=10; tempWis-=10;
					}
					if (Forgefather.refinement == 2) {
						tempStr+=150; tempSpd+=75; tempWrath+=25; tempMDmg+=25; tempInt -=15; tempWis-=15;
					}
					if (Forgefather.refinement == 3) {
						tempStr+=200; tempSpd+=100; tempWrath+=35; tempMDmg+=50; tempInt -=20; tempWis-=20;
					}
					if (Forgefather.refinement == 4) {
						tempStr+=200; tempSpd+=100; tempWrath+=35; tempMDmg+=50; tempInt -=20; tempWis-=20;
					}
					if (Forgefather.refinement == 5) {
						tempStr+=500; tempSpd+=250; tempWrath+=50; tempMDmg+=100; tempInt -=30; tempWis-=30;
					}
					break;
				case "granite":
					if (Forgefather.refinement == 1) {
						tempTou+=100; tempStr+=50; tempHP+=20; tempDRes+=15; tempInt-=10; tempWis-=10;
					}
					if (Forgefather.refinement == 2) {
						tempTou+=150; tempStr+=75; tempHP+=25; tempDRes+=25; tempInt-=15; tempWis-=15;
					}
					if (Forgefather.refinement == 3) {
						tempTou+=200; tempStr+=100; tempHP+=35; tempDRes+=50; tempInt-=20; tempWis-=20;
					}
					if (Forgefather.refinement == 4) {
						tempTou+=200; tempStr+=100; tempHP+=35; tempDRes+=50; tempInt-=20; tempWis-=20;
					}
					if (Forgefather.refinement == 5) {
						tempTou+=500; tempStr+=250; tempHP+=50; tempDRes+=100; tempInt-=30; tempWis-=30;
					}
					break;
				case "marble":
					if (Forgefather.refinement == 1) {
						tempWis+=100; tempStr+=50; tempSF+=20; tempUDmg+=15; tempInt-=10;
					}
					if (Forgefather.refinement == 2) {
						tempWis+=150; tempStr+=75; tempSF+=25; tempUDmg+=25; tempInt-=15;
					}
					if (Forgefather.refinement == 3) {
						tempWis+=200; tempStr+=100; tempSF+=35; tempUDmg+=50; tempInt-=20;
					}
					if (Forgefather.refinement == 4) {
						tempWis+=200; tempStr+=100; tempSF+=35; tempUDmg+=50; tempInt-=20;
					}
					if (Forgefather.refinement == 5) {
						tempWis+=500; tempStr+=250; tempSF+=50; tempUDmg+=100; tempInt-=30;
					}
					break;
				case "sandstone":
					if (Forgefather.refinement == 1) {
						tempSpd+=100; tempStr+=25; tempInt+=25; tempFat+=20; tempRDmg+=15; tempWis-=10;
					}
					if (Forgefather.refinement == 2) {
						tempSpd+=150; tempStr+=35; tempInt+=35; tempFat+=25; tempRDmg+=25; tempWis-=15;
					}
					if (Forgefather.refinement == 3) {
						tempSpd+=200; tempStr+=50; tempInt+=50; tempFat+=35; tempRDmg+=50; tempWis-=20;
					}
					if (Forgefather.refinement == 4) {
						tempSpd+=200; tempStr+=125; tempInt+=125; tempFat+=35; tempRDmg+=50; tempWis-=20;
					}
					if (Forgefather.refinement == 5) {
						tempSpd+=500; tempStr+=125; tempInt+=125; tempFat+=50; tempRDmg+=100; tempWis-=30;
					}
					break;
				default:
					break;
			}
			if (player.hasPerk(PerkLib.GargoylePure)){
				tempWis+=130; tempLib-=20; tempSen-=10;
			}
			if (player.hasPerk(PerkLib.GargoyleCorrupted)){
				tempWis-=20; tempLib+=140;
			}
			switch(Forgefather.channelInlay)
			{
				case "amethyst":
					if (Forgefather.refinement == 4) tempDarkDmg += 25;
					if (Forgefather.refinement == 5) tempDarkDmg += 50;
					break;
				case "emerald":
					if (Forgefather.refinement == 4) tempSpd += 15;
					if (Forgefather.refinement == 5) tempSpd += 30;
					break;
				case "ruby":
					if (Forgefather.refinement == 4) tempFireDmg += 25;
					if (Forgefather.refinement == 5) tempFireDmg += 50;
					break;
				case "sapphire":
					if (Forgefather.refinement == 4) tempIceDmg += 25;
					if (Forgefather.refinement == 5) tempIceDmg += 50;
					break;
				case "topaz":
					if (Forgefather.refinement == 4) tempLtngDmg += 25;
					if (Forgefather.refinement == 5) tempLtngDmg += 50;
					break;
				default:
					break;
			}
			switch(Forgefather.gem)
			{
				case "amethyst":
					if (Forgefather.refinement == 4) tempDarkDmg += 12;
					if (Forgefather.refinement == 5) tempDarkDmg += 25;
					break;
				case "emerald":
					if (Forgefather.refinement == 4) tempSpd += 7;
					if (Forgefather.refinement == 5) tempSpd += 15;
					break;
				case "ruby":
					if (Forgefather.refinement == 4) tempFireDmg += 12;
					if (Forgefather.refinement == 5) tempFireDmg += 25;
					break;
				case "sapphire":
					if (Forgefather.refinement == 4) tempIceDmg += 12;
					if (Forgefather.refinement == 5) tempIceDmg += 25;
					break;
				case "topaz":
					if (Forgefather.refinement == 4) tempLtngDmg += 12;
					if (Forgefather.refinement == 5) tempLtngDmg += 25;
					break;
				default:
					break;
			}
			outputText("\n<font color=\"#0000a0\">\t("); if (tempStr != 0) outputText("<font color=\"#0000a0\">" + tempStr + "% to Str Racial Multi, "); if (tempSpd != 0) outputText("<font color=\"#0000a0\">" + tempSpd + "% to Spe Racial Multi, "); if (tempTou != 0) outputText("<font color=\"#0000a0\">" + tempTou + "% to Tou Racial Multi, "); if (tempInt != 0) outputText("<font color=\"#0000a0\">" + tempInt + "% to Int Racial Multi, "); if (tempWis != 0) outputText("<font color=\"#0000a0\">" + tempWis + "% to Wis Racial Multi, "); if (tempLib != 0) outputText("<font color=\"#0000a0\">" + tempLib + "% to Lib Racial Multi, "); if (tempSen != 0) outputText("<font color=\"#0000a0\">" + tempSen + " to Sen, ");
			outputText("\n<font color=\"#0000a0\">\t"); if (tempHP != 0) outputText("<font color=\"#0000a0\">" + tempHP + "% to Max HP, "); if (tempWrath != 0) outputText("<font color=\"#0000a0\">" + tempWrath + "% to Max Wrath, "); if (tempFat != 0) outputText("<font color=\"#0000a0\">" + tempFat + "% to Max Fatigue, "); if (tempMana != 0) outputText("<font color=\"#0000a0\">" + tempMana + "% to Max Mana, "); if (tempSF != 0) outputText("<font color=\"#0000a0\">" + tempSF + "% to Max Soul Force, ");
			outputText("\n<font color=\"#0000a0\">\t"); if (tempUDmg != 0) outputText("<font color=\"#0000a0\">" + tempUDmg + "% to Unarmed Damage, "); if (tempMDmg != 0) outputText("<font color=\"#0000a0\">" + tempMDmg + "% to Melee Damage, "); if (tempRDmg != 0) outputText("<font color=\"#0000a0\">" + tempRDmg + "% to Ranged Damage, "); if (tempSDmg != 0) outputText("<font color=\"#0000a0\">" + tempSDmg + "% to Spell Damage, "); if (tempDRes != 0) outputText("<font color=\"#0000a0\">" + tempDRes + "% to Damage Resist, "); if (tempDarkDmg != 0) outputText("<font color=\"#0000a0\">" + tempDarkDmg + "% to Darkness Damage"); if (tempIceDmg != 0) outputText("<font color=\"#0000a0\">" + tempIceDmg + "% to Ice Damage"); if (tempFireDmg != 0) outputText("<font color=\"#0000a0\">" + tempFireDmg + "% to Fire Damage"); if (tempLtngDmg != 0) outputText("<font color=\"#0000a0\">" + tempLtngDmg + "% to Lightning Damage");
			outputText("<font color=\"#0000a0\">.)");
			
		}
		else if (player.gargoyleScore() >= 1) outputText("\n<font color=\"#008000\">GARGOYLE: " + player.gargoyleScore() + "</font>");
		else if (player.gargoyleScore() < 1) outputText("\n<font color=\"#ff0000\">GARGOYLE: 0</font>");
		//Gazer
		if (player.gazerScore() >= 21 && player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10) outputText("\n<font color=\"#0000a0\">Eye Tyrant: " + player.gazerScore() + " (+80% to Tou racial multi, -75% to Spe racial multi, +180% to Int racial multi, +130% to Lib racial multi)</font>");
		else if (player.gazerScore() >= 14 && player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 6) outputText("\n<font color=\"#0000a0\">Gazer: " + player.gazerScore() + " (+55% to Tou racial multi, -65% to Spe racial multi, +130% to Int racial multi, +90% to Lib racial multi)</font>");
		else if (player.gazerScore() >= 1) outputText("\n<font color=\"#008000\">Gazer: " + player.gazerScore() + "</font>");
		else if (player.gazerScore() < 1) outputText("\n<font color=\"#ff0000\">Gazer: 0</font>");
		//Goblin
		if (player.goblinScore() >= 10) outputText("\n<font color=\"#0000a0\">Goblin: " + player.goblinScore() + " (-50% to Str racial multi, +75% to Spe racial multi, +100% to Int racial multi, +25% to Lib racial multi)</font>");
		else if (player.goblinScore() >= 1) outputText("\n<font color=\"#008000\">Goblin: " + player.goblinScore() + "</font>");
		else if (player.goblinScore() < 1) outputText("\n<font color=\"#ff0000\">Goblin: 0</font>");
		//Gremlin
		if (player.gremlinScore() >= 18) outputText("\n<font color=\"#0000a0\">High Gremlin: " + player.gremlinScore() + " (-50% to Str racial multi, +90% to Spe racial multi, +135% to Int racial multi, +100% to Lib racial multi, +20 min sens)</font>");
		else if (player.gremlinScore() >= 15) outputText("\n<font color=\"#0000a0\">Gremlin: " + player.gremlinScore() + " (-50% to Str racial multi, +75% to Spe racial multi, +120% to Int racial multi, +115% to Lib racial multi, +20 min sens)</font>");
		else if (player.gremlinScore() >= 1) outputText("\n<font color=\"#008000\">Gremlin: " + player.gremlinScore() + "</font>");
		else if (player.gremlinScore() < 1) outputText("\n<font color=\"#ff0000\">Gremlin: 0</font>");
		//Gryphon
		outputText("\nGryphon: " + player.gryphonScore());
		//Goo
		if (player.gooScore() >= 15) outputText("\n<font color=\"#0000a0\">Slime Queen: " + player.gooScore() + " (+115% to Tou racial multi, -50% to Spe racial multi, +160% to Lib racial multi)</font>");
		else if (player.gooScore() >= 11) outputText("\n<font color=\"#0000a0\">Slime: " + player.gooScore() + " (+105% to Tou racial multi, -40% to Spe racial multi, +100% to Lib racial multi)</font>");
		else if (player.gooScore() >= 1) outputText("\n<font color=\"#008000\">Slime: " + player.gooScore() + "</font>");
		else if (player.gooScore() < 1) outputText("\n<font color=\"#ff0000\">Slime: 0</font>");
		//Gorgon
		if (player.gorgonScore() >= 17) outputText("\n<font color=\"#0000a0\">Greater Gorgon: " + player.gorgonScore() + " (+"+(player.isNaga() ? "95":"80")+"% to Str racial multi, +65% to Tou racial multi, +"+(player.isNaga() ? "125":"110")+"% to Spe racial multi, +" + (100 * (1 + player.newGamePlusMod())) + " max HP)</font>");
		if (player.gorgonScore() >= 11) outputText("\n<font color=\"#0000a0\">Gorgon: " + player.gorgonScore() + " (+"+(player.isNaga() ? "65":"50")+"% to Str racial multi, +45% to Tou racial multi, +"+(player.isNaga() ? "85":"70")+"% to Spe racial multi, +" + (50 * (1 + player.newGamePlusMod())) + " max HP)</font>");
		else if (player.gorgonScore() >= 1) outputText("\n<font color=\"#008000\">Gorgon: " + player.gorgonScore() + "</font>");
		else if (player.gorgonScore() < 1) outputText("\n<font color=\"#ff0000\">Gorgon: 0</font>");
		//GRAND CHIMERA
		outputText("\nGRAND CHIMERA: " + player.grandchimeraScore());
		//Harpy
		if (player.harpyScore() >= 15) outputText("\n<font color=\"#0000a0\">Harpy Queen: " + player.harpyScore() + " (-30% to Tou racial multi, +150% to Spe racial multi, +105% to Lib racial multi)</font>");
		else if (player.harpyScore() >= 8) outputText("\n<font color=\"#0000a0\">Harpy: " + player.harpyScore() + " (-20% to Tou racial multi, +80% to Spe racial multi, +60% to Lib racial multi)</font>");
		else if (player.harpyScore() >= 1) outputText("\n<font color=\"#008000\">Harpy: " + player.harpyScore() + "</font>");
		else if (player.harpyScore() < 1) outputText("\n<font color=\"#ff0000\">Harpy: 0</font>");
		//Hellcat
		if (player.hellcatScore() >= 17 && player.tailType == Tail.TWINKASHA && player.tailCount == 2) {
			outputText("\n<font color=\"#0000a0\">Kasha: " + player.hellcatScore() + " (+");
			if (player.hasPerk(PerkLib.Flexibility)) {
				if (player.hasPerk(MutationsLib.CatlikeNimblenessEvolved)) outputText("100");
				else if (player.hasPerk(MutationsLib.CatlikeNimblenessPrimitive)) outputText("90");
				else outputText("80");
			} else outputText("70");
			outputText("% to Spe racial multi, +135% to Int racial multi, +100% to Lib racial multi, +50 min/max Sens)</font>");
		}
		else if (player.hellcatScore() >= 10) {
			outputText("\n<font color=\"#0000a0\">Hellcat: " + player.hellcatScore() + " (+");
			if (player.hasPerk(PerkLib.Flexibility)) {
				if (player.hasPerk(MutationsLib.CatlikeNimblenessEvolved)) outputText("70");
				else if (player.hasPerk(MutationsLib.CatlikeNimblenessPrimitive)) outputText("60");
				else outputText("50");
			} else outputText("40");
			outputText("% to Spe racial multi, +70% to Int racial multi, +40% to Lib racial multi, +25 min/max Sens)</font>");
		}
		else if (player.hellcatScore() >= 1 && player.hellcatScore() < 10) outputText("\n<font color=\"#008000\">Hellcat: " + player.hellcatScore() + "</font>");
		else if (player.hellcatScore() < 1) outputText("\n<font color=\"#ff0000\">Hellcat: 0</font>");
		//Horse
		if (player.horseScore() >= 7) outputText("\n<font color=\"#0000a0\">Horse-morph: " + player.horseScore() + " (+35% to Tou racial multi, +70% to Spe racial multi, +" + (70 * (1 + player.newGamePlusMod())) + " max HP)</font>");
		else if (player.horseScore() >= 1) outputText("\n<font color=\"#008000\">Horse-morph: " + player.horseScore() + "</font>");
		else if (player.horseScore() < 1) outputText("\n<font color=\"#ff0000\">Horse-morph: 0</font>");
		//HUMANITY
		if (player.humanScore() == player.humanMaxScore()) outputText("\n<font color=\"#0000a0\">HUMANITY: " + player.humanMaxScore() + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() == player.humanMaxScore() - 1) outputText("\n<font color=\"#0000a0\">HUMANITY: " + (player.humanMaxScore() - 1) + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() == player.humanMaxScore() - 2) outputText("\n<font color=\"#0000a0\">HUMANITY: " + (player.humanMaxScore() - 2) + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() == player.humanMaxScore() - 3) outputText("\n<font color=\"#0000a0\">HUMANITY: " + (player.humanMaxScore() - 3) + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() == player.humanMaxScore() - 4) outputText("\n<font color=\"#0000a0\">HUMANITY: " + (player.humanMaxScore() - 4) + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() == player.humanMaxScore() - 5) outputText("\n<font color=\"#0000a0\">HUMANITY: " + (player.humanMaxScore() - 5) + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() == player.humanMaxScore() - 6) outputText("\n<font color=\"#0000a0\">HUMANITY: " + (player.humanMaxScore() - 6) + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() == player.humanMaxScore() - 7) outputText("\n<font color=\"#0000a0\">HUMANITY: " + (player.humanMaxScore() - 7) + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() == player.humanMaxScore() - 8) outputText("\n<font color=\"#0000a0\">HUMANITY: " + (player.humanMaxScore() - 8) + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() == player.humanMaxScore() - 9) outputText("\n<font color=\"#0000a0\">HUMANITY: " + (player.humanMaxScore() - 9) + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() < player.humanMaxScore() - 9) outputText("\n<font color=\"#008000\">HUMANITY: " + player.humanScore() + "</font>");
		//Hydra
		if (player.hydraScore() >= 14) {
			if (player.lowerBody == LowerBody.HYDRA) {
				if (player.hydraScore() >= 29) outputText("\n<font color=\"#0000a0\">Legendary Hydra: " + player.hydraScore() + " (+"+(player.isNaga() ? "175":"160")+"% to Str racial multi, +145% to Tou racial multi, +"+(player.isNaga() ? "145":"130")+"% to Spe racial multi)</font>");
				else if (player.hydraScore() >= 24) outputText("\n<font color=\"#0000a0\">Ancient Hydra: " + player.hydraScore() + " (+"+(player.isNaga() ? "145":"130")+"% to Str racial multi, +125% to Tou racial multi, +"+(player.isNaga() ? "120":"105")+"% to Spe racial multi)</font>");
				else if (player.hydraScore() >= 19) outputText("\n<font color=\"#0000a0\">Greater Hydra: " + player.hydraScore() + " (+"+(player.isNaga() ? "135":"120")+"% to Str racial multi, +105% to Tou racial multi, +"+(player.isNaga() ? "75":"60")+"% to Spe racial multi)</font>");
				else outputText("\n<font color=\"#0000a0\">Hydra: " + player.hydraScore() + " (+"+(player.isNaga() ? "115":"100")+"% to Str racial multi, +50% to Tou racial multi, +"+(player.isNaga() ? "75":"60")+"% to Spe racial multi)</font>");
			} else outputText("\n<font color=\"#008000\">Hydra: " + player.hydraScore() + "</font>");
		}
		else if (player.hydraScore() >= 1) outputText("\n<font color=\"#008000\">Hydra: " + player.hydraScore() + "</font>");
		else if (player.hydraScore() < 1) outputText("\n<font color=\"#ff0000\">Hydra: 0</font>");
		//INTERNAL CHIMERICAL DISPOSITION
		if (player.internalChimeraScore() >= 1) {
            outputText("\n<font color=\"#0000a0\">INTERNAL CHIMERICAL DISPOSITION: (" + player.internalChimeraRating() + ") " + player.internalChimeraScore())
            if (player.hasPerk(PerkLib.RacialParagon)) outputText(" - no buffs because of the Racial Paragon perk</font>");
            else outputText(" (+" + (5 * player.internalChimeraScore()) + "% to Str racial multi / Tou / Spe / Int / Wis / Lib and +" + (5 * player.internalChimeraScore()) + " to Sens)</font>");
        }
		else if (player.internalChimeraScore() < 1) outputText("\nINTERNAL CHIMERICAL DISPOSITION: 0</font>");
		//Jabberwocky
		if (player.jabberwockyScore() >= 30) outputText("\n<font color=\"#0000a0\">Primal Jabberwocky: " + player.jabberwockyScore() + " (+125% to Str racial multi, +95% to Tou racial multi, +100% to Spe racial multi, +40% to Int racial multi, -50% to Wis racial multi, +140% to Lib racial multi)</font>");
		else if (player.jabberwockyScore() >= 25) outputText("\n<font color=\"#0000a0\">Greater Jabberwocky: " + player.jabberwockyScore() + " (+105% to Str racial multi, +80% to Tou racial multi, +90% to Spe racial multi, +40% to Int racial multi, -40% to Wis racial multi, +100% to Lib racial multi)</font>");
		else if (player.jabberwockyScore() >= 20) outputText("\n<font color=\"#0000a0\">Jabberwocky: " + player.jabberwockyScore() + " (+90% to Str racial multi, +70% to Tou racial multi, +80% to Spe racial multi, +30% to Int racial multi, -30% to Wis racial multi, +60% to Lib racial multi)</font>");
		else if (player.jabberwockyScore() >= 10) outputText("\n<font color=\"#0000a0\">Lesser Jabberwocky: " + player.jabberwockyScore() + " (+50% to Str racial multi, +40% to Tou racial multi, +50% to Spe racial multi, +20% to Int racial multi, -20% to Wis racial multi, +10% to Lib racial multi)</font>");
		else if (player.jabberwockyScore() >= 1) outputText("\n<font color=\"#008000\">Lesser Jabberwocky: " + player.jabberwockyScore() + "</font>");
		else if (player.jabberwockyScore() < 1) outputText("\n<font color=\"#ff0000\">Lesser Jabberwocky: 0</font>");
		//Jiangshi
		if (player.jiangshiScore() >= 20) outputText("\n<font color=\"#0000a0\">Jiangshi: " + player.jiangshiScore() + " (+150% to Str racial multi, -90 min Spe, -90 min Int, +130% to Wis racial multi, +200% to Lib racial multi)</font>");
		else if (player.jiangshiScore() < 20) outputText("\n<font color=\"#008000\">Jiangshi: " + player.jiangshiScore() + "</font>");
		//Kamaitachi
		if (player.kamaitachiScore() >= 18) outputText("\n<font color=\"#0000a0\">Greater Kamaitachi: " + player.kamaitachiScore() + " (-35% to Str racial multi, +200% to Spe racial multi, +55% to Int racial multi, +100% to Wis racial multi, +50 sens)</font>");
		else if (player.kamaitachiScore() >= 14) outputText("\n<font color=\"#0000a0\">Kamaitachi: " + player.kamaitachiScore() + " (-20% to Str racial multi, +140% to Spe racial multi, +45% to Int racial multi, +70% to Wis racial multi, +25 sens)</font>");
		else if (player.kamaitachiScore() >= 1) outputText("\n<font color=\"#008000\">Kamaitachi: " + player.kamaitachiScore() + "</font>");
		else if (player.kamaitachiScore() < 1) outputText("\n<font color=\"#ff0000\">Kamaitachi: 0</font>");
		//Kangaroo
		if (player.kangaScore() >= 4) outputText("\n<font color=\"#0000a0\">Kangaroo-morph: " + player.kangaScore() + " (+5% to Tou racial multi, +15% to Spe racial multi)</font>");
		else if (player.kangaScore() >= 1) outputText("\n<font color=\"#008000\">Kangaroo-morph: " + player.kangaScore() + "</font>");
		else if (player.kangaScore() < 1) outputText("\n<font color=\"#ff0000\">Kangaroo-morph: 0</font>");
		//Kitshoo
		//if (player.kitshooScore() >= 6) outputText("\n<font color=\"#0000a0\">Kitshoo: " + player.kitshooScore() + "</font>");
		//else if (player.kitshooScore() >= 1) outputText("\n<font color=\"#008000\">Kitshoo: " + player.kitshooScore() + "</font>");
		//else if (player.kitshooScore() < 1) outputText("\n<font color=\"#ff0000\">Kitshoo: 0</font>");
		//Kitsune
		if (player.kitsuneScore() >= 9 && player.tailType == Tail.FOX && player.tailCount >= 2) {
			if (player.kitsuneScore() >= 16 && player.tailCount == 9) {
				if (player.kitsuneScore() >= 21 && player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) {
					if (player.kitsuneScore() >= 26 && player.tailCount >= 9) outputText("\n<font color=\"#0000a0\">Inari: " + player.kitsuneScore() + " (-50% to Str racial multi, +50% to Spe racial multi, +140% to Int racial multi, +200% to Wis racial multi, +110% to Lib racial multi, +60 to min Sens, +" + (1000 * (1 + player.newGamePlusMod())) + " max Fatigue, +100% max Soulforce)</font>");
					else outputText("\n<font color=\"#0000a0\">Nine Tails Kitsune of Balance: " + player.kitsuneScore() + " (-45% to Str racial multi, +40% to Spe racial multi, +125% to Int racial multi, +160% to Wis racial multi, +80% to Lib racial multi, +45 to min Sens, +" + (500 * (1 + player.newGamePlusMod())) + " max Fatigue, +65% max Soulforce)</font>");
				}
				else outputText("\n<font color=\"#0000a0\">Nine Tails Kitsune: " + player.kitsuneScore() + " (-40% to Str racial multi, +30% to Spe racial multi, +110% to Int racial multi, +125% to Wis racial multi, +45% to Lib racial multi, +30 to min Sens, +" + (300 * (1 + player.newGamePlusMod())) + " max Fatigue, +40% max Soulforce)</font>");
			} else outputText("\n<font color=\"#0000a0\">Kitsune: " + player.kitsuneScore() + " (-35% to Str racial multi, +25% to Spe racial multi, +60% to Int racial multi, +75% to Wis racial multi, +30% to Lib racial multi, +20 to min Sens, +" + (100 * (1 + player.newGamePlusMod())) + " max Fatigue, +20% max Soulforce)</font>");
		}
		else if (player.kitsuneScore() >= 1) outputText("\n<font color=\"#008000\">Kitsune: " + player.kitsuneScore() + "</font>");
		else if (player.kitsuneScore() < 1) outputText("\n<font color=\"#ff0000\">Kitsune: 0</font>");
		//Lizard
		if (player.lizardScore() >= 8) outputText("\n<font color=\"#0000a0\">Lizard-morph: " + player.lizardScore() + " (+70% to Tou racial multi, +50% to Int racial multi, +" + (100 * (1 + player.newGamePlusMod())) + " max Fatigue)</font>");
		else if (player.lizardScore() >= 1) outputText("\n<font color=\"#008000\">Lizard-morph: " + player.lizardScore() + "</font>");
		else if (player.lizardScore() < 1) outputText("\n<font color=\"#ff0000\">Lizard-morph: 0</font>");
		//Magma Goo
		if (player.magmagooScore() >= 17) outputText("\n<font color=\"#0000a0\">Magma Slime Queen: " + player.magmagooScore() + " (+45% to Str racial multi, +115% to Tou racial multi, -50% to Spe racial multi, +145% to Lib racial multi)</font>");
		else if (player.magmagooScore() >= 13) outputText("\n<font color=\"#0000a0\">Magma Slime: " + player.magmagooScore() + " (+35% to Str racial multi, +100% to Tou racial multi, -40% to Spe racial multi, +100% to Lib racial multi)</font>");
		else if (player.magmagooScore() >= 1) outputText("\n<font color=\"#008000\">Magma Slime: " + player.magmagooScore() + "</font>");
		else if (player.magmagooScore() < 1) outputText("\n<font color=\"#ff0000\">Magma Slime: 0</font>");
		//Manticore
		if (player.manticoreScore() >= 22) outputText("\n<font color=\"#0000a0\">True Manticore: " + player.manticoreScore() + " (+160% to Spe racial multi, +90% to Int racial multi, +140% to Lib racial multi, +60 min Sens, +" + (150 * (1 + player.newGamePlusMod())) + " max HP)</font>");
		else if (player.manticoreScore() >= 15) outputText("\n<font color=\"#0000a0\">Manticore: " + player.manticoreScore() + " (+110% to Spe racial multi, +70% to Int racial multi, +90% to Lib racial multi, +45 min Sens, +" + (75 * (1 + player.newGamePlusMod())) + " max HP)</font>");
		else if (player.manticoreScore() >= 1) outputText("\n<font color=\"#008000\">Manticore: " + player.manticoreScore() + "</font>");
		else if (player.manticoreScore() < 1) outputText("\n<font color=\"#ff0000\">Manticore: 0</font>");
		//Mantis
		if (player.mantisScore() >= 12) {
			outputText("\n<font color=\"#0000a0\">Mantis-morph: " + player.mantisScore() + " (-40% to Str racial multi, +60% to Tou racial multi, +");
			if (player.hasPerk(MutationsLib.MantislikeAgilityEvolved)) {
				if (player.hasCoatOfType(Skin.CHITIN) && player.hasPerk(PerkLib.ThickSkin)) outputText("185");
				else if ((player.skinType == Skin.SCALES && player.hasPerk(PerkLib.ThickSkin)) || player.hasCoatOfType(Skin.CHITIN)) outputText("170");
				else if (player.skinType == Skin.SCALES || player.hasPerk(PerkLib.ThickSkin)) outputText("155");
				else outputText("140");
			} else if (player.hasPerk(MutationsLib.MantislikeAgilityPrimitive)) {
				if (player.hasCoatOfType(Skin.CHITIN) && player.hasPerk(PerkLib.ThickSkin)) outputText("170");
				else if ((player.skinType == Skin.SCALES && player.hasPerk(PerkLib.ThickSkin)) || player.hasCoatOfType(Skin.CHITIN)) outputText("160");
				else if (player.skinType == Skin.SCALES || player.hasPerk(PerkLib.ThickSkin)) outputText("150");
				else outputText("140");
			} else if (player.hasPerk(MutationsLib.MantislikeAgility)) {
				if (player.hasCoatOfType(Skin.CHITIN) && player.hasPerk(PerkLib.ThickSkin)) outputText("155");
				else if ((player.skinType == Skin.SCALES && player.hasPerk(PerkLib.ThickSkin)) || player.hasCoatOfType(Skin.CHITIN)) outputText("150");
				else if (player.skinType == Skin.SCALES || player.hasPerk(PerkLib.ThickSkin)) outputText("145");
				else outputText("140");
			} else outputText("140");
			outputText("% to Spe racial multi, +20% to Int racial multi)</font>");
		}
		else if (player.mantisScore() >= 1) outputText("\n<font color=\"#008000\">Mantis-morph: " + player.mantisScore() + "</font>");
		else if (player.mantisScore() < 1) outputText("\n<font color=\"#ff0000\">Mantis-morph: 0</font>");
		//Melkie
		if (player.melkieScore() >= 21) outputText("\n<font color=\"#0000a0\">Elder Melkie: " + player.melkieScore() + " (+140% to Spe / Int racial multi, +100% to Lib racial multi, +65 min Sens)</font>");
		else if (player.melkieScore() >= 18) outputText("\n<font color=\"#0000a0\">Melkie: " + player.melkieScore() + " (+120% to Spe / Int racial multi, +80% to Lib racial multi, +50 min Sens)</font>");
		else if (player.melkieScore() >= 1) outputText("\n<font color=\"#008000\">Melkie: " + player.melkieScore() + "</font>");
		else if (player.melkieScore() < 1) outputText("\n<font color=\"#ff0000\">Melkie: 0</font>");
		//Male Mindbreaker
		if (player.maleMindbreakerScore() >= 20) outputText("\n<font color=\"#0000a0\">Male Mindbreaker: " + player.maleMindbreakerScore() + " (+70% to Str racial multi, -40% to Spe racial multi, +100% to tou racial multi, +450% to int racial multi, +400% to lib racial multi, -30% to Wis racial multi, +50 Sens)</font>");
		else if (player.maleMindbreakerScore() >= 1) outputText("\n<font color=\"#008000\">Male Mindbreaker: " + player.maleMindbreakerScore() + "</font>");
		else if (player.maleMindbreakerScore() < 1) outputText("\n<font color=\"#ff0000\">Male Mindbreaker: 0</font>");
		//Female Mindbreaker
		if (player.femaleMindbreakerScore() >= 20) outputText("\n<font color=\"#0000a0\">Female Mindbreaker: " + player.femaleMindbreakerScore() + " (-60% to Str racial multi, -10% to Spe racial multi, +100% to tou racial multi, +550% to int racial multi, +400% to lib racial multi, -30% to Wis racial multi, +50 Sens)</font>");
		else if (player.femaleMindbreakerScore() >= 1) outputText("\n<font color=\"#008000\">Female Mindbreaker: " + player.femaleMindbreakerScore() + "</font>");
		else if (player.femaleMindbreakerScore() < 1) outputText("\n<font color=\"#ff0000\">Female Mindbreaker: 0</font>");
		//Minotaur
		if (player.minotaurScore() >= 15) outputText("\n<font color=\"#0000a0\">Minotaur: " + player.minotaurScore() + " (+170% to Str racial multi, +45% to Tou racial multi, -20% to Spe racial multi, -40% to Int racial multi, +70% to Lib racial multi, +" + (50 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.minotaurScore() >= 10) outputText("\n<font color=\"#0000a0\">Bull-morph: " + player.minotaurScore() + " (+120% to Str racial multi, +45% to Tou racial multi, -20% to Spe racial multi, -40% to Int racial multi, +45% to Lib racial multi, +" + (50 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.minotaurScore() >= 1) outputText("\n<font color=\"#008000\">Bull-morph: " + player.minotaurScore() + "</font>");
		else if (player.minotaurScore() < 1) outputText("\n<font color=\"#ff0000\">Bull-morph: 0</font>");
		//Mouse & Hinezumi
		if (player.mouseScore() >= 8) {
			if (player.mouseScore() >= 15 && player.arms.type == Arms.HINEZUMI && player.lowerBody == LowerBody.HINEZUMI) outputText("\n<font color=\"#0000a0\">Hinezumi: " + player.mouseScore() + " (+75% to Str racial multi, -10% to Tou racial multi, +80% to Spe racial multi, +80% to Wis racial multi)</font>");
			else if (player.mouseScore() >= 12 && player.arms.type == Arms.HINEZUMI && player.lowerBody == LowerBody.HINEZUMI) outputText("\n<font color=\"#0000a0\">Hinezumi: " + player.mouseScore() + " (+60% to Str racial multi, -10% to Tou racial multi, +80% to Spe racial multi, +50% to Wis racial multi)</font>");
			else outputText("\n<font color=\"#0000a0\">Mouse-morph: " + player.mouseScore() + " (-10% to Tou racial multi, +80% to Spe racial multi, +50% to Wis racial multi)</font>");
		}
		else if (player.mouseScore() >= 1) outputText("\n<font color=\"#008000\">Mouse-morph: " + player.mouseScore() + "</font>");
		else if (player.mouseScore() < 1) outputText("\n<font color=\"#ff0000\">Mouse-morph: 0</font>");
		//Naga
		if (player.nagaScore() >= 8) outputText("\n<font color=\"#0000a0\">Naga: " + player.nagaScore() + " (+"+(player.isNaga() ? "55":"40")+"% to Str racial multi, +20% to Tou racial multi, +"+(player.isNaga() ? "75":"60")+"% to Spe racial multi)</font>");
		else if (player.nagaScore() >= 1) outputText("\n<font color=\"#008000\">Naga: " + player.nagaScore() + "</font>");
		else if (player.nagaScore() < 1) outputText("\n<font color=\"#ff0000\">Naga: 0</font>");
		//Nekomata
		if (player.nekomataScore() >= 10) {
			if (player.tailType == 8 && player.tailCount >= 2 && player.nekomataScore() >= 12) outputText("\n<font color=\"#0000a0\">Elder Nekomata: " + player.nekomataScore() + " (+");
			else outputText("\n<font color=\"#0000a0\">Nekomata: " + player.nekomataScore() + " (+");
			outputText(""+(player.hasPerk(PerkLib.Flexibility) ? "40":"50")+"");
			if (player.tailType == 8 && player.tailCount >= 2 && player.nekomataScore() >= 12) outputText("% to Spe racial multi, +40% to Int racial multi, +100% to Wis racial multi, +20% max Soulforce)</font>");
			else outputText("% to Spe racial multi, +30% to Int racial multi, +80% to Wis racial multi, +10% max Soulforce)</font>");
		}
		else if (player.nekomataScore() >= 1) outputText("\n<font color=\"#008000\">Nekomata: " + player.nekomataScore() + "</font>");
		else if (player.nekomataScore() < 1) outputText("\n<font color=\"#ff0000\">Nekomata: 0</font>");
		//Oni
		if (player.oniScore() >= 18) outputText("\n<font color=\"#0000a0\">Elder Oni: " + player.oniScore() + " (+150% to Str racial multi, +90% to Tou racial multi, -30% to Int racial multi, +60% to Wis racial multi)</font>");
		else if (player.oniScore() >= 12) outputText("\n<font color=\"#0000a0\">Oni: " + player.oniScore() + " (+100% to Str racial multi, +60% to Tou racial multi, -20% to Int racial multi, +40% to Wis racial multi)</font>");
		else if (player.oniScore() >= 1) outputText("\n<font color=\"#008000\">Oni: " + player.oniScore() + "</font>");
		else if (player.oniScore() < 1) outputText("\n<font color=\"#ff0000\">Oni: 0</font>");
		//Oomukade
		if (player.oomukadeScore() >= 18) outputText("\n<font color=\"#0000a0\">Elder Oomukade: " + player.oomukadeScore() + " (+125% to Str racial multi, +45% to Tou racial multi, +60% to Spe racial multi, +110% to Lib racial multi, -50% to Wis racial multi)</font>");
		if (player.oomukadeScore() >= 15) outputText("\n<font color=\"#0000a0\">Oomukade: " + player.oomukadeScore() + " (+75% to Str racial multi, +40% to Tou racial multi, +50% to Spe racial multi, +110% to Lib racial multi, -50% to Wis racial multi)</font>");
		else if (player.oomukadeScore() >= 1) outputText("\n<font color=\"#008000\">Oomukade: " + player.oomukadeScore() + "</font>");
		else if (player.oomukadeScore() < 1) outputText("\n<font color=\"#ff0000\">Oomukade: 0</font>");
		//Orc
		/*if (player.orcScore() >= 11) outputText("\n<font color=\"#0000a0\">High Orc: " + player.orcScore() + " (+130% to Str racial multi, +30% to Tou racial multi, +10% to Spe racial multi, -30% to Int racial multi, +25% to Lib racial multi, +20% max Wrath)</font>");
 		else */
		if (player.orcScore() >= 11) outputText("\n<font color=\"#0000a0\">Orc: " + player.orcScore() + " (+130% to Str racial multi, +30% to Tou racial multi, +10% to Spe racial multi, -30% to Int racial multi, +25% to Lib racial multi, +20% max Wrath)</font>");
		else if (player.orcScore() >= 1) outputText("\n<font color=\"#008000\">Orc: " + player.orcScore() + "</font>");
		else if (player.orcScore() < 1) outputText("\n<font color=\"#ff0000\">Orc: 0</font>");
		//Orca
		if (player.orcaScore() >= 20) outputText("\n<font color=\"#0000a0\">Great Orca-boy/girl: " + player.orcaScore() + " (+140% to Str racial multi, +70% to Tou racial multi, +100% to Spe racial multi)</font>");
		else if (player.orcaScore() >= 14) outputText("\n<font color=\"#0000a0\">Orca-boy/girl: " + player.orcaScore() + " (+100% to Str racial multi, +40% to Tou racial multi, +70% to Spe racial multi)</font>");
		else if (player.orcaScore() >= 1) outputText("\n<font color=\"#008000\">Orca-boy/girl: " + player.orcaScore() + "</font>");
		else if (player.orcaScore() < 1) outputText("\n<font color=\"#ff0000\">Orca-boy/girl: 0</font>");
		//Peacock
		outputText("\nPeacock: " + player.peacockScore());
		//Phantom > Poltergeist
		if (player.poltergeistScore() >= 18) outputText("\n<font color=\"#0000a0\">Eldritch Poltergeist: " + player.poltergeistScore() + " (-45% to Str racial multi, -45% to Tou racial multi, +150% to Spe racial multi, +150% to Int racial multi, +60% to Wis racial multi)</font>");
		else if (player.poltergeistScore() >= 12) outputText("\n<font color=\"#0000a0\">Poltergeist: " + player.poltergeistScore() + " (-25% to Str racial multi, -25% to Tou racial multi, +90% to Spe racial multi, +90% to Int racial multi, +45% to Wis racial multi)</font>");
		else if (player.poltergeistScore() >= 6) outputText("\n<font color=\"#0000a0\">Phantom: " + player.poltergeistScore() + " (-15% to Str racial multi, -15% to Tou racial multi, +45% to Spe racial multi, +45% to Int racial multi, +30% to Wis racial multi)</font>");
		else if (player.poltergeistScore() >= 1) outputText("\n<font color=\"#008000\">Phantom: " + player.poltergeistScore() + "</font>");
		else if (player.poltergeistScore() < 1) outputText("\n<font color=\"#ff0000\">Phantom: 0</font>");
		//Phoenix
		if (player.phoenixScore() >= 21) outputText("\n<font color=\"#0000a0\">Greater Phoenix: " + player.phoenixScore() + " (+40% to Str racial multi, +20% to Tou racial multi, +150% to Spe racial multi, +105% to Lib racial multi, +" + (25 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.phoenixScore() >= 10) outputText("\n<font color=\"#0000a0\">Phoenix: " + player.phoenixScore() + " (+20% to Str racial multi, +20% to Tou racial multi, +70% to Spe racial multi, +40% to Lib racial multi, +" + (25 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.phoenixScore() >= 1) outputText("\n<font color=\"#008000\">Phoenix: " + player.phoenixScore() + "</font>");
		else if (player.phoenixScore() < 1) outputText("\n<font color=\"#ff0000\">Phoenix: 0</font>");
		//Pig
		if (player.pigScore() >= 15) outputText("\n<font color=\"#0000a0\">Boar-morph: " + player.pigScore() + " (+125% to Str racial multi, +125% to Tou racial multi, -15% to Spe racial multi, -10% to Int racial multi)</font>");
		else if (player.pigScore() >= 10) outputText("\n<font color=\"#0000a0\">Pig-morph: " + player.pigScore() + " (+60% to Str racial multi, +120% to Tou racial multi, -15% to Spe racial multi, -10% to Int racial multi, -5% to Wis racial multi)</font>");
		else if (player.pigScore() >= 1) outputText("\n<font color=\"#008000\">Pig-morph: " + player.pigScore() + "</font>");
		else if (player.pigScore() < 1) outputText("\n<font color=\"#ff0000\">Pig-morph: 0</font>");
		//Treant/Dryad
		if (player.plantScore() >= 7) outputText("\n<font color=\"#0000a0\">Treant/Dryad: " + player.plantScore() + " (+25% to Str racial multi, +100% to Tou racial multi, -50% to Spe racial multi, +" + (10 * (1 + player.newGamePlusMod())) + " Armor)</font>");
		else if (player.plantScore() >= 6) outputText("\n<font color=\"#0000a0\">Treant/Dryad: " + player.plantScore() + " (+20% to Str racial multi, +80% to Tou racial multi, -40% to Spe racial multi, +" + (8 * (1 + player.newGamePlusMod())) + " Armor)</font>");
		else if (player.plantScore() >= 5) outputText("\n<font color=\"#0000a0\">Plant-morph: " + player.plantScore() + " (+10% to Str racial multi, +50% to Tou racial multi, -20% to Spe racial multi, +" + (4 * (1 + player.newGamePlusMod())) + " Armor)</font>");
		else if (player.plantScore() >= 4) outputText("\n<font color=\"#0000a0\">Plant-morph: " + player.plantScore() + " (+30% to Tou racial multi, -10% to Spe racial multi, +" + (2 * (1 + player.newGamePlusMod())) + " Armor)</font>");
		else if (player.plantScore() >= 1) outputText("\n<font color=\"#008000\">Plant-morph: " + player.plantScore() + "</font>");
		else if (player.plantScore() < 1) outputText("\n<font color=\"#ff0000\">Plant-morph: 0</font>");
		//Raccon
		if (player.raccoonScore() >= 17 && player.balls > 0 && player.ballSize > 5) outputText("\n<font color=\"#0000a0\">Greater Tanuki: " + player.raccoonScore() + " (+105% to Spe racial multi, +150% to Int racial multi)</font>");
		else if (player.raccoonScore() >= 14 && player.balls > 0 && player.ballSize > 5) outputText("\n<font color=\"#0000a0\">Tanuki: " + player.raccoonScore() + " (+90% to Spe racial multi, +120% to Int racial multi)</font>");
		else if (player.raccoonScore() >= 8) outputText("\n<font color=\"#0000a0\">Raccoon-morph: " + player.raccoonScore() + " (+90% to Spe racial multi, +30% to Int racial multi)</font>");
		else if (player.raccoonScore() >= 1) outputText("\n<font color=\"#008000\">Raccoon-morph: " + player.raccoonScore() + "</font>");
		else if (player.raccoonScore() < 1) outputText("\n<font color=\"#ff0000\">Raccoon-morph: 0</font>");
		//Raiju
		if (player.raijuScore() >= 20) outputText("\n<font color=\"#0000a0\">Greater Raiju: " + player.raijuScore() + " (+150% to Spe racial multi, +50% to Int racial multi, +160% to Lib racial multi, +60 min Sens)</font>");
		else if (player.raijuScore() >= 10) outputText("\n<font color=\"#0000a0\">Raiju: " + player.raijuScore() + " (+70% to Spe racial multi, +50% to Int racial multi, +80% to Lib racial multi, +50 min Sens)</font>");
		else if (player.raijuScore() >= 1) outputText("\n<font color=\"#008000\">Raiju: " + player.raijuScore() + "</font>");
		else if (player.raijuScore() < 1) outputText("\n<font color=\"#ff0000\">Raiju: 0</font>");
		//Ratatoskr
		if (player.ratatoskrScore() >= 18) outputText("\n<font color=\"#0000a0\">Ratatoskr: " + player.ratatoskrScore() + " (-25% to Str racial multi, +140% to Spe racial multi, +155% to Int racial multi)</font>");
		else if (player.ratatoskrScore() >= 12) outputText("\n<font color=\"#0000a0\">Squirrel morph: " + player.ratatoskrScore() + " (-20% to Str racial multi, +95% to Spe racial multi, +105% to Int racial multi)</font>");
		else if (player.ratatoskrScore() >= 1) outputText("\n<font color=\"#008000\">Squirrel morph: " + player.ratatoskrScore() + "</font>");
		else if (player.ratatoskrScore() < 1) outputText("\n<font color=\"#ff0000\">Squirrel morph: 0</font>");
		//Red Panda
		if (player.redpandaScore() >= 8) outputText("\n<font color=\"#0000a0\">Red Panda-morph: " + player.redpandaScore() + " (+15% to Str racial multi, +75% to Spe racial multi, +30% to Int racial multi)</font>");
		else if (player.redpandaScore() >= 1) outputText("\n<font color=\"#008000\">Red Panda-morph: " + player.redpandaScore() + "</font>");
		else if (player.redpandaScore() < 1) outputText("\n<font color=\"#ff0000\">Red Panda-morph: 0</font>");
		//Rhino
		if (player.rhinoScore() >= 4) outputText("\n<font color=\"#0000a0\">Rhino-morph: " + player.rhinoScore() + " (+15% to Str racial multi, +15% to Tou racial multi, -10% to Spe racial multi, -10% to Int racial multi, +" + (100 * (1 + player.newGamePlusMod())) + " max HP)</font>");
		else if (player.rhinoScore() >= 1) outputText("\n<font color=\"#008000\">Rhino-morph: " + player.rhinoScore() + "</font>");
		else if (player.rhinoScore() < 1) outputText("\n<font color=\"#ff0000\">Rhino-morph: 0</font>");
		//Salamander
		if (player.salamanderScore() >= 16) outputText("\n<font color=\"#0000a0\">Primordial Salamander: " + player.salamanderScore() + " (+105% to Str racial multi, +80% to Tou racial multi, +130% to Lib racial multi, +75 min sens, +" + (25 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.salamanderScore() >= 7) outputText("\n<font color=\"#0000a0\">Salamander: " + player.salamanderScore() + " (+25% to Str racial multi, +25% to Tou racial multi, +40% to Lib racial multi, +" + (25 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.salamanderScore() >= 1) outputText("\n<font color=\"#008000\">Salamander: " + player.salamanderScore() + "</font>");
		else if (player.salamanderScore() < 1) outputText("\n<font color=\"#ff0000\">Salamander: 0</font>");
		//Satyr
		if (player.satyrScore() >= 4) outputText("\n<font color=\"#0000a0\">Satyr: " + player.satyrScore() + " (+5% to Str racial multi, +5% to Spe racial multi)</font>");
		else if (player.satyrScore() >= 1) outputText("\n<font color=\"#008000\">Satyr: " + player.satyrScore() + "</font>");
		else if (player.satyrScore() < 1) outputText("\n<font color=\"#ff0000\">Satyr: 0</font>");/*
		//Scorpion
		if (player.scorpionScore() >= ) outputText("\n<font color=\"#0000a0\">Half Scorpion-morph: " + player.scorpionScore() + "</font>");
		else if (player.scorpionScore() >= 1) outputText("\n<font color=\"#008000\">Half Scorpion-morph: " + player.scorpionScore() + "</font>");
		else if (player.scorpionScore() < 1) outputText("\n<font color=\"#ff0000\">Half Scorpion-morph: 0</font>");*/
		outputText("\nScorpion-morph: " + player.scorpionScore());
		//Scylla
		var scyllakrakengland:Number = 0;
		if (player.hasPerk(MutationsLib.ScyllaInkGlands)) scyllakrakengland += 10;
		if (player.scyllaScore() >= 12 && player.isKraken()) {
			if (player.scyllaScore() >= 17) outputText("\n<font color=\"#0000a0\">Elder Kraken: " + player.scyllaScore() + " (+"+(195+scyllakrakengland)+"% to Str racial multi, +60% to Tou racial multi, +60% to Int racial multi, +15 min sens, +" + (150 * (1 + player.newGamePlusMod())) + " max HP)</font>");
			else outputText("\n<font color=\"#0000a0\">Kraken: " + player.scyllaScore() + " (+"+(180+scyllakrakengland)+"% to Str racial multi, +60% to Int racial multi, +15 min sens, +" + (150 * (1 + player.newGamePlusMod())) + " max HP)</font>");
		}
		else if (player.scyllaScore() >= 7 && player.isScylla()) outputText("\n<font color=\"#0000a0\">Scylla: " + player.scyllaScore() + " (+"+(95+scyllakrakengland)+"% to Str racial multi, +40% to Int racial multi, +" + (50 * (1 + player.newGamePlusMod())) + " max HP)</font>");
		else if (player.scyllaScore() >= 1) outputText("\n<font color=\"#008000\">Scylla: " + player.scyllaScore() + "</font>");
		else if (player.scyllaScore() < 1) outputText("\n<font color=\"#ff0000\">Scylla: 0</font>");
		//Sea dragon
		if (player.leviathanScore() >= 30) outputText("\n<font color=\"#0000a0\">Leviathan-boy/girl: " + player.leviathanScore() + " (+200% to Str racial multi, +100% to Tou racial multi, +100% to Spe racial multi, +50% to Int racial multi, +" + (5 * (1 + player.newGamePlusMod())) + " Armor / Magic Resistance)</font>");
		else if (player.leviathanScore() >= 20) outputText("\n<font color=\"#0000a0\">Sea dragon-boy/girl: " + player.leviathanScore() + " (+110% to Str racial multi, +70% to Tou racial multi, +70% to Spe racial multi, +50% to Int racial multi, +" + (1 * (1 + player.newGamePlusMod())) + " Armor / Magic Resistance)</font>");
		else if (player.leviathanScore() >= 1) outputText("\n<font color=\"#008000\">Sea dragon-boy/girl: " + player.leviathanScore() + "</font>");
		else if (player.leviathanScore() < 1) outputText("\n<font color=\"#ff0000\">Sea dragon-boy/girl: 0</font>");
		//Shark
		if (player.sharkScore() >= 11 && player.vaginas.length > 0 && player.cocks.length > 0) outputText("\n<font color=\"#0000a0\">Tigershark-morph: " + player.sharkScore() + " (+60% to Str racial multi, +100% to Spe racial multi, +20% to Lib racial multi, +" + (50 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.sharkScore() >= 10) outputText("\n<font color=\"#0000a0\">Shark-morph: " + player.sharkScore() + " (+40% to Str racial multi, +100% to Spe racial multi, +10% to Lib racial multi)</font>");
		else if (player.sharkScore() >= 1) outputText("\n<font color=\"#008000\">Shark-morph: " + player.sharkScore() + "</font>");
		else if (player.sharkScore() < 1) outputText("\n<font color=\"#ff0000\">Shark-morph: 0</font>");
		//Siren
		if (player.sirenScore() >= 20) outputText("\n<font color=\"#0000a0\">Greater Siren: " + player.sirenScore() + " (+80% to Str racial multi, +120% to Spe racial multi, +100% to Lib racial multi)</font>");
		else if (player.sirenScore() >= 10) outputText("\n<font color=\"#0000a0\">Siren: " + player.sirenScore() + " (+50% to Str racial multi, +70% to Spe racial multi, +30% to Lib racial multi)</font>");
		else if (player.sirenScore() >= 1) outputText("\n<font color=\"#008000\">Siren: " + player.sirenScore() + "</font>");
		else if (player.sirenScore() < 1) outputText("\n<font color=\"#ff0000\">Siren: 0</font>");
		//Sphinx
		if (player.sphinxScore() >= 30) outputText("\n<font color=\"#0000a0\">Noble Sphinx: " + player.sphinxScore() + " (+110% to Str racial multi, -20% to Tou racial multi, +"+(player.hasPerk(PerkLib.Flexibility) ? "70":"60")+"% to Spe racial multi, +150% to Int racial multi, +150% to Wis racial multi)</font>");
		else if (player.sphinxScore() >= 21) outputText("\n<font color=\"#0000a0\">Elder Sphinx: " + player.sphinxScore() + " (+90% to Str racial multi, -20% to Tou racial multi, +"+(player.hasPerk(PerkLib.Flexibility) ? "60":"50")+"% to Spe racial multi, +100% to Int racial multi, +95% to Wis racial multi)</font>");
		else if (player.sphinxScore() >= 14) outputText("\n<font color=\"#0000a0\">Sphinx: " + player.sphinxScore() + " (+50% to Str racial multi, -10% to Tou racial multi, +"+(player.hasPerk(PerkLib.Flexibility) ? "50":"40")+"% to Spe racial multi, +90% to Int racial multi, +40% to Wis racial multi)</font>");
		else if (player.sphinxScore() >= 1) outputText("\n<font color=\"#008000\">Sphinx: " + player.sphinxScore() + "</font>");
		else if (player.sphinxScore() < 1) outputText("\n<font color=\"#ff0000\">Sphinx: 0</font>");
		//Spider
		if (player.spiderScore() >= 7) outputText("\n<font color=\"#0000a0\">Spider-morph: " + player.spiderScore() + " (-20% to Str racial multi, +50% to Tou racial multi, +75% to Int racial multi)</font>");
		else if (player.spiderScore() >= 1) outputText("\n<font color=\"#008000\">Spider-morph: " + player.spiderScore() + "</font>");
		else if (player.spiderScore() < 1) outputText("\n<font color=\"#ff0000\">Spider-morph: 0</font>");
		//Thunderbird
		if (player.thunderbirdScore() >= 21) outputText("\n<font color=\"#0000a0\">Greater Thunderbird: " + player.thunderbirdScore() + " (-25% to Tou racial multi, +155% to Spe racial multi, +185% to Lib racial multi)</font>");
		else if (player.thunderbirdScore() >= 16) outputText("\n<font color=\"#0000a0\">Thunderbird: " + player.thunderbirdScore() + " (-15% to Tou racial multi, +120% to Spe racial multi, +140% to Lib racial multi)</font>");
		else if (player.thunderbirdScore() >= 1) outputText("\n<font color=\"#008000\">Thunderbird: " + player.thunderbirdScore() + "</font>");
		else if (player.thunderbirdScore() < 1) outputText("\n<font color=\"#ff0000\">Thunderbird: 0</font>");
		//Troll
		if (player.trollScore() >= 10) outputText("\n<font color=\"#0000a0\">Troll: " + player.trollScore() + " (+30% to Str racial multi, +40% to Spe racial multi, +30% to Int racial multi, +50% to Wis racial multi)</font>");
		else if (player.trollScore() >= 1) outputText("\n<font color=\"#008000\">Troll: " + player.trollScore() + "</font>");
		else if (player.trollScore() < 1) outputText("\n<font color=\"#ff0000\">Troll: 0</font>");
		//Ushi Onna
		if (player.ushionnaScore() >= 11) {
			outputText("\n<font color=\"#0000a0\">");
			if (player.statusEffectv1(StatusEffects.UshiOnnaVariant) == 1) outputText("Fiery Ushi-" + player.mf("oni", "onna") + "");
			else if (player.statusEffectv1(StatusEffects.UshiOnnaVariant) == 2) outputText("Frozen Ushi-" + player.mf("oni", "onna") + "");
			else if (player.statusEffectv1(StatusEffects.UshiOnnaVariant) == 3) outputText("Sandy Ushi-" + player.mf("oni", "onna") + "");
			else if (player.statusEffectv1(StatusEffects.UshiOnnaVariant) == 4) outputText("Pure Ushi-" + player.mf("oni", "onna") + "");
			else if (player.statusEffectv1(StatusEffects.UshiOnnaVariant) == 5) outputText("Wicked Ushi-" + player.mf("oni", "onna") + "");
			else outputText("Ushi-" + player.mf("oni", "onna") + "");
			outputText(": " + player.ushionnaScore() + " (+80% to Str racial multi, +70% to Tou racial multi, -40% to Int racial multi, -40% to Wis racial multi, +95% to Lib racial multi)</font>");
		}
		else if (player.ushionnaScore() >= 1) outputText("\n<font color=\"#008000\">Ushi-Onna: " + player.ushionnaScore() + "</font>");
		else if (player.ushionnaScore() < 1) outputText("\n<font color=\"#ff0000\">Ushi-Onna: 0</font>");
		//Wendigo
		if (player.wendigoScore() >= 25) outputText("\n<font color=\"#0000a0\">Greater Wendigo: " + player.wendigoScore() + " (+70% to Str racial multi, +70% to Tou racial multi, +60% to Int racial multi, -50% to Wis racial multi, +50% to Lib racial multi, +50 min sens)</font>");
		else if (player.wendigoScore() >= 10) outputText("\n<font color=\"#0000a0\">Wendigo: " + player.wendigoScore() + " (+70% to Str racial multi, +70% to Tou racial multi, +60% to Int racial multi, -50% to Wis racial multi, +50% to Lib racial multi, +50 min sens)</font>");
		else if (player.wendigoScore() >= 1) outputText("\n<font color=\"#008000\">Wendigo: " + player.wendigoScore() + "</font>");
		else if (player.wendigoScore() < 1) outputText("\n<font color=\"#ff0000\">Wendigo: 0</font>");
		//Werewolf
		if (player.werewolfScore() >= 12) outputText("\n<font color=\"#0000a0\">Werewolf: " + player.werewolfScore() + " (+100% to Str racial multi, +40% to Tou racial multi, +60% to Spe racial multi, -20% to Int racial multi)</font>");
		else if (player.werewolfScore() >= 1) outputText("\n<font color=\"#008000\">Werewolf: " + player.werewolfScore() + "</font>");
		else if (player.werewolfScore() < 1) outputText("\n<font color=\"#ff0000\">Werewolf: 0</font>");
		//Wolf
		if (player.wolfScore() >= 21) outputText("\n<font color=\"#0000a0\">Fenrir: " + player.wolfScore() + " (+145% to Str racial multi, +80% to Tou racial multi, +100% to Spe racial multi, -10% to Int racial multi)</font>");
		else if (player.wolfScore() >= 10 && player.hasFur() && player.coatColor == "glacial white") outputText("\n<font color=\"#0000a0\">Winter wolf: " + player.wolfScore() + " (+65% to Str racial multi, +40% to Tou racial multi, +55% to Spe racial multi, -10% to Int racial multi)</font>");
		else if (player.wolfScore() >= 8) outputText("\n<font color=\"#0000a0\">Wolf-morph: " + player.wolfScore() + " (+50% to Str racial multi, +30% to Tou racial multi, +50% to Spe racial multi, -10% to Int racial multi)</font>");
		else if (player.wolfScore() >= 1) outputText("\n<font color=\"#008000\">Wolf-morph: " + player.wolfScore() + "</font>");
		else if (player.wolfScore() < 1) outputText("\n<font color=\"#ff0000\">Wolf-morph: 0</font>");
		//Unicorn
		if (player.unicornScore() >= 27) outputText("\n<font color=\"#0000a0\">True Unicorn/True Bicorn: " + player.unicornScore() + " (+60% to Str racial multi, +90% to Tou racial multi, +115% to Spe racial multi, +140% to Int racial multi)</font>");
		else if (player.unicornScore() >= 18) outputText("\n<font color=\"#0000a0\">Unicorn/Bicorn: " + player.unicornScore() + " (+55% to Tou racial multi, +90% to Spe racial multi, +125% to Int racial multi)</font>");
		else if (player.unicornScore() >= 8) outputText("\n<font color=\"#0000a0\">Half Unicorn/Half Bicorn: " + player.unicornScore() + " (+25% to Tou racial multi, +40% to Spe racial multi, +55% to Int racial multi)</font>");
		else if (player.unicornScore() >= 1) outputText("\n<font color=\"#008000\">Unicorn/Bicorn: " + player.unicornScore() + "</font>");
		else if (player.unicornScore() < 1) outputText("\n<font color=\"#ff0000\">Unicorn/Bicorn: 0</font>");
		//UnicornKin
		if (player.unicornkinScore() >= 12) outputText("\n<font color=\"#0000a0\">Unicornkin/Bicornkin: " + player.unicornkinScore() + " (+55% to Tou racial multi, +70% to Spe racial multi, +85% to Int racial multi)</font>");
		else if (player.unicornkinScore() >= 1) outputText("\n<font color=\"#008000\">Unicorn/Bicorn: " + player.unicornkinScore() + "</font>");
		else if (player.unicornkinScore() < 1) outputText("\n<font color=\"#ff0000\">Unicornkin/Bicornkin: 0</font>");
		//Vampire
		if (player.vampireScore() >= 20) outputText("\n<font color=\"#0000a0\">Pureblood Vampire: " + player.vampireScore() + " (+70% to Str racial multi, +70% to Spe racial multi, +70% to Int racial multi, +90% to Lib racial multi)</font>");
		else if (player.vampireScore() >= 10) outputText("\n<font color=\"#0000a0\">Vampire: " + player.vampireScore() + " (+35% to Str racial multi, +35% to Spe racial multi, +35% to Int racial multi, +45% to Lib racial multi)</font>");
		else if (player.vampireScore() >= 1) outputText("\n<font color=\"#008000\">Vampire: " + player.vampireScore() + "</font>");
		else if (player.vampireScore() < 1) outputText("\n<font color=\"#ff0000\">Vampire: 0</font>");
		//Vouivre
		if (player.vouivreScore() >= 21) outputText("\n<font color=\"#0000a0\">Greater Vouivre: " + player.vouivreScore() + " (+"+(player.isNaga() ? "145":"130")+"% to Str racial multi, +95% to Tou racial multi, +"+(player.isNaga() ? "115":"100")+"% to Spe racial multi, +20% to Int racial multi, -20% to Wis racial multi)</font>");//, +" + (50 * (1 + player.newGamePlusMod())) + " max HP
		else if (player.vouivreScore() >= 16) outputText("\n<font color=\"#0000a0\">Vouivre: " + player.vouivreScore() + " (+"+(player.isNaga() ? "115":"100")+"% to Str racial multi, +65% to Tou racial multi, +"+(player.isNaga() ? "85":"70")+"% to Spe racial multi, +15% to Int racial multi, -15% to Wis racial multi)</font>");//, +" + (50 * (1 + player.newGamePlusMod())) + " max HP
		else if (player.vouivreScore() >= 11) outputText("\n<font color=\"#0000a0\">Lesser Vouivre: " + player.vouivreScore() + " (+"+(player.isNaga() ? "85":"70")+"% to Str racial multi, +45% to Tou racial multi, +"+(player.isNaga() ? "60":"45")+"% to Spe racial multi, +10% to Int racial multi, -10% to Wis racial multi)</font>");//, +" + (50 * (1 + player.newGamePlusMod())) + " max HP
		else if (player.vouivreScore() >= 1) outputText("\n<font color=\"#008000\">Lesser Vouivre: " + player.vouivreScore() + "</font>");
		else if (player.vouivreScore() < 1) outputText("\n<font color=\"#ff0000\">Lesser Vouivre: 0</font>");
		//Yeti
		if (player.yetiScore() >= 17) outputText("\n<font color=\"#0000a0\">True Yeti: " + player.yetiScore() + " (+130% to Str racial multi, +100% to Tou racial multi, +65% to Spe racial multi, -90% to Int racial multi, +50% to Lib racial multi)</font>");
		else if (player.yetiScore() >= 14) outputText("\n<font color=\"#0000a0\">Yeti: " + player.yetiScore() + " (+100% to Str racial multi, +80% to Tou racial multi, +50% to Spe racial multi, -70% to Int racial multi, +50% to Lib racial multi)</font>");
		else if (player.yetiScore() >= 1) outputText("\n<font color=\"#008000\">Yeti: " + player.yetiScore() + "</font>");
		else if (player.yetiScore() < 1) outputText("\n<font color=\"#ff0000\">Yeti: 0</font>");
		//Yggdrasil
		if (player.yggdrasilScore() >= 10) outputText("\n<font color=\"#0000a0\">Yggdrasil: " + player.yggdrasilScore() + " (+50% to Str racial multi, +70% to Tou racial multi, -50% to Spe racial multi, +50% to Int racial multi, +80% to Wis racial multi, -50% to Lib racial multi, +" + (10 * (1 + player.newGamePlusMod())) + " Armor / Magic Resistance)</font>");
		else if (player.yggdrasilScore() >= 1) outputText("\n<font color=\"#008000\">Yggdrasil: " + player.yggdrasilScore() + "</font>");
		else if (player.yggdrasilScore() < 1) outputText("\n<font color=\"#ff0000\">Yggdrasil: 0</font>");
		//Yuki Onna
		if (player.yukiOnnaScore() >= 14) outputText("\n<font color=\"#0000a0\">Yuki Onna: " + player.yukiOnnaScore() + " (+70% to Spe racial multi, +140% to Int racial multi, +70% to Wis racial multi, +50% to Lib racial multi, " + (player.hasPerk(PerkLib.IcyFlesh) ? ", max Tou fixed at 1" : "") + ")</font>");
		else if (player.yukiOnnaScore() >= 1) outputText("\n<font color=\"#008000\">Yuki Onna: " + player.yukiOnnaScore() + "</font>");
		else if (player.yukiOnnaScore() < 1) outputText("\n<font color=\"#ff0000\">Yuki Onna: 0</font>");
		menu();
		addButton(0, "Next", playerMenu);
	}

	public function GenderForcedSetting():void {
		clearOutput();
		outputText("This menu allows you to choose if the game will treat your character as a female or a male. Using the automatic option will let the game orginal system do the work instead of setting your sex in one or another way.");
		menu();
		addButton(0, "Next", playerMenu);
		if (flags[kFLAGS.MALE_OR_FEMALE] == 0) addButtonDisabled(1, "Auto", "It's currently used setting option.");
		else addButton(1, "Auto", GenderForcedSettingAuto);
		if (flags[kFLAGS.MALE_OR_FEMALE] == 1) addButtonDisabled(2, "Male", "It's currently used setting option.");
		else addButton(2, "Male", GenderForcedSettingMale);
		if (flags[kFLAGS.MALE_OR_FEMALE] == 2) addButtonDisabled(3, "Female", "It's currently used setting option.");
		else addButton(3, "Female", GenderForcedSettingFemale);
	}

	public function GenderForcedSettingAuto():void {
		flags[kFLAGS.MALE_OR_FEMALE] = 0;
		doNext(GenderForcedSetting);
	}

	public function GenderForcedSettingMale():void {
		flags[kFLAGS.MALE_OR_FEMALE] = 1;
		doNext(GenderForcedSetting);
	}

	public function GenderForcedSettingFemale():void {
		flags[kFLAGS.MALE_OR_FEMALE] = 2;
		doNext(GenderForcedSetting);
	}

	public static function getGargoyleMaterial(gargoyleFlag: int): String {
		var gargoyleMaterials: Array = ["marble","alabaster"];

		return gargoyleMaterials[gargoyleFlag] || gargoyleMaterials[0];
	}

	private function campActionsReflect():void {
		clearOutput();
		outputText("You sit down on your sleeping " + (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "bed" : "bag") + " and contemplate your current outlook on life. You have been through much and became bigger, better, way more than what you once were.");
		if (player.race() != player.startingRace) outputText(" While you were formerly a " + player.startingRace + " you now are a " + player.race() + " for better or for worse and have decided to live this new life to its fullest.");
		player.strtouspeintwislibsenCalculation2();
		outputText(" As if this reflection unlocked some hidden door in you, you feel your body awaken with newfound vigor and might. Let your adversaries come, you are ready for them now!");
		doNext(playerMenu);
	}

	public function sockDescript(index:int):String {
		var cockSockDesc:String = " ";
		//outputText(" ");
		if (player.cocks[index].sock == "wool")
			cockSockDesc += "It's covered by a wooly white cock-sock, keeping it snug and warm despite how cold it might get.";
		else if (player.cocks[index].sock == "alabaster")
			cockSockDesc +="It's covered by a white, lacey cock-sock, snugly wrapping around it like a bridal dress around a bride.";
		else if (player.cocks[index].sock == "cockring")
			cockSockDesc +="It's covered by a black latex cock-sock with two attached metal rings, keeping your cock just a little harder and [balls] aching for release.";
		else if (player.cocks[index].sock == "viridian")
			cockSockDesc +="It's covered by a lacey dark green cock-sock accented with red rose-like patterns. Just wearing it makes your body, especially your cock, tingle.";
		else if (player.cocks[index].sock == "scarlet")
			cockSockDesc +="It's covered by a lacey red cock-sock that clings tightly to your member. Just wearing it makes your cock throb, as if it yearns to be larger...";
		else if (player.cocks[index].sock == "cobalt")
			cockSockDesc +="It's covered by a lacey blue cock-sock that clings tightly to your member... really tightly. It's so tight it's almost uncomfortable, and you wonder if any growth might be inhibited.";
		else if (player.cocks[index].sock == "gilded")
			cockSockDesc +="It's covered by a metallic gold cock-sock that clings tightly to you, its surface covered in glittering gems. Despite the warmth of your body, the cock-sock remains cool.";
		else if (player.cocks[index].sock == "amaranthine") {
			cockSockDesc +="It's covered by a lacey purple cock-sock";
			if (player.cocks[index].cockType != CockTypesEnum.DISPLACER)
				cockSockDesc +=" that fits somewhat awkwardly on your member";
			else
				cockSockDesc +=" that fits your coeurl cock perfectly";
			cockSockDesc +=". Just wearing it makes you feel stronger and more powerful.";
		} else if (player.cocks[index].sock == "red")
			cockSockDesc +="It's covered by a red cock-sock that seems to glow. Just wearing it makes you feel a bit powerful.";
		else if (player.cocks[index].sock == "green")
			cockSockDesc +="It's covered by a green he cock-sock that seems to glow. Just wearing it makes you feel a bit healthier.";
		else if (player.cocks[index].sock == "blue")
			cockSockDesc +="It's covered by a blue cock-sock that seems to glow. Just wearing it makes you feel like you can cast spells more effectively.";

		else cockSockDesc +="<b>Yo, this is an error.</b>";
		return cockSockDesc;
	}

	public function describeVisage():void{ //expressions!
		if (player.hasPerk(PerkLib.DarkenedKitsune)) {
			outputText(" " + SceneLib.darkenedKitsuneScene.darkenedKitsuneExpression());
		}
	}
}
}