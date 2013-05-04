class ThreadSweeper < ActionController::Caching::Sweeper
  observe Discussion::ThreadRead

  def after_save(thread_read)
    expire_cache_for(thread_read) if thread_read.read_changed?
  end

  private
  def expire_cache_for(thread_read)
    Rails.cache.delete("total_unread_thread_by_#{thread_read.user_id}") if thread_read.id_changed? or thread_read.read_changed?
  end

end