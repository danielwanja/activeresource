package test.models
{
	import active_resource.ActiveResource;
	
	dynamic public class Job extends ActiveResource
	{
		
		public function Job(attributes:Object=null)
		{
			super(attributes);
		}
		
		public var id:*;
		public var name:String;
		public var created_at:Date;		
		public var updated_at:Date;
		
		/* static block */
		resource("jobs", Job); 		
	}
}