class HrepliesController < ApplicationController
  before_action :find_hreply, only: [:destroy]
    def create
        @hreply = Hreply.new(hreply_params)
        if @hreply.save
            flash['success'] = '댓글이 작성되었습니다.'
            redirect_to handout_path(params[:handout_id])
        else
            flash['danger'] = '댓글을 작성하세요'
            redirect_to :back
        end
    end
    def destroy
        if @hreply.destroy
            flash['alert'] = '댓글이 삭제되었습니다.'
            redirect_to :back
        else
            flash['danger'] = '다시 시도하세요'
            redirect_to :back
        end
    end
    private
    def hreply_params
        params.require(:hreply).permit(:content,:user_id,:handout_id)
    end
    def find_hreply
        @hreply = Hreply.find(params[:id])
    end
end
