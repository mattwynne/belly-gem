require 'spec_helper'
require 'belly/project_initializer'

module Belly
  describe ProjectInitializer do
    subject { ProjectInitializer.new(:name => 'foo') }
    let(:ui) { double(:die => nil) }

    context "when user credentials exist" do
      let(:credentials) do
        double(UserCredentials, 
          :username => "matt", 
          :password => "foo")
      end
      
      class Thing
        attr_reader :string
        def get(string)
          @string = string
        end
      end
      
      let(:client) { double.as_null_object }
      
      before(:each) do
        Belly.stub(:user_credentials).and_return(credentials)
        Belly::Client.stub(:new => client)
      end

      it "creates the client with the right credentials" do
        Belly::Client.should_receive(:new).with(Belly.user_credentials).and_return(client)
        subject.run(ui)
      end

      it "calls the projects web service" do
        client.should_receive(:get).with("/projects/foo")
        subject.run(ui)
      end
      
      context "if the web service gives an access denied error" do
        it "tells the UI that the user doesn't have access to the project" do
          
        end
      end
    end
  end
end