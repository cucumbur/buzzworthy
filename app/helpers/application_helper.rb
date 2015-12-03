module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Buzzworthy"
    if page_title.empty?
      base_title
    else
      page_title + " :: " + base_title
    end
  end
	
	# Translates text content into text content with replaced emoji tags. Included via the maker of the gemoji gem
	def emojify(content)
    (content).to_str.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        %(<img alt="#$1" src="#{image_path("emoji/#{emoji.image_filename}")}" style="vertical-align:middle" width="20" height="20" />)
      else
        match
      end
    end.html_safe if content.present?
	end

end
