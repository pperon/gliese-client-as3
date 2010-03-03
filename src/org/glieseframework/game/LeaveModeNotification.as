/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.game
{
	import org.glieseframework.Gliese;

	public class LeaveModeNotification implements ILeaveModeNotification
	{
		public function LeaveModeNotification()
		{
		}
		
		public function leave(newModeName:String):void
		{
			Gliese.session.setGameMode(Gliese.gameModeManager.getMode(newModeName));
		}
	}
}