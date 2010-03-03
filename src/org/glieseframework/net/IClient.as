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

	public interface IClient
	{
		function connect(props:IConnectionProperties):void;
		function disconnect():void;
		function isConnected():Boolean;
		function login(credentials:ICredentials):void;
		function isLoggedIn():Boolean;
		function logout(force:Boolean):void;
		function send(message:GlieseByteArray):void;
	}
}