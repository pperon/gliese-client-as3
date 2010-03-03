/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.game
{
	public class GameModeManager
	{	
		public function addMode(modeName:String, modeClass:Class):void
		{
			// TODO: Add check to make sure the handler implements IGameMode.
			// (instantiate, check without assignment?)
			_gameModes[modeName] = modeClass;
		}
		
		public function getMode(modeName:String):IGameMode
		{
			var mode:Class = _gameModes[modeName];
			if(mode != null)
				return new mode();
			else
				throw new Error("Unable to locate game mode: " + modeName);
		}
		
		private var _gameModes:Object = {};
	}
}