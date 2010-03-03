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

	public interface IMessageHandler
	{
		function encodeMessage(spec:IMessageSpec):GlieseByteArray;
		function decodeMessage(opcode:int, message:GlieseByteArray):IMessage;
	}
}