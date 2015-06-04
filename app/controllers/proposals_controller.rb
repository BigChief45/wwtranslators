class ProposalsController < ApplicationController
    before_action :authenticate_user!, except: [:show]
    before_action :find_job
    
    def create
        @proposal = @job.proposals.create(proposal_params)
        @proposal.user_id = current_user.id
        
        respond_to do |format|
            if @proposal.save
                format.html { redirect_to @job, :flash => { :success => 'Your proposal was added successfully. The job poster will be notified.' } }
                format.json { render :show, status: :created, location: @job }
            end
        end
    end
    
    private
    
        def find_job
           @job = Job.find(params[:job_id]) 
        end
        
        def proposal_params
            params.require(:proposal).permit(:content)
        end
        
end
