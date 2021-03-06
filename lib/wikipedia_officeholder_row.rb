# frozen_string_literal: true

require_relative './wikipedia_table_row'

# A Row in a Wikipedia Table of Officeholders
class WikipediaOfficeholderRow < WikipediaTableRow
  field :id do
    wikidata_ids_in(name_cell).first
  end

  field :name do
    link_titles_in(name_cell).first
  end

  field :start_date do
    return unless start_date_str

    dateclass.new(start_date_str).to_ymd
  end

  field :end_date do
    return unless end_date_str

    dateclass.new(end_date_str).to_ymd
  end

  field :replaces do
  end

  field :replaced_by do
  end

  field :cabinet do
    wikidata_ids_in(cabinet_cell).first if cabinet_cell
  end

  field :cabinetLabel do
    link_titles_in(cabinet_cell).first if cabinet_cell
  end

  def empty?
    name.to_s.empty? || start_date.to_s.empty?
  end

  private

  def name_cell
    cell_for('name')
  end

  def cabinet_cell
    cell_for('cabinet')
  end

  def start_date_cell
    cell_for('start_date')
  end

  def end_date_cell
    cell_for('end_date')
  end

  def cell_for(str)
    ifx = columns.index(str) or return
    tds[ifx]
  end
end
