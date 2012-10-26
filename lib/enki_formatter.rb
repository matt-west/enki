class EnkiFormatter
  class << self
    def format_as_xhtml(text)
    	markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
      Lesstile.format_as_xhtml(
        text,
        :text_formatter => lambda {|text| markdown.render(CGI::unescapeHTML(text))},
        :code_formatter => Lesstile::CodeRayFormatter
      )
    end
  end
end
