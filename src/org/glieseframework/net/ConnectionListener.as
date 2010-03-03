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
	import org.glieseframework.utils.ChannelMap;
	import org.glieseframework.utils.GlieseByteArray;
	
	public class ConnectionListener implements IConnectionListener
	{
		public function ConnectionListener(clientListener:IClientListener)
		{
			_clientListener = clientListener;
			_channelMap = new ChannelMap();
		}
		
		public function get connection():IConnection
		{
			return _connection;
		}
		
		public function connected(connection:IConnection):void
		{
			_payload = new GlieseByteArray();
			_channelID = new GlieseByteArray();
			_connection = connection;
			_clientListener.connected();
		}
		
		public function bytesReceived(message:GlieseByteArray):void
		{
			_opCode = message.readByte();
			
			switch(_opCode)
			{
				case SGSProtocol.CHANNEL_MESSAGE:
					_channelIDSize = message.readUnsignedShort();
					_channelID.clear();
					_channelID.position = 0;
					message.readBytes(_channelID, 0, _channelIDSize);
					_payload.clear();
					_payload.position = 0;
					message.readBytes(_payload);
					handleChannelMessage(_channelID, _payload);
					break;
				case SGSProtocol.SESSION_MESSAGE:
					_payload.clear();
					_payload.position = 0;
					message.readBytes(_payload);
					handleSessionMessage(_payload);
					break;
				case SGSProtocol.CHANNEL_JOIN:
					_channelID.clear();
					_channelID.position = 0;
					_channelName = message.readUTF();
					message.readBytes(_channelID);
					handleChannelJoin(_channelID, _channelName);
					break;
				case SGSProtocol.CHANNEL_LEAVE:
					_channelID.clear();
					_channelID.position = 0;
					message.readBytes(_channelID);
					handleChannelLeave(_channelID);
					break;
				case SGSProtocol.LOGIN_SUCCESS:
					_reconnectionKey = new GlieseByteArray();
					message.readBytes(_reconnectionKey);
					handleLoginSuccess(_reconnectionKey);
					break;
				case SGSProtocol.LOGIN_FAILURE:
					var reason:String = message.readUTF();
					handleLoginFailure(reason);
					break;
				case SGSProtocol.LOGIN_REDIRECT:
					var host:String = message.readUTF();
					var port:int = message.readInt();
					handleLoginRedirect(host, port);
					break;
				case SGSProtocol.LOGOUT_SUCCESS:
					handleLogoutSuccess();
					break;
				case SGSProtocol.RECONNECT_FAILURE:
					// Reserved for future use.
					break;
				case SGSProtocol.RECONNECT_SUCCESS:
					// Reserved for future use.
					break;
				default:
					handleUnknownOpcode(_opCode);
			}
		}
		
		protected function handleChannelMessage(channelID:GlieseByteArray, payload:GlieseByteArray):void
		{
			var channel:Channel = _channelMap.find(channelID.toString());
			if(channel != null)
				channel.receivedChannelMessage(payload.copy());
			else
				throw new Error("Message sent to unknown channel: " + channelID.toString());
		}
		
		protected function handleSessionMessage(payload:GlieseByteArray):void
		{
			_clientListener.receivedMessage(payload.copy());
		}
		
		protected function handleChannelJoin(channelID:GlieseByteArray, channelName:String):void
		{
			var id:GlieseByteArray = channelID.copy();
			var channel:Channel = new Channel(channelName, id);
			channel.connection = connection;
			_channelMap.insert(id.toString(), channel);
			_clientListener.joinedChannel(channel);
		}
		
		protected function handleChannelLeave(channelID:GlieseByteArray):void
		{
			_channelMap.find(channelID.toString()).left();
			_channelMap.remove(channelID.toString());
		}
		
		protected function handleLoginSuccess(reconnectionKey:GlieseByteArray):void
		{
			_connection.reconnectionKey = reconnectionKey;
			_clientListener.loggedIn();
		}
		
		protected function handleLoginFailure(reason:String):void
		{
			_clientListener.loginFailed(reason);
		}
		
		protected function handleLoginRedirect(host:String, port:int):void
		{
			// TODO
		}
		
		protected function handleLogoutSuccess():void
		{
			_clientListener.loggedOut();
		}
		
		protected function handleUnknownOpcode(opcode:uint):void
		{
			var errmsg:String = "Unknown opcode 0x" + _opCode.toString(16);
			// TODO
		}
		
		private var _connection:IConnection;
		private var _channelID:GlieseByteArray;
		private var _channelIDSize:uint;
		private var _channelName:String;
		private var _channelMap:ChannelMap;
		private var _clientListener:IClientListener;
		private var _opCode:int;
		private var _reconnectionKey:GlieseByteArray;
		private var _payload:GlieseByteArray;
	}
}