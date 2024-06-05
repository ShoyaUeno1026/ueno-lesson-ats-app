module ApplicationHelper

  def render_svg(name, options = {})
    options[:title] ||= name.underscore.humanize
    options[:aria] = true
    options[:nocomment] = true
    options[:class] = options.fetch(:styles, "w-5 h-5 fill-current text-slate-400")

    filename = "#{name}.svg"
    inline_svg_tag(filename, options)
  end

  def badge(text, options = {})
    base = options.delete(:base) || "rounded-full py-0.5 px-2 text-xs inline-block font-semibold leading-normal mr-2"
    color = options.delete(:color) || "bg-slate-100 text-slate-500"
    options[:class] = Array.wrap(options[:class]) + [base, color]
    tag.div(text, **options)
  end
end