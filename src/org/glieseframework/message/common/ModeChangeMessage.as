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
	import org.glieseframework.message.Message;
	
	public class ModeChangeMessage extends Message implements IMessage
	{
		public function ModeChangeMessage(modeName:String)
		{
			super(OPCODE);
			this.modeName = modeName;
		}
		
		public static const OPCODE:int = 3;
		
		public var modeName:String;
	}
}