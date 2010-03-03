/*******************************************************************************
 * Gliese AS3 Client
 * Copyright (C) Phil Peron
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the LICENSE.txt file at the root directory of this API.
 ******************************************************************************/
package org.glieseframework.resources
{
	public class ConfigParser
	{
		public function parse(xml:XML):Config
		{
			var config:Config = new Config();
			
			for each(var node:XML in xml.children())
			{
				if(node.localName().toString().toLowerCase() == "darkstar")
				{
					config.host = node.attribute("host");
					config.port = node.attribute("port");
				}
				
				if(node.localName().toString().toLowerCase() == "handlers")
				{
					for each(var handler:XML in node.children())
					{
						config.addHandler(handler.attribute("opcode"), handler.attribute("class"));
					}
				}
				
				if(node.localName().toString().toLowerCase() == "gamemodes")
				{
					for each(var gameMode:XML in node.children())
					{
						config.addGameMode(gameMode.attribute("name"), gameMode.attribute("class"));
					}
				}
			}
			
			return config;
		}
	}
}