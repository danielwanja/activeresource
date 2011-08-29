package test.models
{
	import active_resource.ActiveResource;
	
	dynamic public class Child extends ActiveResource
	{
		public function Child(attributes:Object=null)
		{
			super(attributes);
		}
		
		/* static block */		
		resource("children", Child); 		
	}
}