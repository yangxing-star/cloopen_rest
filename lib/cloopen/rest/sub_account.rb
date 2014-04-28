module Cloopen
  module REST
    class SubAccount < InstanceResource
      def initialize(uri, cilent)
        super uri, cilent
        resource :callback
      end
    end
  end
end