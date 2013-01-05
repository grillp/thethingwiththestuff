Dir['src/**/*.rb'].each{|f| p f;require_relative "../#{f}" }
