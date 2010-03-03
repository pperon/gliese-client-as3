/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.resources
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import org.glieseframework.events.ConfigEvent;

	public class ConfigLoader extends EventDispatcher
	{
		public function ConfigLoader(parser:ConfigParser)
		{
			_parser = parser;
		}
		
		public function load(source:*):void
		{
			if(source is String)
			{
				loadFile(source);
				return;
			}
			
			if(source is XML)
			{
				parse(source);
				return;
			}
			
			if(source is ByteArray)
			{
				var xml:XML = new XML((source as ByteArray).readUTFBytes((source as ByteArray).bytesAvailable));
				parse(xml);
				return;
			}
			
			throw new Error("Unknown handler source type!");
		}
		
		private function loadFile(source:String):void
		{
			var request:URLRequest = new URLRequest(source);
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loadCompleteHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			loader.load(request);
		}
		
		private function loadCompleteHandler(event:Event):void
		{
			var loader:URLLoader = URLLoader(event.target);
			parse(XML(loader.data));
		}
		
		private function parse(xml:XML):void
		{
			var config:Config = _parser.parse(xml);
			dispatchEvent(new ConfigEvent(ConfigEvent.CONFIG_LOADED, config));
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			// TODO
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void
		{
			// TODO
		}
		
		private var _parser:ConfigParser;
		private var _config:Config;
	}
}