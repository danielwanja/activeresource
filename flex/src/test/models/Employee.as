package test.models
{
	import active_resource.ActiveResource;
	
	dynamic public class Employee extends ActiveResource
	{
		
		public function Employee(attributes:Object=null)
		{
			super(attributes);
		}
		
		/* static block */
		resource("employees", Employee); 		
	}
}