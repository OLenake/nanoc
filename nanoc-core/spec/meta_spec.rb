# frozen_string_literal: true

describe 'meta', chdir: false do
  it 'is covered by specs' do
    regular_files = Dir['lib/nanoc/core/**/*.rb']
    regular_file_base_names = regular_files.map { |fn| fn.gsub(/^lib\/nanoc\/core\/|\.rb$/, '') }

    spec_files = Dir['spec/nanoc/core/**/*_spec.rb']
    spec_file_base_names = spec_files.map { |fn| fn.gsub(/^spec\/nanoc\/core\/|_spec\.rb$/, '') }

    # TODO: don’t ignore anything
    ignored_regular_file_base_names = %w[
      action_provider
      assertions
      basic_item_view
      checksum_collection
      compilation_context
      contracts_support
      dependency
      document_view_mixin
      error
      errors
      identifiable_collection_view
      item_collection
      item_rep_repo
      layout_collection
      mutable_document_view_mixin
      mutable_identifiable_collection_view
      outdatedness_reasons
      outdatedness_rule
      outdatedness_rules/attributes_modified
      outdatedness_rules/code_snippets_modified
      outdatedness_rules/content_modified
      outdatedness_rules/item_collection_extended
      outdatedness_rules/layout_collection_extended
      outdatedness_rules/not_written
      outdatedness_rules/rules_modified
      outdatedness_rules/uses_always_outdated_filter
      post_compile_item_collection_view
      processing_actions
      snapshot_def
      version
      view
      view_context_for_compilation
      view_context_for_pre_compilation
      view_context_for_shell
    ]

    ignored_spec_file_base_names = %w[
      outdatedness_rules
    ]

    effective_regular_file_base_names =
      regular_file_base_names - ignored_regular_file_base_names

    effective_spec_file_base_names =
      spec_file_base_names - ignored_spec_file_base_names

    expect(effective_regular_file_base_names)
      .to match_array(effective_spec_file_base_names)
  end

  it 'doesn’t log anything' do
    # TODO: don’t have any exceptions
    regular_files = Dir['lib/nanoc/core/**/*.rb'] - ['lib/nanoc/core/data_source.rb']

    expect(regular_files).to all(satisfy do |fn|
      content = File.read(fn)
      !content.match?(/\b(puts|warn)\b/) && !content.match?(/\$std(err|out)/)
    end)
  end
end
