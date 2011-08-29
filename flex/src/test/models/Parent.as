package test.models
{
	import active_resource.ActiveResource;
	
	dynamic public class Parent extends ActiveResource
	{
		public function Parent(attributes:Object=null)
		{
			super(attributes);
		}
		
		/* static block */		
		resource("parents", Parent); 		
	}
}