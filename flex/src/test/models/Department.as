package test.models
{
	import active_resource.ActiveResource;
	
	public class Department extends ActiveResource
	{
		public function Department(attributes:Object=null)
		{
			super(attributes);
		}
		
		resource("departments", Department); 		
	}
}