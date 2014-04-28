module Cloopen
  module REST

    class Callback < ListResource
      def initialize(uri, cilent)
        super uri, cilent
      end
    end

    class Callbac < InstanceResource
    end

  end
end
