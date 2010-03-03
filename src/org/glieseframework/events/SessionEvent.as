/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.events
{
	import flash.events.Event;
	
	import org.glieseframework.Session;
	
	public class SessionEvent extends Event
	{
		public static const SESSION_START:String = "sessionStart";
		
		public var session:Session;
		
		public function SessionEvent(type:String, session:Session)
		{
			super(type);
			this.session = session;
		}
		
		override public function clone():Event
		{
			return new SessionEvent(type, session);
		}
		
		public override function toString():String
		{
			return formatToString("SessionEvent", "type"); 
		}
	}
}