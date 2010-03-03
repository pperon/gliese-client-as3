/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework
{
	import flash.utils.getDefinitionByName;
	
	import org.glieseframework.events.ConfigEvent;
	import org.glieseframework.game.GameMode;
	import org.glieseframework.game.GameModeManager;
	import org.glieseframework.game.LeaveModeNotification;
	import org.glieseframework.message.MessageManager;
	import org.glieseframework.resource.Config;
	import org.glieseframework.resource.ConfigLoader;
	import org.glieseframework.resource.ConfigParser;

	/**
	 * 
	 * A helper class primarily used to initialize a Session given a configuration file.
	 * 
	 */	
	public class Gliese
	{
		
		/**
		 * 
		 * @param properties
		 * @param callback
		 * 
		 */		
		public static function initialize(properties:*, callback:Function):void
		{
			_callback = callback;
			var loader:ConfigLoader = new ConfigLoader(new ConfigParser());
			loader.addEventListener(ConfigEvent.CONFIG_LOADED, configLoadedHandler);
			loader.load(properties);
		}
		
		
		/**
		 * Facilitates the inclusion of class definitions that are not declared until runtime.
		 * 
		 * @param classDef
		 * 
		 */		
		public static function registerClass(classDef:Class):void {}
		
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public static function get messageManager():MessageManager
		{
			return _messageManager;	
		}
		
		
		/**
		 *
		 * @return A Session instance. 
		 * 
		 */
		public static function get session():Session
		{
			return _session;
		}
		
		public static function get gameModeManager():GameModeManager
		{
			return _gameModeManager;
		}
			
		private static function configLoadedHandler(event:ConfigEvent):void
		{
			(event.target as ConfigLoader).removeEventListener(
				ConfigEvent.CONFIG_LOADED, ConfigLoadedHandler
			);
			
			var config:Config = event.config;
			
			_messageManager = new MessageManager();
			for(var opcode:* in config.handlers)
			{
				_messageManager.addHandler(
					opcode, getDefinitionByName(config.handlers[opcode]) as Class
				);
			}
			
			_gameModeManager = new GameModeManager();
			for(var gameMode:* in config.gameModes)
			{
				_gameModeManager.addMode(
					gameMode, getDefinitionByName(config.gameModes[gameMode]) as Class
				);
			}
			
			
			_session = new Session(config.host, config.port);
			_session.setGameMode(new GameMode(new LeaveModeNotification()));
			
			// TODO: is passing a session instance to the callback necessary when it's 
			// easily accessed via the static getter? I'm not sure which is better.
			_callback(_session);
		}
		
		private static var _callback:Function;
		private static var _gameModeManager:GameModeManager;
		private static var _messageManager:MessageManager;
		private static var _session:Session;
	}
}