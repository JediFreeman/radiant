require 'spec_helper'

# http://blog.davidchelimsky.net/articles/2007/06/03/oxymoron-testing-behaviour-of-abstractions
describe Radiant::ApplicationController do

  it 'should include LoginSystem' do
    Radiant::ApplicationController.included_modules.should include(LoginSystem)
  end

  it 'should initialize detail' do
    controller.detail.should == Radiant::Config
  end

  it 'should initialize the javascript and stylesheets arrays' do
      Radiant::ApplicationController._process_action_callbacks.find(:set_javascripts_and_stylesheets).should_not be_nil
    controller.send :set_javascripts_and_stylesheets
    controller.send(:instance_variable_get, :@javascripts).should_not be_nil
    controller.send(:instance_variable_get, :@javascripts).should be_instance_of(Array)
    controller.send(:instance_variable_get, :@stylesheets).should_not be_nil
    controller.send(:instance_variable_get, :@stylesheets).should be_instance_of(Array)
  end

  it "should include stylesheets" do
    controller.send :set_javascripts_and_stylesheets
    controller.include_stylesheet('test').should include('test')
  end

  it "should include javascripts" do
    controller.send :set_javascripts_and_stylesheets
    controller.include_javascript('test').should include('test')
  end

  describe 'self.template_name' do
    it "should return 'index' when the controller action_name is 'index'" do
      controller.stub!(:action_name).and_return('index')
      controller.template_name.should == 'index'
    end
    ['new', 'create'].each do |action|
      it "should return 'new' when the action_name is #{action}" do
      controller.stub!(:action_name).and_return(action)
      controller.template_name.should == 'new'
      end
    end
    ['edit', 'update'].each do |action|
      it "should return 'edit' when the action_name is #{action}" do
      controller.stub!(:action_name).and_return(action)
      controller.template_name.should == 'edit'
      end
    end
    ['remove', 'destroy'].each do |action|
      it "should return 'remove' when the action_name is #{action}" do
      controller.stub!(:action_name).and_return(action)
      controller.template_name.should == 'remove'
      end
    end
    it "should return 'show' when the action_name is show" do
      controller.stub!(:action_name).and_return('show')
      controller.template_name.should == 'show'
    end
    it "should return the action_name when the action_name is a non-standard name" do
      controller.stub!(:action_name).and_return('other')
      controller.template_name.should == 'other'
    end
  end

  describe "set_timezone" do
    it "should use Radiant::Config['local.timezone']" do
      Radiant::Config['local.timezone'] = 'Kuala Lumpur'
      controller.send(:set_timezone)
      Time.zone.name.should == 'Kuala Lumpur'
    end

    it "should default to config.time_zone" do
      Radiant::Config.initialize_cache # to clear out setting from previous tests
      controller.send(:set_timezone)
      Time.zone.name.should == 'UTC'
    end
  end
end
