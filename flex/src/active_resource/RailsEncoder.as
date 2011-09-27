package active_resource
{
	import bulk_api.BulkEncoder;
	import bulk_api.BulkUtility;
	
	import com.adobe.serialization.json.JSONEncoder;
	import com.adobe.utils.DateUtil;
	import com.ak33m.utils.Inflector;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;

	public class RailsEncoder
	{
		/**
		 * Converts the ActionScript object to a json format that can be send to a Rails application.
		 * 
		 * @param data the resource to convert to JSON
		 * @param options a hash with different saving options. Currently only nestedAttributes is supported.
		 *                For nestedAttributes you specify a flattened object graph. 
		 * 				  I.e assuming parent has many children and child has many hobbies
		 *                I.e {nestedAttributes:['children','children.hobbies']}
		 */
		static public function objectToRails(data:Object, options:Object=null):String {
			var result:String = to_rails(encodeObject(data, options)); 
			if (data is ActiveResource && options && options.nestedAttributes) {
				result = '{"'+Inflector.singularize((data as ActiveResource).resourceName)+'":'+result+'}'
			}
			return result
		}
		
		static public function collectionToRails(collection:ArrayCollection, options:Object=null):String {
			return to_rails(encodeArray(collection, options));			
		}
		
		static protected function to_rails(data:Object):String {
			var json:String = new JSONEncoder(data).getString();
			return json;
		}		
		
		// FIXME: encodeArray and encodeObject are based on the BulkEncoder but I've added
		//		  the nestedAttribute support which is not compatible with the bulk_api.
		//        see _local_id is needed (or find a way to map errors to proper client side instance without an id).
		
		// parentAttributeNames is used for nested attribute to check againt the flattened object graph
		static public function encodeArray(records:ArrayCollection, options:Object=null, parentAttributeNames:Array=null):Array {
			if (parentAttributeNames==null) parentAttributeNames = [];			
			var result:Array = [];
			for each (var record:Object/*BulkResource instance*/ in records) {
				result.push(encodeObject(record, options, parentAttributeNames));
			}
			return result;
		}		
		
		static public function encodeObject(record:Object, options:Object=null, parentAttributeNames:Array=null):Object {
			if (parentAttributeNames==null) parentAttributeNames = [];
			if (record is ObjectProxy) {
				var result:Object = {};
				var attributes:Object = Reflection.getAttributes(record);
				for each (var attribute:Object in attributes) {
					var attributeName:String = attribute.name;
					var value:* = record[attributeName];
					// Check if nested attribute, then add "_attributes" to attribute name
					var attributePath:Array = parentAttributeNames.concat(attributeName); // Increment attribute to path
					var resultAttribute:String = attributeName;
					if (options &&options.nestedAttributes&&options.nestedAttributes.indexOf(attributePath.join('.'))>-1) 
						resultAttribute += "_attributes";
					if (value is ArrayCollection) {
						result[resultAttribute] = encodeArray(value, options, attributePath); 
					} else if (value  is ActiveResource) {
						result[resultAttribute] = encodeObject(value, options, attributePath); // FIXME: add test case for this scenario.
					} else {
						if (attribute.type=="Date"&&value is Date) {
							result[resultAttribute] = DateUtil.toW3CDTF(value);
						} else {
							result[resultAttribute] = value;
						}
					}
				}
				if (record['_destroy']) result._destroy = record['_destroy']; // FIXME: find nicer code for non-attribute columns that should be sent to server
				//result._local_id = record.uid;
				return result;
			} 
			else {
				return record;
			}
		}		
	}
}