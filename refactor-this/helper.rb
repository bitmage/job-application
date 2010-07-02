class Helper < ActionView::Base
  def image_size(profile, non_rep_size)
    if profile.user.rep?
      '190x114'
    else
      non_rep_size
    end
  end

  def display_small_photo(profile, html = {}, options = {})
    display_photo(profile, image_size(profile, "32x32"), html, options)
  end

  def display_medium_photo(profile, html = {}, options = {})
    display_photo(profile, image_size(profile, "48x48"), html, options)
  end

  def display_large_photo(profile, html = {}, options = {}, link = true)
    display_photo(profile, image_size(profile, "64x64"), html, options, link)
  end

  def display_huge_photo(profile, html = {}, options = {}, link = true)
    display_photo(profile, image_size(profile, "200x200"), html, options, link)
  end

  def display_photo(profile, size, html = {}, options = {}, link = true)
    return image_tag("wrench.png") unless profile  # this should not happen

    show_default_image = !(options[:show_default] == false)
    html.reverse_merge!(:class => 'thumbnail', :size => size, :title => "Link to #{profile.name}")

    if profile && profile.user
      if profile.user.photo && File.exists?(profile.user.photo)
        tag = image_tag(url_for_file_column("user", profile.name, "photo", size), html)
        return create_photo_html(tag, profile, link)
      end
    end
    return show_default_image ? default_photo(profile, size, {}, link) : 'NO DEFAULT'
  end

  def default_photo(profile, size, html={}, link = true)
    if profile.user && profile.user.rep?
      tag = image_tag("user190x119.jpg", html)
    else
      tag = image_tag("user#{size}.jpg", html)
    end
    create_photo_html(tag, profile, link)
  end

  def create_photo_html(tag, profile, link = true)
    if link
      link_to(tag, profile_path(profile))
    else
      tag
    end
  end

  #I'm guessing at the file path structure, as the sample code does not include this.
  def url_for_file_column(*args)
    return args.join("/") << ".jpg"
  end

  def profile_path(profile)
    return "/profile/"
  end
end
