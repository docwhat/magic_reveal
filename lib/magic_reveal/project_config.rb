require 'pathname'
require 'json'

module MagicReveal
  class ProjectConfig
    DEFAULT_TEMPLATE = File.expand_path('../template-config.json', __FILE__)
    attr_reader :json

    def initialize io_or_path
      io = io_or_path.respond_to?(:read) ? io_or_path : Pathname.new(io_or_path)
      @json = JSON::load(io.read)
    end

    def dependencies
      out = []
      # you always want this
      out << '{ src: "lib/js/classList.js", condition: function() { return !document.body.classList; } }'

      if json['plugins'].include? 'highlight'
        out << '{ src: "plugin/highlight/highlight.js", async: true, callback: function() { hljs.initHighlightingOnLoad(); } }'
      end
      if json['plugins'].include? 'zoom'
        out << '{ src: "plugin/zoom-js/zoom.js", async: true, condition: function() { return !!document.body.classList; } }'
      end
      if json['plugins'].include? 'notes'
        out << '{ src: "plugin/notes/notes.js", async: true, condition: function() { return !!document.body.classList; } }'
      end

      "\"dependencies\": [\n#{out.join(",\n")}\n]"
    end

    def to_js
      var = []
      keys = json.keys.reject { |k| ['dependencies', 'github'].include?(k) }
      keys.each do |key|
        value = json[key]
        var << "  #{key}: #{value.to_json}"
      end

      out = []
      out << "/* Generated at #{Time.now} */"
      out << "var config = {"
      out << "#{var.join(",\n")},\n#{dependencies}"
      out << "\n};"
      out << "Reveal.initialize(config);"
      out.join("\n")
    end
  end
end
