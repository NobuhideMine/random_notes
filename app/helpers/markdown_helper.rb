# frozen_string_literal: true

# Your Ruby code goes here

require "redcarpet"
#require 'rouge'
require "rouge/plugins/redcarpet"

class CustomRenderHTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
end

module MarkdownHelper
    def markdown(text)
            options = {
            #no_styles:     true,
            with_toc_data: true,
            hard_wrap:     true
        }
        extensions = {
            no_intra_emphasis:   true,
            tables:              true,
            fenced_code_blocks:  true,
            autolink:            true,
            lax_spacing:         true,
            space_after_headers: true,
            highlight:           true,
            lax_html_blocks:     true,
            footnotes:           true,
            strikethrough:       true,
            underline:           true,
            quote:               true
        }

        renderer = CustomRenderHTML.new(options)
        markdown = Redcarpet::Markdown.new(renderer, extensions)
        markdown.render(text)
    end

    def toc(text)
        renderer = Redcarpet::Render::HTML_TOC.new(nesting_level: 6)
        markdown = Redcarpet::Markdown.new(renderer)
        markdown.render(text)
    end
    
end