module Remote
  class RemotableController < ApplicationController
    before_filter :find_project, :is_authorized, :is_allowed

    # this needs code to handle has_many relationships too for emulator?

    def new
      set_instance_object(@project.send("build_#{instance_singular}"))
      instance = get_instance_object
      if instance.respond_to? :calculate_defaults
        instance.calculate_defaults
      end
    end

    def edit
      instance = instance_constantized.find(params[:id])
      set_instance_object(instance)
    end

    def create
      # workaround for mongoid bug
      @project.send(instance_singular).destroy unless @project.send(instance_singular).nil?

      instance = @project.send("build_#{instance_singular}", params[instance_singular.to_sym])
      set_instance_object(instance)

      if instance.save
        # start off task
        Delayed::Job.enqueue RemoteJob.new(instance)

        redirect_to send("#{project_singular}_#{instance_plural}_path", @project)
      else
        render "new"
      end
    end

    def update
      instance = instance_constantized.find(params[:id])
      set_instance_object(instance)

      instance.update_attributes(params[instance_singular.to_sym])

      if instance.save
        # start off task
        Delayed::Job.enqueue RemoteJob.new(instance)

        redirect_to send("#{project_singular}_#{instance_plural}_path", @project, nil)
      else
        render "edit"
      end
    end

    def index
      instance = @project.send(instance_singular)
      set_instance_object(instance)

      # redirect to new if no object has been created
      if instance.nil?
        redirect_to send("new_#{project_singular}_#{instance_singular}_path", @project)
      else
        # otherwise go to object
        redirect_to send("#{project_singular}_#{instance_singular}_path", @project, instance)
      end
    end

    def show
      @object = instance_constantized.find(params[:id])
      set_instance_object(@object)

      respond_to do |format|
        show_respond_to(format) if self.class.method_defined?(:show_respond_to)
        format.json {
          render json: @object.to_hash
        }
        format.matlab {
          render text: @object.to_matlab
        }
        format.r {
          render text: @object.to_r
        }
        format.html { render :formats => [:html] }
        format.js { render :formats => [:js] }
      end
    end

    protected

    def find_project
      # project could also be sensitivity, validation
      if params[:emulator_project_id] != nil
        @project = EmulatorProject.find(params[:emulator_project_id])
        @emulator_project = @project
      elsif params[:sensitivity_project_id] != nil
        @project = SensitivityProject.find(params[:sensitivity_project_id])
      else
        @project = ValidationProject.find(params[:validation_project_id])
      end
    end

    def is_authorized
      authorize! :manage, @project
    end

    def is_allowed
      if !@project.send("allow_#{instance_singular}?")
        needs = @project.send("needs_for_#{instance_singular}")
        flash[:error] = "You must complete the #{needs.to_sentence.gsub(/_/, ' ')} #{"stage".pluralize(needs.size)} first."
        redirect_to @project
      end
    end

    private

    def set_instance_object(object)
      instance_variable_set("@#{instance_singular}", object)
    end

    def get_instance_object
      instance_variable_get("@#{instance_singular}")
    end

    def instance_singular
      controller_name.classify.underscore.singularize
    end

    def instance_plural
      controller_name.classify.underscore.pluralize
    end

    def instance_constantized
      controller_name.classify.constantize
    end

    def project_singular
      @project.class.to_s.underscore.singularize
    end
  end
end