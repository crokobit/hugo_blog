class: center, middle

# Practical Object-Oriented Design in Ruby CH3


---

# Dependency
- Modify code outside self class cause requirement to chage self code
- If the object know another object to much, that will cause dependency.

  

---

# Example

```ruby
  class Gear
    attr_reader :chainring, :cog, :rim, :tire
    def initialize(chainring, cog, rim, tire)
      @chainring = chainring
      @cog       = cog
      @rim       = rim
      @tire      = tire
    end

    def gear_inches
      ratio * Wheel.new(rim, tire).diameter
    end
  end
```

- It knows information about another class

  - class name
  - parameter order
  - which parameter need to pass
  - message name

---

# Introduce methods to decouple those dependency!!

---

# class name
- class do not need to know what specific class we will use, just need to know that class respond to certain message.
- From specific to abstract, this decrease dependency

```ruby
  class Gear
    attr_reader :chainring, :cog, :wheel
    def initialize(chainring, cog, wheel)
      @chainring = chainring
      @cog       = cog
      @wheel     = wheel
    end

    def gear_inches
      ratio * wheel.diameter
    end
  # ...
  end

  # Gear expects a 'Duck' that knows 'diameter'
  Gear.new(52, 11, Wheel.new(26, 1.5)).gear_inches
```

---

# class name
- If we can not isolate dependency outside self class, it should isolated it inside self class.
- Isolated it if we need to know class name and parameter order.
- Expose the dependency. Make modify easy in the future.

```ruby
  class Gear
    attr_reader :rim, :tire, :wheel
    def initialize(chainring, cog, rim, tire)
      @wheel     = Wheel.new(rim, tire)
    end
    # or
    def wheel
      @wheel ||= Wheel.new(rim, tire)
    end
  end

  def gear_inches
    ratio * wheel.diameter
  end

  Gear.new(52, 11, 26, 1.5).gear_inches
```

---

# Parameter order
- knowing order of another class cause dependency

```ruby
  class Wheel
    attr_accessor :rim, :tire
    def initialize(rim, tire)
      @rim = rim
      @tire = tire
    end
  end
```

```ruby
  Wheel.new(rim, tire)
```

- need to know rim, tire order here

---

# Parameter order
- decrease dependency of parameter order by hash parameter

```ruby
  class Wheel
    attr_accessor :rim, :tire
    def initialize(args)
      @rim = args[:rim]
      @tire = args[:tire]
    end
  end
```

```ruby
  Wheel.new(rim: rim, tire: tire)
```

---

# Parameter order
- set default value by ||= 

```ruby
  class Wheel
    attr_accessor :rim, :tire
    def initialize(args)
      @rim = args[:rim] ||= 0
      @tire = args[:tire] ||= 0
    end
  end
```

- When element may be boolean value, we can not use `||=`
- Use `fetch` instead

```ruby
  @rim = args.fetch(:rim, 10)
```

---

# Parameter order
- set default value by hash

```ruby
  class Wheel
    attr_accessor :rim, :tire
    def initialize(args)
      args = defaults.merge(args)
      @rim = args[:rim]
      @tire = args[:tire]
    end

    private
    def defaults
      { rim: 0, tire: 0 }
    end
  end
```

---

# Parameter order
- We may depend on external class which we can not change, and the parameter order of that interface is fixed
- Use `Wrapper` to avoid order dependency

```ruby
  module SomeFramework
    class Gear
      attr_reader :chainring, :cog, :wheel
      def initialize(chainring, cog, wheel)
        #...
      end
    end
  end

  module GearWrapper
    def self.gear(args)
      SomeFramework::Gear.new(args[:chainring], args[:cog], args[:wheel])
    end
  end

  GearWrapper.gear(chainring: 52, cog: 11, wheel: Wheel.new(26, 1.5))
```
---
## use module have below benefit:
- let us know that GearWrapper not returing a GearWrapper object

```ruby
  module GearWrapper
    def self.gear(args)
      SomeFramework::Gear.new(args[:chainring], args[:cog], args[:wheel])
    end
  end

  GearWrapper.gear(chainring: 52, cog: 11, wheel: Wheel.new(26, 1.5))
```
---

# Message name
- message name will send to self, or another object
- sending meaage to another object cause dependency
- If need to send message to another object, isolated it!

```ruby
  def gear_inches
    ratio * wheel.diameter
  end
```
```ruby
  def gear_inches
    ratio * diameter
  end

  private
  def diameter
    wheel.diameter
  end
```
---
# Dependency direction

```ruby
  class Calculator
    def multiply(x, y)
      x * y
    end

    def secret_sauce(compatibility)
      #if Compatibility changes, this method may break
      multiply(compatibility.person_x_score, compatibility.person_y_score)
    end
  end

  class Compatibility
    attr_accessor :person_x_score, :person_y_score
    ...
  end
```
---
# Dependency direction

```ruby
  class Calculator
    def multiply(x, y)
      x * y
    end
  end

  class Compatibility
    attr_accessor :person_x_score, :person_y_score

    def secret_sauce
      # if Calculator changes, this method may break, but is unlikely Calculator will change
      Calculator.new.multiply(person_x_score, person_y_score)
    end
  end
```
---
# Dependency direction
- always have objects depend on objects that are less likely to change
- [Ref] https://codequizzes.wordpress.com/2013/10/06/reversing-dependency-direction/
---
# Summary
Dependency
- class name
  - extract to abstract class
  - isolated dependency code
- parameter order
  - hash parameter
    - ||= , fetch
    - defaults hash
- which parameter need to pass
- message name
  - isolated dependency code

Dependency direction
- always have objects depend on objects that are less likely to change
---
#Thanks!
