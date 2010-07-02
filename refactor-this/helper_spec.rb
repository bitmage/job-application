require 'action_controller'
require 'action_view'
require 'active_support'

require 'rubygems'
require 'factory_girl'
require 'factories'
require 'spec'
require 'spec/autorun'
require 'redgreen'
require 'user_profile'
require 'helper'
require 'user'
require 'photo'

describe "Helper" do
  before(:each) do
    @helper = Helper.new
  end
  describe "display_photo" do
    it "should return the wrench if there is no profile" do
      @helper.display_photo(nil, "100x100", {}, {}, true).should == "<img alt=\"Wrench\" src=\"/images/wrench.png\" />"
    end
    
    describe "With a profile, user and photo requesting a link" do
      before(:each) do
        @profile = UserProfile.new
        @profile.name = "Clayton"
        @user    = User.new
        @profile.user = @user
        @photo   = Photo.new
        @user.photo = @photo
        @profile.stub!(:has_valid_photo?).and_return(true)
      end
      it "should return a link" do
        @helper.display_photo(@profile, "100x100", {}, {}, true).should == "<a href=\"/profile/\"><img alt=\"100x100\" class=\"thumbnail\" height=\"100\" src=\"/images/user/Clayton/photo/100x100.jpg\" title=\"Link to Clayton\" width=\"100\" /></a>"
      end
    end
    
    describe "With a profile, user and photo not requesting a link" do
      before(:each) do
        @profile = UserProfile.new
        @profile.name = "Clayton"
        @user    = User.new
        @profile.user = @user
        @photo   = Photo.new
        @user.photo = @photo
        @profile.stub!(:has_valid_photo?).and_return(true)
      end
      it "should just return an image" do
        @helper.display_photo(@profile, "100x100", {}, {}, false).should == "<img alt=\"100x100\" class=\"thumbnail\" height=\"100\" src=\"/images/user/Clayton/photo/100x100.jpg\" title=\"Link to Clayton\" width=\"100\" />"
      end
    end
    
    describe "Without a user, but requesting a link" do
      before(:each) do
        @profile = UserProfile.new
        @profile.name = "Clayton"
      end
      it "return a default" do
        @helper.display_photo(@profile, "100x100", {}, {}, true).should == "<a href=\"/profile/\"><img alt=\"User100x100\" src=\"/images/user100x100.jpg\" /></a>"
      end
    end
    
    describe "When the user doesn't have a photo" do
      before(:each) do
        @profile = UserProfile.new
        @profile.name = "Clayton"
        @user    = User.new
        @profile.user = @user
        @profile.stub!(:has_valid_photo?).and_return(false)
      end
      describe "With a rep user" do
        before(:each) do
          @user.stub!(:rep?).and_return(true)
        end
        it "return a default link" do
          @helper.display_photo(@profile, "100x100", {}, {}, true).should == "<a href=\"/profile/\"><img alt=\"User190x119\" src=\"/images/user190x119.jpg\" /></a>"
        end
      end
      
      describe "With a regular user" do
        before(:each) do
          @user.stub!(:rep?).and_return(false)
        end
        it "return a default link" do
          @helper.display_photo(@profile, "100x100", {}, {}, true).should == "<a href=\"/profile/\"><img alt=\"User100x100\" src=\"/images/user100x100.jpg\" /></a>"
        end
      end

      describe "When we don't want to display the default" do
        before(:each) do
          @options = {:show_default => false}
        end

        describe "With a rep user" do
          before(:each) do
            @user.stub!(:rep?).and_return(true)
          end
          it "return 'NO DEFAULT'" do
            @helper.display_photo(@profile, "100x100", {}, @options, true).should == "NO DEFAULT"
          end
        end
        
        describe "With a regular user" do
          before(:each) do
            @user.stub!(:rep?).and_return(false)
          end
          it "return 'NO DEFAULT'" do
            @helper.display_photo(@profile, "100x100", {}, @options, true).should == "NO DEFAULT"
          end
        end
      end
    end
    
    
    
  end
end
