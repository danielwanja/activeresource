package test.models
{
	import active_resource.ActiveResource;
	
	dynamic public class Department extends ActiveResource
	{
		public function Department(attributes:Object=null)
		{
			super(attributes);
		}
		
		/* static block */		
		resource("departments", Department); 		
	}
}