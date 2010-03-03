/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.message.common
{
	import org.glieseframework.message.IMessageSpec;
	
	public class ModeChangeMessageSpec implements IMessageSpec
	{
		public function ModeChangeMessageSpec()
		{
		}
		
		public function get opcode():int
		{
			return ModeChangeMessage.OPCODE;
		}
	}
}