package test.models
{
	import active_resource.ActiveResource;
	
	import mx.collections.ArrayCollection;
	
	dynamic public class Department extends ActiveResource
	{
		public function Department(attributes:Object=null)
		{
			super(attributes);
		}
		
		public var id:*;
		public var name:String;
		public var city:String;
		public var state:String;
		public var created_at:Date;
		public var updated_at:Date;
		public var employees:ArrayCollection;
		
		/* static block */		
		resource("departments", Department); 		
	}
}