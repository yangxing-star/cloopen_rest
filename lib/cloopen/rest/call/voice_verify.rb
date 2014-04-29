module Cloopen
  module REST

    class VoiceVerify < ListResource
      def initialize(uri, cilent)
        super uri, cilent
      end
    end

    class VoiceVerif < InstanceResource
    end

  end
end