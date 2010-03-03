/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.net
{
	
	public class ConnectionProperties implements IConnectionProperties
	{
		public function ConnectionProperties(host:String, port:int)
		{
			_host = host;
			_port = port;
		}
		
		public function get host():String
		{
			return _host;
		}
		
		public function get port():int
		{
			return _port;
		}
		
		private var _host:String;
		private var _port:int;
	}
}