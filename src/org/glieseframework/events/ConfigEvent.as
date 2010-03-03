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
	
	import org.glieseframework.resource.Config;
	
	public class ConfigEvent extends Event
	{
		public static const CONFIG_LOADED:String = "ConfigLoaded";
		
		public function ConfigEvent(type:String, config:Config)
		{
			super(type);
			this.config = config;
		}
		
		public override function clone():Event
		{
			return new ConfigEvent(type, config);
		}
		
		public override function toString():String
		{
			return formatToString("ConfigEvent", "type", "config"); 
		}
		
		public var config:Config;
	}
}