describe DesignsController do

  let(:project) { FactoryGirl.create(:trained_emulator_project) }
  let(:design) { project.design }

  before(:each) { sign_in project.user }

  describe "GET #index" do
    it "assigns the project to @project" do
      get :index, emulator_project_id: project
      assigns(:project).should == project
    end

    context "when design exists" do
      it "redirects to #show" do
        get :index, emulator_project_id: project
        response.should redirect_to emulator_project_design_path(project, design)
      end
    end

    context "when design hasn't been created" do
      before(:each) { project.design = nil }

      it "redirects to new design page" do
        get :index, emulator_project_id: project
        response.should redirect_to new_emulator_project_design_path(project) 
      end
    end
  end

end