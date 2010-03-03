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
	import org.glieseframework.message.IMessageSpec;
	import org.glieseframework.net.IClient;
	import org.glieseframework.utils.GlieseByteArray;
	
	public class UserPlayer implements IPlayer
	{
		public function UserPlayer(client:IClient)
		{
			_client = client;
		}
		
		public function get name():String
		{
			return null;
		}
		
		public function get id():GlieseByteArray
		{
			return null;
		}
		
		public function get gameMode():IGameMode
		{
			return null;
		}
		
		public function get wantsToHearMessages():Boolean
		{
			return false;
		}
		
		public function get items():Object
		{
			return null;
		}
		
		public function send(spec:IMessageSpec):void
		{
			_client.send(Gliese.messageManager.encodeMessage(spec));
		}
		
		private var _client:IClient;
	}
}