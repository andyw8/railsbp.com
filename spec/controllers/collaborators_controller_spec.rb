require 'spec_helper'

describe CollaboratorsController do
  before do
    skip_repository_callbacks
    @repository = create(:repository)

    user = create(:user)
    sign_in user
  end

  context "GET :index" do
    it "should list all collaborators" do
      collaborator1 = create(:user)
      collaborator2 = create(:user)
      @repository.users << collaborator1
      @repository.users << collaborator2

      get :index, repository_id: @repository.id
      response.should be_ok
      assigns(:collaborators).should == [collaborator1, collaborator2]
    end
  end
end
