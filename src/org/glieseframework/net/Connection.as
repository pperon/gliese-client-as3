/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.net
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import org.glieseframework.protocol.SGSProtocol;
	import org.glieseframework.utils.GlieseByteArray;

	[Event(name="close", type="flash.events.Event")]
	[Event(name="connect", type="flash.events.Event")]
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	[Event(name="securityError", type="flash.events.SecurityErrorEvent")]
	public class Connection implements IConnection
	{	
		public static function getConnection(props:IConnectionProperties):Connection
		{
			if(!_instance)
				_instance = new Connection(props);
			
			return _instance;
		}
		
		private static var _instance:Connection = null;
		
		public function Connection(props:IConnectionProperties)
		{
			_host = props.host;
			if(props.port < 0 || props.port > 65535)
				throw new RangeError("port " + props.port + " is out of the acceptable range [0-65535].");
			else
				_port = props.port;
		}
		
		public function connect(listener:IConnectionListener):void
		{
			_connectionListener = listener;
			
			if(_socket && _socket.connected) cleanUp();
			
			_socket = new Socket();
			_socket.addEventListener(Event.CLOSE, closeHandler);
			_socket.addEventListener(Event.CONNECT, connectHandler);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, dataHandler);
			
			try
			{
				_socket.connect(_host, _port);
			}
			catch(e:SecurityError)
			{
				// TODO: Should we be doing anything else here?
				throw e;
			}
		}
		
		public function disconnect():void
		{
			cleanUp();
		}
		
		public function isConnected():Boolean
		{
			return _socket.connected;
		}
		
		public function send(buffer:GlieseByteArray):void
		{
			try
			{
				buffer.position = 0;
				_socket.writeShort(buffer.length);
				_socket.writeBytes(buffer);
				_socket.flush();
			}
			catch(error:IOError)
			{
				// TODO
			}
		}
		
		public function set reconnectionKey(reconnectionKey:GlieseByteArray):void
		{
			_reconnectionKey = reconnectionKey;
		}
		
		protected function connectHandler(event:Event):void
		{
			_connectionListener.connected(this);
			_dataBuffer = new GlieseByteArray();
			_msgBuffer = new GlieseByteArray();
		}
		
		protected function dataHandler(event:Event):void
		{
			_dataBuffer.clear();
			_dataBuffer.position = 0;
			
			try
			{
				_socket.readBytes(_dataBuffer);
			}
			catch(e:IOError)
			{
				// TODO: Is the best way to deal with an IO error?
				cleanUp();
				return;
			}
			
			while (_dataBuffer.bytesAvailable > 2)
			{
				_msgSize = _dataBuffer.readUnsignedShort();
				
				if(_dataBuffer.bytesAvailable >= _msgSize)
				{
					_msgBuffer.clear();
					// the docs say that clear() sets the position to zero.
					// this is a lie.
					_msgBuffer.position = 0;
					_dataBuffer.readBytes(_msgBuffer, 0, _msgSize);
					_connectionListener.bytesReceived(_msgBuffer);
				}
				else
				{
					_dataBuffer.position -= 2;
					break;
				}
			}
			
			// handle message segmentation
			if(_dataBuffer.bytesAvailable > 0)
			{
				trace("Message segmentation occurred!");
				_dataBuffer.compact();
			}
		}
		
		protected function closeHandler(event:Event):void
		{
			// TODO
		}
		
		protected function ioErrorHandler(event:IOErrorEvent):void
		{
			// TODO
		}
		
		protected function securityErrorHandler(event:SecurityErrorEvent):void
		{
			// TODO
		}
		
		private function cleanUp():void
		{
			_dataBuffer.clear();
			_dataBuffer.position = 0;
			_msgBuffer.clear();
			_dataBuffer.position = 0;
			_socket.removeEventListener(Event.CLOSE, closeHandler);
			_socket.removeEventListener(Event.CONNECT, connectHandler);
			_socket.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_socket.removeEventListener(ProgressEvent.SOCKET_DATA, dataHandler);
			_socket.close();
			_socket = null;
		}
		
		private var _host:String;
		private var _port:int;
		private var _socket:Socket;
		private var _connectionListener:IConnectionListener;
		private var _dataBuffer:GlieseByteArray;
		private var _msgBuffer:GlieseByteArray;
		private var _msgSize:uint;
		private var _reconnectionKey:GlieseByteArray;
	}
}