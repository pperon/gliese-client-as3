/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.message
{
	import org.glieseframework.utils.GlieseByteArray;

	public class Message implements IMessage
	{	
		public function Message(opcode:int)
		{
			_opcode = opcode;
		}
		
		public function get opcode():int
		{
			return _opcode;
		}
		
		protected function setupBuffer():GlieseByteArray
		{
			var buffer:GlieseByteArray = new GlieseByteArray();
			buffer.writeShort(opcode);
			return buffer;
		}
		
		private var _opcode:int;
	}
}