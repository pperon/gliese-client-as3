/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.message.common
{
	import org.glieseframework.message.IMessage;
	import org.glieseframework.message.IMessageHandler;
	import org.glieseframework.message.IMessageSpec;
	import org.glieseframework.utils.GlieseByteArray;
	
	public class ModeChangeMessageHandler implements IMessageHandler
	{
		public function ModeChangeMessageHandler()
		{
		}
		
		public function encodeMessage(spec:IMessageSpec):GlieseByteArray
		{
			return null;
		}
		
		public function decodeMessage(opcode:int, message:GlieseByteArray):IMessage
		{
			if(ModeChangeMessage.OPCODE != opcode)
				throw new Error("Can't decode message type! [opcode: " + opcode);
			return new ModeChangeMessage(message.readUTFBytes(message.bytesAvailable));
		}
	}
}