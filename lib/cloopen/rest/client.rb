module Cloopen
  module REST
    class Client
      include Utils

      API_VERSION = '2013-12-26'

      HTTP_HEADERS = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json;charset=utf-8'
      }

      PRODUCTION_HOST = 'https://app.cloopen.com'
      LOCAL_HOST = 'http://localhost'
      SANDBOX_HOST = 'https://sandboxapp.cloopen.com'

      attr_reader :account_sid, :auth_token, :signature, :authorization, :config, :headers, :account, :app_id

      def initialize(account_sid, auth_token, app_id, options={})
        @account_sid, @auth_token, @app_id = account_sid.strip, auth_token.strip, app_id.strip
        @config = apply_defaults(options)
        generate_authorization_params
        set_up_subresources
      end

      def inspec
        "<Cloopen::REST::Client @account_sid=#{@account_sid}>"
      end

      [:get, :post].each do |method|
        define_method method do |resource, *args|
          uri = "#{@config[:host]}:#{@config[:port]}#{resource.uri}?sig=#{@signature}"
          response = case method
                     when :get
                       RestClient.get(uri, @headers)
                     when :post
                       RestClient.post(uri, args[0].to_json, @headers)
                     else
                     end
          JSON.parse response
        end
      end
      
      def sub_account(sub_account_sid, sub_account_password)
        timestamp = Time.now.strftime('%Y%m%d%H%M%S')
        @signature = Digest::MD5.hexdigest("#{sub_account_sid}#{sub_account_password}#{timestamp}").upcase
        authorization = Base64.strict_encode64("#{sub_account_sid}:#{timestamp}").strip
        @headers = HTTP_HEADERS.merge! 'Authorization' => authorization
        Cloopen::REST::SubAccount.new "/#{API_VERSION}/SubAccounts/#{sub_account_sid}/Calls", self
      end

      private
      def generate_authorization_params
        timestamp = Time.now.strftime('%Y%m%d%H%M%S')
        @signature = Digest::MD5.hexdigest("#{@account_sid}#{@auth_token}#{timestamp}").upcase
        authorization = Base64.strict_encode64("#{@account_sid}:#{timestamp}").strip
        @headers = HTTP_HEADERS.merge! 'Authorization' => authorization
      end

      def defaults
        {
          host: find_default_host,
          port: 8883
        }
      end

      def find_default_host
        case Cloopen.env.downcase
        when 'production'
          PRODUCTION_HOST
        when 'test'
          LOCAL_HOST
        else
          SANDBOX_HOST
        end
      end

      def apply_defaults(options)
        defaults.merge(options)
      end

      def set_up_subresources
        @account = Cloopen::REST::Account.new "/#{API_VERSION}/Accounts/#{@account_sid}", self
      end

    end
  end
end
