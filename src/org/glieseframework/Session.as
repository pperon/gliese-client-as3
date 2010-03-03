/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework
{
	import org.glieseframework.game.IGameMode;
	import org.glieseframework.game.UserPlayer;
	import org.glieseframework.message.IMessage;
	import org.glieseframework.net.IChannel;
	import org.glieseframework.net.IClient;
	import org.glieseframework.net.IClientListener;
	import org.glieseframework.net.ICredentials;
	import org.glieseframework.net.Client;
	import org.glieseframework.net.ConnectionProperties;
	import org.glieseframework.net.Credentials;
	import org.glieseframework.utils.GlieseByteArray;
	
	public class Session implements IClientListener
	{
		public function Session(host:String, port:int)
		{
			_host = host;
			_port = port;
		}
		
		public function setGameMode(gameMode:IGameMode):void
		{
			_gameMode = gameMode;
		}
		
		public function login(username:String, password:String):UserPlayer
		{
			_credentials = new Credentials(username, password);
			
			if(_client == null)
				_client = new Client(this);
			
			if(!_client.isConnected())
				_client.connect(new ConnectionProperties(_host, _port));
			
			return new UserPlayer(_client);
		}
		
		public function connected():void
		{
			_client.login(_credentials);
		}
		
		public function receivedMessage(message:GlieseByteArray):void
		{
			_message = Gliese.messageManager.decodeMessage(message);
			_gameMode.handleMessage(_message);
		}
		
		public function joinedChannel(channel:IChannel):void
		{
			// TODO
		}
		
		public function reconnecting():void
		{
			// TODO
		}
		
		public function reconnected():void
		{
			// TODO
		}
		
		public function disconnected(graceful:Boolean, reason:String):void
		{
			// TODO
		}
		
		public function loggedIn():void
		{
			// TODO
		}
		
		public function loginFailed(reason:String):void
		{
			// TODO
		}
		
		public function loggedOut():void
		{
			// TODO
		}
		
		private var _client:IClient;
		private var _credentials:ICredentials;
		private var _gameMode:IGameMode;
		private var _host:String;
		private var _message:IMessage;
		private var _port:int;
	}
}