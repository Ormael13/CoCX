public function doThatTestingThang():void
{
	clearOutput();
	// Excercise the parser. This should catch parser regressions, I think.
	//
	//

	outputText(<![CDATA[

**Parser Tests!**

##Bracket escaping!##

* \\\[cock\\\]
* [cock]

**Single word nouns**

* \\\[armor\\\] - [armor]
* \\\[armorname\\\] - [armorname]
* \\\[weapon\\\] - [weapon]
* \\\[weaponname\\\] - [weaponname]
* \\\[name\\\] - [name]
* \\\[asshole\\\] - [asshole]
* \\\[butthole\\\] - [butthole]
* \\\[hair\\\] - [hair]
* \\\[face\\\] - [face]
* \\\[legs\\\] - [legs]
* \\\[leg\\\] - [leg]
* \\\[feet\\\] - [feet]
* \\\[foot\\\] - [foot]
* \\\[sack\\\] - [sack]
* \\\[balls\\\] - [balls]
* \\\[sheath\\\] - [sheath]
* \\\[chest\\\] - [chest]
* \\\[fullchest\\\] - [fullchest]
* \\\[hips\\\] - [hips]
* \\\[butt\\\] - [butt]
* \\\[ass\\\] - [ass]
* \\\[nipple\\\] - [nipple]
* \\\[nipples\\\] - [nipples]
* \\\[tongue\\\] - [tongue]
* \\\[evade\\\] - [evade]
* \\\[misdirection\\\] - [misdirection]
* \\\[agility\\\] - [agility]
* \\\[master\\\] - [master]
* \\\[master\\\] - [master]
* \\\[he\\\] - [he]
* \\\[him\\\] - [him]
* \\\[his\\\] - [his]
* \\\[pussy\\\] - [pussy]
* \\\[vagina\\\] - [vagina]
* \\\[vag\\\] - [vag]
* \\\[clit\\\] - [clit]
* \\\[cock\\\] - [cock]
* \\\[cocks\\\] - [cocks]
* \\\[eachcock\\\] - [eachcock]
* \\\[onecock\\\] - [onecock]
* \\\[cockhead\\\] - [cockhead]
* \\\[vagorass\\\] - [vagorass]
* \\\[hairorfur\\\] - [hairorfur]
* \\\[pg\\\] - [pg] (This is a shortcut to two newlines. This should be two lines below the \\\[pg\\\])


**Single-word function calls and parameter lookups**

* \\\[player.face\\\] - [player.face]
* \\\[allChestDesc\\\] - [allChestDesc]
* \\\[player.armorName\\\] - [player.armorName]
* \\\[player.skinFurScales\\\] - [player.skinFurScales]
* \\\[chestDesc\\\] - [chestDesc]


**Two word nouns**

* \\\[cock all\\\] - [cock all]
* \\\[cock each\\\] - [cock each]
* \\\[cock one\\\] - [cock one]
* \\\[cock largest\\\] - [cock largest]
* \\\[cock biggest\\\] - [cock biggest]
* \\\[cock smallest\\\] - [cock smallest]
* \\\[cock longest\\\] - [cock longest]
* \\\[cock shortest\\\] - [cock shortest]
* \\\[cock 0\\\] - [cock 0]  (This should always error)
* \\\[cock 1\\\] - [cock 1]
* \\\[cock 2\\\] - [cock 2]
* \\\[cockHead biggest\\\] - [cockHead biggest]
* \\\[cockHead largest\\\] - [cockHead largest]
* \\\[cockHead smallest\\\] - [cockHead smallest]
* \\\[cockHead longest\\\] - [cockHead longest]
* \\\[cockHead shortest\\\] - [cockHead shortest]
* \\\[cockHead 0\\\] - [cockHead 0]  (This should always error)
* \\\[cockHead 1\\\] - [cockHead 1]
* \\\[cockHead 2\\\] - [cockHead 2]

**Boolean tests**

* 1 \\\[if (4==4) HERP|DERP\\\]
* 1 [if (4==4) HERP|DERP]
* 2 \\\[if (4 == 7) HERP|DERP\\\]
* 2 [if (4 == 7) HERP|DERP]
* 3 \\\[if (4==(2+2)) HERP|DERP\\\]
* 3 [if (4==(2+2)) HERP|DERP]
* 4 \\\[if (4==4) HERP|DERP\\\]
* 4 [if (4==4) HERP|DERP]
* 5 \\\[if (4==7) [if (4==7) HERP]\\\]
* 5 [if (4==7) [if (4==7) HERP]]
* 6 \\\[if (4==7) [if (4==7) HERP|DERP]\\\]
* 6 [if (4==7) [if (4==7) HERP|DERP]]
* 7 \\\[if (4=4) [if (4=4) HERP]\\\]
* 7 [if (4=4) [if (4=4) HERP]]
* 8 \\\[if (4==4) [if (4==4) HERP]\\\]
* 8 [if (4==4) [if (4==4) HERP]]
* 9 \\\[if (4==biggesttitsize) \\\]
* 9 [if (4==biggesttitsize) ]
* 10 \\\[if (4==biggesttitsize) HERP|DERP\\\]
* 10 [if (4==biggesttitsize) HERP|DERP]
* 11 \\\[if (analcapacity>3)    HERP|DERP\\\]
* 11 [if (analcapacity>3)    HERP|DERP]
* 12 \\\[if (analcapacity>3) HERP|DERP\\\]
* 12 [if (analcapacity>3) HERP|DERP]
* 13 \\\[if (analcapacity = 0)  HERP|DERP\\\]
* 13 [if (analcapacity = 0)  HERP|DERP]
* 14 \\\[if (analcapacity = 0) HERP|DERP\\\]
* 14 [if (analcapacity = 0) HERP|DERP]
* 15 \\\[if (analcapacity > 0)  HERP|DERP\\\]
* 15 [if (analcapacity > 0)  HERP|DERP]
* 16 \\\[if (analcapacity > 0) HERP|DERP\\\]
* 16 [if (analcapacity > 0) HERP|DERP]
* 17 \\\[if (hasCock == True) HERP|DERP\\\]
* 17 [if (hasCock == True) HERP|DERP]
* 18 \\\[if (hasVagina == True) HERP|DERP\\\]
* 18 [if (hasVagina == True) HERP|DERP]

** Member Accessors**

* 19 \\\[if (player.biggestLactation > 0) HERP|DERP\\\]
* 19 [if (player.biggestLactation > 0) HERP|DERP]
* 20 \\\[if (player.biggestLactation > 0)  \\\[if (hasVagina == True) LOL|WAT\\\]|DERP\\\]
* 20 [if (player.biggestLactation > 0)  [if (hasVagina == True) LOL|WAT]|DERP]
* 21 \\\[if (player.str > 0)  HERP|DERP\\\]
* 21 [if (player.str > 0)  HERP|DERP]
* 22 \\\[if (player.inte > 0)  HERP|DERP\\\]
* 22 [if (player.inte > 0)  HERP|DERP]
* 23 \\\[if (player.biggestTitSize > 0)  HERP|DERP\\\]
* 23 [if (player.biggestTitSize > 0)  HERP|DERP]
* 24 \\\[if (player.biggestLactation > 0)  HERP|DERP\\\]
* 24 [if (player.biggestLactation > 0)  HERP|DERP]
* 25 \\\[if (player.isBiped == true) IS A BIPEDDDDD | not a biped. Wat?\\\]
* 25 [if (player.isBiped == true) IS A BIPEDDDDD | not a biped. Wat?]
* 26 \\\[if (player.isBiped) IS A BIPEDDDDD | not a biped. Wat?\\\]
* 26 [if (player.isBiped) IS A BIPEDDDDD | not a biped. Wat?]
* 27 \\\[if (player.isBipd) IS A BIPEDDDDD | not a biped. Wat?\\\]
* 27 [if (player.isBipd) IS A BIPEDDDDD | not a biped. Wat?]



**Arbitrary function calls**


* \\\[eCockDescript 0\\\] - [eCockDescript 0]
* \\\[eCockDescript\\\] - [eCockDescript]

* \\\[cockDescript 0\\\] - [cockDescript 0]
* \\\[cockDescript\\\] - [cockDescript]
* Generic function calls will be cast to string
* \\\[player.cumQ\\\] - [player.cumQ]
* `\[kFLAGS_REF.ARIAN_COCK_SIZE\]` - [kFLAGS_REF.ARIAN_COCK_SIZE]
* `\[flags kFLAGS_REF.ARIAN_COCK_SIZE\]` - [flags kFLAGS_REF.ARIAN_COCK_SIZE]


**Gender tests**

**PC**

* \\\[He\\\]  - [He]
* \\\[he\\\]  - [he]
* \\\[His\\\]  - [His]
* \\\[his\\\]  - [his]
* \\\[Him\\\]  - [Him]
* \\\[him\\\]  - [him]
* \\\[his\\\]  - [his]
* \\\[His\\\]  - [His]

**NPC**

**Rubi**

* \\\[rubi ey\\\] - [rubi ey]
* \\\[rubi eir\\\] - [rubi eir]
* \\\[rubi eirs\\\] - [rubi eirs]
* \\\[rubi emself\\\] - [rubi emself]
* \\\[rubi Ey\\\] - [rubi Ey]
* \\\[rubi Eir\\\] - [rubi Eir]
* \\\[rubi Eirs\\\] - [rubi Eirs]
* \\\[rubi Emself\\\] - [rubi Emself]

**Arian**

* \\\[arian ey\\\] - [arian ey]
* \\\[arian eir\\\] - [arian eir]
* \\\[arian eirs\\\] - [arian eirs]
* \\\[arian emself\\\] - [arian emself]
* \\\[arian Ey\\\] - [arian Ey]
* \\\[arian Eir\\\] - [arian Eir]
* \\\[arian Eirs\\\] - [arian Eirs]
* \\\[arian Emself\\\] - [arian Emself]

**NPC Aspect tests**

* \\\[arian chest\\\] - [arian chest]
* \\\[arian chestAdj\\\] - [arian chestAdj]
* \\\[rubi breasts\\\] - [rubi breasts]
* \\\[rubi cock\\\] - [rubi cock]

**Typical Noun usages**

* [cock] stiffening [cock biggest] and [vagina] starting to burn with need
* [cock all] stiffening [cock each] and [cock 1] starting to burn with need
* [cockhead biggest] stiffening [cockhead smallest] and [cockhead longest] and [cockhead 1] starting to burn with need

**Complex IF Statement thing**

\\\[if (hasCock = true) \\\[cock\\\] stiffening IFSTUFF \\\[if (hasVagina = true) \\\[vagina\\\] starting to burn with need\\\] IFSTUFFDONE\\\]\\\[if (isHerm = true) and \\\]\\\[if (hasVagina = true) \\\[vagina\\\] starting to burn with need\\\]
[if (hasCock = true) [cock] stiffening IFSTUFF [if (hasVagina = true) [vagina] starting to burn with need] IFSTUFFDONE][if (isHerm = true) and ][if (hasVagina = true) [vagina] starting to burn with need]

**FancyQuotes!**

Convert Apostrophes '
It's a herm!

convert "
"derp a herp"


	]]>);


	menu();
	addButton(4, "Back", debugPane)

}

