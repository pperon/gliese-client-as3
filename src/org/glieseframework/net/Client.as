/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.net
{
	import org.glieseframework.protocol.SGSProtocol;
	import org.glieseframework.utils.GlieseByteArray;
	
	public class Client implements IClient
	{
		
		public function Client(listener:IClientListener)
		{
			_clientListener = listener;
		}
		
		public function isConnected():Boolean
		{
			var result:Boolean;
			if(_connection != null)
				result = _connection.isConnected();
			return result;
		}
		
		public function isLoggedIn():Boolean
		{
			return _loggedIn;
		}
		
		public function connect(props:IConnectionProperties):void
		{
			_connectionProps = props;
			_connection = Connection.getConnection(_connectionProps);
			_connectionListener = new ConnectionListener(_clientListener);
			_connection.connect(_connectionListener);
		}
		
		public function disconnect():void
		{
			_connection.disconnect();
		}
		
		public function login(credentials:ICredentials):void
		{
			if(!isConnected())
			{
				// TODO
			}
			_credentials = credentials;
			_buffer.clear();
			_buffer.position = 0;
			_buffer.writeByte(SGSProtocol.LOGIN_REQUEST);
			_buffer.writeByte(SGSProtocol.VERSION);
			_buffer.writeUTF(_credentials.username);
			_buffer.writeUTF(_credentials.password);
			_connection.send(_buffer);
		}
		
		public function logout(forced:Boolean):void
		{
			if(forced)
			{
				disconnect();
			}
			else
			{
				_buffer.clear();
				_buffer.position = 0;
				_buffer.writeByte(SGSProtocol.LOGOUT_REQUEST);
				_connection.send(_buffer);
			}
		}
		
		public function send(message:GlieseByteArray):void
		{
			if(message.length <= SGSProtocol.MAX_PAYLOAD_LENGTH)
			{
				_buffer.clear();
				_buffer.position = 0;
				_buffer.writeByte(SGSProtocol.SESSION_MESSAGE);
				_buffer.writeBytes(message);
				_connection.send(_buffer);
			}
			else
			{
				// TODO
			}
		}
		
		private var _connection:Connection;
		private var _connectionProps:IConnectionProperties;
		private var _clientListener:IClientListener;
		private var _connectionListener:IConnectionListener;
		private var _credentials:ICredentials;
		private var _loggedIn:Boolean;
		private var _buffer:GlieseByteArray = new GlieseByteArray();
	}
}