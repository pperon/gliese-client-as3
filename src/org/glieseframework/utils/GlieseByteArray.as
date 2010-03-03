/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.utils
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class GlieseByteArray extends ByteArray
	{
		public function GlieseByteArray()
		{
			super();
			this.endian = Endian.BIG_ENDIAN;
		}
		
		public function copy():GlieseByteArray
		{
			var pos:uint = position;
			var copy:GlieseByteArray = new GlieseByteArray();
			position = 0;
			readBytes(copy);
			copy.position = position = pos;
			return copy;
		}
		
		/**
		 * Compacts the byte array. 
		 * 
		 * The bytes between the current position and it's limit are copied to 
		 * the beginning of the the array. The position is then set to the
		 * number of bytes copied.
		 */
		public function compact():void
		{
			// TODO make sure you write a test for this!
			
			var newpos:uint = this.bytesAvailable;
			var buf:GlieseByteArray = new GlieseByteArray();
			this.readBytes(buf);
			this.clear();
			this.position = 0;
			buf.readBytes(this);
			this.position = newpos - 1;
		}
		
		override public function toString():String
		{
			var str:String = "";
			var pos:uint = position;
			position = 0;
			while(bytesAvailable > 0) str += readByte().toString(16) + ":";
			position = pos;
			return str;
		}
	}
}