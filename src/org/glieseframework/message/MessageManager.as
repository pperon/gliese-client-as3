/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.message
{
	import flash.events.EventDispatcher;
	
	import org.glieseframework.utils.GlieseByteArray;
	
	// TODO: A Handler list can get pretty lengthy. Support for loading multiple 
	// files or embedded resources should be supported.
	
	public class MessageManager extends EventDispatcher implements IMessageManager
	{
		public function encodeMessage(spec:IMessageSpec):GlieseByteArray
		{
			return getHandler(spec.opcode).encodeMessage(spec);
		}
		
		public function decodeMessage(message:GlieseByteArray):IMessage
		{
			message.position = 0;
			var opcode:int = message.readShort();
			return getHandler(opcode).decodeMessage(opcode, message);
		}
		
		public function addHandler(opcode:int, handler:Class):void
		{
			// TODO: Add check to make sure the handler implements IMessageHandler.
			_handlers[opcode] = new handler();
		}
		
		private function getHandler(opcode:int):IMessageHandler
		{
			var handler:IMessageHandler = _handlers[opcode];
			if(handler != null)
				return _handlers[opcode];
			else
				throw new Error("Unable to locate handler for opcode: " + opcode);
		}
		
		// TODO: Should we vectorize this bad boy instead?
		private var _handlers:Object = {};
	}
}