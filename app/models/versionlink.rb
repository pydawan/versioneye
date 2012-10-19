class Versionlink

  include Mongoid::Document
  include Mongoid::Timestamps

  field :prod_key, type: String
  field :version_id, type: String  
  field :link, type: String
  field :name, type: String
  field :manual, type: Boolean, :default => false
  
  def as_json parameter
    {
      :name => self.name,
      :link => self.link,
      :created_at => self.created_at.strftime("%Y.%m.%d %I:%M %p"),
      :updated_at => self.updated_at.strftime("%Y.%m.%d %I:%M %p")
    }
  end

  def self.find_by(prod_key, link)
    Versionlink.where( prod_key: prod_key, link: link )[0]
  end

  def self.find_version_link(prod_key, version_id, link)
    Versionlink.where( prod_key: prod_key, version_id: version_id, link: link )
  end

  def self.create_versionlink prod_key, version_number, link, name
    return nil if link.nil? || link.empty? 
    versionlink = Versionlink.find_version_link(prod_key, version_number, link)
    return nil if versionlink
      
    versionlink = Versionlink.new
    versionlink.name = name
    versionlink.link = link
    if versionlink.link.match(/^http.*/).nil? && versionlink.link.match(/^git.*/).nil?
      versionlink.link = "http://#{versionlink.link}"
    end
    versionlink.prod_key = prod_key
    versionlink.version_id = version_number
    versionlink.save
  end

  def self.delete_wrong_ones()
    packagist_links = Versionlink.where( name: "Packagist Page")
    packagist_links.each do |link| 
      if !link.link.match(/^http.*/)
        p "delete #{link.link}"
        link.remove
      end
    end
  end

  def get_link
    if self.link.match(/^www.*/) != nil 
      return "http://#{self.link}"
    else 
      return self.link
    end
  end
  
end