module ImageHelper
  def image_path(object, options ={})
  size = options[:size] || 180
  default_image =options[:default] ||"mp"
  base_url = "https://secure.gravatar.com/avatar"
  base_url_params = "?s=#{size}&d=#{default_image}"

    if object.respond_to?(:image) && object.image.attached? && object.image.variable?
      object.image.variant(resize_to_fill: [size, size])
    elsif object.respond_to?(:email) && object.email
      image_id = Digest::MD5.hexdigest(object.email.downcase)
      "#{base_url}/#{image_id}#{base_url_params}"
    else
      "#{base_url}/00000000000000000000000000000000#{base_url_params}"
    end
  end
end