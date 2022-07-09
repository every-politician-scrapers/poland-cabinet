#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class Roman < WikipediaDate
  REMAP = {
    'XII'  => 'Decemeber',
    'XI'   => 'November',
    'IX'   => 'September',
    'X'    => 'October',
    'VIII' => 'August',
    'VII'  => 'July',
    'VI'   => 'June',
    'IV'   => 'April',
    'V'    => 'May',
    'III'  => 'March',
    'II'   => 'February',
    'I'    => 'January',
  }.freeze

  def remap
    super.merge(REMAP)
  end
end

class OfficeholderList < OfficeholderListBase
  decorator RemoveReferences
  decorator UnspanAllTables
  decorator WikidataIdsDecorator::Links

  def header_column
    'Zdjęcie'
  end

  class Officeholder < OfficeholderBase
    def columns
      %w[no image name start end].freeze
    end

    def tds
      noko.css('td,th')
    end

    def date_class
      Roman
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url, klass: OfficeholderList).csv
