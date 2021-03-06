class SystemSettings < ActiveRecord::Base
  self.table_name = 'system_settings'

  attr_accessor :public_role, :default_markup_style
  attr_accessor :site_default_page, :not_found_page, :permission_denied_page,
                :session_expired_page
  attr_accessible :site_subtitle, :footer_message, :public_role_id, :session_timeout, :default_markup_style_id, :site_default_page_id, :not_found_page_id, :permission_denied_page_id, :session_expired_page_id, :menu_depth

  def public_role
    @public_role ||= Role.find(self.public_role_id)
  end

  def default_markup_style
    @default_markup_style ||= if self.default_markup_style_id
                                MarkupStyle.find(self.default_markup_style_id)
                              else
                                MarkupStyle.new(id: nil,
                                                name: '(None)')
                              end
    @default_markup_style
  end

  def site_default_page
    @site_default_page ||= ContentPage.find(self.site_default_page_id)
  end

  def not_found_page
    @not_found_page ||= ContentPage.find(self.not_found_page_id)
  end

  def permission_denied_page
    @permission_denied_page ||= ContentPage.find(self.permission_denied_page_id)
  end

  def session_expired_page
    @session_expired_page ||= ContentPage.find(self.session_expired_page_id)
  end

  # Returns an array of system page settings for a given page,
  # or nil if the page is not a system page.
  def system_pages(pageid)
    pages = []

    pages << "Site default page" if self.site_default_page_id == pageid
    pages << "Not found page" if self.not_found_page_id == pageid
    pages << "Permission denied page" if self.permission_denied_page_id == pageid
    pages << "Session expired page" if self.session_expired_page_id == pageid

    if !pages.empty?
      return pages
    else
      return nil
    end
  end
end
