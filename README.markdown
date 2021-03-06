# activeresource - An ActionScript Framework to integrate Flex with Ruby on Rails

A Flex/ActionScript Framework to integrate with Ruby on Rails. Provides Restful access to Rails including nested attributes.

## Flex App

Copy the flex/bin/activeresource.swc to the lib folder of your application.

## Declaring the Resources

First create a dynamic class that maps to a resource:

```javascript

    dynamic public class Parent extends ActiveResource
    {
    	public function Parent(attributes:Object=null)
    	{
    		super(attributes);
    	}
	
    	/* static block */		
    	resource("parents", Parent); 		
    }

	dynamic public class Child extends ActiveResource
	{
		public function Child(attributes:Object=null)
		{
			super(attributes);
		}
		
		/* static block */		
		resource("children", Child); 		
	}
	
```

Note the static _resource_ method is called when defining the class. This links the resource class to a the Rails resource name.
Also note that by default ActiveResource.baseUrl points to http://localhost:3000. This works fine during development but you need to either point the resources to your server or use a relative path when your Flex application is served from the public folder of your Rails application. I.e. ActiveResource.baseUrl = "/";

## Usage

### Flex

The Flex ActiveResource class allows to access a Rails resource and to perform a Index, Show, Create, Update and Delete. 

Find All:

```javascript
    var call:AsyncToken = ActiveResource.findAll(Parent)
	call.addResponder(new AsyncResponder(resultHandler, faultHandler));
```

Find one:

```javascript
    var call:AsyncToken = ActiveResource.find(Parent, 1)
	call.addResponder(new AsyncResponder(resultHandler, faultHandler));
```

Create:

```javascript
    var parent:Parent = new Parent();
    parent.name = "Daniel";
    parent.favorite_food = "Cheese";
    var call:AsyncToken = parent.save();
	call.addResponder(new AsyncResponder(resultHandler, faultHandler));
```

Update:

```javascript
    parent.favorite_food = "Chocolate";
    var call:AsyncToken = parent.save();
	call.addResponder(new AsyncResponder(resultHandler, faultHandler));
```
		
Note I will add a simplified syntax support for the create and update where you can just issue a _parent.save()_

Delete:

```javascript
    var call:AsyncToken = parent.destroy();
	call.addResponder(new AsyncResponder(resultHandler, faultHandler));
```

### Rails

These are the Rails routes involved:

```ruby
        parents GET    /parents(.:format)                      {:action=>"index", :controller=>"parents"}
                POST   /parents(.:format)                      {:action=>"create", :controller=>"parents"}
         parent GET    /parents/:id(.:format)                  {:action=>"show", :controller=>"parents"}
                PUT    /parents/:id(.:format)                  {:action=>"update", :controller=>"parents"}
                DELETE /parents/:id(.:format)                  {:action=>"destroy", :controller=>"parents"}
```

You can generate a default scaffolded controller for the _parent_ resource and use to Flex ActiveResource framework to consume that resource. The Flex ActiveResource class uses the JSON format. One ActiveResource provides access to the different Rails routes (urls) to perform create, update and deletes.

```
    rails generate scaffold parent name:string birthday:date single:boolean
```

The following is an extract of the ParentController and shows the default generated _index_ and _create_ methods.

```ruby
    # GET /parents.json
    def index
      @parents = Parent.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @parents }
      end
    end
    
    # POST /parents.json
    def create
      @parent = Parent.new(params[:parent])

      respond_to do |format|
        if @parent.save
          format.html { redirect_to @parent, notice: 'Parent was successfully created.' }
          format.json { render json: @parent, status: :created, location: @parent }
        else
          format.html { render action: "new" }
          format.json { render json: @parent.errors, status: :unprocessable_entity }
        end
      end
    end    
```		


### Nested Attributes:

Rails support nested attributes where complex data structures can be sent in one request to the server. For example in the following case a Parent model has many Children. By adding the _accepts_nested_attributes_for_ declaration to the parent active record you allow providing children attributes which can be used to create, update and delete children that are associated with the parent. 


```ruby
	class Parent < ActiveRecord::Base
	  has_many :children
      accepts_nested_attributes_for :children, :allow_destroy => true
	end
	
	class Child < ActiveRecord::Base
	  belongs_to :parent
	end
```

Then you can update the parent and the child records in one request:

```javascript
   parent.children.addItem(new Child({first_name:'Rockie'}));
   parent.childreen.getItemAt(5)._destroy = true;
   var call:AsyncToken = parent.save({nestedAttributes:['children']})
   call.addResponder(new AsyncResponder(resultHandler, faultHandler));
```

Note that the default generated Rails controller just returns an :ok after a successful update. If you wan't the update record and child records are returned you can modify the update method of the controller as follows:

```ruby
# PUT /parents/1.json
    def update
      @parent = Parent.find(params[:id])

      respond_to do |format|
        if @parent.update_attributes(params[:parent])
          format.html { redirect_to @parent, notice: 'Parent was successfully updated.' }
          format.json { render json: @parent, status: :ok } # was { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @parent.errors, status: :unprocessable_entity }
        end
      end
    end
```
Note that the statement _head :ok_ was replace by _render json: @parent_

and you can refine the JSON that is returned by the active record to always include the children of the parent:

```ruby
    class Parent < ActiveRecord::Base
      has_many    :children
      accepts_nested_attributes_for :children, :allow_destroy => true

      def as_json(options={})    
        super(:include => :children)
      end
    end
```  
  
FIXME: deleting children is a bad example/taste in this case. Maybe an Order and it's OrderItems, or a Department and it's Employees...

### RoadMap

1. extend test coverage 
2. unify base classes with bulk_api_flex?
3. improve server side validation support 

### Credits

Thanks to Pinnacol Assurance for providing some of the base code and concepts on which this project is built.


### Community

Want to help? Contact Daniel Wanja d@n-so.com

Enjoy!
Daniel Wanja

