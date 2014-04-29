# encoding: utf-8
require 'spec_helper'

describe 'CloopenRest' do
  
  before(:each) do 
    account_sid = 'ff8080813cf5547f013cf661de2d000d'
    auth_token = '23005456698b49e9bdd76fad2630c7b5'
    app_id = 'ff8080813cf5547f013cf66552a7000f'

    @client = Cloopen::REST::Client.new(account_sid, auth_token, app_id)
  end
  
  context 'accout api' do
    before(:each) do
      @account = @client.account
    end
    
    
    
    # it 'make a voicevofe' do
#       voice = @account.calls.voice_Vofe
#     end
    
    # it 'gets subaccounts' do
#       subaccounts = @account.get_sub_accounts.create 'startNo'=>'1', 'appId'=> @client.app_id, 'offset'=>'10'
#       subaccounts.response.status_code.should == '000000'
#       subaccounts.response.body.should have_key('totalCount')
#       subaccounts.response.body.should have_key('SubAccount')
#       subaccounts.response.body['SubAccount'].should be_an_instance_of(Array)
#     end
    
    
    
    # it 'makes landing call' do
#       landing_call = @account.calls.landing_calls.create(
#         'appId' => @client.app_id, 
#         'to' => '18516198660', 
#         'mediaTxt' => '你好'
#       )
#       landing_call.response.status_code.should == '000000'
#     end
    
    it 'make a voice verify' do
      voice = @account.calls.voice_verify.create(
        'appId' => @client.app_id, 
        'to' => '18516198660', 
        'verifyCode' => '911834',
        'playTimes' => 3,
        "displayNum" => "01052821234"
      )
      voice.response.status_code.should == '000000'
    end
  end
  
  # context 'sub account api' do
#     before(:each) do
#       sub_account_sid = 'aaf98fda4588112c01458c95877f03e2'
#       sub_account_password = 'f50ed09491fb412583ee636fc4d0ce09'
#       @sub_account = @client.sub_account sub_account_sid, sub_account_password
#     end
#     
#     it 'makes callback call' do
#       call = @sub_account.callback.create(from: '13691591115', to: '18516198660')
#     
#       call.response.status_code.should == '000000'
#     end
#   end
end