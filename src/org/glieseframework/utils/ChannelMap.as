/**
 * DATA STRUCTURES FOR GAME PROGRAMMERS
 * Copyright (c) 2007 Michael Baczynski, http://www.polygonal.de
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

/**
 * The following represents a pared down version of HashMap called
 * ChannelMap. The original source is no longer supported by it's 
 * author but can be found here: http://github.com/jaybaird/as3ds
 */

package org.glieseframework.utils
{
	import flash.utils.Dictionary;
	
	import org.glieseframework.net.Channel;
	
	public class ChannelMap
	{
		/**
		 * Initializes a new ChannelMap instance.
		 * 
		 * @param size The initial capacity of the ChannelMap. 
		 */
		public function ChannelMap(size:int = 500)
		{
			_initSize = _maxSize = Math.max(10, size);
			
			_keyMap = new Dictionary(true);
			_dupMap = new Dictionary(true);
			_size = 0;
			
			var node:ChannelNode = new ChannelNode();
			_head = _tail = node;
			
			var k:int = _initSize + 1;
			for (var i:int = 0; i < k; i++)
			{
				node.next = new ChannelNode();
				node = node.next;
			}
			_tail = node;
		}
		
		/**
		 * Inserts a key/data couple into the table.
		 * 
		 * @param key The key.
		 * @param obj The data associated with the key.
		 */
		public function insert(key:String, channel:Channel):Boolean
		{
			if (key == null)  return false;
			if (channel == null)  return false;
			if (_keyMap[key]) return false;
			
			if (_size++ == _maxSize)
			{
				var k:int = (_maxSize += _initSize) + 1;
				for (var i:int = 0; i < k; i++)
				{
					_tail.next = new ChannelNode();
					_tail = _tail.next;
				}
			}
			
			var node:ChannelNode = _head;
			_head = _head.next;
			node.key = key;
			node.channel = channel;
			
			node.next = _channel;
			if (_channel) _channel.prev = node;
			_channel = node;
			
			_keyMap[key] = node;
			_dupMap[channel] ? _dupMap[channel]++ : _dupMap[channel] = 1;
			
			return true;
		}
		
		/**
		 * Finds the channel that is associated with the given key.
		 * 
		 * @param  key The key mapping a value.
		 * @return The channel associated with the key or null if no matching
		 *         entry was found.
		 */
		public function find(key:String):Channel
		{
			var node:ChannelNode = _keyMap[key];
			if (node) return node.channel;
			return null;
		}
		
		/**
		 * Removes a channel based on a given key.
		 * 
		 * @param  key The entry's key.
		 * @return The channel associated with the key or null if no matching
		 *         entry was found.
		 */
		public function remove(key:String):Channel
		{
			var node:ChannelNode = _keyMap[key];
			if (node)
			{
				var channel:* = node.channel;
				
				delete _keyMap[key];
				
				if (node.prev) node.prev.next = node.next;
				if (node.next) node.next.prev = node.prev;
				if (node == _channel) _channel = node.next;
				
				node.prev = null;
				node.next = null;
				_tail.next = node;
				_tail = node;
				
				if (--_dupMap[channel] <= 0)
					delete _dupMap[channel];
				
				if (--_size <= (_maxSize - _initSize))
				{
					var k:int = (_maxSize -= _initSize) + 1;
					for (var i:int = 0; i < k; i++)
						_head = _head.next;
				}
				
				return channel;
			}
			return null;
		}
		
		private var _keyMap:Dictionary;
		private var _dupMap:Dictionary;
		
		private var _initSize:int;
		private var _maxSize:int;
		private var _size:int;
		
		private var _channel:ChannelNode;
		private var _head:ChannelNode;
		private var _tail:ChannelNode;
	}
}

import org.glieseframework.net.Channel;
import org.glieseframework.utils.GlieseByteArray;

internal class ChannelNode
{
	public var key:String;
	public var channel:Channel;
	
	public var prev:ChannelNode;
	public var next:ChannelNode;
}