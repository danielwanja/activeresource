package active_resource
{
	import bulk_api.BulkEncoder;
	import bulk_api.BulkResource;
	
	import com.adobe.serialization.json.JSONEncoder;
	
	import mx.collections.ArrayCollection;

	public class RailsEncoder
	{
		static public function objectToRails(data:Object):String {
			return to_rails(BulkEncoder.encodeObject(data))
		}
		
		static public function collectionToRails(collection:ArrayCollection):String {
			return to_rails(BulkEncoder.encodeArray(collection));			
		}
		
		static protected function to_rails(data:Object):String {
			var json:String = new JSONEncoder(data).getString();
			return json;
		}		
	}
}