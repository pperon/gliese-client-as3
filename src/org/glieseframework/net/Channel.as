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
	
	public class Channel implements IChannel
	{
		public function Channel(name:String, id:GlieseByteArray)
		{
			_name = name;
			_id = id;
			_idLength = _id.length;
			_message = new GlieseByteArray();
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get id():GlieseByteArray
		{
			return _id.copy();
		}
		
		public function set connection(connection:IConnection):void
		{
			_connection = connection;
		}
		
		public function set listener(listener:IChannelListener):void
		{
			_listener = listener;
		}
		
		public function send(buffer:GlieseByteArray):void
		{
			if(_connection != null)
			{
				_message.clear();
				_message.position = 0;
				_message.writeByte(SGSProtocol.CHANNEL_MESSAGE);
				_message.writeShort(_idLength);
				_message.writeBytes(id);
				_message.writeBytes(buffer);
				_connection.send(_message);
			}
		}
		
		public function receivedChannelMessage(message:GlieseByteArray):void
		{
			if(_listener != null)
			{
				_listener.receivedChannelMessage(message);
			}
		}
		
		public function left():void
		{
			// TODO add cleanup code here.
		}
		
		private var _name:String;
		private var _id:GlieseByteArray;
		private var _idLength:uint;
		private var _connection:IConnection;
		private var _listener:IChannelListener;
		private var _message:GlieseByteArray;
	}
}