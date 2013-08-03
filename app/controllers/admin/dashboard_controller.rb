class Admin::DashboardController < Admin::BaseController
  def show
    @posts            = Post.find_recent(:limit => 10)
    @comment_activity = CommentActivity.find_recent
    @stats            = Stats.new
  end
end
