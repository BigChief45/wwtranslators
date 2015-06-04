class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  
  load_and_authorize_resource param_method: :job_params

  def index
    #@jobs = Job.all.order("created_at DESC")
    
    #Ransack
    @q = Job.ransack(params[:q])
    @jobs = @q.result(distinct: true).order("created_at DESC")
    
    # Pagination
    @jobs = @jobs.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    
  end

  def new
    @job = current_user.posted_jobs.build
  end

  def edit
  end

  def create
    @job = current_user.posted_jobs.build(job_params)
    
    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, :flash => { :success => 'Job was successfully created.' } }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new, :flash => { :danger => 'There was an error trying to create the job.' } }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, :flash => { :success => 'Job was successfully updated.' } }
        format.json { render :show, status: :updated, location: @job }
      else
        format.html { render :edit, :flash => { :danger => 'There was an error trying to update the job.' } }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @job.destroy
        format.html { redirect_to root_path, :flash => { :success => 'Job was successfully removed.' } }
      else
        format.html { redirect_to @job, :flash => { :danger => 'There was an error trying to remove the job.' } }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def select_translator
    # Get the proposal
    @proposal = Proposal.find(params[:id])
    
    # Get the job
    @job = @proposal.job
    
    # Get the proposal poster
    @translator = @proposal.user
    
    # Set the proposals's user as the Job's translator and update
    respond_to do |format|
      if @job.update_attributes(:translator_id => @translator.id, :available => false)
        format.html { redirect_to @job, :flash => { :success => "User #{@translator.username} was selected for this job and has been notified." } }
        format.json { render :show, status: :updated, location: @job }
      else
        format.html { render :show, :flash => { :danger => 'There was an error trying to select this user as the translator for this job.' } }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def unselect_translator
    # Get the proposal
    @proposal = Proposal.find(params[:id])
    
    # Get the job
    @job = @proposal.job
    
    # Get the proposal poster
    @translator = @proposal.user
    
    # Set the proposals's user as the Job's translator and update
    respond_to do |format|
      if @job.update_attributes(:translator_id => nil, :available => true)
        format.html { redirect_to @job, :flash => { :success => "User #{@translator.username} has been unhired from this job and has been notified." } }
        format.json { render :show, status: :updated, location: @job }
      else
        format.html { render :show, :flash => { :danger => 'There was an error trying to unhire this user for this job.' } }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:title, :description, :source_language, :target_language, :deadline, 
        :user_id, :attachment, :available, :price, :translator_id)
    end
    
end
