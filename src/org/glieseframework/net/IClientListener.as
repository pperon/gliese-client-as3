/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.net
{	
	import org.glieseframework.utils.GlieseByteArray;

	public interface IClientListener
	{
		function connected():void;
		function receivedMessage(message:GlieseByteArray):void;
		function joinedChannel(channel:IChannel):void;
		function reconnecting():void;
		function reconnected():void;
		function disconnected(graceful:Boolean, reason:String):void;
		function loggedIn():void;
		function loginFailed(reason:String):void;
		function loggedOut():void;
	}
}