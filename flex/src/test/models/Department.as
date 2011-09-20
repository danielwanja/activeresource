package test.models
{
	import active_resource.ActiveResource;
	
	dynamic public class Department extends ActiveResource
	{
		public function Department(attributes:Object=null)
		{
			super(attributes);
		}
		
		public var id:Number;
		public var name:String;
		public var city:String;
		public var state:String;
		public var created_at:Date;
		public var updated_at:Date;
		
		[Transient] public var a_boolean:Boolean;
		[Transient] public var an_array:Array;
		
		/* static block */		
		resource("departments", Department); 		
	}
}