class ResetAllPostCommentsCacheCounters < ActiveRecord::Migration[6.1]
  def up
    Post.find_each { |post| Post.reset_counters(post.id, :comments_count) }
  end

  def down
  end
end
