require 'appengine-api-1.0-sdk-1.5.1.jar'
require 'date'

class Numeric
  def unpack
    self
  end
end

class String
  alias_method :base_unpack, :unpack

  def unpack(*args)
    if args.size == 0
      self
    else
      base_unpack(*args)
    end
  end
end

class NilClass
  def unpack
    nil
  end
end

class TrueClass
  def unpack
    true
  end
end

class FalseClass
  def unpack
    false
  end
end

Key = Java::com.google.appengine.api.datastore.Key
class Key
  def unpack
    Java::com.google.appengine.api.datastore.KeyFactory.keyToString(self)
  end
end

JDate = Java::java.util.Date
class JDate
  def unpack
    cal = Java::java.util.GregorianCalendar.new
    cal.setTime(self)
    y = cal.get(Java::java.util.Calendar::YEAR)
    m = cal.get(Java::java.util.Calendar::MONTH) + 1
    d = cal.get(Java::java.util.Calendar::DAY_OF_MONTH)
    h = cal.get(Java::java.util.Calendar::HOUR)
    min = cal.get(Java::java.util.Calendar::MINUTE)
    s = cal.get(Java::java.util.Calendar::SECOND)
    DateTime.new(y, m, d, h, min, s)
  end
end

Text = Java::com.google.appengine.api.datastore.Text
class Text
  def unpack
    self.getValue
  end
end

Email = Java::com.google.appengine.api.datastore.Email
class Email
  def unpack
    self.getEmail
  end
end

class Object
  def unpack
    puts "!!! Unpacking Object: #{self}"
    self
  end
end