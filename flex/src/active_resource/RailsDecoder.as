package active_resource
{
	import bulk_api.BulkDecoder;
	import bulk_api.BulkResource;
	
	import com.adobe.serialization.json.JSONDecoder;
	
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
			var resourceName:String = resourceClass is String ? resourceClass : BulkResource.resourceForClass(resourceClass);
			var actionScript:Object = new JSONDecoder(json, /*strict*/true).getValue();
			// FIXME: Add Rails validation errors support
			if (actionScript is Array) {
				return BulkDecoder.decodeArray(resourceName, actionScript as Array);
			} else {
				return BulkDecoder.cast(resourceName, actionScript);
			}
			return actionScript;
		}
	}
}