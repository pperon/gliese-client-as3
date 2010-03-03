/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.net
{
	import org.glieseframework.utils.GlieseByteArray;

	public interface IChannelListener
	{
		function receivedChannelMessage(message:GlieseByteArray):void;
	}
}