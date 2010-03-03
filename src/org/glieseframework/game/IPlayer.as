/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.game
{
	import org.glieseframework.message.IMessageSpec;
	import org.glieseframework.utils.GlieseByteArray;

	public interface IPlayer
	{
		function get name():String;
		function get id():GlieseByteArray;
		function get gameMode():IGameMode;
		function get wantsToHearMessages():Boolean;
		function get items():Object;
		function send(spec:IMessageSpec):void;
	}
}