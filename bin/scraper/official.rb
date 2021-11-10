#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      noko.css('.title').text.tidy
    end

    def position
      noko.css('.position').text.tidy
          .gsub(', minister', '|Minister')
          .gsub(', przewodniczący', '|Przewodniczący')
          .gsub(', Koordynator', '|Koordynator')
          .gsub(', Szef', '|Szef')
          .split('|')
    end
  end

  class Members
    def member_container
      noko.css('.bio-prev ul li')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
