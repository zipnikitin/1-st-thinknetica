class Admin::Vagon
end

class Admin::Train
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      self.class.each { |class| puts class }
    end
  end

  module InstanceMethods
    def register_instance
      self.class.count { |class| }
    end
  end
 end