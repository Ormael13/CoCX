/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc {
import classes.Appearance;
import classes.BodyParts.Skin;
import classes.CoC;
import classes.CockTypesEnum;
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;

import coc.xlogic.ExecContext;

public class StoryContext extends ExecContext{
	public var game:CoC;
	public function StoryContext(game:CoC) {
		super([
			game,
			CoC,
			{
				Appeearance:Appearance,
				CockTypesEnum:CockTypesEnum,
				kFLAGS:kFLAGS,
				kGAMECLASS:kGAMECLASS,
				Skin:Skin
			}
		]);
		this.game = game;
	}
}
}
