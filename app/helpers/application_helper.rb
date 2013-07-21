module ApplicationHelper

  def title
    if @post
      @post.title
    elsif @page
      @page.title
    elsif @tag
      "Thoughts on #{@tag.capitalize}"
    elsif @months
      'The Archives'
    else
      'Coding Skyscrapers'
    end
  end

  def sub_title
    if @post
      "Published on the #{@post.published_at.day.ordinalize} day of #{@post.published_at.strftime('%B')}, #{@post.published_at.year}"
    elsif @page
      @page.sub_title
    elsif @tag
      pluralize(@posts.count, 'Article')
    elsif @months
      'Articles from times gone by'
    else
      'Thoughts on the business, technology and life by <a href="/pages/about" title="About Matt West">Matt West</a>'
    end
  end

  def author
    Struct.new(:name, :email).new(enki_config[:author][:name], enki_config[:author][:email])
  end

  def open_id_delegation_link_tags(server, delegate)
    raw links = <<-EOS
      <link rel="openid.server" href="#{server}">
      <link rel="openid.delegate" href="#{delegate}">
    EOS
  end

  def format_comment_error(error)
    {
      'body'   => 'Please comment',
      'author' => 'Please provide your name or OpenID identity URL',
      'base'   => error.last
    }[error.first.to_s]
  end
end
