package test.models
{
	import active_resource.ActiveResource;

	/**
	 * This class is temporarly used to test resource with strongly typed attributes.
	 * In the future all resources will require strongly typed attributes.
	 */
	dynamic public class TypedDepartment extends ActiveResource
	{
		public function TypedDepartment(attributes:Object=null)
		{
			super(attributes);
		}
		
		public var id:*;
		[Bindable] public var name:String;
		[Bindable] public var city:String;
		public var state:String;
		public var created_at:Date;
		public var updated_at:Date;
		
		[Transient] public var a_boolean:Boolean;
		[Transient] public var an_array:Array;

		/* static block */		
		resource("typed_departments", TypedDepartment); 		
	}
}