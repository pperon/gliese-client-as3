/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.protocol
{
	public class SGSProtocol
	{
		public static const VERSION:int = 0x04;
		
		
		public static const MAX_MESSAGE_LENGTH:int = 65535;
		
		public static const MAX_PAYLOAD_LENGTH:int = 65532;
		
		
		public static const LOGIN_FAILURE:int = 0x12;
		
		public static const LOGIN_REDIRECT:int = 0x13;
		
		public static const LOGIN_REQUEST:int = 0x10;
		
		public static const LOGIN_SUCCESS:int = 0x11;
		
		
		public static const RECONNECT_FAILURE:int = 0x22;
		
		public static const RECONNECT_REQUEST:int = 0x20;
		
		public static const RECONNECT_SUCCESS:int = 0x21;
		
		
		public static const SESSION_MESSAGE:int = 0x30;
		
		
		public static const LOGOUT_REQUEST:int = 0x40;
		
		public static const LOGOUT_SUCCESS:int = 0x41;
		
		
		public static const CHANNEL_JOIN:int = 0x50;
		
		public static const CHANNEL_LEAVE:int = 0x51;
		
		public static const CHANNEL_MESSAGE:int = 0x52; 
	}
}