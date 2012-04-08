# from: "Testing private methods in RSpec"
# kailuowang.blogspot.com/2010/08/testing-private-methods-in-rspec.html

def describe_internally *args, &block

  example = describe *args, &block
  qlass = args[0]

  if qlass.is_a? Module
    saved_private_instance_methods = qlass.private_instance_methods
    example.before do
      qlass.module_eval { public *saved_private_instance_methods }
    end
    example.after do
      qlass.module_eval { private *saved_private_instance_methods }
    end
  end

  if qlass.is_a? Class
    saved_private_instance_methods = qlass.private_instance_methods
    example.before do
      qlass.class_eval { public *saved_private_instance_methods }
    end
    example.after do
      qlass.class_eval { private *saved_private_instance_methods }
    end
  end

end
