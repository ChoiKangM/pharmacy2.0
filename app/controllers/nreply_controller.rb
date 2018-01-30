class NrepliesController < ApplicationController
    before_action :find_nreply, only: [:destroy]
    def create
        @nreply = Nreply.new(nreply_params)
        if @nreply.save
            flash['success'] = '댓글이 작성되었습니다.'
            redirect_to notice_path(params[:notice_id])
        else
            flash['danger'] = '댓글을 작성하세요'
            redirect_to :back
        end
    end
    def destroy
        if @nreply.destroy
            flash['alert'] = '댓글이 삭제되었습니다.'
            redirect_to :back
        else
            flash['danger'] = '다시 시도하세요'
            redirect_to :back
        end
    end
    private
    def nreply_params
        params.require(:nreply).permit(:content,:user_id,:notice_id)
    end
    def find_nreply
        @nreply = Nreply.find(params[:id])
    end
end
