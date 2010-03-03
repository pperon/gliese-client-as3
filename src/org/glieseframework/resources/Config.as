/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.resources
{
	public class Config
	{
		public function addHandler(opcode:int, handler:String):void
		{
			handlers[opcode] = handler;
		}
		
		public function addGameMode(modeName:String, gameMode:String):void
		{
			gameModes[modeName] = gameMode;
		}
		
		public var host:String;
		public var port:int;
		public var handlers:Object = {};
		public var gameModes:Object = {}; 
	}
}