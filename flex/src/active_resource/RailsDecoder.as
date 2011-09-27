package active_resource
{
	import bulk_api.BulkDecoder;
	
	import com.adobe.serialization.json.JSONDecoder;
	import com.adobe.utils.DateUtil;
	import com.adobe.utils.StringUtil;
	
	import mx.collections.ArrayCollection;

	public class RailsDecoder
	{
		/**
		 * Converts the JSON received from Rails into ActionScript data structure.
		 * 
		 * @param resourceNameOrClass represents the rources name as a string, i.e. "departments", or the class i.e. Department.
		 * @param json is the JSON formatted string as provided by Rails.
		 * @return the translated ActionScript structure like anarray of Resources or a instance of a Resource depending on the call type.
		 */
		static public function from_rails(resourceClass:*, json:String):Object {
			var resourceName:String = resourceClass is String ? resourceClass : ClassRegistry.resourceForClass(resourceClass);
			var actionScript:Object = StringUtil.trim(json)!="" ? new JSONDecoder(json, /*strict*/true).getValue() : null;
			// FIXME: Add Rails validation errors support
			if (actionScript is Array) {
				return decodeArray(resourceName, actionScript as Array);
			} else if (actionScript != null) {
				return cast(resourceName, actionScript);
			}
			return actionScript;
		}
		
		// FIXME: merge/refactor the following with the BulkDecoder
		static public function decodeArray(resourceName:String, records:Array):ArrayCollection {
			var result:Array = [];
			for each (var record:Object in records) {
				result.push(cast(resourceName, record));	   
			}
			return new ArrayCollection(result);
		}
		
		static public function cast(resourceName:String, record:Object):Object {
			var clazz:Class = ClassRegistry.classForResource(resourceName); 
			var instance:Object = new clazz();
			var attributes:Object = Reflection.getAttributes(instance);
			for (var attr:String in record) {
				var value:* = record[attr];
				if (value is Array) {
					instance[attr] = decodeArray(attr, value as Array);
				} else {
					if (attributes[attr].type != "Date") {
						instance[attr] = value;
					} else {
						if (value is String && value.length == 10) value = value+"T00:00:00Z"
						instance[attr] = value ? DateUtil.parseW3CDTF(value) : null;
					}
				}
				// TODO: add test to check if instance is dynamic (use describeType+type+.isDynamic)
				// TODO: transform date fields based on metadata.json or other mechanism
			}
			return instance;
		}		
	}
}