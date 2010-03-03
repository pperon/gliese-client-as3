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

	public interface IChannel
	{
		function get name():String;
		function get id():GlieseByteArray;
		function set connection(connection:IConnection):void;
		function set listener(listener:IChannelListener):void;
		function send(buffer:GlieseByteArray):void;
		function receivedChannelMessage(message:GlieseByteArray):void;
		function left():void;
	}
}