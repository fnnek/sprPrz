class CustomDomainConstraint
  def self.matches? request
    request.subdomain.present? && matching_blog?(request)
  end

  def self.matching_blog? request
    Rails.where(:custom_domain => request.host).any?
  end
end