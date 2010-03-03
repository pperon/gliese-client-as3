/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.game
{
	import org.glieseframework.message.IMessage;
	import org.glieseframework.message.common.ModeChangeMessage;
	
	public class GameMode implements IGameMode
	{
		public function GameMode(leaveModeNotification:ILeaveModeNotification)
		{
			_leaveModeNotification = leaveModeNotification;
		}
		
		public function handleMessage(message:IMessage):void
		{
			if(message.opcode == ModeChangeMessage.OPCODE)
				_leaveModeNotification.leave((message as ModeChangeMessage).modeName);
		}
		
		private var _leaveModeNotification:ILeaveModeNotification;
	}
}