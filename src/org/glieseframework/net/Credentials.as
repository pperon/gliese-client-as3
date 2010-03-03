/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.net
{
	
	public class Credentials implements ICredentials
	{
		public function Credentials(username:String, password:String)
		{
			_username = username;
			_password = password;
		}
		
		public function get username():String
		{
			return _username;
		}
		
		public function get password():String
		{
			return _password;
		}
		
		private var _username:String;
		private var _password:String;
	}
}