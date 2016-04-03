### will show error `ActionController::UnknownFormat` when writing test with respond_to { |format| format.js }

need to add `format: :js` to the end of `get: prams` or `post: params` ... etc.


e.g.
```ruby
  def create
    respond_to do |format|
      format.js
    end
  end
```

```ruby
  describe 'xxx' do
    post :create, id: @agent.id, add_underwriter_id: underwriter.id #fail with error "ActionController::UnknownFormat"
    post :create, id: @agent.id, add_underwriter_id: underwriter.id, format: :js # OK
  end
```

r.f.
http://stackoverflow.com/questions/17984690/getting-an-actioncontrollerunknownformat-rspec-testing-when-creating-new-obje

TODO: TRACE CODE
http://api.rubyonrails.org/classes/ActionController/TestCase.html


### rspec change expector

https://www.relishapp.com/rspec/rspec-expectations/v/2-0/docs/matchers/expect-change

```ruby
expect{}.to change{}.by()
expect{}.to change{}.from().to()
```
