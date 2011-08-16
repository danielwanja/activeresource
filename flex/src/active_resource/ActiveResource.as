package active_resource
{
	import bulk_api.BulkUtility;
	
	import flash.utils.getDefinitionByName;
	
	import mx.collections.ArrayCollection;
	import mx.core.mx_internal;
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.ObjectProxy;
	
	/**
	 * A dynamic class that maps to a Resource. Can be used for CRUD operations.
	 * 
	 * Is based on bulk_api.ActiveResource and common code will be factored out between 
	 * the bulk_api and the active_resource projects.
	 * 
	 * Follows the Rails REST convention. For the employees resource the following calls are supported:
	 * 
     *                Verb    Url                      Action
	 *      employees GET    /employees(.:format)      index
	 *                POST   /employees(.:format)      create
	 *       employee GET    /employees/:id(.:format)  show
	 *                PUT    /employees/:id(.:format)  update
	 *                DELETE /employees/:id(.:format)  delete
	 *
	 */
	public dynamic class ActiveResource extends ObjectProxy
	{
		static public var baseUrl:String = "http://localhost:3000";
		public function ActiveResource(attributes:Object=null) {
			super();
			BulkUtility.copyAttributes(attributes, this);
		}
		
		static public function find(clazz:Class, id:Number):AsyncToken {
			var http:HTTPService = new HTTPService();
			http.url = baseUrl+"/"+resourceForClass(clazz)+"/"+id;
			return send(http);
		}
		
		static public function findAll(clazz:Class):AsyncToken {
			var http:HTTPService = new HTTPService();
			http.url = baseUrl+"/"+resourceForClass(clazz);
			return send(http);			
		}
		
		static public function create(clazz:Class, data:Object):AsyncToken {
			var http:HTTPService = new HTTPService();
			http.url = baseUrl+"/"+resourceForClass(clazz);
			http.method = "POST";
			http.resultFormat = "text";
			http.contentType = "application/json";			
			return send(http, RailsEncoder.to_rails(data), data)
		}
		
		static public function update(clazz:Class, data:Object):AsyncToken {
			var http:HTTPService = new HTTPService();
			http.url = baseUrl+"/"+resourceForClass(clazz)+"/"+data.id;
			http.method = "POST";
			http.headers={X_HTTP_METHOD_OVERRIDE:'put'}; // tell Rails we really want a put
			http.resultFormat = "text";
			http.contentType = "application/json";
			return send(http, RailsEncoder.to_rails(data), data)
		}
		
		static public function destroy(clazz:Class, data:Object):AsyncToken {
			var http:HTTPService = new HTTPService();
			http.url = baseUrl+"/"+resourceForClass(clazz)+"/"+data.id
			http.method = "POST";
			http.headers={X_HTTP_METHOD_OVERRIDE:'delete'}; // tell Rails we really want a delete
			http.resultFormat = "text";
			http.contentType = "application/json";
			return send(http, RailsEncoder.to_rails(data), data)
		}
		
		//-----------------------------------------------------------
		// DATA CONVERSION METHODS
		//-----------------------------------------------------------
		static public var send:Function = sendImplementation;
		
		static public function sendImplementation(service:HTTPService, params:Object=null, originalData:Object=null):AsyncToken {
			var call:AsyncToken = service.send(params);
			call.addResponder(new AsyncResponder(handleResult, handleFault));
			call.originalData = originalData; // token
			return call;			
		}
		
		static public function handleResult(event:ResultEvent, token:Object=null):void {
			event.mx_internal::setResult(mapErrors(RailsDecoder.from_rails(event.result as String), event.token.originalData));
		}
		
		static protected function handleFault(fault:FaultEvent, token:Object=null):void {
			// TODO: see how to deal with error object
		}
		
		//-----------------------------------------------------------
		// HANDLE ERRORS
		//-----------------------------------------------------------
		
		/**
		 * map errors to originalData if present
		 */
		static protected function mapErrors(data:Object, originalData:Object):Object {
			var errors:Object = data ? data.errors : null;
			if (errors==null) return data;
			var resources:Array = BulkUtility.getAttributeNames(errors);
			for each (var resource:String in resources) {
				mapErrorsForResource(errors[resource], originalData[resource])
				
			}
			return originalData;	// FIXME: returning original data with errors replaced or shall we just return objects with errors?
		}
		
		static protected function mapErrorsForResource(errors:Object, objects:ArrayCollection):void {
			if (objects==null) return; // FIXME: check if that situation can occur.
			for each (var object:ActiveResource in objects) {  // clear errors
				object.errors = null;
			}
			var keys:Array = BulkUtility.getAttributeNames(errors);
			for each (var key:String in keys) {
				var originalResource:Object = objectForKey(key, objects)
				if (originalResource)  // Create errors attribute on resource 
					originalResource.errors = errors[key].data; // type:'invalid' FIXME: check if other types?
			}
		}
		
		/**
		 * Find object in list based on id or uid.
		 */
		static protected function objectForKey(key:Object, objects:ArrayCollection):Object {
			for each (var object:ActiveResource in objects) {
				if (object.id == key || object.uid == key) return object;
			}
			return null;
		}
		
		//-----------------------------------------------------------
		// CLASS REGISTRY METHODS
		//-----------------------------------------------------------
		public function get resourceName():String {
			var className:String = flash.utils.getQualifiedClassName(this); // FIXME: we could cache the className/resourceName
			var clazz:Class = getDefinitionByName(className) as Class;
			return resourceForClass(clazz);
		}
		
		public static function classForResource(resourceName:String):Class {
			var clazz:Class = resourceMap[resourceName];
			return clazz ? clazz : Object;
		}
		
		public static function resourceForClass(clazz:Class):String {
			return reverseMap[clazz];
		}
		
		static protected var resourceMap:Object = {};
		static protected var reverseMap:Object = {};
		static protected function resource(resourceName:String, clazz:Class):void {
			resourceMap[resourceName] = clazz;
			reverseMap[clazz] = resourceName;
		}		
		
	}
}