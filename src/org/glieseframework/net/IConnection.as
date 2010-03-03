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

	public interface IConnection
	{
		function connect(listener:IConnectionListener):void;
		function disconnect():void;
		function isConnected():Boolean;
		function send(buffer:GlieseByteArray):void;
		function set reconnectionKey(reconnectionKey:GlieseByteArray):void;
	}
}