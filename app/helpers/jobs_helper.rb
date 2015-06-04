module JobsHelper
    
    
    # Determines if a proposal can be posted for this job
    def can_post_proposal?
        if ( (user_signed_in?) && (@job.available?) && (current_user != @job.poster) && !has_posted_proposal? )
            return true
        else
            return false
        end
    end
    
    # Determines if the current user has already posted a proposal for this job
    def has_posted_proposal?
        @job.proposals.exists?(user_id: current_user.id)
    end
    
    # Determines if current user is the poster of the current job shown
    def current_user_is_job_poster?
       @job.poster == current_user 
    end
    
    # Determines if current user is the poster of the current proposal in the loop
    def current_user_is_proposal_poster?(proposal)
       proposal.user == current_user 
    end
    
    # Determines if the job poster can select a proposal
    def can_select_proposal?
        current_user_is_job_poster? && @job.available? && @job.translator == nil
    end
    
    # Determines if proposal poster can edit the proposal
    def can_edit_proposal?(proposal)
       current_user_is_proposal_poster?(proposal) && @job.available 
    end
    
    # Determines if this proposal is the selected proposal
    def is_selected_proposal?(proposal)
       @job.translator == proposal.user 
    end
    
    # Determines if current user is this job's translator
    def current_user_is_job_translator?
       (current_user == @job.translator) && (user_signed_in?)
    end
    
end
