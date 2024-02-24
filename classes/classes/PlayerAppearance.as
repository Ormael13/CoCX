package classes {
import classes.BodyParts.*;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Races.ElementalRace;
import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.NPCs.SophieFollowerScene;
import classes.internals.Utils;

public class PlayerAppearance extends BaseContent {


	public function PlayerAppearance() {
		onGameInit(init);
	}
	protected function inchesOrCentimetres(...args):String { return Measurements.inchesOrCentimetres.apply(null, args); }
	protected function shortSuffix(...args):String { return Measurements.shortSuffix.apply(null, args); }
	private function init():void {
 	}
	public function appearance(debug: Boolean = false):void {
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
			outputText("[pg]" + describeCocks());
			outputText("[pg]" + describeBalls());
		} else {
			if (player.hasCock() || player.hasBalls()) {
				outputText("[pg]" + Utils.mergeSentences([describeCocks(), describeBalls()]));
			}
		}
		const pussyDesc: String = describePussies();
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
		
		if (debug) return; // don't print buttons if opened from debug menu
		
		menu();
		addButton(0, "Next", playerMenu);
		if (player.hasPerk(PerkLib.RacialParagon)) addButton(1, "Set Race.", ApexRaceSetting);
		addButton(2, "Weap View", WeaponDisplay);
		addButton(3, "Superboob", BoobDisplay);
		if (player.hasPerk(PerkLib.Lycanthropy) || player.hasPerk(PerkLib.Vulpesthropy) || player.hasPerk(PerkLib.Selachimorphanthropy)) addButton(4, "Were/Human", HumanFormDisplay);
		addButton(7, "Reflect", campActionsReflect).hint("Reflect on your current state and future plans. (Also would make your body fully adjust to any sudden changes to natural limits of your attributes after eating any odd things and etc.)");
		addButton(10, "RacialScores", RacialScores);
		addButton(11, "Gender Set.", GenderForcedSetting);
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

	public function	BoobDisplay():void {
		clearOutput();
		outputText("Do you want to display Breast Bigger then F cup.");
		if (flags[kFLAGS.BOOB_DISPLAY_FLAG] == 0) outputText("[pg]Display Style: <b>Yes</b>");
		if (flags[kFLAGS.BOOB_DISPLAY_FLAG] == 1) outputText("[pg]Display Style: <b>No</b>");
		mainView.hideAllMenuButtons();
		menu();
		addButton(0, "Hyper", BoobDisplaySwitch, 0).disableIf(flags[kFLAGS.BOOB_DISPLAY_FLAG] == 0, "Bigger boob disabled");
		addButton(1, "No Hyper", BoobDisplaySwitch, 1).disableIf(flags[kFLAGS.BOOB_DISPLAY_FLAG] == 1, "Bigger boob enabled");
		addButton(14, "Back", appearance);
	}

	public function HumanFormDisplay():void {
		clearOutput();
		outputText("Choose if you want were-races to hide their true appearance out of combat.");
		outputText("[pg]Human Form: <b>" + (player.hasStatusEffect(StatusEffects.HumanForm) ? "On" : "Off") + "</b>");
		mainView.hideAllMenuButtons();
		menu();
		addButton(0, "Human On", HumanFormToggle).disableIf(player.hasStatusEffect(StatusEffects.HumanForm));
		addButton(1, "Human Off", HumanFormToggle).disableIf(!player.hasStatusEffect(StatusEffects.HumanForm));
		addButton(14, "Back", appearance);
	}

	public function	WeaponDisplaySwitch(Display:Number):void {
		flags[kFLAGS.WEAPON_DISPLAY_FLAG] = Display;
		WeaponDisplay();
	}

	public function	BoobDisplaySwitch(Display:Number):void {
		flags[kFLAGS.BOOB_DISPLAY_FLAG] = Display;
		BoobDisplay();
	}

	public function HumanFormToggle():void {
		if (!player.hasStatusEffect(StatusEffects.HumanForm)) player.createStatusEffect(StatusEffects.HumanForm,1,0,0,0);
		else player.removeStatusEffect(StatusEffects.HumanForm);
		HumanFormDisplay();
	}

	public function ApexRaceSetting():void {
		clearOutput();
		mainView.hideAllMenuButtons();
		ApexRaceDisplayTextUpdate();
		// Display selected race
		var races:Array = [];
		for each(var x:Race in Races.AllRacesByName) {
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
			var element:int = ElementalRace.getElement(player);
			if (element == ElementalRace.ELEMENT_UNDINE) {
				outputText("You have currently fusioned with an water elemental spirit as an undine. Your body is humanoid in shape but many of your traits remind of water. You have light blue skin the color of azure while your "+Hair.getHairLength(player)+" blue liquid hair are human at a first glance but drips into a vanishing trail of water toward the end. ");
				outputText("Your eyes are the color sea water and your expression albeit serene mask the violent mood swing your element can be subject to. Calm like a pond or raging like the sea amidst a storm you can just as easily move from one to the other in a blink.\n\n");
				outputText("Your body, while mostly unified like a pool of water, is ornamented by a number of energy runes that allows you to maintain a solid shape somewhat. Your arms are human-like in shape, but just as the rest of your body, you can extend and shift your arms into churning water at any will. The skin is like water and can be semi seen through. ");
				outputText("Your legs are human-like in shape, though they occasionally drip water to the ground. Just like the rest of your semi liquid body, it's translucent as if staring through a pool of water. Your semi liquid form allows you to pleasantly float in the air like condensation, though you cannot outright fly.");
			}
			else if (element == ElementalRace.ELEMENT_IGNIS) {
				outputText("You have currently fusioned with an fire elemental spirit as a ignis. Your body is humanoid in shape but many of your traits remind of fire. You have tan skin as if spending too much time under the sun while your "+Hair.getHairLength(player)+" burning, raging flame like hair flow like raging flames. Your eyes are the color of blazing embers while your vicious expression mirrors the raging fire in your heart. You feel like going violent and reckless might solve some of your problems.\n\n");
				outputText("Your arms are human-like in shape, but at the junction of your wrists, fire wicks about in the palm of your hands. Your legs are human-like in shape, but a raging fire starts at your ankles, coating your feet entirely. You levitate by burning the ambient air around you. Wreathed in a corona of flame, you can fly freely as long as you have oxygen to propel you.");
			}
			else if (element == ElementalRace.ELEMENT_GNOME) {
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
						if (player.hasBalls())
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
				return "You are completely bald, displaying [color] [skin.type] where your hair would otherwise be.";
			}
		}
	}

	public function describeEars(): String {
		return Ears.getAppearanceDescription(player);
	}

	public function describeSpecialCases(): String {
		var specialCasesDesc: String = "";

		if (player.hasStatusEffect(StatusEffects.GooStuffed)) {
			specialCasesDesc += "<b>Your gravid-looking belly is absolutely stuffed full of goo. There's no way you can get pregnant like this, but at the same time, you look like some fat-bellied breeder.</b>[pg]";
		}
		if (player.hasStatusEffect(StatusEffects.WormPlugged)) {
			specialCasesDesc += "<b>Your belly is a bit pudgy and your vagina is inflamed from constant stimulation, and the reason becomes apparent when some of the worms that infest your womb momentarily peek outside. There is no way you are getting pregnant until you get rid of these worms!</b>";
		}

		return specialCasesDesc;
	}

	public function describePregnancy(): String {
		var temp:Number = 0;
		var pregnancyDesc: String = "";
		var womb:Object;
		if (player.isPregnant()) {
			if (player.pregnancyType > 0) {
				womb = {};
				womb["womb"] = 0
				womb["type"] = player.pregnancyType;
				womb["incubation"] = player.pregnancyIncubation;
			}
			if (player.pregnancy2Type > 0 && (player.pregnancyType == 0 || (player.pregnancyIncubation > 0 && player.pregnancy2Incubation < player.pregnancyIncubation))) {
				womb = {};
				womb["womb"] = 1
				womb["type"] = player.pregnancy2Type;
				womb["incubation"] = player.pregnancy2Incubation;
			}
		}

		if ((player.isButtPregnant() || player.isPregnant()) && !player.hasStatusEffect(StatusEffects.GooStuffed) && !player.hasStatusEffect(StatusEffects.WormPlugged)) {
			if (player.isPregnant() && womb["type"] == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) {
				pregnancyDesc += "<b>";
				//Compute size
				temp = player.statusEffectv3(StatusEffects.Eggs) + player.statusEffectv2(StatusEffects.Eggs) * 10;
				if(womb["incubation"] <= 50 && womb["incubation"] > 20) {
					pregnancyDesc += "Your swollen pregnant belly is as large as a ";
					if(temp < 10)
						pregnancyDesc += "basketball.";
					if(temp >= 10 && temp < 20)
						pregnancyDesc += "watermelon.";
					if(temp >= 20)
						pregnancyDesc += "beach ball.";
				}
				if(womb["incubation"] <= 20) {
					pregnancyDesc += "Your swollen pregnant belly is as large as a ";
					if(temp < 10)
						pregnancyDesc += "watermelon.";
					if(temp >= 10 && temp < 20)
						pregnancyDesc += "beach ball.";
					if(temp >= 20)
						pregnancyDesc += "large medicine ball.";
				}
				pregnancyDesc += "</b>";
			}
			//Satur preggos - only shows if bigger than regular pregnancy or not pregnancy
			else if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR && (!player.isPregnant() || player.buttPregnancyIncubation < womb["incubation"])) {
				if(player.buttPregnancyIncubation < 125 && player.buttPregnancyIncubation >= 75) {
					pregnancyDesc += "<b>You've got the beginnings of a small pot-belly.</b>";
				}
				else if(player.buttPregnancyIncubation >= 50) {
					pregnancyDesc += "<b>The unmistakable bulge of pregnancy is visible in your tummy, yet it feels odd inside you - wrong somehow.</b>";
				}
				else if(player.buttPregnancyIncubation >= 30) {
					pregnancyDesc += "<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>";
				} else { //Surely Benoit and Cotton deserve their place in this list
					if (womb["type"] == PregnancyStore.PREGNANCY_MARBLE)
						pregnancyDesc += "<b>Your belly protrudes unnaturally far forward, bulging outwards with Marble's precious child.</b>";
					else if (InCollection(womb["type"], PregnancyStore.PREGNANCY_IZMA, PregnancyStore.PREGNANCY_MOUSE, PregnancyStore.PREGNANCY_AMILY, PregnancyStore.PREGNANCY_EMBER, PregnancyStore.PREGNANCY_BENOIT, PregnancyStore.PREGNANCY_COTTON, PregnancyStore.PREGNANCY_URTA, PregnancyStore.PREGNANCY_BEHEMOTH, PregnancyStore.PREGNANCY_ZENJI) || (womb["type"] == PregnancyStore.PREGNANCY_JOJO && (JojoScene.monk <= 0 || flags[kFLAGS.JOJO_BIMBO_STATE] == 3)))
						pregnancyDesc += "<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>";
					else pregnancyDesc += "<b>Your belly protrudes unnaturally far forward, bulging with the unclean spawn of some monster or beast.</b>";
				}
			} else if (player.isButtPregnant()) {
				if(player.buttPregnancyIncubation <= 8 && player.buttPregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL)
					pregnancyDesc += "<b>Your stomach is so full of frog eggs that you look about to birth at any moment, your belly wobbling and shaking with every step you take, packed with frog ovum.</b>";
				else if (player.buttPregnancyType != PregnancyStore.PREGNANCY_GOO_STUFFED) pregnancyDesc += "<b>You're stuffed so full with eggs that your belly looks obscenely distended, huge and weighted with the gargantuan eggs crowding your gut. They make your gait a waddle and your gravid tummy wobble obscenely.</b>";
			}
			//URTA PREG
			else if ((womb["type"] == PregnancyStore.PREGNANCY_URTA)) {
				if (womb["incubation"] <= 432 && womb["incubation"] > 360) {
					pregnancyDesc += "<b>Your belly is larger than it used to be.</b>\n";
				}
				else if (womb["incubation"] > 288) {
					pregnancyDesc += "<b>Your belly is more noticeably distended. You're pretty sure it's Urta's.</b>";
				}
				else if (womb["incubation"] > 216) {
					pregnancyDesc += "<b>The unmistakable bulge of pregnancy is visible in your tummy, and the baby within is kicking nowadays.</b>";
				}
				else if (womb["incubation"] > 144) {
					pregnancyDesc += "<b>Your belly is large and very obviously pregnant to anyone who looks at you. It's gotten heavy enough to be a pain to carry around all the time.</b>";
				}
				else if (womb["incubation"] > 72) {
					pregnancyDesc += "<b>It would be impossible to conceal your growing pregnancy from anyone who glanced your way. It's large and round, frequently moving.</b>";
				}
				else if (womb["incubation"] > 48) {
					pregnancyDesc += "<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>";
				}
				else {
					pregnancyDesc += "<b>Your belly protrudes unnaturally far forward, bulging with the Urta's Kits.</b>";
				}
			} else if (womb["type"] == PregnancyStore.PREGNANCY_FAERIE) { //Belly size remains constant throughout the pregnancy
				pregnancyDesc += "<b>Your belly remains swollen like a watermelon. ";
				if (womb["incubation"] <= 100)
					pregnancyDesc += "It's full of liquid, though unlike a normal pregnancy the passenger you’re carrying is tiny.</b>";
				else if (womb["incubation"] <= 140)
					pregnancyDesc += "It feels like it’s full of thick syrup or jelly.</b>";
				else pregnancyDesc += "It still feels like there’s a solid ball inside your womb.</b>";
			} else if (womb["type"] == PregnancyStore.PREGNANCY_HARPY_HATCHING) {
				pregnancyDesc += "You eagerly await the hatching of your harpy egg at camp. You feel it should hatch ";
				if (7 - SophieFollowerScene.HarpyEggDay > 0)  pregnancyDesc += "in " + (7 - SophieFollowerScene.HarpyEggDay) + " days.";
				else pregnancyDesc += "tomorrow.";
			} else {
				if (womb["incubation"] <= 336 && womb["incubation"] > 280) {
					pregnancyDesc += "<b>Your belly is larger than it used to be.</b>";
				}
				else if(womb["incubation"] > 216) {
					pregnancyDesc += "<b>Your belly is more noticeably distended. You are probably pregnant.</b>";
				}
				else if(womb["incubation"] > 180) {
					pregnancyDesc += "<b>The unmistakable bulge of pregnancy is visible in your tummy.</b>";
				}
				else if(womb["incubation"] > 120) {
					pregnancyDesc += "<b>Your belly is very obviously pregnant to anyone who looks at you.</b>";
				}
				else if(womb["incubation"] > 72) {
					pregnancyDesc += "<b>It would be impossible to conceal your growing pregnancy from anyone who glanced your way.</b>";
				}
				else if(womb["incubation"] > 48) {
					pregnancyDesc += "<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>";
				}
				else { //Surely Benoit and Cotton deserve their place in this list
					if (womb["type"] == PregnancyStore.PREGNANCY_MARBLE)
						pregnancyDesc += "<b>Your belly protrudes unnaturally far forward, bulging outwards with Marble's precious child.</b>";
					else if (InCollection(womb["type"], PregnancyStore.PREGNANCY_IZMA, PregnancyStore.PREGNANCY_MOUSE, PregnancyStore.PREGNANCY_AMILY, PregnancyStore.PREGNANCY_EMBER, PregnancyStore.PREGNANCY_BENOIT, PregnancyStore.PREGNANCY_COTTON, PregnancyStore.PREGNANCY_URTA, PregnancyStore.PREGNANCY_BEHEMOTH, PregnancyStore.PREGNANCY_ZENJI) || (womb["type"] == PregnancyStore.PREGNANCY_JOJO && (JojoScene.monk <= 0 || flags[kFLAGS.JOJO_BIMBO_STATE] == 3)))
						pregnancyDesc += "<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>";
					else if (womb["type"] == PregnancyStore.PREGNANCY_HARPY_EGGS)
						pregnancyDesc += "<b>Your belly protrudes unnaturally far forward, bulging with your harpy eggs.</b>";
					else pregnancyDesc += "<b>Your belly protrudes unnaturally far forward, bulging with the unclean spawn of some monster or beast.</b>";
				}
			}
		}

		return pregnancyDesc;
	}

	public function describeBreasts(): String {
		var temp:Number = 0;
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

	public function describeCocks(): String {
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
				cockDesc += describeCock(cock_index, rando);
			}
			//Worm flavor
			if (player.hasStatusEffect(StatusEffects.Infested)) cockDesc += " Every now and again slimy worms coated in spunk slip partway out of your " + player.multiCockDescriptLight() + ", tasting the air like tongues of snakes";
		}

		return cockDesc;
	}

	public function describeCock(cock_index:int = 0, rando:int = 0): String {
		var cockDesc:String = ""
		if (cock_index >= player.cocks.length) return cockDesc;
		if (rando == 0)
			rando = rand(100);
		// How to start the sentence?
		if (player.cocks.length == 1) cockDesc += "Your ";
		else if (cock_index == 0) cockDesc += "\n--Your first ";
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
		cockDesc += " You estimate its area to be about " + Math.round(player.cockArea(cock_index)) + ".";
		// What flavor of cock do you have?
		switch (player.cocks[cock_index].cockType) {
			case CockTypesEnum.HORSE: cockDesc += " It's mottled black and brown in a very animalistic pattern. The 'head' of its shaft flares proudly, just like a horse's."; break;
			case CockTypesEnum.KIRIN: cockDesc += " It's a glowing pale blue in color. The 'head' of its shaft flares proudly, just like a horse's."; break;
			case CockTypesEnum.DOG: cockDesc += " It is shiny, pointed, and covered in veins, just like a large dog's cock."; break;
			case CockTypesEnum.WOLF: cockDesc += " It is shiny red, pointed, and covered in veins, just like a large wolf's cock."; break;
			case CockTypesEnum.RAIJU: cockDesc += " It's a deep, glowing electric blue in color, pointed, and covered in veins, just like a large raiju's cock."; break;
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
		return cockDesc;
	}

	public function describeBalls(): String {
		var ballsDesc: String = "";

		const ballsSizeDesc: String = " about " + num2Text(Math.round(player.ballSize)) + " " + (Math.round(player.ballSize) == 1 ? "inch" : "inches") +" across"

		if(player.hasBalls()) {
			if(player.hasStatusEffect(StatusEffects.Uniball)) {
				if(player.skinType != Skin.GOO) ballsDesc += "Your [sack] clings tightly to your groin, holding [balls]," + ballsSizeDesc + ", snugly against you.";
				else if(player.skinType == Skin.GOO) ballsDesc += "Your [sack] clings tightly to your groin, dripping and holding [balls]," + ballsSizeDesc + ", snugly against you.";
			} else {
				var swingsWhere:String;
				if (player.cockTotal() == 0) swingsWhere = " where a penis would normally grow.";
				else swingsWhere = " under your [cocks].";

				if (player.isFurCovered()) ballsDesc += "A fuzzy [sack] filled with [ballsarticle]," + ballsSizeDesc + " each, swings low" + swingsWhere;
				else if (player.hasCoatOfType(Skin.CHITIN)) ballsDesc += "A chitin [sack] hugs your [balls]," + ballsSizeDesc + " each, tightly against your body.";
				else if (player.isScaleCovered()) ballsDesc += "A scaly [sack] hugs your [balls]," + ballsSizeDesc + " each, tightly against your body.";
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

	public function describePussies(): String {
		var pussyDesc: String = "";

		if (player.vaginas.length > 0) {
			if((player.gender == 2 || player.gender == 3) && player.isTaur() && !player.isScylla())
			pussyDesc += "Your womanly parts have shifted to lie between your hind legs, in a rather feral fashion.";
			if((player.gender == 2 || player.gender == 3) && (player.isScylla() || player.isKraken()))
			pussyDesc += "Your womanly parts have shifted to lie underneath your tentacle legs.";

			for(var i:int=0; i<player.vaginas.length; i++){
				pussyDesc += describePussy(i);

				if (player.vaginas.length > 1)
					pussyDesc += "[pg]";
			}
		}

		return pussyDesc;
	}

	public function describePussy(i:int = 0):String {
		var pussyDesc:String = "";
		if (player.vaginas.length == 1) {
			if (player.lowerBody == LowerBody.MELKIE){
				pussyDesc += "You have two sets of vaginal lips, the first"; //one twice as big as the other and hiding the smaller within its folds. Behind your first set of lips, you have a " + vaginaDescript(0) + ", with a " + Measurements.shortSuffix(int(player.clitLength*10)/10) + " clit";
			} else {
				pussyDesc += "Your " + vaginaDescript(i);
			}
		}
		else {
			if (player.lowerBody == LowerBody.MELKIE){
				pussyDesc += "You have two sets of vaginal lips, the first"; //set in pairs, one twice as big as the other and hiding the smaller within its folds. Behind your first set of lips, you have a " + vaginaDescript(0) + ", with a " + Measurements.shortSuffix(int(player.clitLength*10)/10) + " clit, and behind your second set of lips, you have a " + vaginaDescript(1) + ", with a " + Measurements.shortSuffix(int(player.clitLength*10)/10) + " clit";
			} else {
				pussyDesc += "Your  " + num2Text2(i+1) +" "+ vaginaDescript(i);
			}
		}
		var clitExists:int = 0;
		var vagType:int = player.vaginaType(-1, i) //It's not iterating properly to register the second pussy.
		switch (vagType) { //missing black sand trap, maybe melkie.
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
				pussyDesc += " is twice as big as the other, and the other hidden within its folds. Your outer lips hide a ";
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
				if (player.isNaga()) pussyDesc += " as your hot spot is now way further inside your deep canal, requiring quite a longer member to reach";
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
			case VaginaClass.KIRIN:
				pussyDesc += " is deep and wide just like that of a horse. Sometime you lament that most of your partners are no longer big enough to satisfy you. It constantly drools plasma, small puffs of electrified matter wafting up from beneath where you're standing. Your equine static chamber hides a ";
				break;
			default:
				pussyDesc += " hides a ";
				break;
		}
		//Clit check. Only for Scylla for now.
		if (clitExists == 0) pussyDesc += Measurements.shortSuffix(int(player.clitLength * 10) / 10) + " clit";
		//Hymen check.
		if (player.vaginas[i].virgin) {
			pussyDesc += ". Its hymen is intact. ";
		} else {
			pussyDesc += ". ";
		}
		//Wetness check.
		if (player.lib < 50 && player.lust < 50) { //not particularly horny
			//Wetness
			if (player.vaginas[i].vaginalWetness >= VaginaClass.WETNESS_WET && player.vaginas[i].vaginalWetness < VaginaClass.WETNESS_DROOLING)
				pussyDesc += "Moisture gleams in ";
			if (player.vaginas[i].vaginalWetness >= VaginaClass.WETNESS_DROOLING) {
				pussyDesc += "Occasional beads of ";
				pussyDesc += "lubricant drip from ";
			}
			//Different description based on vag looseness
			if (player.vaginas[i].vaginalWetness >= VaginaClass.WETNESS_WET) {
				if (player.vaginas[i].vaginalLooseness < VaginaClass.LOOSENESS_LOOSE)
					pussyDesc += "your " + vaginaDescript(i) + ".";
				if (player.vaginas[i].vaginalLooseness >= VaginaClass.LOOSENESS_LOOSE && player.vaginas[i].vaginalLooseness < VaginaClass.LOOSENESS_GAPING_WIDE)
					pussyDesc += "your " + vaginaDescript(i) + ", its lips slightly parted.";
				if (player.vaginas[i].vaginalLooseness >= VaginaClass.LOOSENESS_GAPING_WIDE)
					pussyDesc += "the massive hole that is your " + vaginaDescript(0) + ".";
			}
		} else if ((player.lib >= 50 || player.lust >= 50) && (player.lib < 80 && player.lust < 80)) { //kinda horny
			//Wetness
			if (player.vaginas[i].vaginalWetness < VaginaClass.WETNESS_WET)
				pussyDesc += "Moisture gleams in ";
			if (player.vaginas[i].vaginalWetness >= VaginaClass.WETNESS_WET && player.vaginas[i].vaginalWetness < VaginaClass.WETNESS_DROOLING) {
				pussyDesc += "Occasional beads of ";
				pussyDesc += "lubricant drip from ";
			}
			if (player.vaginas[i].vaginalWetness >= VaginaClass.WETNESS_DROOLING) {
				pussyDesc += "Thin streams of ";
				pussyDesc += "lubricant occasionally dribble from ";
			}
			//Different description based on vag looseness
			if (player.vaginas[i].vaginalLooseness < VaginaClass.LOOSENESS_LOOSE)
				pussyDesc += "your " + vaginaDescript(i) + ".";
			if (player.vaginas[i].vaginalLooseness >= VaginaClass.LOOSENESS_LOOSE && player.vaginas[i].vaginalLooseness < VaginaClass.LOOSENESS_GAPING_WIDE)
				pussyDesc += "your " + vaginaDescript(i) + ", its lips slightly parted.";
			if (player.vaginas[i].vaginalLooseness >= VaginaClass.LOOSENESS_GAPING_WIDE)
				pussyDesc += "the massive hole that is your " + vaginaDescript(0) + ".";
		} else if ((player.lib > 80 || player.lust > 80)) { //WTF horny!
			//Wetness
			if (player.vaginas[i].vaginalWetness < VaginaClass.WETNESS_WET) {
				pussyDesc += "Occasional beads of ";
				pussyDesc += "lubricant drip from ";
			}
			if (player.vaginas[i].vaginalWetness >= VaginaClass.WETNESS_WET && player.vaginas[i].vaginalWetness < VaginaClass.WETNESS_DROOLING) {
				pussyDesc += "Thin streams of ";
				pussyDesc += "lubricant occasionally dribble from ";
			}
			if (player.vaginas[i].vaginalWetness >= VaginaClass.WETNESS_DROOLING) {
				pussyDesc += "Thick streams of ";
				pussyDesc += "lubricant drool constantly from ";
			}
			//Different description based on vag looseness
			if (player.vaginas[i].vaginalLooseness < VaginaClass.LOOSENESS_LOOSE)
				pussyDesc += "your " + vaginaDescript(i) + ".";
			if (player.vaginas[i].vaginalLooseness >= VaginaClass.LOOSENESS_LOOSE && player.vaginas[i].vaginalLooseness < VaginaClass.LOOSENESS_GAPING_WIDE)
				pussyDesc += "your " + vaginaDescript(i) + ", its lips slightly parted.";
			if (player.vaginas[i].vaginalLooseness >= VaginaClass.LOOSENESS_GAPING_WIDE)
				pussyDesc += "the massive hole that is your cunt.";
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
	
	/**
	 * @param sortBy 0: name, 1: score
	 */
	public function RacialScores(clickedRace:Race = null, sortBy:int=0):void {
		var body:BodyData = player.bodyData();

		//For saving state across sessions and "time".
		sortBy = flags[kFLAGS.RACESORT_SETTING];

		clearOutput();
		outputText("<b>Current racial scores (and bonuses to stats if applicable):</b>\n");
		outputText("Sort by: ");
		if (sortBy == 0) {
			outputText('<b>name</b>, ');
			printLink("score", "sort,1");
		} else {
			printLink('name',"sort,0");
			outputText(', <b>score</b>');
		}
		outputText(". ");
		outputText("Click on a race to view details.\n");
		outputText("List legend: [font-lblue]active race[/font], [font-green]positive score[/font], zero score.\n");
		outputText("Details legend: [font-lblue]active tier[/font], [font-green]passed check[/font], failed check, [font-red]score penalty[/font].\n");
		
		player.updateRacialCache();
		var list:/*Race*/Array = Races.AllRacesByName;
		var scrollPos:int = 0;
		if (sortBy == 1) {
			list = sortedBy(list, function (a:Race):int {
				return player.racialScoreCached(a);
			}, true);
		}
		for (var i:int = 0; i<list.length; i++) {
			var race:Race = list[i];
			// skip "old" races
			if (race.requirements.length == 0 || race.tiers.length == 0) continue;
			
			outputText("\n");
			var rscore:int     = player.racialScoreCached(race);
			var rtier:RaceTier = race.getTier(body, rscore);
			
			if (rtier) {
				outputText("[font-lblue]");
			} else if (rscore > 0) {
				outputText("[font-green]");
			} else {
				outputText("[font-default]");
			}
			printLink(Utils.capitalizeFirstLetter(rtier?rtier.nameFor(body):race.name), "race,"+race.id);
			outputText(": "+rscore);
			outputText("[/font]");
			if (rtier) {
				if (rtier.hasBuffs()) {
					var s:String = rtier.describeBuffs(body);
					if (s) {
						outputText(" (");
						outputText(s);
						outputText(")");
					}
				}
				outputText("[/font]");
			}
			if (race == clickedRace) {
				outputText("\n");
				outputText(race.printDetails(body));
				scrollPos = Math.max(0, 6+i);
				if (debug && race.debugFormNames().length > 0) {
					outputText("Transform into");
					for each (var tfname:String in race.debugFormNames()) {
						outputText(" ");
						printLink(tfname, "tf,"+race.id+","+tfname);
					}
				}
			}
		}
		mainView.linkHandler = function(event:String):void {
			var parts:Array = event.split(",");
			switch (parts[0]) {
				case "race":
					var clickedRace2:Race = Race.byId(parseInt(parts[1]));
					if (clickedRace2 == clickedRace) clickedRace2 = null;
					RacialScores(clickedRace2, sortBy);
					break;
				case "sort":
					flags[kFLAGS.RACESORT_SETTING] = parseInt(parts[1]);
					RacialScores(clickedRace, parseInt(parts[1]));
					break;
				case "tf":
					clearOutput();
					Race.byId(parseInt(parts[1])).takeForm(player, parts[2]);
					mainViewManager.updateCharviewIfNeeded();
					doNext(RacialScores, clickedRace, sortBy);
					break;
			}
		}
		var score:Number;
		var scoreH:Number;
		//CHIMERA
		outputText("\nCHIMERA: " + player.chimeraScore());
		//GRAND CHIMERA
		outputText("\nGRAND CHIMERA: " + player.grandchimeraScore());
		//INTERNAL CHIMERICAL DISPOSITION
		score = player.internalChimeraScore();
		if (score >= 1) {
			outputText("\n");
			outputText(player.hasPerk(PerkLib.RacialParagon) ? "[font-green]" : "[font-lblue]");
			outputText("INTERNAL CHIMERICAL DISPOSITION: (" + player.internalChimeraRating() + ") " + score);
            if (player.hasPerk(PerkLib.RacialParagon)) outputText(" - no buffs because of the Racial Paragon perk");
            else outputText(" (+" + (5 * score) + "% to Str racial multi / Tou / Spe / Int / Wis / Lib");
			outputText("[/font]")
        } else {
			outputText("\nINTERNAL CHIMERICAL DISPOSITION: 0");
		}
		scoreH = player.internalHumanScore();
		if (scoreH >= 1) {
			outputText("\n");
			outputText(player.hasPerk(PerkLib.RacialParagon) ? "[font-green]" : "[font-lblue]");
			outputText("INTERNAL HUMAN DISPOSITION: " + player.internalHumanScore());
            //if (player.hasPerk(PerkLib.RacialParagon)) outputText(" - no buffs because of the Racial Paragon perk");
            //else outputText(" (+" + (5 * score) + "% to Str racial multi / Tou / Spe / Int / Wis / Lib");
			outputText("[/font]")
        } else {
			outputText("\nINTERNAL HUMAN DISPOSITION: 0");
		}
		
		// Other body part-related buffs that contribute to the "Racial" buff object in Player.calcRacialBuffs
		outputText("\n");
		
		var factor:Number = 0;
		if (player.hasCoatOfType(Skin.CHITIN)) factor += 2;
		else if (player.hasCoatOfType(Skin.SCALES)) factor += 1;
		if (player.hasPerk(PerkLib.ThickSkin)) factor += 1;
		score = player.perkv1(IMutationsLib.MantislikeAgilityIM);
		var bonus:Number = 0;
		if (score >= 3) {
			bonus = 30*factor;
		} else if (score >= 2) {
			bonus += 15*factor;
		} else if (score >= 1) {
			bonus += 5*factor;
		}
		if (bonus > 0) {
			outputText("\n[font-lblue]Mantislike Agility[/font]: +"+bonus+"% Speed");
		}
		if (player.hasPerk(PerkLib.Flexibility) && player.isAnyRaceCached(Races.CatlikeRaces)) {
			outputText("\n[font-lblue]Cat-like race + Flexibility[/font]: +10% Speed.");
		}
		if (player.isNaga()) {
			if (player.lowerBody == LowerBody.FROSTWYRM) {
				outputText("\n[font-lblue]Frost wyrm lower body[/font]: +20% Strength, +10% Toughness.");
			} else {
				outputText("\n[font-lblue]Naga lower body[/font]: +15% Strength, +15% Toughness.");
			}
		}
		
		if (player.isTaur()) {
			outputText("\n[font-lblue]Taur lower body[/font]: +20% Speed.")
		}
		
		if (player.isDrider()) {
			if (player.lowerBody == LowerBody.CANCER) {
				outputText("\n[font-lblue]Cancer lower body[/font]: +15% Strength, +5% Speed, +10% Toughness.");
			} else {
				outputText("\n[font-lblue]Drider lower body[/font]: +15% Toughness, +15% Speed.");
			}
		}
		if (player.isScylla()) {
			outputText("\n[font-lblue]Scylla lower body[/font]: +30% Strength.")
		}
		if (player.isKraken()) {
			outputText("\n[font-lblue]Kraken lower body[/font]: +60% Strength, +15 Sensitivity");
		}
		if (player.lowerBody == LowerBody.CENTIPEDE) {
			outputText("\n[font-lblue]Centipede lower body[/font]: +15% Strength, +5% Toughness, +10% Speed.")
		}
		if (player.isAlraune()) {
			outputText("\n[font-lblue]Alraune lower body[/font]: +15% Toughness, +15% Libido.")
		}
		if (player.hasPerk(PerkLib.RacialParagon)) {
			outputText("\n[font-lblue]Racial Paragon[/font]: +"+player.level+"% to core stats.")
		}
		if (player.hasPerk(PerkLib.Apex)) {
			outputText("\n[font-lblue]Apex[/font]: +"+(2*player.level)+"% to core stats.")
		}
		if (player.hasPerk(PerkLib.AlphaAndOmega)) {
			outputText("\n[font-lblue]Alpha And Omega[/font]: +"+(2*player.level)+"% to core stats.")
		}
		if (player.hasPerk(PerkLib.AscensionOneRaceToRuleThemAllX)) {
			outputText("\n[font-lblue]Ascension: One Race To Rule Them All[/font]: +"+(2*player.perkv1(PerkLib.AscensionOneRaceToRuleThemAllX)*player.level)+"% to core stats.");
		}
		
		menu();
		if (scrollPos) mainView.mainText.scrollV = scrollPos;
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
		player.updateRacialAndPerkBuffs();
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
}
}
